function data = KineticAnalysis
% All data should be in folders by trial date. Be sure a footfall.csv file
% is available in the root folder.

%% set some basic parameters
% Home
% addpath('F:\Research\Active Folders\Tail Regeneration\ProcessedRaw');
addpath(genpath('../GitHub/ComparativeBiomechanics/MATLAB/'));

curdir      =   cd;     % current directory

% an arbitrary value that limits the upper end of data import from trc
% files
maxPts      =   150;    
fps         =   500;
Fs          =   fps*10;

%% Import data
% import footfall data, which will be used to determine which files to use
% for remaining data. Also, import force plate calibration matrix, to be
% used to calculated forces from binary output data generated by Cortex.

% Automatically assign file and path parameters if working off Tonia's
% computer. Otherwise, request information, as needed.
if exist('C:\Users\Liz\Desktop\DataLarge') == 7    % laptop
    ffname                  =   'DataList'; %'BasiliskFootfalls.xlsx';
    ffpath                  =   'C:\Users\Liz\Desktop\DataLarge';
    calfname                =   'fpCalMatrix.csv';
    calpath                 =   'C:\Users\Liz\Desktop\DataLarge';
    newdir                  =   'C:\Users\Liz\Desktop\DataLarge';
else
    [ffname,ffpath,fidx]        =   uigetfile('*.xlsx','Select Footfall File');
    [calfname,calpath,fidx]     =   uigetfile('*.csv','Select Force Plate Calibration Matrix (*.csv)');
    newdir                      =   uigetdir('','Select the Directory Containing Data Folders'); 
    clear fidx
end

% Here is where importing the files and data actual begins
cd(ffpath);
[num,txt,raw]   =   xlsread(ffname);

ff.raw          =   raw;
ff.allfnames   	=   txt(2:end,1);
ff.datafolder   =   txt(2:end,2);
ff.mass = num(:,1);
ff.svl = num(:,4);
ff.treat = txt(2:end,4);
ff.force = txt(2:end,5);
ff.forcestep    =   num(:,7:8);
ff.FD           =   num(:,9:2:end);
ff.FO           =   num(:,10:2:end);
[ff.ufnames,ff.ia,ff.ic]    =   unique(txt(2:end,1),'stable');  
ff.datafolder               =   ff.datafolder(ff.ia);

datafiles       =   ff.ufnames;
numTrials       =   length(datafiles);
heads           =   cell([numTrials,1]);

clear num txt raw

% import force plate calibration matrix
data.fpcalMat   =   importdata(calfname);
% pre-allocate space for force data
F               =   cell(1,numTrials);

clear cal* fidx

% import data from data files
cd(newdir);
disp(sprintf('Extracting Data from Files in Directory %s',newdir));

% pre-allocate space for filenames
data.forcefname       	=   cell(1,numTrials);
data.kinemfname       	=   cell(1,numTrials);

for i = 1:numTrials  
    fprintf('.');
    fname               =   datafiles{i};
    if isempty(strfind(fname,'.'))      % confirms that file extension not included
        kinemfname      =   [fname '.trc'];
        forcefname      =   [fname '.anc'];
        datafiles{i}    =   kinemfname;
    else
        kinemfname      =   [kinemfname(1:end-3) 'trc'];
        forcefname      =   [fname(1:end-3) 'anc'];
    end
    data.forcefname{i}	=   forcefname;
    data.kinemfname{i}	=   kinemfname;
    
    % change directory to the appropriate folder
    cd(['./' ff.datafolder{i}]);
    clear start*
    
    % Import KINEMATIC DATA
    %   numerical data import and assign to TEMP2
    A           =   importdata(kinemfname,'\t',5);      % File has 5 header lines
    raw{i}      =   A.data;
    % import relevant header information
    fid = fopen(kinemfname);
        temp2       =   [];
        % extract header into cell array, position {1,1}, then convert to
        % comma-delimited list
        % NOTE: header values will include a ton of non-variable names,
        % because variable number will likely be less than maxPts. This
        % should not cause any problems, though.
        B       =   textscan(fid,'%s',maxPts,'delimiter','\t',...
                    'MultipleDelimsAsOne',1,'HeaderLines',3);
        temp    =   B{1,1}';
        
        for j = 1:maxPts
            temp2   =   [temp2 temp{j} ','];
        end
        heads{i}    =   temp2;
    fclose (fid);
    clear A B
    
    if strcmp(ff.force(i*2),'Yes')
        
    % Import ANALOG data and convert to FORCE using calcCortexF
    temp3           =   importdata(forcefname,'\t',11);
    F{i}            =   calcCortexF(data.fpcalMat,temp3.data);
    
    % Zero force data using first 1000 data samples
    F{i}            =   F{i} - repmat(mean(F{i}(1:1000,:)),size(F{i},1),1);
    end
    cd(newdir);
end

data.FTz            =   F;

for i = 1:numTrials
    data.rawXYZ{i} = raw{i}(:,2:end);
end
fprintf('done!\n');
clear F binMat fid fname j temp*;

cd(curdir);

%% Isolate individual variables from trc file and rotate/filter forces from anc file
% Variables of interest identified in cell array VARNAMES. All variables
% are rotated so that Back_mid runs parallel to the X-axis (determined by
% taking the difference in location for the first and last foot down
% location for each trial)
varnames    =   genvarname({'Head_Anterior','Head_Posterior','Back_anterior','Back_middle',...
                 'Back_posterior','L_shoulder','L_elbow','L_wrist',...
                 'R_shoulder','R_elbow','R_wrist','L_hip','L_knee',...
                 'R_hip','R_knee','L_ankle','R_ankle','L_foot','R_foot',...
                 'L_toe','R_toe','Tail1','Tail2','Tail3','Tail4','Tail5'});
% Preallocate space for theta (rotation about Z-axis to align running direction)             
theta       =   nan(length(datafiles),1);
data.theta  =   theta;
data.rotF   =   cell(1,numTrials);
data.rotXYZ =   cell(1,numTrials);

for i = 1:length(datafiles)
    
    temp    =   raw{i};
    temph   =   heads{i};
    temph = strrep(temph,' ','_');
    
    % Rotate the trials only if footfall data exist for the trial of
    % interest. (Check first if ff.FD has a row i, then check that that row
    % is not empty before proceeding.)
    rotF    =   data.FTz{i};
    
%     if i <= size(ff.FD,1)
%         if ~isempty(ff.FD(ff.ia(i),:))
            % find the column for Head_Anterior
            varLoc  =   findstr(lower(temph),'head_anterior');
            colnum  =   (length(findstr(temph(1:varLoc),','))-1)*3;

            % TEMP2 contains just the Head_Anterior point
            temp2   =   temp(:,colnum:colnum+2);
                     
            % calculate angle of Z rotation, using the first instance of footfalls
            % for each file as the metric for run direction.
            start = min(find(~isnan(temp2(:,1))==1));
            finish = max(find(~isnan(temp2(:,1))==1));
            
            theta(i)=   atan(diff(temp2([start finish],2))/...
                             diff(temp2([start finish],1)));
            
%             atan(diff(temp2([min(ff.forcestep(ff.ia(i),:)) max(ff.forcestep(ff.ia(i),:))],2))/...
%                              diff(temp2([min(ff.forcestep(ff.ia(i),:)) max(ff.forcestep(ff.ia(i),:))],1)));
            
            % Rotate TEMP around Z-axis such that the lizard is running along the
            % x-axis.
            for j = 3:3:size(temp,2)
                temp(:,j:j+2)	=   ZAxisRotAngle(temp(:,j:j+2),-theta(i));
            end
            
            %Apply filter
    for j = 3:3:size(temp,2)
        XYZ = temp(:,j:j+2);
        if ~isempty(find(isnan(temp(:,j))));
            if sum(isnan(temp(:,j)))< .6*(length(temp(:,j)))
                XYZ_old = XYZ;
                t               =   0:1/fps:(size(XYZ,1)-1)/fps;
                teval       = t;
                r           =   1:size(XYZ,1);
                r(find(~isnan(XYZ(:,1))))   =   [];
                t(r)        =   [];
                XYZ(r,:)    =   [];
                 U               =   nan(size(XYZ_old));
                for trial = 1:size(XYZ,2)
                    U(:,trial) = fnval(teval,csaps(t,XYZ(:,trial)))';

                end
                %apply the filter 
                temp(:,j:j+2) = lopass_butterworth(U,60,500,4);
                temp(r,j:j+2) = NaN;

               clear XYZ* r t U 
            end
       
    else
        temp(:,j:j+2) = lopass_butterworth(XYZ,60,500,4);
        
            end 
    end
            % TEMP NOW CONTAINS ROTATED DATA
            if isempty(data.FTz{i})==0
                
            % Rotatfe FORCES ONLY in FTz around Z-axis the same amount as
            % kinematic data, then FILTER
            rotF(:,1:3)     =   ZAxisRotAngle(data.FTz{i}(:,1:3),-theta(i));
            for c = 1:6
                rotF(:,c)   =   lopass_butterworth(rotF(:,c),60,Fs,4);
            end
            % ROTF NOW CONTAINS ROTATED AND FILTERED DATA!!!!
            end
            
            clear colnum j temp2 varLoc;
%         end
%     end

    
    for v = 1:length(varnames)
        % find the appropriate column for VARNAMES{v}
        varLoc  =   findstr(lower(temph),lower(varnames{v}));
        if isempty(varLoc)
            fprintf('No variable %s found for %s. Variables not created.\r',varnames{v},datafiles{i});
            eval([varnames{v} '{i}  = [];']);
        else
            colnum  =   (length(findstr(temph(1:varLoc),','))-1)*3;
            if colnum > size(temp,2)
                fprintf('No variable %s found for %s. Variables not created.\r',varnames{v},datafiles{i});
                eval([varnames{v} '{i}  = [];']);
            else
                disp(sprintf('Variable %s is found to occupy column %d in file %s.\r',varnames{v},colnum,datafiles{i}));
                % Extract the variable
                temp2       =   temp(:,colnum:colnum+2);
                eval([varnames{v} '{i}  = temp2;']);
            end
        end
      
    end
    
    data.rotF{i}    =   rotF;
    data.rotXYZ{i}  =   temp;
    
    clear colnum rotF temp* v varLoc;
   
end
data.ff         =   ff;
data.theta      =   theta;
close all
clear i theta*;

data.Head_Anterior= Head_Anterior;
data.Back_anterior= Back_anterior;
data.Back_middle= Back_middle;
data.Back_posterior= Back_posterior;
data.Head_anterior= Head_Anterior;
data.Head_posterior= Head_Posterior;
data.L_ankle = L_ankle;
data.L_elbow = L_elbow;
data.L_foot = L_foot;
data.L_hip = L_hip;
data.L_knee = L_knee;
data.L_shoulder = L_shoulder;
data.L_toe = L_toe;
data.L_wrist = L_wrist;
data.R_ankle = R_ankle;
data.R_elbow = R_elbow;
data.R_foot = R_foot;
data.R_hip = R_hip;
data.R_knee = R_knee;
data.R_shoulder = R_shoulder;
data.R_toe = R_toe;
data.R_wrist = R_wrist;
data.Tail1 = Tail1;
data.Tail2 = Tail2;
data.Tail3 = Tail3;
data.Tail4 = Tail4;
data.Tail5 = Tail5;
%% Instantaneous Velocity Calculation

for i = 1:numTrials
     FD = data.ff.FD(i*2-1:i*2,:);
     FO = data.ff.FO(i*2-1:i*2,:);

     velo{i} = CalcVelocity(data.Head_Anterior{i},500);
    veloshort{i} = velo{i}(min(FD(:)):max(FO(:)),:);
end
data.instvelo= velo;
data.veloshort = veloshort;
 %% lsdalkfj
for i =1:numTrials
    for j = 1:3
        a = max(veloshort{i}(:,j));
        b = min(veloshort{i}(:,j));
        percentvelodif(i,j) = (a-b)/a*100;
      if isempty(data.FTz{i})==0
        ForceMax(i,j) = max(data.rotF{i}(:,j));
        ForceMin(i,j) = min(data.rotF{i}(:,j));
      end
    end
end
clear FD FO a b i j
data.ForceMax = ForceMax;
data.ForceMin = ForceMin;
data.percentvelodif = percentvelodif;
%%
data.ff = ff;
data.datafiles = datafiles;
data.fps = fps;
data.Fs = Fs;

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
ff.forcefoot    =   txt(2:end,6);
ff.forcestep    =   num(:,7:8);
ff.FD           =   num(:,9:2:end);
ff.FO           =   num(:,10:2:end);
[ff.ufnames,ff.ia,ff.ic]    =   unique(txt(2:end,1),'stable');  
ff.datafolder               =   ff.datafolder(ff.ia);

datafiles       =   ff.ufnames;
numTrials       =   length(datafiles);
heads           =   cell([numTrials,1]);

clear num txt raw

% % import force plate calibration matrix
% data.fpcalMat   =   importdata(calfname);
% % pre-allocate space for force data
% F               =   cell(1,numTrials);

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
    
%     if strcmp(ff.force(i*2),'Yes')
        
%     % Import ANALOG data and convert to FORCE using calcCortexF
%     temp3           =   importdata(forcefname,'\t',11);
%     F{i}            =   calcCortexF(data.fpcalMat,temp3.data);
%     
%     % Zero force data using first 1000 data samples
%     F{i}            =   F{i} - repmat(mean(F{i}(1:1000,:)),size(F{i},1),1);
%      end
    cd(newdir);
end

% data.FTz            =   F;

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
%     rotF    =   data.FTz{i};
    
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
%             % TEMP NOW CONTAINS ROTATED DATA
%             if isempty(data.FTz{i})==0
%                 
%             % Rotatfe FORCES ONLY in FTz around Z-axis the same amount as
%             % kinematic data, then FILTER
%             rotF(:,1:3)     =   ZAxisRotAngle(data.FTz{i}(:,1:3),-theta(i));
%             for c = 1:6
%                 rotF(:,c)   =   lopass_butterworth(rotF(:,c),60,Fs,4);
%             end
%             % ROTF NOW CONTAINS ROTATED AND FILTERED DATA!!!!
%             end
            
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
    
%     data.rotF{i}    =   rotF;
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
% %% Calculate duty factor, stride length, step width, and frequency
% data.DF         =   nan(numTrials,2);   % column 2 is for drop trial only
% data.sFreq      =   nan(numTrials,2);   % column 2 is for drop trial only
% data.LsLen       =   nan(numTrials,2);   % column 2 is for drop trial only
% data.RsLen       =   nan(numTrials,2);   % column 2 is for drop trial only
% data.sWidth     =   nan(numTrials,2);   % column 2 is for drop trial only
% for trial = 1:2:2*numTrials
%     FD          =   ff.FD(trial:trial+1,:);
%     FO          =   ff.FO(trial:trial+1,:);
%     % Check that FD and FO have the same number of columns
%     if size(FD,2) ~= size(FO,2)
%         FD      =   FD(:,1:min([size(FD,2) size(FO,2)]));
%         FO      =   FO(:,1:min([size(FD,2) size(FO,2)]));
%     end
%     
%     numStr(1)   =   length(find(~isnan(FD(1,:))))-1;
%     numStr(2)   =   length(find(~isnan(FD(2,:))))-1;
% 
%     % duty factor calculation
%     stride      =   diff(FD,[],2);
%     stance      =   FO-FD;
%     DF          =   stance(:,1:size(stride,2))./stride;
%     data.DF((trial+1)/2,1)    =   nanmean(reshape(DF,numel(DF),1));
%     clear temp
%     
%     % stride frequency calculation
%     tStr(1)     =   (max(FD(1,:)) - min(FD(1,:)))/fps;
%     tStr(2)     =   (max(FD(2,:)) - min(FD(2,:)))/fps;
%     sFreq       =   numStr./tStr;
%     data.sFreq((trial+1)/2,1)     =   nanmean(reshape(sFreq,numel(sFreq),1));
%     
%     % stride length calculation based on same leg ankle to ankle 2D distance
%     if sum(isnan(FD(2,:))) <= .5*length(FD(2,:)) %this may not necessairly be the best idea.  it is really only a problem if more than one is nan
%         Rpos        =   R_ankle{(trial+1)/2}([min(FD(2,:)) max(FD(2,:))],:);
%         RsLen       =   sqrt(sum(diff(Rpos(:,1:2)).^2))/numStr(2);
%     else
%         Rpos = 0;
%         RsLen = 0;
%     end
%         
%     Lpos        =   L_ankle{(trial+1)/2}([min(FD(1,:)) max(FD(1,:))],:);
%    if isnan(Lpos(1,1)) == 1
% %        Lpos(1,:) = L_ankle{(trial+1)/2}(FD(1,2),:)
%    end
%     LsLen       =   sqrt(sum(diff(Lpos(:,1:2)).^2))/numStr(1);
% %     RsLen       =   sqrt(sum(diff(Rpos(:,1:2)).^2))/numStr(2);
%     data.LsLen((trial+1)/2,1)	=   LsLen;  % trial average
%     data.RsLen((trial+1)/2,1)   =   RsLen;  % trial average
%     data.Rpos = Rpos;
%     data.Lpos = Lpos;
%     clear pos Rpos Lpos
%     
%     % step width calculation
%     
%     Lpos        =   L_ankle{(trial+1)/2}(FD(1,~isnan(FD(1,:))),1:2);
% %     if isnan(Lpos(1,1)) == 1
% %        Lpos(1,:) = L_ankle{(trial+1)/2}(FD(1,2),:)
% %    end
%     Rpos        =   R_ankle{(trial+1)/2}(FD(2,~isnan(FD(2,:))),1:2);
%     % shorten to the short length if these are of different lengths
%     if numel(Rpos) ~= 0
%         if size(Lpos,1) ~= size(Rpos,1)
%             Lpos    =   Lpos(1:min([size(Lpos,1) size(Rpos,1)]),:);
%             Rpos    =   Rpos(1:min([size(Lpos,1) size(Rpos,1)]),:);
%             sWidth     =   sqrt(sum((Lpos-Rpos).^2,2))';
%             data.sWidth((trial+1)/2,1)  =   nanmean(sWidth);
%         end
%         else
%             sWidth     =   sqrt(sum((Lpos).^2,2))';
%             data.sWidth((trial+1)/2,1)  =   nanmean(sWidth);
%     end
%     % Calculations for drop step, only.
%     if strcmp('drop',lower(ff.treat{trial}))
% %         % duty factor
% %         stance      =   diff(ff.forcestep(trial,:));
% %         stride      =   FD(find(FD == ff.forcestep(trial,1))+2) - ff.forcestep(trial,1);
% %         data.DF((trial+1)/2,2)      =   stance/stride;
% %         DF(DF == stance/stride)     =   NaN;
% %         data.DF((trial+1)/2,1)    =   nanmean(reshape(DF,numel(DF),1));
% % 
% %         % stride frequency
% %         data.sFreq((trial+1)/2,2)       =   1/stride*fps;
% %         sFreq(sFreq == 1/stride*fps)    =   NaN;
% %         data.sFreq((trial+1)/2,1)       =   nanmean(sFreq);
% %         
% %         switch lower(ff.forcefoot{trial})
% %             case 'l'
% %                 % stride length
% %      
% %                 pos         =   L_ankle{(trial+1)/2}([ff.forcestep(trial,1) FD(find(FD == ff.forcestep(trial,1))+2)],:);
% %                 data.LsLen((trial+1)/2,2)	=   sqrt(sum(diff(pos).^2));
% %                 % stride width this is giving average stride with and drop
% %                 % step
% %                 if length(sWidth) >=  find(ff.forcestep(trial,1) == FD(1,:))
% %                     
% %                     data.sWidth((trial+1)/2,2)  =   sWidth(find(ff.forcestep(trial,1) == FD(1,:)));
% %                     sWidth(sWidth == data.sWidth((trial+1)/2,2))    =   NaN;
% %                     data.sWidth((trial+1)/2,1)  =   nanmean(sWidth);
% %                 else
% %                     data.sWidth((trial+1)/2,1)  =   nanmean(sWidth);
% %                 end
% %             case 'r'
% %                 % stride length
% %                 pos         =   R_ankle{(trial+1)/2}([ff.forcestep(trial,1) ff.forcestep(trial,2)],:);
% %                 data.RsLen(2)	=   sqrt(sum(diff(pos).^2));
% %                 % stride width
% %                 if length(sWidth) >=  find(ff.forcestep(trial,1) == FD(2,:))
% %                     data.sWidth((trial+1)/2,2)  =   sWidth(find(ff.forcestep(trial,1) == FD(2,:)));
% %                 else
% %                     data.sWidth((trial+1)/2,2) = nanmean(sWidth);
% %                 end
% %             otherwise
% %                 disp('Force foot not detected. Drop variables not calculated.')
%          end
%     end
% 
% %     % write data to fields in data
% %     data.DF((trial+1)/2)          =   nanmean(reshape(DF,1,numel(DF)));
% %     data.sFreq((trial+1)/2,1)     =   nanmean(sFreq);
% %     data.sLen((trial+1)/2,:)      =   mean([LsLen, RsLen]);
% %     data.sWidth((trial+1)/2,1)    =   mean(sWidth);
% 
% 
% clear DF FD FO Lpos LsLen Rpos RsLen sfreq stance swidth swing trial

%% Calculate total Velocity only for first to final foot down, both feet
% h               =   figure('Name','Back mid data smoothed');
% h2              =   figure('Name','Back mid velocities');

for trial = 1:2:2*numTrials
    FD          =   [min(ff.FD(trial:trial+1,1)) max(max(ff.FD(trial:trial+1,:)))];
    temp        =   Back_middle{(trial+1)/2}(FD(1):FD(2),:);     % extract only the region of interest
    t           =   0:1/500:(size(temp,1)-1)/500;
    
    % find and remove instances of NaN for splining
    tsp         =   t;
    misspts     =   find(isnan(temp(:,1)));
    if length(misspts) > size(temp,1)*.15
        fprintf('More than 15 percent of the data are NaN for trial %d, file %s\n',(trial+1)/2,datafiles{(trial+1)/2});
    end
    
    % pre-allocate space for smoothing
    temp2   =   nan(size(temp,1),3);
    utemp   =   nan(size(temp,1),3);
    
    % reduce tsp and temp to only existing ata in preparation for splining
    tsp(misspts)    =   [];
    temp(misspts,:) =   [];
    
    % smooth with butterworth filter      
    for i = 1:3
        % interpolate missing datapoints in temp into temp3
        temp3       =   fnval(t,csaps(tsp,temp(:,i)));
        temp2(:,i)  =   lopass_butterworth(temp3,80,500,4);
        utemp(:,i)  =   fnval(t,fnder(csaps(t,temp2(:,i))));
    end
    
    % store the TOTAL VELOCITY (sum x,y,z) in the fourth column of utemp
    utemp(:,4)  =   sqrt(sum(utemp.^2,2));
    
%     figure(h);
%     subplot(numTrials,1,(trial+1)/2);
%     plot(tsp,temp,'k:');
%     hold on; plot(t,temp2,'-');
%     xlabel('Time (s)');
%     ylabel('Position (mm)');
%     title(sprintf('Position raw & filtered: %s',datafiles{(trial+1)/2}));
%     
%     figure(h2);
%     subplot(numTrials,1,(trial+1)/2);
%     plot(t,utemp);
%     xlabel('Time (s)');
%     ylabel('Velocity (mm/s)');
%     title(sprintf('Velocity calculation: %s',datafiles{(trial+1)/2}));

    Utot.data((trial+1)/2)    =   {utemp};
    Utot.mean((trial+1)/2,:)  =   [nanmean(utemp(:,4)) nanstd(utemp(:,4))];
    
end

data.Utot       =   Utot;

clear FD Utot h h2 i misspts t temp* tsp utemp

%% Calculate touch down angle (in radians) to the horizontal
% 2015-11-19: changed from using hip to toe to hip to ankle to eliminate issues with
% heel strike instead of toe strikes. This does modify the ultimate value
% of touch down angle, but hopefully this will not be a problem.
TDAngle         =   nan(numTrials,3);  % data in radians

for trial = 1:numTrials
    FD          =   ff.FD((2*trial)-1:2*trial,:);
    
    if ~isempty(L_hip{trial}) & ~isempty(L_ankle{trial})
        [~,angL]             =   Angle2Horiz(L_hip{trial}, L_ankle{trial});
        TDAngle(trial,1)    =   nanmean(angL(FD(1,(~isnan(FD(1,:))))));
    else
        disp('%s: Left hip and/or toe point missing. Touch down angle not calculated for the left foot.',ff.ufnames{trial});
    end
    if ~isempty(R_hip{trial}) & ~isempty(R_ankle{trial})
        [~,angR]             =   Angle2Horiz(R_hip{trial}, R_ankle{trial});
        TDAngle(trial,2)    =   nanmean(angR(FD(2,(~isnan(FD(2,:))))));
    else
        disp('%s: Right hip and/or toe point missing. Touch down angle not calculated for the right foot.',ff.ufnames{trial});
    end
    
        % Calculations for drop step, only.
    if strcmp('drop',lower(ff.treat{2*trial}))       
        switch lower(ff.forcefoot{2*trial})
            case 'l'
                TDAngle(trial,3)    =   angL(ff.forcestep(2*trial,1));
                angL(find(TDAngle(trial,3) == angL)) = NaN;
                TDAngle(trial,1)    =   nanmean(angL(FD(1,(~isnan(FD(1,:))))));
            case 'r'
                TDAngle(trial,3)    =   angR(ff.forcestep(2*trial,1));
                angR(find(TDAngle(trial,3) == angR)) = NaN;
                TDAngle(trial,2)    =   nanmean(angR(FD(2,(~isnan(FD(2,:))))));
            otherwise
                disp('Force foot not detected. Touch-down angle for drop step not calculated.')
        end
    end
end

data.TDAngle    =   TDAngle*180/pi;
clear TDAngle ang* trial FD

%% Calculate body and tail angles (in radians) to the horizontal
% Body angle calculated using Back_anterior and Back_posterior
% (Back_posterior as the vertex)
% Tail angle calculated using Back_posterior and Tail2, with
% Back_posterior as the vertex
% Use function Angle2Horiz to calculated the angle

% pre-allocate space
bodAng          =   cell(1,numTrials);
tailAng         =   cell(1,numTrials);

% h_ang           =   figure('NumberTitle','off','Name','Body and Tail Angles');
for i = 1:numTrials
    t           =   0:1/fps:(size(Back_posterior{i},1)-1)/fps;
    [bodDeg, bodAng{i}]     =   Angle2Horiz(Back_anterior{i},Back_posterior{i});
    [tailDeg, tailAng{i}]   =   Angle2Horiz(Tail2{i},Back_posterior{i});
%     figure(h_ang);
%     subplot(numTrials,1,i);
%     plot(t,[bodDeg tailDeg],'LineWidth',2);
%     ylabel('Angle (degrees)');
%     if i == 1
%         legend('Body Angle','Tail Angle',0);
%         legend('boxoff');
%     elseif i == numTrials
%         xlabel('Time (s)');
%     end
end

data.bodAng     =   bodAng;
data.tailAng    =   tailAng;

clear i t *Ang *Deg
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
%       if isempty(data.FTz{i})==0
%         ForceMax(i,j) = max(data.rotF{i}(:,j));
%         ForceMin(i,j) = min(data.rotF{i}(:,j));
%       end
    end
end
clear FD FO a b i j
% data.ForceMax = ForceMax;
% data.ForceMin = ForceMin;
data.percentvelodif = percentvelodif;
%%
data.ff = ff;
data.datafiles = datafiles;
data.fps = fps;
data.Fs = Fs;
data.ff.forcefoot= data.ff.raw(2:end,8);
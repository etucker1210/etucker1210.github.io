function data = Chapter1Analysis
% All data should be in folders by trial date, and the excel file
% with the claibration data should be in here.
%% Setting the stage

fps = 500;

%% Import data
% We are going to import where the files are and the calibration
% information.
if exist('/Volumes/Catalina backup/Chapter 1/Granular_Level') == 7    % laptop %this is cata's drive
    ffname = 'Granular_Level_Dataset_Rotations.xlsx';
    ffpath = '/Volumes/Catalina backup/Chapter 1/Granular_Level';
    newdir = '/Volumes/Catalina backup/Chapter 1/Granular_Level';
elseif exist('C:\Users\Liz\Box\Chapter_1_Data\Granular_Level')==7
    ffname = 'Granular_Level_Dataset_Rotations.xlsx';
    ffpath = 'C:\Users\Liz\Box\Chapter_1_Data\Granular_Level';
    newdir = 'C:\Users\Liz\Box\Chapter_1_Data\Granular_Level';
elseif exist('H:\Active Data\Catalina\Chapter 1\Granular_Level')==7
    ffname = 'Granular_Level_Dataset_Rotations.xlsx';
    ffpath = 'H:\Active Data\Catalina\Chapter 1\Granular_Level';
    newdir = 'H:\Active Data\Catalina\Chapter 1\Granular_Level';    
else
    [ffname,ffpath,fidx] = uigetfile('*.xlsx','Select Information File');
    newdir = uigetdir('', 'Select Directory Containing Folders');
    clear fidx
end
cd(ffpath);
[num,txt,raw] = xlsread(ffname);

info.raw = raw;
info.allfnames = txt(2:end,1);
info.folder = txt(2:end,2);
info.calibration = num(:,1);
info.startF= num(:,2);
info.endF = num(:,3);
info.strides = num(:,4);
datafiles = info.allfnames;
numtrials = length(datafiles);
data.info = info;
clear num txt raw

% import data

data.kinemfname = cell(1,numtrials);
data.xy = cell(1,numtrials);
data.id = cell(1,numtrials);
for i = 1
    data.kinemfname{i} = info.allfnames{i};
    kname = datafiles{i};
    cd(['./' info.folder{i}]);
    
    %importing kinematic data
    A= csvread(kname,1);
    temp = A(:,7:8);
%     XYZ = temp;
%     if ~isempty(find(isnan(temp(:,1))));
%             if sum(isnan(temp(:,1)))< .6*(length(temp(:,1)))
%                 XYZ_old = XYZ;
%                 t               =   0:1/fps:(size(XYZ,1)-1)/fps;
%                 teval       = t;
%                 r           =   1:size(XYZ,1);
%                 r(find(~isnan(XYZ(:,1))))   =   [];
%                 t(r)        =   [];
%                 XYZ(r,:)    =   [];
%                  U               =   nan(size(XYZ_old));
%                 for trial = 1:size(XYZ,2)
%                     U(:,trial) = fnval(teval,csaps(t,XYZ(:,trial)))';
% 
%                 end
%                 %apply the filter 
%                 temp = lopass_butterworth(U,100,500,4);
%                 temp(r,1:2) = NaN;
% 
%                clear XYZ* r t U 
%             end
%        
%     else
%         temp = lopass_butterworth(XYZ,100,500,4);
%         
%             end
    
    xy = temp*info.calibration(i);
    if contains(kname,'Collared')
        data.id{i} = 'Collared';
    elseif contains(kname,'Zebra')
        data.id{i} = 'Zebra';
    else
    end      
    data.xy{i} = xy;
    cd(newdir)
end
%Calculating Velocity, stride length, and stride freq
data.velo = cell(1,numtrials);
data.stdfreq = nan(1,numtrials);
data.stdlength = nan(1,numtrials);
for i  = 1
    velo = CalcVelocity(data.xy{i},fps);
    veloxy = sqrt(sum(velo(:,1:2).^2,2));
    Umean = nanmean(veloxy(info.startF(i):info.endF(i)));
    data.velo{i} = horzcat(velo,veloxy);
    data.meanvelo(i) = Umean;
    time = (info.endF(i) - info.startF(i))/fps;
    sFreq = info.strides(i)./time;
    data.stdfreq(i) = sFreq;
    pos = data.xy{i}([info.startF(i) info.endF(i)],:);
    tlength = sqrt(sum(diff(pos).^2));
    stdleng= tlength/info.strides(i);
    data.stdlength(i) = stdleng;
end

    
    


    
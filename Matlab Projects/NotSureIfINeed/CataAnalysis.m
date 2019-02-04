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
    newdir = '/Volumes/Catalina backup/Chapter 1/Granular_Level'
elseif exist('C:\Users\Liz\Box\Chapter_1_Data\Granular_Level')==7
    ffname = 'Granular_Level_Dataset_Rotations.xlsx';
    ffpath = 'C:\Users\Liz\Box\Chapter_1_Data\Granular_Level';
    newdir = 'C:\Users\Liz\Box\Chapter_1_Data\Granular_Level'
    
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
numtrials = length(datafiles)

clear num txt raw

% import data

data.kinemfname = cell(1,numtrials);

for i = 1:numtrials
    data.tname = info.allfnames;
    
    cd(['./' info.folder{i}];
    
    %importing kinematic data
    A = importdata()
end
    
    


    
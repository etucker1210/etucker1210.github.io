%This will import Lower Back and Upper Back angle data.  These files are
%Hrt files.  The First 54 Rows are info.  For the Lower back we need to
%specify that the first 54 rows are headers for the upper back this number
%is 
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
if exist('/Users/ElizabethTucker/Desktop/Liz Basilisk Data') == 7    % laptop
    ffname                  =   'Footfalldataforceflat'; %'BasiliskFootfalls.xlsx';
    ffpath                  =   '/Users/ElizabethTucker/Desktop/Liz Basilisk Data/';
    newdir                  =   '/Users/ElizabethTucker/Desktop/Liz Basilisk Data/Data';
else
    [ffname,ffpath,fidx]        =   uigetfile('*.xlsx','Select Footfall File');
    newdir                      =   uigetdir('','Select the Directory Containing Data Folders'); 
    clear fidx
end

% Here is where importing the files and data actual begins
cd(ffpath);
[num,txt,raw]   =   xlsread(ffname);

ff.raw          =   raw;
ff.allfnames   	=   txt(2:end,1);
ff.datafolder   =   txt(2:end,2);

% Extract unique filenames
[ff.ufnames,ff.ia,ff.ic]    =   unique(txt(2:end,1),'stable');  
ff.datafolder               =   ff.datafolder(ff.ia);

datafiles       =   ff.ufnames;
numTrials       =   length(datafiles);
heads           =   cell([numTrials,1]);

clear num txt raw

LowerBackskb = cell(1,numTrials);
LHipskb = cell(1,numTrials);
LUpperLegskb = cell(1,numTrials);
LLowerLegskb = cell(1,numTrials);
RHipskb = cell(1,numTrials);
RUpperLegskb = cell(1,numTrials);
RLowerLegskb = cell(1,numTrials);
UpperBackskb = cell(1,numTrials);

data.skbfname = cell(1,numTrials);
for i = 1:numTrials  
    fprintf('.');
    fname               =   datafiles{i};
    if isempty(strfind(fname,'.'))      % confirms that file extension not included
        skbfname       =   [fname '.xls'];
    end

    data.skbfname{i} = skbfname;

    % change directory to the appropriate folder
    cd(newdir);
    cd(['./' ff.datafolder{i}]);
    clear start*
    
    % Import KINEMATIC DATA
    %   numerical data import and assign to TEMP2
    A           =   importdata(skbfname);      % File has 54 header lines for Lower Back
    
    % import relevant header information
    r           =   1:size(A.data,1);
    r(find(~isnan(A.data(:,1))))   =   [];
    t = length(r);
    r(t+1) = 0;
    v =0;
    for j = 1:t
        if r(j)+1 == r(j+1)
        else
            v = v+1;
            f(v,1)=r(j)+1;
        end
    end
g=f(2)-f(1)-3;
LowerBackskb{i} = A.data(f(1):f(1)+g,5:7);
    b = find(LowerBackskb{i}(:,1) == [9999999]);
    LowerBackskb{i}(b,:) = NaN;
    clear b
LHipskb{i} = A.data(f(2):f(2)+g,5:7);
    b = find(LHipskb{i}(:,1) == [9999999]);
    LHipskb{i}(b,:) = NaN;
    clear b
LUpperLegskb{i} = A.data(f(3):f(3)+g,5:7);
    b = find(LUpperLegskb{i}(:,1) == [9999999]);
    LUpperLegskb{i}(b,:) = NaN;
    clear b
LLowerLegskb{i} = A.data(f(4):f(4)+g,5:7);
    b = find(LLowerLegskb{i}(:,1) == [9999999]);
    LLowerLegskb{i}(b,:) = NaN;
    clear b
RHipskb{i} = A.data(f(5):f(5)+g,5:7);
    b = find(RHipskb{i}(:,1) == [9999999]);
    RHipskb{i}(b,:) = NaN;
    clear b
RUpperLegskb{i} = A.data(f(6):f(6)+g,5:7);
  b = find(RUpperLegskb{i}(:,1) == [9999999]);
    RUpperLegskb{i}(b,:) = NaN;
    clear b
RLowerLegskb{i} = A.data(f(7):f(7)+g,5:7);
  b = find(RLowerLegskb{i}(:,1) == [9999999]);
    RLowerLegskb{i}(b,:) = NaN;
    clear b
UpperBackskb{i} = A.data(f(8):f(8)+g,5:7);
  b = find(UpperBackskb{i}(:,1) == [9999999]);
    UpperBackskb{i}(b,:) = NaN;

    clear A b g f t v r j i 
    
    cd(newdir);
end
clear Fs heads max* n* f* s* data* curdir ans
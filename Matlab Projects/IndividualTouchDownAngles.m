function indivTD(data) 
%% this will give touchdown angles at each stride for each foot
numtrials = length(data.forcefname);
Bas9 = ('Trimmed_Bas09');
Bas10 = ('Trimmed_Bas10');
Bas26 = ('Trimmed_Bas26');
Bas31 = ('Trimmed_Bas31');
Bas9TDF = nan(1,3);
Bas10TDF = nan(1,3);
Bas26TDF = nan(1,3);
Bas31TDF = nan(1,3);
Bas9TDD = nan(1,1);
Bas10TDD = nan(1,1);
Bas26TDD= nan(1,1);
Bas31TDD = nan(1,1);
treatment = ['Flat';'Drop'];
for i = 1:numtrials
    trial = data.forcefname(i);
    L_hip = data.L_hip{i};
    L_ankle = data.L_ankle{i};
    R_hip= data.R_hip{i};
    R_ankle = data.R_ankle{i};
    FD = data.ff.FD(i*2-1:i*2,:);
    Zero = zeros(length(L_ankle),1);
    
    if ~isempty(L_hip) & ~isempty(L_ankle)
        [~,angL]             =   Angle2Horiz(L_hip, L_ankle);
        %[~,angL]             =   Angle2Horiz([L_hip(:,1),Zero,L_hip(:,3)], [L_ankle(:,1),Zero,L_ankle(:,3)]);
    end
    if ~isempty(R_hip) & ~isempty(R_ankle)
        [~,angR]             =   Angle2Horiz(R_hip, R_ankle);
        %[~,angR] =  Angle2Horiz([R_hip(:,1),Zero,R_hip(:,3)], [R_ankle(:,1),Zero,R_ankle(:,3)]);
    end
    angR = angR*180/pi;
    angL = angL*180/pi;
    right =  (angR(FD(2,~isnan(FD(2,:)))))';
    left = (angL(FD(1,~isnan(FD(1,:)))))';
    r=length(right);
    l=length(left);
    if strcmp(data.ff.treat(i*2),'Drop') && strcmp(data.ff.forcefoot(i*2),'R')
        drop = angR(data.ff.forcestep(i*2,1));
    elseif strcmp(data.ff.treat(i*2), 'Drop') && strcmp(data.ff.forcefoot(i*2),'L')
        drop = angL(data.ff.forcestep(i*2,1));
    else       
    end
    if startsWith(trial,Bas9)
        if strcmp(data.ff.treat(i*2),'Flat')
           a = size(Bas9TDF,1);
           Bas9TDF(a+1,1:l)=left;
           Bas9TDF(a+2,1:r) = right;
        else
           a = size(Bas9TDD,1);
           Bas9TDD(a+1,1)=drop;
        end
    elseif startsWith(trial,Bas10)
        if strcmp(data.ff.treat(i*2),'Flat')
           a = size(Bas10TDF,1);
           Bas10TDF(a+1,1:l)=left;
           Bas10TDF(a+2,1:r) = right;
        else
           a = size(Bas10TDD,1);
           Bas10TDD(a+1,1)=drop;
        end
    elseif startsWith(trial,Bas26)
        if strcmp(data.ff.treat(i*2),'Flat')
           a = size(Bas26TDF,1);
           if strcmp(data.forcefname(i),'Trimmed_Bas26_2015_08_19_Trial12.anc')
               Bas26TDF(a+1,1:l) = nan(1,l);
           else
               Bas26TDF(a+1,1:l)=left;
           end
           Bas26TDF(a+2,1:r) = right;
        else
           a = size(Bas26TDD,1);
           Bas26TDD(a+1,1)=drop;
        end
    else
        if strcmp(data.ff.treat(i*2),'Flat')
           a = size(Bas31TDF,1);
           Bas31TDF(a+1,1:l)=left;
           Bas31TDF(a+2,1:r) = right;
        else
           a = size(Bas31TDD,1);
           Bas31TDD(a+1,1)=drop;
        end
    end
    clear a left right FD L* R* r l numtrials trial ang*
end
clear i Bas10 Bas26 Bas9 Bas31
Bas9TDF(1,:)  = [];
Bas10TDF(1,:) = [];
Bas26TDF(1,:) = [];
Bas31TDF(1,:) = [];
Bas9TDD(1,:)  = [];
Bas10TDD(1,:) = [];
Bas26TDD(1,:) = [];
Bas31TDD(1,:) = [];
Bas9TDF(Bas9TDF==0)  = NaN;
Bas10TDF(Bas10TDF==0)  = NaN;
Bas26TDF(Bas26TDF==0)  = NaN;
Bas31TDF(Bas31TDF==0)  = NaN;
Bas9TDD(Bas9TDD==0)  = NaN;
Bas10TDD(Bas10TDD==0)  = NaN;
Bas26TDD(Bas26TDD==0)  = NaN;
Bas31TDD(Bas31TDD==0)  = NaN;
Bas9TD(:,1)=Bas9TDF(:);
Bas9TD(1:8,2)=Bas9TDD;
Bas10TD(:,1)=Bas10TDF(:);
Bas10TD(1:8,2)=Bas10TDD;
Bas26TD(:,1)=Bas26TDF(:);
Bas26TD(1:8,2)=Bas26TDD;
Bas31TD(:,1)=Bas31TDF(:);
Bas31TD(1:8,2)=Bas31TDD;
Bas9TD(Bas9TD==0)  = NaN;
Bas10TD(Bas10TD==0)  = NaN;
Bas26TD(Bas26TD==0)  = NaN;
Bas31TD(Bas31TD==0)  = NaN;
% figure('Name','Bas09TD')
% boxplot(Bas9TD,treatment)
% figure('Name','Bas10TD')
% boxplot(Bas10TD,treatment)
% figure('Name','Bas26TD')
% boxplot(Bas26TD,treatment)
% figure('Name','Bas31TD')
% boxplot(Bas31TD,treatment)
FlatTD = Bas9TDF(:);
FlatTD= [FlatTD;Bas10TDF(:)];
FlatTD= [FlatTD;Bas26TDF(:)];
FlatTD= [FlatTD;Bas31TDF(:)];
DropTD = Bas9TDD(:);
DropTD = [DropTD;Bas10TDD(:)];
DropTD = [DropTD;Bas26TDD(:)];
DropTD = [DropTD;Bas31TDD(:)];
TD = FlatTD;
TD(1:length(DropTD),2) = DropTD;
TD(TD==0)  = NaN;
% figure('Name','Total TD angle')
% boxplot(TD,treatment)

lizTD = Bas9TD;
lizTD = [lizTD Bas10TD];
lizTD = [lizTD Bas26TD];
lizTD = [lizTD Bas31TD];
boxplot(lizTD,'labels',{'Bas9 Flat','Bas9 Drop','Bas10 Flat','Bas10 Drop','Bas26 Flat', 'Bas26 Drop', 'Bas31 Flat', 'Bas31 Drop'})
ylabel('Touch Down Angle in Degrees')


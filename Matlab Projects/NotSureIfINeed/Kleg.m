numtrials = length(data.forcefname);
%%  need to calculate 3d leg length and force and com height.  
%This should be TD to Midstance aka max compression.

%First calculate the different leg legnth/ Com positions

for  i = 1:numtrials
    if strcmp(data.ff.kinematic(i*2,1),'Yes')
    FD = data.ff.forcestep(i*2,1);
    FO = data.ff.forcestep(i*2,2);
    if strcmp(data.ff.forcefoot(i*2),'L')
        %take position of hip to toe from TD to midstance.
        mid = min(find(data.L_hip{i}(FD:FO,1) >= data.L_toe{i}(FD:FO,1)))+ (FD-1);
        if isempty(mid)
        Lo = data.L_hip{i}(FD,:);
        Lo(2,:) = data.L_toe{i}(FD,:);
        Lm = NaN
        Lm(2,:) = NaN
        else
        Lo = data.L_hip{i}(FD,:);
        Lo(2,:) = data.L_toe{i}(FD,:);
        Lm = data.L_hip{i}(mid,:);
        Lm(2,:) = data.L_toe{i}(mid,:);
        end
    else
        mid = min(find(data.R_hip{i}(FD:FO,1) >= data.R_toe{i}(FD:FO,1)))+ (FD-1);
        Lo = data.R_hip{i}(FD,:);
        Lo(2,:) = data.R_toe{i}(FD,:);
        Lm = data.R_hip{i}(mid,:);
        Lm(2,:) = data.R_toe{i}(mid,:);
    end
    end
    Fmid = sqrt(sum(data.rotF{i}(mid,1:3).^2));
    Ffd = sqrt(sum(data.rotF{i}(FD,1:3).^2));
    comfd = sqrt(sum(data.CM{i}(FD,:).^2));
    commid = sqrt(sum(data.CM{i}(mid,:).^2));
    dcom = comfd - commid;
    Lo = sqrt(sum(diff(Lo).^2));
    Lm = sqrt(sum(diff(Lm).^2));
    L = Lo-Lm;
    Klit{i,1} = (Fmid-Ffd)/L;
    Kvirtual{i,1} =(commid-comfd)/L;
    %lowbackangtd(i,:) = data.LowerBackskb{i}(FD,:);
  %  upbackangtd(i,:) = data.UpperBackskb{i}(FD,:);
       clear F* L* com* dcom mid;
end
data.Klit = Klit;
data.Kvirtual = Kvirtual;
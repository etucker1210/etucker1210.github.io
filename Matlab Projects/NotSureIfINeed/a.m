% for trial = 1:length(data.forcefname)
%        
%     ff          =   data.ff.forcestep(trial*2,:)*10;
%     F           =   data.rotF{trial}(ff(1):ff(2),1:3);
%     % Remove the next two lines if not matching Daley's data
%     F(:,1)      =   -F(:,1);
%     F(:,3)      =   -F(:,3);
%      scrsz       =   get(groot,'ScreenSize');
%     h           =   figure('Name',data.kinemfname{trial},'Position',[1 1 scrsz(3)/3 scrsz(4)]);
%     
% %     ax1         =   subplot(7,1,1:2);     % Force data
%     ax1         = subplot('Position',[0.15 0.71 0.7 0.28]);
%     p1          =   plot(ax1,linspace(0,100,size(F,1)),F-repmat(F(1,:),size(F,1),1),'k');
%     set(p1,'LineWidth',1.5);
%     p1(2).LineStyle     =   '--';
%     p1(3).LineStyle     =   ':';
%     Lax1                = legend('F_X','F_Y','F_Z','Location','northeast'); 
%     Lax1.Box            =   'off';
%     Lax1.Position       =   [0.8562    0.8690    0.1291    0.1181];
% %     Lax1.Position       =   [0.7730    0.8147    0.1290    0.1056];
%     ylabel('\Delta Force (N)');
%     ax1.Box = 'off';
%     ax1.XColor = 'none';
% end
numTrials = length(data.forcefname);
for trial = 1:numTrials
    CM          =   data.CM{trial};
    foot        =   data.ff.forcefoot(trial);
    
    % Extract stance period for the foot producing force to variable
    % FORCESTEP Remaining calculations will deal with this step, ONLY!
    forcestep   =   data.ff.forcestep(2*trial,:);
    
    % Pull relevant variables for the force foot
    switch lower(data.ff.forcefoot{2*trial})
        case 'r'
            hip     =   data.R_hip{trial};
            foot    =   data.R_ankle{trial};
        case 'l'
            hip     =   data.L_hip{trial};
            foot    =   data.L_ankle{trial};
    end
    % Identify mid-stance as 1/2 stance angle
    initialpos  =   diff([hip(forcestep(1),:); foot(forcestep(1),:)])*-1;
    finalpos    =   diff([hip(forcestep(2),:); foot(forcestep(2),:)])*-1;
   
    % Limb stiffness: kleg = F/zleg, for which zleg is the difference in
    % hip height between mid-stance and initial leg length at touchdown
    %   (1) Identify initial leg length (L0) for each step
    L0(trial)         =   sqrt(sum(initialpos.^2))/1000;  % change to units of m
   
end

data.L0 = L0;

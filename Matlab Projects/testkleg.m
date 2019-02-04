maxPts      =   150;    
fps         =   500;
Fs          =   500*10;
for trial = 1:length(data.forcefname)
if strcmp('Yes',data.ff.kinematic(trial*2,1)) 
    CM          =   data.CM{trial};
    foot        =   data.ff.forcefoot(trial*2);
    
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
    %   (1) Calculate 1/2 angle between these two vectors
    theta       =   acos(dot(initialpos,finalpos)/(sqrt(sum(initialpos.^2))*sqrt(sum(finalpos.^2))))/2;  % radians
    
    thetaSweep(trial)  =   theta*2;
    
    % Vertical stiffness: kvert = F/x, for which x is the change in CM
    % height during stance
    %   (1) Calculate dzCM as difference in CM height during stance, based
    %       on force data
    dzCM            =   max(CM(:,3)) - min(CM(:,3));
    %   (2) Identify dFz during stance, which really should just be the
    %       peak vertical force that occurs after the initial impulse
    %       (assume that is beyond 30% of the period)
    Fz              =   data.rotF{trial}((forcestep(1)+round(diff(forcestep)/3))*Fs/fps:forcestep(2)*Fs/fps,3);
    dFz             =   max(-Fz);
    %   (4) Calculate kvert
     kvert(trial)    =   dFz/dzCM;
    
    % Limb stiffness: kleg = F/zleg, for which zleg is the difference in
    % hip height between mid-stance and initial leg length at touchdown
    %   (1) Identify initial leg length (L0) for each step
    L0          =   sqrt(sum(initialpos.^2))/1000;  % change to units of m
    %   (2) Calculate zleg as dzCM + L0(1-cos[theta])
    zleg        =   dzCM + L0*(1-cos(theta));
    %   (4) Calculate kleg
    kleg(trial)     =   dFz/zleg;
   
else
    thetaSweep(trial)  = NaN;
    kvert(trial) = NaN;
    kleg(trial)     = NaN;
end
end

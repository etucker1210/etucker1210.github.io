numtrials = length(data.forcefname);

%% this is going to make limb tradjectories xz plane

for trial = 1:numtrials
   
        R_hip = data.R_hip{trial}(:, [1,2]);
        R_knee = data.R_knee{trial}(:, [1,2]);
        R_ankle = data.R_ankle{trial}(:, [1,2]);
        R_foot = data.R_foot{trial}(:, [1,2]);
        R_toe = data.R_toe{trial}(:, [1,2]);
        R_knee = R_hip - R_knee;
        R_ankle = R_hip - R_ankle;
        R_foot = R_hip - R_foot;
        R_toe = R_hip - R_toe;
 
        L_hip = data.L_hip{trial}(:, [1,3]);
        L_knee = data.L_knee{trial}(:, [1,3]);
        L_ankle = data.L_ankle{trial}(:, [1,3]);
        L_foot = data.L_foot{trial}(:, [1,3]);
        L_toe = data.L_toe{trial}(:, [1,3]);
        L_knee = L_hip - L_knee;
        L_ankle = L_hip - L_ankle;
        L_foot = L_hip - L_foot;
        L_toe = L_hip - L_toe;
        
    
    figure('NumberTitle','off','Name',data.ff.ufnames{trial});
    subplot(2,1,1)
        plot(0,0,'ko')
        hold on
        plot(L_knee(:,1), L_knee(:,2),'r')
        plot(L_ankle(:,1), L_ankle(:,2),'k') 
        plot(L_foot(:,1), L_foot(:,2),'b')
        plot(L_toe(:,1), L_toe(:,2),'g')
        title('Limb Trajectory for Left Limb whole trial');
        xlabel('X Position');
        ylabel('Z Position');
        legend('hip', 'knee', 'ankle', ' foot' ,'toe');
       subplot(2,1,2)
        plot(0,0,'ko')
        hold on
        plot(R_knee(:,1), R_knee(:,2),'r')
        plot(R_ankle(:,1), R_ankle(:,2),'k') 
        plot(R_foot(:,1), R_foot(:,2),'b')
        plot(R_toe(:,1), R_toe(:,2),'g')
        title('Limb Trajectory for Right Limb whole trial  top down')
        xlabel('X Position');
        ylabel('Z Position');
        legend('hip', 'knee', 'ankle', ' foot' ,'toe');
    clear R* L*
end
%% Proof for tonia
for trial = 1:21
figure('NumberTitle','off','Name',data.ff.ufnames{trial});
    subplot(4,1,1);
    plot(data.KE{trial}(:,4),'r'); ylabel('Total Kinetic Energy (J)');
    hold on
    subplot(4,1,2);
    plot(data.PE{trial},'g'); ylabel('Potential Energy (J)');
    subplot(4,1,3);
    plot(data.CM{trial});
    legend('X', 'Y', 'Z');
    subplot(4,1,4);
    plot((1:length(data.dCM{trial,1}(:,1)))/500,data.dCM{trial,1}(:,1)); ylabel('Velocity in X Direction(mm/s)');
   
end
%%
for i = 1:numtrials
KE = data.KE{i}(:,1:3);
PE = data.PE{i};
Ecom= data.Ecom{i};
KE(:,1) = KE(:,1) - KE(1,1);
KE(:,2) = KE(:,2) - KE(1,2);
KE(:,3) = KE(:,3) - KE(1,3);
PE = PE(:,1) - PE(1,1);
Ecom = Ecom(:,1) - Ecom(1,1);
    
figure('NumberTitle','off','Name',data.ff.ufnames{i});
subplot(4,1,1)
    plot(KE(:,1), 'k'); title('KE X');
    hold on
    ylim([-10e-3 10e-3])
subplot(4,1,2)
    plot(KE(:,2), 'r'); 
    hold on
    plot(KE(:,3), 'b');
    legend('y','z')
     ylim([-5e-3 4e-3])
subplot(4,1,3)
    plot(PE, 'g'); title('PE');
     ylim([-1e-2 4e-3])
subplot(4,1,4)
    plot(Ecom); title('Ecom');
     ylim([-20e-3 10e-3])
clear E* *E

end
numtrials = length(data.forcefname);
for i = 1:length(data.forcefname)
    xzang(i,1) = Angle2Horiz([data.Fimp(i,1),0,data.Fimp(i,3)]);
    yzang(i,1) = Angle2Horiz([data.Fimp(i,2),0,data.Fimp(i,3)]);

end

for trial = 1:  numtrials
        xzang = Angle2Horiz([data.Fimp(i,1),0,data.Fimp(i,3)])
        yzang= Angle2Horiz([data.Fimp(i,2),0,data.Fimp(i,3)])
        FD = data.ff.forcestep(trial*2,1);
        FO = data.ff.forcestep(trial*2,2);
        mass = data.ff.mass(trial*2);
        x= data.Velofilt5x{trial}(FD,1)
        y= data.Velofilt5x{trial}(FD,2)
        z=data.Velofilt5x{trial}(FD,3)
        xz= sqrt((x+z).^2);
        yz= sqrt((y+z).^2)
        subplot(2,1,1)
            if strcmp(data.ff.treat(trial*2,1),'Drop')
                    plot(data.Velofilt5x{trial}(FD,1),xzang,'ko')
            else
                plot(data.Velofilt5x{trial}(FD,1),xzang,'ro')
            end
            title('Xvelo by xzang')
            hold on
        subplot(2,1,2)
            hold on
            if strcmp(data.ff.treat(trial*2,1),'Drop')
               plot(data.Velofilt5x{trial}(FD,2),yzang,'ko')
            else 
                plot(data.Velofilt5x{trial}(FD,2),yzang,'ro')
            end
            title('yvelo by xzang')
            clear FD FO x* y* z*
end

%% work Loops Force on the Y and delta L on the x. length should eventually
% %be the difference between the com and the toe
for trial = 1:numtrials
    FD = data.ff.forcestep(trial*2,1);
    FO = data.ff.forcestep(trial*2,2);
    FFFD= FD * 10;
    FFFO= FO * 10;
    %com is in m  pos data seems to be in cm
    com = data.CM{trial,1}(FD:FO,3);
    normcom= com-com(1,1);
    if strcmp(data.ff.forcefoot(trial*2),'R')== 1;
        toe = data.R_toe{trial}(FD:FO,3);
           hipr= data.R_hip{trial}(FD:FO,3);
    else
        toe = data.L_toe{trial}(FD:FO,3);
          hipr= data.L_hip{trial}(FD:FO,3);
    end
    hip = data.Back_posterior{trial}(FD:FO,3);
    toem = toe/100;
    pos = com-toem;
    hipdif= hip-toe;
    f = data.rotF{trial}(FFFD:10:FFFO,3);
    y= 'Force (N)';
    x='delta length(m)';

    figure('NumberTitle','off','Name',data.ff.ufnames{trial});
        subplot(5,1,1)
            plot(pos,f);
            if strcmp(data.ff.treat(trial*2,1),'Drop')
                title('Z Direction Work Loop Leg Stiffness DROP');
            else
                 title('Z Direction Work Loop Leg Stiffness Level');
            end
            xlabel(x);
            ylabel(y);
       subplot(5,1,2)
            plot(hipdif,f);
            if strcmp(data.ff.treat(trial*2,1),'Drop')
                title('Z Direction Work Loop hip to toe DROP');
            else
                title('Z Direction Work Loop hip to toe Level');
            end
             xlabel(x);
             ylabel(y);
            
        subplot(5,1,3)
            plot(normcom,f);
            if strcmp(data.ff.treat(trial*2,1),'Drop')
                title('Z Direction Work Loop COM Height DROP');
            else
                title('Z Direction Work Loop COM Height Level');
            end
             xlabel(x);
             ylabel(y);
         
       subplot(5,1,4)
         plot(f);
         title('Force Trace');
         xlabel('Frames');
         ylabel(y);
       subplot(5,1,5)
         plot(com);
         title('Com Position');
         xlabel('Frames');
         ylabel('m');

    clear pos F* f toe trial com
    
end
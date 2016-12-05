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
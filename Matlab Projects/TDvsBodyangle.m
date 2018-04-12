%%This will make the tdangle to Body angle graph that I want.
numtrials = length(data.forcefname);

%%first I need to bring in all the footfalls and body angles.
%%
f1 = figure;
f2 = figure;
f3 = figure;
f4 = figure;
f5 = figure;
f6 = figure;
f7 = figure;
f8 = figure;
f9 = figure;

for i = 1:numtrials
    if strcmp(data.ff.treat(i*2),'Flat')
        FD = data.ff.FD(i*2-1:i*2,:);
        for j = 1:2
            for t = 1:size(FD,2)
                if j == 1
                    if ~isnan(FD(j,t))
                        temphip = data.L_hip{i}(FD(j,t),:);
                        temptoe = data.L_toe{i}(FD(j,t),:);
                        bodyanglepitch= data.LowerBackskb{i}(FD(j,t),1);
                        bodyangleyaw= data.LowerBackskb{i}(FD(j,t),2);
                        bodyangleroll = data.LowerBackskb{i}(FD(j,t),3);
                        
                    end
                else
                    if ~isnan(FD(j,t))
                        temphip = data.R_hip{i}(FD(j,t),:);
                        temptoe = data.R_toe{i}(FD(j,t),:);
                        bodyanglepitch= data.LowerBackskb{i}(FD(j,t),1);
                        bodyangleyaw= data.LowerBackskb{i}(FD(j,t),2);
                        bodyangleroll = data.LowerBackskb{i}(FD(j,t),3);
                    end
                end
                tdangxz = Angle2Horiz([temphip(1),0,temphip(3)],[temptoe(1),0,temptoe(3)]);
                tdangyz= Angle2Horiz([0,temphip(2),temphip(3)],[0,temptoe(2),temptoe(3)]);
                tdangxyz= Angle2Horiz(temphip,temptoe);
               figure(f1);
                hold on
                plot(tdangxz,bodyanglepitch, 'ko');
               figure(f2)
                hold on
                plot(tdangyz,bodyanglepitch,'ko');
               figure(f3)
                hold on
                plot(tdangxyz,bodyanglepitch,'ko');
               figure(f4);
                hold on
                plot(tdangxz,bodyangleyaw, 'ko');
               figure(f5)
                hold on
                plot(tdangyz,bodyangleyaw,'ko');
               figure(f6)
                hold on
                plot(tdangxyz,bodyangleyaw,'ko');
                 figure(f7);
               hold on
                 plot(tdangxz,bodyangleroll, 'ko');
               figure(f8)
                hold on
                plot(tdangyz,bodyangleroll,'ko');
               figure(f9)
                hold on
                plot(tdangxyz,bodyangleroll,'ko');            
            end
        end
    else
            FD = data.ff.forcestep(i*2,1);
            foot = data.ff.forcefoot(i*2);
            if ~isnan(FD)
            if strcmp(foot,'L')
                temphip = data.L_hip{i}(FD,:);
                temptoe = data.L_toe{i}(FD,:);
            else
                temphip = data.R_hip{i}(FD,:);
                temptoe = data.R_toe{i}(FD,:);
            end
            
         bodyanglepitch= data.LowerBackskb{i}(FD,1);
         tdangxz = Angle2Horiz([temphip(1),0,temphip(3)],[temptoe(1),0,temptoe(3)]);
         tdangyz= Angle2Horiz([0,temphip(2),temphip(3)],[0,temptoe(2),temptoe(3)]);
         tdangxyz= Angle2Horiz(temphip,temptoe);  
                 bodyangleyaw= data.LowerBackskb{i}(FD,2);
                 bodyangleroll = data.LowerBackskb{i}(FD,3);
               figure(f1);
                 hold on
                 plot(tdangxz,bodyanglepitch, 'ro');
               figure(f2)
                hold on
                plot(tdangyz,bodyanglepitch,'ro');
               figure(f3)
                 hold on
                 plot(tdangxyz,bodyanglepitch,'ro');
               figure(f4);
                hold on
                 plot(tdangxz,bodyangleyaw, 'ro');
               figure(f5)
                hold on
                 plot(tdangyz,bodyangleyaw,'ro');
               figure(f6)
                hold on
                 plot(tdangxyz,bodyangleyaw,'ro');
                 figure(f7);
               hold on
                 plot(tdangxz,bodyangleroll, 'ro');
               figure(f8)
                hold on
                 plot(tdangyz,bodyangleroll,'ro');
               figure(f9)
                hold on
                 plot(tdangxyz,bodyangleroll,'ro');
            end
    end
    clear temp* FD FO foot td* 
end

figure(f1)
    ylabel('Body Pitch (deg)')
    xlabel('TD XZ Angle (deg')
    title('TD XZ Angle Relative to Pitch')
figure(f2)
    ylabel('Body Pitch (deg)')
    xlabel('TD YZ Angle (deg')
    title('TD YZ Angle Relative to Pitch')
figure(f3)
    ylabel('Body Pitch (deg)')
    xlabel('TD 3D Angle (deg')
    title('TD 3D Angle Relative to Pitch')
figure(f4)
    ylabel('Body Yaw (deg)')
    xlabel('TD XZ Angle (deg')
    title('TD XZ Angle Relative to yaw')
figure(f5)
    ylabel('Body Yaw (deg)')
    xlabel('TD YZ Angle (deg')
    title('TD YZ Angle Relative to yaw')
figure(f6)
    ylabel('Body Yaw (deg)')
    xlabel('TD 3D Angle (deg')
    title('TD 3D Angle Relative to yaw')
figure(f7)
    ylabel('Body Roll (deg)')
    xlabel('TD XZ Angle (deg')
    title('TD XZ Angle Relative to roll')
figure(f8)
    ylabel('Body Roll (deg)')
    xlabel('TD YZ Angle (deg')
    title('TD YZ Angle Relative to roll')
figure(f9)
    ylabel('Body Roll (deg)')
    xlabel('TD 3D Angle (deg')
    title('TD 3D Angle Relative to roll')
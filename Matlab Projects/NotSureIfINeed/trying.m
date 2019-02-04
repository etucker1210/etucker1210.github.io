lonumtrials = length(data.forcefname);
% % % for i=1:numtrials
% % %    figure('NumberTitle','off','Name',data.ff.ufnames{i});
% % %    plotUglyFF(data.ff.FD((i*2-1):(i*2),:),data.ff.FO((i*2-1):(i*2),:))
% % %    hold on 
% % %    line(repmat(data.ff.forcestep(i*2,1),1,2),repmat(ylim,1,1));
% % %    line(repmat(data.ff.forcestep(i*2,2),1,2),repmat(ylim,1,1));
% % %    hold off
% % % end
% % 
% % %This will calculate the stride length of the stride going into the drop
% % %and then after the drop.  
% % 
% % 
% % for trial = 1: numtrials
% %     if strcmp(data.ff.forcefoot(trial*2),'R')
% %         temp = isnan(data.ff.FD(trial*2,:))
% %         if isnan(data.ff.FD(trial*2-1,:))== 0
% %             lpos= data.L_toe{trial}([data.ff.FD(trial*2-1,3) data.ff.FD(trial*2-1,2)],:);
% %           
% %         else
% %             %think about how this might get fucked up
% %             lpos= data.L_toe{trial}([min(data.ff.FD(trial*2-1,:)) max(data.ff.FD(trial*2-1,:))],:);
% %         end
% %         
% %         rpos = nan(3,3);
% %         if sum(temp) == 0
% %             rpos = data.R_toe{trial}([repmat(data.ff.FD(trial*2,:),1,1)],:)
% %         else
% %             for i = 1:3
% %                 if temp(i) ==  0
% %                     rpos(i,:) = data.R_toe{trial}([repmat(data.ff.FD(trial*2,i),1,1)],:);
% %                 
% %                 end
% %             end
% %         end
% %         
% %         stdin(trial) = sqrt(sum(diff(rpos(1:2,1:2))).^2);
% %         stdout(trial) = sqrt(sum(diff(rpos(2:3,1:2))).^2);
% %         oppos (trial) = sqrt(sum(diff(lpos(:,1:2))).^2);
% %         clear lpos rpos temp
% %     
% %     else 
% %         temp = isnan(data.ff.FD(trial*2-1,:));
% %         if isnan(data.ff.FD(trial*2,:))== 0
% %             rpos= data.R_toe{trial}([data.ff.FD(trial*2,3) data.ff.FD(trial*2,2)],:);
% %           
% %         elseif sum(isnan(data.ff.FD(trial*2,:)))==3
% %             rpos=nan(2,3);
% %         else
% %             
% %             %think about how this might get fucked up
% %             rpos= data.R_toe{trial}([min(data.ff.FD(trial*2,:)) max(data.ff.FD(trial*2,:))],:);
% %         end
% %         
% %         lpos = nan(3,3);
% %         if sum(temp) == 0
% %             lpos = data.L_toe{trial}([repmat(data.ff.FD(trial*2-1,:),1,1)],:)
% %         else
% %             for i = 1:3
% %                 if temp(i) ==  0
% %                     lpos(i,:) = data.L_toe{trial}([repmat(data.ff.FD(trial*2-1,i),1,1)],:);
% %                 
% %                 end
% %             end
% %         end
% %         
% %     stdin(trial) = sqrt(sum(diff(lpos(1:2,1:3))).^2);
% %     stdout(trial) = sqrt(sum(diff(lpos(2:3,1:3))).^2);
% %     oppos (trial) = sqrt(sum(diff(rpos(:,1:3))).^2);
% %     clear lpos rpos temp
% %         
% %     end
% % end
% % 
% %this calculates the KE and PE of the center of mass from where the foot
% %should have hit the forceplate but doesn't so that way we can get the
% %change in KE and PE
% for i = 1:numtrials
% KE{i} = data.KE{i}(:,1:3);
% end
% for trial = 1 : numtrials
%     if strcmp(data.ff.treat(trial*2,1),'Drop')
%         len = length(data.L_toe{trial});
%         [x y] = find(data.ff.FD(trial*2-1:trial*2,:)>data.ff.forcestep(trial*2,1));
%         index = find(y==max(y));
%         if x(index) == 2
%             frame= data.ff.FD(trial*2, y(index));
%             xmin= min(data.R_toe{trial}(frame:end,3));
%         else
%             frame = data.ff.FD(trial*2-1,y(index));
%             xmin= min(data.L_toe{trial}(frame:end,3));
%         end
%     
%         FD = data.ff.forcestep(trial*2,1);
%         FO = data.ff.forcestep(trial*2,2);
%         mass = data.ff.mass(trial*2);
%         if strcmp(data.ff.forcefoot(trial*2),'R')
%            f= [data.R_toe{trial}(FD-50:FD,3)];
%            [c index] = min(abs(f-xmin));
%            closestValues = f(index);
%            frame= find(data.R_toe{trial}(:,3) == closestValues);
%            %need to calculate KE from frame to FD
%            %%do 3d stride length
%         else
%            f= [data.L_toe{trial}(FD-50:FD,3)];
%            [c index] = min(abs(f-xmin));
%            closestValues = f(index);
%            frame= find(data.L_toe{trial}(:,3) == closestValues);
%         end
%            KExyz{trial} = .5*mass/1000*((Velofilt5{trial}(frame:FD,1:3)).*.001).^2;
%            KEXYZ{trial} = .5*mass/1000*(Velofilt5{trial}(:,1:3).*.001).^2; 
%            KExyz{trial}(:,4) = frame:1:FD;
%            filler = nan(size(KExyz{trial},1),3);
%            filler(:,4) = frame:1:FD;
%            KE{trial}(:,4) = FD:.1:FO;
%            KE{trial} = vertcat(filler,KE{trial});
%            
%     end
%     clear size xmin Fmin mass f c closestValues frame index
% end
% for i = 26:29
%     KExyz{i}=[];
% end
%     
% numtrials = length(data.forcefname)
% 
% % for trial = 1: numtrials
% %     plot(KExyz{trial})
% %     hold on
% %     plot(KE{trial}(length(KExyz{trial})+1:end,:))
% %     hold off
% %     figure
% % end
% for trial = 1:numtrials
%     FD = data.ff.forcestep(trial*2,1);
%     FO = data.ff.forcestep(trial*2,2);
%     
%   if isempty(KExyz{trial})==0
%     figure('NumberTitle','off','Name',data.ff.ufnames{trial});
%    subplot(3,1,1);
%     plot(KEXYZ{trial}(:,1),'k');
%     hold on
%     plot(KExyz{trial}(:,4),KExyz{trial}(:,1),'r'); ylabel('Kinetic Energy X (J)');
%     plot(KE{trial}(:,4),KE{trial}(:,1)),'b';
%     ylim;
%     line([repmat(FD,1,2)],[ylim],'color','k', 'LineStyle', ':');
%     line([repmat(FO,1,2)],[ylim],'color','k', 'LineStyle', ':');
%     title('10x StrideFrequency Filter');
%    subplot(3,1,2);
%     plot(KEXYZ{trial}(:,2),'k');
%     hold on
%     plot(KE{trial}(:,4),KE{trial}(:,2),'b');
%     plot(KExyz{trial}(:,4),KExyz{trial}(:,2),'r'); ylabel('Kinetic Energy Y  (J)');
%     ylim;
%     line([repmat(FD,1,2)],[ylim],'color','k', 'LineStyle', ':');
%     line([repmat(FO,1,2)],[ylim],'color','k', 'LineStyle', ':');
%    subplot(3,1,3);
%     plot(KEXYZ{trial}(:,3),'k');
%     hold on
%     plot(KE{trial}(:,4),KE{trial}(:,3),'b');
%     plot(KExyz{trial}(:,4),KExyz{trial}(:,3),'r'); ylabel('Kinetic Energy Z (J)');
%     ylim;
%     line([repmat(FD,1,2)],[ylim],'color','k', 'LineStyle', ':');
%     line([repmat(FO,1,2)],[ylim],'color','k', 'LineStyle', ':');
%     end
% clear FD FO
% end
%this will calculate the differences in min and max KE through the drop.

for trial = 1:  numtrials
   if strcmp(data.ff.treat(trial*2,1),'Drop')
       len = length(data.L_toe{trial});
        [x y] = find(data.ff.FD(trial*2-1:trial*2,:)>data.ff.forcestep(trial*2,1));
        index = find(y==max(y));
        if x(index) == 2
            frame= data.ff.FD(trial*2, y(index));
            xmin= min(data.R_toe{trial}(frame:end,3));
        else
            frame = data.ff.FD(trial*2-1,y(index));
            xmin= min(data.L_toe{trial}(frame:end,3));
        end
    
        FD = data.ff.forcestep(trial*2,1);
        FO = data.ff.forcestep(trial*2,2);
        mass = data.ff.mass(trial*2);
        if strcmp(data.ff.forcefoot(trial*2),'R')
           f= [data.R_toe{trial}(FD-50:FD,3)];
           [c index] = min(abs(f-xmin));
           closestValues = f(index);
           frame= find(data.R_toe{trial}(:,3) == closestValues);
           %need to calculate KE from frame to FD
           %%do 3d stride length
        else
           f= [data.L_toe{trial}(FD-50:FD,3)];
           [c index] = min(abs(f-xmin));
           closestValues = f(index);
           frame= find(data.L_toe{trial}(:,3) == closestValues);
        end
        
%     %difference before midstance
%        
%         maxx =max(KEXYZ{trial}(frame:FD+10,1:3));
%         minn = min(KE{trial}(:,1:3));
%         deltb4{trial}= maxx - minn;
%         clear maxx minn
%     %difference after midstance
%         timeafr = FO+50;
%         maxx =max(KEXYZ{trial}(FD+20:timeafr,1:3));
%         minn = min(KE{trial}(:,1:3));;
%         deltafr{trial} = maxx - minn;
%         clear minn maxx
     %difference before kinematics 
        maxx =max(KEXYZ{trial}(frame:FD+10,1:3));
        minn = min(KEXYZ{trial}(frame:FD+10,1:3));
        deltb4kin{trial}= maxx - minn;
        clear maxx minn
    %difference after kinematics
        timeafr = FO+50;
        maxx =max(KEXYZ{trial}(FD+20:timeafr,1:3));
        minn = min(KEXYZ{trial}(FD+20:timeafr,1:3));;
        deltafrkin{trial} = maxx - minn;
        clear minn maxx
   end
end
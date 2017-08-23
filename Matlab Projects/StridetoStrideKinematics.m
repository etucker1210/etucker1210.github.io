%The goal of this script is to gain individual kinematic data for each of
%the strides.  This will include stride length, duty factor, 
numtrials = length(data.forcefname);

%%
%This will calculate the stride length of the stride going into the drop
%and then after the drop.  
for trial = 1: numtrials
%     figure('NumberTitle','off','Name',data.ff.ufnames{trial});
%        plotUglyFF(data.ff.FD((trial*2-1):(trial*2),:),data.ff.FO((trial*2-1):(trial*2),:))
%        hold on 
%         line(repmat(data.ff.forcestep(trial*2,1),1,2),repmat(ylim,1,1));
%         line(repmat(data.ff.forcestep(trial*2,2),1,2),repmat(ylim,1,1));
%        hold off
    if strcmp(data.ff.forcefoot(trial*2),'R')
        temp = isnan(data.ff.FD(trial*2,:))
        if isnan(data.ff.FD(trial*2-1,:))== 0
            lpos= data.L_toe{trial}([data.ff.FD(trial*2-1,3) data.ff.FD(trial*2-1,2)],:);
          
        else
            %think about how this might get fucked up
            lpos= data.L_toe{trial}([min(data.ff.FD(trial*2-1,:)) max(data.ff.FD(trial*2-1,:))],:);
        end
        
        rpos = nan(3,3);
        if sum(temp) == 0
            rpos = data.R_toe{trial}([repmat(data.ff.FD(trial*2,:),1,1)],:)
        else
            for i = 1:3
                if temp(i) ==  0
                    rpos(i,:) = data.R_toe{trial}([repmat(data.ff.FD(trial*2,i),1,1)],:);
                
                end
            end
        end
        
        stdin(trial) = sqrt(sum(diff(rpos(1:2,1:2))).^2);
        stdout(trial) = sqrt(sum(diff(rpos(2:3,1:2))).^2);
        oppos (trial) = sqrt(sum(diff(lpos(:,1:2))).^2);
        clear lpos rpos temp
    
    else 
        temp = isnan(data.ff.FD(trial*2-1,:));
        if sum(isnan(data.ff.FD(trial*2,:)))== 0
            rpos= data.R_toe{trial}([data.ff.FD(trial*2,3) data.ff.FD(trial*2,2)],:);
          
        elseif sum(isnan(data.ff.FD(trial*2,:)))==3
            rpos=nan(2,3);
        else
            
            %think about how this might get fucked up
            rpos= data.R_toe{trial}([min(data.ff.FD(trial*2,:)) max(data.ff.FD(trial*2,:))],:);
        end
        
        lpos = nan(3,3);
        if sum(temp) == 0
            lpos = data.L_toe{trial}([repmat(data.ff.FD(trial*2-1,:),1,1)],:)
        else
            for i = 1:3
                if temp(i) ==  0
                    lpos(i,:) = data.L_toe{trial}([repmat(data.ff.FD(trial*2-1,i),1,1)],:);
                
                end
            end
        end
        
    stdin(trial) = sqrt(sum(diff(lpos(1:2,1:3))).^2);
    stdout(trial) = sqrt(sum(diff(lpos(2:3,1:3))).^2);
    oppos (trial) = sqrt(sum(diff(rpos(:,1:3))).^2);
    clear lpos rpos temp
        
    end
    % duty factor Pull FD and FO
FD = data.ff.FD(trial*2-1:trial*2,:);
FO = data.ff.FO(trial*2-1:trial*2,:);
end

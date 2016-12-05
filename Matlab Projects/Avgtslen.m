%this will grab the toe points from whatever data has been processed
 for i = 1:length(data.ff.FD)
dif(i,1) = min(data.ff.FD(i,:));
dif(i,2) = max(data.ff.FD(i,:));
 end

for i = 1: length(data.ff.FD)
    if sum(isnan(dif(i,:)))>0
        dif(i,:) = 0;
        if mod(i,2) == 0
            rslen(i/2,1) = 0;
        else 
            lslen((i+1)/2,1) = 0;
        end
    else
        if mod(i,2) == 0
            rslen(i/2,1) = (data.rotXYZ{1,i/2}(dif(i,2),108)- data.rotXYZ{1,i/2}(dif(i,1),108))/data.ff.numStr(i);
        else 
            lslen((i+1)/2,1) = (data.rotXYZ{1,(i+1)/2}(dif(i,2),78) - data.rotXYZ{1,(i+1)/2}(dif(i,1),78))/data.ff.numStr(i);
        end
    end
end
clear dif
tslen= lslen';
for i= 1: length(rslen)
    if rslen(i) == 0
        rslen(i) = NaN;
    end
end
tslen(2,:) = rslen';   
avgtslen= mean(tslen,1);

%this fills in any missing averages with the leg that is not missing data
for i= 1:length(avgtslen)
    if isnan(avgtslen(i))==1
        if isnan(rslen(i)) ==1
            avgtslen(i)=lslen(i,1);
        else
            avgtslen(i)=rslen(i,1);
        end
    end
end


% for i = 1:length(rslen)
%     avgtoestdlen = 

% for i=1:length(data.ff.FD)
%     if mod(i,2)
%         if isnan(max(data.ff.FD(i,:)) - min(data.ff.FD(i,:))) == 1 or max(data.ff.FD(i,:)) - min(data.ff.FD(i,:)) == 0
%             lslen((i+1)/2,1) = 0
%         else
%             lslen((i+1)/2,1) = (data.rotXYZ{1,(i+1)/2}(max(data.ff.FD((i+1)/2,:)),78)- data.rotXYZ{1,(i+1)/2}(min(data.ff.FD((i+1)/2,:)),78))//data.ff.numStr(i);
%         end
%      else
%          if isnan(max(data.ff.FD(i,:)) - min(data.ff.FD(i,:))) == 1 or max(data.ff.FD(i,:)) - min(data.ff.FD(i,:)) == 0
%             rslen((i+2)/2,1) = 0
%          else
%             rslen(i/2,1) = (data.rotXYZ{1,i/2}(max(data.ff.FD(i/2,:)),108)- data.rotXYZ{1,i/2}(min(data.ff.FD(i/2,:)),108))/data.ff.numStr(i);  
%          end
%     end
%     
% end
% % %this will find the average toe stride lenth for each leg and show where
% % %there is missing data
% % for trial = 1:n   
% %     rslen(trial) = (rtoe{1,trial}(max(data.ff.FD(trial*2,:)),1)-rtoe{1,trial}(min(data.ff.FD(trial*2,:)),1))/data.ff.numStr(trial*2);
% %     lslen(trial) = (ltoe{1,trial}(max(data.ff.FD((trial+(trial-1)),:)),1)-ltoe{1,trial}(min(data.ff.FD((trial+(trial-1)),:)),1))/data.ff.numStr(trial+(trial-1));
% %  if isnan(rslen(trial)) ==1
% %      fprintf('Debug here rslen(%d) \n', trial);
% %  end
% %  if isnan(lslen(trial)) == 1
% %     fprintf('Debug here lslen(%d)\n', trial);
% %  end
% % end
% %this gives us the average stride length for both legs
% tslen= lslen
% tslen(2,:) = rslen
% avgtslen= mean(tslen,1)
% 
% %this fills in any missing averages with the leg that is not missing data
% for i= 1:length(avgtslen)
%     if isnan(avgtslen(i))==1
%         if isnan(rslen(i)) ==1
%             avgtslen(i)=lslen(i)
%         else
%             avgtslen(i)=rslen(i)
%         end
%     end
% end

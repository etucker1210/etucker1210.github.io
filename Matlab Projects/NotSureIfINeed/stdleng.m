 numtrials = length(data.forcefname);
% %%
% STD = nan(2*numtrials,1);
% for i = 1:numtrials
%     FD = data.ff.FD(i*2-1:i*2,:)
%     for a= 1:3
%         if isnan(FD(1,a)) == 0 
%             lpos(a,:) = data.Back_middle{i}(FD(1,a),:);
%         end
%         if isnan(FD(2,a))== 0
%             rpos(a,:) = data.Back_middle{i}(FD(2,a),:);
%         end
%     end
%    difl = diff(lpos(:,1:3)).^2;
%    difr = diff(rpos(:,1:3)).^2;
%    for b = 1:size(difl,1)
%        STD(i*2-1,b) = sqrt(sum(difl(b,:)));
%    end
%    for c = 1:size(difr,1)
%        STD(i*2,c) = sqrt(sum(difr(c,:)));
%    end
%    clear *pos a b c dif* 
% end
%%
for i = 1:numtrials
    phasing(i,1) = find(data.KE{i}(:,1) == min(data.KE{i}(:,1)));
    phasing(i,2) = find(data.PE{i} == min(data.PE{i}));
    %percent difference for phasing
    phasing(i,3)= abs(phasing(i,1)-phasing(i,2))/size(data.KE{i},1)*100;
    
    velodif(i,1) = min(data.Utot.data{i}(:,1));
    velodif(i,2) = max(data.Utot.data{i}(:,1));
    %percent difference for phasing
    velodif(i,3)= (velodif(i,2)-velodif(i,1))/velodif(i,2) * 100;
end
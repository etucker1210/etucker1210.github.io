numtrials = length(data.forcefname);
% count = 1;
% for i= 1:numtrials    
%     if ~isempty(data.Back_anterior{i})
%         if strcmp(data.ff.treat(i*2),'Flat')
%          LFD = data.ff.FD(i*2-1,:);
%          RFD = data.ff.FD(i*2,:);
%             if sum(~ismissing(LFD))>1
%                 for j = 1:find(max(LFD)==LFD)-1
%                     strideL{j} = (0:LFD(j+1)-LFD(j))/(LFD(j+1)-LFD(j));
%                 end
%                 for r= 1:length(strideL)
%                     if ~ismissing(strideL{r})
%                     [pkshiprelf{count},lochiprelf{count}]=findpeaks(deglhiprel{i}(LFD(r):LFD(r+1)),strideL{r});
%                     [pkshipabsf{count},lochipabsf{count}]=findpeaks(deglhipabs{i}(LFD(r):LFD(r+1)),strideL{r});
%                     [pkskneef{count},lockneef{count}]=findpeaks(deglknee{i}(LFD(r):LFD(r+1)),strideL{r});
%                     [pksanklef{count},locanklef{count}]=findpeaks(deglankle{i}(LFD(r):LFD(r+1)),strideL{r});
%                     [pkstmpf{count},loctmpf{count}]=findpeaks(degltmp{i}(LFD(r):LFD(r+1)),strideL{r});
%                     [pkshiprelfmin{count},lochiprelfmin{count}]=findpeaks(-deglhiprel{i}(LFD(r):LFD(r+1)),strideL{r});
%                     [pkshipabsfmin{count},lochipabsfmin{count}]=findpeaks(-deglhipabs{i}(LFD(r):LFD(r+1)),strideL{r});
%                     [pkskneefmin{count},lockneefmin{count}]=findpeaks(-deglknee{i}(LFD(r):LFD(r+1)),strideL{r});
%                     [pksanklefmin{count},locanklefmin{count}]=findpeaks(-deglankle{i}(LFD(r):LFD(r+1)),strideL{r});
%                     [pkstmpfmin{count},loctmpfmin{count}]=findpeaks(-degltmp{i}(LFD(r):LFD(r+1)),strideL{r});
%                     count = count+1;
%                     end
%                 end
%             end
%             if sum(~ismissing(RFD))>1
%                 for h = 1:find(max(RFD)== RFD)-1
%                 strideR{h} = (0:RFD(h+1)-RFD(h))/(RFD(h+1)-RFD(h));
%                 end
%                 for k= 1:length(strideR)
%                     if ~ismissing(strideR{k})
%                     [pkshiprelf{count},lochiprelf{count}]=findpeaks(degrhiprel{i}(RFD(k):RFD(k+1)),strideR{k});
% %                     pkshiprelf(1:end,count) = num2cell(pkshiprelf{count});
% %                     lochiprelf(1:end,count)= num2cell(lochiprelf{count});
%                     [pkshipabsf{count},lochipabsf{count}]=findpeaks(degrhipabs{i}(RFD(k):RFD(k+1)),strideR{k});
%                     [pkskneef{count},lockneef{count}]=findpeaks(degrknee{i}(RFD(k):RFD(k+1)),strideR{k});
%                     [pksanklef{count},locanklef{count}]=findpeaks(degrankle{i}(RFD(k):RFD(k+1)),strideR{k});
%                     [pkstmpf{count},loctmpf{count}]=findpeaks(degrtmp{i}(RFD(k):RFD(k+1)),strideR{k});
%                     [pkshiprelfmin{count},lochiprelfmin{count}]=findpeaks(-degrhiprel{i}(RFD(k):RFD(k+1)),strideR{k});
%                     [pkshipabsfmin{count},lochipabsfmin{count}]=findpeaks(-degrhipabs{i}(RFD(k):RFD(k+1)),strideR{k});
%                     [pkskneefmin{count},lockneefmin{count}]=findpeaks(-degrknee{i}(RFD(k):RFD(k+1)),strideR{k});
%                     [pksanklefin{count},locanklefmin{count}]=findpeaks(-degrankle{i}(RFD(k):RFD(k+1)),strideR{k});
%                     [pkstmpfmin{count},loctmpfmin{count}]=findpeaks(-degrtmp{i}(RFD(k):RFD(k+1)),strideR{k});
%                     count = count+1;
%                     end
%                 end
%             end
%         end
%     end
% clear stride* LFD RFD
% end
% clear count h j k i r 
%%
maxpkshiprelf = nan(2,1);
maxpkshipabsf = nan(2,1);
maxpkskneef = nan(2,1);
maxpksanklef = nan(2,1);
maxpkstmpf = nan(2,1);
maxpkshiprelfmin = nan(2,1);
maxpkshipabsfmin = nan(2,1);
maxpkskneefmin = nan(2,1);
maxpksanklefmin = nan(2,1);
maxpkstmpfmin = nan(2,1);

for i = 1:length(pkskneef)
    if ~ismissing(pkshiprelf{i})
        maxpkshiprelf(1,i) = max(pkshiprelf{i});
        r = find(max(pkshiprelf{i}) == pkshiprelf{i});
        maxpkshiprelf(2,i) = lochiprelf{i}(r);
    end
    clear r
    if ~ismissing(pkshipabsf{i})
        maxpkshipabsf(1,i) = max(pkshipabsf{i});
        r = find(max(pkshipabsf{i}) == pkshipabsf{i});
        maxpkshipabsf(2,i) = lochipabsf{i}(r);
    end
    clear r
        if ~ismissing(pkskneef{i})
        maxpkskneef(1,i) = max(pkskneef{i});
        r = find(max(pkskneef{i}) == pkskneef{i});
        maxpkskneef(2,i) = lockneef{i}(r);
    end
    clear r
     if ~ismissing(pksanklef{i})
        maxpksanklef(1,i) = max(pksanklef{i});
        r = find(max(pksanklef{i}) == pksanklef{i});
        maxpksanklef(2,i) = locanklef{i}(r);
    end
    clear r
    if ~ismissing(pkstmpf{i})
        maxpkstmpf(1,i) = max(pkstmpf{i});
        r = find(max(pkstmpf{i}) == pkstmpf{i});
        maxpkstmpf(2,i) = loctmpf{i}(r);
    end
    clear r
     if ~ismissing(pkshiprelfmin{i})
        maxpkshiprelfmin(1,i) = max(pkshiprelfmin{i});
        r = find(max(pkshiprelfmin{i}) == pkshiprelfmin{i});
        maxpkshiprelfmin(2,i) = lochiprelfmin{i}(r);
    end
    clear r
    if ~ismissing(pkshipabsfmin{i})
        maxpkshipabsfmin(1,i) = max(pkshipabsfmin{i});
        r = find(max(pkshipabsfmin{i}) == pkshipabsfmin{i});
        maxpkshipabsfmin(2,i) = lochipabsfmin{i}(r);
    end
    clear r
        if ~ismissing(pkskneefmin{i})
        maxpkskneefmin(1,i) = max(pkskneefmin{i});
        r = find(max(pkskneefmin{i}) == pkskneefmin{i});
        maxpkskneefmin(2,i) = lockneefmin{i}(r);
    end
    clear r
     if ~ismissing(pksanklefmin{i})
        maxpksanklefmin(1,i) = max(pksanklefmin{i});
        r = find(max(pksanklefmin{i}) == pksanklefmin{i});
        maxpksanklefmin(2,i) = locanklefmin{i}(r);
    end
    clear r
    if ~ismissing(pkstmpfmin{i})
        maxpkstmpfmin(1,i) = max(pkstmpfmin{i});
        r = find(max(pkstmpfmin{i}) == pkstmpfmin{i});
        maxpkstmpfmin(2,i) = loctmpfmin{i}(r);
    end
    clear r
 end

%%
numtrials= length(data.forcefname);
count = 1;
for i = 1:numtrials
    if strcmp(data.ff.treat(i*2),'Drop')
        if ~ismissing(data.ff.forcestep(i*2))
         LFD = data.ff.FD(i*2-1,:);
         RFD = data.ff.FD(i*2,:);
         if strcmp(data.ff.forcefoot(i*2),'R')
            if sum(~ismissing(RFD))>1
               h = find(RFD== data.ff.forcestep(i*2,1));
               if h-1>0
                strideR{1} = (0:RFD(h)-RFD(h-1))/(RFD(h)-RFD(h-1));
                steps{1} = RFD(h-1):RFD(h);
               else strideR{1} = nan; steps{1} = nan;
               end
               if h+1 == find(max(RFD)==RFD)
                strideR{2} = (0:RFD(h+1) - RFD(h))/(RFD(h+1)-RFD(h))+1;
                steps{2} = RFD(h):RFD(h+1);
               else strideR{2}= nan; steps{2}= nan;
               end
               if ~ismissing(strideR{1})
                [pkshipreldin{count},lochipreldin{count}]=findpeaks(degrhiprel{i}(steps{1}),strideR{1});
                [pkshipabsdin{count},lochipabsdin{count}]=findpeaks(degrhipabs{i}(steps{1}),strideR{1});
                [pkskneedin{count},lockneedin{count}]=findpeaks(degrknee{i}(steps{1}),strideR{1});
                [pksankledin{count},locankledin{count}]=findpeaks(degrankle{i}(steps{1}),strideR{1});
                [pkstmpdin{count},loctmpdin{count}]=findpeaks(degrtmp{i}(steps{1}),strideR{1});
                [pkshipreldinmin{count},lochipreldinmin{count}]=findpeaks(-degrhiprel{i}(steps{1}),strideR{1});
                [pkshipabsdinmin{count},lochipabsdinmin{count}]=findpeaks(-degrhipabs{i}(steps{1}),strideR{1});
                [pkskneedinmin{count},lockneedinmin{count}]=findpeaks(-degrknee{i}(steps{1}),strideR{1});
                [pksankledinmin{count},locankledinmin{count}]=findpeaks(-degrankle{i}(steps{1}),strideR{1});
                [pkstmpdinmin{count},loctmpdinmin{count}]=findpeaks(-degrtmp{i}(steps{1}),strideR{1});
               end
               if ~ismissing(strideR{2})
                [pkshipreldout{count},lochipreldout{count}]=findpeaks(degrhiprel{i}(steps{2}),strideR{2});
                [pkshipabsdout{count},lochipabsdout{count}]=findpeaks(degrhipabs{i}(steps{2}),strideR{2});
                [pkskneedout{count},lockneedout{count}]=findpeaks(degrknee{i}(steps{2}),strideR{2});
                [pksankledout{count},locankledout{count}]=findpeaks(degrankle{i}(steps{2}),strideR{2});
                [pkstmpdout{count},loctmpdout{count}]=findpeaks(degrtmp{i}(steps{2}),strideR{2});
                [pkshipreldoutmin{count},lochipreldoutmin{count}]=findpeaks(-degrhiprel{i}(steps{2}),strideR{2});
                [pkshipabsdoutmin{count},lochipabsdoutmin{count}]=findpeaks(-degrhipabs{i}(steps{2}),strideR{2});
                [pkskneedoutmin{count},lockneedoutmin{count}]=findpeaks(-degrknee{i}(steps{2}),strideR{2});
                [pksankledoutmin{count},locankledoutmin{count}]=findpeaks(-degrankle{i}(steps{2}),strideR{2});
                [pkstmpdoutmin{count},loctmpdoutmin{count}]=findpeaks(-degrtmp{i}(steps{2}),strideR{2});
               end
               list(count,1) = data.
                count = count+1;
                 end
            clear steps stride*
         else
             if sum(~ismissing(LFD))>1
               j = find(LFD== data.ff.forcestep(i*2,1));
               if j-1 >0
                strideL{1} = (0:LFD(j)-LFD(j-1))/(LFD(j)-LFD(j-1));
                steps{1} = LFD(j-1):LFD(j);
               else strideL{1} = nan; steps{1} = nan;                
               end
               if j+1 == find(max(LFD)== LFD)
                strideL{2} = (0:LFD(j+1) - LFD(j))/(LFD(j+1)-LFD(j))+1;
                steps{2} = LFD(j):LFD(j+1);
               else strideL{2} = nan; steps{2} = nan;
               end
               if ~ismissing(strideL{1})
                [pkshipreldin{count},lochipreldin{count}]=findpeaks(deglhiprel{i}(steps{1}),strideL{1});
                [pkshipabsdin{count},lochipabsdin{count}]=findpeaks(deglhipabs{i}(steps{1}),strideL{1});
                [pkskneedin{count},lockneedin{count}]=findpeaks(deglknee{i}(steps{1}),strideL{1});
                [pksankledin{count},locankledin{count}]=findpeaks(deglankle{i}(steps{1}),strideL{1});
                [pkstmpdin{count},loctmpdin{count}]=findpeaks(degltmp{i}(steps{1}),strideL{1});
                [pkshipreldinmin{count},lochipreldinmin{count}]=findpeaks(-deglhiprel{i}(steps{1}),strideL{1});
                [pkshipabsdinmin{count},lochipabsdinmin{count}]=findpeaks(-deglhipabs{i}(steps{1}),strideL{1});
                [pkskneedinmin{count},lockneedinmin{count}]=findpeaks(-deglknee{i}(steps{1}),strideL{1});
                [pksankledinmin{count},locankledinmin{count}]=findpeaks(-deglankle{i}(steps{1}),strideL{1});
                [pkstmpdinmin{count},loctmpdinmin{count}]=findpeaks(-degltmp{i}(steps{1}),strideL{1});
               end
               if ~ismissing(strideL{2})
                [pkshipreldout{count},lochipreldout{count}]=findpeaks(deglhiprel{i}(steps{2}),strideL{2});
                [pkshipabsdout{count},lochipabsdout{count}]=findpeaks(deglhipabs{i}(steps{2}),strideL{2});
                [pkskneedout{count},lockneedout{count}]=findpeaks(deglknee{i}(steps{2}),strideL{2});
                [pksankledout{count},locankledout{count}]=findpeaks(deglankle{i}(steps{2}),strideL{2});
                [pkstmpdout{count},loctmpdout{count}]=findpeaks(degltmp{i}(steps{2}),strideL{2});
                [pkshipreldoutmin{count},lochipreldoutmin{count}]=findpeaks(-deglhiprel{i}(steps{2}),strideL{2});
                [pkshipabsdoutmin{count},lochipabsdoutmin{count}]=findpeaks(-deglhipabs{i}(steps{2}),strideL{2});
                [pkskneedoutmin{count},lockneedoutmin{count}]=findpeaks(-deglknee{i}(steps{2}),strideL{2});
                [pksankledoutmin{count},locankledoutmin{count}]=findpeaks(-deglankle{i}(steps{2}),strideL{2});
                [pkstmpdoutmin{count},loctmpdoutmin{count}]=findpeaks(-degltmp{i}(steps{2}),strideL{2});
               end
                count = count+1;
              end
            end
         end
    end
        clear steps stride* h j k r *FD
end
%%
for i = 1:length(pkskneedin)
    if ~ismissing(pkshipreldin{i})
        maxpkshipreldin(1,i) = max(pkshipreldin{i});
        r = find(max(pkshipreldin{i}) == pkshipreldin{i});
        maxpkshipreldin(2,i) = lochipreldin{i}(r);
    end
    clear r
    if ~ismissing(pkshipabsdin{i})
        maxpkshiprabsdin(1,i) = max(pkshipabsdin{i});
        r = find(max(pkshipabsdin{i}) == pkshipabsdin{i});
        maxpkshiprabsdin(2,i) = lochipabsdin{i}(r);
    end
    clear r
        if ~ismissing(pkskneedin{i})
        maxpkskneedin(1,i) = max(pkskneedin{i});
        r = find(max(pkskneedin{i}) == pkskneedin{i});
        maxpkskneedin(2,i) = lockneedin{i}(r);
    end
    clear r
     if ~ismissing(pksankledin{i})
        maxpksankledin(1,i) = max(pksankledin{i});
        r = find(max(pksankledin{i}) == pksankledin{i});
        maxpksankledin(2,i) = locankledin{i}(r);
    end
    clear r
    if ~ismissing(pkstmpdin{i})
        maxpkstmpdin(1,i) = max(pkstmpdin{i});
        r = find(max(pkstmpdin{i}) == pkstmpdin{i});
        maxpkstmpdin(2,i) = loctmpdin{i}(r);
    end
    clear r
     if ~ismissing(pkshipreldinmin{i})
        maxpkshipreldinmin(1,i) = max(pkshipreldinmin{i});
        r = find(max(pkshipreldinmin{i}) == pkshipreldinmin{i});
        maxpkshipreldinmin(2,i) = lochipreldinmin{i}(r);
    end
    clear r
    if ~ismissing(pkshipabsdoutmin{i})
        maxpkshiprabsdinmin(1,i) = max(pkshipabsdoutmin{i});
        r = find(max(pkshipabsdoutmin{i}) == pkshipabsdoutmin{i});
        maxpkshiprabsdinmin(2,i) = lochipabsdoutmin{i}(r);
    end
    clear r
        if ~ismissing(pkskneedinmin{i})
        maxpkskneedinmin(1,i) = max(pkskneedinmin{i});
        r = find(max(pkskneedinmin{i}) == pkskneedinmin{i});
        maxpkskneedinmin(2,i) = lockneedinmin{i}(r);
    end
    clear r
    
    if ~ismissing(pkshipreldout{i})
        maxpkshipreldout(1,i) = max(pkshipreldout{i});
        r = find(max(pkshipreldout{i}) == pkshipreldout{i});
        maxpkshipreldout(2,i) = lochipreldout{i}(r);
    end
    clear r
    if ~ismissing(pkshipabsdin{i})
        maxpkshipabsdin(1,i) = max(pkshipabsdin{i});
        r = find(max(pkshipabsdin{i}) == pkshipabsdin{i});
        maxpkshipabsdin(2,i) = lochipabsdin{i}(r);
    end
    clear r
        if ~ismissing(pkskneedout{i})
        maxpkskneedout(1,i) = max(pkskneedout{i});
        r = find(max(pkskneedout{i}) == pkskneedout{i});
        maxpkskneedout(2,i) = lockneedout{i}(r);
    end
    clear r
     if ~ismissing(pksankledout{i})
        maxpksankledout(1,i) = max(pksankledout{i});
        r = find(max(pksankledout{i}) == pksankledout{i});
        maxpksankledout(2,i) = locankledout{i}(r);
    end
    clear r
    if ~ismissing(pkstmpdout{i})
        maxpkstmpdout(1,i) = max(pkstmpdout{i});
        r = find(max(pkstmpdout{i}) == pkstmpdout{i});
        maxpkstmpdout(2,i) = loctmpdout{i}(r);
    end
    clear r
     if ~ismissing(pkshipreldoutmin{i})
        maxpkshipreldoutmin(1,i) = max(pkshipreldoutmin{i});
        r = find(max(pkshipreldoutmin{i}) == pkshipreldoutmin{i});
        maxpkshipreldoutmin(2,i) = lochipreldoutmin{i}(r);
    end
    clear r
    if ~ismissing(pkshipabsdinmin{i})
        maxpkshipabsdinmin(1,i) = max(pkshipabsdinmin{i});
        r = find(max(pkshipabsdinmin{i}) == pkshipabsdinmin{i});
        maxpkshipabsdinmin(2,i) = lochipabsdinmin{i}(r);
    end
    clear r
        if ~ismissing(pkskneedoutmin{i})
        maxpkskneedoutmin(1,i) = max(pkskneedoutmin{i});
        r = find(max(pkskneedoutmin{i}) == pkskneedoutmin{i});
        maxpkskneedoutmin(2,i) = lockneedoutmin{i}(r);
    end
    clear r
     if ~ismissing(pksankledoutmin{i})
        maxpksankledoutmin(1,i) = max(pksankledoutmin{i});
        r = find(max(pksankledoutmin{i}) == pksankledoutmin{i});
        maxpksankledoutmin(2,i) = locankledoutmin{i}(r);
    end
    clear r
    if ~ismissing(pkstmpdoutmin{i})
        maxpkstmpdoutmin(1,i) = max(pkstmpdoutmin{i});
        r = find(max(pkstmpdoutmin{i}) == pkstmpdoutmin{i});
        maxpkstmpdoutmin(2,i) = loctmpdoutmin{i}(r);
    end
    clear r
     if ~ismissing(pksankledinmin{i})
        maxpksankledinmin(1,i) = max(pksankledinmin{i});
        r = find(max(pksankledinmin{i}) == pksankledinmin{i});
        maxpksankledinmin(2,i) = locankledinmin{i}(r);
    end
    clear r
    if ~ismissing(pkstmpdinmin{i})
        maxpkstmpdinmin(1,i) = max(pkstmpdinmin{i});
        r = find(max(pkstmpdinmin{i}) == pkstmpdinmin{i});
        maxpkstmpdinmin(2,i) = loctmpdinmin{i}(r);
    end
    clear r
 end
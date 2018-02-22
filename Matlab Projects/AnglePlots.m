% Create plots
numtrials = length(data.forcefname);
for i= 1:numtrials
    if ~isempty(data.Back_anterior{i})
        if strcmp(data.ff.treat(i*2),'Flat')
         LFD = data.ff.FD(i*2-1,:);
         RFD = data.ff.FD(i*2,:);
            if sum(~ismissing(LFD))>1
                for j = 1:find(max(LFD)==LFD)-1
                    strideL{j} = (0:LFD(j+1)-LFD(j))/(LFD(j+1)-LFD(j));
                end
                for r= 1:length(strideL)
                    if ~ismissing(strideL{r})
%             %      for r = 1:length(r(~isnan(r)))
                   plot(strideL{r},deglhiprel{i}(LFD(r):LFD(r+1))); ylabel('HipRel Angle Degrees');
                   hold on
                end
            end
            if sum(~ismissing(RFD))>1
                for h = 1:find(max(RFD)== RFD)-1
                strideR{h} = (0:RFD(h+1)-RFD(h))/(RFD(h+1)-RFD(h));
                end
                for k= 1:length(strideR)
                    if ~ismissing(strideR{k})
        %      for r = 1:length(r(~isnan(r)))
               plot(strideR{k},degrhiprel{i}(RFD(k):RFD(k+1)));
               hold on
                    end
                end
            end
        end
    end
clear stride* LFD RFD
    end
end
figure;
for i= 1:numtrials
    if ~isempty(data.Back_anterior{i})
        if strcmp(data.ff.treat(i*2),'Flat')
         LFD = data.ff.FD(i*2-1,:);
         RFD = data.ff.FD(i*2,:);
            if sum(~ismissing(LFD))>1
                for j = 1:find(max(LFD)==LFD)-1
                    strideL{j} = (0:LFD(j+1)-LFD(j))/(LFD(j+1)-LFD(j));
                end
                for r= 1:length(strideL)
                    if ~ismissing(strideL{r})
%             %      for r = 1:length(r(~isnan(r)))
                   plot(strideL{r},deglhipabs{i}(LFD(r):LFD(r+1))); ylabel('HipAbs Angle Degrees');
                   hold on
                end
            end
            if sum(~ismissing(RFD))>1
                for h = 1:find(max(RFD)== RFD)-1
                strideR{h} = (0:RFD(h+1)-RFD(h))/(RFD(h+1)-RFD(h));
                end
                for k= 1:length(strideR)
                    if ~ismissing(strideR{k})
        %      for r = 1:length(r(~isnan(r)))
               plot(strideR{k},degrhipabs{i}(RFD(k):RFD(k+1)));
               hold on
                    end
                end
            end
        end
    end
clear stride* LFD RFD
    end
end
figure;
for i= 1:numtrials
    if ~isempty(data.Back_anterior{i})
        if strcmp(data.ff.treat(i*2),'Flat')
         LFD = data.ff.FD(i*2-1,:);
         RFD = data.ff.FD(i*2,:);
            if sum(~ismissing(LFD))>1
                for j = 1:find(max(LFD)==LFD)-1
                    strideL{j} = (0:LFD(j+1)-LFD(j))/(LFD(j+1)-LFD(j));
                end
                for r= 1:length(strideL)
                    if ~ismissing(strideL{r})
%             %      for r = 1:length(r(~isnan(r)))
                   plot(strideL{r},deglknee{i}(LFD(r):LFD(r+1))); ylabel('Knee Angle Degrees');
                   hold on
                end
            end
            if sum(~ismissing(RFD))>1
                for h = 1:find(max(RFD)== RFD)-1
                strideR{h} = (0:RFD(h+1)-RFD(h))/(RFD(h+1)-RFD(h));
                end
                for k= 1:length(strideR)
                    if ~ismissing(strideR{k})
        %      for r = 1:length(r(~isnan(r)))
               plot(strideR{k},degrknee{i}(RFD(k):RFD(k+1)));
               hold on
                    end
                end
            end
        end
    end
clear stride* LFD RFD
    end
end
figure;
for i= 1:numtrials
    if ~isempty(data.Back_anterior{i})
        if strcmp(data.ff.treat(i*2),'Flat')
         LFD = data.ff.FD(i*2-1,:);
         RFD = data.ff.FD(i*2,:);
            if sum(~ismissing(LFD))>1
                for j = 1:find(max(LFD)==LFD)-1
                    strideL{j} = (0:LFD(j+1)-LFD(j))/(LFD(j+1)-LFD(j));
                end
                for r= 1:length(strideL)
                    if ~ismissing(strideL{r})
%             %      for r = 1:length(r(~isnan(r)))
                   plot(strideL{r},deglankle{i}(LFD(r):LFD(r+1))); ylabel('Ankle Angle Degrees');
                   hold on
                end
            end
            if sum(~ismissing(RFD))>1
                for h = 1:find(max(RFD)== RFD)-1
                strideR{h} = (0:RFD(h+1)-RFD(h))/(RFD(h+1)-RFD(h));
                end
                for k= 1:length(strideR)
                    if ~ismissing(strideR{k})
        %      for r = 1:length(r(~isnan(r)))
               plot(strideR{k},degrankle{i}(RFD(k):RFD(k+1)));
               hold on
                    end
                end
            end
        end
    end
clear stride* LFD RFD
    end
end
figure;
for i= 1:numtrials
    if ~isempty(data.Back_anterior{i})
        if strcmp(data.ff.treat(i*2),'Flat')
         LFD = data.ff.FD(i*2-1,:);
         RFD = data.ff.FD(i*2,:);
            if sum(~ismissing(LFD))>1
                for j = 1:find(max(LFD)==LFD)-1
                    strideL{j} = (0:LFD(j+1)-LFD(j))/(LFD(j+1)-LFD(j));
                end
                for r= 1:length(strideL)
                    if ~ismissing(strideL{r})
%             %      for r = 1:length(r(~isnan(r)))
                   plot(strideL{r},degltmp{i}(LFD(r):LFD(r+1))); ylabel('TMP Angle Degrees');
                   hold on
                end
            end
            if sum(~ismissing(RFD))>1
                for h = 1:find(max(RFD)== RFD)-1
                strideR{h} = (0:RFD(h+1)-RFD(h))/(RFD(h+1)-RFD(h));
                end
                for k= 1:length(strideR)
                    if ~ismissing(strideR{k})
        %      for r = 1:length(r(~isnan(r)))
               plot(strideR{k},degrtmp{i}(RFD(k):RFD(k+1)));
               hold on
                    end
                end
            end
        end
    end
clear stride* LFD RFD
    end
end
figure;
clear r j k i h 

%%
color = ['k' 'r'];
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
               for k= 1:length(strideR)
                if ~ismissing(strideR{k})
        %      for r = 1:length(r(~isnan(r)))
                plot(strideR{k},degrhiprel{i}(steps{k}), color(k)); ylabel('Hiprel angle degrees Drop');
                hold on
                end  
              end
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
              for r= 1:length(strideL)
                if ~ismissing(strideL{r})
        %      for r = 1:length(r(~isnan(r)))
                plot(strideL{r},deglhiprel{i}(steps{r}), color(r));
                hold on
                end  
              end
            end
         end
        end
    end
    clear steps stride* h j k r *FD
end
figure;
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
               for k= 1:length(strideR)
                if ~ismissing(strideR{k})
        %      for r = 1:length(r(~isnan(r)))
                plot(strideR{k},degrhipabs{i}(steps{k}), color(k)); ylabel('Hipabs angle degrees Drop');
                hold on
                end  
              end
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
              for r= 1:length(strideL)
                if ~ismissing(strideL{r})
        %      for r = 1:length(r(~isnan(r)))
                plot(strideL{r},deglhipabs{i}(steps{r}), color(r));
                hold on
                end  
              end
            end
         end
        end
    end
    clear steps stride* h j k r *FD
end
figure;
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
               for k= 1:length(strideR)
                if ~ismissing(strideR{k})
        %      for r = 1:length(r(~isnan(r)))
                plot(strideR{k},degrknee{i}(steps{k}), color(k)); ylabel('Knee angle degrees Drop');
                hold on
                end  
              end
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
              for r= 1:length(strideL)
                if ~ismissing(strideL{r})
        %      for r = 1:length(r(~isnan(r)))
                plot(strideL{r},deglknee{i}(steps{r}), color(r));
                hold on
                end  
              end
            end
         end
        end
    end
    clear steps stride* h j k r *FD
end
figure;
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
               for k= 1:length(strideR)
                if ~ismissing(strideR{k})
        %      for r = 1:length(r(~isnan(r)))
                plot(strideR{k},degrankle{i}(steps{k}), color(k)); ylabel('Ankle angle degrees Drop');
                hold on
                end  
              end
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
              for r= 1:length(strideL)
                if ~ismissing(strideL{r})
        %      for r = 1:length(r(~isnan(r)))
                plot(strideL{r},deglankle{i}(steps{r}), color(r));
                hold on
                end  
              end
            end
         end
        end
    end
    clear steps stride* h j k r *FD
end
figure;
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
               for k= 1:length(strideR)
                if ~ismissing(strideR{k})
        %      for r = 1:length(r(~isnan(r)))
                plot(strideR{k},degrtmp{i}(steps{k}), color(k)); ylabel('Tmp angle degrees Drop');
                hold on
                end  
              end
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
              for r= 1:length(strideL)
                if ~ismissing(strideL{r})
        %      for r = 1:length(r(~isnan(r)))
                plot(strideL{r},degltmp{i}(steps{r}), color(r));
                hold on
                end  
              end
            end
         end
        end
    end
    clear steps stride* h j k r *FD
end
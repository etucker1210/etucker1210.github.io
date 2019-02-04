%%This will make the tdangle to Body angle graph that I want.
numtrials = length(data.forcefname);

%%first I need to bring in all the footfalls and body angles.
%%

for i = 1:numtrials
    if strcmp(data.ff.treat(i*2),'Flat')
        FD = data.ff.FD(i*2-1:i*2,:);
        for j = 1:2
            for t = 1:size(FD,2)
                if j == 1
                    if ~isnan(FD(j,t))
                        bodyanglep= data.LowerBackskb{i}(FD(j,t),1);
                        bodyangley= data.LowerBackskb{i}(FD(j,t),2);
                        bodyangler = data.LowerBackskb{i}(FD(j,t),3);
                    end
                else
                    if ~isnan(FD(j,t))
                       
                        bodyanglep= data.LowerBackskb{i}(FD(j,t),1);
                        bodyangley= data.LowerBackskb{i}(FD(j,t),2);
                        bodyangler = data.LowerBackskb{i}(FD(j,t),3);
                    else
%                         temphip= NaN;
%                         temptoe = NaN;
%                         bodyanglepitch= NaN;
%                         bodyangleyaw= NaN;
%                         bodyangleroll = NaN;
                    end
                end
                bodyanglepitch(i) = nanmean(bodyanglep);
                bodyangleyaw(i) = nanmean(bodyangley);
                bodyangleroll(i) = nanmean(bodyangler);           
            end
        end
    else
            FD = data.ff.forcestep(i*2,1);
            foot = data.ff.forcefoot(i*2);
            if ~isnan(FD)
                  bodyanglep= data.LowerBackskb{i}(FD,1);
          
                 bodyangley= data.LowerBackskb{i}(FD,2);
                 bodyangler = data.LowerBackskb{i}(FD,3);
               
            end
                bodyanglepitch(i) = nanmean(bodyanglep);
                bodyangleyaw(i) = nanmean(bodyangley);
                bodyangleroll(i) = nanmean(bodyangler);  
    end
    clear temp* FD FO foot td* 
end
   
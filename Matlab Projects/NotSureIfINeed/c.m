numTrials = length(data.forcefname)
fps=500
for trial = 1:2:2*numTrials
    FD          =   data.ff.FD(trial:trial+1,:);
    FO          =   data.ff.FO(trial:trial+1,:);
    % Check that FD and FO have the same number of columns
    if size(FD,2) ~= size(FO,2)
        FD      =   FD(:,1:min([size(FD,2) size(FO,2)]));
        FO      =   FO(:,1:min([size(FD,2) size(FO,2)]));
    end
    
    numStr(1)   =   length(find(~isnan(FD(1,:))))-1;
    numStr(2)   =   length(find(~isnan(FD(2,:))))-1;

    % duty factor calculation
    stride      =   diff(FD,[],2);
    stance      =   FO-FD;
    DF          =   stance(:,1:size(stride,2))./stride;
    data.DF((trial+1)/2,1)    =   nanmean(reshape(DF,numel(DF),1));
    clear temp
    
    % stride frequency calculation
    tStr(1)     =   (max(FD(1,:)) - min(FD(1,:)))/fps;
    tStr(2)     =   (max(FD(2,:)) - min(FD(2,:)))/fps;
    sFreq       =   numStr./tStr;
    data.sFreq((trial+1)/2,1)     =   nanmean(reshape(sFreq,numel(sFreq),1));
    
    % stride length calculation based on same leg ankle to ankle 2D distance
    if sum(isnan(FD(2,:))) <= .5*length(FD(2,:)) %this may not necessairly be the best idea.  it is really only a problem if more than one is nan
        Rpos        =   data.R_ankle{(trial+1)/2}([min(FD(2,:)) max(FD(2,:))],:);
        RsLen       =   sqrt(sum(diff(Rpos(:,1:2)).^2))/numStr(2);
    else
        Rpos = 0;
        RsLen = 0;
    end
        
    Lpos        =   data.L_ankle{(trial+1)/2}([min(FD(1,:)) max(FD(1,:))],:);
   if isnan(Lpos(1,1)) == 1
%        Lpos(1,:) = L_ankle{(trial+1)/2}(FD(1,2),:)
   end
    LsLen       =   sqrt(sum(diff(Lpos(:,1:2)).^2))/numStr(1);
%     RsLen       =   sqrt(sum(diff(Rpos(:,1:2)).^2))/numStr(2);
    data.LsLen((trial+1)/2,1)	=   LsLen;  % trial average
    data.RsLen((trial+1)/2,1)   =   RsLen;  % trial average
    data.Rpos = Rpos;
    data.Lpos = Lpos;
    clear pos Rpos Lpos
    
    % step width calculation
    
    Lpos        =   L_ankle{(trial+1)/2}(FD(1,~isnan(FD(1,:))),1:2);
%     if isnan(Lpos(1,1)) == 1
%        Lpos(1,:) = L_ankle{(trial+1)/2}(FD(1,2),:)
%    end
    Rpos        =   R_ankle{(trial+1)/2}(FD(2,~isnan(FD(2,:))),1:2);
    % shorten to the short length if these are of different lengths
    if numel(Rpos) ~= 0
        if size(Lpos,1) ~= size(Rpos,1)
            Lpos    =   Lpos(1:min([size(Lpos,1) size(Rpos,1)]),:);
            Rpos    =   Rpos(1:min([size(Lpos,1) size(Rpos,1)]),:);
            sWidth     =   sqrt(sum((Lpos-Rpos).^2,2))';
            data.sWidth((trial+1)/2,1)  =   nanmean(sWidth);
        end
        else
            sWidth     =   sqrt(sum((Lpos).^2,2))';
            data.sWidth((trial+1)/2,1)  =   nanmean(sWidth);
    end
end
titles = {'file name', 'mass (g)','Treatment', 'Utot', 'Utot stdev', 'mean duty factor',...
    'stride frequency', 'stride length (l) trial avg', 'stride length (R) trial avg','average toe stride length', ...
    'Max Fx (N)', 'Max Fy (N)','Max Fz (N)','Force Impulse X','Force Impulse Y', 'Force Impulse Z', 'Total force impulse',...
    'Xzang Imp','Yzang Imp','Svl (mm)', 'TDAng XZ','TDAng YZ','TDAng total','Stride Length  toe(L)', 'Stride Length toe(R)','COM Stride Length', ...
    'Stride in','Stride Out', 'Opposite', 'DeltKEx','DeltKEy','DeltKEz','DeltPE','DeltEcom', 'Kinematic'};

numtrials = length(data.forcefname);

%Get average toe stride length
%this will grab the toe points from whatever data has been processed
% for some reason number of strides is off by one

strides = data.ff.numStr +1

rslen= NaN(numtrials,1);
lslen = NaN(numtrials,1);
for i = 1: length(data.ff.FD)%should change this
    dif(i,1) = min(data.ff.FD(i,:));
    dif(i,2) = max(data.ff.FD(i,:));
    if sum(isnan(dif(i,:)))>0
        dif(i,:) = 0;
        if mod(i,2) == 0
            rslen(i/2,1) = NaN;
        else 
            lslen((i+1)/2,1) = NaN;
        end
    else
        if mod(i,2) == 0
            if isempty(data.R_toe{1,i/2})==0
                rpos = data.R_toe{1,i/2}([dif(i,1) dif(i,2)],:)
                rslen(i/2,1) = sqrt(sum(diff(rpos(:,1:3)).^2))/strides(i);
            end
        else 
            if isempty(data.L_toe{1,(i+1)/2})==0
                lpos = data.L_toe{1,(i+1)/2}([dif(i,1) dif(i,2)],:)
                lslen((i+1)/2,1) = sqrt(sum(diff(lpos(:,1:3)).^2))/strides(i);
            end
        end
    end
end

tslen= lslen';
% for i= 1: length(rslen)
%     if rslen(i) == 0
%         rslen(i) = NaN;
%     end
% end
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
 avgtslen = avgtslen';
%this calculates the COM stride length off of the back middle point.
for i = 1:numtrials
    if isempty(data.Back_middle{i})==0
    lpos= data.Back_middle{i}([dif(i*2-1,1) dif(i*2-1,2)],:);
    len(1,i)=sqrt(sum(diff(lpos(:,1:3)).^2))/strides(i*2-1);
    if dif(i*2,1) == 0
        rpos = NaN;
        len(2,1) = NaN;
    else
        rpos= data.Back_middle{i}([dif(i*2,1) dif(i*2,2)],:);
        len(2,i)=sqrt(sum(diff(rpos(:,1:3)).^2))/strides(i*2);
    end
    end
end
comlen = mean(len,1);
clear dif rpos lpos

%% Pull force data
ForcePeak = NaN(numtrials,3);
for trial = 1: length(data.forcefname)
    
switch data.ff.forcefoot{trial*2}
    case 'L'
        ForcePeak(trial,1) = data.FxPeak(trial);
        ForcePeak(trial,2) = abs(data.FyMin(trial));
        ForcePeak(trial,3) = data.FzPeak(trial);
    case 'R'
        ForcePeak(trial,1) = data.FxPeak(trial);
        ForcePeak(trial,2) = abs(data.FyPeak(trial));
        ForcePeak(trial,3) = data.FzPeak(trial);
end
end

%% Get Force impulse angle data
xzang = NaN(numtrials,1);
yzang= NaN(numtrials,1);
for i = 1:length(data.forcefname)
    xzang(i,1) = Angle2Horiz([data.Fimp(i,1),0,data.Fimp(i,3)]);
    yzang(i,1) = Angle2Horiz([data.Fimp(i,2),0,data.Fimp(i,3)]);

end

%%td angle recalculated

for i = 1: length(data.forcefname)
    if isempty(data.L_hip{i})==0 && isempty(data.R_hip{i}) ==0
        if strcmp(data.ff.forcefoot(i*2,1), 'L')
            %left toex 78  hip is 51
            temphip = data.L_hip{1,i}(data.ff.forcestep(i*2),:);
            temptoe = data.L_toe{1,i}(data.ff.forcestep(i*2),:);
        elseif strcmp(data.ff.forcefoot(i*2,1),'R')
            temphip = data.R_hip{1,i}(data.ff.forcestep(i*2),:);
            temptoe = data.R_toe{1,i}(data.ff.forcestep(i*2),:);
        else
            temphip = NaN(1,3);
            temptoe = NaN(1,3);
        end
        tdang(i,1) = Angle2Horiz([temphip(1),0,temphip(3)],[temptoe(1),0,temptoe(3)]);
        tdang(i,2) = Angle2Horiz([0,temphip(2),temphip(3)],[0,temptoe(2),temptoe(3)]);
        tdang(i,3) = Angle2Horiz(temphip,temptoe);
   clear temp*
    else tdang(i,1:3) = NaN;
    end
end
%The goal of this script is to gain individual kinematic data for each of
%the strides.  This will include stride length, duty factor, 
numtrials = length(data.forcefname);

%%
%This will calculate the stride length of the stride going into the drop
%and then after the drop.  
% for trial = 1: numtrials
% %     figure('NumberTitle','off','Name',data.ff.ufnames{trial});
% %        plotUglyFF(data.ff.FD((trial*2-1):(trial*2),:),data.ff.FO((trial*2-1):(trial*2),:))
% %        hold on 
% %         line(repmat(data.ff.forcestep(trial*2,1),1,2),repmat(ylim,1,1));
% %         line(repmat(data.ff.forcestep(trial*2,2),1,2),repmat(ylim,1,1));
% %        hold off
%     if strcmp(data.ff.forcefoot(trial*2),'R')
%         temp = isnan(data.ff.FD(trial*2,:))
%         if isnan(data.ff.FD(trial*2-1,:))== 0
%             lpos= data.L_toe{trial}([data.ff.FD(trial*2-1,3) data.ff.FD(trial*2-1,2)],:);
%           
%         else
%             %think about how this might get fucked up
%             lpos= data.L_toe{trial}([min(data.ff.FD(trial*2-1,:)) max(data.ff.FD(trial*2-1,:))],:);
%         end
%         
%         rpos = nan(3,3);
%         if sum(temp) == 0
%             rpos = data.R_toe{trial}([repmat(data.ff.FD(trial*2,:),1,1)],:)
%         else
%             for i = 1:3
%                 if temp(i) ==  0
%                     rpos(i,:) = data.R_toe{trial}([repmat(data.ff.FD(trial*2,i),1,1)],:);
%                 
%                 end
%             end
%         end
%         
%         stdin(trial) = sqrt(sum(diff(rpos(1:2,1:3))).^2);
%         stdout(trial) = sqrt(sum(diff(rpos(2:3,1:3))).^2);
%         oppos (trial) = sqrt(sum(diff(lpos(:,1:3))).^2);
%         clear lpos rpos temp
%     
%     else 
%         temp = isnan(data.ff.FD(trial*2-1,:));
%         if sum(isnan(data.ff.FD(trial*2,:)))== 0
%             rpos= data.R_toe{trial}([data.ff.FD(trial*2,3) data.ff.FD(trial*2,2)],:);
%           
%         elseif sum(isnan(data.ff.FD(trial*2,:)))==3
%             rpos=nan(2,3);
%         else
%             
%             %think about how this might get fucked up
%             rpos= data.R_toe{trial}([min(data.ff.FD(trial*2,:)) max(data.ff.FD(trial*2,:))],:);
%         end
%         
%         lpos = nan(3,3);
%         if sum(temp) == 0
%             lpos = data.L_toe{trial}([repmat(data.ff.FD(trial*2-1,:),1,1)],:)
%         else
%             for i = 1:3
%                 if temp(i) & isempty(data.L_toe{trial}) ==  0
%                     lpos(i,:) = data.L_toe{trial}([repmat(data.ff.FD(trial*2-1,i),1,1)],:);
%                 end
%             end
%         end
%         
%     stdin(trial) = sqrt(sum(diff(lpos(1:2,1:3))).^2);
%     stdout(trial) = sqrt(sum(diff(lpos(2:3,1:3))).^2);
%     oppos (trial) = sqrt(sum(diff(rpos(:,1:3))).^2);
%     clear lpos rpos temp
%         
%     end
%     % duty factor Pull FD and FO
% FD = data.ff.FD(trial*2-1:trial*2,:);
% FO = data.ff.FO(trial*2-1:trial*2,:);
% end
%% Change in KE PE
% Delt = nan(length(data.forcefname),5);
% for i = 1: length(data.forcefname)
%      deltKE = data.KE{i}(end,1:3)-data.KE{i}(1,1:3);
%      deltPE = data.PE{i}(end,1) - data.PE{i}(1,1);
%      Etot        =   sum([data.KE{i}(:,1:3),data.PE{i}],2);
%      deltEtot = Etot(end,1)-Etot(1,1);
%      Delt(i,1:3) = deltKE;
%      Delt(i,4) = deltPE;
%      Delt(i,5) = deltEtot;
%      clear delt*
% end


    i = length(data.forcefname)+1;
    
    things = titles;
    things (2:i,1) = data.forcefname';
    things (2:i,2) = data.ff.raw(2:2:end,3);
    things (2:i,3) = data.ff.treat(1:2:end,1);
    things (2:i,4:5) = num2cell(data.Utot.mean);
    things (2:i,6) = num2cell(data.DF(:,1));
    things (2:i,7) = num2cell(data.sFreq(:,1));
    things (2:i,8) = num2cell(data.LsLen(:,1));
    things (2:i,9) = num2cell(data.RsLen(:,1));
    things (2:i,10) = num2cell(avgtslen(:,1));
    things (2:i,11) = num2cell(ForcePeak(:,1));
    things (2:i,12) = num2cell(ForcePeak(:,2));
    things (2:i,13) =num2cell(ForcePeak(:,3));
    things(2:i,14:17) = num2cell(data.Fimp);
    things(2:i,18) = num2cell(xzang);
    things(2:i,19) = num2cell(yzang);
    things(2:i,20)= num2cell(data.ff.svl(1:2:end,:)); 
    things(2:i,21:23) = num2cell(tdang);
    things(2:i,24) = num2cell(lslen);
    things(2:i,25) = num2cell(rslen);
    things(2:i,26) =num2cell(comlen');
%     things(2:i,27) = num2cell(stdin');
%     things(2:i,28) = num2cell(stdout');
%     things(2:i,29) = num2cell(oppos');
%     things(2:i,30:34) = num2cell(Delt);
    things(2:i,35) = data.ff.kinematic(1:2:end,1);
data.forcepeak = ForcePeak;
data.avgtstdlen =  avgtslen;
data.tdangliz =tdang;
data.fimpxzang = xzang;
data.fimpyzang = yzang;

path = 'C:\Users\Liz\Desktop\DataLarge'    
clear ForcePeak i *len *trial* *ang titles   avg* *ang std* oppos
cd(path)
% xlswrite('Data_Variables.xlsx',things);

titles = {'file name', 'mass (g)','Treatment', 'Utot', 'Utot stdev', 'mean duty factor',...
    'stride frequency', 'stride length (l) trial avg', 'stride length (R) trial avg','average toe stride length', ...
    'Max Fx (N)', 'Max Fy (N)','Max Fz (N)','Force Impulse X','Force Impulse Y', 'Force Impulse Z', 'Total force impulse',...
    'Xzang Imp','Yzang Imp','Svl (mm)', 'TDAng XZ','TDAng YZ','TDAng total','Stride Length  toe(L)', 'Stride Length toe(R)','COM Stride Length'};

numtrials = length(data.forcefname);

%Get average toe stride length
%this will grab the toe points from whatever data has been processed
 for i = 1:length(data.ff.FD)
dif(i,1) = min(data.ff.FD(i,:));
dif(i,2) = max(data.ff.FD(i,:));

 end
for i = 1: length(data.ff.FD)%should change this
    if sum(isnan(dif(i,:)))>0
        dif(i,:) = 0;
        if mod(i,2) == 0
            rslen(i/2,1) = 0;
        else 
            lslen((i+1)/2,1) = 0;
        end
    else
        if mod(i,2) == 0
            rpos = data.R_toe{1,i/2}([dif(i,1) dif(i,2)],:)
            rslen(i/2,1) = sqrt(sum(diff(rpos(:,1:3)).^2))/data.ff.numStr(i);
        else 
            lpos = data.L_toe{1,(i+1)/2}([dif(i,1) dif(i,2)],:)
            lslen((i+1)/2,1) = sqrt(sum(diff(lpos(:,1:3)).^2))/data.ff.numStr(i);
        end
    end
end

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
avgtslen = avgtslen';
%this calculates the COM stride length off of the back middle point.
for i = 1:numtrials
    lpos= data.Back_middle{i}([dif(i*2-1,1) dif(i*2-1,2)],:);
    len(1,i)=sqrt(sum(diff(lpos(:,1:3)).^2))/data.ff.numStr(i*2-1);
    if dif(i*2,1) == 0
        rpos = NaN;
        len(2,1) = NaN;
    else
        rpos= data.Back_middle{i}([dif(i*2,1) dif(i*2,2)],:);
        len(2,i)=sqrt(sum(diff(rpos(:,1:3)).^2))/data.ff.numStr(i*2);
    end
end
comlen = mean(len,1);
clear dif rpos lpos

%Pull force data
for trial = 1: length(data.forcefname);
switch data.ff.forcefoot{trial*2}
    case 'L'
        ForcePeak(trial,1) = num2cell(data.FxPeak(trial));
        ForcePeak(trial,2) = num2cell(abs(data.FyMin(trial)));
        ForcePeak(trial,3) = num2cell(data.FzPeak(trial));
    case 'R'
        ForcePeak(trial,1) = num2cell(data.FxPeak(trial));
        ForcePeak(trial,2) = num2cell(abs(data.FyPeak(trial)));
        ForcePeak(trial,3) = num2cell(data.FzPeak(trial));
end
end

%Get Force impulse angle data

for i = 1:length(data.forcefname)
    xzang(i,1) = Angle2Horiz([data.Fimp(i,1),0,data.Fimp(i,3)]);
    yzang(i,1) = Angle2Horiz([data.Fimp(i,2),0,data.Fimp(i,3)]);

end

%td angle recalculated

for i = 1: length(data.forcefname)
    if strcmp(data.ff.forcefoot(i*2,1), 'L')
        %left toex 78  hip is 51
        temphip = data.L_hip{1,i}(data.ff.forcestep(i*2),:)
        temptoe = data.L_toe{1,i}(data.ff.forcestep(i*2),:)
    else %right toex 108 hip is 81
        temphip = data.R_hip{1,i}(data.ff.forcestep(i*2),:)
        temptoe = data.R_toe{1,i}(data.ff.forcestep(i*2),:)
    end
        tdang(i,1) = Angle2Horiz([temphip(1),0,temphip(3)],[temptoe(1),0,temptoe(3)]);
        tdang(i,2) = Angle2Horiz([0,temphip(2),temphip(3)],[0,temptoe(2),temptoe(3)]);
        tdang(i,3) = Angle2Horiz(temphip,temptoe);
   clear temp*
end

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
    things (2:i,11) = ForcePeak(:,1);
    things (2:i,12) = ForcePeak(:,2);
    things (2:i,13) =ForcePeak(:,3);
    things(2:i,14:17) = num2cell(data.Fimp);
    things(2:i,18) = num2cell(xzang);
    things(2:i,19) = num2cell(yzang);
    things(2:i,20)= num2cell(data.ff.svl(1:2:end,:)); 
    things(2:i,21:23) = num2cell(tdang);
    things(2:i,24) = num2cell(lslen);
    things(2:i,25) = num2cell(rslen);
     things(2:i,26) =num2cell(comlen');
    
    
 clear ForcePeak i *len *trial* *ang titles   avg* *ang

% xlswrite('Data',things);

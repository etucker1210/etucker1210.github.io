%% Change in KE PE
Delt = nan(length(data.forcefname),5);
for i = 1: length(data.forcefname)
     deltKE = data.KE{i}(end,1:3)-data.KE{i}(1,1:3);
     deltPE = data.PE{i}(end,1) - data.PE{i}(1,1);
     Etot        =   sum([data.KE{i}(:,1:3),data.PE{i}],2);
     deltEtot = Etot(end,1)-Etot(1,1);
     Delt(i,1:3) = deltKE;
     Delt(i,4) = deltPE;
     Delt(i,5) = deltEtot;
     clear delt*
end

     
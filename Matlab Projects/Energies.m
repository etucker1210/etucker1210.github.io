% KE Plots
for trial = 1:length(first.forcefname);
figure('NumberTitle','off','Name',first.ff.ufnames{trial});
plot(first.KE{trial}(:,1:3)); ylabel('Kinetic Energy (J)');
legend('x', 'y','z');
end
for trial = 1:length(second.forcefname);
figure('NumberTitle','off','Name',second.ff.ufnames{trial});
plot(second.KE{trial}(:,1:3)); ylabel('Kinetic Energy (J)');
legend('x', 'y','z');
end


%Kinetic Energies for X,y,z
for trial = 1: length(first.forcefname);
KExmax(trial) = max(first.KE{1,trial}(:,1));
KExmin(trial) = min(first.KE{1,trial}(:,1));
KEymax(trial) = max(first.KE{1,trial}(:,2));
KEymin(trial) = min(first.KE{1,trial}(:,2));
KEzmax(trial) = max(first.KE{1,trial}(:,3));
KEzmin(trial) = min(first.KE{1,trial}(:,3));
KExmean(trial) = mean(first.KE{1,trial}(:,1));
KEymean(trial) = mean(first.KE{1,trial}(:,2));
KEzmean(trial) = mean(first.KE{1,trial}(:,3));
end
for trial = 1: length(second.forcefname);
KExmax(trial+ length(first.forcefname)) = max(second.KE{1,trial}(:,1));
KExmin(trial + length(first.forcefname)) = min(second.KE{1,trial}(:,1));
KEymax(trial +length(first.forcefname)) = max(second.KE{1,trial}(:,2));
KEymin(trial + length(first.forcefname)) = min(second.KE{1,trial}(:,2));
KEzmax(trial+ length(first.forcefname)) = max(second.KE{1,trial}(:,3));
KEzmin(trial + length(first.forcefname)) = min(second.KE{1,trial}(:,3));
KExmean(trial + length(first.forcefname)) = mean(second.KE{1,trial}(:,1));
KEymean(trial + length(first.forcefname)) = mean(second.KE{1,trial}(:,2));
KEzmean(trial + length(first.forcefname)) = mean(second.KE{1,trial}(:,3));
end
    
%add the name thing in  you did it by hand
    
titles = {'file name', 'min KEx', 'max KEx', 'min KEy', 'max KEy', 'min KEz', 'max KEz', 'mean KEx','mean KEy','mean KEz',};
for i = length(KExmax)+1;
energies = titles;
energies (2:i,1) = names';
energies (2:i,2) = num2cell(KExmin);
energies (2:i,3) = num2cell(KExmax);
energies (2:i,4) = num2cell(KEymin);
energies (2:i,5) = num2cell(KEymax);
energies (2:i,6) = num2cell(KEzmin);
energies (2:i,7) = num2cell(KEzmax);
energies (2:i,8) = num2cell(KExmean);
energies (2:i,9) = num2cell(KEymean);
energies (2:i,10) = num2cell(KEzmean);
end

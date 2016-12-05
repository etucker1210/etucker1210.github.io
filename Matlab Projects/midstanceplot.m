% This will put a line up for midtance during the drop step
f = nan(length(data.forcefname),1);
for trial = 1: length(data.rotXYZ)
    switch data.ff.forcefoot{trial*2}
        case 'L'
            f(trial,1) = (min(find(data.rotXYZ{1,trial}(data.ff.forcestep(trial*2,1):data.ff.forcestep(trial*2,2),51) >= data.rotXYZ{1,trial}(data.ff.forcestep(trial*2,1):data.ff.forcestep(trial*2,2),78))))+ (data.ff.forcestep(trial*2,1)-1);
           
        case 'R'
            f(trial,1) = (min(find(data.rotXYZ{1,trial}(data.ff.forcestep(trial*2,1):data.ff.forcestep(trial*2,2),81) >= data.rotXYZ{1,trial}(data.ff.forcestep(trial*2,1):data.ff.forcestep(trial*2,2),108))))+ (data.ff.forcestep(trial*2,1)-1);
            
    end
end
for trial = 1:length(data.rotXYZ)
    figure('NumberTitle','off','Name',data.ff.ufnames{trial});
    subplot(2,1,1);
    plot(data.KE{trial}(:,1)); ylabel('Kinetic Energy X (J)');
    hold on
    ylim;
   line([f(trial) f(trial)],[ans(1) ans(2)]);
   subplot(2,1,2);
    plot(data.KE{trial}(:,2:3)); ylabel('Kinetic Energy Y & Z (J)');
    legend('KE Y','KE Z')
    ylim;
   line([f(trial) f(trial)],[ans(1) ans(2)]);
 
    
end
% for trial = 1: length(data.forcefname)
%     figure('NumberTitle','off','Name',data.ff.ufnames{1});
%     subplot(4,1,1);
%     plot(data.KE{1}(:,1:3), 'r','g','b'); ylabel('Kinetic Energy (J)');
%     hold on
%     subplot(4,1,2);
%     plot(data.KE{trial}(:,4),'r'); ylabel('Total Kinetic Energy (J)');
%     subplot(4,1,3);
%     plot(data.PE{trial},'g'); ylabel('Potential Energy (J)');
%     subplot(4,1,4);
%     plot(data.Ecom{trial},'k'); ylabel('Total COM Energy (J)');
% end

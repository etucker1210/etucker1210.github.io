numdata = length(data.forcefname);
p = nan(numdata,1); 
for i = 1: numdata
%     if strcmp(data.ff.treat(i*2), 'Flat')
        if strcmp(data.ff.kinematic(i*2),'Yes')
           p(i) = phdiffmeasure(data.KE{i}(:,4),data.PE{i});
        end
%     end
end

phasedeg=p*180/pi
clear numdata i
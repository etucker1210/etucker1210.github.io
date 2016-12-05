f = nan(length(data.forcefname),1);
for trial = 1: length(data.rotXYZ)
    switch data.ff.forcefoot{trial*2}
        case 'L'
            f(trial,1) = (min(find(data.rotXYZ{1,trial}(data.ff.forcestep(trial*2,1):data.ff.forcestep(trial*2,2),51) >= data.rotXYZ{1,trial}(data.ff.forcestep(trial*2,1):data.ff.forcestep(trial*2,2),78))))+ (data.ff.forcestep(trial*2,1)-1);
           
        case 'R'
            f(trial,1) = (min(find(data.rotXYZ{1,trial}(data.ff.forcestep(trial*2,1):data.ff.forcestep(trial*2,2),81) >= data.rotXYZ{1,trial}(data.ff.forcestep(trial*2,1):data.ff.forcestep(trial*2,2),108))))+ (data.ff.forcestep(trial*2,1)-1);
            
    end
end
for i = 1:length(data.forcefname)
    if strcmp(data.ff.treat(i*2,1),'Drop')
        am(i,:)= max(data.KE{1,i}(f(i):end,1:3));
        mid(i,:)= data.KE{1,i}(f(i),1:3) ;
        b4m(i,:)= max(data.KE{1,i}(1:f(i),1:3));
      
    end
end
difam = am-mid;
difb4 = b4m-mid;
change = difam-difb4

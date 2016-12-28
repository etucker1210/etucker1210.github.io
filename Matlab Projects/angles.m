for i = 1:length(data.forcefname)
    FD = data.ff.forcestep(i*2,1);
    FO = data.ff.forcestep(i*2,2);
LowerBackskb(i*2-1:i*2,:) =data.LowerBackskb{i}([FD FO],:);
UpperBackskb(i*2-1:i*2,:) = data.UpperBackskb{i}([FD FO],:);
UpperBackOtherskb(i*2-1:i*2,:) = data.UpperBackOtherskb{i}([FD FO],:);
LowerBackOtherskb (i*2-1:i*2,:)= data.LowerBackOtherskb{i}([FD FO],:);
clear FD FO
end
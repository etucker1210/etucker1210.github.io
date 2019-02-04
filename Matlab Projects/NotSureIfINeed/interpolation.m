angl= (1/140*100:1/140*100:100)
angl=angl'
for i = 1:length(tdangcontl)
    if i==6
    else
    angl(:,i+1) = interp1(1:length(tdangcontl{i}), tdangcontl{i}(:,1), linspace(1,length(tdangcontl{i}) , 140))
    end
    
end

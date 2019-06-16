for i = 1:length(data.forcefname)
    if strcmp(data.ff.kinematic(i*2,1),'Yes')
        force = data.rotF{i}(data.ff.forcestep(i*2,1)*10:data.ff.forcestep(i*2,2)*10,1:3);
        stiffness = Stiffnes3D(data.CM{i},force,data.forcefname{i},1)
        maxstiff(i,1) = max(stiffness);
    else
        maxstiff(i,1) = NaN;
    end
end


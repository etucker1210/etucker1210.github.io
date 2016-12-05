%Peak forces for the Fx, Fy, Fz direction

% Need to realize if the hit is a right or left foot hit.  If the hit is
% from the left foot then the Fy min data should be used and the absolute value must be taken.  If the hit is from
% the right foot then the Fy max data should be used.
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
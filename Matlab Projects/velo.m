for i = 1:numtrials
FD =  [min(data.ff.FD(i*2-1:i*2,1)) max(max(data.ff.FD(i*2-1:i*2,:)))];
mi = min(Utot.data{i}(FD(1):FD(2),4))
ma = max(Utot.data{i}(FD(1):FD(2),4))
per(i) = (ma-mi)/ma
end
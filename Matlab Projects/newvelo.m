% Calculate the velocity of the position datanew and apply lopass butterworth
% at 5x the Stride Frequency of the Trials

numtrials = length(data.forcefname);

Back_middle = data.Back_middle;
fps = 500;

for i = 1:numtrials
    velo{i} = CalcVelocity(Back_middle{i},500);
end

%find the rows with NaN
for i = 1:numtrials
    if ~isempty(find(isnan(velo{i}(:,1))));
        XYZ = velo{i};
        XYZ_old = XYZ;
        t               =   0:1/fps:(size(XYZ,1)-1)/fps;
        teval = t;
    
            r           =   1:size(XYZ,1);
            r(find(~isnan(XYZ(:,1))))   =   [];
            t(r)        =   [];
            XYZ(r,:)    =   [];
         U               =   nan(size(XYZ_old));
        for trial = 1:size(XYZ,2)
            U(:,trial) = fnval(teval,csaps(t,XYZ(:,trial)))';
           
        end
        %apply the filter 
        
        Velofilt5{i} = lopass_butterworth(U,data.sFreq(i,1)*5,500,4);
        Velofilt5{i}(r,:) = NaN;
       clear XYZ* r t U 
       
    else
        
        Velofilt5{i} = lopass_butterworth(velo{i},data.sFreq(i,1)*5,500,4);
        
end

    figure('NumberTitle','off','Name',data.ff.ufnames{i});
    plot(Velofilt5{i});
    hold on;
    plot(velo{i},'k:');
    title('5x stdfreq filter')
    hold off;
    
end
    
        

for i = 1:length(data.forcefname)
   LHippos = data.LHipskb{i}; 
   if sum(isnan(LHippos(:,1)))== length(LHippos(:,1))
       data.UAngLHip{i} = NaN;
   else
       t           =   [0:1:size(LHippos,1)-1]/500;
           
        nanPos      =   find(isnan(LHippos(:,1)));
       
        if nanPos(end)==size(LHippos,1)  % if true, end is padded with NaN
            dnanPos     =   diff(nanPos)-1;
            endpad      =   nanPos(max(find(dnanPos==1))+1);
            if isempty(endpad)
                endpad  =   nanPos(1);
            end
            t(endpad:end)   =   [];
            LHippos(endpad:end,:)=   [];
        end
        if nanPos(1) == 1   % if true, front is padded with NaN
            dnanPos     =   diff(nanPos)-1;
            frontpad    =   nanPos(min(find(dnanPos)));
            if isempty(frontpad)
                frontpad    =   nanPos(end);
            end
            t(1:frontpad)   =   [];
            LHippos(1:frontpad,:)=   [];
        end
        clear nanPos
        
        
        %   	(b) Determine if there are any addition NaN values within the
        %   remaining dataset. If so, remove NaN values and write to new
        %   variable XYnan.
        if max(find(dnanPos))-min(find(dnanPos))~=0     % additional NaN exists
            tnan = t;
            nanpos = find(isnan(LHippos(:,1)));
            tnan(nanpos) = [];
            XYnan = LHippos;
            XYnan(nanpos,:) = [];
        else
            nanPos      =   [];
            XYnan       =   LHippos;
            tnan        =   t;
        end
        
        % spline and evaluate data at all points, effectively interpolating
        % through missing points. ASSUMPTION: MISSING VALUES ARE FOR VERY SHORT
        % PERIODS (<= 5 FRAMES) SO OK TO INTERPOLATE THROUGH MISSING POINTS.
        for n = 1:3
        XYnew(:,n)      =   fnval(t,csaps(tnan,XYnan(:,n),1));
        temp2(:,n) = lopass_butterworth(XYnew(:,n),50,500,4);
        Utemp(:,n) = fnval(t,fnder(csaps(t,temp2(:,n))));
        end
       Utemp(nanpos,:) = nan;
        
        if exist('frontpad','var')
            XY              =   [nan(frontpad,3);LHippos];
            XYfilt          =   [nan(frontpad,3);XYfilt];
            UAngLHip               =   [nan(frontpad,3);Utemp];
        end
      
        
        data.UAngLHip{i}       =   UAngLHip;
        
        clear *pad
    end
end

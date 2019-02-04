function plots = trajectories(data)
    numtrials = length(data.forcefname);
    %this one will make trajectories in the xz plane and leave a solid line
    %at Stance
    for i = 1:numtrials
        RFD = data.ff.FD(i*2,:);
        LFD = data.ff.FD(i*2-1,:);
        RFO = data.ff.FO(i*2,:);
        LFO = data.ff.FO(i*2-1,:);
        Dropstep = data.ff.dropstep(i*2,:);
        Dropfoot = data.ff.dropfoot(i*2);
        
        R_hip = data.R_hip{i};
        R_knee = data.R_knee{i};
        R_ankle = data.R_ankle{i};
        R_foot = data.R_foot{i};
        R_toe = data.R_toe{i};
        R_knee = R_knee - R_hip;
        R_ankle = R_ankle- R_hip;
        R_foot = R_foot- R_hip;
        R_toe =  R_toe - R_hip;
 
        L_hip = data.L_hip{i};
        L_knee = data.L_knee{i};
        L_ankle = data.L_ankle{i};
        L_foot = data.L_foot{i};
        L_toe = data.L_toe{i};
        L_knee = L_knee - L_hip;
        L_ankle = L_ankle - L_hip;
        L_foot = L_foot - L_hip;
        L_toe = L_toe - L_hip;
         
        figure('NumberTitle','off','Name',data.ff.ufnames{i});
        if strcmp(data.ff.treat(i*2), "Flat")
        subplot(3,1,1)
            plot(0,0,'o','MarkerFaceColor','k')
            hold on
            plot(R_knee(:,1), R_knee(:,3),'r--')
            plot(R_ankle(:,1), R_ankle(:,3),'k--') 
            plot(R_foot(:,1), R_foot(:,3),'b--')
            plot(R_toe(:,1), R_toe(:,3),'g--')
            plot(L_knee(:,1), L_knee(:,3),'r--')
            plot(L_ankle(:,1), L_ankle(:,3),'k--') 
            plot(L_foot(:,1), L_foot(:,3),'b--')
            plot(L_toe(:,1), L_toe(:,3),'g--')
            
            for k = 1:5
                if ~isnan(RFD(k))&& ~isnan(RFO(k))
                    plot(R_knee(RFD(k):RFO(k),1), R_knee(RFD(k):RFO(k),3),'r', 'linewidth', 2)
                    plot(R_ankle(RFD(k):RFO(k),1), R_ankle(RFD(k):RFO(k),3),'k', 'linewidth', 2) 
                    plot(R_foot(RFD(k):RFO(k),1), R_foot(RFD(k):RFO(k),3),'b', 'linewidth', 2)
                    plot(R_toe(RFD(k):RFO(k),1), R_toe(RFD(k):RFO(k),3),'g', 'linewidth', 2)
                    plot(R_knee(RFD(k),1), R_knee(RFD(k),3),'ro')
                    plot(R_ankle(RFD(k),1), R_ankle(RFD(k),3),'ko') 
                    plot(R_foot(RFD(k),1), R_foot(RFD(k),3),'bo')
                    plot(R_toe(RFD(k),1), R_toe(RFD(k),3),'go')
                end
                if ~isnan(LFD(k)) && ~isnan(LFO(k))
                    plot(L_knee(LFD(k):LFO(k),1), L_knee(LFD(k):LFO(k),3),'r', 'linewidth', 2)
                    plot(L_ankle(LFD(k):LFO(k),1), L_ankle(LFD(k):LFO(k),3),'k', 'linewidth', 2) 
                    plot(L_foot(LFD(k):LFO(k),1), L_foot(LFD(k):LFO(k),3),'b', 'linewidth', 2)
                    plot(L_toe(LFD(k):LFO(k),1), L_toe(LFD(k):LFO(k),3),'g', 'linewidth', 2)
                    plot(L_knee(LFD(k),1), L_knee(LFD(k),3),'ro')
                    plot(L_ankle(LFD(k),1), L_ankle(LFD(k),3),'ko') 
                    plot(L_foot(LFD(k),1), L_foot(LFD(k),3),'bo')
                    plot(L_toe(LFD(k),1), L_toe(LFD(k),3),'go')
                end
            end
                title('Lateral View')
                xlabel('X position')
                ylabel('Z position')
            subplot(3,1,2)
            plot(0,0,'o','MarkerFaceColor','k')
            hold on
            plot(R_knee(:,2), R_knee(:,1),'r--')
            plot(R_ankle(:,2), R_ankle(:,1),'k--') 
            plot(R_foot(:,2), R_foot(:,1),'b--')
            plot(R_toe(:,2), R_toe(:,1),'g--')
            plot(L_knee(:,2), L_knee(:,1),'r--')
            plot(L_ankle(:,2), L_ankle(:,1),'k--') 
            plot(L_foot(:,2), L_foot(:,1),'b--')
            plot(L_toe(:,2), L_toe(:,1),'g--')
            
            for k = 1:5
                if ~isnan(RFD(k))&& ~isnan(RFO(k))
                    plot(R_knee(RFD(k):RFO(k),2), R_knee(RFD(k):RFO(k),1),'r', 'linewidth', 2)
                    plot(R_ankle(RFD(k):RFO(k),2), R_ankle(RFD(k):RFO(k),1),'k', 'linewidth', 2) 
                    plot(R_foot(RFD(k):RFO(k),2), R_foot(RFD(k):RFO(k),1),'b', 'linewidth', 2)
                    plot(R_toe(RFD(k):RFO(k),2), R_toe(RFD(k):RFO(k),1),'g', 'linewidth', 2)
                    plot(R_knee(RFD(k),2), R_knee(RFD(k),1),'ro')
                    plot(R_ankle(RFD(k),2), R_ankle(RFD(k),1),'ko') 
                    plot(R_foot(RFD(k),2), R_foot(RFD(k),1),'bo')
                    plot(R_toe(RFD(k),2), R_toe(RFD(k),1),'go')
                end
                if ~isnan(LFD(k)) && ~isnan(LFO(k))
                    plot(L_knee(LFD(k):LFO(k),2), L_knee(LFD(k):LFO(k),1),'r', 'linewidth', 2)
                    plot(L_ankle(LFD(k):LFO(k),2), L_ankle(LFD(k):LFO(k),1),'k', 'linewidth', 2) 
                    plot(L_foot(LFD(k):LFO(k),2), L_foot(LFD(k):LFO(k),1),'b', 'linewidth', 2)
                    plot(L_toe(LFD(k):LFO(k),2), L_toe(LFD(k):LFO(k),1),'g', 'linewidth', 2)
                    plot(L_knee(LFD(k),2), L_knee(LFD(k),1),'ro')
                    plot(L_ankle(LFD(k),2), L_ankle(LFD(k),1),'ko') 
                    plot(L_foot(LFD(k),2), L_foot(LFD(k),1),'bo')
                    plot(L_toe(LFD(k),2), L_toe(LFD(k),1),'go')
                end
            end
                title('Dorsal View')
                xlabel('Y position')
                ylabel('X position')
            subplot(3,1,3)
            plot(0,0,'o','MarkerFaceColor','k')
            hold on
            plot(R_knee(:,2), R_knee(:,3),'r--')
            plot(R_ankle(:,2), R_ankle(:,3),'k--') 
            plot(R_foot(:,2), R_foot(:,3),'b--')
            plot(R_toe(:,2), R_toe(:,3),'g--')
            plot(L_knee(:,2), L_knee(:,3),'r--')
            plot(L_ankle(:,2), L_ankle(:,3),'k--') 
            plot(L_foot(:,2), L_foot(:,3),'b--')
            plot(L_toe(:,2), L_toe(:,3),'g--')
            
            for k = 1:5
                if ~isnan(RFD(k))&& ~isnan(RFO(k))
                    plot(R_knee(RFD(k):RFO(k),2), R_knee(RFD(k):RFO(k),3),'r', 'linewidth', 2)
                    plot(R_ankle(RFD(k):RFO(k),2), R_ankle(RFD(k):RFO(k),3),'k', 'linewidth', 2) 
                    plot(R_foot(RFD(k):RFO(k),2), R_foot(RFD(k):RFO(k),3),'b', 'linewidth', 2)
                    plot(R_toe(RFD(k):RFO(k),2), R_toe(RFD(k):RFO(k),3),'g', 'linewidth', 2)
                    plot(R_knee(RFD(k),2), R_knee(RFD(k),3),'ro')
                    plot(R_ankle(RFD(k),2), R_ankle(RFD(k),3),'ko') 
                    plot(R_foot(RFD(k),2), R_foot(RFD(k),3),'bo')
                    plot(R_toe(RFD(k),2), R_toe(RFD(k),3),'go')
                end
                if ~isnan(LFD(k)) && ~isnan(LFO(k))
                    plot(L_knee(LFD(k):LFO(k),2), L_knee(LFD(k):LFO(k),3),'r', 'linewidth', 2)
                    plot(L_ankle(LFD(k):LFO(k),2), L_ankle(LFD(k):LFO(k),3),'k', 'linewidth', 2) 
                    plot(L_foot(LFD(k):LFO(k),2), L_foot(LFD(k):LFO(k),3),'b', 'linewidth', 2)
                    plot(L_toe(LFD(k):LFO(k),2), L_toe(LFD(k):LFO(k),3),'g', 'linewidth', 2)
                    plot(L_knee(LFD(k),2), L_knee(LFD(k),3),'ro')
                    plot(L_ankle(LFD(k),2), L_ankle(LFD(k),3),'ko') 
                    plot(L_foot(LFD(k),2), L_foot(LFD(k),3),'bo')
                    plot(L_toe(LFD(k),2), L_toe(LFD(k),3),'go')
                end
            end
                title('Cranial Caudal View')
                xlabel('Y position')
                ylabel('Z position')
        else
            subplot(3,1,1)
            plot(0,0,'o','MarkerFaceColor','k')
            hold on
            if data.ff.dropfoot(i*2),'
            plot(R_knee(:,1), R_knee(:,3),'r--')
            plot(R_ankle(:,1), R_ankle(:,3),'k--') 
            plot(R_foot(:,1), R_foot(:,3),'b--')
            plot(R_toe(:,1), R_toe(:,3),'g--')
            plot(L_knee(:,1), L_knee(:,3),'r--')
            plot(L_ankle(:,1), L_ankle(:,3),'k--') 
            plot(L_foot(:,1), L_foot(:,3),'b--')
            plot(L_toe(:,1), L_toe(:,3),'g--')
            
            for k = 1:5
                if ~isnan(RFD(k))&& ~isnan(RFO(k))
                    plot(R_knee(RFD(k):RFO(k),1), R_knee(RFD(k):RFO(k),3),'r', 'linewidth', 2)
                    plot(R_ankle(RFD(k):RFO(k),1), R_ankle(RFD(k):RFO(k),3),'k', 'linewidth', 2) 
                    plot(R_foot(RFD(k):RFO(k),1), R_foot(RFD(k):RFO(k),3),'b', 'linewidth', 2)
                    plot(R_toe(RFD(k):RFO(k),1), R_toe(RFD(k):RFO(k),3),'g', 'linewidth', 2)
                    plot(R_knee(RFD(k),1), R_knee(RFD(k),3),'ro')
                    plot(R_ankle(RFD(k),1), R_ankle(RFD(k),3),'ko') 
                    plot(R_foot(RFD(k),1), R_foot(RFD(k),3),'bo')
                    plot(R_toe(RFD(k),1), R_toe(RFD(k),3),'go')
                end
                if ~isnan(LFD(k)) && ~isnan(LFO(k))
                    plot(L_knee(LFD(k):LFO(k),1), L_knee(LFD(k):LFO(k),3),'r', 'linewidth', 2)
                    plot(L_ankle(LFD(k):LFO(k),1), L_ankle(LFD(k):LFO(k),3),'k', 'linewidth', 2) 
                    plot(L_foot(LFD(k):LFO(k),1), L_foot(LFD(k):LFO(k),3),'b', 'linewidth', 2)
                    plot(L_toe(LFD(k):LFO(k),1), L_toe(LFD(k):LFO(k),3),'g', 'linewidth', 2)
                    plot(L_knee(LFD(k),1), L_knee(LFD(k),3),'ro')
                    plot(L_ankle(LFD(k),1), L_ankle(LFD(k),3),'ko') 
                    plot(L_foot(LFD(k),1), L_foot(LFD(k),3),'bo')
                    plot(L_toe(LFD(k),1), L_toe(LFD(k),3),'go')
                end
            end
                title('Lateral View')
                xlabel('X position')
                ylabel('Z position')
            subplot(3,1,2)
            plot(0,0,'o','MarkerFaceColor','k')
            hold on
            plot(R_knee(:,2), R_knee(:,1),'r--')
            plot(R_ankle(:,2), R_ankle(:,1),'k--') 
            plot(R_foot(:,2), R_foot(:,1),'b--')
            plot(R_toe(:,2), R_toe(:,1),'g--')
            plot(L_knee(:,2), L_knee(:,1),'r--')
            plot(L_ankle(:,2), L_ankle(:,1),'k--') 
            plot(L_foot(:,2), L_foot(:,1),'b--')
            plot(L_toe(:,2), L_toe(:,1),'g--')
            
            for k = 1:5
                if ~isnan(RFD(k))&& ~isnan(RFO(k))
                    plot(R_knee(RFD(k):RFO(k),2), R_knee(RFD(k):RFO(k),1),'r', 'linewidth', 2)
                    plot(R_ankle(RFD(k):RFO(k),2), R_ankle(RFD(k):RFO(k),1),'k', 'linewidth', 2) 
                    plot(R_foot(RFD(k):RFO(k),2), R_foot(RFD(k):RFO(k),1),'b', 'linewidth', 2)
                    plot(R_toe(RFD(k):RFO(k),2), R_toe(RFD(k):RFO(k),1),'g', 'linewidth', 2)
                    plot(R_knee(RFD(k),2), R_knee(RFD(k),1),'ro')
                    plot(R_ankle(RFD(k),2), R_ankle(RFD(k),1),'ko') 
                    plot(R_foot(RFD(k),2), R_foot(RFD(k),1),'bo')
                    plot(R_toe(RFD(k),2), R_toe(RFD(k),1),'go')
                end
                if ~isnan(LFD(k)) && ~isnan(LFO(k))
                    plot(L_knee(LFD(k):LFO(k),2), L_knee(LFD(k):LFO(k),1),'r', 'linewidth', 2)
                    plot(L_ankle(LFD(k):LFO(k),2), L_ankle(LFD(k):LFO(k),1),'k', 'linewidth', 2) 
                    plot(L_foot(LFD(k):LFO(k),2), L_foot(LFD(k):LFO(k),1),'b', 'linewidth', 2)
                    plot(L_toe(LFD(k):LFO(k),2), L_toe(LFD(k):LFO(k),1),'g', 'linewidth', 2)
                    plot(L_knee(LFD(k),2), L_knee(LFD(k),1),'ro')
                    plot(L_ankle(LFD(k),2), L_ankle(LFD(k),1),'ko') 
                    plot(L_foot(LFD(k),2), L_foot(LFD(k),1),'bo')
                    plot(L_toe(LFD(k),2), L_toe(LFD(k),1),'go')
                end
            end
                title('Dorsal View')
                xlabel('Y position')
                ylabel('X position')
            subplot(3,1,3)
            plot(0,0,'o','MarkerFaceColor','k')
            hold on
            plot(R_knee(:,2), R_knee(:,3),'r--')
            plot(R_ankle(:,2), R_ankle(:,3),'k--') 
            plot(R_foot(:,2), R_foot(:,3),'b--')
            plot(R_toe(:,2), R_toe(:,3),'g--')
            plot(L_knee(:,2), L_knee(:,3),'r--')
            plot(L_ankle(:,2), L_ankle(:,3),'k--') 
            plot(L_foot(:,2), L_foot(:,3),'b--')
            plot(L_toe(:,2), L_toe(:,3),'g--')
            
            for k = 1:5
                if ~isnan(RFD(k))&& ~isnan(RFO(k))
                    plot(R_knee(RFD(k):RFO(k),2), R_knee(RFD(k):RFO(k),3),'r', 'linewidth', 2)
                    plot(R_ankle(RFD(k):RFO(k),2), R_ankle(RFD(k):RFO(k),3),'k', 'linewidth', 2) 
                    plot(R_foot(RFD(k):RFO(k),2), R_foot(RFD(k):RFO(k),3),'b', 'linewidth', 2)
                    plot(R_toe(RFD(k):RFO(k),2), R_toe(RFD(k):RFO(k),3),'g', 'linewidth', 2)
                    plot(R_knee(RFD(k),2), R_knee(RFD(k),3),'ro')
                    plot(R_ankle(RFD(k),2), R_ankle(RFD(k),3),'ko') 
                    plot(R_foot(RFD(k),2), R_foot(RFD(k),3),'bo')
                    plot(R_toe(RFD(k),2), R_toe(RFD(k),3),'go')
                end
                if ~isnan(LFD(k)) && ~isnan(LFO(k))
                    plot(L_knee(LFD(k):LFO(k),2), L_knee(LFD(k):LFO(k),3),'r', 'linewidth', 2)
                    plot(L_ankle(LFD(k):LFO(k),2), L_ankle(LFD(k):LFO(k),3),'k', 'linewidth', 2) 
                    plot(L_foot(LFD(k):LFO(k),2), L_foot(LFD(k):LFO(k),3),'b', 'linewidth', 2)
                    plot(L_toe(LFD(k):LFO(k),2), L_toe(LFD(k):LFO(k),3),'g', 'linewidth', 2)
                    plot(L_knee(LFD(k),2), L_knee(LFD(k),3),'ro')
                    plot(L_ankle(LFD(k),2), L_ankle(LFD(k),3),'ko') 
                    plot(L_foot(LFD(k),2), L_foot(LFD(k),3),'bo')
                    plot(L_toe(LFD(k),2), L_toe(LFD(k),3),'go')
                end
            end
                title('Cranial Caudal View')
                xlabel('Y position')
                ylabel('Z position')
    end
                
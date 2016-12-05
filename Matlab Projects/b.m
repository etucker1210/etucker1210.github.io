numtrials = length( data.forcefname)
    Bas09 = figure;
   set(Bas09,'name','Bas09 Hip height','numbertitle','off')
    Bas10 = figure;
    set(Bas10,'name','Bas10  Hip height','numbertitle','off')
    Bas26 = figure;
    set(Bas26,'name','Bas26  Hip height','numbertitle','off')
    Bas31 = figure;
    set(Bas31,'name','Bas31  Hip height','numbertitle','off')
for i = 1: numtrials
    if strcmp(Lizard{i},'Bas09')
        figure(Bas09);
        if strcmp(data.ff.treat(i*2),'Level')
       subplot(2,1,1)
            plot(data.Back_posterior{i}(:,3),'k')
        hold on
        else
            subplot(2,1,2)
            plot(data.Back_posterior{i}(:,3),'r')
            hold on
        end
    elseif strcmp(Lizard{i},'Bas10')
        figure(Bas10);
        if strcmp(data.ff.treat(i*2),'Level')
             subplot(2,1,1)
        plot(data.Back_posterior{i}(:,3),'k')
        hold on
        else
             subplot(2,1,2)
            plot(data.Back_posterior{i}(:,3),'r')
            hold on
        end
    elseif strcmp(Lizard{i},'Bas26')
        figure(Bas26);
        if strcmp(data.ff.treat(i*2),'Level')
             subplot(2,1,1)
        plot(data.Back_posterior{i}(:,3),'k')
        hold on
        else
             subplot(2,1,2)
            plot(data.Back_posterior{i}(:,3),'r')
            hold on
        end
    else strcmp(Lizard{i},'Bas31')
        figure(Bas31);
        if strcmp(data.ff.treat(i*2),'Level')
             subplot(2,1,1)
        plot(data.Back_posterior{i}(:,3),'k')
        hold on
        else
             subplot(2,1,2)
            plot(data.Back_posterior{i}(:,3),'r')
            hold on
        end
    end
end


numtrials = length(data.forcefname);
for i = 1:numtrials
    temp = data.ff.FD(i*2-1:i*2,:)
    [r,c] = find(temp == data.ff.forcestep(i*2,1));
    if isnan(temp(r,c+1)) == 0
    FDO = temp(r,c+1);
        if strcmp(data.ff.forcefoot(i*2,1), 'L')
            temphip = data.L_hip{1,i}(FDO,:);
            temptoe = data.L_toe{1,i}(FDO,:);
        else 
            temphip = data.R_hip{1,i}(FDO,:);
            temptoe = data.R_toe{1,i}(FDO,:);
        end
            tdang(i,1) = Angle2Horiz([temphip(1),0,temphip(3)],[temptoe(1),0,temptoe(3)]);
            tdang(i,2) = Angle2Horiz([0,temphip(2),temphip(3)],[0,temptoe(2),temptoe(3)]);
            tdang(i,3) = Angle2Horiz(temphip,temptoe);
       clear temp* c r
    end
end
%%
for i = 1:numtrials
    if strcmp(data.ff.treat(i*2),'Level')
        FD=data.ff.FD(i*2-1:i*2,:); 
        Left=FD(1,:);
        Right=FD(2,:);
        L = find(~isnan(Left));
        R = find(~isnan(Right));
        FDL = Left(:,L);
        FDR = Right(:,R);
        hipl = data.L_hip{i}(FDL(1):FDL(2),:);
        toel = data.L_toe{i}(FDL(1):FDL(2),:);
        hipr = data.R_hip{i}(FDR(1):FDR(2),:);
        toer = data.R_toe{i}(FDR(1):FDR(2),:);
    zerol = zeros(length(hipl),1);
    zeror = zeros(length(hipr),1);
    angcontl{i}(:,1)= Angle2Horiz([hipl(:,1),zerol,hipl(:,3)],[toel(:,1),zerol,toel(:,3)]);
    angcontl{i}(:,2)= Angle2Horiz([zerol,hipl(:,2),hipl(:,3)],[zerol,toel(:,2),toel(:,3)]);
    angcontr{i}(:,1)= Angle2Horiz([hipr(:,1),zeror,hipr(:,3)],[toer(:,1),zeror,toer(:,3)]);
    angcontr{i}(:,2)= Angle2Horiz([zeror,hipr(:,2),hipr(:,3)],[zeror,toer(:,2),toer(:,3)]);
    angcontl{i}(:,3)=(1/length(angcontl{i})*100:1/length(angcontl{i})*100:100);
    angcontr{i}(:,3)=(1/length(angcontr{i})*100:1/length(angcontr{i})*100:100);
    
    clear z* h*  t* R* L*
    
   
    end
end
     sizel =  max(cellfun(@(field) length(field),angcontl));
     sizer = max(cellfun(@(field) length(field),angcontr));
       
    countl= (1/sizel*100:1/sizel*100:100);
    countr= (1/sizer*100:1/sizer*100:100);
    countl= countl';
    countr = countr';
    angl = countl;
    angr=countr;
for i = 1:length(angcontl)
    if i==6
    else
        angl(:,i+1) = interp1(1:length(angcontl{i}), angcontl{i}(:,1), linspace(1,length(angcontl{i}) , sizel));
        angr(:,i+1) = interp1(1:length(angcontl{i}), angcontl{i}(:,1), linspace(1,length(angcontl{i}) , sizer));
    end
    
end

for i = 1:length(angcontl)
    FD=data.ff.FD(i*2-1:i*2,:); 
        Left=FD(1,:);
        Right=FD(2,:);
        L = find(~isnan(Left));
        R = find(~isnan(Right));
        FDL = Left(:,L);
        FDR = Right(:,R);
      if strcmp(data.ff.forcefoot(i*2),'L')
        [r,c] = find(FDL == data.ff.forcestep(i*2,1));
        if c ==1
            plot(angl(1,1),angl(1,i+1),'k*','MarkerSize',10);
            hold on
            
        elseif c==2
            plot(angl(end,1),angl(end,i+1),'k*','MarkerSize',10);
            hold on
        else 
        end
    end
end

    for i = 1:length(angcontr)
        if strcmp(data.ff.forcefoot(i*2),'R')
       [r,c] = find(FDR == data.ff.forcestep(i*2,1));
        if c ==1
            plot(angr(1,1),angr(1,i+1),'k*','MarkerSize',10);
            hold on
        elseif c==2
            plot(angr(end,1),angr(end,i+1),'k*','MarkerSize',10);
            hold on
        else
        end
        end
    end
        hold on
        plot(angr(:,1),(angr(:,2:end)), 'k--');
        plot(angl(:,1),(angl(:,2:end)), 'k--');
        title 'XZang'  
clear F*
   
%%
for i=1:numtrials
    if strcmp(data.ff.treat(i*2),'Drop')
        FD=data.ff.FD(i*2-1:i*2,:); 
        Force = data.ff.forcestep(i*2,1)
        [r,c] = find(Force == FD);
        if r==1           
            Left=FD(1,c:c+1);
            Right=FD(2,:);
        else
            Right= FD(2,c:c+1);
            Left = FD(1,:);
        end
        
        L = find(~isnan(Left));
        R = find(~isnan(Right));
        FDL = Left(:,L);
        FDR = Right(:,R);
        hipl = data.L_hip{i}(FDL(1):FDL(2),:);
        toel = data.L_toe{i}(FDL(1):FDL(2),:);
        zerol = zeros(length(hipl),1);
        if length(FDR<2)==1
            angcontdr{i}= nan(length(zerol),1)
        elseif isnan(FD(2,1))==1
            angcontdr{i}= nan(length(zerol),1)
        else
            hipr = data.R_hip{i}(FDR(1):FDR(2),:);
            toer = data.R_toe{i}(FDR(1):FDR(2),:);
            zeror = zeros(length(hipr),1);
            angcontdr{i}(:,1)= Angle2Horiz([hipr(:,1),zeror,hipr(:,3)],[toer(:,1),zeror,toer(:,3)]);
            angcontdr{i}(:,2)= Angle2Horiz([zeror,hipr(:,2),hipr(:,3)],[zeror,toer(:,2),toer(:,3)]);
        end
    
    angcontdl{i}(:,1)= Angle2Horiz([hipl(:,1),zerol,hipl(:,3)],[toel(:,1),zerol,toel(:,3)]);
    angcontdl{i}(:,2)= Angle2Horiz([zerol,hipl(:,2),hipl(:,3)],[zerol,toel(:,2),toel(:,3)]);
    angcontdl{i}(:,3)=(1/length(angcontdl{i})*100:1/length(angcontdl{i})*100:100);
    angcontdr{i}(:,3)=(1/length(angcontdr{i})*100:1/length(angcontdr{i})*100:100);
    
    clear z* h*  t* R* L*
    
   
    end
end
    sizel =  max(cellfun(@(field) length(field),angcontdl));
    sizer = max(cellfun(@(field) length(field),angcontdr));
       
    countl= (1/sizel*100:1/sizel*100:100);
    countr= (1/sizer*100:1/sizer*100:100);
    countl= countl';
    countr = countr';
    angdl = countl;
    angdr=countr;
for i = 1:length(angcontdl)
        if isempty(angcontdl{i})==0
        angdl(:,i+1) = interp1(1:length(angcontdl{i}), angcontdl{i}(:,1), linspace(1,length(angcontdl{i}) , sizel));
        angdr(:,i+1) = interp1(1:length(angcontdl{i}), angcontdl{i}(:,1), linspace(1,length(angcontdl{i}) , sizer));
        end
end
    


for i = 1:length(angcontdl)    
    if strcmp(data.ff.forcefoot(i*2),'L')
            plot(angdl(end,1),angdl(end,i+1),'r*','MarkerSize',10);
            hold on
    else
        plot(angdr(end,1),angdr(end,i+1),'r*','MarkerSize',10);
            hold on
     end
    
end
hold on
plot(angdr(:,1),(angdr(:,2:end)), 'r--');
plot(angdl(:,1),(angdl(:,2:end)), 'r--');
        
figure;
     sizel =  max(cellfun(@(field) length(field),angcontl));
     sizer = max(cellfun(@(field) length(field),angcontr));
       
    countl= (1/sizel*100:1/sizel*100:100);
    countr= (1/sizer*100:1/sizer*100:100);
    countl= countl';
    countr = countr';
    angl = countl;
    angr=countr;
for i = 1:length(angcontl)
    if i==6
    else
        angl(:,i+1) = interp1(1:length(angcontl{i}), angcontl{i}(:,2), linspace(1,length(angcontl{i}) , sizel));
        angr(:,i+1) = interp1(1:length(angcontl{i}), angcontl{i}(:,2), linspace(1,length(angcontl{i}) , sizer));
    end
    
end

for i = 1:length(angcontl)
    FD=data.ff.FD(i*2-1:i*2,:); 
        Left=FD(1,:);
        Right=FD(2,:);
        L = find(~isnan(Left));
        R = find(~isnan(Right));
        FDL = Left(:,L);
        FDR = Right(:,R);
      if strcmp(data.ff.forcefoot(i*2),'L')
        [r,c] = find(FDL == data.ff.forcestep(i*2,1));
        if c ==1
            plot(angl(1,1),angl(1,i+1),'k*','MarkerSize',10);
            hold on
            
        elseif c==2
            plot(angl(end,1),angl(end,i+1),'k*','MarkerSize',10);
            hold on
        else 
        end
    end
end

    for i = 1:length(angcontr)
        if strcmp(data.ff.forcefoot(i*2),'R')
       [r,c] = find(FDR == data.ff.forcestep(i*2,1));
        if c ==1
            plot(angr(1,1),angr(1,i+1),'k*','MarkerSize',10);
            hold on
        elseif c==2
            plot(angr(end,1),angr(end,i+1),'k*','MarkerSize',10);
            hold on
        else
        end
        end
    end
        hold on
        plot(angr(:,1),(angr(:,2:end)), 'k--');
        plot(angl(:,1),(angl(:,2:end)), 'k--');
clear F*
   
%%
for i=1:numtrials
    if strcmp(data.ff.treat(i*2),'Drop')
        FD=data.ff.FD(i*2-1:i*2,:); 
        Force = data.ff.forcestep(i*2,1)
        [r,c] = find(Force == FD);
        if r==1           
            Left=FD(1,c:c+1);
            Right=FD(2,:);
        else
            Right= FD(2,c:c+1);
            Left = FD(1,:);
        end
        
        L = find(~isnan(Left));
        R = find(~isnan(Right));
        FDL = Left(:,L);
        FDR = Right(:,R);
        hipl = data.L_hip{i}(FDL(1):FDL(2),:);
        toel = data.L_toe{i}(FDL(1):FDL(2),:);
        zerol = zeros(length(hipl),1);
        if length(FDR<2)==1
            angcontdr{i}= nan(length(zerol),1)
        elseif isnan(FD(2,1))==1
            angcontdr{i}= nan(length(zerol),1)
        else
            hipr = data.R_hip{i}(FDR(1):FDR(2),:);
            toer = data.R_toe{i}(FDR(1):FDR(2),:);
            zeror = zeros(length(hipr),1);
            angcontdr{i}(:,1)= Angle2Horiz([hipr(:,1),zeror,hipr(:,3)],[toer(:,1),zeror,toer(:,3)]);
            angcontdr{i}(:,2)= Angle2Horiz([zeror,hipr(:,2),hipr(:,3)],[zeror,toer(:,2),toer(:,3)]);
        end
    
    angcontdl{i}(:,1)= Angle2Horiz([hipl(:,1),zerol,hipl(:,3)],[toel(:,1),zerol,toel(:,3)]);
    angcontdl{i}(:,2)= Angle2Horiz([zerol,hipl(:,2),hipl(:,3)],[zerol,toel(:,2),toel(:,3)]);
    angcontdl{i}(:,3)=(1/length(angcontdl{i})*100:1/length(angcontdl{i})*100:100);
    angcontdr{i}(:,3)=(1/length(angcontdr{i})*100:1/length(angcontdr{i})*100:100);
    
    clear z* h*  t* R* L*
    
   
    end
end
    sizel =  max(cellfun(@(field) length(field),angcontdl));
    sizer = max(cellfun(@(field) length(field),angcontdr));
       
    countl= (1/sizel*100:1/sizel*100:100);
    countr= (1/sizer*100:1/sizer*100:100);
    countl= countl';
    countr = countr';
    angdl = countl;
    angdr=countr;
for i = 1:length(angcontdl)
        if isempty(angcontdl{i})==0
        angdl(:,i+1) = interp1(1:length(angcontdl{i}), angcontdl{i}(:,1), linspace(1,length(angcontdl{i}) , sizel));
        angdr(:,i+1) = interp1(1:length(angcontdl{i}), angcontdl{i}(:,1), linspace(1,length(angcontdl{i}) , sizer));
        end
end
    


for i = 1:length(angcontdl)    
    if strcmp(data.ff.forcefoot(i*2),'L')
            plot(angdl(end,1),angdl(end,i+1),'r*','MarkerSize',10);
            hold on
    else
        plot(angdr(end,1),angdr(end,i+1),'r*','MarkerSize',10);
            hold on
     end
    
end
hold on
plot(angdr(:,1),(angdr(:,2:end)), 'r--');
plot(angdl(:,1),(angdl(:,2:end)), 'r--');
title 'YZang'

%%

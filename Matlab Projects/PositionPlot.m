%function plots = PositionPlot(data)
% The goal of this code is to create plots that hold the positions of the 
%joints relative to the ankle and plot them.  Will create two plots, xz and
%yz.  Drop trials will be in RED level trials will be in BLACK.
NumTrials = length(data.forcefname);
%%Gathering the Positions

Fhxz = NaN(1,2);
Fkxz = NaN(1,2);
Ffxz = NaN(1,2);
Fhyz = NaN(1,2);
Fkyz = NaN(1,2);
Ffyz = NaN(1,2);

Dhxz = NaN(1,2);
Dkxz = NaN(1,2);
Dfxz = NaN(1,2);
Dhyz = NaN(1,2);
Dkyz = NaN(1,2);
Dfyz = NaN(1,2);

for trial = 1:NumTrials
    if trial ==41 | trial==81
    else
        if ~isempty(data.L_ankle{trial})
            Rh = data.R_hip{trial}-data.R_ankle{trial};
            Rk = data.R_knee{trial}-data.R_ankle{trial};
            Ra = data.R_ankle{trial}-data.R_ankle{trial};
            Rf = data.R_foot{trial}-data.R_ankle{trial};
            Lh = data.L_hip{trial}-data.L_ankle{trial};
            Lk = data.L_knee{trial}-data.L_ankle{trial};
            La = data.L_ankle{trial}-data.L_ankle{trial};
            Lf = data.L_foot{trial}-data.L_ankle{trial};

            if strcmp(data.ff.treat(trial*2),'Flat')
                hold on
                LFD = data.ff.FD(trial*2-1,~isnan(data.ff.FD(trial*2-1,:)));
                RFD = data.ff.FD(trial*2,~isnan(data.ff.FD(trial*2,:)));
                scatter(Rh(RFD,1),Rh(RFD,3), 'ks')
                scatter(Rk(RFD,1),Rk(RFD,3), 'k*')
                scatter(Ra(RFD,1),Ra(RFD,3), 'ko')
                scatter(Rf(RFD,1),Rf(RFD,3), 'kd')
                scatter(Lh(LFD,1),Lh(LFD,3), 'ks')
                scatter(Lk(LFD,1),Lk(LFD,3), 'k*')
                scatter(La(LFD,1),La(LFD,3), 'ko')
                scatter(Lf(LFD,1),Lf(LFD,3), 'kd')
                Fhxz = vertcat(Fhxz,[Rh(RFD,1) Rh(RFD,3)]);
                Fhxz = vertcat(Fhxz,[Lh(LFD,1) Lh(LFD,3)]);
                Fkxz = vertcat(Fkxz,[Rk(RFD,1) Rk(RFD,3)]);
                Fkxz = vertcat(Fkxz,[Lk(LFD,1) Lk(LFD,3)]);
                Ffxz = vertcat(Ffxz,[Rf(RFD,1) Rf(RFD,3)]);
                Ffxz = vertcat(Ffxz,[Lf(LFD,1) Lf(LFD,3)]); 
            else
                if strcmp(data.ff.forcefoot(trial*2),'L')
                    hold on
                    LFD = data.ff.forcestep(trial*2,1);
                    if ~isnan(LFD)
                    scatter(Lh(LFD,1),Lh(LFD,3), 'rs')
                    scatter(Lk(LFD,1),Lk(LFD,3), 'r*')
                    scatter(La(LFD,1),La(LFD,3), 'ro')
                    scatter(Lf(LFD,1),Lf(LFD,3), 'rd')
                    Dhxz = vertcat(Dhxz,[Lh(LFD,1) Lh(LFD,3)]);
                    Dkxz = vertcat(Dkxz,[Lk(LFD,1) Lk(LFD,3)]);
                    Dfxz = vertcat(Dfxz,[Lf(LFD,1) Lf(LFD,3)]); 
                    end
                else
                    RFD = data.ff.forcestep(trial*2,1);
                    hold on
                    if ~isnan(RFD)
                    scatter(Rh(RFD,1),Rh(RFD,3), 'rs')
                    scatter(Rk(RFD,1),Rk(RFD,3), 'r*')
                    scatter(Ra(RFD,1),Ra(RFD,3), 'ro')
                    scatter(Rf(RFD,1),Rf(RFD,3), 'rd')
                    Dhxz = vertcat(Dhxz,[Rh(RFD,1) Rh(RFD,3)]);
                    Dkxz = vertcat(Dfxz,[Rk(RFD,1) Rk(RFD,3)]);
                    Dfxz = vertcat(Dfxz,[Rf(RFD,1) Rf(RFD,3)]);
                    end
                end
            end
        end
    clear RFD LFD
    end
end

Fhxz(~any(~isnan(Fhxz), 2),:)=[]
Fkxz(~any(~isnan(Fkxz), 2),:)=[]
Ffxz(~any(~isnan(Ffxz), 2),:)=[]
Dhxz(~any(~isnan(Dhxz), 2),:)=[]
Dkxz(~any(~isnan(Dkxz), 2),:)=[]
Dfxz(~any(~isnan(Dfxz), 2),:)=[]

a = boundary(Fhxz);
b = boundary(Fkxz);
c = boundary(Ffxz);
d = boundary(Dhxz);
e = boundary(Dkxz);
f = boundary(Dfxz);

aa = fill(Fhxz(a,1),Fhxz(a,2),'r', Fkxz(b,1),Fkxz(b,2),'b', ... 
Ffxz(c,1),Ffxz(c,2),'g',Dhxz(d,1),Dhxz(d,2),'k',Dkxz(e,1),Dkxz(e,2),'y', ... 
Dfxz(f,1),Dfxz(f,2),'c')

legend(aa, 'Flat Hip','Flat Knee', 'Flat Foot', 'Drop Hip', 'Drop Knee', ...
    'Drop Foot');
 dd = fill(Dhxz(d,1),Dhxz(d,2),'k', Dkxz(e,1),Dkxz(e,2),'y',Dfxz(f,1),Dfxz(f,2),'c')
 
set(aa,'facealpha',.5)
scatter(0,0,'k','MarkerFaceColor', 'b', 'DisplayName', 'Ankle')
xlabel('X position (mm)')
ylabel('Z position (mm)')
title('Position of Joints Relative to Ankle')

figure,
for trial = 1:NumTrials
    hold on
    if trial ==41 | trial==81
    else
        if ~isempty(data.L_ankle{trial})
            Rh = data.R_hip{trial}-data.R_ankle{trial};
            Rk = data.R_knee{trial}-data.R_ankle{trial};
            Ra = data.R_ankle{trial}-data.R_ankle{trial};
            Rf = data.R_foot{trial}-data.R_ankle{trial};
            Lh = data.L_hip{trial}-data.L_ankle{trial};
            Lk = data.L_knee{trial}-data.L_ankle{trial};
            La = data.L_ankle{trial}-data.L_ankle{trial};
            Lf = data.L_foot{trial}-data.L_ankle{trial};

            if strcmp(data.ff.treat(trial*2),'Flat')
                hold on
                LFD = data.ff.FD(trial*2-1,~isnan(data.ff.FD(trial*2-1,:)));
                RFD = data.ff.FD(trial*2,~isnan(data.ff.FD(trial*2,:)));
                scatter(Rh(RFD,2),Rh(RFD,3), 'ks')
                scatter(Rk(RFD,2),Rk(RFD,3), 'k*')
                scatter(Ra(RFD,2),Ra(RFD,3), 'ko')
                scatter(Rf(RFD,2),Rf(RFD,3), 'kd')
                scatter(Lh(LFD,2),Lh(LFD,3), 'ks')
                scatter(Lk(LFD,2),Lk(LFD,3), 'k*')
                scatter(La(LFD,2),La(LFD,3), 'ko')
                scatter(Lf(LFD,2),Lf(LFD,3), 'kd')
                Fhyz = vertcat(Fhyz,[Rh(RFD,2) Rh(RFD,3)]);
                Fhyz = vertcat(Fhyz,[Lh(LFD,2) Lh(LFD,3)]);
                Fkyz = vertcat(Fkyz,[Rk(RFD,2) Rk(RFD,3)]);
                Fkyz = vertcat(Fkyz,[Lk(LFD,2) Lk(LFD,3)]);
                Ffyz = vertcat(Ffyz,[Rf(RFD,2) Rf(RFD,3)]);
                Ffyz = vertcat(Ffyz,[Lf(LFD,2) Lf(LFD,3)]); 
            else
                if strcmp(data.ff.forcefoot(trial*2),'L')
                    hold on
                    LFD = data.ff.forcestep(trial*2,1);
                    if ~isnan(LFD)
                    scatter(Lh(LFD,2),Lh(LFD,3), 'rs')
                    scatter(Lk(LFD,2),Lk(LFD,3), 'r*')
                    scatter(La(LFD,2),La(LFD,3), 'ro')
                    scatter(Lf(LFD,2),Lf(LFD,3), 'rd')
                    Dhyz = vertcat(Dhyz,[Lh(LFD,2) Lh(LFD,3)]);
                    Dkyz = vertcat(Dkyz,[Lk(LFD,2) Lk(LFD,3)]);
                    Dfyz = vertcat(Dfyz,[Lf(LFD,2) Lf(LFD,3)]); 
                    end
                else
                    RFD = data.ff.forcestep(trial*2,1);
                    hold on
                    if ~isnan(RFD)
                    scatter(Rh(RFD,2),Rh(RFD,3), 'rs')
                    scatter(Rk(RFD,2),Rk(RFD,3), 'r*')
                    scatter(Ra(RFD,2),Ra(RFD,3), 'ro')
                    scatter(Rf(RFD,2),Rf(RFD,3), 'rd')
                    Dhyz = vertcat(Dhyz,[Rh(RFD,2) Rh(RFD,3)]);
                    Dkyz = vertcat(Dfyz,[Rk(RFD,2) Rk(RFD,3)]);
                    Dfyz = vertcat(Dfyz,[Rf(RFD,2) Rf(RFD,3)]);
                    end
                end
            end
        end
    clear RFD LFD
    end
end
clear a b c d e f 
Fhyz(~any(~isnan(Fhyz), 2),:)=[]
Fkyz(~any(~isnan(Fkyz), 2),:)=[]
Ffyz(~any(~isnan(Ffyz), 2),:)=[]
Dhyz(~any(~isnan(Dhyz), 2),:)=[]
Dkyz(~any(~isnan(Dkyz), 2),:)=[]
Dfyz(~any(~isnan(Dfyz), 2),:)=[]

a = boundary(Fhyz);
b = boundary(Fkyz);
c = boundary(Ffyz);
d = boundary(Dhyz);
e = boundary(Dkyz);
f = boundary(Dfyz);

bb = fill(Fhyz(a,1),Fhyz(a,2),'r', Fkyz(b,1),Fkyz(b,2),'b', ... 
Ffyz(c,1),Ffyz(c,2),'g',Dhyz(d,1),Dhyz(d,2),'k',Dkyz(e,1),Dkyz(e,2),'y', ... 
Dfyz(f,1),Dfyz(f,2),'c')

legend(bb, 'Flat Hip','Flat Knee', 'Flat Foot', 'Drop Hip', 'Drop Knee', ...
    'Drop Foot','Ankle');
set(bb,'facealpha',.5)
fill(Dhyz(d,1),Dhyz(d,2),'k', Dkyz(e,1),Dkyz(e,2),'y',Dfyz(f,1),Dfyz(f,2),'c')
scatter(0,0,'k','MarkerFaceColor', 'b', 'DisplayName', 'Ankle')
xlabel('y position (mm)')
ylabel('Z position (mm)')
title('Position of Joints Relative to Ankle')


        
function plots = testingposition(data)
% The goal of this code is to create plots that hold the positions of the 
%joints relative to the ankle and plot them.  Will create two plots, xz and
%yz.  Drop trials will be in RED level trials will be in BLACK.
NumTrials = length(data.forcefname);
%%Gathering the Positions

Faxz = NaN(1,2);
Fkxz = NaN(1,2);
Ffxz = NaN(1,2);
Fayz = NaN(1,2);
Fkyz = NaN(1,2);
Ffyz = NaN(1,2);

Daxz = NaN(1,2);
Dkxz = NaN(1,2);
Dfxz = NaN(1,2);
Dayz = NaN(1,2);
Dkyz = NaN(1,2);
Dfyz = NaN(1,2);

for trial = 1:NumTrials
    if trial ==33 
    else
        rhip= data.R_hip{trial};
        lhip= data.L_hip{trial};
        if ~isempty(data.L_ankle{trial})
            Rh = data.R_hip{trial}-rhip;
            Rk = data.R_knee{trial}-rhip;
            Ra = data.R_ankle{trial}-rhip;
            Rf = data.R_foot{trial}-rhip;
            Lh = data.L_hip{trial}-lhip;
            Lk = data.L_knee{trial}-lhip;
            La = data.L_ankle{trial}-lhip;
            Lf = data.L_foot{trial}-lhip;

            if strcmp(data.ff.treat(trial*2),'Flat')
                hold on
                LFD = data.ff.FD(trial*2-1,~isnan(data.ff.FD(trial*2-1,:)));
                RFD = data.ff.FD(trial*2,~isnan(data.ff.FD(trial*2,:)));
                scatter(Rh(RFD,1),Rh(RFD,3), 'ko')
                scatter(Rk(RFD,1),Rk(RFD,3), 'k*')
                scatter(Ra(RFD,1),Ra(RFD,3), 'ks')
                scatter(Rf(RFD,1),Rf(RFD,3), 'kd')
                scatter(Lh(LFD,1),Lh(LFD,3), 'ko')
                scatter(Lk(LFD,1),Lk(LFD,3), 'k*')
                scatter(La(LFD,1),La(LFD,3), 'ks')
                scatter(Lf(LFD,1),Lf(LFD,3), 'kd')
                Faxz = vertcat(Faxz,[Ra(RFD,1) Ra(RFD,3)]);
                Faxz = vertcat(Faxz,[La(LFD,1) La(LFD,3)]);
                Fkxz = vertcat(Fkxz,[Rk(RFD,1) Rk(RFD,3)]);
                Fkxz = vertcat(Fkxz,[Lk(LFD,1) Lk(LFD,3)]);
                Ffxz = vertcat(Ffxz,[Rf(RFD,1) Rf(RFD,3)]);
                Ffxz = vertcat(Ffxz,[Lf(LFD,1) Lf(LFD,3)]); 
            else
                if strcmp(data.ff.forcefoot(trial*2),'L')
                    hold on
                    LFD = data.ff.forcestep(trial*2,1);
                    if ~isnan(LFD)
                    scatter(Lh(LFD,1),Lh(LFD,3), 'ro')
                    scatter(Lk(LFD,1),Lk(LFD,3), 'r*')
                    scatter(La(LFD,1),La(LFD,3), 'rs')
                    scatter(Lf(LFD,1),Lf(LFD,3), 'rd')
                    Daxz = vertcat(Daxz,[La(LFD,1) La(LFD,3)]);
                    Dkxz = vertcat(Dkxz,[Lk(LFD,1) Lk(LFD,3)]);
                    Dfxz = vertcat(Dfxz,[Lf(LFD,1) Lf(LFD,3)]); 
                    end
                else
                    RFD = data.ff.forcestep(trial*2,1);
                    hold on
                    if ~isnan(RFD)
                    scatter(Rh(RFD,1),Rh(RFD,3), 'ro')
                    scatter(Rk(RFD,1),Rk(RFD,3), 'r*')
                    scatter(Ra(RFD,1),Ra(RFD,3), 'rs')
                    scatter(Rf(RFD,1),Rf(RFD,3), 'rd')
                    Daxz = vertcat(Daxz,[Ra(RFD,1) Ra(RFD,3)]);
                    Dkxz = vertcat(Dkxz,[Rk(RFD,1) Rk(RFD,3)]);
                    Dfxz = vertcat(Dfxz,[Rf(RFD,1) Rf(RFD,3)]);
                    end
                end
            end
        end
    clear RFD LFD
    end
end

Faxz(~any(~isnan(Faxz), 2),:)=[];
Fkxz(~any(~isnan(Fkxz), 2),:)=[];
Ffxz(~any(~isnan(Ffxz), 2),:)=[];
Daxz(~any(~isnan(Daxz), 2),:)=[];
Dkxz(~any(~isnan(Dkxz), 2),:)=[];
Dfxz(~any(~isnan(Dfxz), 2),:)=[];

a = convhull(Faxz(:,1),Faxz(:,2));
b = convhull(Fkxz(:,1),Fkxz(:,2));
c = convhull(Ffxz(:,1),Ffxz(:,2));
d = convhull(Daxz(:,1),Daxz(:,2));
e = convhull(Dkxz(:,1),Dkxz(:,2));
f = convhull(Dfxz(:,1),Dfxz(:,2));

aa = fill(Fkxz(b,1),Fkxz(b,2),'b',Faxz(a,1),Faxz(a,2),'r',...  
Ffxz(c,1),Ffxz(c,2),'g', Dkxz(e,1),Dkxz(e,2),'y', ... 
Daxz(d,1),Daxz(d,2),'k', Dfxz(f,1),Dfxz(f,2),'c');

legend(aa, 'Flat Knee','Flat Ankle', 'Flat Foot', 'Drop Knee', 'Drop Ankle', ...
    'Drop Foot');
 dd = fill(Daxz(d,1),Daxz(d,2),'k', Dkxz(e,1),Dkxz(e,2),'y',Dfxz(f,1),Dfxz(f,2),'c');
 
set(aa,'facealpha',.5)
scatter(0,0,'k','MarkerFaceColor', 'b', 'DisplayName', 'Hip')
xlabel('X position (mm)')
ylabel('Z position (mm)')
title('Position of Joints Relative to Hip')

%%
figure,
for trial = 1:NumTrials
    hold on
    if trial ==41 | trial==81
    else
       rhip= data.R_hip{trial};
       lhip= data.L_hip{trial};
        if ~isempty(data.L_ankle{trial})
            Rh = data.R_hip{trial}-rhip;
            Rk = data.R_knee{trial}-rhip;
            Ra = data.R_ankle{trial}-rhip;
            Rf = data.R_foot{trial}-rhip;
            Lh = data.L_hip{trial}-lhip;
            Lk = data.L_knee{trial}-lhip;
            La = data.L_ankle{trial}-lhip;
            Lf = data.L_foot{trial}-lhip;
            
            if strcmp(data.ff.treat(trial*2),'Flat')
                hold on
                LFD = data.ff.FD(trial*2-1,~isnan(data.ff.FD(trial*2-1,:)));
                RFD = data.ff.FD(trial*2,~isnan(data.ff.FD(trial*2,:)));
                scatter(abs(Rh(RFD,2)),Rh(RFD,3), 'ko')
                scatter(abs(Rk(RFD,2)),Rk(RFD,3), 'k*')
                scatter(abs(Ra(RFD,2)),Ra(RFD,3), 'ks')
                scatter(abs(Rf(RFD,2)),Rf(RFD,3), 'kd')
                scatter(Lh(LFD,2),Lh(LFD,3), 'ko')
                scatter(Lk(LFD,2),Lk(LFD,3), 'k*')
                scatter(La(LFD,2),La(LFD,3), 'ks')
                scatter(Lf(LFD,2),Lf(LFD,3), 'kd')
                Fayz = vertcat(Fayz,[abs(Ra(RFD,2)) Ra(RFD,3)]);
                Fayz = vertcat(Fayz,[La(LFD,2) La(LFD,3)]);
                Fkyz = vertcat(Fkyz,[abs(Rk(RFD,2)) Rk(RFD,3)]);
                Fkyz = vertcat(Fkyz,[Lk(LFD,2) Lk(LFD,3)]);
                Ffyz = vertcat(Ffyz,[abs(Rf(RFD,2)) Rf(RFD,3)]);
                Ffyz = vertcat(Ffyz,[Lf(LFD,2) Lf(LFD,3)]); 
            else
                if strcmp(data.ff.forcefoot(trial*2),'L')
                    hold on
                    LFD = data.ff.forcestep(trial*2,1);
                    if ~isnan(LFD)
                    scatter(Lh(LFD,2),Lh(LFD,3), 'ro')
                    scatter(Lk(LFD,2),Lk(LFD,3), 'r*')
                    scatter(La(LFD,2),La(LFD,3), 'rs')
                    scatter(Lf(LFD,2),Lf(LFD,3), 'rd')
                    Dayz = vertcat(Dayz,[La(LFD,2) La(LFD,3)]);
                    Dkyz = vertcat(Dkyz,[Lk(LFD,2) Lk(LFD,3)]);
                    Dfyz = vertcat(Dfyz,[Lf(LFD,2) Lf(LFD,3)]); 
                    end
                else
                    RFD = data.ff.forcestep(trial*2,1);
                    hold on
                    if ~isnan(RFD)
                    scatter(abs(Rh(RFD,2)),Rh(RFD,3), 'ro')
                    scatter(abs(Rk(RFD,2)),Rk(RFD,3), 'r*')
                    scatter(abs(Ra(RFD,2)),Ra(RFD,3), 'rs')
                    scatter(abs(Rf(RFD,2)),Rf(RFD,3), 'rd')
                    Dayz = vertcat(Dayz,[abs(Ra(RFD,2)) Ra(RFD,3)]);
                    Dkyz = vertcat(Dkyz,[abs(Rk(RFD,2)) Rk(RFD,3)]);
                    Dfyz = vertcat(Dfyz,[abs(Rf(RFD,2)) Rf(RFD,3)]);
                    end
                end
            end
        end
    clear RFD LFD
    end
end
clear a b c d e f 
Fayz(~any(~isnan(Fayz), 2),:)=[];
Fkyz(~any(~isnan(Fkyz), 2),:)=[];
Ffyz(~any(~isnan(Ffyz), 2),:)=[];
Dayz(~any(~isnan(Dayz), 2),:)=[];
Dkyz(~any(~isnan(Dkyz), 2),:)=[];
Dfyz(~any(~isnan(Dfyz), 2),:)=[];

a = convhull(Fayz(:,1),Fayz(:,2));
b = convhull(Fkyz(:,1),Fkyz(:,2));
c = convhull(Ffyz(:,1),Ffyz(:,2));
d = convhull(Dayz(:,1),Dayz(:,2));
e = convhull(Dkyz(:,1),Dkyz(:,2));
f = convhull(Dfyz(:,1),Dfyz(:,2));

bb = fill(Fkyz(b,1),Fkyz(b,2),'b',Fayz(a,1),Fayz(a,2),'r', ... 
Ffyz(c,1),Ffyz(c,2),'g',Dkyz(e,1),Dkyz(e,2),'y',Dayz(d,1),Dayz(d,2),'k', ... 
Dfyz(f,1),Dfyz(f,2),'c');

legend(bb, 'Flat Knee','Flat Ankle', 'Flat Foot', 'Drop Knee', 'Drop Ankle', ...
    'Drop Foot','Hip');
set(bb,'facealpha',.5)
%fill(Dayz(d,1),Dayz(d,2),'k', Dkyz(e,1),Dkyz(e,2),'y',Dfyz(f,1),Dfyz(f,2),'c')
scatter(0,0,'k','MarkerFaceColor', 'b', 'DisplayName', 'Ankle')
xlabel('Y position (mm)')
ylabel('Z position (mm)')
title('Position of Joints Relative to Hip')


        
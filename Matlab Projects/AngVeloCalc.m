%prep work for linear measurements
numtrials = length(data.forcefname);
%%
for i = 1:numtrials
    if isempty(data.Back_anterior{i})~= 1 

    R_hip = data.R_hip{i};
    R_knee = data.R_knee{i};
    R_ankle = data.R_ankle{i};
    R_foot  = data.R_foot{i};
    R_toe = data.R_toe{i};
    L_hip  = data.L_hip{i};
    L_knee = data.L_knee{i};
    L_ankle = data.L_ankle{i};
    L_foot = data.L_foot{i};
    L_toe = data.L_toe{i};
    Back_anterior  = data.Back_anterior{i};
    Back_posterior = data.Back_posterior{i};
    
    R_hipvectknee = R_hip - R_knee;
    R_anklevectknee = R_knee- R_ankle;
    L_hipvectknee = L_hip - L_knee;
    L_anklevectknee =L_knee - L_ankle;
    
    R_kneevectankle = R_knee - R_ankle;
    L_kneevectankle = L_knee - L_ankle;
    R_footvectankle = R_ankle - R_foot;
    L_footvectankle = L_ankle - L_foot;
    
    R_anklevecttmp = R_ankle - R_foot;
    L_anklevecttmp = L_ankle - L_foot;    
    R_toevecttmp = R_foot - R_toe;
    L_toevecttmp = L_foot - L_toe;
    
    Back = Back_anterior - Back_posterior;
    R_vecthip = R_knee- R_hip; 
    L_vecthip = L_knee - L_hip;
    
%Start Calculating Degrees and AngVelo of those parts
t= (0:length(L_ankle)-1)/data.fps;
[degLknee,radLknee]= calc2vectorAngle(L_hipvectknee,L_anklevectknee);
[degRknee,radRknee]= calc2vectorAngle(R_hipvectknee,R_anklevectknee);
[degLankle,radLankle]= calc2vectorAngle(L_kneevectankle,L_footvectankle);
[degRankle,radRankle]= calc2vectorAngle(R_kneevectankle,R_footvectankle);
[degLtmp,radLtmp]= calc2vectorAngle(L_anklevecttmp,L_toevecttmp);
[degRtmp,radRtmp]= calc2vectorAngle(R_anklevecttmp,R_toevecttmp);
[degLhiprel,radLhiprel]= calc2vectorAngle(Back,L_vecthip);
[degRhiprel,radRhiprel]= calc2vectorAngle(Back,R_vecthip);
[degLhipabs,radLhipabs]= Angle2Horiz(L_vecthip);
[degRhipabs,radRhipabs]= Angle2Horiz(R_vecthip);

misslk= find(ismissing(degLknee));
missrk= find(ismissing(degRknee));
missla= find(ismissing(degLankle));
missra= find(ismissing(degRankle));
missltmp= find(ismissing(degLtmp));
missrtmp= find(ismissing(degRtmp));
misslhiprel= find(ismissing(degLhiprel));
missrhiprel= find(ismissing(degRhiprel));
misslhipabs= find(ismissing(degLhipabs));
missrhipabs= find(ismissing(degRhipabs));

%start eval for Lknee
teval = t;
deglknee{i}= degLknee;
if length(find(ismissing(degLknee)))<= .75 * length(degLknee)
    teval(misslk) = [];
    degLknee(misslk) = [];
    degLknee = fnval(t,csaps(teval,degLknee));
    U = fnval(t,fnder(csaps(t,degLknee)));
    U(misslk) = nan; 
    U_anglk{i}= U;
    clear teval U
end

%start eval for Rknee
teval = t;
degrknee{i}= degRknee;
if length(find(ismissing(degRknee)))<= .75 * length(degRknee)
    teval(missrk) = [];
    degRknee(missrk) = [];
    degRknee = fnval(t,csaps(teval,degRknee));
    U = fnval(t,fnder(csaps(t,degRknee)));
    U(missrk) = nan;
    U_angrk{i} = U;
    clear teval U
end

%start eval for Lankle
teval = t;
deglankle{i}= degLankle;
if length(find(ismissing(degLankle)))<= .75 * length(degLankle)
    teval(missla) = [];
    degLankle(missla) = []; 
    degLankle = fnval(t,csaps(teval,degLankle));
    U = fnval(t,fnder(csaps(t,degLankle)));
    U(missla) = nan;
    U_angla{i} = U;
    clear teval U
end

%start eval for Rankle
teval = t;
degrankle{i}= degRankle;
if length(find(ismissing(degRankle)))<= .75 * length(degRankle)
    teval(missra) = [];
    degRankle(missra) = [];
    degRankle = fnval(t,csaps(teval,degRankle));
    U = fnval(t,fnder(csaps(t,degRankle)));
    U(missra) = nan;
    U_angra{i} = U;
    clear teval U
end

%start eval for Ltmp
teval = t;
degltmp{i}= degLtmp;
if length(find(ismissing(degLtmp)))<= .75 * length(degLtmp)
    teval(missltmp) = [];
    degLtmp(missltmp) = [];
    degLtmp = fnval(t,csaps(teval,degLtmp));
    U = fnval(t,fnder(csaps(t,degLtmp)));
    U(missltmp) = nan;
    U_angltmp{i} = U;
    clear teval U
end

%start eval for Rtmp
teval = t;
degrtmp{i}= degRtmp;
if length(find(ismissing(degRtmp)))<= .75 * length(degRtmp)
    teval(missrtmp) = [];
    degRtmp(missrtmp) = [];
    degRtmp = fnval(t,csaps(teval,degRtmp));
    U = fnval(t,fnder(csaps(t,degRtmp)));
    U(missrtmp) = nan;
    U_angrtmp{i} = U;
    clear teval U
end 
%start eval for Rel Hip
teval = t;
deglhiprel{i}= degLhiprel;
if length(find(ismissing(degLhiprel)))<= .75 *  length(degLhiprel)
    teval(misslhiprel) = [];
    degLhiprel(misslhiprel) = [];
    degLhiprel = fnval(t,csaps(teval,degLhiprel));
    U = fnval(t,fnder(csaps(t,degLhiprel)));
    U(misslhiprel) = nan;
    U_anglhiprel{i} = U;
    clear teval U
end
%start eval for Rtmp
teval = t;
degrhiprel{i}= degRhiprel;
if length(find(ismissing(degRhiprel)))<= .75 *  length(degRhiprel)
    teval(missrhiprel) = [];
    degRhiprel(missrhiprel) = [];
    degRhiprel= fnval(t,csaps(teval,degRhiprel));
    U = fnval(t,fnder(csaps(t,degRhiprel)));
    U(missrhiprel) = nan;
    U_angrhiprel{i}= U;
    clear teval U
end
%% abship
%start eval for Ltmp
teval = t;
deglhipabs{i}= degLhipabs;
if length(find(ismissing(degLhipabs)))<= .75 *  length(degLhipabs)
    teval(misslhipabs) = [];
    degLhipabs(misslhipabs) = [];
    degLhipabs = fnval(t,csaps(teval,degLhipabs));
    U = fnval(t,fnder(csaps(t,degLhipabs)));
    U(misslhipabs) = nan;
    U_anglhipabs{i} = U;
    clear teval U
end
%start eval for Rtmp
teval = t;
degrhipabs{i}= degRhipabs;
if length(find(ismissing(degRhipabs)))<= .75 *  length(degRhipabs)
    teval(missrhipabs) = [];
    degRhipabs(missrhipabs) = [];
    degRhipabs = fnval(t,csaps(teval,degRhipabs));
    U = fnval(t,fnder(csaps(t,degRhipabs)));
    U(missrhipabs) = nan;
    U_angrhipabs{i} = U;
    clear teval U 
end

clear Lk* Rk* La* Ra* Lt* Rt* rad* t* degL* B* miss* degR* L_* R_*
    end
end
clear i 




    
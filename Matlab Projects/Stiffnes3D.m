function stiffness = Stiffness3D(CoMpos,Force,tname,p)
%this function will calculate the 3D stiffenss using CoM position matrix
%(Mx3) and Force data (Mx3).  This calculates displacement by taking the
%CoM position throughout time minus the initial CoM position.  This will
%output a stiffness value matrix of (Mx1). plot = 1 means return plot, 0 is
%no plot.
Force(:,4) = sqrt(sum(Force.^2,2));

%Scalar projection of force onto the CoM
norms = sqrt(sum(CoMpos.^2,2));
proj = dot(CoMpos,Force(:,1:3),2)./norms;

%displacement of the CoM
discm = sqrt(sum((CoMpos-CoMpos(1)).^2,2));

%stiffness calculated as the projected force over the displacement of the
%CoM
stiffness = -1*proj./discm;

%plot if wanted.
if p == 1
    figure('Name', tname);
    hold on
    plot(discm); 
    plot(Force(:,4)); 
    plot(stiffness)
    legend("CoM Displacement","Force","Stiffness")
end

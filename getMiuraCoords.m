function [Xms, Yms, Zms, mInds, Sm, Lm] = getMiuraCoords(a,bm,gm,psi)
thetam = asin(sin(psi)/sin(gm));
Hm = a*sin(thetam)*sin(gm);
Sm = bm*cos(thetam)*tan(gm)/sqrt(1+cos(thetam)^2*tan(gm)^2);
% Spsi = bm*sqrt(sin(gm)^2-sin(psi)^2)/cos(psi);
Lm = a*sqrt(1-sin(thetam)^2*sin(gm)^2);
Vm = Sm/(tan(gm)*cos(thetam));

Xms = [Sm Sm Sm 0 0 0 2*Sm 2*Sm 2*Sm]';
Yms = [2*Lm+Vm Lm+Vm Vm 2*Lm Lm 0 2*Lm Lm 0]';
Zms = [0 Hm 0 0 Hm 0 0 Hm 0]';
mInds = [6 3 2 5;       % Each row corresponds to one quadrilateral
    5 2 1 4;
    3 9 8 2;
    1 2 8 7];
end
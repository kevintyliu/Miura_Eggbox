function [Xes, Yes, Zes, eInds, Se, Le] = getEggboxCoords(a,be,ge,psi)
alphae = pi/2-psi;
betae = acos(cos(ge)/cos(alphae));
hae = a*cos(alphae);
hbe = be*cos(betae);
He = hae+hbe;
Se = be*sqrt(1-cos(ge)^2/cos(alphae)^2);    % instead of B
Le = a*sin(alphae);                       % instead of W

Xes = [Se 2*Se 0 Se 2*Se 0 Se 2*Se 0]';
Yes = [Le Le Le 0 0 0 2*Le 2*Le 2*Le]';
Zes = [He hae hae hbe 0 0 hbe 0 0]';
eInds = [6 4 1 3;       % Each row corresponds to one quadrilateral
    3 1 7 9;
    4 5 2 1;
    1 2 8 7];
end
%% Params
% a = 9.6;
% bm = 9.6;
% be = 2.3;
% gm = deg2rad(75);
% ge = deg2rad(30);
% psis = deg2rad([62 74.5]);
a = 8.5;
bm = 9.6;
be = 1.90;
gm = deg2rad(75);
ge = deg2rad(60);
psis = deg2rad([40 74.5]);
for i = 1:length(psis)
    psi = psis(i);
    %% Calculate helpful angles
    thetam = asin(sin(psi)/sin(gm));
    alphae = pi/2-psi;
    %% Calculate dihedral angles
    rhom1(i) = 2*asin( cos(thetam) / sqrt(cos(gm)^2 + sin(gm)^2*cos(thetam)^2) );       % angle of M and V of Miura (creases in YZ plane)
    rhom2(i) = pi - 2*thetam;       % angle of the Ms of Miura (creases parallel to XY plane)
    rhom2sup(i) = pi - rhom2(i);      % angle between Miuras for tube
    rhoe1(i) = 2*asin( sqrt(cos(alphae)^2-cos(ge)^2) / (sin(ge)*cos(alphae)) );       % angle of creases in YZ plane
    rhoe2(i) = 2*asin( sin(alphae) / sin(ge) );       % angle of creases in XZ plane

    tau1(i) = (rhom1(i)+rhoe1(i))/2;       % angle between Miura and Eggbox at +Y side
    tau2(i) = (pi - rhom1(i)/2) + rhoe1(i)/2;       % angle between Miura and Eggbox at -Y side
    if tau2(i)>pi
        tau2(i) = 2*pi-tau2(i);
    end
end
%% Print
fprintf('rho_m1 = %0.3f deg\n', rad2deg(min(rhom1))); %
fprintf('rho_m2_min = %0.3f deg\n', rad2deg(min(rhom2))); %
fprintf('rho_m2_max = %0.3f deg\n', rad2deg(max(rhom2))); % min psi
fprintf('rho_e1 = %0.3f deg\n', rad2deg(min(rhoe1))); % min psi
fprintf('rho_e2min = %0.3f deg\n', rad2deg(min(rhoe2))); %
fprintf('rho_e2max = %0.3f deg\n', rad2deg(max(rhoe2))); %
fprintf('tau_1 = %0.3f deg\n', rad2deg(min(tau1)));
fprintf('tau_2up = %0.3f deg\n', rad2deg(tau2(1)));
fprintf('tau_2down = %0.3f deg\n', rad2deg(tau2(2)));
fprintf('\n');

% rhom1(1)<rhom1(2)
% rhom2(1)<rhom2(2)
% rhom2sup(1)<rhom2sup(2)
% rhoe1(1)<rhoe1(2)
% rhoe2(1)<rhoe2(2)
% tau1(1)<tau1(2)
% tau2(1)<tau2(2)
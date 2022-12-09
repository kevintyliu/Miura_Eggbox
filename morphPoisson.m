alpha = deg2rad(60);
beta = deg2rad(40);
a = 1;
c = 1;

b = a*abs(cos(alpha)/cos(beta));
phis = linspace(alpha-beta, alpha+beta, 501);
xis = cos(beta) - cos(alpha)*cos(phis);
zetas = cos(alpha) - cos(beta)*cos(phis);
psis = acos( cos(2*alpha) + 2*xis.^2.*csc(phis).^2 );
Ls = sqrt(a^2+b^2-2*a*b*cos(phis));
Ws = 2*c*sin(psis/2);
nus = 4*c^2*Ls.^2./(a^2*Ws.^2)*abs(cos(beta)/cos(alpha)).*xis.*zetas./sin(phis).^4;
nus(abs(nus)>1e5) = NaN;

figure
plot(rad2deg(phis),nus);
xlim([0 100]);   % range is alpha-beta to alpha+beta
ylim([-3 3]);
xlabel('\phi (deg)');
ylabel('\nu (deg)');
grid on


figure
plot(rad2deg(psis),nus);
xlim([0 100]);
ylim([-10 10]);
xlabel('\psi (deg)');
ylabel('\nu (deg)');
grid on


figure
plot(90-rad2deg(psis)/2,nus);    %range is 90 - (alpha+beta)/2 to 90-(alpha-beta)/2
xlabel('My \psi (deg)');
ylabel('\nu (deg)');
grid on

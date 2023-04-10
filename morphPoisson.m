function [psis, nuMiuras, nuEggs, LMiuras, LEggs] = morphPoisson(a,c,alpha,beta)
b = a*abs(cos(alpha)/cos(beta));

psis = linspace(0, 2*beta, 501);
phi1s = acos(cos(alpha)./cos(psis/2));
phi2s = acos(cos(beta)./cos(psis/2));
% cosMiuraPhis = (2*cos(alpha)*cos(beta)+sqrt(2*(cos(alpha)^2-cos(beta)^2)*(cos(psis)-cos(2*alpha))+(cos(psis)-cos(2*alpha)).^2))...
%     ./(2*cos(alpha)^2+cos(psis)-cos(2*alpha));
% cosEggPhis = (2*cos(alpha)*cos(beta)-sqrt(2*(cos(alpha)^2-cos(beta)^2)*(cos(psis)-cos(2*alpha))+(cos(psis)-cos(2*alpha)).^2))...
%     ./(2*cos(alpha)^2+cos(psis)-cos(2*alpha));
% phisMiuras = acos(cosMiuraPhis);
phisMiuras = phi1s - phi2s;
xiMiuras = cos(beta) - cos(alpha)*cos(phisMiuras);
zetaMiuras = cos(alpha) - cos(beta)*cos(phisMiuras);
LMiuras = sqrt(a^2+b^2-2*a*b*cos(phisMiuras));
WMiuras = 2*c*sin(psis/2);
nuMiuras = 4*c^2*LMiuras.^2./(a^2*WMiuras.^2)*abs(cos(beta)/cos(alpha)).*xiMiuras.*zetaMiuras./sin(phisMiuras).^4;
% phisEggs = acos(cosEggPhis);
phisEggs = phi1s + phi2s;
xiEggs = cos(beta) - cos(alpha)*cos(phisEggs);
zetaEggs = cos(alpha) - cos(beta)*cos(phisEggs);
LEggs = sqrt(a^2+b^2-2*a*b*cos(phisEggs));
WEggs = 2*c*sin(psis/2);
nuEggs = 4*c^2*LEggs.^2./(a^2*WEggs.^2)*abs(cos(beta)/cos(alpha)).*xiEggs.*zetaEggs./sin(phisEggs).^4;
rad2deg([min(phisMiuras) max(phisMiuras)])
rad2deg([min(phisEggs) max(phisEggs)])

% figure
% plot(rad2deg(psis),rad2deg(phisMiuras));
% hold on;
% plot(rad2deg(psis),rad2deg(phisEggs));
% plot(rad2deg(psis),rad2deg(phi1s));
% plot(rad2deg(psis),rad2deg(phi2s));
% grid on;
% close

figure
plot(rad2deg(pi/2-psis/2),LMiuras);
hold on;
plot(rad2deg(pi/2-psis/2),LEggs);
grid on;
close

phis = linspace((alpha-beta)*1.001, (alpha+beta)*0.999, 501);
xis = cos(beta) - cos(alpha)*cos(phis);
zetas = cos(alpha) - cos(beta)*cos(phis);
psisPlot = acos( cos(2*alpha) + 2*xis.^2.*csc(phis).^2 );
Ls = sqrt(a^2+b^2-2*a*b*cos(phis));
Ws = 2*c*sin(psisPlot/2);
nus = 4*c^2*Ls.^2./(a^2*Ws.^2)*abs(cos(beta)/cos(alpha)).*xis.*zetas./sin(phis).^4;
nus(abs(nus)>1e5) = NaN;

% figure
% plot(rad2deg(phis),nus);
% xlim([0 100]);   % range is alpha-beta to alpha+beta
% ylim([-3 3]);
% xlabel('\phi (deg)');
% ylabel('\nu');
% grid on
% 
% 
% figure
% plot(rad2deg(psis),nus); % range is 0 to 2*beta
% xlim([0 100]);
% ylim([-10 10]);
% xlabel('\psi (deg)');
% ylabel('\nu');
% grid on
morph_a_label = sprintf('%0.1f',a);
morph_c_label = sprintf('%0.1f',c);
morph_alpha_label = sprintf('%u',round(rad2deg(alpha)));
morph_beta_label = sprintf('%u',round(rad2deg(beta)));
% legendlabel = ['Morph: a = ' morph_a_label ', c = ' morph_c_label ...
%     ', \alpha = ' morph_alpha_label '^\circ, \beta = ' morph_beta_label '^\circ'];
legendlabel = ['Morph: \alpha = ' morph_alpha_label '^\circ, \beta = ' morph_beta_label '^\circ'];
plot(90-rad2deg(psisPlot)/2,nus.^-1,'DisplayName',legendlabel,'LineWidth',3);    %range is 90-beta to 90
% plot(90-rad2deg(psis)/2,nuMiuras.^-1);    %range is 90-beta to 90
% plot(90-rad2deg(psis)/2,nuEggs.^-1);    %range is 90-beta to 90% xlabel('My \psi (deg)');
legend
hold on
grid on
xlim([15 75]);
ylim([-10 10]);
xlim manual
ylim manual
xlabel('\psi (deg)');
ylabel('\nu = (dS/S) / (dL/L)');
set(gca,'FontSize',18)
set(gcf,'color','w');

% figure
% plot(90-rad2deg(phis)/2,nus);
% xlabel('My \psi rot (deg)');
% ylabel('\nu = (dS/S) / (dL/L)');
% title(['\alpha = ' num2str(rad2deg(alpha)) ' deg, \beta = ' num2str(rad2deg(beta)) ' deg']);
% xlim([0 90])
% ylim([-10 10]);
% grid on
end
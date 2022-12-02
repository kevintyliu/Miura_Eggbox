function plotMiuraEgg(f)
nplot = 301;
a = f.UserData.a;
bm = f.UserData.bm;
be = f.UserData.be;
gm = f.UserData.gm;
ge = f.UserData.ge;
psi = f.UserData.psi;

% Miura calculations
[Xms, Yms, Zms, mInds, Sm, L] = getMiuraCoords(a,bm,gm,psi);

% Eggbox calculations
[Xes, Yes, Zes, eInds, Se, ~] = getEggboxCoords(a,be,ge,psi);
Xes  = Xes + 2*Sm;
eInds = eInds + 9;

Ssum = Sm + Se;
% Plot
Xs = [Xms; Xes];
Ys = [Yms; Yes];
Zs = [Zms; Zes];
quadInds = [mInds; eInds];
for i = 1:size(quadInds,1)
    h = f.Children(length(f.Children)).Children(i);
    h.XData = Xs(quadInds(i,:));
    h.YData = Ys(quadInds(i,:));
    h.ZData = Zs(quadInds(i,:));
end
axes(f.Children(length(f.Children)));
title(sprintf('$a$: %0.2f, $b_m$: %0.2f, $b_e$: %0.2f, $\\gamma_m$: %0.1f$^\\circ$, $\\gamma_e$: %0.2f$^\\circ$, $\\psi$: %0.1f$^\\circ$',...
    a,bm,be,rad2deg(gm),rad2deg(ge),rad2deg(psi)),'Interpreter','latex');
xlim([0,2*bm*sin(gm)+2*be*sin(ge)]);
ylim([0,max([2*a+bm*cos(gm) bm+2*a*cos(gm) 2*a*sin(ge)])]);
zlim([0,max([a+be*cos(ge) be+a*cos(ge) a*sin(gm)])]);

psims = linspace(0,gm,nplot);
Sms = bm*sqrt(sin(gm).^2-sin(psims).^2)./cos(psims);
psies = linspace(pi/2-ge,pi/2,nplot);
alphaes = pi/2-psies;
Ses = be*sqrt(1-cos(ge)^2./cos(alphaes).^2);
% Ses2 = be*sqrt(1-0.99999999*cos(ge)^2./sin(psies).^2);
% max(Ses2-Ses)
psiSums = linspace(pi/2-ge,gm,nplot);
Ls = a*sin(pi/2-psiSums);
thetaSums = asin(sin(psiSums)./sin(gm));
SSumsms = bm*cos(thetaSums)*tan(gm)./sqrt(1+cos(thetaSums).^2*tan(gm)^2);
alphaSums = pi/2-psiSums;
SSumes = be*sqrt(1-cos(ge)^2./cos(alphaSums).^2);
SHs = SSumsms+SSumes;
% S vs. psi
SvPsiTab = f.Children(length(f.Children)-1).Children(1);
SvPsiAxes = SvPsiTab.Children(2);
hSLinem = SvPsiAxes.Children(1);
hSLinem.Value = rad2deg(psi);
hSPlotm = SvPsiAxes.Children(4);
hSPlotm.XData = rad2deg(psims);
hSPlotm.YData = Sms;
hSPlote = SvPsiAxes.Children(3);
hSPlote.XData = rad2deg(psies);
hSPlote.YData = Ses;
hSPlotSum = SvPsiAxes.Children(2);
hSPlotSum.XData = rad2deg(psiSums);
hSPlotSum.YData = SHs;

num = -cos(gm).^2./(sin(gm).^2-sin(psi).^2);
nue = cos(ge)^2*cot(psi).^2./abs(sin(psi).^2 - cos(ge)^2);
nuH = Sm/Ssum*num + Se/Ssum*nue;

nums = -cos(gm).^2./(sin(gm).^2-sin(psims).^2);
nues = cos(ge)^2*cot(psies).^2./abs(sin(psies).^2 - cos(ge)^2);
nuSumsms = -cot(gm).^2./cos(thetaSums).^2;
nuSumses = cos(ge)^2*tan(alphaSums).^2./(cos(alphaSums).^2 - cos(ge)^2);
nuHs = SSumsms./(SSumsms+SSumes).*nuSumsms + SSumes./(SSumsms+SSumes).*nuSumses;
% nu vs. psi
NuvPsiTab = f.Children(length(f.Children)-1).Children(2);
NuvPsiAxes = NuvPsiTab.Children(2);
hNuPsiLinem = NuvPsiAxes.Children(1);
hNuPsiLinem.Value = rad2deg(psi);
hNuPlotm = NuvPsiAxes.Children(4);
hNuPlotm.XData = rad2deg(psims);
hNuPlotm.YData = nums;
hNuPlote = NuvPsiAxes.Children(3);
hNuPlote.XData = rad2deg(psies);
hNuPlote.YData = nues;
hNuPlotSum = NuvPsiAxes.Children(2);
hNuPlotSum.XData = rad2deg(psiSums);
hNuPlotSum.YData = nuHs;

% nu vs. S
NuvSTab = f.Children(length(f.Children)-1).Children(3);
NuvSAxes = NuvSTab.Children(1);
hNuSDotm = NuvSAxes.Children(1);
hNuSDotm.XData = Ssum;
hNuSDotm.YData = nuH;
hNuPlotSum = NuvSAxes.Children(2);
hNuPlotSum.XData = SHs;
hNuPlotSum.YData = nuHs;

% Sh vs. S
SvsSmTab = f.Children(length(f.Children)-1).Children(4);
SvSmAxes = SvsSmTab.Children(1);
SvSmDotm = SvSmAxes.Children(1);
SvSmDotm.XData = Sm/max(SHs);
SvSmDotm.YData = Ssum/max(SHs);
hSvSmPlotSum = SvSmAxes.Children(2);
hSvSmPlotSum.XData = SSumsms/max(SHs);
hSvSmPlotSum.YData = SHs/max(SHs);
ifirst = find(hSvSmPlotSum.YData>0.95,1);
iend = find(hSvSmPlotSum.YData>0.95,1,'last');
interShift = hSvSmPlotSum.XData(ifirst) - hSvSmPlotSum.XData(iend);
if f.UserData.MaxInterShift < interShift
    f.UserData.MaxInterShift = interShift;
    fprintf('Intershift: %0.1f%%, a: %0.2f, bm: %0.2f, be: %0.2f, gm: %0.2f deg, ge: %0.2f deg\n', interShift*100, a, bm, be, rad2deg(gm), rad2deg(ge));
end

% Sh vs. S
LvsSTab = f.Children(length(f.Children)-1).Children(5);
LvsSAxes = LvsSTab.Children(2);
LvsSDot = LvsSAxes.Children(1);
LvsSDot.XData = Ssum/2;
LvsSDot.YData = L;
LvsSPlot = LvsSAxes.Children(2);
LvsSPlot.XData = SHs/2;
LvsSPlot.YData = Ls;
LvsSfillm = LvsSAxes.Children(4);
LvsSfillm.XData = [SSumsms/2 0];
LvsSfillm.YData = [Ls Ls(1)];
LvsSfille = LvsSAxes.Children(3);
LvsSfille.XData = [SSumsms/2 fliplr(SHs)/2];
LvsSfille.YData = [Ls fliplr(Ls)];
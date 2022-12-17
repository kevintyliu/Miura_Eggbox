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
% nhats = zeros(3,size(quadInds,1));

axes(f.Children(length(f.Children)));
title(sprintf('$a$: %0.2f, $b_m$: %0.2f, $b_e$: %0.2f, $\\gamma_m$: %0.1f$^\\circ$, $\\gamma_e$: %0.2f$^\\circ$, $\\psi$: %0.1f$^\\circ$',...
    a,bm,be,rad2deg(gm),rad2deg(ge),rad2deg(psi)),'Interpreter','latex');
xlim([0,2*bm*sin(gm)+2*be*sin(ge)]);
ylim([0,max([2*a+bm*cos(gm) bm+2*a*cos(gm) 2*a*sin(ge)])]);
% zlim([0,max([a+be*cos(ge) be+a*cos(ge) a*sin(gm)])]);
zlim([-max([a+be*cos(ge) be+a*cos(ge) a*sin(gm)]),max([a+be*cos(ge) be+a*cos(ge) a*sin(gm)])]);
for i = 1:size(quadInds,1)
    h = f.Children(length(f.Children)).Children(2*i-1); % for tube
    h.XData = Xs(quadInds(i,:));
    h.YData = Ys(quadInds(i,:));
    h.ZData = Zs(quadInds(i,:));
    h2 = f.Children(length(f.Children)).Children(2*i);
    h2.XData = Xs(quadInds(i,:));% for tube
    h2.YData = Ys(quadInds(i,:));% for tube
    h2.ZData = -Zs(quadInds(i,:));% for tube
    if i>4  
        h3 = f.Children(length(f.Children)).Children(2*size(quadInds,1)+i-4); % for Miura flip
        h3.XData = Xs(quadInds(i,:));% for tube
        h3.YData = Ys(quadInds(i,:));% for tube
        if i == 5 % hacky miura flip thing
            h3.ZData = [Zs(quadInds(i,1:2)); 2*Zs(quadInds(i,2))-Zs(quadInds(i,3)); -Zs(quadInds(i,4))];
        elseif i == 6
            h3.ZData = [-Zs(quadInds(i,1)); 2*Zs(quadInds(i,3))-Zs(quadInds(i,2)); Zs(quadInds(i,3:4))];
        elseif i == 7
            h3.ZData = [Zs(quadInds(i,1:2)); -Zs(quadInds(i,3)); 2*Zs(quadInds(i,1))-Zs(quadInds(i,4)); ];
        elseif i == 8
            h3.ZData = [2*Zs(quadInds(i,4))-Zs(quadInds(i,1));-Zs(quadInds(i,2));  Zs(quadInds(i,3:4))];
        end
    end
    %     s1 = [Xs(quadInds(i,2))-Xs(quadInds(i,1)); Ys(quadInds(i,2))-Ys(quadInds(i,1)); Zs(quadInds(i,2))-Zs(quadInds(i,1)) ];
    %     s2 = [Xs(quadInds(i,4))-Xs(quadInds(i,1)); Ys(quadInds(i,4))-Ys(quadInds(i,1)); Zs(quadInds(i,4))-Zs(quadInds(i,1)) ];
    %     n = cross(s1,s2);
    %     nhats(:,i) = n/norm(n);
end
% % for checking angles for thick panels
% rhom1 = pi-acos(nhats(:,2)'*nhats(:,4));       % angle of M and V of Miura (creases in YZ plane)
% if (abs(pi-acos(nhats(:,1)'*nhats(:,3)))-rhom1 > deg2rad(0.1))
%     error('Do not match');
% end
% rhom2 = pi-acos(nhats(:,1)'*nhats(:,2));       % angle of the Ms of Miura (creases parallel to XY plane)
% rhom2sup = pi-acos(nhats(:,2)'*[nhats(1:2,2); -nhats(3,2)]);      % angle between Miuras for tube
% rhoe1 = pi-acos(nhats(:,6)'*nhats(:,8));       % angle of creases in YZ plane
% rhoe2 = pi-acos(nhats(:,5)'*nhats(:,6));       % angle of creases in XZ plane
%
% tau1 = pi-acos(nhats(:,4)'*nhats(:,6));       % angle between Miura and Eggbox at +Y side
% tau2 = pi-acos(nhats(:,3)'*nhats(:,5));       % angle between Miura and Eggbox at -Y side

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
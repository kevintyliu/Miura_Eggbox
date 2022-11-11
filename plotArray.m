function plotArray(f)
nplot = 301;
m = f.UserData.m;
n = f.UserData.n;
a = f.UserData.a;
miura_bools = f.UserData.miura_bools;
bs = f.UserData.bs;
gs = f.UserData.gs;
psi = f.UserData.psi;
psimin = f.UserData.psimin;
psimax = f.UserData.psimax;

Xs = zeros(3*m*3*n,1);
Ys = zeros(3*m*3*n,1);
Zs = zeros(3*m*3*n,1);
quadInds = zeros(4*m*n,4);
for j = 1:n % cols
    if j>1
        Xshift = Xs((j-1)*9*m-1);
    else
        Xshift = 0;
    end
    for i = 1:m % rows
        if miura_bools(j)
            [Xjs, Yjs, Zjs, jInds, Sj, Lj] = getMiuraCoords(a,bs(j),gs(j),psi);
        else
            [Xjs, Yjs, Zjs, jInds, Sj, Lj] = getEggboxCoords(a,bs(j),gs(j),psi);
        end
        Yshift = 2*Lj*(i-1);
        Xs((j-1)*9*m+9*i-8:(j-1)*9*m+9*i) = Xjs + Xshift;
        Ys((j-1)*9*m+9*i-8:(j-1)*9*m+9*i) = Yjs + Yshift;
        Zs((j-1)*9*m+9*i-8:(j-1)*9*m+9*i) = Zjs;
        quadInds(4*((j-1)*m+i)-3:4*((j-1)*m+i),:) = jInds + 9*((j-1)*m+i-1);
    end
end

% Plot
for i = 1:size(quadInds,1)
    h = f.Children(length(f.Children)).Children(i);
    h.XData = Xs(quadInds(i,:));
    h.YData = Ys(quadInds(i,:));
    h.ZData = Zs(quadInds(i,:));
end
axes(f.Children(length(f.Children)));
tita = sprintf('$a$: %0.2f, $b$: [ ',a);
titb = sprintf('%0.2g, ', bs);
titb(end-1) = '';
titc = sprintf('], $\\gamma$: [ ');
titd = sprintf('%0.2g$^\\circ$, ', rad2deg(gs));
titd(end-1) = '';
tite = sprintf('], $\\psi$: %0.1f$^\\circ$', rad2deg(psi));
title([tita titb titc titd tite],'Interpreter','latex');

psis = linspace(psimin,psimax,nplot);
Sms = bs.*sqrt(sin(gs).^2-sin(psis').^2)./cos(psis'); % Lengths if Miura
alphas = pi/2-psis;
Ses = real(bs.*sqrt(1-cos(gs).^2./cos(alphas').^2)); % Lengths if Eggbox
Stots = sum([Sms(:,miura_bools) Ses(:,~miura_bools)],2);
xlim([0,2*max(Stots)]);
% Max width determined by Miura with highest V
Vs = bs./sqrt(1+cos(asin(sin(psimin)./sin(gs))).^2.*tan(gs).^2);
ylim([0,2*m*a*cos(psimin)+max([0 Vs(:,miura_bools)],[],'all')]);
zlim([0,a*sin(psimax)+max([0 bs(~miura_bools)])]);
% psiSums = linspace(pi/2-ge,gm,nplot);
% thetaSums = asin(sin(psiSums)./sin(gm));
% SSumsms = bm*cos(thetaSums)*tan(gm)./sqrt(1+cos(thetaSums).^2*tan(gm)^2);
% alphaSums = pi/2-psiSums;
% SSumes = be*sqrt(1-cos(ge)^2./cos(alphaSums).^2);
% SHs = SSumsms+SSumes;

% S vs. psi
SvPsiTab = f.Children(length(f.Children)-1).Children(1);
SvPsiAxes = SvPsiTab.Children(2);
hSLinem = SvPsiAxes.Children(1);
hSLinem.Value = rad2deg(psi);
% hSPlotm = SvPsiAxes.Children(4);
% hSPlotm.XData = rad2deg(psims);
% hSPlotm.YData = Stots;
% hSPlote = SvPsiAxes.Children(3);
% hSPlote.XData = rad2deg(psies);
% hSPlote.YData = Ses;
hSPlotSum = SvPsiAxes.Children(2);
hSPlotSum.XData = rad2deg(psis);
hSPlotSum.YData = Stots;

% num = -cos(gm).^2./(sin(gm).^2-sin(psi).^2);
% nue = cos(ge)^2*cot(psi).^2./(sin(psi).^2 - cos(ge)^2);
% nuH = Sm/Ssum*num + Se/Ssum*nue;
%
% nums = -cos(gm).^2./(sin(gm).^2-sin(psims).^2);
% nues = cos(ge)^2*cot(psies).^2./(sin(psies).^2 - cos(ge)^2);
% nuSumsms = -cot(gm).^2./cos(thetaSums).^2;
% nuSumses = cos(ge)^2*tan(alphaSums).^2./(cos(alphaSums).^2 - cos(ge)^2);
% nuHs = SSumsms./(SSumsms+SSumes).*nuSumsms + SSumes./(SSumsms+SSumes).*nuSumses;
% % nu vs. psi
% NuvPsiTab = f.Children(length(f.Children)-1).Children(2);
% NuvPsiAxes = NuvPsiTab.Children(2);
% hNuPsiLinem = NuvPsiAxes.Children(1);
% hNuPsiLinem.Value = rad2deg(psi);
% hNuPlotm = NuvPsiAxes.Children(4);
% hNuPlotm.XData = rad2deg(psims);
% hNuPlotm.YData = nums;
% hNuPlote = NuvPsiAxes.Children(3);
% hNuPlote.XData = rad2deg(psies);
% hNuPlote.YData = nues;
% hNuPlotSum = NuvPsiAxes.Children(2);
% hNuPlotSum.XData = rad2deg(psiSums);
% hNuPlotSum.YData = nuHs;
%
% % nu vs. S
% NuvSTab = f.Children(length(f.Children)-1).Children(3);
% NuvSAxes = NuvSTab.Children(1);
% hNuSDotm = NuvSAxes.Children(1);
% hNuSDotm.XData = Ssum;
% hNuSDotm.YData = nuH;
% hNuPlotSum = NuvSAxes.Children(2);
% hNuPlotSum.XData = SHs;
% hNuPlotSum.YData = nuHs;
%
% % Sh vs. S
% SvsSmTab = f.Children(length(f.Children)-1).Children(4);
% SvSmAxes = SvsSmTab.Children(1);
% SvSmDotm = SvSmAxes.Children(1);
% SvSmDotm.XData = Sm/max(SHs);
% SvSmDotm.YData = Ssum/max(SHs);
% hSvSmPlotSum = SvSmAxes.Children(2);
% hSvSmPlotSum.XData = SSumsms/max(SHs);
% hSvSmPlotSum.YData = SHs/max(SHs);
% ifirst = find(hSvSmPlotSum.YData>0.95,1);
% iend = find(hSvSmPlotSum.YData>0.95,1,'last');
% interShift = hSvSmPlotSum.XData(ifirst) - hSvSmPlotSum.XData(iend);
% if f.UserData.MaxInterShift < interShift
%     f.UserData.MaxInterShift = interShift;
%     fprintf('Intershift: %0.1f%%, a: %0.2f, bm: %0.2f, be: %0.2f, gm: %0.2f deg, ge: %0.2f deg\n', interShift*100, a, bm, be, rad2deg(gm), rad2deg(ge));
% end
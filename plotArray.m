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

Ss = zeros(1,n);
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
    Ss(j) = Sj;
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

% Save vs psi plot
SvPsiTab = f.Children(length(f.Children)-1).Children(1);
SvPsiAxes = SvPsiTab.Children;
hSvPsiscatter = SvPsiAxes.Children(1);
hSvPsiscatter.XData = rad2deg(psi);
hSvPsiscatter.YData = sum(Ss)/n;
hSPlotSum = SvPsiAxes.Children(2);
hSPlotSum.XData = rad2deg(psis);
hSPlotSum.YData = Stots/n;
% nu vs. psi plot
num = -cos(gs).^2./(sin(gs).^2-sin(psi).^2); % nu if Miura given psi
nue = cos(gs).^2*cot(psi').^2./abs(sin(psi').^2 - cos(gs).^2); % nu if Eggbox given psi
nu = 1/sum(Ss)*sum([Ss(miura_bools).*num(miura_bools) Ss(~miura_bools).*nue(~miura_bools)]);
nums = -cos(gs).^2./(sin(gs).^2-sin(psis').^2); % nu if Miura
nues = cos(gs).^2.*cot(psis').^2./abs(sin(psis').^2 - cos(gs).^2); % nu if Eggbox
nus = 1./Stots.*sum([Sms(:,miura_bools).*nums(:,miura_bools)  Ses(:,~miura_bools).*nues(:,~miura_bools)],2);
NuvPsiTab = f.Children(length(f.Children)-1).Children(2);
NuvPsiAxes = NuvPsiTab.Children;
hNuPsiScatter = NuvPsiAxes.Children(1);
hNuPsiScatter.XData = rad2deg(psi);
hNuPsiScatter.YData = nu;
hNuPlotm = NuvPsiAxes.Children(2);
hNuPlotm.XData = rad2deg(psis);
hNuPlotm.YData = nus;
% nu vs. Save
NuvSTab = f.Children(length(f.Children)-1).Children(3);
NuvSAxes = NuvSTab.Children;
hNuSDotm = NuvSAxes.Children(1);
hNuSDotm.XData = sum(Ss)/n;
hNuSDotm.YData = nu;
hNuPlotSum = NuvSAxes.Children(2);
hNuPlotSum.XData = Stots/n;
hNuPlotSum.YData = nus;
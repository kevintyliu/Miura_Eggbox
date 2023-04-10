%% Span of Hybrid (Miura and Eggbox Poisson curves)
close all; clear;
plotHybridPoisson(false,3);
%% Repeat in black and Plot Morph Overlay
close all; clear;
plotHybridPoisson(true,3);
temp = linspace(deg2rad(55),pi/2,5+1);
alphas = temp(1:end-1);
for i = 1:length(alphas) % no influence from a and c
    morphPoisson(1,1,alphas(i),deg2rad(55));
end
lgd = legend;
lgd.Location = 'best';
%% Plot one Morph Poisson's ratio curve, then interpolated curves between
close all; clear;
corder = colororder;
figure
[psis, nuMiuras, nuEggs, LMiuras, LEggs] = morphPoisson(1,1,deg2rad(65),deg2rad(55));
ninterp = 30;
temp = linspace(0,1,ninterp+1);
mus = temp(1:end-1)+(temp(2)-temp(1))/2;
for i = 1:ninterp
    mu = mus(i);
    nuis = (((1-mu)*LMiuras.*nuMiuras.^-1 + mu*LEggs.*nuEggs.^-1)./((1-mu)*LMiuras+mu*LEggs)).^-1;
    %     interp_label = sprintf('%0.1f',mu);
    %     legendlabel = ['Interp: \mu = ' interp_label];
    %     plot(90-rad2deg(psis)/2,nuis.^-1','DisplayName',legendlabel,'LineWidth',3);
    plot(90-rad2deg(psis)/2,nuis.^-1','Color',corder(1,:),'HandleVisibility','off');
    if nuis(2)<0 && nuis(end-1)<0 && max(nuis(2:end-1))>0 
        mu % doesn't happen
    end
end
%% Plot Multiple Morph Poisson's ratio curve, then interpolated curves between
close all; clear;
corder = colororder;
temp = linspace(deg2rad(55),pi/2,4+1);
alphas = temp(1:end-1)+(temp(2)-temp(1))/2;
figure
for i = 1:length(alphas) % no influence from a and c
    set(gca,'ColorOrderIndex',i);
    [psis, nuMiuras, nuEggs, LMiuras, LEggs] = morphPoisson(1,1,alphas(i),deg2rad(55));
    ninterp = 50;
    temp = linspace(0,1,ninterp+1);
    mus = temp(1:end-1)+(temp(2)-temp(1))/2; % frac of strips in Eggbox
    for j = 1:ninterp
        mu = mus(j);
        nuis = (((1-mu)*LMiuras.*nuMiuras.^-1 + mu*LEggs.*nuEggs.^-1)./((1-mu)*LMiuras+mu*LEggs)).^-1;
        %     interp_label = sprintf('%0.1f',mu);
        %     legendlabel = ['Interp: \mu = ' interp_label];
        %     plot(90-rad2deg(psis)/2,nuis.^-1','DisplayName',legendlabel,'LineWidth',3);
        plot(90-rad2deg(psis)/2,nuis.^-1','Color',corder(i,:),'HandleVisibility','off');
    end
end
%% Plots arrays with Miura, Eggbox, Morph in Miura, and Morph in Eggbox unit cells
% a=amorph=bm=be=c=1, gm=ge=60 deg, alphaMorph=65 deg, betaMorph=55 deg
% Varies mu, the fraction of the columns attributed to each unit cell
close all; clear;
corder = colororder;
plotHybridPoisson(false,0);
set(gca,'ColorOrderIndex',1);
alphaMorph = deg2rad(65);
betaMorph = deg2rad(55);
[psiMorphs, nuMiuras, nuEggs, LMiuras, LEggs] = morphPoisson(1,1,alphaMorph,betaMorph);
psis = pi/2 - psiMorphs/2;
gm = deg2rad(60);
ge = deg2rad(60);
bm = 1;
be = 1;
nums = -cos(gm).^2./(sin(gm).^2-sin(psis).^2);
nums(nums>0) = NaN;
nues = cos(ge)^2*cot(psis).^2./abs(sin(psis).^2 - cos(ge)^2);
Sms = real(bm*sqrt(sin(gm)^2-sin(psis).^2)./cos(psis));
Ses = be*sqrt(sin(psis).^2-cos(ge)^2)./sin(psis);
Ls = real(1*cos(psis));

ninterp = 15;
mus = linspace(0,1,ninterp); % fraction of array
for i = 1:ninterp
    mui = mus(i);
    mujs = linspace(0,1-mui,ninterp-i+1);
    for j = 1:length(mujs)
        muj = mujs(j);
        muks = linspace(0,1-mui-muj,ninterp-i-j+2);
        for k = 1:length(muks)
            muk = muks(k);
            mul = 1 - mui - muj - muk;
            nuis = ((mui*LMiuras.*nuMiuras.^-1 + muj*LEggs.*nuEggs.^-1 + muk*Sms.*nums + mul*Ses.*nues)./(mui*LMiuras+muj*LEggs+muk*Sms+mul*Ses)).^-1;
            %                     figure
            %         plot(rad2deg(psis),nuMiuras.^-1','Color',corder(1,:),'HandleVisibility','off');
            %         xlim([15 75]);
            %         ylim([-10 10]);
            %         hold on;
            %         plot(rad2deg(psis),nuEggs.^-1','HandleVisibility','off');
            %         plot(rad2deg(psis),nuMiuras.^-1','HandleVisibility','off');
            %         plot(rad2deg(psis),nums.^-1','HandleVisibility','off');
            %         plot(rad2deg(psis),nuis.^-1','k','HandleVisibility','off');
            %
            %                     plot(rad2deg(psis),LMiuras,'HandleVisibility','off');
            %                     xlim([15 75]);
            %                     ylim([-3 3]);
            %                     hold on;
            %                     plot(rad2deg(psis),LEggs,'HandleVisibility','off');
            %                     plot(rad2deg(psis),Sms,'HandleVisibility','off');
            %                     grid on
            %         close

            %             figure
            %             plot(Ls,mui*LMiuras+muj*LEggs+muk*Sms+mul*Ses);
            %             hold on;
            %             xline(cos(pi/2-betaMorph)*1);
            %             xline(cos(gm)*1);
            %             xlabel('Y length');
            %             ylabel('X length');
            %             grid on;
            %             close
            %         [mui muj muk mul]
            if nuis(find(psis<gm,1))<0 && nuis(end-1)<0 && max(nuis)>0
                plot(rad2deg(psis),nuis.^-1','k','HandleVisibility','off');
            else
                plot(rad2deg(psis),nuis.^-1','Color',corder(1,:),'HandleVisibility','off');
            end
        end
    end
end
%% Plots arrays with Miura, Eggbox, Morph
% a=amorph=bm=be=c=1, gm=ge=60 deg, alphaMorph=65 deg, betaMorph=55 deg
% Varies mu, the fraction of the columns attributed to each unit cell
% Then plots traces varying the fraction of morph in Miura and Eggbox modes
close all; clear;
corder = colororder;
alphaMorph = deg2rad(65);
betaMorph = deg2rad(55);
[psiMorphs, nuMiuras, nuEggs, LMiuras, LEggs] = morphPoisson(1,1,alphaMorph,betaMorph);
close
psis = pi/2 - psiMorphs/2;
gm = deg2rad(60);
ge = deg2rad(60);
bm = 1;
be = 1;
nums = -cos(gm).^2./(sin(gm).^2-sin(psis).^2);
nums(nums>0) = NaN;
nues = cos(ge)^2*cot(psis).^2./abs(sin(psis).^2 - cos(ge)^2);
Sms = real(bm*sqrt(sin(gm)^2-sin(psis).^2)./cos(psis));
Ses = be*sqrt(sin(psis).^2-cos(ge)^2)./sin(psis);
Ls = real(1*cos(psis));

ninterp = 15;
mus = linspace(0,1,ninterp); % fraction of array
for i = 1:ninterp
    muMorph = mus(i);
    muMorphMiuras = linspace(0,muMorph,ninterp);
    muMiuras = linspace(0,1-muMorph,ninterp-i+1);
    for j = 1:length(muMiuras)
        muMiura = muMiuras(j);
        muEgg = 1 - muMorph - muMiura;
        if muMorph == 0
            numMorphOverlays = 0;
        else
            numMorphOverlays = length(muMorphMiuras);
        end
        plotHybridPoisson(false,0);
        set(gca,'ColorOrderIndex',1);
        morphPoisson(1,1,alphaMorph,betaMorph);
        colorInd = get(gca,'ColorOrderIndex');
        for l = 1:numMorphOverlays % adjust frac of morphs. Fix later
            muMorphMiura = muMorphMiuras(l);
            muMorphEgg = muMorph - muMorphMiura;
            nuis = ((muMorphMiura*LMiuras.*nuMiuras.^-1 + muMorphEgg*LEggs.*nuEggs.^-1 + muMiura*Sms.*nums + muEgg*Ses.*nues)./(muMorphMiura*LMiuras+muMorphEgg*LEggs+muMiura*Sms+muEgg*Ses)).^-1;
            %             plot(rad2deg(psis),nuis.^-1','Color',corder((i-1)*length(muMiuras)+j,:),'HandleVisibility','off');
            plot(rad2deg(psis),nuis.^-1','Color',corder(colorInd,:),'HandleVisibility','off');
            [muMorphMiura muMorphEgg muMiura muEgg]
        end
        close
    end
end
%% Weighted average Poisson's ratio
% Miura: a=b=1, gm=60 deg
% Eggbox: a=b=1, ge=60 deg
% Morph a=c=1, alpha=69 deg, beta=55 deg
close all; clear;
a = 1;
bm = 0.1429;
gm = deg2rad(60);
be = 0.4286;
ge = deg2rad(60);
alphaMorph = deg2rad(65);
betaMorph = deg2rad(55);
aMorph = 0.4286;
bmorph = aMorph*abs(cos(alphaMorph)/cos(betaMorph));
nPlot = 1001;

% phis = linspace(alphaMorph-betaMorph, alphaMorph+betaMorph, nPlot);

cosPhiMorphLims = (2*cos(alphaMorph)*cos(betaMorph)+[-1 1]*sqrt(2*(cos(alphaMorph)^2-cos(betaMorph)^2)*(cos(pi-2*gm)-cos(2*alphaMorph))+(cos(pi-2*gm)-cos(2*alphaMorph)).^2))...
    ./(2*cos(alphaMorph)^2+cos(pi-2*gm)-cos(2*alphaMorph));
phiMorphLims = sort(acos(cosPhiMorphLims));
phis = linspace(phiMorphLims(1), phiMorphLims(2), nPlot);
xis = cos(betaMorph) - cos(alphaMorph)*cos(phis);
zetas = cos(alphaMorph) - cos(betaMorph)*cos(phis);
psiMorphs = acos( cos(2*alphaMorph) + 2*xis.^2.*csc(phis).^2 );
% figure
% plot(rad2deg(phis),rad2deg(phis));
% hold on;
% plot(rad2deg(phis),rad2deg(phiMorphs));
% plot(rad2deg(phis),cosPhiMorphs);
% hold on;
% plot(rad2deg(phis),cosPhiMorphs);
SMorphs = sqrt(aMorph^2+bmorph^2-2*aMorph*bmorph*cos(phis));
Ws = 2*a*sin(psiMorphs/2);
nuMorphs = (4*a^2*SMorphs.^2./(aMorph^2*Ws.^2)*abs(cos(betaMorph)/cos(alphaMorph)).*xis.*zetas./sin(phis).^4).^-1;

psis = pi/2 - psiMorphs/2;
isGood = psis < gm;
thetas = asin(sin(psis)./sin(gm));
Sms = bm*cos(thetas)*tan(gm)./sqrt(1+cos(thetas).^2*tan(gm)^2);
nums = -cos(gm).^2./(sin(gm).^2-sin(psis).^2);
alphas = pi/2-psis;
Ses = be*sqrt(1-cos(ge)^2./cos(alphas).^2);
nues = cos(ge)^2*cot(psis).^2./abs(sin(psis).^2 - cos(ge)^2);

nuArrays = (Sms.*nums + Ses.*nues + SMorphs.*nuMorphs)./(Sms+Ses+SMorphs);

figure
plot(rad2deg(psis(isGood)),nums(isGood),'LineWidth',3,'DisplayName','Miura');
hold on
plot(rad2deg(psis),nues,'LineWidth',3,'DisplayName','Eggbox');
plot(rad2deg(psis),nuMorphs,'LineWidth',3,'DisplayName','Morph');
plot(rad2deg(psis(isGood)),nuArrays(isGood),'LineWidth',3,'DisplayName','Array');
legend
grid on
xlim([15 75]);
ylim([-10 10]);
xlim manual
ylim manual
xlabel('\psi (deg)');
ylabel('\nu = (dS/S) / (dL/L)');
set(gca,'FontSize',18)
set(gcf,'color','w');
function plotHybridPoisson(isBlack, nPlots)
% Plot of Poisson's ratio curves for freeform arrays
% Plot Miura Poisson's ratio gm_min=60 deg
% Plot Eggbox Poisson's ratio ge_min=60 deg
% Plot 3 Miura curves with gm \in (gm_min pi/2)
% Plot 3 Eggbox curves with ge \in (0,ge_max)

gm_min = deg2rad(60);
ge_min = deg2rad(60);

psis_mmin = linspace(0,gm_min,101);
nus_mmin = -cos(gm_min).^2./(sin(gm_min).^2-sin(psis_mmin).^2);
psis_emax = linspace(pi/2-ge_min,pi/2,101);
nus_emax = cos(ge_min)^2*cot(psis_emax).^2./abs(sin(psis_emax).^2 - cos(ge_min)^2);

if isBlack
    figure
    plot(rad2deg(psis_mmin),nus_mmin,'k','LineWidth',5,'HandleVisibility','off');
    hold on
    plot(rad2deg(psis_emax),nus_emax,'k--','LineWidth',5,'HandleVisibility','off');
    if nPlots > 0
        temp = linspace(gm_min,pi/2,nPlots+2);
        gms = temp(2:end-1);
        for i = 1:nPlots
            gm = gms(i);
            psis_m = linspace(0,gm,301);
            nus_m = -cos(gm).^2./(sin(gm).^2-sin(psis_m).^2);
            plot(rad2deg(psis_m),nus_m,'k','LineWidth',3,'HandleVisibility','off');
        end
        temp = linspace(ge_min,pi/2,nPlots+2);
        ges = temp(2:end-1);
        for i = 1:nPlots
            ge = ges(i);
            psis_e = linspace(pi/2-ge,pi/2,301);
            nus_e = cos(ge)^2*cot(psis_e).^2./abs(sin(psis_e).^2 - cos(ge)^2);
            plot(rad2deg(psis_e),nus_e,'k--','LineWidth',3,'HandleVisibility','off');
        end
    end
else
    figure
    miura_min_label = sprintf('%u',round(rad2deg(gm_min)));
%     plot(rad2deg(psis_mmin),nus_mmin,'k','DisplayName',['Miura: \gamma_m=' miura_min_label '^\circ'],'LineWidth',5);
    plot(rad2deg(psis_mmin),nus_mmin,'k','DisplayName',['\gamma_m=' miura_min_label '^\circ'],'LineWidth',5);
    hold on
    eggbox_max_label = sprintf('%u',round(rad2deg(ge_min)));
%     plot(rad2deg(psis_emax),nus_emax,'k--','DisplayName',['Eggbox: \gamma_e=' eggbox_max_label '^\circ'],'LineWidth',5);
    plot(rad2deg(psis_emax),nus_emax,'k--','DisplayName',['\gamma_e=' eggbox_max_label '^\circ'],'LineWidth',5);
    if nPlots > 0
        temp = linspace(gm_min,pi/2,nPlots+2);
        gms = temp(2:end-1);
        set(gca,'ColorOrderIndex',1);
        for i = 1:nPlots
            gm = gms(i);
            psis_m = linspace(0,gm,301);
            nus_m = -cos(gm).^2./(sin(gm).^2-sin(psis_m).^2);
            miura_label = sprintf('%u',round(rad2deg(gm)));
%             plot(rad2deg(psis_m),nus_m,'DisplayName',['Miura: \gamma_m=' miura_label '^\circ'],'LineWidth',3);
            plot(rad2deg(psis_m),nus_m,'DisplayName',['\gamma_m=' miura_label '^\circ'],'LineWidth',3);
        end
        temp = linspace(ge_min,pi/2,nPlots+2);
        ges = temp(2:end-1);
        set(gca,'ColorOrderIndex',1);
        for i = 1:nPlots
            ge = ges(i);
            psis_e = linspace(pi/2-ge,pi/2,301);
            nus_e = cos(ge)^2*cot(psis_e).^2./abs(sin(psis_e).^2 - cos(ge)^2);
            eggbox_label = sprintf('%u',round(rad2deg(ge)));
%             plot(rad2deg(psis_e),nus_e,'--','DisplayName',['Eggbox: \gamma_e=' eggbox_label '^\circ'],'LineWidth',3);
            plot(rad2deg(psis_e),nus_e,'--','DisplayName',['\gamma_e=' eggbox_label '^\circ'],'LineWidth',3);
        end
    end
end
% xline(rad2deg(pi/2-ge_min));
% xline(rad2deg(gm_min));
patch(rad2deg([0 pi/2-ge_min pi/2-ge_min 0]),[-15 -15 15 15],'k','FaceAlpha',0.3,'HandleVisibility','off');
patch(rad2deg([gm_min pi/2 pi/2 gm_min]),[-15 -15 15 15],'k','FaceAlpha',0.3,'HandleVisibility','off');
alpha(0.3);
lgd = legend;
lgd.Location = 'bestoutside';
grid on
xlim([15 75]);
ylim([-10 10]);
xlim manual
ylim manual
xlabel('\psi (deg)');
ylabel('\nu = (dS/S) / (dL/L)');
set(gca,'FontSize',18)
set(gcf,'color','w');
end
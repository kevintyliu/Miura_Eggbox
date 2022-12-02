function initMiuraEggTabs( f )
tabgp = uitabgroup(f,'Position',[0.6 0.4 0.3 0.55]);
% S vs psi plot
tab1 = uitab(tabgp,'Title',['S vs.' char(968)]);
tab1.BackgroundColor = 'w';
axes('Parent',tab1);
plot(1,1,'DisplayName','Miura','LineWidth',3);
hold on
plot(1,1,'DisplayName','Eggbox','LineWidth',3);
plot(1,1,'DisplayName','S_h = Sum','LineWidth',3);
xline(1,'DisplayName','\psi','LineWidth',3);
legend
grid on
xlim([0 90]);
ylim([0 5]);
xlim manual
ylim manual
xlabel('\psi (deg)');
ylabel('S');
set(gca,'FontSize',18)
% nu vs. psi plot
tab2 = uitab(tabgp,'Title',[char(957) ' vs. ' char(968)]);
tab2.BackgroundColor = 'w';
axes('Parent',tab2);
plot(1,1,'DisplayName','Miura','LineWidth',3);
hold on
plot(1,1,'DisplayName','Eggbox','LineWidth',3);
plot(1,1,'DisplayName','Hybrid','LineWidth',3);
xline(1,'DisplayName','\psi');
legend
grid on
xlim([0 90]);
ylim([-10 10]);
xlim manual
ylim manual
xlabel('\psi (deg)');
ylabel('\nu = (dS/S) / (dL/L)');
set(gca,'FontSize',18)
% nu vs. Shybrid plot
tab3 = uitab(tabgp,'Title',[char(957) ' vs. S']);
tab3.BackgroundColor = 'w';
axes('Parent',tab3);
plot(1,1,'LineWidth',3);
hold on;
scatter(1,1);
grid on
xlim([0 5]);
ylim([-10 10]);
xlim manual
ylim manual
xlabel('S_h');
ylabel('\nu = (dS/S) / (dL/L)');
set(gca,'FontSize',18)
% Shybrid vs. Sm plot
tab4 = uitab(tabgp,'Title',['S vs. Sm']);
tab4.BackgroundColor = 'w';
axes('Parent',tab4);
plot(1,1,'LineWidth',3);
hold on;
scatter(1,1,'LineWidth',3);
grid on
xlim([0 1]);
ylim([0 1]);
xlim manual
ylim manual
xlabel('S_m / max( S_h )');
ylabel('S_h / max( S_h )');
set(gca,'FontSize',18)
end
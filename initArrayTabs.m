function initArrayTabs( f )
tabgp = uitabgroup(f,'Position',[0.6 0.4 0.3 0.55]);
% Save vs psi plot
tab1 = uitab(tabgp,'Title',['S vs.' char(968)]);
tab1.BackgroundColor = 'w';
axes('Parent',tab1);
plot(1,1,'DisplayName','Average S');
hold on
scatter(1,1,'DisplayName','\psi');
% legend
grid on
xlim(rad2deg([f.UserData.psimin f.UserData.psimax]));
ylim([0 1.5]);
xlim manual
ylim manual
xlabel('\psi (deg)');
ylabel('Average S');
set(gca,'FontSize',18,'FontName','Tacoma')
% nu vs. psi plot
tab2 = uitab(tabgp,'Title',[char(957) ' vs. ' char(968)]);
tab2.BackgroundColor = 'w';
axes('Parent',tab2);
plot(1,1,'DisplayName','Total');
hold on
for i = 1:f.UserData.n
    plot(1,1,'DisplayName',['Col ' num2str(i)])
end
scatter(1,1,'DisplayName','\psi');
legend
grid on
xlim(rad2deg([f.UserData.psimin f.UserData.psimax]));
ylim([-10 10]);
xlim manual
ylim manual
xlabel('\psi (deg)');
ylabel('\nu = (dS/S) / (dL/L)');
set(gca,'FontSize',18,'FontName','Tacoma')
% nu vs. Save plot
tab3 = uitab(tabgp,'Title',[char(957) ' vs. S avg']);
tab3.BackgroundColor = 'w';
axes('Parent',tab3);
plot(1,1);
hold on;
scatter(1,1);
grid on
xlim([0 3]);
ylim([-10 10]);
xlim manual
ylim manual
xlabel('Average S');
ylabel('\nu = (dS/S) / (dL/L)');
set(gca,'FontSize',18,'FontName','Tacoma')
% L vs. Save plot
tab4 = uitab(tabgp,'Title', 'L vs. S avg');
tab4.BackgroundColor = 'w';
axes('Parent',tab4);
plot(1,1);
hold on;
scatter(1,1);
grid on
xlim([0 1]);
ylim([0 1]);
xlim manual
ylim manual
xlabel('Average S');
ylabel('L');
set(gca,'FontSize',18,'FontName','Tacoma')
end
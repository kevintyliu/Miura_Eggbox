close all
clear
miura
zlim([0 1.5])
ax = gca;
xlabel('');
ylabel('');
zlabel('');
xticklabels("")
yticklabels("")
zticklabels("")
% Set major Grid lines
ax.GridLineStyle = '-';
ax.GridColor = 'k';
ax.GridAlpha = 0.2;
grid on;
alpha(0.3)
view([42 23]);

close all
clear
eggbox
f.UserData.psi = deg2rad(45);
zlim([0 1.5])
ax = gca;
xlabel('');
ylabel('');
zlabel('');
xticklabels("")
yticklabels("")
zticklabels("")
% Set major Grid lines
ax.GridLineStyle = '-';
ax.GridColor = 'k';
ax.GridAlpha = 0.2;
grid on;
alpha(0.3)
view([42 23]);

close all
clear
miura_eggbox
view([14 43])
zlim([0 1.5])
ax = gca;
xlabel('');
ylabel('');
zlabel('');
xticklabels("")
yticklabels("")
zticklabels("")

% Mode locking
view([3 70]);
xlabel('');
ylabel('');
zlabel('');
xticklabels("")
yticklabels("")
zticklabels("")
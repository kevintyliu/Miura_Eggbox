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
view([42 23]);
posTemp = f.Position;
f.Position = [posTemp(1:2) 1200 800];

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
view([42 23]);
posTemp = f.Position;
f.Position = [posTemp(1:2) 1200 800];

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
posTemp = f.Position;
f.Position = [posTemp(1:2) 1200 800];

% Mode locking
close all
clear
miura_eggbox
view([3 70]);
xlabel('');
ylabel('');
zlabel('');
xticklabels("")
yticklabels("")
zticklabels("")
posTemp = f.Position;
f.Position = [posTemp(1:2) 1200 800];

legend('Location','southwest')
ylim([0 3])

% Freeform Arrays
close all
clear
miura_eggbox_array
view([26 47]);
xlabel('');
ylabel('');
zlabel('');
xticklabels("")
yticklabels("")
zticklabels("")
posTemp = f.Position;
f.Position = [posTemp(1:2) 1200 800];
title([]);
close all; clear
params.a = 1.75;   % Mode locking
params.bm = 2.22;
params.be = 1.16;
params.gm = deg2rad(66.1);
params.ge = deg2rad(60);
params.psi = deg2rad(45);
f = figure;
f.UserData = params;
plotMiuraEgg(f);
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
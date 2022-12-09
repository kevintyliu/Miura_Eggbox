close all
clear
clc
%% Parse inputs
% % Normal Miura
% params.m = 3;
% params.n = 3;
% params.a = 1;
% params.miura_bools = true(1,3);
% params.bs = [1 1 1];
% params.gs = deg2rad([60 60 60]);

% Simple unit
% params.m = 3;
% params.n = 2;
% params.a = 1;
% params.miura_bools = [true false];
% params.bs = [1 1];
% params.gs = deg2rad([60 60]);

% % Some hybrid
params.m = 4;
params.n = 5;
params.a = 1;
params.miura_bools = [true true false true false];
params.bs = [1 2 0.75 1 0.5];
params.gs = deg2rad([40 50 60 50 65]);

% % MVMVMVMV Zero Poisson
% params.m = 3;
% params.n = 6;
% params.a = 1;
% params.miura_bools = repmat([true false],1,params.n/2);
% params.bs = repmat([0.76 0.68],1,params.n/2);
% params.gs = deg2rad(76.5)*ones(1,params.n);

% MVMVMVMV 2 to 1
% params.m = 3;
% params.n = 6;
% params.a = 1.5;
% params.miura_bools = repmat([true false],1,params.n/2);
% params.bs = repmat([2.09 1.11],1,params.n/2);
% params.gs = repmat(deg2rad([75 64.5]),1,params.n/2);

% % MMMMEEEE
% params.m = 4;
% params.n = 8;
% params.a = 1;
% params.miura_bools = [true(1,params.n/2) false(1,params.n/2)];
% params.bs = [1*ones(1,params.n/2) 1*ones(1,params.n/2)];
% params.gs = deg2rad(60)*ones(1,params.n);

% % Gradients
% params.m = 2;
% params.n = 8;
% params.a = 1;
% params.miura_bools = [true(1,4) false(1,4)];
% params.bs = ones(1,8);
% params.gs = deg2rad([45 55 65 55 65 75 85 85]); % min of miura needs to be > than 90-min(eggbox)

params.psimin = max([0 pi/2 - min(params.gs(~params.miura_bools))]);
params.psimax = min([params.gs(params.miura_bools) pi/2]);
params.psi = 3/4*params.psimin + 1/4*params.psimax;
% params.psi = params.psimin;
% params.psi = params.psimax;
if params.psimax <= params.psimin
    error('Incompatibility');
end
%% Create GUI
f = initVisual(params.m,params.n,params.miura_bools);
f.UserData = params;
initArrayTabs(f)
plotArray(f);
plotPoisson = false;
if plotPoisson  % Plot static initial configuration
    zshift = 3;
    for i = 1:length(f.Children(length(f.Children)).Children)
        h = f.Children(length(f.Children)).Children(end-i+1);
        fill3(h.XData,h.YData,zshift+h.ZData,'y');
    end
    alpha(0.3);
    zlim(zlim+[0 zshift]);
end
makeSlider(f.UserData.psi,params.psimin,params.psimax,0.1,0.22,0.8, ...
    '\psi',sprintf('%0.0f^\\circ',rad2deg(params.psimin)), ...
    sprintf('%0.0f^\\circ',rad2deg(params.psimax)),@changePsi);

function changePsi(~,event)
f = gcf;
f.UserData.psi = event.AffectedObject.Value;
plotArray(f);
end
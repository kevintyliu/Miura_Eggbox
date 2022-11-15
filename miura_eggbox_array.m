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
% Some hybrid
% params.m = 3;
% params.n = 3;
% params.a = 1;
% params.miura_bools = [true true false];
% params.bs = [1 2 2];
% params.gs = deg2rad([40 50 60]);
% MVMVMVMV
% params.m = 3;
% params.n = 8;
% params.a = 1;
% params.miura_bools = repmat([true false],1,params.n/2);
% params.bs = repmat([2.45 1.21],1,params.n/2);
% params.gs = deg2rad(60)*ones(1,params.n);
% MMMMVVVV
params.m = 4;
params.n = 8;
params.a = 1;
params.miura_bools = [true(1,params.n/2) false(1,params.n/2)];
params.bs = [1*ones(1,params.n/2) 1*ones(1,params.n/2)];
params.gs = deg2rad(60)*ones(1,params.n);

params.psimin = max([0 pi/2 - max(params.gs(~params.miura_bools))]);
params.psimax = min([params.gs(params.miura_bools) pi/2]);
params.psi = (params.psimin+params.psimax)/2;
if params.psimax <= params.psimin
    error('Incompatibility');
end
%% Create GUI
f = initVisual(params.m,params.n);
f.UserData = params;
initArrayTabs(f)
plotArray(f);
makeSlider(f.UserData.psi,params.psimin,params.psimax,0.1,0.22,0.8, ...
    '\psi',sprintf('%0.0f^\\circ',rad2deg(params.psimin)), ...
    sprintf('%0.0f^\\circ',rad2deg(params.psimax)),@changePsi);

function changePsi(~,event)
f = gcf;
f.UserData.psi = event.AffectedObject.Value;
plotArray(f);
end
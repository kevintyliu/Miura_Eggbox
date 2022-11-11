close all
clear
clc
%% Parse inputs
params.m = 3;
params.n = 3;
params.a = 1;
params.miura_bools = [true true false];
params.bs = [1 2 2];
params.gs = deg2rad([40 50 60]);
% params.m = 3;
% params.n = 10;
% params.a = 1;
% params.miura_bools = [true(1,5) false(1,5)];
% params.miura_bools = [true false true false true false true false true false];
% params.bs = [ones(1,5) ones(1,5)];
% params.gs = deg2rad([60*ones(1,5) 60*ones(1,5)]);

params.psimin = max([0 pi/2 - max(params.gs(~params.miura_bools))]);
params.psimax = min([params.gs(params.miura_bools) pi/2]);
params.psi = (params.psimin+params.psimax)/2;
if params.psimax <= params.psimin
    error('Incompatibility');
end
%% Create GUI
f = initGui(params.m,params.n);
f.UserData = params;
plotArray(f);
makeSlider(f.UserData.psi,params.psimin,params.psimax,0.1,0.22,0.8, ...
    '\psi',sprintf('%0.0f^\\circ',rad2deg(params.psimin)), ...
    sprintf('%0.0f^\\circ',rad2deg(params.psimax)),@changePsi);

function changePsi(~,event)
f = gcf;
f.UserData.psi = event.AffectedObject.Value;
plotArray(f);
end
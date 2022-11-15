%% Input Parameters
close all
clear
clc

params.a = 1;   % a between eggbox and Miura match
params.bm = 1;
params.be = 1;
params.gm = deg2rad(60);
params.ge = deg2rad(60);
params.psi = deg2rad(40);
% params.a = 1.07;   % a between eggbox and Miura match
% params.bm = 1.56;
% params.be = 0.63;
% params.gm = deg2rad(23.25);
% params.ge = deg2rad(66.88);
% params.psi = deg2rad(23.24);
params.MaxInterShift = 0; % TODO: Delete
%% Create GUI
f = initVisual(1,2);
initMiuraEggTabs(f)
f.UserData = params;
plotMiuraEgg(f);
makeSlider(f.UserData.a,0,3,0.1,0.22,0.8,'a','0','3',@changeA);
makeSlider(f.UserData.bm,0,3,0.1,0.19,0.8,'b_m','0','3',@changeBm);
makeSlider(f.UserData.be,0,3,0.1,0.16,0.8,'b_e','0','3',@changeBe);
makeSlider(f.UserData.gm,deg2rad(1),pi/2,0.1,0.13,0.8,'\gamma_m','1^\circ','90^\circ',@changeGm);
[f.UserData.geSlider, f.UserData.geLeftNote, ~] = ...
    makeSlider(f.UserData.ge,pi/2-f.UserData.gm,pi/2,0.9-0.8*f.UserData.gm/(pi/2),0.10,0.8*f.UserData.gm/(pi/2),'\gamma_e','90^\circ-\gamma_m','90^\circ',@changeGe);
[f.UserData.psiSlider, f.UserData.psiLeftNote, f.UserData.psiRightNote] = ...
    makeSlider(f.UserData.psi,pi/2-f.UserData.ge,f.UserData.gm,0.9-0.8*(f.UserData.ge/(pi/2)),0.05,...
    0.8*((f.UserData.gm+f.UserData.ge-pi/2)/(pi/2)),'\psi:','90^\circ-\gamma_e','\gamma_m',@changePsi);

function changeA(~,event)
f = gcf;
f.UserData.a = event.AffectedObject.Value;
plotMiuraEgg(f);
end
function changeBm(~,event)
f = gcf;
f.UserData.bm = event.AffectedObject.Value;
plotMiuraEgg(f);
end
function changeBe(~,event)
f = gcf;
f.UserData.be = event.AffectedObject.Value;
plotMiuraEgg(f);
end
function changeGm(~,event)
f = gcf;
f.UserData.gm = event.AffectedObject.Value;
% adjust ge
f.UserData.ge = max(pi/2-f.UserData.gm,f.UserData.ge);
f.UserData.geSlider.Value = f.UserData.ge;
f.UserData.geSlider.Min = pi/2-f.UserData.gm;
f.UserData.geSlider.Position = [0.9-0.8*f.UserData.gm/(pi/2) 0.10 0.8*f.UserData.gm/(pi/2) 0.03];
f.UserData.geLeftNote.Position = [0.85-0.8*(f.UserData.gm/(pi/2)) 0.10 0.05 0.03];
% adjust psi
f.UserData.psiSlider.Max = max(f.UserData.gm,f.UserData.psiSlider.Min*1.001); % to prevent 0 range
f.UserData.psiSlider.Min = min(pi/2-f.UserData.ge,f.UserData.psiSlider.Max*.999); % to prevent 0 range
if ~(f.UserData.psiSlider.Min <f.UserData.psi && f.UserData.psi < f.UserData.psiSlider.Max)
    f.UserData.psi = mean([f.UserData.psiSlider.Min f.UserData.psiSlider.Max]);
end
f.UserData.psiSlider.Value = f.UserData.psi;
f.UserData.psiSlider.Position = [0.9-0.8*(f.UserData.ge/(pi/2)) 0.05 0.8*((f.UserData.gm+f.UserData.ge-pi/2)/(pi/2)) 0.03];
f.UserData.psiLeftNote.Position = [0.85-0.8*(f.UserData.ge/(pi/2)) 0.05 0.05 0.03];
f.UserData.psiRightNote.Position = [0.9+0.8*(f.UserData.gm-pi/2)/(pi/2) 0.05 0.05 0.03];
% plot
plotMiuraEgg(f);
end
function changeGe(~,event)
f = gcf;
f.UserData.ge = event.AffectedObject.Value;
% adjust psi
f.UserData.psi = max(pi/2-f.UserData.ge,f.UserData.psi);
f.UserData.psiSlider.Min = pi/2-f.UserData.ge;
f.UserData.psiSlider.Value = max(pi/2-f.UserData.ge,f.UserData.psi);
f.UserData.psiSlider.Position = [0.9-0.8*(f.UserData.ge/(pi/2)) 0.05 0.8*((f.UserData.gm+f.UserData.ge-pi/2)/(pi/2)) 0.03];
f.UserData.psiLeftNote.Position = [0.85-0.8*(f.UserData.ge/(pi/2)) 0.05 0.05 0.03];
% plot
plotMiuraEgg(f);
end
function changePsi(~,event)
f = gcf;
f.UserData.psi = event.AffectedObject.Value;
plotMiuraEgg(f);
end
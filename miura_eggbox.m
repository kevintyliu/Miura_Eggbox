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
f = figure;
f.Position = [100 100 1000 800];
f.UserData = params;
axes('Parent',f,'position',[0.1 0.4  0.5 0.55]);
hold on;
for i = 1:8
    fill3(1,1,1,'g');
end
grid on
axis equal
xlim manual
ylim manual
zlim manual
xlabel('X');
ylabel('Y');
zlabel('Z');
view(60,30)
tabgp = uitabgroup(f,'Position',[0.6 0.4 0.3 0.55]);
% S vs psi plot
tab1 = uitab(tabgp,'Title',['S vs.' char(968)]);
tab1.BackgroundColor = 'w';
axes('Parent',tab1);
plot(1,1,'DisplayName','Miura');
hold on
plot(1,1,'DisplayName','Eggbox');
plot(1,1,'DisplayName','S_h = Sum');
xline(1,'DisplayName','\psi');
legend
grid on
xlim([0 90]);
ylim([0 5]);
xlim manual
ylim manual
xlabel('\psi (deg)');
ylabel('S');
% nu vs. psi plot
tab2 = uitab(tabgp,'Title',[char(957) ' vs. ' char(968)]);
tab2.BackgroundColor = 'w';
axes('Parent',tab2);
plot(1,1,'DisplayName','Miura');
hold on
plot(1,1,'DisplayName','Eggbox');
plot(1,1,'DisplayName','Hybrid');
xline(1,'DisplayName','\psi');
legend
grid on
xlim([0 90]);
ylim([-5 5]);
xlim manual
ylim manual
xlabel('\psi (deg)');
ylabel('\nu = (dS/S) / (dL/L)');
% nu vs. Shybrid plot
tab3 = uitab(tabgp,'Title',[char(957) ' vs. S']);
tab3.BackgroundColor = 'w';
axes('Parent',tab3);
plot(1,1);
hold on;
scatter(1,1);
grid on
xlim([0 5]);
ylim([-5 5]);
xlim manual
ylim manual
xlabel('S_h');
ylabel('\nu = (dS/S) / (dL/L)');
% Shybrid vs. Sm plot
tab4 = uitab(tabgp,'Title',['S vs. Sm']);
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
xlabel('S_m / max( S_h )');
ylabel('S_h / max( S_h )');

plotMiuraEgg(f);
set(gcf,'color','w');
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

function [slider, leftNote, rightNote] = makeSlider(initval, minval, maxval, xpos, ypos, len, name, minStr, maxStr,callback)
slider = uicontrol('Parent',gcf,'Style','slider','Units','normalized',...
    'Position',[xpos ypos len 0.03],'value', initval, 'min', minval, 'max', maxval);
addlistener(slider, 'Value', 'PostSet', callback);
leftNote = annotation(gcf,'textbox','String', minStr, 'FontSize',12,'units','normalized',...
    'Position', [xpos-0.05 ypos 0.05 0.03],'Interpreter','Tex','EdgeColor','none',...
    'HorizontalAlignment','center','VerticalAlignment','middle');
rightNote = annotation(gcf,'textbox','String', maxStr, 'FontSize',12,'units','normalized',...
    'Position', [xpos+len ypos 0.05 0.03],'Interpreter','Tex','EdgeColor','none',...
    'HorizontalAlignment','center','VerticalAlignment','middle');
annotation(gcf,'textbox','String', name, 'FontSize',12,'units','normalized',...
    'Position', [0 ypos 0.05 0.03],'Interpreter','Tex','EdgeColor','none',...
    'HorizontalAlignment','center','VerticalAlignment','middle');
end
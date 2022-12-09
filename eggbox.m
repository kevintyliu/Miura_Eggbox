%% Input Parameters
% close all
% clear
% clc

% assume 1 plane of symmetry for now
% as between eggbox and Miura match
eggParams.a = 1;
eggParams.b = 1;
eggParams.g = deg2rad(60);
eggParams.psi = deg2rad(45);
% eggParams.psi = pi/2-eggParams.g;
%% Create GUI
f = initVisual(1,1,false);
initSingleUnitTabs(f);
f.UserData = eggParams;
plotEgg(f);
set(gcf,'color','w');
makeSlider(eggParams.a,0,3,0.1,0.25,0.8,'a','0','3',@changeA);
makeSlider(eggParams.b,0,3,0.1,0.2,0.8,'b','0','3',@changeB);
makeSlider(eggParams.g,deg2rad(1),pi/2,0.1,0.15,0.8,'\gamma','1^\circ','90^\circ',@changeG);
[f.UserData.psiSlider, f.UserData.leftNote, ~] = ...
    makeSlider(eggParams.psi,pi/2-eggParams.g,pi/2,0.1,0.05,...
    0.8*(f.UserData.g/(pi/2)),'\psi:','90^\circ-\gamma','90^\circ',@changePsi);
% makeSlider(eggParams.a,0,3,0.25,0.8,'a','0','3',@changeA);
% makeSlider(eggParams.b,0,3,0.2,0.8,'b','0','3',@changeB);
% makeSlider(eggParams.g,deg2rad(1),pi/2,0.15,0.8,'\gamma','1^\circ','90^\circ',@changeG);
% [f.UserData.psiSlider, f.UserData.leftNote] = ...
%     makeSlider(eggParams.psi,pi/2-eggParams.g,pi/2,0.05,0.8*(f.UserData.g/(pi/2)),'\psi:','90^\circ-\gamma','90^\circ',@changePsi);

function changeA(~,event)
f = gcf;
f.UserData.a = event.AffectedObject.Value;
plotEgg(f);
end
function changeB(~,event)
f = gcf;
f.UserData.b = event.AffectedObject.Value;
plotEgg(f);
end
function changeG(~,event)
f = gcf;
f.UserData.g = event.AffectedObject.Value;
f.UserData.psi = max(pi/2-f.UserData.g,f.UserData.psi);
f.UserData.psiSlider.Value = max(pi/2-f.UserData.g,f.UserData.psi);
f.UserData.psiSlider.Position = [0.9-0.8*(f.UserData.g/(pi/2)) 0.05 0.8*(f.UserData.g/(pi/2)) 0.05];
f.UserData.leftNote.Position = [0.85-0.8*f.UserData.g/(pi/2) 0.05 0.05 0.05];
f.UserData.psiSlider.Min = pi/2-f.UserData.g;
plotEgg(f);
end

function changePsi(~,event)
f = gcf;
f.UserData.psi = event.AffectedObject.Value;
plotEgg(f);
end

% function [slider, leftNote] = makeSlider(initval, minval, maxval, ypos, len, name, minStr, maxStr,callback)
% slider = uicontrol('Parent',gcf,'Style','slider','Units','normalized',...
%     'Position',[0.9-len ypos len 0.05],'value', initval, 'min', minval, 'max', maxval);
% addlistener(slider, 'Value', 'PostSet', callback);
% leftNote = annotation(gcf,'textbox','String', minStr, 'FontSize',12,'units','normalized',...
%     'Position', [0.85-len ypos 0.05 0.05],'Interpreter','Tex','EdgeColor','none',...
%     'HorizontalAlignment','center','VerticalAlignment','middle');
% annotation(gcf,'textbox','String', maxStr, 'FontSize',12,'units','normalized',...
%     'Position', [0.9 ypos 0.05 0.05],'Interpreter','Tex','EdgeColor','none',...
%     'HorizontalAlignment','center','VerticalAlignment','middle');
% annotation(gcf,'textbox','String', name, 'FontSize',12,'units','normalized',...
%     'Position', [0 ypos 0.05 0.05],'Interpreter','Tex','EdgeColor','none',...
%     'HorizontalAlignment','center','VerticalAlignment','middle');
% end
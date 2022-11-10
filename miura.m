%% Input Parameters
% close all
% clear
% clc

miuraParams.a = cosd(40)/cosd(60);
miuraParams.b = 1;
miuraParams.g = deg2rad(60);
% miuraParams.psi = deg2rad(10);
theta = deg2rad(61.03);
miuraParams.psi = acos(sqrt(1-sin(miuraParams.g)^2*sin(theta)^2));
%% Create GUI
f = figure;
f.UserData = miuraParams;
axes('Parent',f,'position',[0.1 0.4  0.5 0.55]);
hold on;
for i = 1:4
    fill3([1],[1],[1],'g');
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
axes('Parent',f,'position',[0.6 0.4 0.3 0.55]);
plot([1],[1]);
hold on
scatter([1],[1]);
grid on
xlim([0 90]);
ylim([0 3]);
xlim manual
ylim manual
xlabel('\psi');
ylabel('S');
plotMiura(f);
set(gcf,'color','w');
makeSlider(miuraParams.a,0,3,0.25,0.8,'a','0','3',@changeA);
makeSlider(miuraParams.b,0,3,0.2,0.8,'b','0','3',@changeB);
makeSlider(miuraParams.g,deg2rad(1),pi/2,0.15,0.8,'\gamma','1^\circ','90^\circ',@changeG);
[f.UserData.psiSlider, f.UserData.rightNote] = ...
    makeSlider(miuraParams.psi,0,miuraParams.g,0.05,0.8*f.UserData.g/(pi/2),'\psi:','0^\circ','\gamma',@changePsi);

function changeA(~,event)
f = gcf;
f.UserData.a = event.AffectedObject.Value;
plotMiura(f);
end
function changeB(~,event)
f = gcf;
f.UserData.b = event.AffectedObject.Value;
plotMiura(f);
end
function changeG(~,event)
f = gcf;
f.UserData.g = event.AffectedObject.Value;
f.UserData.psi = min(f.UserData.g,f.UserData.psi);
f.UserData.psiSlider.Value = min(f.UserData.g,f.UserData.psi);
f.UserData.psiSlider.Position = [0.1 0.05 0.8*f.UserData.g/(pi/2) 0.05];
f.UserData.rightNote.Position = [0.1+0.8*f.UserData.g/(pi/2) 0.05 0.05 0.05];
f.UserData.psiSlider.Max = f.UserData.g;
plotMiura(f);
end

function changePsi(~,event)
f = gcf;
f.UserData.psi = event.AffectedObject.Value;
plotMiura(f);
end

function [slider, rightNote] = makeSlider(initval, minval, maxval, ypos, len, name, minStr, maxStr,callback)
slider = uicontrol('Parent',gcf,'Style','slider','Units','normalized',...
    'Position',[0.1 ypos len 0.05],'value', initval, 'min', minval, 'max', maxval);
addlistener(slider, 'Value', 'PostSet', callback);
annotation(gcf,'textbox','String', minStr, 'FontSize',12,'units','normalized',...
    'Position', [0.05 ypos 0.05 0.05],'Interpreter','Tex','EdgeColor','none',...
    'HorizontalAlignment','center','VerticalAlignment','middle');
rightNote = annotation(gcf,'textbox','String', maxStr, 'FontSize',12,'units','normalized',...
    'Position', [0.1+len ypos 0.05 0.05],'Interpreter','Tex','EdgeColor','none',...
    'HorizontalAlignment','center','VerticalAlignment','middle');
annotation(gcf,'textbox','String', name, 'FontSize',12,'units','normalized',...
    'Position', [0 ypos 0.05 0.05],'Interpreter','Tex','EdgeColor','none',...
    'HorizontalAlignment','center','VerticalAlignment','middle');
end
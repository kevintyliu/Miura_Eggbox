function [f] = initVisual(m,n)
f = figure;
f.Position = [100 100 1000 800];
axes('Parent',f,'position',[0.1 0.4  0.5 0.55]);
hold on;
for i = 1:4*m*n
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
set(gcf,'color','w');
set(gca,'FontSize',18)
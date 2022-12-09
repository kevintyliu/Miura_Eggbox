function [f] = initVisual(m,n,miura_bools)
f = figure;
f.Position = [100 100 1000 800];
axes('Parent',f,'position',[0.1 0.4  0.5 0.55]);
hold on;
for i = 1:4*m*n
    if miura_bools(end-ceil(i/(4*m))+1)
        fill3(1,1,1,[0 0.4470 0.7410]);
    else
        fill3(1,1,1,[0.8500 0.3250 0.0980]);
    end
end
alpha(0.5);
grid on
axis equal
xlim manual
ylim manual
zlim manual
xlabel('X');
ylabel('Y');
zlabel('Z');
view([42 23]);
set(gcf,'color','w');
set(gca,'FontSize',16)
set(gca,'Fontname','Tacoma')
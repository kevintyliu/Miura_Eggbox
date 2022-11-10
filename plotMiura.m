function plotMiura(f)
    a = f.UserData.a;
    b = f.UserData.b;
    g = f.UserData.g;
    psi = f.UserData.psi;
    theta = asin(sin(psi)/sin(g))
%     theta = f.UserData.theta;
    H = a*sin(theta)*sin(g);
    S = b*cos(theta)*tan(g)/sqrt(1+cos(theta)^2*tan(g)^2);
    L = a*sqrt(1-sin(theta)^2*sin(g)^2);
    V = S/(tan(g)*cos(theta));
    Xs = [S S S 0 0 0 2*S 2*S 2*S];
    Ys = [2*L+V L+V V 2*L L 0 2*L L 0];
    Zs = [0 H 0 0 H 0 0 H 0];
    quadInds = [6 3 2 5;
        5 2 1 4;
        3 9 8 2;
        1 2 8 7];
    for i = 1:4
        h = f.Children(length(f.Children)).Children(i);
        h.XData = Xs(quadInds(i,:));
        h.YData = Ys(quadInds(i,:));
        h.ZData = Zs(quadInds(i,:));
    end
    axes(f.Children(length(f.Children)));
    title(sprintf('a: %0.2f, b: %0.2f, $\\gamma$: %0.1f$^\\circ$, $\\psi$: %0.1f$^\\circ$',...
        a,b,rad2deg(g),rad2deg(psi)),'Interpreter','latex');
    xlim([0,2*b*sin(g)]);
    ylim([0,max(2*a+b*cos(g),b+2*a*cos(g))]);
    zlim([0,a*sin(g)]);

    psis = linspace(0,g,101);
    thetas = asin(sin(psis)./sin(g));
    Ss = b*cos(thetas)*tan(g)./sqrt(1+cos(thetas).^2*tan(g)^2);
    axes(f.Children(length(f.Children)));
    hscatter = f.Children(length(f.Children)-1).Children(1);
    hscatter.XData = rad2deg(psi);
    hscatter.YData = S;
    hplot = f.Children(length(f.Children)-1).Children(2);
    hplot.XData = rad2deg(psis);
    hplot.YData = Ss;
end
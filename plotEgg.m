function plotEgg(f)
    a = f.UserData.a;
    b = f.UserData.b;
    g = f.UserData.g;
    psi = f.UserData.psi;
    alpha = pi/2-psi;
    beta = acos(cos(g)/cos(alpha));
    ha = a*cos(alpha);
    hb = b*cos(beta);
    H = ha+hb;
    S = b*sqrt(1-cos(g)^2/cos(alpha)^2);    % instead of B
    L = a*sin(alpha);                       % instead of W
    Xs = [S 2*S 0 S 2*S 0 S 2*S 0];
    Ys = [L L L 0 0 0 2*L 2*L 2*L];
    Zs = [H ha ha hb 0 0 hb 0 0];
    quadInds = [6 4 1 3;
        3 1 7 9;
        4 5 2 1;
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
    ylim([0,2*a*sin(g)]);
    zlim([0,max(a+b*cos(g),b+a*cos(g))]);

    psis = linspace(pi/2-g,pi/2,101);
    alphas = pi/2-psis;
    Ss = b*sqrt(1-cos(g)^2./cos(alphas).^2);
    axes(f.Children(length(f.Children)));
    hscatter = f.Children(length(f.Children)-1).Children(1);
    hscatter.XData = rad2deg(psi);
    hscatter.YData = S;
    hplot = f.Children(length(f.Children)-1).Children(2);
    hplot.XData = rad2deg(psis);
    hplot.YData = Ss;
end
function ViewAxes()
    hold on;
    h1 = [1 0 0];
    h2 = [0 1 0];
    h3 = [0 0 1];
    xorigin = [0 0 0];
    yorigin = [0 0 0];
    zorigin = [0 0 0];
    quiver3(xorigin, yorigin, zorigin, h1, h2, h3,'r', 'AutoScale', "on", 'AutoScaleFactor',100, 'LineWidth',1.5);
    text(xLabel,yLabel,zLabel, num2str((1:numel(xLabel)).'), 'Color','w', 'FontSize',20);
    quiver3(xorigin, yorigin, zorigin, -h1, -h2, -h3,'r', 'AutoScale', "on", 'AutoScaleFactor',100, 'Marker','o','ShowArrowHead','off', 'LineWidth',1.5);
    hold off;
end
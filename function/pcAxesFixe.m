function pcAxesFixe(ptData)
    hold on;
    coeff = pca(ptData);
    h1 = coeff(1,:);
    h2 = coeff(2,:);
    h3 = coeff(3,:);
    xorigin = [0 0 0];
    yorigin = [0 0 0];
    zorigin = [0 0 0];
    quiver3(xorigin, yorigin, zorigin, h1, h2, h3,'blue', 'AutoScale', "on", 'AutoScaleFactor',16, 'LineWidth',1.5);
    quiver3(xorigin, yorigin, zorigin, -h1, -h2, -h3,'blue', 'AutoScale', "on", 'AutoScaleFactor',10, 'Marker','o','ShowArrowHead','off', 'LineWidth',1.5);
end
function [fig, coeff, score] = pcaandaxis(Point, str)
    [coeff, score] = pca(Point);
   
    h1 = coeff(1,:);
    h2 = coeff(2,:);
    h3 = coeff(3,:);
    xorigin = [0 0 0];
    yorigin = [0 0 0];
    zorigin = [0 0 0];

    fig = figure('Name', str);
    hold on; 
    
    quiver3(xorigin, yorigin, zorigin, h1, h2, h3, 'red', 'AutoScale', "on", 'AutoScaleFactor',165, 'LineWidth',3.5);
    xLabel = [200 0 0];
    yLabel = [0 200 0];
    zLabel = [0 0 200];
    text(xLabel, yLabel, zLabel, num2str((1:numel(xLabel)).'), 'FontSize',25, 'Color','w');
    quiver3(xorigin, yorigin, zorigin, -h1, -h2, -h3,'red', 'AutoScale', "on", 'AutoScaleFactor',140, 'Marker','o','ShowArrowHead','off', 'LineWidth',3.5);
    grid on
%     pcshow(score);
    pcshow(score, 'AxesVisibility','on');
    hold off;
end

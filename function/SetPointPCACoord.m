function coeff = SetPointPCACoord(Point, fig)
    % 新しい座標空間上の点群を出すためのPCA
    [coeff, score] = pca(Point); 
    % 新しい主軸を出す（x,y,z）に一致
    coeff2= pca(score);

    [h1, h2, h3] = pcaxisVector(coeff2);
    xorigin = [0 0 0]; yorigin = [0 0 0]; zorigin = [0 0 0];
    
    pcshow(score, 'Parent',fig);
    hold on; grid on;
    quiver3(xorigin, yorigin, zorigin, h1, h2, h3,'red', 'AutoScale', "on", ...
        'AutoScaleFactor',165, 'LineWidth',3.5);
    
    quiver3(xorigin, yorigin, zorigin, -h1, -h2, -h3,'red', 'AutoScale', "on", ...
        'AutoScaleFactor',165, 'LineWidth',3.5, 'ShowArrowHead','off');
    xLabel = [200 0 0];
    yLabel = [0 200 0];
    zLabel = [0 0 200];
    text(xLabel, yLabel, zLabel, num2str((1:numel(xLabel)).'), 'FontSize',25, 'Color','w');
    hold off;
end
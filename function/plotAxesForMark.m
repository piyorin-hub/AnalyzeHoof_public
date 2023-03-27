function plotAxesForMark(score)    
    [coeff2, ~] = pca(score);
    [h1, h2, h3] = pcaxisVector(coeff2);
    xorigin = [0 0 0];
    yorigin = [0 0 0];
    zorigin = [0 0 0];
    
    fig1 = figure('Name','Re-Display ptCloud', 'Position',[650 500 500 400]);
    hold on;
    grid on;
    quiver3(xorigin, yorigin, zorigin, h1, h2, h3,'red', 'AutoScale', "on", ...
        'AutoScaleFactor',25, 'LineWidth',3.5);
    xLabel = [35 0 0];
    yLabel = [0 35 0];
    zLabel = [0 0 35];
    text(xLabel, yLabel, zLabel, num2str((1:numel(xLabel)).'), 'FontSize',15, 'Color','w');
    quiver3(xorigin, yorigin, zorigin, -h1, -h2, -h3,'red', 'AutoScale', "on", ...
        'AutoScaleFactor',25, 'LineWidth',3.5, 'ShowArrowHead','off');
%     pcshow(score2);
    pcshow(score,'AxesVisibility','on' );
    hold off;
end
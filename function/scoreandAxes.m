function score = scoreandAxes(xyzpoint)
    [coeff, score] = pca(xyzpoint);
    pcshow(score, "AxesVisibility","on");

    maxc = max(score);
    minc = min(score);
    diffe = (maxc - minc) + 20;
    
    axesLen = diffe/2; 
    
    h1 = [1 0 0]; h2 = [0 1 0]; h3 = [0 0 1];
    xorigin = [0 0 0]; yorigin = [0 0 0]; zorigin = [0 0 0];
    hold on;  grid on;
    quiver3(xorigin, yorigin, zorigin, h1, h2, h3,'red', 'AutoScale', "on", ...
        'AutoScaleFactor',mean(axesLen), 'LineWidth',3.5);
%     quiver3(xorigin, h1, 'red', 'AutoScaleFactor', axesLen(1), 'LineWidth', 3.5);
    xLabel = [mean(axesLen)+5 0 0];
    yLabel = [0 mean(axesLen)+5 0];
    zLabel = [0 0 mean(axesLen)+5];
    text(xLabel, yLabel, zLabel, num2str((1:numel(xLabel)).'), 'FontSize',25, 'Color','w');
    quiver3(xorigin, yorigin, zorigin, -h1, -h2, -h3,'red', 'AutoScale', "on", ...
        'AutoScaleFactor',mean(axesLen), 'LineWidth',3.5, 'ShowArrowHead','off');
%     quiver3(xorigin, -h1, 'red', 'AutoScaleFactor', axesLen, 'LineWidth', 3.5, 'ShowArrowHead', 'off')
    hold off;
end
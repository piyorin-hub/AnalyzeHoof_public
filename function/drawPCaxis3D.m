function [fig, coeff, score] = drawPCaxis3D(ptData, isShow)
    % This function draws PC Axes on The plot After calculate by PCA
    % @param data => PointCloud.Location (xyzPoints)
    % 
    if nargin < 2
        isShow = false;
    end

    [coeff, score] = pca(ptData);
    [h1, h2, h3] = pcaxisVector(coeff);
    meanData = mean(ptData);
    x = meanData(:,1);
    X = [x x x];
    y = meanData(:,2);
    Y = [y y y];
    z = meanData(:,3);
    Z = [z z z];
    
    if ~isShow
        fig = figure('Position', [100 500 500 400]); 
        hold on;
        xLab = [170 0 0];
        yLab = [0 170 0];
        zLab = [0 0 170];
        quiver3(X, Y, Z, h1, h2, h3,'red','AutoScale', "on", 'AutoScaleFactor',165, 'LineWidth',3.5);
        text(xLab,yLab,zLab, num2str((1:numel(xLab)).'), 'Color','w', 'FontSize',20);
        quiver3(X, Y, Z, -h1, -h2, -h3,'red', 'AutoScale', "on", 'AutoScaleFactor',140, 'Marker','o','ShowArrowHead','off', 'LineWidth',3.5);
        grid on;
        pcshow(ptData, 'AxesVisibility','on');
        xlabel('X');ylabel('Y');zlabel('Z');
        hold off;
    end
end



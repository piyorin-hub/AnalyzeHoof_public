function scorePlotAxes(score, pos)
    if nargin < 2
        pos = [650 500 1010 400];
    end
    coeff = pca(score);
    [H1, H2, H3]  = pcaAxVector(coeff);
    
    ptCloud = pointCloud(score);
    xli = ptCloud.XLimits;
    yli = ptCloud.YLimits;
    zli = ptCloud.ZLimits;

    x_width = [abs(xli(2))+30, abs(xli(1))+25];
    y_width = [abs(yli(2))+25, abs(yli(1))+25];
    z_width = [abs(zli(2))+25, abs(zli(1))+25];
    meanData = mean(score);
    x = meanData(:,1);
    y = meanData(:,2);
    z = meanData(:,3);

    figure("Name","Score Plot with Axes" ,'Position', pos); 
    hold on;
    quiver3(x,y, z, H1(1,1),H1(2,1), H1(3,1),'r','AutoScale', "on", 'AutoScaleFactor',200, 'LineWidth',3.5);
    text(xli(2), 0 ,0, 'PC1', 'Color','w', 'FontSize',20);
    quiver3(x,y, z, -H1(1,1),-H1(2,1), -H1(3,1),'r', 'AutoScale', "on", 'AutoScaleFactor',max(x_width), 'Marker','o','ShowArrowHead','off', 'LineWidth',3.5);
   
    quiver3(x,y, z, H2(1,1),H2(2,1), H2(3,1),'g','AutoScale', "on", 'AutoScaleFactor',max(y_width), 'LineWidth',3.5);
    text( 0,yli(2)+20,0, 'PC2', 'Color','w', 'FontSize',20);
    quiver3(x,y, z, -H2(1,1),-H2(2,1), -H2(3,1),'g', 'AutoScale', "on", 'AutoScaleFactor',max(y_width), 'Marker','o','ShowArrowHead','off', 'LineWidth',3.5);
    
    quiver3(x,y, z, H3(1,1),H3(2,1), H3(3,1),'b','AutoScale', "on", 'AutoScaleFactor',max(z_width), 'LineWidth',3.5);
    text(0 ,0,zli(2)+20, 'PC3', 'Color','w', 'FontSize',20);
    quiver3(x,y, z, -H3(1,1),-H3(2,1), -H3(3,1),'b', 'AutoScale', "on", 'AutoScaleFactor',max(z_width), 'Marker','o','ShowArrowHead','off', 'LineWidth',3.5);

    quiver3(0,0, 0, 1,0,0,'w','AutoScale', "on", 'AutoScaleFactor',120, 'LineWidth',3.5);
    text(140, 0 ,0, 'X', 'Color','w', 'FontSize',20);
%         quiver3(0,0, 0, -1,0, 0,'r', 'AutoScale', "on", 'AutoScaleFactor',120, 'Marker','o','ShowArrowHead','off', 'LineWidth',3.5);
   
    quiver3(0,0, 0, 0,1,0,'w','AutoScale', "on", 'AutoScaleFactor',120, 'LineWidth',3.5);
    text(0, 140 ,0, 'Y', 'Color','w', 'FontSize',20);
%         quiver3(0,0, 0, 0,-1, 0,'r', 'AutoScale', "on", 'AutoScaleFactor',120, 'Marker','o','ShowArrowHead','off', 'LineWidth',3.5);

    quiver3(0,0, 0, 0,0,1,'w','AutoScale', "on", 'AutoScaleFactor',120, 'LineWidth',3.5);
    text(0, 0 ,140, 'Z', 'Color','w', 'FontSize',20);
    
    grid on;
    pcshow(score, 'AxesVisibility','on');

    xlabel('X');ylabel('Y');zlabel('Z');
    hold off;
end
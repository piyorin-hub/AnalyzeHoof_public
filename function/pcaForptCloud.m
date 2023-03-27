function [coeff, score, latent] = pcaForptCloud(ptCloud, isShow, Position)
% ptCloudに対してPCAを行い，軸表示
% @param1 = ptCloud
% @param2 = isShow => show figure or not
    if nargin < 3
%         isShow = false;
        Position = [100 500 500 400];
    elseif nargin < 2
        isShow = false;
        Position = [100 500 500 400];

    end
    pt = ptCloud.Location;
    [coeff, score, latent] = pca(pt);
    [H1, H2, H3] = pcaAxVector(coeff);
    xli = ptCloud.XLimits;
    yli = ptCloud.YLimits;
    zli = ptCloud.ZLimits;

    x_width = [abs(xli(2))+30, abs(xli(1))+25];
    y_width = [abs(yli(2))+25, abs(yli(1))+25];
    z_width = [abs(zli(2))+25, abs(zli(1))+25];
    meanData = mean(pt);
    mx = meanData(:,1);
    my = meanData(:,2);
    mz = meanData(:,3);
    pos_pc1 = xli(2);
    pos_pc2 = yli(2);
    pos_pc3 = zli(2);
    mData = meanData';
    pc1 = mData + H1*pos_pc1;
    pc2 = mData + H2*pos_pc2;
    pc3 = mData + H3*pos_pc3;
    arrowScale1 = 250;
    arrowScale = 130;
    if isShow
        figure("Name", "pca for ptCloud", 'Position', Position); 
        hold on;
        quiver3(0,0, 0, 1,0,0,'w','AutoScale', "on", 'AutoScaleFactor',120, 'LineWidth',3.5);
        text(140, 0 ,0, 'X', 'Color','w', 'FontSize',20);
%         quiver3(0,0, 0, -1,0, 0,'r', 'AutoScale', "on", 'AutoScaleFactor',120, 'Marker','o','ShowArrowHead','off', 'LineWidth',3.5);
       
        quiver3(0,0, 0, 0,1,0,'w','AutoScale', "on", 'AutoScaleFactor',120, 'LineWidth',3.5);
        text(0, 140 ,0, 'Y', 'Color','w', 'FontSize',20);
%         quiver3(0,0, 0, 0,-1, 0,'r', 'AutoScale', "on", 'AutoScaleFactor',120, 'Marker','o','ShowArrowHead','off', 'LineWidth',3.5);

        quiver3(0,0, 0, 0,0,1,'w','AutoScale', "on", 'AutoScaleFactor',120, 'LineWidth',3.5);
        text(0, 0 ,140, 'Z', 'Color','w', 'FontSize',20);
%         quiver3(0,0, 0, 0,0, -1,'r', 'AutoScale', "on", 'AutoScaleFactor',120, 'Marker','o','ShowArrowHead','off', 'LineWidth',3.5);


%         quiver3(mx,my, mz, H1(1,1),H1(2,1), H1(3,1),'r','AutoScale', "on", 'AutoScaleFactor',x_width(2), 'LineWidth',3.5);
%         text(pc1(1), pc1(2), pc1(3), 'PC1', 'Color', 'w', 'FontSize',20);
%         quiver3(mx,my, mz, -H1(1,1),-H1(2,1), -H1(3,1),'r', 'AutoScale', "on", 'AutoScaleFactor',x_width(1), 'Marker','o','ShowArrowHead','off', 'LineWidth',3.5);
%        
%         quiver3(mx,my, mz, H2(1,1),H2(2,1), H2(3,1),'g','AutoScale', "on", 'AutoScaleFactor',y_width(2), 'LineWidth',3.5);
%         text(pc2(1),pc2(2),pc2(3), 'PC2', 'Color','w', 'FontSize',20);
%         quiver3(mx,my, mz, -H2(1,1),-H2(2,1), -H2(3,1),'g', 'AutoScale', "on", 'AutoScaleFactor',y_width(1), 'Marker','o','ShowArrowHead','off', 'LineWidth',3.5);
%         
%         quiver3(mx,my, mz, H3(1,1),H3(2,1), H3(3,1),'b','AutoScale', "on", 'AutoScaleFactor',z_width(2), 'LineWidth',3.5);
%         text(pc3(1),pc3(2),pc3(3), 'PC3', 'Color','w', 'FontSize',20);
%         quiver3(mx,my, mz, -H3(1,1),-H3(2,1), -H3(3,1),'b', 'AutoScale', "on", 'AutoScaleFactor',z_width(1), 'Marker','o','ShowArrowHead','off', 'LineWidth',3.5);
        quiver3(mx,my, mz, H1(1,1),H1(2,1), H1(3,1),'r','AutoScale', "on", 'AutoScaleFactor',arrowScale1, 'LineWidth',3.5);
%         text(pc1(1), pc1(2), pc1(3), 'PC1', 'Color', 'w', 'FontSize',20);
        quiver3(mx,my, mz, -H1(1,1),-H1(2,1), -H1(3,1),'r', 'AutoScale', "on", 'AutoScaleFactor',arrowScale1, 'Marker','o','ShowArrowHead','off', 'LineWidth',3.5);
       
        quiver3(mx,my, mz, H2(1,1),H2(2,1), H2(3,1),'g','AutoScale', "on", 'AutoScaleFactor',arrowScale, 'LineWidth',3.5);
        text(pc2(1),pc2(2),pc2(3), 'PC2', 'Color','w', 'FontSize',20);
        quiver3(mx,my, mz, -H2(1,1),-H2(2,1), -H2(3,1),'g', 'AutoScale', "on", 'AutoScaleFactor',arrowScale, 'Marker','o','ShowArrowHead','off', 'LineWidth',3.5);
        
        quiver3(mx,my, mz, H3(1,1),H3(2,1), H3(3,1),'b','AutoScale', "on", 'AutoScaleFactor',arrowScale, 'LineWidth',3.5);
        text(pc3(1),pc3(2),pc3(3), 'PC3', 'Color','w', 'FontSize',20);
        quiver3(mx,my, mz, -H3(1,1),-H3(2,1), -H3(3,1),'b', 'AutoScale', "on", 'AutoScaleFactor',arrowScale, 'Marker','o','ShowArrowHead','off', 'LineWidth',3.5);
        grid on;
        pcshow(pt, 'AxesVisibility','on');

        xlabel('X');ylabel('Y');zlabel('Z');
        hold off;
    end

end
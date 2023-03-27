function ptCloud = import3Dmodel(filename, showPt)
    if nargin < 2
        showPt = false;
    end
    if contains(filename, '.stl')
        mesh = stlread(filename);
        scale = 1000;
        pt = (mesh.Points).*scale;
        ptCloud = pointCloud(pt);
    elseif contains(filename, '.ply')
        pt = pcread(filename);
        ptData = pt.Location * 1000;
        ptCloud = pointCloud(ptData);
    else
        disp('Not Found');
    end

    if showPt
        pcshowWithAxes(ptCloud, 'imported model');
        hold on;
        quiver3(0,0, 0, 1,0,0,'w','AutoScale', "on", 'AutoScaleFactor',120, 'LineWidth',3.5);
        text(140, 0 ,0, 'X', 'Color','w', 'FontSize',20);
%         quiver3(0,0, 0, -1,0, 0,'r', 'AutoScale', "on", 'AutoScaleFactor',120, 'Marker','o','ShowArrowHead','off', 'LineWidth',3.5);
       
        quiver3(0,0, 0, 0,1,0,'w','AutoScale', "on", 'AutoScaleFactor',120, 'LineWidth',3.5);
        text(0, 140 ,0, 'Y', 'Color','w', 'FontSize',20);
%         quiver3(0,0, 0, 0,-1, 0,'r', 'AutoScale', "on", 'AutoScaleFactor',120, 'Marker','o','ShowArrowHead','off', 'LineWidth',3.5);

        quiver3(0,0, 0, 0,0,1,'w','AutoScale', "on", 'AutoScaleFactor',120, 'LineWidth',3.5);
        text(0, 0 ,140, 'Z', 'Color','w', 'FontSize',20);
        hold off;
    end

end

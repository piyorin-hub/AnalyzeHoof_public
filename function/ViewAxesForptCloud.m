function ViewAxesForptCloud(xyzpoint, x_width, y_width, z_width, origin)
    if nargin < 5
        origin = [0 0 0];
    end
    x = origin(1);y = origin(2);z = origin(3);

    quiver3(x,y, z, H1(1,1),H1(2,1), H1(3,1),'r','AutoScale', "on", 'AutoScaleFactor',x_width(1), 'LineWidth',3.5);
    text(xli(2)+20, 0 ,0, '1', 'Color','w', 'FontSize',20);
    quiver3(x,y, z, -H1(1,1),-H1(2,1), -H1(3,1),'r', 'AutoScale', "on", 'AutoScaleFactor',x_width(2), 'Marker','o','ShowArrowHead','off', 'LineWidth',3.5);
   
    quiver3(x,y, z, H2(1,1),H2(2,1), H2(3,1),'r','AutoScale', "on", 'AutoScaleFactor',y_width(1), 'LineWidth',3.5);
    text( 0,yli(2)+20,0, '2', 'Color','w', 'FontSize',20);
    quiver3(x,y, z, -H2(1,1),-H2(2,1), -H2(3,1),'r', 'AutoScale', "on", 'AutoScaleFactor',y_width(2), 'Marker','o','ShowArrowHead','off', 'LineWidth',3.5);
    
    quiver3(x,y, z, H3(1,1),H3(2,1), H3(3,1),'r','AutoScale', "on", 'AutoScaleFactor',z_width(1), 'LineWidth',3.5);
    text(0 ,0,zli(2)+20, '3', 'Color','w', 'FontSize',20);
    quiver3(x,y, z, -H3(1,1),-H3(2,1), -H3(3,1),'r', 'AutoScale', "on", 'AutoScaleFactor',z_width(2), 'Marker','o','ShowArrowHead','off', 'LineWidth',3.5);
end
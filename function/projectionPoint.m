function point2d = projectionPoint(point, axes)
    switch axes
        case 'x'
            y = point(:,2);
            z = point(:,3);
            point2d = [y z];
        case 'y'
            x = point(:,1);
            z = point(:,3);
            point2d = [x z];
        case 'z'
            x = point(:,1);
            y = point(:,2); 
            point2d = [x y];
    end
end
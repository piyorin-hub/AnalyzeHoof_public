function [k,area]  = convexhullCal(point, axis)
    % This function calculate the convex hull for slashed points
    % point
    % use y-z axis when calculate
    switch axis
        case 'x'
            [k, area] = convhull(point(:, 2:3));
        case 'y'
            [k, area] = convhull(point(:, [1 3]));
        case 'z'
            [k, area] = convhull(point(:, 1:2));
    end

end
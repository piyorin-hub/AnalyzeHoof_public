function slash = slashPoint(point, t, dt, axis)
    switch axis
        case 'x'
            slash = point(point(:, 1) > (dt-t) & (dt+t) > point(:,1), :);
        case 'y'
            slash = point(point(:, 2) > (dt-t) & (dt+t) > point(:,2), :);
        case 'z'
            slash = point(point(:, 3) > (dt-t) & (dt+t) > point(:,3), :);
        otherwise
            disp('You Must Choose');
    end
    figure('Name', ...
        'Slashed Point');
    
    pcshow(slash, 'MarkerSize', 20);
%     axis equal
    disp(length(slash));
end

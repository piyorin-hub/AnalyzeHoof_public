function [x, y, z] = getDatatip(target)
    try
        dt = findobj(target, 'Type', 'datatip');
    catch
        warning("Select One Point");
    end
    pos = dt.Content;
    x = pos(1);
    y = pos(2);
    z = pos(3);
    disp([x, y, z]);
end

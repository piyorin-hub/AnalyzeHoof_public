function [X, Y, Z] = getPos(target)
    [x, y, z] = getDatatip(target);
    [X, Y, Z] = makeDatatipToDouble(x, y, z);
    disp([X, Y, Z]);
end

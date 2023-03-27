function [new_x, new_y, new_z] = makeDatatipToDouble(x, y, z)
    % this function make cell include position to double
    % param x => 1x1 cell, like"X 2.10988"
    % param y => 1x1 cell, like"Y 2.08082"
    %
    X = string(x);
    Y = string(y);
    Z = string(z);
%     [X, Y, Z] = string([x, y, z]);
    strX = strsplit(X, ' ');
    strY = strsplit(Y, ' ');
    strZ = strsplit(Z, ' ');
    
    new_x = str2double(strX(2));
    new_y = str2double(strY(2));
    new_z = str2double(strZ(2));
end

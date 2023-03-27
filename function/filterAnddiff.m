function [y1, v1, v2] =filterAnddiff(y,n, Wn)
    if nargin < 2
        n = 1;
        Wn = 0.2;
    end
    [b,a] = butter(n, Wn, "low");
    y1 =filtfilt(b, a ,y);
    [v1, v2] = fun_dif_6(y1);
end
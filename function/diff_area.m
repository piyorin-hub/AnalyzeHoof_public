function [Y1, Y2] = diff_area(x, y, t, plot)
    Y1 = diff(y)/t;
    Y2 = diff(Y1)/t;
%     plot(x,y,x(1:length(Y1), :), Y1, 'b',x(1:length(Y2),:), Y2, 'r');
    if strcmp(plot, 'on')
        plot(x, y, x(1:length(Y1), :), Y1, 'b', x(1:length(Y2), :), Y2, 'r');
    end
end



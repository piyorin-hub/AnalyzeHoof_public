function fig = pcshowWithAxes(ptCloud, name, pos)
% @param1 = pointCloud
% @param2 = figure name
    if nargin < 3
        fig = figure("Name",name);
    elseif nargin < 2
        fig = figure;
    elseif nargin < 1
        disp('何も出力できません');
        return;
    else
        fig = figure("Name",name, 'Position',pos);
    end
    grid on;
    pcshow(ptCloud, AxesVisibility="on");
    xlabel('X');
    ylabel('Y');
    zlabel('Z');
end


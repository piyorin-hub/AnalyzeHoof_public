function CircleData = sliceCircleRho(sPoint, axes, cutWidthT, isShow)
    if nargin < 4
        isShow = false;
    end
    switch axes
        case 'x' % x軸方向にスライスしたい
            limit = sPoint.XLimits;
            axisIdx = 1;
        case 'y'
            limit = sPoint.YLimits;
            axisIdx = 2;
        case 'z'
            limit = sPoint.ZLimits;
            axisIdx = 3;
    end

    sp = sPoint.Location;
    t = cutWidthT;
    Data = zeros(1, 5);
    idx = 0;

    pcshow(sp, 'AxesVisibility', 'on');
    hold on;
    % 選択領域を１ｍｍ幅(既定)でカット
    for i = limit(1):t:limit(2)
        dt = i + t;
        idx = idx + 1;
        cross_section = sp(sp(:,axisIdx)>(dt-t) & (dt+t)>sp(:,axisIdx), :);
%         Point = pointCloud(cross_section);
%         PointSet(idx,:) = pointCloud(cross_section);
        switch axisIdx
            case 1
                cross = cross_section(:,[2 3]);
            case 2
                cross = cross_section(:,[1 3]);
            case 3
                cross = cross_section(:,[1 2]);
        end
        x = cross(:,1);
        y = cross(:,2);
        [cx, cy, r] = CircleFitting(x, y);
        try 
            [k, ~] = convhull(cross);
        catch
            disp('点群が足りないよ');
            Data(idx, 1) = dt;
            Data(idx, 2) = 0;
            Data(idx, 3) = 0;
            Data(idx, 4) = 0;
            Data(idx, 5) = 0;
            continue;
        end
        cross_conv = [cross(k, 1) cross(k, 2)];
        [thetaSorted, rhoSorted] = sortPointOnPolar(cross_conv);
%         [thetaSorted, rhoSorted] = sortPointOnPolar()
        [x, y] = pol2cart(thetaSorted, rhoSorted);

        Data(idx,1) = dt;
        Data(idx,2) = calculateLengthForPoint([x y]);
        Data(idx,3) = r;
        Data(idx, 4) = cx;
        Data(idx,5) = cy;
        theta = linspace(0,2*pi,60);
        for j = 1:length(theta)
            D(j) = dt;
        end
        y1 = r*cos(theta)+cx;
        z1= r*sin(theta)+cy;
        if isShow
            plot3(D, y1, z1, '-r');
        end
    end
    index = Data(:,1)~=0 & Data(:,3)~=0;
    CircleData = Data(index, 1:5);   
    hold off;
end
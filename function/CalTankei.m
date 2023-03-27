function sekiData = CalTankei(sPoint, axes, cutWidthT)
% param point 点群データ(pointCloud)
% param axis str 軸方向
% param t カット幅

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
%     Y_range = zeros(1,2);
%     Z_range = zeros(1,2);
    Data = zeros(1, 3);
    idx = 0;

    % 選択領域を１ｍｍ幅(既定)でカット
    for i = limit(1):t:limit(2)
        dt = i + t;
        idx = idx + 1;
        cross_section = sp(sp(:,axisIdx)>(dt-t) & (dt+t)>sp(:,axisIdx), :);
        Point = pointCloud(cross_section);
%         PointSet(idx,:) = pointCloud(cross_section);
        xli = Point.XLimits;
        x_r = abs(xli(2)-xli(1));
        yli = Point.YLimits;
        y_r = abs(yli(2)-yli(1));
        zli = Point.ZLimits;
        z_r = abs(zli(2)-zli(1));

        switch axisIdx
            case 1
                cross = cross_section(:,[2 3]);
                seki = y_r * z_r;
            case 2
                cross = cross_section(:,[1 3]);
                seki = x_r * z_r;
            case 3
                cross = cross_section(:,[1 2]);
                seki = x_r * y_r;
        end

        try 
            [k, av] = convhull(cross);
        catch
            disp('点群が足りないよ');
            Data(idx, 1) = dt;
            Data(idx, 2) = 0;
            Data(idx, 3) = 0;
            continue;
        end
        cross_conv = [cross(k, 1) cross(k, 2)];
        [thetaSorted, rhoSorted] = sortPointOnPolar(cross_conv);
%         [thetaSorted, rhoSorted] = sortPointOnPolar()
        [x, y] = pol2cart(thetaSorted, rhoSorted);

        Data(idx,1) = dt;
        Data(idx,2) = calculateLengthForPoint([x y]);
%         y = max(cross(:,1)) - min(cross(:,1));
%         y_range =abs(y);
%         z = max(cross(:,2)) - min(cross(:,2));
%         z_range = abs(z);
        Data(idx,3) = seki;
    end
    index = Data(:,1)~=0 & Data(:,3)~=0;
    sekiData = Data(index, 1:3);   
    
end
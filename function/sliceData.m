function CircumData = sliceData(sPoint, axes, cutWidthT)
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
    Circums = zeros(1, 3);
    idx = 0;

    % 選択領域を１ｍｍ幅(既定)でカットそれぞれで凸包を実行する
    for i = limit(1):t:limit(2)
        dt = i + t;
        idx = idx + 1;
        cross_section = sp(sp(:,axisIdx)>(dt-t) & (dt+t)>sp(:,axisIdx), :);
%         PointSet(idx,:) = pointCloud(cross_section);
        switch axisIdx
            case 1
                cross = cross_section(:,[2 3]);
            case 2
                cross = cross_section(:,[1 3]);
            case 3
                cross = cross_section(:,[1 2]);
        end

        try 
            [k, av] = convhull(cross);
        catch
            disp('点群が足りないよ');
            Circums(idx, 1) = dt;
            Circums(idx, 2) = 0;
            Circums(idx, 3) = 0;
            continue;
        end

        cross_conv = [cross(k, 1) cross(k, 2)];
        [thetaSorted, rhoSorted] = sortPointOnPolar(cross_conv);
        [x, y] = pol2cart(thetaSorted, rhoSorted);

        Circums(idx, 1) = dt;
        Circums(idx, 2) = calculateLengthForPoint([x y]);
        Circums(idx, 3) = av;

    end
    
%     index = Circums(:,1)~=0 & Circums(:,3)~=0;
    CircumData = Circums(:, 1:3);    
end
function selectedPoint = roiTrimmerPoints(point, roi)
% roiで選ばれた点群部分を取り出してあらたに変数とする。    
    xmin = roi.Position(1);
    ymin = roi.Position(2);
    zmin = roi.Position(3);
    xmax = roi.Position(4)+xmin;
    ymax = roi.Position(5)+ymin;
    zmax = roi.Position(6)+zmin;
    newroi = [xmin xmax ymin ymax zmin zmax];
    indices = findPointsInROI(point, newroi);
    selectedPoint = select(point, indices);

end

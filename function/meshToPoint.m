function ptCloud = meshToPoint()
    filename = uigetfile('*.stl');
    mesh = stlread(filename);
    pt = mesh.Points;
    ptData = pt.*1000;
    ptCloud = pointCloud(ptData);
    % disp(ptData);
end

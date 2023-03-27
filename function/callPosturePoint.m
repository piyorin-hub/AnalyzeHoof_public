function ptCloud = callPosturePoint()

    file = uigetfile('.mat');
    m = load(file);
    try 
        ptCloud = m.nPoint;
        pcshowWithAxes(ptCloud, 'Get Point')
    catch
        return;
    end
end
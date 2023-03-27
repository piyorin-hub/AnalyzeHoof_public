file = uigetfile('*.mat');

m = load(file);

ptCloud = m.nPoint;
at1pt = m.Circum1Pt;
at2pt = m.Circum2Pt;

figure("Name","Show result")
pcshow(ptCloud);
hold on;

pcshow(at1pt.Location, 'g');
pcshow(at2pt.Location, 'b', 'AxesVisibility', 'on');
hold off;


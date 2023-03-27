file = uigetfile('*.mat', ...
    'Select a file', ...
    'C:\Users\piyorin\dev\AnalyzeHoof\');

model = load(file);
mainPoint = model.nPoint;
close all;

pcshowWithAxes(mainPoint, "Posture_Controlled");

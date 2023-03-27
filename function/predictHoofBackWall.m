function len = predictHoofBackWall(Circum)
% param Circum = 球節周囲長
    len = (Circum * 0.1) * 0.1719 + 3.5886;
    len = len * 10;
end

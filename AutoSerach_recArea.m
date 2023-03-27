clear;
close;
% fileList = dir("C:\Users\piyorin\dev\AnalyzeHoof\new3dData\*.mat");
fileList = dir("./new3dData/*.mat");

numArrays = length(fileList); % ファイルの数
data = cell(numArrays,1); % 配列事前確保
ni = 1;
for ni = 1:length(fileList)
    close;
    chr = fileList(ni).name;
    data{ni} = chr;
    d(ni, 1) = string(chr);
    file = d(ni, 1);
    m = load(file);
    ptCloud = m.nPoint;
    t = 1;
    axIdx = 1;
    [PosData, PointSet] = sliceModel(ptCloud, t, axIdx);
    DataSize = length(PosData);
    avArea = zeros(DataSize, 3);
    rectangleArea = zeros(DataSize, 3);
    FitCircleRho = zeros(DataSize, 3);
    
    center = mean(PosData);
    index = PosData>= center;

    plusSectionPos = PosData(index);
    plusSectionPt = PointSet(index);
    sp = ptCloud.Location;
    
        for i = 1:DataSize
            pos = PosData(i);
            point = PointSet(i);
            pt = point.Location;
            yli = point.YLimits;
            zli = point.ZLimits;
            proJ = pt(:, [2 3]);
            ymax = min(proJ(:,1));
        
            [thetaSorted, rhoSorted] = sortPointOnPolar(proJ);
            [x, y] = pol2cart(thetaSorted, rhoSorted);
            sortSet = [x y];
       
        
            % 矩形面積
            y_range = abs(yli(2)-yli(1));
            z_range = abs(zli(2)-yli(1));
            recArea = y_range * z_range;
            rectangleArea(i,1) = pos;
            rectangleArea(i,3) = recArea;
     
        end
    spx_max1 = max(sp(:,1));
    idx_rec = rectangleArea(:,1) >= center & spx_max1-10 > rectangleArea(:,1);

    recPos = rectangleArea(:,1);
    recArea = rectangleArea(:,3);
    plrecPos = recPos(idx_rec);
    plrecArea = recArea(idx_rec);

    viewrec = [rectangleArea(:,1) rectangleArea(:,2) rectangleArea(:,3)/100];
    
    xli = ptCloud.XLimits;
    x_range = abs(xli(2)-xli(1));
    
    ptCloudA = pcdownsample(ptCloud, "random", 0.2, PreserveStructure=true);
    sp = ptCloudA.Location;
  

    [recMax, rec_idx] = max(rectangleArea(:,3));
    n = 3;
    Wn = 0.2;

    [rec_y, rec_v1, rec_v2] = filterAnddiff(plrecArea, n, Wn);
    TF = islocalmin(rec_v1, 'MaxNumExtrema',1 );
    TF2 = islocalmax(rec_v2, 'MaxNumExtrema',1);
    sec2At = plrecPos(TF2);
    idx_sec2 = recPos < sec2At & sec2At-70 < recPos;

    sec2avPos = recPos(idx_sec2);
    sec2avArea = recArea(idx_sec2);
    
    [s2av_y, s2a_v1, s2a_v2] = filterAnddiff(sec2avArea, n, Wn);
    s2_TF2 = islocalmax(s2a_v2, 'MaxNumExtrema',1);
    [max_s2y, I_sec2] = max(s2av_y);

    sec3At = sec2avPos(I_sec2);
    idx_sec3 = recPos < sec3At & sec3At-40 < recPos;
    
    sec3avPos = recPos(idx_sec3);
    sec3avArea = recArea(idx_sec3);
    [s3av_y, s3a_v1, s3a_v2]= filterAnddiff(sec3avArea, n, Wn);
    s3_TF = islocalmax(s3a_v1, 'MaxNumExtrema',1);
    s3_TF2 = islocalmax(s3a_v2, 'MaxNumExtrema',1);
    CircumCenter = sec3avPos(s3_TF2);

    sec1At = center;
    sec2_xline = sec2At;
    sec3_xline = sec3At;
    sec1_max = max(recPos);
    
    x_line = repmat(CircumCenter,200, 1);
    z_line = linspace(-125, 125, 200)';
    y_line = zeros(200, 1);
    y_line2 = zeros(length(recPos), 1);
    pc_line = [x_line y_line z_line];
    pc_rec = [recPos y_line2 recArea/100];
    sfig1 = figure("Name", "Show_Section");
    plot(recPos, recArea);
    xline(sec1At, '-g', {'Section1'});
    xline(sec1_max, '-g')
    xline(sec2_xline, '-b',{'Section2'});
    xline(sec2_xline-70,'-b');
    xline(sec3_xline, '-m',{'Section3'});
    xline(sec3_xline-40, '-m');
    xline(CircumCenter, '-r', 'LineWidth',3);

%     viewav = [recArea(:,1)  recArea(:,2) recArea(:,3)/100];
    [Y, aV1, aV2] = filterAnddiff(rectangleArea(:,3)/100, n, Wn);
    pt = ptCloudA.Location;
    
    diff1_pc = [rectangleArea(:,1) rectangleArea(:,2), (aV1/100)+60];
    diff2_pc = [rectangleArea(:,1) rectangleArea(:,2), (aV2/10000)+60];
    sfig2 = figure("Name","GETFIG");
    pcshow(pc_rec, 'm', 'MarkerSize', 15);
    hold on;
    pcshow(pc_line, 'g', 'MarkerSize', 25);
    pcshow(diff1_pc, 'b','MarkerSize', 18)
    pcshow(diff2_pc, 'r','MarkerSize', 18)
    pcshow(pt, 'w', 'AxesVisibility', 'on');
    view([0 0])
    hold off

    sampleWidth = 5;
    getCase1 = [CircumCenter, CircumCenter-sampleWidth];
    getCase2 = [CircumCenter-sampleWidth, CircumCenter-sampleWidth*2];
    
    idx1 = PosData >= getCase1(2) & getCase1(1) >= PosData;
    idx2 = PosData >= getCase2(2) & getCase2(1) >= PosData;
    getPoint1 = PointSet(idx1);
    getPoint2 = PointSet(idx2);

    sfig3 = figure('Name', 'marking');
    hold on;
    pcshow(ptCloudA, 'AxesVisibility', 'on');
    pcshow(pc_line, 'r')
    leng1 = zeros(length(getPoint1), 1);
    leng2 =  zeros(length(getPoint2), 1);
    % at1 = onews(length())
    atCir1 = [];
    atCir2 = [];
    for i = 1:length(getPoint1)
        gp = getPoint1(i).Location;
        gp_c= [gp(:,2) gp(:,3)];
        [thetaSorted, rhoSorted] = sortPointOnPolar(gp_c);
        [gp_x, gp_y] = pol2cart(thetaSorted, rhoSorted);
        gp_cross = [gp_x gp_y];
        try
            k = convhull(gp_cross);
        catch
            continue;
        end
        gpk = [gp_cross(k, 1), gp_cross(k,2)];
    %     figure(i);
    %     plot(gpk(:,1), gpk(:,2), '-or');
        len = calculateLengthForPoint(gpk);
        leng1(i) = len; 
        pcshow(gp, 'g', AxesVisibility="on");
       
        at1 = atCir1;
        atCir1 = [at1; gp];
    end
    
    for i = 1:length(getPoint1)
        gp = getPoint2(i).Location;
        gp_c= [gp(:,2) gp(:,3)];
        [thetaSorted, rhoSorted] = sortPointOnPolar(gp_c);
        [gp_x, gp_y] = pol2cart(thetaSorted, rhoSorted);
        gp_cross = [gp_x gp_y];
        try
            k = convhull(gp_cross);
        catch
            continue;
        end
        gpk = [gp_cross(k, 1), gp_cross(k,2)];
    %     figure(i);
    %     plot(gpk(:,1), gpk(:,2), '-or');
        len = calculateLengthForPoint(gpk);
        leng2(i) = len; 
        pcshow(gp, 'b', AxesVisibility="on");
        at2 = atCir2;
        atCir2 = [at2; gp];
    end
    
    pcshow(pc_line, 'g', 'MarkerSize', 25);
    pcshow(diff1_pc, 'b','MarkerSize', 18)
    pcshow(diff2_pc, 'r','MarkerSize', 18)
    pcshow(pt, 'w', 'AxesVisibility', 'on');
    view([0 0])
    hold off
    figure;
    pcshow(pt, 'w');
    hold on;
    pcshow(atCir1, 'g');
    pcshow(pc_line, 'g', 'MarkerSize', 25);
    pcshow(atCir2, 'b', 'AxesVisibility', 'on');
    view([0 0])
    hold off;
    Circum1 = mean(leng1);
    Circum2 = mean(leng2);
    hl1 = predictHoofBackWall(Circum1);
    hl2 = predictHoofBackWall(Circum2);
    saveMat = [string(file), Circum1, Circum2, hl1, hl2];
    savename = 'newMethod_rec';
    ext = '.xlsx';
    savexlsx = append(savename, ext);
    writematrix(saveMat, savexlsx, 'WriteMode','append');
    
    path = 'Third3dfile_rec/'; % macは/windowsは\
    path2 = 'ThirdnumData_rec/';
    chfile = convertStringsToChars(file);
    idx_f = length(chfile);
    nfile = chfile(1:idx_f-4);
    newfile = [path, nfile,'_rec', '.mat'];
    newfile2 = [path2, nfile, '_data_', '.mat'];
    nPoint = ptCloud;
    renPoint = ptCloudA;
    Circum1Pt = pointCloud(atCir1);
    Circum2Pt = pointCloud(atCir2);
    numData = [Circum1, Circum2, hl1, hl2];
    save(newfile, 'nPoint', 'renPoint','Circum1Pt','Circum2Pt','-mat');
    save(newfile2, 'Circum1', 'Circum2', 'hl1', 'hl2', '-mat')
    figpath = 'newfig_rec/';
    figfile1 = [figpath, nfile,'_Section', '.fig'];
    savefig(sfig1, figfile1);
    figpath2 = 'modelfig_rec/';
    figfile2 = [figpath2, nfile,'_Section_model', '.fig'];
    savefig(sfig2, figfile2);
    figpath3 = 'markfig_rec/';
    figfile3 = [figpath3, nfile,'_Section_mark_', '.fig'];
    savefig(sfig3, figfile3);


end




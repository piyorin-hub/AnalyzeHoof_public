clear;
close;
% fileList = dir("C:\Users\piyorin\dev\AnalyzeHoof\new3dData\*.mat");
fileList = dir("C:\Users\Makoto_Sasaki\Desktop\hayashi\AnalyzeHoof\new3dData\*.mat");

numArrays = length(fileList); % ファイルの数
data = cell(numArrays,1); % 配列事前確保
% ni = 1;
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

        
            % 近似円半径
            [cx, cy, cr] = CircleFitting(x, y);
            theta = linspace(0,2*pi,100);
            Xr = cr*cos(theta)+cx;
            Yr = cr*sin(theta)+cy;
            FitCircleRho(i, 1) = pos;
        
            FitCircleRho(i,3) = cr;
    
        
        
        end
    % 位置と半径情報
    fitPos = FitCircleRho(:,1);
    fitCirRho = FitCircleRho(:,3);
    % 真ん中から蹄方面切り出し
    idx_rho = FitCircleRho(:,1) >= center & spx_max1-10 > FitCircleRho(:,1);
    plfitCirPos = fitPos(idx_rho);
    plfitCirRho = fitCirRho(idx_rho);
    viewrho = [FitCircleRho(:,1) FitCircleRho(:,2) FitCircleRho(:,3)*1.2];
    
    xli = ptCloud.XLimits;
    x_range = abs(xli(2)-xli(1));
    
    %　表示用にダウンサンプルした点群データ
    ptCloudA = pcdownsample(ptCloud, "random", 0.2);
    sp = ptCloudA.Location;
    [rhMax, rh_idx] = max(FitCircleRho(:,3));
    
    n = 3;
    Wn = 0.2;
    %　くびれ部分の発見
    [rho_y, rho_v1, rho_v2] = filterAnddiff(plfitCirRho, n, Wn);
    TF = islocalmin(rho_v1, 'MaxNumExtrema',1 );
    TF2 = islocalmax(rho_v2, 'MaxNumExtrema',1);
    sec2At = plfitCirPos(TF2);
    idx_sec2 = fitPos < sec2At & sec2At-70 < fitPos;

    sec2CirPos = fitPos(idx_sec2);
    sec2CirRho = fitCirRho(idx_sec2);
    % 副蹄の山の頂点
    [s2rho_y, s2rho_v1, s2rho_v2] = filterAnddiff(sec2CirRho, n, Wn);
    s2_TF2 = islocalmax(s2rho_v2, 'MaxNumExtrema',1);
    [max_s2y, I_sec2] = max(s2rho_y);

    sec3At = sec2CirPos(I_sec2);
    idx_sec3 = fitPos < sec3At & sec3At-40 < fitPos;
    
    sec3fitPos = fitPos(idx_sec3);
    sec3fitArea = fitCirRho(idx_sec3);
    [s3av_y, s3rho_v1, s3rho_v2]= filterAnddiff(sec3fitArea, n, Wn);
    s3_TF = islocalmax(s3rho_v1, 'MaxNumExtrema',1);
    s3_TF2 = islocalmax(s3rho_v2, 'MaxNumExtrema',1);
    CircumCenter = sec3fitPos(s3_TF2);

    sec1At = center;
    sec2_xline = sec2At;
    sec3_xline = sec3At;
    sec1_max = max(fitPos);
    
    x_line = repmat(CircumCenter,200, 1);
    z_line = linspace(-125, 125, 200)';
    y_line = zeros(200, 1);
    y_line2 = zeros(length(fitPos), 1);
    pc_line = [x_line y_line z_line];
    pc_conv = [fitPos y_line2 FitCircleRho*1.2];
    sfig1 = figure("Name", "Show_Section");
    plot(fitPos, fitCirRho);
    xline(sec1At, '-g', {'Section1'});
    xline(sec1_max, '-g')
    xline(sec2_xline, '-b',{'Section2'});
    xline(sec2_xline-70,'-b');
    xline(sec3_xline, '-m',{'Section3'});
    xline(sec3_xline-40, '-m');
    xline(CircumCenter, '-r', 'LineWidth',3);

    viewrho = [FitCircleRho(:,1)  FitCircleRho(:,2) FitCircleRho(:,3)*1.2];
    [Y, aV1, aV2] = filterAnddiff(FitCircleRho(:,3)*1.2, n, Wn);
    pt = ptCloudA.Location;
    
    diff1_pc = [FitCircleRho(:,1) FitCircleRho(:,2), (aV1/100)+60];
    diff2_pc = [FitCircleRho(:,1) FitCircleRho(:,2), (aV2/10000)+60];
    sfig2 = figure("Name","GETFIG");
    pcshow(pc_conv, 'm', 'MarkerSize', 15);
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
    pcshow(ptCloudA);
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

        len = calculateLengthForPoint(gpk);
        leng2(i) = len; 
        pcshow(gp, 'b', AxesVisibility="on");
        at2 = atCir2;
        atCir2 = [at2; gp];
    end
    
    pcshow(pc_line, 'g', 'MarkerSize', 25);
    pcshow(diff1_pc, 'b','MarkerSize', 18)
    pcshow(diff2_pc, 'r','MarkerSize', 18)
    pcshow(pt, 'w');
    view([0 0])
    hold off
    figure;
    pcshow(pt, 'w');
    hold on;
    pcshow(atCir1, 'g');
    pcshow(pc_line, 'g', 'MarkerSize', 25);
    pcshow(atCir2, 'b');
    view([0 0])
    hold off;
    Circum1 = mean(leng1);
    Circum2 = mean(leng2);
    hl1 = predictHoofBackWall(Circum1);
    hl2 = predictHoofBackWall(Circum2);
    saveMat = [string(file), Circum1, Circum2, hl1, hl2];
    savename = 'newMethod';
    ext = '.xlsx';
    savexlsx = append(savename, ext);
    writematrix(saveMat, savexlsx, 'WriteMode','append');
    
    path = 'Third3dfile_rho/'; % macは/windowsは\
    path2 = 'ThirdnumData_rho/';
    chfile = convertStringsToChars(file);
    idx_f = length(chfile);
    nfile = chfile(1:idx_f-4);
    newfile = [path, nfile, '_rho','.mat'];
    newfile2 = [path2, nfile, '_data_', '.mat'];
    nPoint = ptCloud;
    renPoint = ptCloudA;
    Circum1Pt = pointCloud(atCir1);
    Circum2Pt = pointCloud(atCir2);
    numData = [Circum1, Circum2, hl1, hl2];
    save(newfile, 'nPoint', 'renPoint','Circum1Pt','Circum2Pt','-mat');
    save(newfile2, 'Circum1', 'Circum2', 'hl1', 'hl2', '-mat')
    figpath = 'newfig_rho/';
    figfile1 = [figpath, nfile,'_Section', '.fig'];
    savefig(sfig1, figfile1);
    figpath2 = 'modelfig_rho/';
    figfile2 = [figpath2, nfile,'_Section_model', '.fig'];
    savefig(sfig2, figfile2);
    figpath3 = 'markfig_rho/';
    figfile3 = [figpath3, nfile,'_Section_mark_', '.fig'];
    savefig(sfig3, figfile3);


end




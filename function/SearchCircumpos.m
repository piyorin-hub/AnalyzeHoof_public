function [index1,index2,samplePos1,samplePos2, rPos, yset, TF] = SearchCircumpos(Data,sampleWidth, n, Wn)
    % 第一区間探索
    pos = Data(:,1);
    area = Data(:,3);
    [~, I] = max(area);
    %　蹄断面積最大位置から130のところまで
    cutData = Data(Data(:,1) > pos(I)-80 & pos(I) > Data(:,1),:);
    cPos = cutData(:,1);
    cArea = cutData(:,3);
    %　フィルター処理と微分
    [y1, v1, v2] = filterAnddiff(cArea, n, Wn);
    TF = islocalmin(v1, 'MaxNumExtrema',1);
    %　第二区間探索
    RecutData = cutData(cutData(:,1) < cPos(TF)-10, :);
    rPos = RecutData(:,1);
    r3 = RecutData(:,3);
    
    [yr, v1_r, v2_r] = filterAnddiff(r3, n, Wn);
    mTF = islocalmax(v1_r, 'MaxNumExtrema',2);
    localMaxSet = [rPos(mTF) v1_r(mTF)];
    [~, I] = max(localMaxSet(:,2));
    rx_ex1 = localMaxSet(I);
    mTF2 = islocalmax(v2_r, 'MaxNumExtrema',2);
    localMaxSet2 = [rPos(mTF2) v2_r(mTF2)];
    [~, I2] = max(localMaxSet2(:,2));
    rx_ex2 = localMaxSet2(I2);

    TF = [mTF, mTF2];
    yset = [yr, v1_r, v2_r];
    samplemin = rx_ex1-sampleWidth;
    samplemax = rx_ex1;
    samplePos1 = [samplemin, samplemax];
    index1 = Data(:,1) > samplemin & samplemax > Data(:,1);
    
    samplemin2 = rx_ex2-(sampleWidth/2);
    samplemax2 = rx_ex2+(sampleWidth/2);
    samplePos2 = [samplemin2, samplemax2];
    index2 = Data(:,1) > samplemin2 & samplemax2 > Data(:,1);
end
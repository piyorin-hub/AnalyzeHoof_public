function [ cx, cy, r ] = CircleFitting(x,y)
%CIRCLEFITTING 最小二乗法による円フィッテングをする関数
% input: x,y 円フィッティングする点群
% output cx 中心x座標
%        cy 中心y座標
%        r  半径
    sumx=sum(x);
    sumy=sum(y);
    sumx2=sum(x.^2);
    sumy2=sum(y.^2);
    sumxy=sum(x.*y);
    
    F=[sumx2 sumxy sumx;
       sumxy sumy2 sumy;
       sumx  sumy  length(x)];
    
    G=[-sum(x.^3+x.*y.^2);
       -sum(x.^2.*y+y.^3);
       -sum(x.^2+y.^2)];
    
    T=F\G;
    
    cx=T(1)/-2;
    cy=T(2)/-2;
    r=sqrt(cx^2+cy^2-T(3));

end
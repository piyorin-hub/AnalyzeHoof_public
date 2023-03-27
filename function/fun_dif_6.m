function [varargout] = fun_dif_6(pos,varargin)
%1回微分，2回微分をとる
%varargout=[dif1,dif2] varargin サンプリング周波数
%%%%%%%%%%%%%%%% 5点微分 %%%%%%%%%%%%%%%%%%%%%%%
format long
if nargin<2
    Fs=1000;%サンプリング周波数
end
if nargin>1
    Fs=varargin{1};%サンプリング周波数
end

sam_fr=1/Fs;%サンプリング周波数1000Hz

[dataMaxNum_m,~]=size(pos);
%%%%%%%%%%%%%%%% 1階微分 %%%%%%%%%%%%%%%%%%%%%%%
dif1=zeros;
for i=1:dataMaxNum_m
    if i==1
        dif1(i,:)=(1/(12*sam_fr))*(-25*pos(i,:)+48*pos(i+1,:)-36*pos(i+2,:)+16*pos(i+3,:)-3*pos(i+4,:));
        
    elseif i==2
        dif1(i,:)=(1/(12*sam_fr))*(-3*pos(i-1,:)-10*pos(i,:)+18*pos(i+1,:)-6*pos(i+2,:)+1*pos(i+3,:));
    
    elseif i==dataMaxNum_m-1
        dif1(i,:)=(1/(12*sam_fr))*(-1*pos(i-3,:)+6*pos(i-2,:)-18*pos(i-1,:)+10*pos(i,:)+3*pos(i+1,:));
    
    elseif i==dataMaxNum_m
        dif1(i,:)=(1/(12*sam_fr))*(3*pos(i-4,:)-16*pos(i-3,:)+36*pos(i-2,:)-48*pos(i-1,:)+25*pos(i,:));
        
    else
        dif1(i,:)=(1/(12*sam_fr))*(1*pos(i-2,:)-8*pos(i-1,:)+8*pos(i+1,:)-1*pos(i+2,:));
    end
end
%%%%%%%%%%%%%%%% 2階微分 %%%%%%%%%%%%%%%%%%%%%%%
dif2=zeros;
for i=1:dataMaxNum_m
    if i==1
        dif2(i,:)=(1/(12*sam_fr))*(-25*dif1(i,:)+48*dif1(i+1,:)-36*dif1(i+2,:)+16*dif1(i+3,:)-3*dif1(i+4,:));
        
    elseif i==2
        dif2(i,:)=(1/(12*sam_fr))*(-3*dif1(i-1,:)-10*dif1(i,:)+18*dif1(i+1,:)-6*dif1(i+2,:)+1*dif1(i+3,:));
    
    elseif i==dataMaxNum_m-1
        dif2(i,:)=(1/(12*sam_fr))*(-1*dif1(i-3,:)+6*dif1(i-2,:)-18*dif1(i-1,:)+10*dif1(i,:)+3*dif1(i+1,:));
    
    elseif i==dataMaxNum_m
        dif2(i,:)=(1/(12*sam_fr))*(3*dif1(i-4,:)-16*dif1(i-3,:)+36*dif1(i-2,:)-48*dif1(i-1,:)+25*dif1(i,:));
        
    else
        dif2(i,:)=(1/(12*sam_fr))*(1*dif1(i-2,:)-8*dif1(i-1,:)+8*dif1(i+1,:)-1*dif1(i+2,:));
    end
end
%%%%%%%%%%%%%%%% 3階微分 %%%%%%%%%%%%%%%%%%%%%%%
dif3=zeros;
for i=1:dataMaxNum_m
    if i==1
        dif3(i,:)=(1/(12*sam_fr))*(-25*dif2(i,:)+48*dif2(i+1,:)-36*dif2(i+2,:)+16*dif2(i+3,:)-3*dif2(i+4,:));
        
    elseif i==2
        dif3(i,:)=(1/(12*sam_fr))*(-3*dif2(i-1,:)-10*dif2(i,:)+18*dif2(i+1,:)-6*dif2(i+2,:)+1*dif2(i+3,:));
    
    elseif i==dataMaxNum_m-1
        dif3(i,:)=(1/(12*sam_fr))*(-1*dif2(i-3,:)+6*dif2(i-2,:)-18*dif2(i-1,:)+10*dif2(i,:)+3*dif2(i+1,:));
    
    elseif i==dataMaxNum_m
        dif3(i,:)=(1/(12*sam_fr))*(3*dif2(i-4,:)-16*dif2(i-3,:)+36*dif2(i-2,:)-48*dif2(i-1,:)+25*dif2(i,:));
        
    else
        dif3(i,:)=(1/(12*sam_fr))*(1*dif2(i-2,:)-8*dif2(i-1,:)+8*dif2(i+1,:)-1*dif2(i+2,:));
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%1回微分、2回微分値を返す
if nargout<2 %返り値１つ
    varargout{1}=dif1;
elseif nargout<3 %返り値2つ
    varargout{1}=dif1;
    varargout{2}=dif2;
else %返り値3つ
    varargout{1}=dif1;
    varargout{2}=dif2;
    varargout{3}=dif3; 
end

    

end
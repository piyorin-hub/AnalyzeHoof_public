function [PosData, Points] = sliceModel(ptCloud, t, axIdx)
% param1 => pointCloud
% t => slice_size
% axIdx => Cut-direction Axes (if you want cut 'x'-direction, you shoud set 
% "axIdx = 1")
% 
   
   Xli = ptCloud.XLimits;
   pt = ptCloud.Location;
   
   diff = abs(Xli(2)-Xli(1));
   num =round(diff/t);

   idx = 0;
   Data = zeros(num, 1);
%    PointData=zeros(num, 1);

   for i = Xli(1):t:Xli(2)
       dt = i+t;
       idx = idx + 1;
       cross_section = pt(pt(:,axIdx)>(dt-t) & (dt+t)>pt(:,axIdx), :);
       pointSet = pointCloud(cross_section);
       Data(idx, 1) = dt;
       PointData(idx, 1) = pointSet;
   end
   PosData = Data;
   Points = PointData;
end
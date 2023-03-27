function len = calculateLengthForPoint(Point2d)
% this function calculate the length of some Points
    len = 0.0;
    for i = 1:length(Point2d)-1
        diff = norm(Point2d(i,:) - Point2d(i+1,:));
        len = len + diff; 
    end
    len = len + norm(Point2d(1,:) - Point2d(length(Point2d),:));
%     disp(len);
end
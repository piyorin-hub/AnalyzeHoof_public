function [thetaSorted, rhoSorted] = sortPointOnPolar(Point)
    % param point ->assumption:slash2d
    %
    x = Point(:,1);
    y = Point(:,2);
    [theta, rho] = cart2pol(x,y);
%     figure('Name', 'BeforeSort');
% 
%     polarplot(theta, rho);
%     
    % sort
    [thetaSorted, I] = sort(theta);
    rhoSorted = rho(I);
end

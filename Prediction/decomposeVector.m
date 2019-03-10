function [x,y] = decomposeVector(magnitude,angle)
%DECOMPOSEVECTOR Given the magnitude and angle of a vector,decompose it into x and y direction 
if(angle < 90)
    x = magnitude * sind(angle);
    y = magnitude * cosd(angle);
elseif(angle < 180)
    angle = angle - 90;
    x = magnitude * cosd(angle);
    y = - magnitude * sind(angle);
    
elseif (angle < 270)
    angle = angle - 180;
    x = -magnitude * sind(angle);
    y = -magnitude * cosd(angle);
else
    angle = angle - 270;
    x = -magnitude * cosd(angle);
    y = magnitude * sind(angle);
end


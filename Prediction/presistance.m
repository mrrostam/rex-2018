function w = presistance(past_data,t)
%PRESISTANCE Summary of this function goes here
%   Detailed explanation goes here
last_row = tail(past_data);
x_pre = last_row.x;
y_pre = last_row.y;
x = repmat(x_pre,t,1);
y = repmat(y_pre,t,1);
w = [x,y];
end


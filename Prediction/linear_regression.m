function w = linear_regression(past_data,t)
%LINEAR_REGRESSION Given past data,will predict the wind speed of the next
%timestamp
%   I assume that the next timestamp will be the next time stamp after the
%   latest data
% The data should be in the shape of [datetime,x,y],where datetime is the record
%time of the windspeed that is taken,x is the speed along x-axis, and y is the wind-speed along
%side y-axis%
    X_train = past_data.datetime;
    y_train_x = past_data.x;
    y_train_y = past_data.y;
    X_train = posixtime(X_train);
    p_x = polyfit(X_train,y_train_x,2);
    p_y = polyfit(X_train,y_train_y,2);
    %Find the base timestamp to base our prediction on%
    timestamp_base = max(X_train);
    %Since we are using unix timesatmp and each interval is 0.1s, we will
    %just multiple the timestamp value by 100%
    next_timestamp_vector = (1:t).*100+ timestamp_base;
    %perform prediction here%
    x_hat = polyval(p_x,next_timestamp_vector);
    y_hat = polyval(p_y,next_timestamp_vector);
    w = [x_hat,y_hat];
end


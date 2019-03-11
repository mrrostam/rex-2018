
function w = gaussian_process(past_data,t)
%GAUSSAIN_PROCESS return the prediction of wind speed using gaussian
%process
% Not much description right now
X_train = past_data.datetime;
y_train_x = past_data.x;
y_train_y = past_data.y;
X_train = posixtime(X_train);
gp_model_x = fitrgp(X_train,y_train_x);
gp_model_y = fitrgp(X_train,y_train_y);
timestamp_base = max(X_train);
next_timestamp_vector = (1:t).*100+ timestamp_base;
x_hat = predict(gp_model_x,next_timestamp_vector);
y_hat = predict(gp_model_y,next_timestamp_vector);

w = [x_hat,y_hat];
end


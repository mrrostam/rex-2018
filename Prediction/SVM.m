function w = SVM(past_data,t)
%SVM use a support vector machine to predict the wind speed of next
%timestamp
%   Detailed explanation goes here
X_train = past_data.datetime;
y_train_x = past_data.x;
y_train_y = past_data.y;
X_train = posixtime(X_train);
SVM_x = fitrsvm(X_train,y_train_x);
SVM_y = fitrsvm(X_train,y_train_y);
timestamp_base = max(X_train);
next_timestamp_vector = (1:t).*100+ timestamp_base;
x_hat = predict(SVM_x,next_timestamp_vector);
y_hat = predict(SVM_y,next_timestamp_vector);
w = [x_hat,y_hat]
end


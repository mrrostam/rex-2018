%Read and claer the data beforehand%
clear;
x_train = readtable('Datasets\x_train.csv');
y_train = readtable('Datasets\y_train.csv');
x_test = readtable('Datasets\x_test.csv');
y_test = readtable('Datasets\y_test.csv');
%Fetch specific column from the table%
X = x_train.datetime;
X_test = x_test.datetime;
y_train_x = y_train.x;
y_train_y = y_train.y;
y_test_x = y_test.x;
y_test_y = y_test.y;
%convert datatime to unix time for regression%
X = posixtime(X);
X_test = posixtime(X_test);
p_x = polyfit(X,y_train_x,2);
p_y = polyfit(X,y_train_y,2);
y_x_hat = polyval(p_x,X_test);
y_y_hat = polyval(p_y,X_test);
MSE_x = sum( (y_x_hat - y_test_x).^2);
MSE_y = sum(((y_y_hat) - y_test_y).^2);
fprintf("Mean square error of x prediction:%d\n" + MSE_x);
fprintf("Mean sqaure error fo y prediction:%d\n" + MSE_y);
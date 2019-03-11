%Read and claer the data beforehand%
x_train = readtable('Datasets\x_train.csv');
y_train = readtable('Datasets\y_train.csv');
x_test = readtable('Datasets\x_test.csv');
y_test = readtable('Datasets\y_test.csv');
%Fetch specific column from the table%
x_train = tail(x_train,5000);
y_train = tail(y_train,5000);
X = x_train.datetime;
X_test = x_test(1:10,:).datetime;
y_train_x = y_train.x;
y_train_y = y_train.y;
y_test_x = y_test(1:10,:).x;
y_test_y = y_test(1:10,:).y;
%convert datatime to unix time for regression%
X = datenum(X);
minstamp = min(X);
X = X - minstamp;
X_test = datenum(X_test);
X_test = X_test-minstamp;
p_x = polyfit(X,y_train_x,5);
p_y = polyfit(X,y_train_y,5);
y_x_hat = polyval(p_x,X_test);
y_y_hat = polyval(p_y,X_test);
MSE_x = sum( (y_x_hat - y_test_x).^2);
MSE_y = sum(((y_y_hat) - y_test_y).^2);
fprintf("Mean square error of x prediction:%d\n" + MSE_x);
fprintf("Mean sqaure error fo y prediction:%d\n" + MSE_y);
result = y_test(1:10,1);
result.x = y_test(1:10,:).x;
result.y = y_test(1:10,:).y;
result.x_hat = y_x_hat;
result.y_hat = y_y_hat;
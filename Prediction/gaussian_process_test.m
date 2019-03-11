%test on the gaussian process%
x_train = readtable('Datasets\x_train.csv');
y_train = readtable('Datasets\y_train.csv');
x_test = readtable('Datasets\x_test.csv');
y_test = readtable('Datasets\y_test.csv');
%Fetch specific column from the table%
x_train = tail(x_train,5000);
y_train = tail(y_train,5000);
X = x_train.datetime;
x_test = x_test(1:10,:);
X_test = x_test.datetime;
y_train_x = y_train.x;
y_train_y = y_train.y;
y_test_x = y_test(1:10,:).x;
y_test_y = y_test(1:10,:).y;
%convert datatime to date num for regression%
X = datenum(X);
minstamp = min(X);
X = X - minstamp;
X_test = datenum(X_test);
X_test = X_test - minstamp;
gp_model_x = fitrgp(X,y_train_x);
gp_model_y = fitrgp(X,y_train_y);
x_hat = predict(gp_model_x,X_test);
y_hat = predict(gp_model_y,X_test);
MSE_x = sum( (x_hat - y_test_x).^2);
MSE_y = sum(((y_hat) - y_test_y).^2);
fprintf("Mean square error of x prediction:%d\n" + MSE_x);
fprintf("Mean sqaure error fo y prediction:%d\n" + MSE_y);
x_test.x = x_hat;
x_test.y = y_hat;
gau_result = y_test(1:10,1);
gau_result.x = y_test(1:10,:).x;
gau_result.y = y_test(1:10,:).y;
gau_result.x_hat = x_hat;
gau_result.y_hat = y_hat;

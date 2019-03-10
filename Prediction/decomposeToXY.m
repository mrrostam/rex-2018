clear;
y_train = readtable('Datasets\y_train.csv');
y_train.x = zeros(height(y_train),1);
y_train.y = zeros(height(y_train),1);
y_test = readtable('Datasets\y_test.csv');
y_test.x = zeros(height(y_test),1);
y_test.y = zeros(height(y_test),1);

for i = 1: height(y_train)
    row = y_train(i,:);
    direction = row.wind_direction;
    speed = row.wind_speed;
    [x,y] = decomposeVector(speed,direction);
    row.x = x;
    row.y = y;
    y_train(i,:) = row;
end
for i = 1: height(y_test)
    row = y_test(i,:);
    direction = row.wind_direction;
    speed = row.wind_speed;
    [x,y] = decomposeVector(speed,direction);
    row.x = x;
    row.y = y;
    y_test(i,:) = row;
end
writetable(y_train,'Datasets\y_train.csv');
writetable(y_test,'Datasets\y_test.csv');
% read in all tables first
clear;
humidity_table = import_file('Datasets\humidity.csv', 1, inf);
pressure_table = import_file('Datasets\pressure.csv', 1, inf);
temperature_table = import_file('Datasets\temperature.csv', 1, inf);
weather_description_table = import_weather_description('Datasets\weather_description.csv', 1, inf);
wind_direction_table = import_file('Datasets\wind_direction.csv', 1, inf);
wind_speed_table = import_file('Datasets\wind_speed.csv', 1, inf);

% now join all tables together
combined_table = join(humidity_table,pressure_table,'Keys',1);
combined_table = join(combined_table,temperature_table,'Keys',1);
combined_table = join(combined_table,weather_description_table,'Keys',1);
combined_table = join(combined_table,wind_direction_table,'Keys',1);
combined_table = join(combined_table,wind_speed_table,'Keys',1);

%rename the column names for the combined_table
combined_table.Properties.VariableNames = {'datetime','humidity','pressure','temperature','weather_description','wind_direction','wind_speed'};
%remove all row containing nan
reduced_table = rmmissing(combined_table);
%perform train test split of the table and save them
reduced_table_x = reduced_table(:,{'datetime','humidity','pressure','temperature','weather_description'});
reduced_table_y = reduced_table(:,{'datetime','wind_direction','wind_speed'});

[trainInd,valInd] = divideblock(height(reduced_table_x),0.7,0.3);
x_train = reduced_table_x(trainInd,:);
y_train = reduced_table_y(trainInd,:);
x_test = reduced_table_x(valInd,:);
y_test = reduced_table_y(valInd,:);
writetable(x_train,'Datasets\x_train.csv');
writetable(y_train,'Datasets\y_train.csv');
writetable(x_test,'Datasets\x_test.csv');
writetable(y_test,'Datasets\y_test.csv');
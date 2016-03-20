%% Datastores.
% * Create and calibrate a datastore corresponding to 
% the hurricane data.
fileLocation = ...
'C:\Users\kdeeley\Desktop\class_York\Data\hurricaneData\*.txt';         
% Tip: if you specify the fully-qualified path, this can
% avoid errors to do with being in the right folder etc.

% Create the datastore (using the default settings).
ds = datastore(fileLocation);

% Calibration stage.
ds.CommentStyle = '##'; 
% (Skip/ignore any lines beginning with ##.)
ds.Delimiter = '\t'; 
% (Column separator is a tab (\t).)
ds.ReadVariableNames = false; % Don't read the names

% We can define the names ourself:
ds.VariableNames = {'Timestamp', 'Latitude', ...
    'Longitude', 'Windspeed', 'Pressure'};
ds.TextscanFormats{1} = '%D'; % 1st column is datetimes

% * Use the preview command to ensure the datastore is 
% calibrated correctly.
check = preview(ds);

%% Read the data.
% Option 1: readall - reads everything.
% Option 2: read - reads block-by-block.
T = readall(ds);

%% Example calculation (e.g. mean windspeed by month).
T.Month = month(T.Timestamp); % Add month column
f = @(x) [mean(x), std(x), min(x), max(x), median(x)];
monthlyStats = varfun(f, T, ...
    'InputVariables', {'Windspeed', 'Pressure'}, ...
    'GroupingVariables', 'Month');

% Tidy up the stats. names.
wsStats = monthlyStats.Fun_Windspeed;
wsStats = array2table(wsStats, 'VariableNames', ...
    {'Mean', 'Std', 'Min', 'Max', 'Median'});






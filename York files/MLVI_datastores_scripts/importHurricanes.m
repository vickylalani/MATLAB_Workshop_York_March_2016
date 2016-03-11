clear; close all; clc

%% Import location data
% Create data store
dat = datastore('hurricaneData/Location/hurricaneData*.txt', ...
    'CommentStyle', '##', ...
    'Delimiter'   , '\t', ...
    'NumHeaderLines', 0,...
    'ReadVariableNames', true);
    
dat.TextscanFormats{2}    = '%D';
dat.TextscanFormats{end}  = '%C';

%% Deselect variables (latitude and longitude)
dat.SelectedVariableNames = setdiff(dat.VariableNames, {'Latitude','Longitude'}, 'stable');

%% Preview data
preview(dat)

%% Read data from all files
data = readall(dat);

%% Import wind speed data

dat = datastore('hurricaneData/Windspeed/hurricaneData*.txt', ...
    'CommentStyle', '##', ...
    'Delimiter'   , '\t', ...
    'NumHeaderLines', 0,...
    'ReadVariableNames', true);

dat.TextscanFormats{2} = '%D';

preview(dat)

%% Read data and merge with existing data
data = join(data,readall(dat));

%% Import pressure data
dat = datastore('hurricaneData/Pressure/hurricaneData*.txt', ...
    'CommentStyle', '##', ...
    'Delimiter'   , '\t', ...
    'NumHeaderLines', 0,...
    'ReadVariableNames', true);
    
dat.TextscanFormats{2} = '%D';

preview(dat)

%% Read data and merge with existing data

data = outerjoin(data,readall(dat),'Type','left','MergeKeys',true);

%% Sort rows by timestamp
data = sortrows(data,'Timestamp');
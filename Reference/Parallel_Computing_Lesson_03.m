%% Working with Datastores.

%% Create a list of files to use with the datastore.
fileList = ['..', filesep, 'Data', filesep, 'hurricaneData', filesep, '*.txt'];

%% Create the datastore.
ds = datastore(fileList);

%% Calibrate the datastore.
ds.CommentStyle = '##';
ds.Delimiter = '\t';
ds.ReadVariableNames = false;
ds.VariableNames = {'Timestamp', 'Latitude', 'Longitude', 'Windspeed', 'Pressure'};
ds.TextscanFormats = {'%D', '%f', '%f', '%f', '%f'};

%% Preview to ensure correct calibration.
hurrPreview = preview(ds);
display(hurrPreview)

%% Set the required batch size.
ds.ReadSize = 'file'; % Or, specify the number of lines to read.

%% Simple calculation illustrating the use of datastore batch processing.
% Task: what is the overall maximum windspeed?
maxWS = -Inf;
while hasdata(ds)
    T = read(ds); % Read the next chunk.
    m = max(T.Windspeed);
    if m > maxWS
        maxWS = m;
    end % if
end % while

%% Exercise: compute the overall minimum windspeed.
reset(ds); % Ensure we reset the datastore to its original position.

%% Sometimes intermediate storage is required.
% Task: suppose we want to compute the mean windspeed.
reset(ds); % Ensure we reset the datastore to its original position.
intermCounts = [];
intermSums = [];
while hasdata(ds)
    T = read(ds);
    ws = T.Windspeed;
    intermCounts(end+1, 1) = numel(ws); %#ok<*SAGROW>
    intermSums(end+1, 1) = sum(ws);
end
meanWS = sum(intermSums) / sum(intermCounts);

%% How can we take advantage of parallel programming in this context?
reset(ds);
N = numpartitions(ds, gcp);
intermCounts = zeros(N, 1);
intermSums = zeros(N, 1);
parfor k = 1:N
    subds = partition(ds, N, k);
    while hasdata(subds)
        T = read(subds);
        ws = T.Windspeed;
        intermCounts(k) = intermCounts(k) + numel(ws);
        intermSums(k) = intermSums(k) + sum(ws);
    end % while
end % parfor
meanWS2 = sum(intermSums) / sum(intermCounts);
        
%% Exercise.
% Compute the overall sum of the squared windspeed values using batch
% processing. Hence evaluate the mean squared windspeed and the standard
% deviation of the windspeeds.

%% Further examples: missing data and aggregation.
% Task: compute the mean monthly wind speeds.
reset(ds);
intermCounts = [];
intermSums = [];
while hasdata(ds)
    T = read(ds);
    validIdx = ~isnan(T.Windspeed);
    mths = month(T.Timestamp(validIdx));
    ws = T.Windspeed(validIdx);
    intermCounts(end+1, :) = accumarray(mths, ws, [12, 1], @numel);
    intermSums(end+1, :) = accumarray(mths, ws, [12, 1], @sum);
end
meanMonthlyWindspeeds = sum(intermSums) ./ sum(intermCounts);

% Visualise.
figure
plot(meanMonthlyWindspeeds, 'b.-', 'LineWidth', 2)
xlabel('Month')
ylabel('Mean Windspeed (mph)')
title('Mean Monthly Windspeeds')
grid
monthNames = month(datetime(2000, 1:12, 1), 'shortname');
set(gca, 'XTick', 1:12, 'XTickLabel', monthNames)

%% Exercise: compute the following monthly windspeed statistics.
% * standard deviation;
% * minimum;
% * maximum.

%% Sometimes we need to read all data to perform a computation.
% Task: compute the median windspeed.
reset(ds);
ds.SelectedVariableNames = {'Windspeed'};
T = readall(ds);
medWS = median(T.Windspeed);
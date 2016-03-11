%% Clear everything
clear; clc; close all

%% Load data
load rawhurricanedata.mat

%% Determine location ("land" vs "sea")
% Obtain the list of countries (by removing "N/A" from the full list)
ctry = setdiff(categories(data.Country), 'N/A');

% Merge all countries into a single "Land" category
data.Location = mergecats(data.Country, ctry, 'Land');

% Rename the "N/A" category to "Sea"
data.Location = renamecats(data.Location, 'N/A', 'Sea');

%% Categorize each wind speed measurement by the Saffir-Simpson hurricane scale
SSscale  = [0 39 74 96 111 130 157 Inf];
catnames = {'TD','TS','1','2','3','4','5'};
data.HurrCat = discretize(data.Windspeed, SSscale, 'Categorical', catnames);

%% Number each individual hurricane
% Create a unique number for each hurricane by taking combinations of the
% year and the hurricane number (within the year)
data.RunningNumber = findgroups(year(data.Timestamp), data.Number);

% Sort by number then timestamp
data = sortrows(data,{'RunningNumber','Timestamp'});

% %% Remove missing data
% height(data)
% badrows = any(ismissing(data), 2);
% data(badrows, :) = [];
% height(data)

%% Compute average wind speed and pressure of hurricanes grouped by category and location
[groups, byCatLoc] = findgroups(data(:,{'HurrCat', 'Location'}));
byCatLoc.AverageWindspeed = splitapply(@mean, data.Windspeed, groups);
byCatLoc.AveragePressure  = splitapply(@(x) mean(x, 'omitnan'), data.Pressure, groups);

%% 1) Make a scatter plot of wind speed and pressure for land and sea
%% Determine the number of observations at each speed/pressure combination
% Get unique combinations of wind speed, pressure, and location.
vars = {'Windspeed', 'Pressure', 'Location'};
[group, WSPL] = findgroups(data(:,vars));

% Count the number of observations in each combination
obscounts = histcounts(group,'BinMethod','integers');
WSPL.NumObs = obscounts';

%% Scatter plot
figure(1)
scl = 2.5;  % Scaling factor for marker size

% Find all hurricanes on land
onland = (WSPL.Location == 'Land');

% Set color and transparency properties
scatter(WSPL.Windspeed(~onland), WSPL.Pressure(~onland), ...
    scl*WSPL.NumObs(~onland),'filled', ...
    'MarkerEdgeColor', 'flat', ...
    'MarkerEdgeAlpha', 0.8, ...
    'MarkerFaceAlpha', 0.4);

hold on

scatter(WSPL.Windspeed(onland), WSPL.Pressure(onland), ...
    scl*WSPL.NumObs(onland), 'filled', ...
    'MarkerEdgeColor', 'flat', ...
    'MarkerEdgeAlpha', 0.8, ...
    'MarkerFaceAlpha', 0.4);

% Annotate
xlabel('Wind speed [mph]')
ylabel('Pressure [mbar]')
legend('Sea','Land')
hold off

%% Tally the number of hurricanes by category and country
% Group data by hurricane number and country
[group, byCtry] = findgroups(data(:,{'RunningNumber', 'Country'}));

% Find the hurricane category for each group
byCtry.HurrCat = splitapply(@max, data.HurrCat, group);

% Count the number of hurricanes in each category for each country
ctry_num       = double(byCtry.Country);
cat_num        = double(byCtry.HurrCat);
countByCatCtry = accumarray([ctry_num,cat_num],1);

% Get the names of the categories and countries
cat_name  = categories(byCtry.HurrCat);
ctry_name = categories(byCtry.Country);

%% Select the countries with at least 20 observations
% Calculate the total number of hurricanes in each country
totalCtry = sum(countByCatCtry, 2);

% Sort by total number
[totalCtry, idx] = sort(totalCtry,'descend');

% Reorder the variables
ctry_name      = ctry_name(idx);
countByCatCtry = countByCatCtry(idx, :);

% Keep only those countries with at least 20 observations
idx            = totalCtry >= 20;
totalCtry      = totalCtry(idx);

ctry_name      = ctry_name(idx);
countByCatCtry = countByCatCtry(idx,:);

%% Plot number of storms by category and country
figure
subplot(211)

% Make the bar plot of counts
bar(countByCatCtry,'stacked')
ylabel('Number of storms')
legend(cat_name,'Location', 'eastoutside')
title('Number of storms by category for countries with at least 20 storms')

% Store the axes object
ax_bar(1) = gca;

% Plot distribution of storms by category (and country)
% Normalize the number of hurricanes by country
catdistrib = 100*bsxfun(@rdivide, countByCatCtry, totalCtry);

% Plot
subplot(212)
bar(catdistrib, 'stacked')
ylabel('Percentage of storms')
legend(cat_name, 'Location', 'eastoutside')
title('Distribution of storms by category for countries with at least 20 storms')

ax_bar(2) = gca;
ylim(ax_bar(2), [0 100])

% Set same property values on both axes
for k = 1:2
    ax_bar(k).XTickLabel          = ctry_name;
    ax_bar(k).XTickLabelRotation  = 60;
    ax_bar(k).XAxis.TickDirection = 'out';
end

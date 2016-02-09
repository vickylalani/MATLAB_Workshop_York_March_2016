%% IMPORTSPOT Import spot curve data.
% Data source: Bank of England Statistics, 
% http://www.bankofengland.co.uk/statistics/Pages/yieldcurve/archive.aspx

%% Import raw data from file.
[~, ~, raw] = xlsread('uknom16_mdaily.xls', '4. spot curve');

%% Extract variables.
dates = datetime(raw(6:26, 1), 'InputFormat', 'dd/MM/yyyy');
maturities = cell2mat(raw(4, 2:end));
spot = cell2mat(raw(6:26, 2:end));

%% Remove completely missing dates/maturities.
L = isnan(spot);
missingDates = all(L, 2);
missingMaturities = all(L, 1);
spot(missingDates, :) = [];
spot(:, missingMaturities) = [];
maturities(missingMaturities) = [];
dates(missingDates) = [];

%% Save variables.
save UKSpotData dates spot maturities
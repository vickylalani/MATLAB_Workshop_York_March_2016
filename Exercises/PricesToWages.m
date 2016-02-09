%% Load the data.
load('House.mat')

%% Extract the region names.
regions = pricesToWages.Properties.RowNames;

%% Identify Manchester in the data.
L = strcmp(regions, 'York');
YorkData = pricesToWages{L, :};
Yrs = 1997:2012;
figure
plot(Yrs, YorkData, 'LineWidth', 2, 'Marker', '*')
title(sprintf('Data for %s', regions{L}), 'FontWeight', 'Bold')
xlabel('Year')
ylabel('House Price to Median Earnings Ratio')
grid

%% Test the function.
plotPrices_sol(find(L))
%% Exploratory Data Analysis.

%% Load the data.
load healthdata

%% Visualise missing values.
L = ismissing(data);
figure
imagesc(L)
colormap(gray(2))
xlabel('Variable')
ylabel('Observation')
title('Missing Data Pattern')
colorbar

%% Explore the height and weight data.
H = data.Height;
W = data.Weight;

%% Compute basic summary statistics.
heightStats = [mean(H), std(H), min(H), max(H), median(H)];
% What if we want to do the same thing for the weight?
% What if we want to compute the statistics by group? (Start with smaller
% examples and build them up.)
customStats = grpstats(data, 'Sex', {@mean, @std, @min, @max, @median}, ...
    'DataVars', {'Height', 'Weight'});

%% Visualisation of marginal distributions with histograms.
Hmen = H(data.Sex == 'M');
Hwomen = H(data.Sex == 'F');
binEdges = min(H):max(H);
figure
histogram(Hmen, binEdges)
hold on
histogram(Hwomen, binEdges)
xlabel('Height')
ylabel('Frequency')
title('Marginal Height Distributions')
grid
legend('Male', 'Female')
alpha(0.6)

%% Visualisation of joint densities.
figure
scatterhist(H, W, 'Group', data.Sex, 'Style', 'bar', 'Marker', 'x')
xlabel('Height (cm)')
ylabel('Weight (kg)')
title('Height/Weight Joint Distribution')
grid

%% Categorical plots.
figure
boxplot(H, data.Ethnicity)
title('Heights by Ethnicity')

%% Correlation.
bodyVars = data{:, 5:16};
labels = data.Properties.VariableNames(5:16);

figure
plotmatrix(bodyVars)

C = corr(bodyVars, 'rows', 'complete');
figure
imagesc(C, [-1, 1])
colormap('jet')
colorbar
set(gca, 'XTick', 1:numel(labels), ...
    'YTick', 1:numel(labels), ...
    'XTickLabel', labels, ...
    'YTickLabel', labels, ...
    'XTickLabelRotation', 45)
title('Correlation')
% Identify pairs of variables with high correlation.
highCorr = C - eye(size(C)) > 0.8;
hold on
spy(highCorr, 'k.', 20)



















%% Exploratory data analysis.

%% Load data.
load MedData

%% Investigate via visualisations.
% Investigate height/weight by Sex.
figure
gscatter(MedData.Height, MedData.Weight, MedData.Sex)

%% Look at height distribution for males/females.
% Custom histogram:
H = MedData.Height;
MedData.Sex = categorical(MedData.Sex); % Categorise
H_men = H( MedData.Sex == 'M' );
H_women = H( MedData.Sex == 'F' );

figure
bins = min(H):max(H);
histogram(H_men, bins)
hold on
h = histogram(H_women, bins);
h.FaceAlpha = 0.8; % Change female histogram transparency
%alpha(0.3) % 30% transparency (note alpha is global).

%% Quick exercise:
% * add vertical lines to each histogram to 
%   represent the mean heights
mH = mean(H_men);
mW = mean(H_women);
x = [mH, mH];
y = ylim;
plot(x, y, 'LineWidth', 2)
x = [mW, mW];
plot(x, y, 'LineWidth', 2)
% * add the mean values to the legend
legend('Males', 'Females', ...
    ['Male \mu = ', num2str(mH)], ...
    ['Female \mu = ', num2str(mW)])
% * use a ttest2 (2-sample t-test) to check whether
%   male/female heights are significantly different.
h = ttest2(H_men, H_women, 'Tail', 'right');
% Conclusion: males are taller than females at the 95%
% confidence level.

% Verify that male/female heights are Normal:
figure
qqplot(H_men) % Graphical check
% Test formally:
h1 = jbtest(H_men); % (Null hypothesis: Normal).
h2 = jbtest(H_women);

%% Quick ANOVA example:
% Which ethnic groups differ significantly in height?
MedData.Ethnicity = categorical(MedData.Ethnicity);
[p, ~, stats] = anova1(MedData.Height, MedData.Ethnicity);
groupComparisons = multcompare(stats);
% When do we use ANOVA? When we have > 2 groups.

% Note: for non-parametric testing, you could use
% signtest, signrank (2 populations)
% kruskalwallis (> 2 populations/groups)
% For multiway ANOVA/kruskalwallis, you could combine
% grouping variables or use repeated measures (fitrm).

%% Descriptive statistics.
% See the VARFUN examples here.
bodyMeas = table2array(MedData(:, 5:16)); % Matrix
C = corr(bodyMeas, 'rows', 'complete');
% (Only uses the complete rows to compute correlation.)
figure
imagesc(C) % (Scaled image/heatmap).
colorbar
varNames = MedData.Properties.VariableNames(5:16);
ax = gca; % Get current axes
ax.XTick = 1:numel(varNames);
ax.XTickLabel = varNames;
ax.YTick = ax.XTick;
ax.YTickLabel = ax.XTickLabel;
ax.XTickLabelRotation = 45;
% Superimpose the correlation coefficients.
corrText = num2str(C(:), '%.2f');
[X, Y] = meshgrid(1:numel(varNames));
% text(X(:)-0.4, Y(:), corrText)
text(X(:), Y(:), corrText, ...
    'horizontalAlignment', 'center')

%% Principal component analysis.
% * Dimension reduction technique
% (e.g. 20 body measurements --> 3/4 key measurements).
% * Explain variance in your data
% (which variables account for the most variance?)
% * Feature selection for a model (which inputs could
% we use for a model?)

%% Run a pca on the body measurements.
% Remove any missing data.
L = isnan(bodyMeas);
badRows = any(L, 2); % Which rows have missing data?
bodyMeas = bodyMeas(~badRows, :);
% Remove dependencies on units.
X = zscore(bodyMeas);
% Use PCA:
[coeff, score, latent, tsquared, explained] = pca(X);

%% What's going on?
% coeff: "rotation" matrix - how we get from the old
% system to the new system. 12x12 orthogonal matrix
% (rotations & reflections). 12 - number of variables.
figure
imagesc(coeff)
colorbar
ax = gca;
ax.YTick = 1:numel(varNames);
ax.YTickLabel = varNames;
xlabel('Principal component')
% We could interpret this as:
% PC 1 is weight-related ("bulk")
% PC 2 is height-related ("length")
% PC 3 is blood-pressure-related

%% Scores (2nd output).
% Variables in the new (rotated) system. In other words,
% score = X * coeff
figure
biplot(coeff(:, 1:3), 'Score', score(:, 1:3), ...
    'VarLabels', varNames)

%% Post-PCA rotation.
A = rotatefactors(coeff);
figure
biplot(A(:, 1:3), 'VarLabels', varNames)

%% How many components should we keep?
% Use the third output, "latent". This contains
% the eigenvalues of the transformation.
figure
subplot(2, 1, 1)
plot(latent, 'bo-')
subplot(2, 1, 2)
pareto(latent)
% 5th output: "explained":
disp(cumsum(explained))

%% Can we identify extreme/unusual values?
% Quantified in terms of deviation from the central/
% common values. Bigger t^2 => more deviation from
% the centre.

% Identify the 50 most extreme people:
[~, sortPositions] = sort(tsquared, 'descend');
% Plot them:
figure
scatter3(score(:, 1), score(:, 2), score(:, 3), 'b.')
hold on
top50 = sortPositions(1:50);
scatter3(score(top50, 1), ...
    score(top50, 2), score(top50, 3), 'r*')
legend('All people', 'Extreme 50')
% Note: extreme individuals have a high distance to the
% origin.















































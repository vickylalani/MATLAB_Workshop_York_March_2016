%% Advanced MATLAB graphics and visualisation.

%% Load data.
load UKSpotData

%% Create main figure.
f = figure('Name', 'UK Spot Data', ...
           'NumberTitle', 'off', ...           
           'Units', 'Normalized', ...
           'Position', 0.25*[1, 1, 2, 2]);
       
%% Create axes for visualisation.
ax(1) = subplot(1, 2, 1, 'Parent', f);
ax(2) = subplot(1, 2, 2, 'Parent', f);

%% Plot initial data.
% Spot curve on an individual date.
spotCurve = spot(1, :);
pSpot = plot(maturities, spotCurve, 'LineWidth', 2, 'Parent', ax(1));
% Highlight maximum point.
[maxSpot, maxIdx] = max(spotCurve);
hold(ax(1), 'on')
matMax = maturities(maxIdx);
pMax = plot(matMax, maxSpot, 'r*', 'Parent', ax(1));
% Add horizontal/vertical lines for clarity.
xl = xlim(ax(1));
yl = ylim(ax(1));
hMax = plot([matMax, matMax], [yl(1), maxSpot], 'k:', 'Parent', ax(1));
vMax = plot([xl(1), matMax], [maxSpot, maxSpot], 'k:', 'Parent', ax(1));
hold(ax(1), 'off')
% Annotations.
xlabel(ax(1), 'Maturity (years)')
ylabel(ax(1), 'Spot rate (%)')
t = title(ax(1), ['UK Spot Rates on ', char(dates(1))]);
l = legend(ax(1), 'Spot curve', ['Maximum rate = ', num2str(maxSpot), ...
    ' at maturity ', num2str(matMax)], ...
    'Location', 'southeast');
grid(ax(1), 'on')

%% Plot initial surface.
numDates = datenum(dates);
spotSurf = surf(ax(2), maturities, numDates, spot, ...
    'FaceColor', 'interp', 'EdgeAlpha', 0);
datetick(ax(2), 'y', 'dd/mm/yyyy')
xlabel(ax(2), 'Maturity (years)')
ylabel(ax(2), 'Date')
zlabel(ax(2), 'Spot rate (%)')
title(ax(2), 'Spot Rate Surface')

%% Overlay the selected yield curve.
yCurve = numDates(1) * ones(size(maturities));
hold(ax(2), 'on')
pSpot3D = plot3(maturities, yCurve, spotCurve, 'k', 'LineWidth', 2);







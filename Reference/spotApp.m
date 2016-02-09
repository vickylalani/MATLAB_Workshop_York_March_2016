function spotApp()

%% Advanced MATLAB graphics and visualisation.

%% Load data.
data = load('UKSpotData');
spot = data.spot;
dates = data.dates;
maturities = data.maturities;
numDates = datenum(dates);

%% Create main figure.
f = figure('Name', 'UK Spot Data', ...
           'NumberTitle', 'off', ...           
           'Units', 'Normalized', ...
           'Position', 0.25*[1, 1, 2, 2]);
       
%% Create axes for visualisation.
ax(1) = subplot(1, 2, 1, 'Parent', f);
ax(2) = subplot(1, 2, 2, 'Parent', f);

%% Create user-interface control.
% First, adjust the axes to provide more space.
axPos = ax(1).Position;
ax(1).Position = [axPos(1), 0.30, axPos(3), axPos(4)-0.20];
% Create the date adjustment slider.
sliderStep = 1/(numel(numDates)-1);
dateSlider = uicontrol('Parent', f, ...
    'Units', 'Normalized', ...
    'Position', [axPos(1), 0.10, axPos(3), 0.05], ...
    'Style', 'slider', ...
    'Min', 0, 'Max', 1, ...
    'SliderStep', [sliderStep, sliderStep], ...
    'Value', 0, ...
    'Callback', @onDateChanged);
% Create a descriptive static text box.
uicontrol('Parent', f, ...
    'Units', 'Normalized', ...
    'Position', [axPos(1)+0.25*axPos(3), 0.05, 0.5*axPos(3), 0.05], ...
    'Style', 'text', ...
    'String', 'Date', ...
    'FontSize', 14);

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
vMax = plot([matMax, matMax], [yl(1), maxSpot], 'k:', 'Parent', ax(1));
hMax = plot([xl(1), matMax], [maxSpot, maxSpot], 'k:', 'Parent', ax(1));
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

%% Callback function.
    function onDateChanged(~, ~)
        % Read current slider value (round to nearest day).
        sliderVal = round((numel(numDates)-1)*dateSlider.Value)+1;
        
        % What do we need to update?
        % Plot title.        
        t.String = ['UK Spot Rates on ', char(dates(sliderVal))];
        % Spot curve data.
        spotCurve = spot(sliderVal, :);
        pSpot.YData = spotCurve;
        % Maximum point.
        [maxSpot, maxIdx] = max(spotCurve);
        matMax = maturities(maxIdx);
        pMax.XData = matMax;
        pMax.YData = maxSpot;
        % Dotted lines.
        vMax.XData = [matMax, matMax];
        vMax.YData = [yl(1), maxSpot];
        hMax.XData = [xl(1), matMax];
        hMax.YData = [maxSpot, maxSpot];
        % Legend text.
        l.String{2} = ['Maximum rate = ', num2str(maxSpot), ' at maturity ', num2str(matMax)];
        % Surface line.
        yCurve = numDates(sliderVal) * ones(size(maturities));        
        pSpot3D.YData = yCurve;
        pSpot3D.ZData = spotCurve;
        
    end % onDateChanged

end % function
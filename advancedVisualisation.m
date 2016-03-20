%% Advanced MATLAB visualisation techniques.

%% Example: create a custom animation.
f = figure;
f.Name = 'Custom Animation @ York';
% f is usually called a "reference" or "handle" to the
% figure.
f.MenuBar = 'none';
f.NumberTitle = 'off';
f.Color = [1, 66, 37]/255; 
% Note: colours can be specified in two ways - 
% you can use strings, e.g. 'g', 'b' etc, or
% as RGB triples between 0 and 1.

%% Question: how can we change size/position?
f.Units = 'Normalized'; 
% (Allows us to specify relative sizes.)
% Dead centre, 50% height, 50% width relative to
% the screen.
f.Position = [0.25, 0.25, 0.50, 0.50];
% [x, y, dx, dy] 

%% Axes (next layer).
ax = axes('Parent', f);

%% Plot (next layer).
% Create a Brownian motion.
rng default % Get reproducible results.
t = linspace(0, 10, 500);
y = cumsum(randn(size(t)));
p = plot(t, y, 'Parent', ax);
p.LineWidth = 1.5;
p.Color = 'm';

%% Create a point.
hold(ax, 'on') % Specify which axes to hold.
p2 = plot(t(1), y(1), 'Parent', ax, ...
                      'Marker', '*', ...
                      'Color', 'y');
hold(ax, 'off')    

%% Move the point through the walk.
for k = 1:numel(t)
    p2.XData = t(k);
    p2.YData = y(k);
    drawnow % Force MATLAB to process each step
    pause(0.05) % Adjust the rate (seconds)
end







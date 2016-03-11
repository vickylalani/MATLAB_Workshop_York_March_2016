clear; close all; clc

%% Find root around initial guess x0 = 3
fun = @sin;
x0  = 3; 
z   = fzero(fun,x0);

%% Plot result
ezplot(fun, [-pi 3*pi])
ax = gca;
ax.Parent.Position = [100 100 160*4 90*4];
ax.XAxisLocation   = 'origin';
ax.YAxisLocation   = 'origin';
ax.XTick           = -2*pi:pi:2*pi;
ax.XTickLabel      = {'-2\pi', '-\pi', '0', '\pi', '2\pi'};
hold on

plot(x0, fun(3), 'rs', 'MarkerSize', 10, 'MarkerFaceColor', 'r')
label = sprintf('(%.1f, %.1f)', x0, fun(3));
text(x0+.25, fun(3), label)

plot(z, 0, 'bd',  'MarkerFaceColor', 'b')
hold off

title('sin(x)')

movegui('center')
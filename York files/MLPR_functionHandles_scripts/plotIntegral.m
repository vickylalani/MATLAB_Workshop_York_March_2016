clear; clc; close all

%% Implement the anonymous functions
fun = @(x) cos(x) + sqrt(x/2);
g = @(a, b) integral(fun, a, b);

%% Compute the definite integral for x = [5, 10]
a = 5; b = 10;
g(a, b)


%% Plot the function and fill the area under the curve
x = 0:1e-2:20;
y = fun(x);

plot(x, y, 'r', 'LineWidth', 2)
hold on
idx = x>=a & x<=b;
area(x(idx), y(idx), 'facealpha', .5)

ax = gca;
ax.Parent.Position = [100 100 160*4 90*4];
hold off
movegui('center')
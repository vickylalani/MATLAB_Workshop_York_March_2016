clear; clc; close all

%% Define anonymous function and embed parameters
a = 1.3; b = 0.2; c = 30;
myParabola = @(x) a*x.^2 + b*x + c;

%% You can clear variables a, b and c, this will still work
clear a b c
myParabola(2)

%% Return information about the function
info = functions(myParabola)

%% Get the variables stored in the definition of the anonymous function
info.workspace{:}

%% Plot the parabola
x = linspace(-10, 10, 100);
plot(x, myParabola(x))
ax = gca;
ax.Parent.Position = [100 100 160*4 90*4];
movegui('center')
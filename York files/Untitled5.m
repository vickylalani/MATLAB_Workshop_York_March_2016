%% Function handles.
%
% * Create a function handle to represent 
% the function g(x) = x.*sin(x).
%%
g = @(x) x.*sin(x);

% * Plot this function over the domain [-4*pi, 4*pi] 
% using ezplot.
%%
figure(1)
ezplot(g, [-4*pi, 4*pi])

% * Find a root of this function near x0 = pi/2 using fzero. 
%%
zeroLocation = fzero(g, pi/2);

% Add this point
%   to the plot.

%%
hold on
plot(zeroLocation, 0, 'r*')
hold off

ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';

% * What is the area under g between 0 and pi? 
% Hint: use integral.
%%
areaG = integral(g, 0, pi);

% * Create a function to represent the function 
% f(x, y) = x.*y.*exp(-x.^2-y.^2).
%%
f = @(x, y) x.*y.*exp(-x.^2-y.^2);

% * Visualise this function as a surface using ezsurf 
% and the default
%   domain.
figure(2)
ezsurf(f)
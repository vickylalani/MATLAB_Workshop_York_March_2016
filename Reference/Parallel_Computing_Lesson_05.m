%% GPU Computing.

%% GPU devices.
g = gpuDevice;
display(g)

%% Suppose we wish to solve the heat equation on a domain.
% In many cases it is easy to convert existing code to run on a GPU without
% significant changes.
% For example, we can solve the heat equation by initialising
% the temperature distribution directly on the GPU using the ones function.
Ugpu = heateqGPU(200);
figure
imagesc(Ugpu, [20, 80])
axis square
title('Final Temperature Distribution')

%% Creating data on the GPU.
% Task: visualise the Mandelbrot set using GPU computations.
% (Implement this first on the CPU without the use of gpuArray.)
x = gpuArray.linspace(-1.5, 1.5, 2000);
[X, Y] = meshgrid(x);
Z = complex(X, Y);
c = -0.8 + 0.156i;
for k = 1:20
    Z = Z.^2 + c;
end
Z = exp(-abs(Z));
figure
imagesc(Z)

%% Retrieving data on the client.
Zclient = gather(Z);

%% Performing elementwise array operations on the GPU.
Z = complex(X, Y);
Zfinal = arrayfun(@juliaCalc, Z, c);
figure
imagesc(Zfinal)

%% Timing GPU execution.
f = @() juliaCalc(Z, c);
t = gputimeit(f);
display(t)

%% Clearing the GPU memory.
reset(g);














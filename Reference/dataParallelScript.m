%% Data-parallel programming.
spmd % Single-program, multiple data
    disp('Hello world!')
end
% In the data-parallel world, workers need to have
% communication (e.g. to exchange data) and are 
% referred to as "labs". In the task-parallel world,
% we use "workers".

%% Split data between labs.
spmd
   A = zeros(2, 4, 'codistributed')
   B = A.'
end

%% Example: run the heat equation in parallel.
% First, let's run it sequentially.
U = heateq(200);
% Note: parallelising this is not appropriate for
% parfor (task-parallel) because heat is exchanged
% across any boundaries that we impose. So, we need
% to use SPMD (data-parallel construct) instead.

%% Test the parallel version.
spmd
    U_spmd = my_heateqSPMD(200);
end
figure
imagesc(U_spmd, [10, 80]) % Temp. scale between 10C and 80C
title('Final heat distribution')
% Note: if your data comes from a file, an image
% or a database, this construct still works.
% See, for example, parallelImageRead.m.

%% Getting this to work on a GPU.
% See heateqGPU.m.
U_gpu = heateqGPU(200);
figure
imagesc(U_gpu, [10, 80]) % Temp. scale between 10C and 80C
title('Final heat distribution')

% Useful commands:
methods('codistributed') % Supported functions for SPMD
methods('gpuArray') % Supported functions for GPU devices
















%% Pool administration shortcuts.

%% Start parallel pool.
% Check if a pool exists using GCP (get 
% current pool).
if isempty(gcp('nocreate'))
    parpool
else
    disp('A pool already exists.')
end

%% Shut down parallel pool.
if ~isempty(gcp('nocreate'))
    delete(gcp)
else
    disp('No pool exists.')
end
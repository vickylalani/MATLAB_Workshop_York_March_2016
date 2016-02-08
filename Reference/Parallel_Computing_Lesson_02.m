%% Offloading Execution and Working with Clusters.

%% Step 1: Create a parallel cluster object.
c = parcluster('local');

%% Step 2: Create a job on the cluster.
job = createJob(c);

%% Step 3: Add tasks to the job.
load US_Births_1978
groupSizes = 5:5:60;
numTrials = 1e4;
birthProb = T.BirthProb;
for k = 1:numel(groupSizes)
    createTask(job, @runBirthdaySim, 1, {groupSizes(k), numTrials, birthProb});
end

%% Step 4: Submit and wait for the job.
submit(job);
wait(job, 'finished')

%% Step 5: Retrieve and process the results.
matchProb = fetchOutputs(job);
matchProb = cell2mat(matchProb);

%% Step 6: Tidy up.
delete(job);

%% Example using the jobs/tasks framework.
% Runs through the process of creating a batch job using a function

%% Create a cluster object
cluster = parcluster('local');

%% Add a job to the cluster
job = createJob(cluster);

%% Define the data to be used
colSizes = 5:5:50;
numRows = 100;
numTasks = 4;

%% Add the tasks to the job
for k = 1:numTasks
    createTask(job, @rand, 1, {numRows, colSizes(k)});
end
% Note: change "rand" to "ranD" (for example) to see how
% to inspect errors arising from tasks.

%% Submit the job
submit(job);

%% Get results
wait(job, 'finished');
randMatrices = fetchOutputs(job);

%% Clean up.
delete(job);
clear job

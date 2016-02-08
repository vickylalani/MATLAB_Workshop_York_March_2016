function results = pargenematch()

% Define sequence to find and number of tasks to create.
searchSeq = repmat('gattaca', 1, 10);
numTasks = 2;
numBases = 7048095;

% TODO: Create a cluster object.
c = parcluster('local');
c.NumWorkers = numTasks; % Try to achieve "load balancing".
% Each worker is occupied with roughly the same amount
% of work.
% TODO: Create a job on the cluster.
job = createJob(c);
filename = 'gene.txt';
job.AttachedFiles = {filename};
% Use job.AdditionalPaths = ... to make another folder
% visible.

% TODO: Call the splitDataset function to obtain the start and end values.
[startValues, endValues] = splitDataset(numBases, numTasks);

% Add border handling.
offsetLeft = floor(length(searchSeq)/2);
if mod(length(searchSeq),2) == 0
    offsetRight = offsetLeft - 1;
else
    offsetRight = offsetLeft;
end
    
startValues(2:end) = startValues(2:end) - offsetLeft;
endValues(1:end-1) = endValues(1:end-1) + offsetRight;

% TODO: Create the tasks, using the genematch function with different 
% starting and end indices. You need to make use of the startValues and
% endValues variables created above.
for tasknum = 1:numTasks
    createTask(job, @genematch, 2, ...
        {searchSeq, filename, ...
        startValues(tasknum), endValues(tasknum)});
end

% TODO: Submit the job and wait for the results.
submit(job);
% pause(120) % For Iceberg.
wait(job, 'finished');

% TODO: Retrieve the results and tidy up.
results = fetchOutputs(job);
delete(job);

% Process the results.
results = cell2mat(results);

function [startValues, endValues] = splitDataset(numTotalElements, numTasks)

% Divide up the total elements among the tasks
numPerTask = repmat(floor(numTotalElements/numTasks), 1, numTasks);
leftover = rem(numTotalElements, numTasks);
numPerTask(1:leftover) = numPerTask(1:leftover) + 1;

% Determine the start end end values for the vector
endValues = cumsum(numPerTask);
startValues = [1 endValues(1:end-1) + 1];

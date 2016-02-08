function matchProb = runBirthdaySimPar(groupSize, numTrials, birthDist)
% Monte Carlo simulation for the birthday problem / birthday paradox. The
% output is the match probability. The inputs are the number of individuals
% in the group (groupSize), the number of Monte Carlo trials (numTrials)
% and a vector (birthDist) providing a sample probability distribution for
% the birthdays over the course of a year.

% Preallocate space for the results.
blockWidth = 100;
matches = false(numTrials, blockWidth);

% Run the batch of Monte Carlo trials.
parfor k = 1:numTrials
    matches(k, :) = runTrial(groupSize, blockWidth, birthDist);
end

% Evaluate the match probability.
matchProb = sum(matches(:))/numel(matches);

end % runBirthdaySim

function match = runTrial(groupSize, blockWidth, birthDist)
% Local function performing a single Monte Carlo trial.

% Generate random birthdays, sampling with replacement.
bdays = randsample(365, groupSize*blockWidth, true, birthDist);
bdays = reshape(bdays, [groupSize, blockWidth]);

% Is there a match?
match = any(diff(sort(bdays)) == 0);

end % runTrial
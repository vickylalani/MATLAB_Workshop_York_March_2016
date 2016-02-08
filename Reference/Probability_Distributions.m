%% Probability distributions.

%% Load the data.
load healthdata

%% Extract male/female heights, and all weights.
W = data.Weight;
Hmen = data.Height(data.Sex == 'M');
Hwomen = data.Height(data.Sex == 'F');

%% Investigate the distributions graphically.
figure
subplot(2, 1, 1)
probplot('normal', Hmen)
title('Male heights')
subplot(2, 1, 2)
probplot('normal', Hwomen)
title('Female heights')

figure
subplot(2, 1, 1)
probplot('normal', W)
title('Normal Weight Probability Plot')
subplot(2, 1, 2)
probplot('lognormal', W)
title('Lognormal Weight Probability Plot')

%% Investigate formally.
h1 = jbtest(Hmen);
h2 = lillietest(log(W));
% See also ADTEST, KSTEST and CHI2GOF.

%% Fit distributions using maximum-likelihood estimation.
hMenFit = fitdist(Hmen, 'normal');
hWomenFit = fitdist(Hwomen, 'normal');
wFit = fitdist(W, 'lognormal');

%% Visualise the fits.
sampleVals = linspace(min(W), max(W), 500);
pdfVals = pdf(wFit, sampleVals);
cdfVals = cdf(wFit, sampleVals);
figure
plotyy(sampleVals, pdfVals, sampleVals, cdfVals)
legend('Weight PDF', 'Weight CDF')
title('Weight Distribution Lognormal Fit')

%% Evaluate probabilities.
% Prob. of an individual weighing at most 80kg.
p80 = cdf(wFit, 80); 
% Prob. of an individual weighing at least 100kg.
pAbove100 = 1 - cdf(wFit, 100); 

%% Use Monte Carlo simulation to evaluate more difficult probabilities.
% Task: compute prob. of a woman being taller than a man.
nTrials = 1e6;
rMen = random(hMenFit, [nTrials, 1]);
rWomen = random(hWomenFit, [nTrials, 1]);
p = sum(rWomen > rMen)/nTrials;

%% Distribution fitting (1 variable).
load MedData

%% Separate male/female heights.
H = MedData.Height;
MedData.Sex = categorical(MedData.Sex); % Categorise
H_men = H( MedData.Sex == 'M' );
H_women = H( MedData.Sex == 'F' );

%% Fit distributions.
maleFit = fitdist(H_men, 'Normal');
femaleFit = fitdist(H_women, 'Normal');

%% Visualise the fits.
sampleH = linspace(min(H), max(H), 500);
malePDF = pdf(maleFit, sampleH);
femalePDF = pdf(femaleFit, sampleH);
figure
plot(sampleH, malePDF, sampleH, femalePDF)

%% Prob. that a male is <= 180cm?
p180 = cdf(maleFit, 180);
% Prob. that a female is between 150cm and 160cm?
pFemale150_160 = cdf(femaleFit, 160) - cdf(femaleFit, 150);

%% Prob. that a woman is taller than a man?
nTrials = 1e5;
randMen = random(maleFit, nTrials, 1);
randWomen = random(femaleFit, nTrials, 1);
p = sum(randWomen > randMen) / nTrials;

%% Question: how would we make a distribution
% from scratch without fitting it to some data?
myFavDist = makedist('Beta', 'a', 0.5, 'b', 0.7);
% a - alpha shape parameter
% b - beta shape parameter

%% Curve-fitting/regression.
% Potentially many inputs, one output.
X = MedData.Age; % Input (age)
y = MedData.BPSyst1 - MedData.BPDias1; 
% Output (pulse pressure).
figure
scatter(X, y, 'k.')
% Fit the model (fitlm):
mdl = fitlm(X, y, 'quadratic');
% Visualise the fit.
sampleAge = linspace(min(X), max(X), 500).';
fittedVals = predict(mdl, sampleAge);
hold on
plot(sampleAge, fittedVals, 'r', 'LineWidth', 2)

%% What's the equation of this curve?
coeffs = mdl.Coefficients.Estimate;
eqn = poly2str(flip(coeffs), 'Age');
title(['pulsePressure ~', eqn])





















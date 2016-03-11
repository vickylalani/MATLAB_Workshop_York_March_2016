%% Clear everything
clear; clc; close all

%% Load data
load patients

%% Create a table
patients = table(Age, Gender, Height, Weight, Smoker, ...
'RowNames', LastName);
patients(1:5, :)

%% Indexing into a table
patients('Williams', 'Weight')
patients({'Williams', 'Brown'}, :)
patients(1:5, {'Height', 'Weight'})

%% Get table size
size(patients)
height(patients)
width(patients)

%% Add new variables to an existing table
% Compute BMI = weight(lb) / height(in)^2 x 703
BMI = patients.Weight ./ patients.Height.^2 * 703;
patients.BMI = BMI;
patients(1:5, :)

%% Permute the order of variables
col = {'Age', 'Gender', 'Height', 'Weight', 'BMI', 'Smoker'};
patients = patients(:, col);
patients(1:5, :)

%% Rename variables
patients.Properties.VariableNames
patients.Properties.VariableNames{'Gender'} = 'Sex';

%% Logical indexing
% Get gender, height and weight of all non smoker patients over the age of 30 
rows    = patients.Age >= 30 & ~patients.Smoker;
vars    = {'Age', 'Sex', 'Height', 'Weight', 'Smoker'};
over30s = patients(rows, vars);
over30s(1:5, :)

%% Sort rows
%% Sort patients by age
patients = sortrows(patients, 'Age');
patients(1:10, :)

%% Sort patients by age (descending)
patients = sortrows(patients, 'Age', 'descend');
patients(1:10, :)

%% Sort patients by age (ascending) then weight (descending)
sortrows(patients, {'Age', 'Weight'}, {'ascend', 'descend'})
patients(1:5, :)

%% Use categorical variables to save memory and do comparisons more efficiently
whos patients
patients.Sex = categorical(patients.Sex);
whos patients

%% Get details of male patients under the age of 30
cond = patients.Sex == 'Male' & patients.Age < 30;
patients(cond, :)

%% Split data into groups and apply functions on those groups
% Split patients by age and gender, then calculate the mean height, weight
% and BMI
sortrows(patients, {'Age', 'Height', 'Weight'})
T = patients(:, {'Age', 'Sex'})

[groups, byAgeAndSex] = findgroups(T);
byAgeAndSex.AvgHeight = splitapply(@mean, patients.Height, groups);
byAgeAndSex.AvgWeight = splitapply(@mean, patients.Weight, groups);
byAgeAndSex.AvgBMI    = splitapply(@mean, patients.BMI, groups)

%% Plot average BMI by age for men and women
figure(1)
men = byAgeAndSex.Sex == 'Male';

x = byAgeAndSex.Age(men);
y = byAgeAndSex.AvgBMI(men);
bar(x, y)

hold on

x = byAgeAndSex.Age(~men);
y = byAgeAndSex.AvgBMI(~men);
bar(x, y, 'r')

hold off

xlabel('Age')
ylabel('Average BMI')
legend('Men', 'Women')


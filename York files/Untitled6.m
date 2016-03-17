%% clear everything
clear; clc; close all;

%% load some data
load patients

patients = table(Age, Gender, Height, Weight, ...
    Smoker, 'RowNames', LastName);

%% sort rows.
A = sortrows(patients, 'Height', 'descend')
A = sortrows(patients, {'Height', 'Weight'}, ...
    {'descend', 'ascend'})

%% Change variable name.
A.Properties.VariableNames{'Gender'} = 'Sex'

%% BMI
% BMI = weight(lb) / height(in) ^2 *703;
BMI = A.Mass ./ A.Height.^2 *703;
A.BMI = BMI

%% Use categorical array to save memory and
% perform more efficient comparisons
A.Sex = categorical(A.Sex);

%% Get all the male patients under the age of 30
cond = A.Sex == 'Male' & A.Age <= 30;
B = A(cond, :)

%% Find groups within table
T = A(:, {'Age', 'Sex'});
[groups, byAge_Gender] = findgroups(T)
byAge_Gender.AvgMass = splitapply(@mean, A.Mass, groups)
byAge_Gender.MinHeight = splitapply(@min, A.Height, groups)
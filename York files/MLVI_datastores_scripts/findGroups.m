clear; close all; clc

%% Create table
A = [0 1 1 0 0 0 1 1]';
B = categorical({'Yes', 'Yes', 'No', 'Yes', 'Yes', 'No', 'No', 'Yes'}', ...
{'Yes', 'No'});
C = categorical({'X', 'Z', 'X', 'Z', 'X', 'Y', 'Y', 'Z'}');
D = [3.14 42 6.66 9.99 1.23 3.21 1.41 0.99]';

mytable = table(A, B, C, D)

%% Group by variables B and C
[groups, byB_C] = findgroups(mytable(:,{'B', 'C'}))

%% Apply min of D according to groups
output = splitapply(@min, mytable(:,'D'), groups)

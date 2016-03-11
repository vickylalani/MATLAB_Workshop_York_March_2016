%% Join tables
clear; clc; close all

A = [1 2 3 4]';
B  = {'Yes', 'No', 'No', 'Yes'}';
C  = {'X', 'Z', 'Y', 'Y'}';
D  = [3.1 42, 6.66 9.99]';

tableA = table(A, B, C, D)

A = [6 5 4 3]';
E  = [1 0 0 0]';
F  = {'x', 'xxx', 'xx', 'xx'}';

tableB = table(A, E, F)
innerjoin(tableA, tableB)
outerjoin(tableA, tableB, 'mergekeys', true)
outerjoin(tableA, tableB, 'mergekeys', true, 'type', 'left')
outerjoin(tableA, tableB, 'mergekeys', true, 'type', 'right')
% Changing interface with anonymous functions
clear; clc; close all;

%% Calling 'myfun', from a wrapper function which also loads some data
tic
f = @wrapper;
fzero(f, 0.5)
toc

%% Calling 'myfun', but loading the data outside and embed the parameter
tic
a = readparameters();
f = @(b) myfun(a, b, pi/4);
fzero(f, 0.5)
toc
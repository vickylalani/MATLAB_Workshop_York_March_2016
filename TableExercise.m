%% Tables.
% Exercise - Gas Prices 
% Solution - Ex01_GasPrices.m 
%
% * Create a new script, and use the readtable function to import the data 
%   from gasprices.csv into a table in your Workspace. Hint: You will need 
%   to specify the Delimiter and Headerlines options – see the 
%   documentation for the readtable function.

%% Import data
clear; close all; clc;

gasPrices = readtable('gasprices.csv', ...
    'delimiter', ',', ...
    'headerlines', 4);

%
% * Extract the data for Japan from the table into a separate numeric 
%   variable, using the dot syntax (.). Compute the mean and standard 
%   deviation of the Japanese prices.
%
%% Extract Japanese prices
Japan      = gasPrices.Japan;
Japan_mean = mean(Japan);
Japan_std  = std(Japan);

% * Extract the data for Europe into a numeric array, and compute the mean
%   European price for each year. Hint: check the documentation for the 
%   mean function.

%% Extract prices for Europe (France, Germany, Italy, UK)
Europe      = [gasPrices.France, gasPrices.Germany, ...
               gasPrices.Italy, gasPrices.UK];
Europe_mean = mean(Europe, 2);

%
% * Compute the European return series from the prices using the following 
%   formula:
%
%       R(t) = log( P(t+1)/P(t) )
%
%   Here, P(t) represents a single price series. There are four price 
%   series in the European data.
%% Compute return
Europe_returns = log(Europe(2:end, :) ./ Europe(1:end-1, :));
% * Compute the correlation coefficients of the four European return 
%   series. Hint: See the documentation for the corrcoef function. Display 
%   the resulting correlation matrix using the imagesc function.

%% Create figure
C = corrcoef(Europe_returns);

figure(1)
imagesc(C, [-1 1]);

str = {'France', 'Germany', 'Italy', 'UK'};
set(gca, 'xtick', 1:4, 'xticklabel', str, ...
    'ytick', 1:4, 'yticklabel', str);
colorbar
grid on
shg
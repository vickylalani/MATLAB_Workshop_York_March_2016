%% INTRODUCTION: motorParamSweep
% Copyright 2016 The MathWorks, Inc.
%{
	This script is used to demonstrate the interface between MATLAB & Simulink
	It shows how:
				- model parameters may be set programatically
				- the use of the sim() command to run a simulation
				- how data is extracted from the simulation
%}


%% Initialise parameters for the motor
mdlName = 'dc_motorParamSweep';
K = 0.3;  
L = 0.05; 
b = 0.01; 
J = 0.005;

%% The aim is to analyse how the current of the motor changes as the value of the resistance changes.
% Let us look at resistance values from 2-10 Ohm. "linspace" returns a
% vector of evenly space points between 2 Ohm and 10 Ohm. 


% Declare N = length of values of R and load the system


%% Parallel Monte carlo simulations. Use "parfor" to start a parallel pool with 
% default cluster preferences. The parfor loop calls a functions that uses
% "sim" command to simulate the DC motor. The function takes the model name
% and the variable "R" as inputs. The output is stored in a output
% Dataset which is used to plot the results.

   
%% Plotting the simulation results. simOut is a dataset with output elements 
% that can be accessed using the method "get".
for j = 1:N
simLogs = simOut(j).get('logsout');
    I = simLogs.get('current');
    plot(I.Values.Time, I.Values.Data)
    hold on
end

hold off
xlabel('Time (s)')
ylabel('Load current (A)');

% Delete the parallel pool
delete(gcp('nocreate'));





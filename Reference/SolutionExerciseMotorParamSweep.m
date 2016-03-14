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
mdlName = 'Exercise_motorParamSweep';
K = 0.3;  
L = 0.05; 
J = 0.005;

%% The aim is to analyse how the current of the motor changes as the value of the resistance and the damping factor changes.
% Let us look at resistance values from 2-10 Ohm. "linspace" returns a
% vector of evenly space points between 2 Ohm and 10 Ohm.
R_values = linspace(2,5,2);
b_values = linspace(0.01,1,1);
N = length(R_values);
M = length(b_values);
load_system(mdlName);

%% Parallel Monte carlo simulations. Use "parfor" to start a parallel pool with 
% default cluster preferences. The parfor loop calls simDCMotor that uses
% "sim" command to simulate the DC motor. The funcion simDCMotor takes the 
% name of the model and the value of the parameter R as the input. 
% The result is stored in a output
% Dataset which is used to plot the results.
[Rgrid, bgrid] = meshgrid(R_values, b_values);
parfor k = 1:numel(Rgrid)
   R = Rgrid(k);
   b  = bgrid(k);
  simOut(k) = simDCMotorRB(mdlName,R,b);
  
end

    
%% Plotting the simulation results. simOut is a dataset with output elements 
% that can be accessed using the method "get".
 for j = 1:N
     
        simLogs = simOut(j).get('logsout');
        I = simLogs.get('current');
        plot(I.Values.Time, I.Values.Data)
        hold on
     
end
% 
hold off
xlabel('Time (s)')
ylabel('Load current (A)');
l = legend(num2str(combvec(R_values,b_values)'));
delete(gcp('nocreate'));





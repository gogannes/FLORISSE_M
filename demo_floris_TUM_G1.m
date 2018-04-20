clear all; clc; close all;

%% Run a single simulation without optimization (G1)
disp('Running a single simulation...');
FLORIS_sim = floris('generic_2turb_scaled','TUM_G1','uniform','greedy',...
                    'PorteAgel','PorteAgel','Katic',...
                    'PorteAgel','PorteAgel_default'); % Initialize FLORIS class with specific settings
FLORIS_sim.run();            % Run a single simulation with the settings 'FLORIS.inputData'
FLORIS_sim.outputData.power
FLORIS_sim.visualize(0,1,0,'WF'); 

%% now with wake errors
FLORIS_sim.inputData.wake_pos_error = [ 0.20 0];
FLORIS_sim.inputData.wake_def_error = [ +0   2];
FLORIS_sim.run();           
FLORIS_sim.outputData.power
FLORIS_sim.visualize(0,1,0,'WF'); 




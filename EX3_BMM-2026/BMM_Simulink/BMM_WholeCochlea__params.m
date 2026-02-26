
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% This scripts assigns a value of 1 to the Input gain element and runs
%%% the passive Whole Cochlea model.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

YourModel = 'BMM_WholeCochlea';

%% Assign model parameters

mdlWks = get_param(YourModel, 'ModelWorkspace');

%Input gain value
assignin(mdlWks, 'U_inputGain', 1)

%Values in the RLC branch #1
assignin(mdlWks, 'R_1', 150)
assignin(mdlWks, 'C_1', 100e-9)
assignin(mdlWks, 'L_1', 10e-3)
assignin(mdlWks, 'Ls_1', 33e-3)

%Values in the RLC branch #2
% assignin(mdlWks, 'R_2', ??)
% assignin(mdlWks, 'C_2', ??)
% assignin(mdlWks, 'L_2', 10e-3)
% assignin(mdlWks, 'Ls_2', 33e-3)

%Values in the RLC branch #3
% ...

%% Run the simulation

sim( YourModel )

%% Make your plots ...

% english_msg - english message definition file -
%
% ready_msg		displayed when ready for user response
% measure_msg		displayed when entering measurement phase
% correct_msg		displayed after correct response
% false_msg		displayed after false response
% maxvar_msg		displayed when maxvar is reached
% minvar_msg		displayed when minvar is reached
% start_msg		displayed when the experiment starts
% next_msg		displayed when the next parameter is presented
% finished_msg		displayed when the experiment is finished

msg.ready_msg = 'Which way did the sound move?';
msg.measure_msg = 'Beginning measurement';
msg.correct_msg = '--- CORRECT ---';
msg.false_msg = '--- WRONG ---';
msg.maxvar_msg = 'Maximum level reached';
msg.minvar_msg = 'Minimum level reached';


msg.start_msg    = {'You have started a new measurement.', ...
                    'Press any key to continue.'};
msg.next_msg     = {'End of Run.', ...
                    'Press "s" for a new run or "e" to end.'};
msg.finished_msg = {'Experiment Done.', ...
                    'Press "e" to end.'};
                    
msg.experiment_windetail = 'Experiment: %s';
msg.measurement_windetail = 'Measurement %d of %d';
msg.measurementsleft_windetail = '%d of %d measurements left';

msg.buttonString = {[char(171) char(171) char(171) '  (1)'];['(2)  ' char(187) char(187) char(187) ]};

% eof

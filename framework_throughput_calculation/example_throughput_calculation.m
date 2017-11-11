%%% ***********************************************************************************
%%% * Interference-based Throughput calculation framework                             *
%%% * Author: Francesc Wilhelmi (francesc.wilhelmi@upf.edu)                           *
%%% * Copyright (C) 2017-2022, and GNU GPLd, by Francesc Wilhelmi                     *
%%% * GitHub repository:                                                              *
%%% *   https://github.com/wn-upf/interference_based_throughput_calculation_framework *
%%% * More info on https://www.upf.edu/en/web/fwilhelmi                               *
%%% ***********************************************************************************

clc
clear all

disp('----------------------------------------------------------')
disp('EXAMPLE: building a 3D Network and computing the throughput')
disp('----------------------------------------------------------')

% Generate constants from 'constants.m'
constants

% Generate a WN in a grid way and with the safe configuration
wns = generate_random_network_3D(); % SAFE CONFIGURATION

% Draw the WN
draw_network_3D(wns);

% Find the index of the initial action taken by each WLAN
initialActionIxPerWlan = zeros(1, nWNs);
for i = 1 : nWNs
    [~,indexCca] = find(ccaActions == wns(i).CCA);
    [~,indexTpc] = find(txPowerActions == wns(i).TxPower);
    initialActionIxPerWlan(i) = indexes2val(wns(i).Channel, ...
        indexCca, indexTpc, size(channelActions,2), size(ccaActions,2));
end

%% Compute the maximum achievable throughput per WN
% Step 1: generate the power matrix, which includes the power received by
% each WN from the interferring nodes
powerMatrix = power_matrix(wns);     
% Step 2: compute the throughput
upperBoundThroughputPerWN = compute_max_bound_throughput(wns, ...
    powerMatrix, NOISE_DBM, max(txPowerActions));
disp([' * Maximum achievable throughput per WN: ' num2str(upperBoundThroughputPerWN)])
fprintf('\n')

%% Compute the throughput noticed after applying the action
disp('+++++++++++++++++++++++++++++++++++++++++++++++++')
disp('Computing the throughput for the given configuration...')
disp('+++++++++++++++++++++++++++++++++++++++++++++++++')
% Step 1: generate the power matrix, which includes the power received by
% each WN from the interferring nodes
powerMatrix = power_matrix(wns);
% Step 2: compute the throughput according to the interference
throughputExperienced = compute_throughput_from_sinr(wns, powerMatrix, NOISE_DBM); 
disp([' * Throughput experienced per WN: ' num2str(throughputExperienced)])
disp([' * Average throughput experienced: ' num2str(mean(throughputExperienced))])
% Step 3: compute the fairness according to the throughput
fairnessExperienced = jains_fairness(throughputExperienced);
disp([' * Jain''s fairness index: ' num2str(fairnessExperienced)])
fprintf('\n')

%% Compute the throughput for all the combinations
throughputPerConfiguration = compute_throughput_all_combinations(wns);
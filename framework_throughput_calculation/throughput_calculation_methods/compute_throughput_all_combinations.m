%%% ***********************************************************************************
%%% * Interference-based Throughput calculation framework                             *
%%% * Author: Francesc Wilhelmi (francesc.wilhelmi@upf.edu)                           *
%%% * Copyright (C) 2017-2022, and GNU GPLd, by Francesc Wilhelmi                     *
%%% * GitHub repository:                                                              *
%%% *   https://github.com/wn-upf/interference_based_throughput_calculation_framework *
%%% * More info on https://www.upf.edu/en/web/fwilhelmi                               *
%%% ***********************************************************************************

function throughputPerConfiguration = compute_throughput_all_combinations( wns )
% Computes the throughput experienced by each WN for all the possible
% combinations of Channels, CCA and TPC 
%
%   NOTE: the "allcomb" function does not hold big amounts of combinations 
%   (a reasonable limit is 4 WLANs with 2 channels and 4 levels of TPC)
%
% OUTPUT:
%   * throughputPerConfiguration - tpt achieved by each WN for each configuration (Mbps)
% INPUT:
%   * wns: contains information of each Wireless Network in the map. 
%   For instance, wns(1) corresponds to the first WN, so that it has 
%   unique parameters (position_ap, position_sta, txPower, etc.).

    load('constants.mat')

    disp('+++++++++++++++++++++++++++++++++++++++++++++++++')
    disp('Computing the throughput for all the combinations...')
    disp('+++++++++++++++++++++++++++++++++++++++++++++++++')

    % Each state represents an [i,j,k] combination for indexes on "channels", "CCA" and "TxPower"
    possible_actions = 1:(size(channelActions,2)*size(ccaActions,2)*size(txPowerActions,2));
    % Set of possible combinations of configuration  
    possible_comb = allcomb(possible_actions,possible_actions,possible_actions,possible_actions);
    
    wn_aux = wns;    % Generate a copy of the WN object to make modifications

    % Try all the combinations
    for i = 1 : size(possible_comb, 1)
        % Change WLANs configuration 
        for j = 1:nWNs 
            [ch, ~, tpc_ix] = val2indexes(possible_comb(i,j), nChannels, size(ccaActions,2), size(txPowerActions,2));
            wn_aux(j).Channel = ch;   
            wn_aux(j).TxPower = txPowerActions(tpc_ix);            
        end
        % Compute the Throughput and store it
        powerMatrix = power_matrix(wn_aux); 
        throughputPerConfiguration(i, :) = compute_throughput_from_sinr(wn_aux, powerMatrix, NOISE_DBM); 
    end
    
    % Find the best configuration for each WN and display it
    for i = 1 : size(throughputPerConfiguration, 1)
        agg_tpt(i) = sum(throughputPerConfiguration(i,:));
        fairness(i) = jains_fairness(throughputPerConfiguration(i,:));
        prop_fairness(i) = sum(log(throughputPerConfiguration(i,:)));
    end    
    
    %% Dsiplay configurations maximizing prop. fairness and agg. throughput
    disp('---------------')
    fprintf('Configuration that maximizes proportional fairness:\n\n')
    [val, ix] = max(prop_fairness);
    disp([' * Best proportional fairness: ' num2str(val)])
    disp([' * Aggregate throughput: ' num2str(agg_tpt(ix)) ' Mbps'])   
    disp([' * Mean individual throughput: ' num2str(mean(throughputPerConfiguration(ix, :))) ' Mbps']) 
    disp([' * std: ' num2str(std(throughputPerConfiguration(ix, :))) ' Mbps']) 
    disp([' * Fairness: ' num2str(fairness(ix))])
    disp([' * Best configurations: ' num2str(possible_comb(ix, :))])
    for i = 1:nWNs
        [a, ~, c] = val2indexes(possible_comb(ix, i), nChannels, size(ccaActions, 2), size(txPowerActions, 2));  
        disp(['   . WN' num2str(i) ':'])
        disp(['       - Channel:' num2str(a)])
        disp(['       - TPC:' num2str(txPowerActions(c))])
    end
    
    disp('---------------')
    fprintf('Configuration that maximizes aggregate throughput:\n\n')
    [val2, ix2] = max(agg_tpt);
    disp([' * Best aggregate throughput: ' num2str(val2) ' Mbps'])
    disp([' * Max individual throughput: ' num2str(max(throughputPerConfiguration(ix2, :))) ' Mbps']) 
    disp([' * Min individual throughput: ' num2str(min(throughputPerConfiguration(ix2, :))) ' Mbps']) 
    disp([' * Mean individual throughput: ' num2str(mean(throughputPerConfiguration(ix2, :))) ' Mbps']) 
    disp([' * std: ' num2str(std(throughputPerConfiguration(ix2, :))) ' Mbps'])    
    disp([' * Fairness: ' num2str(fairness(ix2))])
    disp([' * Best configurations: ' num2str(possible_comb(ix2, :))])
    for i = 1 : nWNs
        [a, ~, c] = val2indexes(possible_comb(ix2, i), nChannels, size(ccaActions, 2), size(txPowerActions, 2));  
        disp(['   . WN' num2str(i) ':'])
        disp(['       - Channel:' num2str(a)])
        disp(['       - TPC:' num2str(txPowerActions(c))])
    end
    
end
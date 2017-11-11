%%% ***********************************************************************************
%%% * Interference-based Throughput calculation framework                             *
%%% * Author: Francesc Wilhelmi (francesc.wilhelmi@upf.edu)                           *
%%% * Copyright (C) 2017-2022, and GNU GPLd, by Francesc Wilhelmi                     *
%%% * GitHub repository:                                                              *
%%% *   https://github.com/wn-upf/interference_based_throughput_calculation_framework *
%%% * More info on https://www.upf.edu/en/web/fwilhelmi                               *
%%% ***********************************************************************************

function optimalThroughputPerWlan = compute_max_bound_throughput(wn, powerMatrix, noise, maxPower)
% Given an WLAN (AP+STA), compute the maximum capacity achievable according
% to the power obtained at the receiver without interference
%
% OUTPUT:
%   * optimalThroughputPerWlan - maximum achievable throughput per WLAN (Mbps)
% INPUT:
%   * wlan - object containing all the WLANs information 
%   * powerMatrix - power received from each AP
%   * noise - floor noise in dBm

    disp('+++++++++++++++++++++++++++++++++++++++++++++++++')
    disp('Computing the maximum achievable throughput per WN for the given configuration...')
    disp('+++++++++++++++++++++++++++++++++++++++++++++++++')

    wlan_aux = wn;
    % Iterate for each WLAN
    for i = 1 : size(wlan_aux,2)
        wlan_aux(i).TxPower = maxPower;
        optimalThroughputPerWlan(i) = compute_theoretical_capacity(wlan_aux(i).BW, ...
            db2pow(powerMatrix(i,i) - noise))/1e6; % Mbps
    end
    
end
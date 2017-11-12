%%% ***********************************************************************************
%%% * Interference-based Throughput calculation framework                             *
%%% * Author: Francesc Wilhelmi (francesc.wilhelmi@upf.edu)                           *
%%% * Copyright (C) 2017-2022, and GNU GPLd, by Francesc Wilhelmi                     *
%%% * GitHub repository:                                                              *
%%% *   https://github.com/wn-upf/interference_based_throughput_calculation_framework *
%%% * More info on https://www.upf.edu/en/web/fwilhelmi                               *
%%% ***********************************************************************************

function optimalThroughputPerWlan = compute_max_bound_throughput(wns, powerMatrix, noise, maxPower)
% Given a WN (AP+STA), computes the maximum capacity achievable according
% to the power obtained at the receiver without interference
%
% OUTPUT:
%   * optimalThroughputPerWlan - maximum achievable throughput per WLAN (Mbps)
% INPUT:
%   * wns: contains information of each Wireless Network in the map. 
%   For instance, wns(1) corresponds to the first WN, so that it has 
%   unique parameters (position_ap, position_sta, txPower, etc.).
%   * powerMatrix - power received at each STA from each AP
%   * noise - floor noise in dBm

    disp('+++++++++++++++++++++++++++++++++++++++++++++++++')
    disp('Computing the maximum achievable throughput per WN for the given configuration...')
    disp('+++++++++++++++++++++++++++++++++++++++++++++++++')

    wns_aux = wns;
    % Iterate for each WLAN
    for i = 1 : size(wns_aux,2)
        wns_aux(i).TxPower = maxPower;
        optimalThroughputPerWlan(i) = compute_theoretical_capacity(wns_aux(i).BW, ...
            db2pow(powerMatrix(i,i) - noise))/1e6; % Mbps
    end
    
end
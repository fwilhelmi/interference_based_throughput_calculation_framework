%%% ***********************************************************************************
%%% * Interference-based Throughput calculation framework                             *
%%% * Author: Francesc Wilhelmi (francesc.wilhelmi@upf.edu)                           *
%%% * Copyright (C) 2017-2022, and GNU GPLd, by Francesc Wilhelmi                     *
%%% * GitHub repository:                                                              *
%%% *   https://github.com/wn-upf/interference_based_throughput_calculation_framework *
%%% * More info on https://www.upf.edu/en/web/fwilhelmi                               *
%%% ***********************************************************************************

function throughputPerWlan = compute_throughput_from_sinr(wns, powerMatrix, noise)
% Computes the throughput of each WN in wlan according to the
% interferences sensed 
%  * Assumption: all the devices transmit at the same time and the
%    throughput is computed as the capacity obtained from the total SINR 
%
% OUTPUT:
%   * tpt - tpt achieved by each WLAN (Mbps)
% INPUT:
%   * wns: contains information of each Wireless Network in the map. 
%   For instance, wns(1) corresponds to the first WN, so that it has 
%   unique parameters (position_ap, position_sta, txPower, etc.).
%   * powMat - power received from each AP
%   * noise - floor noise in dBm

    nWNs = size(wns, 2);
    sinr = zeros(1, nWNs);  
    % Activate all the WNs
    for j = 1 : nWNs, wns(j).transmitting = 1; end
    % Compute the tpt of each WN according to the sensed interferences
    for i = 1 : nWNs
        interf = interferences(wns, powerMatrix); %dBm                      
        sinr(i) = powerMatrix(i,i) - pow2db((interf(i) + db2pow(noise))); % dBm
        throughputPerWlan(i) = compute_theoretical_capacity(wns(i).BW, db2pow(sinr(i))) / 1e6; % Mbps     
    end
    
end
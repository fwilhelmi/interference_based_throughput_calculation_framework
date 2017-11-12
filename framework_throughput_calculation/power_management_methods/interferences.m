%%% ***********************************************************************************
%%% * Interference-based Throughput calculation framework                             *
%%% * Author: Francesc Wilhelmi (francesc.wilhelmi@upf.edu)                           *
%%% * Copyright (C) 2017-2022, and GNU GPLd, by Francesc Wilhelmi                     *
%%% * GitHub repository:                                                              *
%%% *   https://github.com/wn-upf/interference_based_throughput_calculation_framework *
%%% * More info on https://www.upf.edu/en/web/fwilhelmi                               *
%%% ***********************************************************************************

function interf = interferences(wns, powerMatrix)
% Interferences - Returns the interferences power received at each WLAN
%   OUTPUT:
%       - interf: 1xN array (N is the number of WLANs) with the
%       interferences noticed on each AP in mW
%   INPUT:
%       - wns: contains information of each Wireless Network in the map. 
%       For instance, wns(1) corresponds to the first WN, so that it has 
%       unique parameters (position_ap, position_sta, txPower, etc.).
%       - powerMatrix: matrix NxN (N is the number of WLANs) with the power
%       received at each AP in dBm.

% We assume that overlapping channels also create an interference with lower level (20dB/d) - 20 dB == 50 dBm

    interf = zeros(1, size(wns, 2)); 
    
    for i = 1:size(wns, 2)
        
        for j = 1:size(wns, 2)
            
            if i ~= j && wns(j).transmitting == 1
                
                interf(i) = interf(i) + db2pow(powerMatrix(i,j) - db2pow(20 * (abs(wns(i).Channel - wns(j).Channel))));
            
            end
            
        end
        
    end

end
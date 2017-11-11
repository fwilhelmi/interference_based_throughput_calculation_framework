%%% ***********************************************************************************
%%% * Interference-based Throughput calculation framework                             *
%%% * Author: Francesc Wilhelmi (francesc.wilhelmi@upf.edu)                           *
%%% * Copyright (C) 2017-2022, and GNU GPLd, by Francesc Wilhelmi                     *
%%% * GitHub repository:                                                              *
%%% *   https://github.com/wn-upf/interference_based_throughput_calculation_framework *
%%% * More info on https://www.upf.edu/en/web/fwilhelmi                               *
%%% ***********************************************************************************

function powerMatrix = power_matrix(wns)
% power_matrix - Returns the power received by each AP from all the others
%   OUTPUT:
%       - powMat: matrix NxN (N is the number of WLANs) with the power
%       received at each AP in dBm
%   INPUT:
%       - wns: contains information of each WLAN in the map. For instance,
%       wlan(1) corresponds to the first one, so that it has unique
%       parameters (x,y,z,BW,CCA,etc.)

    
    PLd1=5;                     % Path-loss factor
    shadowing = 9.5;            % Shadowing factor
    obstacles = 30;             % Obstacles factor
%     shadowingmatrix = shadowing*randn(nWlans);       % Shadowing affecting each WLAN
%     obstaclesmatrix = obstacles*rand(nWlans);        % Obstacles affecting each WLAN

    nWNs = size(wns,2);

    % Compute the received power on all the APs from all the others
    for i = 1 : nWNs
        for j = 1 : nWNs
            if(i ~= j)
                % Distance between APs of interest
                d_AP_AP = sqrt((wns(i).position_ap(1) - wns(j).position_ap(1))^2 + ...
                    (wns(i).position_ap(2) - wns(j).position_ap(2))^2 + ...
                    (wns(i).position_ap(3) - wns(j).position_ap(3))^2); 
                % Propagation model
                alfa = 4.4;
                %PL_AP = PLd1 + 10*alfa*log10(d_AP_AP) + shadowingmatrix(i,j) + (d_AP_AP/10).*obstaclesmatrix(i,j);
                PL_AP = PLd1 + 10 * alfa * log10(d_AP_AP) + shadowing / 2 + (d_AP_AP/10) .* obstacles / 2;
                powerMatrix(i,j) = wns(j).TxPower - PL_AP;        
            else
                % Calculate Power received at the STA associated to the AP
                d_AP_STA = sqrt((wns(i).position_ap(1) - wns(j).position_sta(1))^2 + ...
                    (wns(i).position_ap(2) - wns(j).position_sta(2))^2 + ...
                    (wns(i).position_ap(3) - wns(j).position_sta(3))^2); 
                % Propagation model
                alfa = 4.4;
                PL_AP = PLd1 + 10 * alfa * log10(d_AP_STA) + shadowing / 2 + (d_AP_STA / 10) .* obstacles / 2;
                powerMatrix(i,j) = wns(i).TxPower - PL_AP;
            end
        end
    end
%     disp('Received Power at each TX ')
%     disp(powMat)   
end
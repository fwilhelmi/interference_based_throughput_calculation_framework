%%% ***********************************************************************************
%%% * Interference-based Throughput calculation framework                             *
%%% * Author: Francesc Wilhelmi (francesc.wilhelmi@upf.edu)                           *
%%% * Copyright (C) 2017-2022, and GNU GPLd, by Francesc Wilhelmi                     *
%%% * GitHub repository:                                                              *
%%% *   https://github.com/wn-upf/interference_based_throughput_calculation_framework *
%%% * More info on https://www.upf.edu/en/web/fwilhelmi                               *
%%% ***********************************************************************************

function wn = generate_random_network_3D()
    % DrawNetwork3D  Calculate interferences on WLANs.
    %   Inputs are given by the "constants" file
    %   Output:
    %       * wn: object containing the information of each wireless network
    
    % Load constants
    load('constants.mat')

    % Display AP's density according to map size
    disp('Density of APs');
    disp(nWNs / (MaxX * MaxY * MaxZ));

    %% Locate elements on the map randomly
    for i = 1 : nWNs
        % Randomize the "txPowerActions" array and pick the first one
        randomPowers = txPowerActions(randperm(length(txPowerActions)));
        wn(i).TxPower = randomPowers(1);
        % Randomize the "ccaActions" array and pick the first one
        randomCCA = ccaActions(randperm(length(ccaActions)));
        wn(i).CCA = randomCCA(1);
        % Assign channel to the AP randomly
        wn(i).Channel = ceil(nChannels*rand());
        % Assign location to the AP on the 3D map
        wn(i).position_ap = [MaxX*rand() MaxY*rand() MaxZ*rand()];  
        % Assign a STA to each AP at a random distance (bounded by MaxRange)
        if(rand() < 0.5) 
            xc = MaxRangeX.*rand();   
        else
            xc = -MaxRangeX.*rand();
        end
        if(rand() < 0.5)
            yc = MaxRangeY.*rand();
        else
            yc = -MaxRangeY.*rand();
        end
        if(rand() < 0.5)
            zc = MaxRangeZ.*rand();
        else
            zc = -MaxRangeZ.*rand();
        end
        % Assign STA's position
        wn(i).position_sta = [min(abs(wn(i).position_ap(1)+xc), MaxX) ...
            min(abs(wn(i).position_ap(2)+yc), MaxY) min(abs(wn(i).position_ap(3)+zc), MaxZ)]; 
        % Assign the bandwidth available for transmissions
        wn(i).BW = channelBandwidth; 
    end
    
end
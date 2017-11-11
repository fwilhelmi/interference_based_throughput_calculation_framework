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
    %   Inputs:
    %       * N_WLANs: number of WLANs on the studied environment
    %       * NumChannels: number of available channels
    %       * B: bandwidth available per WLAN (Hz)
    %   Output:
    %       * wlan: object containing the information of each wlan drawn
    
    % Load constants
    load('constants.mat')

    % AP density
    disp('Density of APs');
    disp(nWNs / (MaxX * MaxY * MaxZ));

    %% Locate elements on the map randomly
    for j = 1 : nWNs
        % Randomize the "txPowerActions" array and pick the first one
        randomPowers = txPowerActions(randperm(length(txPowerActions)));
        wn(j).TxPower = randomPowers(1);
        % Randomize the "ccaActions" array and pick the first one
        randomCCA = ccaActions(randperm(length(ccaActions)));
        wn(j).CCA = randomCCA(1);
        % Assign channel to the AP randomly
        wn(j).Channel = ceil(nChannels*rand());
        % Assign location to the AP on the 3D map
        wn(j).position_ap = [MaxX*rand() MaxY*rand() MaxZ*rand()];  
        % Assign a STA to each AP for throughput analysis
        if(rand() < 0.5), xc = MaxRangeX.*rand();   
        else xc = -MaxRangeX.*rand();
        end
        if(rand() < 0.5), yc = MaxRangeY.*rand();
        else yc = -MaxRangeY.*rand();
        end
        if(rand() < 0.5), zc = MaxRangeZ.*rand();
        else zc = -MaxRangeZ.*rand();
        end
        wn(j).position_sta = [min(abs(wn(j).position_ap(1)+xc), MaxX) ...
            min(abs(wn(j).position_ap(2)+yc), MaxY) min(abs(wn(j).position_ap(3)+zc), MaxZ)]; 
        % Assign the bandwidth available for transmissions
        wn(j).BW = channelBandwidth; 
    end
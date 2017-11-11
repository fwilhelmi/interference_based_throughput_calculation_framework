%%% ***********************************************************************************
%%% * Interference-based Throughput calculation framework                             *
%%% * Author: Francesc Wilhelmi (francesc.wilhelmi@upf.edu)                           *
%%% * Copyright (C) 2017-2022, and GNU GPLd, by Francesc Wilhelmi                     *
%%% * GitHub repository:                                                              *
%%% *   https://github.com/wn-upf/interference_based_throughput_calculation_framework *
%%% * More info on https://www.upf.edu/en/web/fwilhelmi                               *
%%% ***********************************************************************************

% Number of WNs
nWNs = 4;                     

% Configuration parameters
nChannels = 2;                      % Number of channels
channelActions = 1 : nChannels;     % Range of available channels
ccaActions = [-62, -82];            % CCA threshold levels (dBm)
txPowerActions = [5, 20];           % Transmit power levels (dBm)

% Floor NOISE_DBM in dBm
NOISE_DBM = -100;                   
% Channel bandwidth (Hz)
channelBandwidth = 20e6;

% Dimensions of the 3D map
MaxX=10;
MaxY=5; 
MaxZ=10;
% Maximum range for a STA
MaxRangeX = 1;
MaxRangeY = 1;
MaxRangeZ = 1;
MaxRange = sqrt(3);

% Save constants into current folder
save('constants.mat');  
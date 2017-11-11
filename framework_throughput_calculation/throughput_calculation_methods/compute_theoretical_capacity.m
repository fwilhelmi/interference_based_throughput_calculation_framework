%%% ***********************************************************************************
%%% * Interference-based Throughput calculation framework                             *
%%% * Author: Francesc Wilhelmi (francesc.wilhelmi@upf.edu)                           *
%%% * Copyright (C) 2017-2022, and GNU GPLd, by Francesc Wilhelmi                     *
%%% * GitHub repository:                                                              *
%%% *   https://github.com/wn-upf/interference_based_throughput_calculation_framework *
%%% * More info on https://www.upf.edu/en/web/fwilhelmi                               *
%%% ***********************************************************************************

function C = compute_theoretical_capacity(B, sinr)
% Computes the theoretical capacity given a bandwidth and a SINR
%
% OUTPUT:
%   * C - capacity in bps
% INPUT:
%   * B - Available Bandwidth (Hz) 
%   * sinr - Signal to Interference plus Noise Ratio (-)

    C = B * log2(1 + sinr);

end
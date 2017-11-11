%%% ***********************************************************************************
%%% * Interference-based Throughput calculation framework                             *
%%% * Author: Francesc Wilhelmi (francesc.wilhelmi@upf.edu)                           *
%%% * Copyright (C) 2017-2022, and GNU GPLd, by Francesc Wilhelmi                     *
%%% * GitHub repository:                                                              *
%%% *   https://github.com/wn-upf/interference_based_throughput_calculation_framework *
%%% * More info on https://www.upf.edu/en/web/fwilhelmi                               *
%%% ***********************************************************************************

function fairness = jains_fairness(C)
% JainsFairness returns the Jain's fairness measure given the inputted array
%   OUTPUT: 
%       * fairness - Jain's fairness measure from 0 to 1
%   INPUT: 
%       * C - array of capacities that each WLAN experiences

    numRows = size(C, 1);
    
    for i = 1 : numRows
        fairness(i) = sum(C(i,:))^2 ./ (size(C(i,:),2)*sum(C(i,:).^2));
    end

end
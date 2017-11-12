%%% ***********************************************************************************
%%% * Interference-based Throughput calculation framework                             *
%%% * Author: Francesc Wilhelmi (francesc.wilhelmi@upf.edu)                           *
%%% * Copyright (C) 2017-2022, and GNU GPLd, by Francesc Wilhelmi                     *
%%% * GitHub repository:                                                              *
%%% *   https://github.com/wn-upf/interference_based_throughput_calculation_framework *
%%% * More info on https://www.upf.edu/en/web/fwilhelmi                               *
%%% ***********************************************************************************

function draw_network_3D(wn)
% DrawNetwork3D - Plots a 3D of the network 
%   INPUT: 
%       * wn - contains information of each Wireless Network in the map. For instance,
%       wn(1) corresponds to the first one, so that it has unique
%       parameters (position_ap, position_sta, txPower, etc.)

    load('constants.mat')
    
    % Put AP positions into an array
    for j = 1 : size(wn,2)
        x(j) = wn(j).position_ap(1);
        y(j) = wn(j).position_ap(2);
        z(j) = wn(j).position_ap(3);
    end
    
    % Draw each WN in the 3D-map
    figure
    axes;
    set(gca,'fontsize',16);
    labels = num2str((1:size(y' ))','%d');    
    for i = 1 : size(wn,2)
        % AP drawing
        scatter3(wn(i).position_ap(1), wn(i).position_ap(2), wn(i).position_ap(3), 70, [0 0 0], 'filled');
        hold on;   
        % STA drawing
        scatter3(wn(i).position_sta(1), wn(i).position_sta(2), wn(i).position_sta(3), 30, [0 0 1], 'filled');
        line([wn(i).position_ap(1), wn(i).position_sta(1)], ...
            [wn(i).position_ap(2), wn(i).position_sta(2)], ...
            [wn(i).position_ap(3), wn(i).position_sta(3)], 'Color', [0.4, 0.4, 1.0], 'LineStyle', ':');        
    end
    text(x,y,z,labels,'horizontal','left','vertical','bottom') 
    xlabel('x [meters]','fontsize',14);
    ylabel('y [meters]','fontsize',14);
    zlabel('z [meters]','fontsize',14);
    axis([0 MaxX 0 MaxY 0 MaxZ])
    
end
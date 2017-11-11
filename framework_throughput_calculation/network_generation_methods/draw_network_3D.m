%%% ***********************************************************************************
%%% * Interference-based Throughput calculation framework                             *
%%% * Author: Francesc Wilhelmi (francesc.wilhelmi@upf.edu)                           *
%%% * Copyright (C) 2017-2022, and GNU GPLd, by Francesc Wilhelmi                     *
%%% * GitHub repository:                                                              *
%%% *   https://github.com/wn-upf/interference_based_throughput_calculation_framework *
%%% * More info on https://www.upf.edu/en/web/fwilhelmi                               *
%%% ***********************************************************************************

function draw_network_3D(wlan)
% DrawNetwork3D - Plots a 3D of the network 
%   INPUT: 
%       * wlan - contains information of each WLAN in the map. For instance,
%       wlan(1) corresponds to the first one, so that it has unique
%       parameters (x,y,z,BW,CCA,etc.)

    MaxX=10;
    MaxY=5; 
    MaxZ=10;
    for j = 1 : size(wlan,2)
        x(j) = wlan(j).position_ap(1);
        y(j) = wlan(j).position_ap(2);
        z(j) = wlan(j).position_ap(3);
    end
    figure
    axes;
    set(gca,'fontsize',16);
    labels = num2str((1:size(y' ))','%d');    
    for i=1:size(wlan,2)
        scatter3(wlan(i).position_ap(1), wlan(i).position_ap(2), wlan(i).position_ap(3), 70, [0 0 0], 'filled');
        hold on;   
        scatter3(wlan(i).position_sta(1), wlan(i).position_sta(2), wlan(i).position_sta(3), 30, [0 0 1], 'filled');
        line([wlan(i).position_ap(1), wlan(i).position_sta(1)], ...
            [wlan(i).position_ap(2), wlan(i).position_sta(2)], ...
            [wlan(i).position_ap(3), wlan(i).position_sta(3)], 'Color', [0.4, 0.4, 1.0], 'LineStyle', ':');        
    end
    text(x,y,z,labels,'horizontal','left','vertical','bottom') 
    xlabel('x [meters]','fontsize',14);
    ylabel('y [meters]','fontsize',14);
    zlabel('z [meters]','fontsize',14);
    axis([0 MaxX 0 MaxY 0 MaxZ])
end
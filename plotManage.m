% function to manage world frame grid and axis for plot
function []=plotManage()
    worldFrame=[-2 22 -2 22];
    grid minor;
    axis(worldFrame);
    axis square;
end

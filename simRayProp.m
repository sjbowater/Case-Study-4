% function simRayProp(M,y_in,theta_in)
% simulates propagation of rays through an object
% 
% inputs:
% M - ray transfer matrix (2D)
% y_in - list of rays' y-coordinates to propagate
% theta_in - list of rays' angles in yz plane to propagate
%
% outputs:
% y_out - list of rays' y-coordinates at output
% theta_out - list of rays' angles in yz plane at output

function [y_out,theta_out] = simRayProp(M,y_in,theta_in)
    % length(y_in) gives us N, where |y_in|, |theta_in|, |y_out|, and
    % |theta_out| are all Nx1 vectors. 
    y_out     = zeros(length(y_in), 1);
    theta_out = zeros(length(y_in), 1);
    for i = 1:length(y_in)
        x = M * [y_in(i) theta_in(i)].';
        y_out(i) = x(1);
        theta_out(i) = x(2);
    end
end
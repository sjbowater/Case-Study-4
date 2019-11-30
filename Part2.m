%% Task 2
clear all;
close all;
%% Part 2.1

f = 100;  % f  = 100 mm.
z1 = 250; % z1 = 250 mm.

M = generate_ray_transfer_matrix(z1, f);

[y_out theta_out] = simRayProp(M, 1, 0);

% f = 100; % f is 100 mm.
% theta1 = 0;
% 
% M = generate_ray_transfer_matrix(theta1, f);
% 
% [y_out, theta_out] = simRayProp(M, 1, theta1);
% 
% 
function M = generate_ray_transfer_matrix(z1, f)
    M1 = [1 z1;
          0 1;
         ];
    
    Mf = [  1   0;
           -1/f 1;
         ];
     
    % Z2 = Z1 / ( (Z1 / f) - 1)
    M2 = [ 1 (z1 / ( (z1 / f) - 1))
           0                      1
         ];
       
    M = M2 * Mf * M1;
end
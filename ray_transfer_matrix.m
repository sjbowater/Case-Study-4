%% functions
function [M, M1, Mf, M2] = ray_transfer_matrix(z1, f)
    M1 = [1 z1;
          0 1;
         ];
    
    Mf = [  1   0;
           -1/f 1;
         ];
     
    % Z2 = Z1 / ( (Z1 / f) - 1)
    M2 = [ 1 abs(z1 / ( (z1 / f) - 1))
           0                      1
         ];
       
    M = M2 * Mf * M1;
end
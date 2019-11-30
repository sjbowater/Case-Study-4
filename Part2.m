%% Task 2
clear all;
close all;
%% Part 2.1

f = 100;  % f  = 100 mm.
z1 = 250; % z1 = 250 mm.

M = generate_ray_transfer_matrix(z1, f);
y1=1;
z2=z1 / ( (z1 / f) - 1);
[y_out theta_out] = simRayProp(M, y1, 0)

   M1 = [1 z1;
          0 1;
         ];
    
    Mf = [  1   0;
           -1/f 1;
         ];
    M2 = [ 1 (z1 / ( (z1 / f) - 1));
           0                      1;
         ];
% theta1=theta(y1,z1);
[y_out1 theta_out1] = simRayProp(M2, y1, -y1/z1);
[y_out2 theta_out2] = simRayProp(M2, y1, 0);
[y_out3 theta_out3] = simRayProp(M2, y1, -(y1+abs(y_out))/z2);


% f = 100; % f is 100 mm.
% theta1 = 0;
% 
% M = generate_ray_transfer_matrix(theta1, f);
% 
% [y_out, theta_out] = simRayProp(M, 1, theta1);

figure();
rectangle('Position',[-5 -y1 10 2*y1],'Curvature',[0.5,1]);
axis([-z1 z2 y_out y1]);
hold on;
scatter(-z1,y1);
scatter(z2, y_out);
scatter(-f,0);
scatter(f,0);
line([-300,300],[0,0]); %horizontal line at zero
line([-z1,0],[y1,y_out1]); %ray through middle of lense
line([0,z2],[y_out1,y_out]);
line([-z1,0],[y1,y_out2]); %ray starts at 0 theta
line([0,z2],[y_out2,y_out]);
line([-z1,0],[y1,y_out3]); %ray hits bottow of lense
line([0,z2],[y_out3,y_out]);




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
%% Case study 4: Ray tracing in optics
% *ESE 105* 
%
% *Name: Stephanie Bowater and Peyton Gozon*

clear;
close all;

% load light field
load('lightField.mat');

% visualize rays as an image
[rayImg,x,y] = rays2img(ray_x,ray_y,ray_color,.025,300);
image(x,y,rayImg); axis image xy;
xlabel('x (m)'); ylabel('y (m)');

%% img 1
z2 = 2000;
p = 4000;  % rays of the point originate 4000 mm away from the lens.
f = 200;

M1 = [1 -(f*z2) / (f - z2);
      0 1;
     ];

Mf = [  1   0;
       -1/f 1;
     ];
 
M2 = [ 1 z2;
       0                      1;
     ];
      
Minv = inv(M1) * inv(Mf) * inv(M2);

z1 = -(f*z2) / (f - z2);



[x_out, theta_x_out] = simRayProp(Minv, ray_x, ray_theta_x);
[y_out, theta_y_out] = simRayProp(Minv, ray_y, ray_theta_y);

figure;
[rayImg, x, y] = rays2img(x_out.', y_out.', ray_color, 0.025, 300);
image(x, y, rayImg); axis image xy;
xlabel('x (m)'); ylabel('y (m)');

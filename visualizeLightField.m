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
z1 = 2000; % the lens focuses rays from 2000 mm away.
p = 4000;  % rays of the point originate 4000 mm away from the lens.
f = 200;

M1 = [1 z1;
      0 1;
     ];

Mf = [  1   0;
       -1/f 1;
     ];
 
M2 = [ 1 abs(z1 / ( (z1 / f) - 1));
       0                      1;
     ];
 
Mb = [1 p-z1;
      0 1   ;
     ];
 
% invM1 = inv(M1);
% invMf = inv(Mf);
% invM2 = inv(M2);
% M=invM1*invMf*invM2;
 
M = inv(M1) * inv(Mf) * inv(M2);
ray_x_in = zeros(1, length(ray_theta_x));
ray_theta_x_in = zeros(1, length(ray_theta_x));

for i = 1:length(ray_theta_x)
 x = M * [ray_x(i), ray_theta_x(i)].';
 ray_x_in(i) = x(1); 
 ray_theta_x_in(i) = x(2);
end
 
[rayImg,x,y] = rays2img(ray_x,ray_y,ray_color,.025,300);
image(x,y,rayImg); axis image xy;
xlabel('x (m)'); ylabel('y (m)');

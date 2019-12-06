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
% These are the best-looking distances to each image. 
z1 = [0.1539 0.1568 0.16205 0.1811];

z2 = 0.2;         % Fixing a number for Z2. 
f  = 0.085;       % Fixing a focal distance.
fnum = 1.4;       % Choosing a small f-num to isolate images in view without layering.

Mf = [  1   0;
       -1/f 1;
     ];

M2 = [ 1 z2;
       0  1;
     ];

for i = 1:length(z1)    
    M1 = [1 z1(i);
          0 1;
         ];
        
    M = M2 * Mf * M1;
    
    % Handle permutations in the yz plane.
    [sim_output_y, sim_theta_y] = simRayProp(M, ray_y, ray_theta_y);
    
    % Handle permutations in the xz plane.
    [sim_output_x, sim_theta_x] = simRayProp(M, ray_x, ray_theta_x);
    
    [rayImg,x,y] = rays2img(sim_output_x,sim_output_y,ray_color,.025,1000);
    figure;
    image(x,y,rayImg); axis image xy;
    xlabel('x (m)'); ylabel('y (m)'); 
    set(gca, 'Ydir', 'Reverse');
    set(gca, 'Xdir', 'Reverse');
    title("z1 = " + string(z1(i)))
end
%% Task 3: Depth of Field

clear all;
close all;

%% Task 3.1
% For an out-of-focus object placed at a position 4 m in front of the lens,
% plot the radius ? of the circle of confusion versus f-number for f-numbers
% ranging from 1.4 to 22

z1 = 2000; % the lens focuses rays from 2000 mm away.
p = 4000;  % rays of the point originate 4000 mm away from the lens.
f = 200;   % the focal distance is 200 mm.
index = 1;
fnums = 1.4:0.1:22;
y_out = zeros(length(fnums), 1);
z2=z1 / ( (z1 / f) - 1);
[M, ~, ~, ~] = ray_transfer_matrix(z1, f);

Mb = [1 p-z1
      0 1   ];

for fnum = fnums
    theta_in = (f / (2 * fnum))/p;
    [y_out(index), theta_out] = simRayProp(M * Mb, 0, theta_in);
    index = index + 1; 
end

figure;
plot(fnums, abs(y_out))
xlabel("f/#");
ylabel("radius (mm)");
title("Radius of Confusion vs F-Number");

%% 3.2
z1 = 2; % the turkey image is 2m back from the lens.
zb = 2; % the "background" image (snowglobe) is 2m back further from the turkey.
f = 0.2;% focal distance is 200 mm.

fnum_large = 50;
fnum_small = 1.4;

fnums = [fnum_large fnum_small];

img1 = imread('200px-Turkey.png');
img2 = imread('200px-Snow_Globe.png');

width = 0.025;
numRays = 5e6;

[M, ~, ~, ~] = ray_transfer_matrix(z1, f);
 
Mb = [1 zb;
      0  1;
     ];

for fnum = fnums
    % Compute the maximum angles
    theta_turkey = (f / (2 * fnum)) / z1;
    theta_snow   = (f / (2 * fnum)) / (z1 + zb);
    
    % convert the images to rays.
    [x_out1,y_out1,theta_x_out1,theta_y_out1, turkey_color] = img2rays(img1,.2,numRays,theta_turkey);
    [x_out2,y_out2,theta_x_out2,theta_y_out2, snow_color]   = img2rays(img2,.2,numRays,theta_snow);
    [x_out1,y_out1,theta_x_out1,theta_y_out1, turkey_color] = img2rays(img1,0.2,numRays,theta_turkey);
    [x_out2,y_out2,theta_x_out2,theta_y_out2, snow_color]   = img2rays(img2,0.2,numRays,theta_snow);
    
    % Handle permutations in the yz plane.
    [turkey_output_y, ray_theta_y1] = simRayProp(M,      y_out1, theta_y_out1);
    [snow_output_y,   ray_theta_y2] = simRayProp(M * Mb, y_out2, theta_y_out2);
    
    % Handle permutations in the xz plane.
    [turkey_output_x, ray_theta_x1] = simRayProp(M,      x_out1, theta_x_out1);
    [snow_output_x,   ray_theta_x2] = simRayProp(M * Mb, x_out2, theta_x_out2);
    
    % Store the imaging components so that they may be visualized.
    rays_x      = [turkey_output_x snow_output_x];
    rays_y      = [turkey_output_y snow_output_y];
    color       = [turkey_color snow_color];
        
    % Visualize the components. 
    [img, x, y] = rays2img(rays_x, rays_y, color, width, 1000);
    
    figure;
    image(x,y,img);
    xlabel("x (m)"); ylabel("y (m)");
    title("Fnum = " + string(fnum));
end

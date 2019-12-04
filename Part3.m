%% Task 3: Depth of Field

clear all;
close all;

%% Task 3.1
%For an out-of-focus object placed at a position 4 m in front of the lens,
%plot the radius ? of the circle of confusion versus f-number for f-numbers
%ranging from 1.4 to 22
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
  
%     M1 = [1 p;
%           0 1;
%          ];
%     
%     Mf = [  1   0;
%            -1/f 1;
%          ];
%      
%     % Z2 = Z1 / ( (Z1 / f) - 1)
%     M2 = [ 1 abs(z1 / ( (z1 / f) - 1))
%            0                      1
%          ];
%  M = M2 * Mf * M1;

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
z1 = 2000; % the lens focuses rays from 2000 mm away.
p = 4000;  % Blurred image originates 4000 mm away from the lens.
img1=load('200px-Turkey.png');
img2=load('200px-Snow_Globe.png');
[x_out1,y_out1,theta_x_out1,theta_y_out1, color1]=img2rays(img1,0.02,1000000,pi/2);
[x_out2,y_out2,theta_x_out2,theta_y_out2, color2]=img2rays(img2,0.02,1000000,pi/2);
for fnum = fnums
    theta_in = (f / (2 * fnum))/p;
    [y_out(index), theta_out] = simRayProp(M * Mb, 0, theta_in);
    index = index + 1; 
end

  



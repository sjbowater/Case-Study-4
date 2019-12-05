%% Task 2
clear all;
close all;
%% Part 2.1

f = 100;  % f  = 100 mm.
z1 = 45; % z1 = 250 mm.

M = generate_ray_transfer_matrix(z1, f);
y1=1;
z2=z1 / ( (z1 / f) - 1)
[y_out, theta_out] = simRayProp(M, y1, 0);

% [y_out theta_out] = simRayProp(M, y1, 0)

   M1 = [1 z1;
          0 1;
         ];
    
    Mf = [  1   0;
           -1/f 1;
         ];
    M2 = [ 1 abs(z1 / ( (z1 / f) - 1));
           0                      1;
         ];
% theta1=theta(y1,z1);

% f = 100; % f is 100 mm.
 theta1 = 0;
% 
% M = generate_ray_transfer_matrix(theta1, f);

[y_out, theta_out] = simRayProp(M, 1, theta1);

figure();
rectangle('Position',[-(z1/100) -y1-1 2*z1/100 2*y1+2],'Curvature',[0.5,1]);
axis([-z1-100 z2+100 -abs(y_out)-1 y1+1]);
hold on;

[y_out2, theta_out2] = simRayProp(M2, y1, 0);
    
if f>z1
    [y_out1, theta_out1] = simRayProp(M2, y1, y1/z2);
    [y_out3, theta_out3] = simRayProp(M1, y1, y1/(f-z1));
    line([-f, 0],[0, y_out3]);
else 
    [y_out1, theta_out1] = simRayProp(M2, y1, -y1/z2);
    [y_out3, theta_out3] = simRayProp(M2, y1, -(y1+abs(y_out))/z2);
end

% The points on the graph
scatter(-z1,y1);
scatter(z2, y_out);
scatter(-f,0);
scatter(f,0);

line([-300,300],[0,0]); %horizontal line at zero
line([-z1,0],[y1,y_out1]); %ray through middle of lense
line([0,z2],[y_out1,y_out]);
line([-z1,0],[y1,y_out2]); %ray starts at 0 theta
line([0,z2],[y_out2,y_out]);
line([0,z2],[y_out3,y_out]); %refelcted ray from line going through f
line([-z1,0],[y1,y_out1]); %ray through middle of lense
line([0, z2],[y_out1,y_out]);
line([-z1,0],[y1,y_out2]); %ray starts at 0 theta
line([0,z2],[y_out2,y_out]);
line([-z1,0],[y1,y_out3]); %ray hits bottow of lense
line([0,z2],[y_out3,y_out]);

%% Task 2.3

% |i| is the equivalent of z1 for this part. 
z2 = zeros(1000, 1);
% from 1 mm to 1000 mm (1 meter).
for i = 1:1000
    z2(i) = (i / ((i / f) - 1));
end

% figure();
% hold on;
% plot(1:1000, z2);
% fplot(@(x) (1./f - 1./x).^(-1), [1, 1000])
% hold off;
% legend("Approximated", "Theoretical", "location", "best");
% xlabel("z_1 (mm)");
% ylabel("z_2 (mm)");
% title("Approximated vs Theoretical z_1 vs z_2 ");

%% Task 2.4

% from 1 mm to 1000 mm (1 meter)
m = zeros(1000, 1);
theta = 0;
for i = 1:1000
    if f>i
        theta = y1 / (f-i);
    else 
        theta = -(y1 + abs(y_out)) / i;
    end
    [y2, ~] = simRayProp(M2, y1, theta);
    m(i) = y2 / y1;
end

figure();
hold on;
plot(1:1000, m(:));
fplot(@(x) (1 - x./f).^(-1), [1, 1000])
hold off;
legend("Approximated", "Theoretical", "location", "best");
xlabel("z_1 (mm)");
ylabel("magnification");    
title("z_1 vs magnification");

%% functions
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

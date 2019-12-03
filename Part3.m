%% Task 3: Depth of Field

%% Task 3.1
%For an out-of-focus object placed at a position 4 m in front of the lens,
%plot the radius ? of the circle of confusion versus f-number for f-numbers
%ranging from 1.4 to 22
z1=4000; %mm
f=200;
for i = 1.4:0.1:22
    M=generate_ray_transfer_matrix(z1, f);
    theta_in=f/2i/z1;
    [y_out, theta_out]=simRayProp(M,0,theta_in);
end
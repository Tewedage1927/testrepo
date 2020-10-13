%   Clear up workspace

close all;
clear all;
clc;

%% Initialize variables.

filename = 'data1.txt';
delimiter = '\t';
startRow = 50;

%% importing the data set from the text file

[time,fx,fy,fz,wx,wy,wz] = importfile(filename, startRow);

time=time*10^-6;%% since the time is in microsecond 

%% since the angular velocity is degree per second 
wx=(pi/180)*wx;
wy=(pi/180)*wy;
wz=(pi/180)*wz;

%% Clear temporary variables

clearvars filename delimiter startRow formatSpec fileID dataArray ans;

%%computing for the time interval 

n=139;%% the row of the vector 
dt = compute_time_interval (time,n);

%% setting initial conditions

initial_condition_psi=0;
initial_condition_theta=0;
initial_condition_phi=0;

initial_condition_vx=0;
initial_condition_vy=0;
initial_condition_vz=0;

initial_condition_X=0;
initial_condition_Y=0;
initial_condition_Z=0;
%% computting orientation 

[psi,theta,phi] = computing_orientation(n,wx,wy,wz,dt,initial_condition_psi,initial_condition_theta,initial_condition_phi);

%% plotting orientation 
figure(1)

subplot(3,1,1)
plot(time,psi)
grid on
title('plot of psi');

subplot(3,1,2)
plot(time,theta)
grid on
title('plot of theta');

subplot(3,1,3)
plot(time,phi)
grid on
title('plot of phi');

%% computing transformation matrix 

[C1,C2,C3]= compute_transformaiton_matrix(n,psi,theta,phi);

%% computing gravity 

%% inputing latitude, altitude, and radius

Ld=46.3924;
h=264;
R=6.371*10^3;

gamma=compute_gravity_vector(Ld,h,R);

%% computing acceleration

[ax, ay, az]= computing_acceleration(n,C1,C2,C3,fx,fy,fz,gamma);

%% plotting acceleration  
figure(2)

subplot(3,1,1)
plot(time,ax)
grid on
title('plot of acceleration in the x-direction');

subplot(3,1,2)
plot(time,ay)
grid on
title('plot of acceleration in the y-direction');

subplot(3,1,3)
plot(time,az)
grid on
title('plot of acceleration in the z-direction');

%% computing velocity 

[vx,vy,vz] = computing_velocity(n,ax,ay,az,dt,initial_condition_vx,initial_condition_vy,initial_condition_vz);

%% plotting velocity 
figure(3)

subplot(3,1,1)
plot(time,vx)
grid on
title('plot of velocity in the x-direction');

subplot(3,1,2)
plot(time,vy)
grid on
title('plot of velocity in the y-direction');

subplot(3,1,3)
plot(time,vz)
grid on
title('plot of velocity in the z-direction');

%% computing velocity 

[X,Y,Z] = computing_position(n,vx,vy,vz,dt,initial_condition_X,initial_condition_Y,initial_condition_Z);

%% plotting velocity 
figure(4)

subplot(3,1,1)
plot(time,X)
grid on
title('plot of position in the x-direction');

subplot(3,1,2)
plot(time,Y)
grid on
title('plot of position in the y-direction');

subplot(3,1,3)
plot(time,Z)
grid on
title('plot of position in the z-direction');


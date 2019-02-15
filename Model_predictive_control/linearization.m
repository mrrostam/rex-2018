clear;
close all;
clc;

addpath('../Quadrotor_Model_2D');

num_state = 6;
num_u = 2;

fun = @(x) quadrotor_model_2d([0 0 0 0 0 0], 0, x);

x = fsolve(fun,[500 500]);

x_equ = [0 0 0 0 0 0]';
u_equ = x';


t = 0;
e_state = eye(num_state);
e_u = eye(num_u);

h = 0.1;

for i = 1:(num_state)
    dsys_in = quadrotor_model_2d(x_equ + e_state(:,i)*h, t, u_equ) - quadrotor_model_2d(x_equ - e_state(:,i)*h, t, u_equ);
    A(:,i) = (dsys_in)/(2*h);
end

h = 1;
for i = 1:(num_u)
    dsys_in = quadrotor_model_2d(x_equ, t, u_equ + e_u(:,i)*h) - quadrotor_model_2d(x_equ, t, u_equ - e_u(:,i)*h);
    B(:,i) = (dsys_in)/(2*h);
end

C = eye(num_state);
D = zeros(num_state,num_u);

save linear_model A B C D
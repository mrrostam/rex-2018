% Simulation times, in seconds.
start_time = 0;
end_time = 2;
dt = 0.1;
times = start_time:dt:end_time;

% Number of points in the simulation.
N = numel(times);
q = zeros(N, 6);
% Initial simulation state.
x0 = 0;
y0 = 10;
theta0 = 0;

x0_dot = 0;
y0_dot = 0;
theta0_dot = 0;

q(1,:) = [x0;y0;theta0;x0_dot;y0_dot;theta0_dot];

u(1) = 800;
u(2) = 800;

% Step through the simulation, updating the state.

% Model => x_dot = f(x, t)
% Euler method https://en.wikipedia.org/wiki/Euler_method
%  x_(n+1) = x_(n) + dt*f(x,t)

for i = 1:N-1
    
    q(i+1,:) = q(i,:) + transpose(dt*quadrotor_model_2d(q(i,:), u));

end

%Plot all position and orientation variables

figure(1);
subplot(3, 1, 1);
plot(times,q(:,1))
xlabel('Time [Second]');
ylabel('x [m]');

subplot(3, 1, 2);
plot(times,q(:,2))
xlabel('Time [Second]');
ylabel('y [m]');

subplot(3, 1, 3);
plot(times,q(:,3))
xlabel('Time [Second]');
ylabel('theta [rad]');
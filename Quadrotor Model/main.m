% Simulation times, in seconds.
start_time = 0;
end_time = 2;
dt = 0.005;
times = start_time:dt:end_time;

% Number of points in the simulation.
N = numel(times);
q = zeros(N, 12);
% Initial simulation state.
x = [0; 0; 10];
x_dot = zeros(3, 1);
theta = zeros(3, 1);
theta_dot = zeros(3, 1);

q(1,:) = [x; theta; x_dot; theta_dot];

u(1) = 600;
u(2) = 600;
u(3) = 600;
u(4) = 599;

% Step through the simulation, updating the state.
for i = 1:N-1
    
    q(i+1,:) = q(i,:) + dt*quadrotor_model(q(i,:), times(i), u);

end

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
ylabel('z [m]');

figure(2);
subplot(3, 1, 1);
plot(times,q(:,4))
xlabel('Time [Second]');
ylabel('phi [rad]');

subplot(3, 1, 2);
plot(times,q(:,5))
xlabel('Time [Second]');
ylabel('theta [rad]');

subplot(3, 1, 3);
plot(times,q(:,6))
xlabel('Time [Second]');
ylabel('psi [rad]');

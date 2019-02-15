nx = 4;
ny = 2;
nu = 1;
nlobj = nlmpc(nx, ny, nu);



nlobj.OV(1).Min = -10;
nlobj.OV(1).Max = 10;

nlobj.MV.Min = -100;
nlobj.MV.Max = 100;

x0 = [0.1;0.2;-pi/2;0.3];
u0 = 0.4;

EKF = unscentedKalmanFilter(@pendulumStateFcn, @pendulumMeasurementFcn);

x = [0;0;-pi;0];
y = [x(1);x(3)];
EKF.State = x;

mv = 0;

yref1 = [0 0];

yref2 = [5 0];


Duration = 20;
hbar = waitbar(0,'Simulation Progress');
xHistory = x;
for ct = 1:(20/Ts)
    % Set references
    if ct*Ts<10
        yref = yref1;
    else
        yref = yref2;
    end
    % Correct previous prediction using current measurement
    xk = correct(EKF, y);
    % Compute optimal control moves
    [mv,nloptions,info] = nlmpcmove(nlobj,xk,mv,yref,[],nloptions);
    % Predict prediction model states for the next iteration
    predict(EKF, [mv; Ts]);
    % Implement first optimal control move and update plant states.
    x = pendulumDT0(x,mv,Ts);
    % Generate sensor data with some white noise
    y = x([1 3]) + randn(2,1)*0.01;
    % Save plant states for display.
    xHistory = [xHistory x]; %#ok<*AGROW>
    waitbar(ct*Ts/20,hbar);
end
close(hbar);

figure
subplot(2,2,1)
plot(0:Ts:Duration,xHistory(1,:))
xlabel('time')
ylabel('z')
title('cart position')
subplot(2,2,2)
plot(0:Ts:Duration,xHistory(2,:))
xlabel('time')
ylabel('zdot')
title('cart velocity')
subplot(2,2,3)
plot(0:Ts:Duration,xHistory(3,:))
xlabel('time')
ylabel('theta')
title('pendulum angle')
subplot(2,2,4)
plot(0:Ts:Duration,xHistory(4,:))
xlabel('time')
ylabel('thetadot')
title('pendulum velocity')
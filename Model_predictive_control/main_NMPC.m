clear

addpath('../Quadrotor_Model_2D'); %import model

nx = 6; % # of states
ny = 6; % # of output
nu = 2; % # of inputs

nlobj = nlmpc(nx, ny, nu);

Ts = 0.1; % time step
nlobj.Ts = Ts;

nlobj.PredictionHorizon = 20; 
nlobj.ControlHorizon = 10;

nlobj.Model.StateFcn = "quadrotor_model_2d";

nlobj.Model.IsContinuousTime = true;

nlobj.Model.NumberOfParameters = 0;

nlobj.Weights.OutputVariables = [1 1 1 1 1 1]*10^5;
nlobj.Weights.ManipulatedVariables = [0 0];
nlobj.Weights.ManipulatedVariablesRate = [1 1]*100;

nloptions = nlmpcmoveopt;
%nloptions.Parameters = {};


xk = [0 0 0 0 0 0]; % initial states

mv = [500 500]; % initial control inputs

yref = [0 0 0 0 0 0]; % Control reference (target)

Duration = 10;
hbar = waitbar(0,'Simulation Progress');

mvHistory = mv;
xHistory = [xk];
refHistory = [0 0 0 0 0 0];
History = 0;

for i = 1:Duration/Ts
    
    if i < Duration/Ts/2
        
        yref = [1 0 0 0 0 0];
        
    else
        
        yref = [1 -2 0 0 0 0];
    end

    [mv,nloptions,info] = nlmpcmove(nlobj,xk,mv,yref,[],nloptions);
    xk = xk + transpose(Ts*quadrotor_model_2d(xk', mv));

    waitbar(i*Ts/Duration,hbar);
    mvHistory = [mvHistory; mv'];
    xHistory = [xHistory; xk];
    refHistory = [refHistory; yref];
    History = [History; i*Ts];
end

close(hbar);

figure(1);
subplot(3, 1, 1);
plot(History, xHistory(:,1))
hold on
plot(History, refHistory(:,1),'r--')
xlabel('Time [Second]');
ylabel('x [m]');

subplot(3, 1, 2);
plot(History, xHistory(:,2))
hold on
plot(History, refHistory(:,2),'r--')
xlabel('Time [Second]');
ylabel('y [m]');

subplot(3, 1, 3);
plot(History, xHistory(:,3))
hold on
plot(History, refHistory(:,3),'r--')
xlabel('Time [Second]');
ylabel('theta [rad]');
legend('Output', 'Reference');

figure(2);
subplot(2, 1, 1);
plot(History, mvHistory(:,1))
xlabel('Time [Second]');
ylabel('Rotor speed 1 [rad/s]');

subplot(2, 1, 2);
plot(History, mvHistory(:,2))
xlabel('Time [Second]');
ylabel('Rotor speed 2 [rad/s]');

addpath('./Quadrotor Model-2D');
linearization

nx = 6;
ny = 6;
nu = 2;
nlobj = nlmpc(nx,ny,nu);

Ts = 0.1;
nlobj.Ts = Ts;
nlobj.PredictionHorizon = 10;
nlobj.ControlHorizon = 5;

nlobj.Model.StateFcn = "quadrotor_model_2d";
nlobj.Model.IsContinuousTime = true;

CSTR = ss(A,B,C,D); %linearized system model

CSTR.InputName = {'w_1','w_2'};
CSTR.OutputName = {'X','Y', 'T', 'Xdot', 'Ydot', 'Tdot'};
CSTR.StateName = {'X','Y', 'T', 'Xdot', 'Ydot', 'Tdot'};
CSTR.InputGroup.MV = 2; %manipulated variable (control input)
%CSTR.InputGroup.UD = 0; %unmeasured disturbance
CSTR.OutputGroup.MO = 6; %measured output
%CSTR.OutputGroup.UO = 0; %unmeasured output

%old_status = mpcverbosity('off');

Ts = 0.1;
MPCobj = mpc(CSTR,Ts);

display(MPCobj)

get(MPCobj)

MPCobj.PredictionHorizon = 20;

MPCobj.Model.Plant.OutputUnit = {'m','m', 'rad', 'm/s', 'm/s', 'rad/s'};

%MPCobj.MV.Min = [-700;-700];
%MPCobj.MV.Max = [700 700];
%MPCobj.MV.RateMin = -10;
%MPCobj.MV.RateMax = 10;

MPCobj.W.ManipulatedVariables = [1 1];
MPCobj.W.ManipulatedVariablesRate = [10 10];
MPCobj.W.OutputVariables = [1 1 0 0 0 0]*10^3;

review(MPCobj)

T = 200;
r = [0 0 0 0 0 0; 1 -2 0 0 0 0];
sim(MPCobj,T,r) %Linear simulation

[y,t,u] = sim(MPCobj,T,r);
% 
% figure
% subplot(2,1,1)
% plot(t,u)
% title('Inputs')
% legend('T_c')
% subplot(2,1,2)
% plot(t,y)
% title('Outputs')
% legend('T','C_A')
% xlabel('Time')
% 
% mpcverbosity(old_status);
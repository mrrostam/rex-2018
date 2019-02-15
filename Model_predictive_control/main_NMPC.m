clear

addpath('../Quadrotor_Model_2D');
nx = 6;
ny = 6;
nu = 2;
nlobj = nlmpc(nx, ny, nu);

Ts = 0.02;
nlobj.Ts = Ts;

nlobj.PredictionHorizon = 20;
nlobj.ControlHorizon = 20;

nlobj.Model.StateFcn = "quadrotor_model_2d";

nlobj.Model.IsContinuousTime = true;

nlobj.Model.NumberOfParameters = 0;

nlobj.Weights.OutputVariables = [1 1 1 0.01 0.01 0.01]*10^3;
nlobj.Weights.ManipulatedVariables = [1 1];
%nlobj.Weights.ManipulatedVariablesRate = [0.1 0.1];

nloptions = nlmpcmoveopt;
%nloptions.Parameters = {};


x = [0 0 0 0 0 0];
mv = [500, 500];

yref = [1 0 0 0 0 0];

Duration = 10;
hbar = waitbar(0,'Simulation Progress');

mvHistory = mv;

for i = 1:Duration/Ts

    [mv,nloptions,info] = nlmpcmove(nlobj,x(i,:),mv,yref,[],nloptions);
    
    x(i+1,:) = x(i,:) + transpose(Ts*quadrotor_model_2d(x(i,:), mv));
    
    waitbar(i*Ts/Duration,hbar);
    mvHistory = [mvHistory; mv'];
end
    close hbar
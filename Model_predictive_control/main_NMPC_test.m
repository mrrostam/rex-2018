nx = 1;
ny = 1;
nu = 1;
nlobj = nlmpc(nx, ny, nu);

Ts = 0.1;
nlobj.Ts = Ts;

nlobj.PredictionHorizon = 10;
nlobj.ControlHorizon = 5;

nlobj.Model.StateFcn = "quadrotor_model_2d_test";

nlobj.Model.IsContinuousTime = true;

nlobj.Model.NumberOfParameters = 0;

nlobj.Weights.OutputVariables = [1];
nlobj.Weights.ManipulatedVariablesRate = [0.1];
nlobj.Weights.ManipulatedVariables = [1];

nloptions = nlmpcmoveopt;
%nloptions.Parameters = {Ts};

x0 = [0];
mv = [0];
yref = [1];
% Compute optimal control moves
[mv,nloptions,info] = nlmpcmove(nlobj,x0,mv,yref,[]);
function q_dot = quadrotor_model_2d(q, u)

     g = 9.81; % gravitational acceleration
     m = 0.468; % mass
     L = 0.225; % distance between the rotor and the center of mass of the quadcopter
     k = 2.9e-6; % lift constant
     kd = 1e-8; % friction constant
     I = 4.856e-3;
      
     w_1 = u(1); %inputs (rotors' speed)
     w_2 = u(2);
     
     x = q(1); %position
     y = q(2);
     theta = q(3);
     
     x_dot = q(4); %velocity
     y_dot = q(5);
     theta_dot = q(6);

     TB1 = k*w_1^2; %Forces
     TB2 = k*w_2^2;
     FDx = -kd*x_dot;
     FDy = -kd*y_dot;
     Fg = -m*g;
     MT = L*k*(w_2^2-w_1^2);
     
     %Equations of motion
     x_dot_dot = 1/m*(TB1 + TB2)*sin(theta) + FDx; 
     y_dot_dot = 1/m*(TB1 + TB2)*cos(theta) + FDy + Fg;
     theta_dot_dot = L/I*(TB2 - TB1);
     
     q_dot(1:3) = [x_dot;y_dot;theta_dot];
     q_dot(4:6) = [x_dot_dot;y_dot_dot;theta_dot_dot];
     
     q_dot = q_dot';
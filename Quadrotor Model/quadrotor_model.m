function q_dot = quadrotor_model(q, t, u)

g = 9.81;
m = 0.468;
L = 0.225;
k = 2.9e-6;
b = 1.1e-7;
kd = 0;
I_xx = 4.856e-3;
I_yy = 4.856e-3;
I_zz = 8.8e-3;

I = [I_xx 0 0;
     0 I_yy 0;
     0 0 I_zz];
 
w_1 = u(1);
w_2 = u(2);
w_3 = u(3);
w_4 = u(4);

x = q(1);
y = q(2);
z = q(3);
phi = q(4);
theta = q(5);
psi = q(6);

x_dot = q(7);
y_dot = q(8);
z_dot = q(9);
phi_dot = q(10);
theta_dot = q(11);
psi_dot = q(12);

zeta = [x;y;z];
zeta_dot = [x_dot;y_dot;z_dot];

eta = [phi;theta;psi];
eta_dot = [phi_dot;theta_dot;psi_dot];

R = [cos(psi)*cos(theta) cos(psi)*sin(theta)*sin(phi)-sin(psi)*cos(phi) cos(psi)*sin(theta)*cos(phi)+sin(psi)*sin(phi);
     sin(psi)*cos(theta) sin(psi)*sin(theta)*sin(phi)+cos(psi)*cos(phi) sin(psi)*sin(theta)*cos(phi)-cos(psi)*sin(phi);
     -sin(theta)         cos(theta)*sin(phi)                            cos(theta)*cos(phi)                          ];

W_eta = [1 0 -sin(theta);
         0 cos(phi) cos(theta)*sin(phi);
         0 -sin(phi) cos(theta)*cos(phi)];
     
omega = W_eta*eta_dot;
 
Tb = k*[0;0;w_1^2 + w_2^2 + w_3^2 + w_4^2];
Fd = -kd*zeta_dot;
taub = [L * k * (w_1^2 - w_3^2)
        L * k * (w_2^2 - w_4^2)
        b * (w_1^2 - w_2^2 + w_3^2 - w_4^2)];

omega_dot_dot = inv(I) * (taub - cross(omega, I * omega));

zeta_dot_dot = 1/m*( [0;0;-m*g] + R*Tb + Fd );
eta_dot_dot = inv(W_eta)*omega_dot_dot;

q_dot(1:6) = [zeta_dot;eta_dot];
q_dot(7:12) = [zeta_dot_dot;eta_dot_dot];
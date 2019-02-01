%% MQP work for Rocket Controller
clc; clear all; close all;
% 
% syms u v w Fx Fy Fz m q1 q2 q3 q4 wx wy wz Mx My Mz Ixx Iyy Izz
% % define matrix groups
% q = [q1; q2; q3; q4];
% w0 = [wx ;wy; wz];
% M = [Mx; My; Mz];
% I = [Ixx 0 0; 0 Iyy 0; 0 0 Izz];
% H = [Ixx*wx; Iyy*wy; Izz*wz];
% % define matrix helper formulas
% w_x = [0 -wz wy; wz 0 -wx; -wy wx 0];
% O = [-w_x w0; -w0' 0];
% q_dot = .5*O*q;
% w_dot = I\(M-cross(w0,H));
% 
% x_dot = [u; v; w; Fx/m; Fy/m; Fz/m; q_dot; w_dot];
% disp(x_dot);
% 
% vars = [u; v; w; Fx; Fy; Fz; q1; q2; q3; q4; wx; wy; wz];
% J_x = jacobian(x_dot,vars);
% disp(J_x);

%% 

% DCM for velocity fixed to body fixed frame of reference
RvB = [[      1/(v^2/w^2 + 1)^(1/2), -v^2/(w*(v^2/w^2 + 1)^(1/2)*(u^2 + v^2 + w^2)^(1/2)), (v*(1 - v^2/(u^2 + v^2 + w^2))^(1/2))/(w*(v^2/w^2 + 1)^(1/2))];
       [                          0,                    (1 - v^2/(u^2 + v^2 + w^2))^(1/2),                                     v/(u^2 + v^2 + w^2)^(1/2)];
       [ -v/(w*(v^2/w^2 + 1)^(1/2)),     -v/((v^2/w^2 + 1)^(1/2)*(u^2 + v^2 + w^2)^(1/2)),         (1 - v^2/(u^2 + v^2 + w^2))^(1/2)/(v^2/w^2 + 1)^(1/2)]];






























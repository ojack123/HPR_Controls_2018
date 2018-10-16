function states_i_dot = EquationsOfMotion(t,states,thrust,tspan,rocket)
global rho g
[d,time_index] = min(abs(t-tspan));
thrust    = thrust(time_index); % Finds the thrust value corresponding to T

% External Forces (inertial frame)


% External Moments (inertial frame)


% Define states_i_dot as the solutions to the equations of motion


pos_i_dot    = states(4:6); % inertial position
vel_i_dot    = [0;0;(g*rocket.m)+thrust]; % inertial acceleration (transport theorerocket.m)
angPos_i_dot = zeros(4,1); % inertial angular velocity
angVel_i_dot = zeros(4,1); % inertial angular acceleration

states_i_dot = [pos_i_dot; vel_i_dot; angPos_i_dot; angVel_i_dot];










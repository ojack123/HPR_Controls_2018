clc; clear all; close all;

% Define parameters used throughout the simulation
global rho g
rho = 1.225;
g   = -9.8;
load('rocket.mat');
load('Thrust_Data.mat');

% ------------------------------------------------------------------------
% position     - 1:3 - x y z
% velocity     - 4:6 - u v w
% ang position - 7:10 - q1 q2 q3 q4
% ang velocity - 11:14

t = 0;               % initialize t 
states = zeros(1,14); % initialize state matrix

% User-defined initial states
states(7)  = 0.0001;
states(4)  = 1;

% User-defined time span and resolution
t0 = 0;
tf = 10;

nsteps   = 500; % Number of steps between t0 and tf
stepSize = 1/nsteps;
tspan0    = t0:stepSize:tf; % Time span created from defined step size

nip      = 100; % Number of integration points
statesIC = states;   % State array used inside the loop

% Re-map the thrust data
thrust_H130 = interp1(H130.time,H130.thrust,tspan0);
thrust_I170 = interp1(I170.time,I170.thrust,tspan0);
for i = 1:length(tspan0)
    if isnan(thrust_H130(i))
        thrust_H130(i) = 0;
    end
    if isnan(thrust_I170(i))
        thrust_I170(i) = 0;
    end
end

options = odeset('JConstant','on', 'RelTol',1e-6, 'AbsTol',1e-6);
for i = 1:nsteps  
    t1 = tf*(i-1)/nsteps;
    t2 = tf*i/nsteps;
    tspan = t1:(t2-t1)/nip:t2;
    thrust = interp1(tspan0,thrust_H130,tspan,'spline');
    
    %statesIC(:,15) = thrust;
    [tNew,tempStates] = ode45(@(tNew,statesIC) EquationsOfMotion(tNew,statesIC,thrust,tspan,rocket),...
                               tspan,statesIC,options);
                           
    t(i) = t2;
    statesIC = tempStates(nip+1,1:14)';
    statesNew(i,:) = statesIC';
    
    disp((i*100)/nsteps); % display percent completion
end

states = statesNew;
% Animate the resulting state array
ax = axes('XLim',[-100 100],'YLim',[-100 100],'ZLim',[0 max(states(:,3))]);
whitebg([0 .5 .6])
AnimateRocket(t,stepSize,states,ax,rocket);
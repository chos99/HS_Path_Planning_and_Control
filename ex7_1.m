%%
% Author: Aaron Kiani, Heiko Wascheck
% Last changes: Nov 06, 2023
close all;
clear all;

%% 
% Inputs:
vmax = 0.5;     % [m/s] the maximum speed v* as parameter vmax
x0 = 0;         % [m]   the starting position x0 as parameter x0
xs = 1;         % [m]   the arc length to be driven x* as parameter xs
% Outputs:
%   - cff:          Polynomial coefficients u_vp1
%   - y_p(t)        y_p = x, where x is the driven arc length of the rear axle midpoint.
%   - w_p_dot(t)
%   - w_p_dot_dot(t)

% Define parameters
kp = 1;
kr = 0.344014;
k = 2.51; 
Ti = 0.2468;
T = 316e-3; 
Tt = 0.1; 
TA = 0.02;  % Sampling time

% Previous transfer function of the control loop
numerator = [Ti 1];
denominator = [(Ti*T*Tt)/(kp*kr*k) (Ti*(T+Tt))/(kp*kr*k) Ti/kp*(1 + 1/(kr*k)) (1/kp + Ti) 1];
G_wp = tf(numerator, denominator);

%% Task 7.4.1 e)
[c, te] = cd_refpoly_vmax(vmax, x0, xs)

% Define simulation time
% from zero to te with sampling time
t = 0:TA:te;

cff = cd_refpoly_ff(c, k, T, Tt, kr, Ti)  % is k = P_p_k --> yes

% Generation of the polynomial w_p from the coefficients
w_p = polyval(c, t);

% Simulate system response
[y_p, t_out] = lsim(G_wp, w_p, t);


% Calculation of the first derivative of w_p
c_dot = polyder(c);
w_p_dot = polyval(c_dot, t);

% Calculation of the second derivative of w_p
c_dot_dot = polyder(c_dot);
w_p_dot_dot = polyval(c_dot_dot, t);


% Calculation of uvp1 using the cd_refpoly_ff.m function
uvp1 = polyval(cff, t);


%% Task 7.4.1. f)
s = tf('s');
% Open loop transfer function
GS = (k * exp((-s * Tt))) / (1 + T * s);
GR = kr * (1 + (1/(Ti * s)));
G0 = GR * GS;
Gw = feedback(G0, 1);

G_vp1_s = tf([1, 0], [Ti, 1]);
G_vp1_z = c2d(G_vp1_s, TA, 'tustin')

yp = lsim(minreal(G_vp1_s * Gw / s), uvp1, t);

uvp = lsim(G_vp1_z, uvp1, t, 0);


%% Create a window for subplots
figure;

% Subplot for ramp response of the cascaded control loop
subplot(2, 3, 1);
plot(t_out, w_p, 'r', t_out, y_p, 'b--');
xlabel('Time (s)');
ylabel('Amplitude');
title('Comparison without feedforward w_p and y_p');
legend('w_p(t)', 'y_p(t)');
grid on;

% Subplot for w_p_dot
subplot(2, 3, 2);
plot(t, w_p_dot, 'r');
xlabel('Time (s)');
ylabel('w_p_dot');
title('w_p*');
grid on;

% Subplot for w_p_dot_dot
subplot(2, 3, 3);
plot(t, w_p_dot_dot, 'r');
xlabel('Time (s)');
ylabel('Amplitude');
title('w_p**');
grid on;

% Subplot for uvp1
subplot(2, 3, 4);
plot(t, uvp1);
xlabel('Time (s)');
ylabel('Amplitude');
title('uvp1');
grid on;

% Subplot for uvp1
subplot(2, 3, 5);
plot(t, uvp);
xlabel('Time (s)');
ylabel('Amplitude');
title('uvp');
grid on;

% Subplot for comparison with feedforward w_p and y_p
subplot(2, 3, 6);
plot(t, w_p, 'r', t, yp, 'b');
xlabel('Time (s)');
ylabel('Amplitude');
title('Comparison with feedforward w_p and y_p');
legend('w_p(t)', 'y_p(t)');
grid on;


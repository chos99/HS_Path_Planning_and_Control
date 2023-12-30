close all;
clear all;

%% Calculation of Ti
% Given parameters
Tm = 1000e-3; % in seconds
omega_D = pi / Tm;
Tt = 0.1;
T = 0.316; 
phi_Res_deg = 65; % Phase margin in degrees
phi_Res_rad = deg2rad(phi_Res_deg); % Phase margin in radians

% Function for the total phase
G0_phase = @(Ti) -atan(omega_D * T) - omega_D * Tt - atan(1 / (omega_D * Ti));

% Solving the equation for Ti
Ti = fzero(@(Ti) G0_phase(Ti) + pi - phi_Res_rad, 1); % Initial guess is 1

% Output of the result
fprintf('The calculated value for Ti is: %f seconds\n', Ti);

% Calculation of kr
ku = 2.51; % Gain
Tm = 1000e-3;
omega_D = pi / Tm; % Crossover frequency % in seconds

% Calculation of kr
kr = (sqrt(1 + (omega_D * T)^2)) / (ku * sqrt(1 + (1 / (-omega_D * T))^2));

% Output of the result
fprintf('The calculated value for kr is: %f\n', kr);

% b) Check results with margin()
% Definition of the controller transfer function GR(s)
s = tf('s');
GR = kr * (1 + (1/(Ti * s)));
GS = (ku * exp((-s * Tt))) / (1 + T * s);

% Open-loop transfer function G0(s)
G0 = GR * GS;
[gainMargin, phaseMargin, gainCrossOverFrequency, phaseCrossOverFrequency] = margin(G0);

fprintf('Phase margin: %f degrees\n', phaseMargin);
fprintf('Gain margin: %f\n', gainMargin);
fprintf('Check: Phase crossover frequency: %f rad/s\n', phaseCrossOverFrequency);

% Creation of the Bode plot with marked margins
figure;
margin(G0);
grid on;

% c) step()
% Transfer function of the closed-loop control system Gw(s)
Gw = feedback(G0, 1);

% Plotting the step response
figure;
step(Gw);
grid on;

% Calculation of overshoot and settling time
S = stepinfo(Gw);

fprintf('Overshoot:   %f\n', S.Overshoot);
fprintf('Settling time: %f s\n', S.SettlingTime);

% d) Discrete-time Control
TA = 0.02;  % Sampling time

tf_P = kr;

num_I = [kr];
denum_I = [Ti 0];

tf_I_cont = tf(num_I, denum_I)
tf_I_dis = c2d(tf_I_cont, TA, 'tustin')

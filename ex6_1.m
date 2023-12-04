%%
% Author: Kiani Aaron, Wascheck Heiko
% Last changes: 06.Nov.23
close all;

%%
% This file is for nessusary for the exercise 6.1
% Required lab results:

%• mathematical expressions and values of 𝑇_𝑖 and 𝑘_𝑟
%• Bode diagram of 𝐺_0 including margins
%• signal-time-diagram of step response of 𝐺_𝑤
%• transfer function 𝐺_𝑅(𝑧) of discrete-time PI controller
%• differences equations to compute I part 𝑢_𝑖𝑘 = 𝑢_𝑖(𝑘* 𝑇_𝐴) and
%   total manipulation signal 𝑢_𝑘 = 𝑢(k* 𝑇_𝐴) from control deviation 𝑒_𝑘 = 𝑤_𝑘 - 𝑦_k
%• MATLAB script of b. and c. named ex6_1.m
%%
%%
%• mathematical expressions and values of 𝑇_𝑖 and 𝑘_r

% gegeb Ti, 

% Tm = 1000e-3; % close-loop time constant [ s ]
% omega = pi / Tm;
% ts = 0.02;
% numerator = [ts];
% denominator = [2 4];
% 
% sys_DSP = filt(sys_z.numerator, sys_z.denominator, Ts)


%% Heikos Idee:
%inputs:
vmax = 0.5;     % [m/s] die maximale Geschwindigkeit 𝑣∗ als Parameter vmax
x0 = 0;         % [m]   die Startposition 𝑥0 als Parameter x0
xs = 1;         % [m]   die zu fahrende Bogenlänge 𝑥∗ als Parameter xs
%outputs:
%   - cff:          Polynomialkoeffizienten u_vp1
%   - y_p(t)    	𝑦_𝑝 = 𝑥, wobei 𝑥 die gefahrene Bogenlängedes Hinterachsmittelpunkts ist.
%   - w_p_dot(t)
%   - w_p_dot_dot(t)

% Parameter definieren
kp = 1;
kr = 0.344014;
ku = P_p_k; 
Ti = 0.246830;
T = P_p_T; 
Tt = P_p_Tt; 
 


[c, te] = cd_refpoly_vmax(vmax, x0, xs)

% Simulationszeit definieren
t = 0:0.05:te; % 10 Sekunden lang von 0 bis 10 mit 0.01 Sekunden Schritten

cff = cd_refpoly_ff(c, ku, T, Tt, kr, Ti);  % ist k = P_p_k??? Fragen!


w_p = polyval(cff,t);
%w_p_dot = polyder(w_p);
%w_p_dot_dot = polyder(w_p_dot);


% Übertragungsfunktion definieren für Speed Controller und 1/s block = Positions Regler 
numerator = [Ti 1];
denominator = [(Ti*T*Tt)/(kp*kr*ku) (Ti*(T+Tt))/(kp*kr*ku) Ti/kp*(1 + 1/(kr*ku)) (1/kp + Ti) 1];
G_wp = tf(numerator, denominator);

% Systemantwort simulieren
[y_p, t_out] = lsim(G_wp, w_p, t);

%Grafische Darstellung der Ergebnisse
figure;
plot(t_out, w_p, 'r', t_out, y_p, 'b--');
xlabel('Zeit (s)');
ylabel('Amplitude');
title('Rampenantwort des kaskadierten Regelkreises');
legend('w_p(t)', 'y_p(t)');
grid on;


% w_p_dot(te/2) = vmax 
% oder 
% w_p_dot(te/2) = (15*xs)/8*te 
% w_p_dot_dot(t) ???? 








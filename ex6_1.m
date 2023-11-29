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
%   - y_p(t)
%   - w_p_dot(t)
%   - w_p_dot_dot(t)

[c, te] = cd_refpoly_vmax(vmax, x0, xs);
cff = cd_refpoly_ff(c,k,P_p_T,P_p_Tt,kr,Ti); 


% w_p_dot(te/2) = vmax 
% oder 
% w_p_dot(te/2) = (15*xs)/8*te 
% w_p_dot_dot(t) ???? 

% polyder(p): ableitung von p 
w_p_dot_dot = polyder(w_p_dot); % stimmt so aber nicht zu 100%, muss noch raus in die richtige vorm gebracht werden... 
% ... bsp.: x^3 + 2x^2 - 5x +9 -> w_p_dot=[1 2 -5 9] 

% Definition lsim(sys,u,t)  sys: Systemantwort, u; eingangssignal, t: zeit
y_p = lsim()


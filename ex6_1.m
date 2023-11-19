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

Ta = 0.02;
Ti = 0.5
kr = 0.2
z = tf('z',Ta)

sys = (kr *Ta * z) / (Ti*z -Ti )
%
% Mini-Auto-Drive
%
% System Parameters
%
% Copyright (c) 2020 Frank Traenkle
% http://www.modbas.de
%
% This file is part of Mini-Auto-Drive.
%
% Mini-Auto-Drive is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
%
% Mini-Auto-Drive is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with Mini-Auto-Drive.  If not, see <http://www.gnu.org/licenses/>.


%% Clear workspace
clear all;

%% Global Variables
global P_dt P_display_dt;

%% Car and Belt Configuration
p_mad_car;

%% Sample Times
P_dt = 20e-3; % sample time of controller
P_sim_dt = 2e-3; % sample time of simulation
P_display_dt = 40e-3; % sample time of display

%% EKF e6
%e6_data;

%% Speed Controller
%% TODO
% Gegebene Parameter
Tm = 1000e-3; % in Sekunden
omega_D = pi / Tm;
Tt = 0.1;
T = 0.316; 
phi_Res_deg = 65; % Phasenreserve in Grad
phi_Res_rad = deg2rad(phi_Res_deg); % Phasenreserve in Radian

%% Berechnung von Ti
% Funktion für die Gesamtphase 
G0_phase = @(Ti) -atan(omega_D * T) - omega_D * Tt - atan(1 / (omega_D * Ti));

% Lösen der Gleichung für Ti
Ti = fzero(@(Ti) G0_phase(Ti) + pi - phi_Res_rad, 1); % Startwert ist 1

% Ausgabe des Ergebnisses
fprintf('Der berechnete Wert für Ti ist: %f Sekunden\n', Ti);

%% Berechnung von kr
ku = 2.51; % Verstärkung 
Tm = 1000e-3;
omega_D = pi / Tm; % Durchtrittsfrequenz % in Sekunden

% Berechnung von kr
kr = (sqrt(1 + (omega_D * T)^2)) / (ku * sqrt(1 + (1 / (-omega_D * T))^2));

% Ausgabe des Ergebnisses
fprintf('Der berechnete Wert für kr ist: %f\n', kr);

% Berechnung G_RP --> Verstärkung kp vom äußeren RK
P_cx_k = 1;


%% Zuweisung der errechneten Werte
P_p_kr = 0.344014;
P_p_Ti = 0.246830;
P_p_TA = 0.02;

%% Lateral Controller
%% TODO
P_p_Tw = 0.3;

%% Create Race Track
% a1total = 2.7; % total surface width [ m ]
% a2total = 1.8; % total surface height [ m ]
% a1boundary = 0.05; % margin [ m ]
% a2boundary = 0.05; % margin [ m ]
% a1 = a1total - 2 * a1boundary; % total surface width [ m ]
% a2 = a2total - 2 * a2boundary; % total surface height [ m ]
% P_width = 0.25 * a2; % track P_width [ m ]
% 
% track = mbc_track_create(a1boundary + P_width, a2boundary + 0.5 * P_width, 0);
% track = mbc_straight_create(track, a1 - 2 * P_width, P_width);
% track = mbc_circle_create(track, 0.5 * P_width, pi, P_width);
% track = mbc_straight_create(track, a1 - 3 * P_width, P_width);
% track = mbc_circle_create(track, 0.5 * P_width, -pi, P_width);
% track = mbc_straight_create(track, a1 - 3 * P_width, P_width);
% track = mbc_circle_create(track, 0.5 * P_width, pi, P_width);
% track = mbc_straight_create(track, a1 - 2 * P_width, P_width);
% track = mbc_circle_create(track, 0.5 * P_width, 0.5 * pi, P_width);
% track = mbc_straight_create(track, a2 - 2 * P_width, P_width);
% track = mbc_circle_create(track, 0.5 * P_width, 0.5 * pi, P_width);
% track = mbc_track_display(track, 0.1, [ 0 a1total 0 a2total ]);
% path = track.center;

%% Exercise 8.3.2. Create Race Track according to Abbildung 84
a1total = 2.7; % total surface width [ m ]
a2total = 1.8; % total surface height [ m ]
a1boundary = 0.05; % margin [ m ]
a2boundary = 0.05; % margin [ m ]
a1 = a1total - 2 * a1boundary; % total surface width [ m ]
a2 = a2total - 2 * a2boundary; % total surface height [ m ]
P_width = 0.2; % track P_width [ m ]
a = 8;

track = mbc_track_create(0.15, 0.9, -pi/2);
track = mbc_straight_create(track, (a2 - 2 * P_width)/2 - 0.43, P_width);
turn = 1;   % Linkskurve
track = mbc_clothoid_create(track, a, turn * pi / 4, P_width, 0);
track = mbc_clothoid_create(track, a, turn * pi / 4, P_width, 1);
track = mbc_straight_create(track, a1 - 2 * P_width -0.855, P_width);
track = mbc_clothoid_create(track, a, turn * pi / 4, P_width, 0);
track = mbc_clothoid_create(track, a, turn * pi / 4, P_width, 1);
track = mbc_straight_create(track, a2 - 2 * P_width - 0.86, P_width);
track = mbc_clothoid_create(track, a, turn * pi / 4, P_width, 0);
track = mbc_clothoid_create(track, a, turn * pi / 4, P_width, 1);
track = mbc_straight_create(track, a1 - 2 * P_width -0.855, P_width); 
track = mbc_clothoid_create(track, a, turn * pi / 4, P_width, 0);
track = mbc_clothoid_create(track, a, turn * pi / 4, P_width, 1);
track = mbc_straight_create(track, (a2 - 2 * P_width)/2 - 0.43, P_width);
track = mbc_track_display(track, 0.1, [ 0 a1total 0 a2total ]);
path = track.center;


%% Path for Lap Statistics
lappath = track.center;
P_lap_breakslen = uint32(length(lappath.points));
P_lap_points = zeros(SPLINE.Elements(2).Dimensions); 
P_lap_points(:,1:length(lappath.points)) = lappath.points;
P_lap_coefs = zeros(SPLINE.Elements(3).Dimensions);
P_lap_coefs(1:length(lappath.pp.coefs),:) = lappath.pp.coefs;
P_lap_segments = uint32(zeros(SPLINE.Elements(4).Dimensions)); 

%% Workspace variables for reference track generation in Simulink
P_w_breakslen = uint32(length(path.points));
P_w_points = zeros(SPLINE.Elements(2).Dimensions); 
P_w_points(:,1:length(path.points)) = path.points;
P_w_coefs = zeros(SPLINE.Elements(3).Dimensions);
P_w_coefs(1:length(path.pp.coefs),:) = path.pp.coefs;
P_w_segments = uint32(zeros(SPLINE.Elements(4).Dimensions)); 

% Init car display
mbc_car_display(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

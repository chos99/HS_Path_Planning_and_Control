%%
% Author: Kiani Aaron, Wascheck Heiko
% Last changes: 06.Nov.23
close all;
clear all;

%% 
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
k = 2.51; 
Ti = 0.2468;
T = 316e-3; 
Tt = 0.1; 
TA = 0.02;  % Abtastzeit

% Bisherige Übertragungsfunktion des Regelkreises
numerator = [Ti 1];
denominator = [(Ti*T*Tt)/(kp*kr*k) (Ti*(T+Tt))/(kp*kr*k) Ti/kp*(1 + 1/(kr*k)) (1/kp + Ti) 1];
G_wp = tf(numerator, denominator);

%% Aufgabe 7.4.1 e)
[c, te] = cd_refpoly_vmax(vmax, x0, xs)

% Simulationszeit definieren
% von null bis te mit Abtastzeit
t = 0:TA:te;

cff = cd_refpoly_ff(c, k, T, Tt, kr, Ti)  % ist k = P_p_k --> ja

% Erzeugung des Polynoms w_p aus den Koeffizienten
w_p = polyval(c, t);

% Systemantwort simulieren
[y_p, t_out] = lsim(G_wp, w_p, t);


% Berechnung der ersten Ableitung von w_p
c_dot = polyder(c);
w_p_dot = polyval(c_dot, t);

% Berechnung der zweiten Ableitung von w_p
c_dot_dot = polyder(c_dot);
w_p_dot_dot = polyval(c_dot_dot, t);


% Berechnung von uvp1 durch Verwendung der cd_refpoly_ff.m Funktion
uvp1 = polyval(cff, t);


%% Aufgabe 7.4.1. f)
s = tf('s');
% Offene Übertragungsfunktion
GS = (k * exp((-s * Tt))) / (1 + T * s);
GR = kr * (1 + (1/(Ti * s)));
G0 = GR * GS;
Gw = feedback(G0, 1);

G_vp1_s = tf([1, 0], [Ti, 1]);
G_vp1_z = c2d(G_vp1_s, TA, 'tustin')

yp = lsim(minreal(G_vp1_s * Gw / s), uvp1, t);

uvp = lsim(G_vp1_z, uvp1, t, 0);


%% Erstellen eines Fensters für Subplots
figure;

% Subplot für Rampenantwort des kaskadierten Regelkreises
subplot(2, 3, 1);
plot(t_out, w_p, 'r', t_out, y_p, 'b--');
xlabel('Zeit (s)');
ylabel('Amplitude');
title('Vergleich ohne Vorsteuerung w_p und y_p');
legend('w_p(t)', 'y_p(t)');
grid on;

% Subplot für w_p_dot
subplot(2, 3, 2);
plot(t, w_p_dot, 'r');
xlabel('Zeit (s)');
ylabel('w_p_dot');
title('w_p*');
grid on;

% Subplot für w_p_dot_dot
subplot(2, 3, 3);
plot(t, w_p_dot_dot, 'r');
xlabel('Zeit (s)');
ylabel('Amplitude');
title('w_p**');
grid on;

% Subplot für uvp1
subplot(2, 3, 4);
plot(t, uvp1);
xlabel('Zeit (s)');
ylabel('Amplitude');
title('uvp1');
grid on;

% Subplot für uvp1
subplot(2, 3, 5);
plot(t, uvp);
xlabel('Zeit (s)');
ylabel('Amplitude');
title('uvp');
grid on;

% Subplot für Vergleich mit Vorsteuerung w_p und y_p
subplot(2, 3, 6);
plot(t, w_p, 'r', t, yp, 'b');
xlabel('Zeit (s)');
ylabel('Amplitude');
title('Vergleich mit Vorsteuerung w_p und y_p');
legend('w_p(t)', 'y_p(t)');
grid on;



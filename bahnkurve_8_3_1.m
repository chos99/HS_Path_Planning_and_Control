%% Aufgabe 8.1 Gerade Bahnkurve
%% a)
% Startbedingungen
%s_0 = [0, 0]';
%psi_0 = 0;
close all;
syms s_01 s_02 psi_0

psi_0 = deg2rad(90);
s_01 = 1; s_02 = 1;
x = 5;

% Erst rotieren der Bogenstrecke um psi
rotZ = [cos(psi_0) -sin(psi_0) 0;
        sin(psi_0), cos(psi_0) 0;
        0         ,         0, 1];
x_vector = [x; 0; 0];
x_vector_rot = rotZ * x_vector;

% dann verschieben um s
x_vector_rot_trans = x_vector_rot + [s_01; s_02; 0];

figure;
plot(x_vector(1), x_vector(2), 'ro')
grid on;
hold on;
plot(x_vector_rot_trans(1), x_vector_rot_trans(2), 'bo')

%% b)
% Tangentialvektor: bei Gerader ist Tangentialvektor im Grunde dasselbe
tangential_vector_norm = x_vector_rot_trans / norm(x_vector_rot_trans); % normalisiert

% Normalvektor: steht senkrecht auf Vektor bei Bogenlänge x
u = [0; 0; 1];  % Vektor wählen, der nicht parallel zur Tangente ist

% Das Kreuzprodukt von Tangente und u ergibt einen Normalvektor
normal_vector = cross(tangential_vector_norm, u);

% Krümmung = 0 wegen gerader Bahnkurve





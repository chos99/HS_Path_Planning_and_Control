function [c, te] = cd_refpoly_vmax(vmax, x0, xs)
% Inputs:
%   - vmax: die maximale Geschwindigkeit 𝑣∗ als Parameter vmax
%   - x0:   die Startposition 𝑥0 als Parameter x0
%   - xs:   die zu fahrende Bogenlänge 𝑥∗ als Parameter xs
% Outputs.
%   - c:    ein Zeilenvektor c, der die Polynomialkoeffizienten 𝑐𝑐5, 𝑐𝑐4, … , 𝑐𝑐0 enthält,
%   - te:   die Zeit te, bei welcher das Führungssignal 𝑤𝑝(𝑡e) = 𝑥0 + 𝑥∗ ist.

te = 15*xs / (8*vmax);
%c = [x0; 0; 0; (10*xs)/(te^3); -(15*xs)/(te^4); (6*xs)/(te^5)];
c = [(6*xs)/(te^5);-(15*xs)/(te^4);(10*xs)/(te^3); 0; 0; x0];
end
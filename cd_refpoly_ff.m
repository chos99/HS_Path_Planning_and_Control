function cff = cd_refpoly_ff(c,k,P_p_T,P_p_Tt,kr,Ti)
% Inputs:
%   - c:            Polynomialkoeffizienten --> aus funktion "cd_refpoly_vmax.m"
%   -               𝑘
%   - P_p_T:        𝑇
%   - P_p_Tt:       𝑇𝑡    
%   - kr            𝑘𝑟  --> aus funktion "s6_data.m"
%   - Ti            𝑇𝑖  --> aus funktion "s6_data.m" 
%   wobei k, T, Tt, kr, Ti aus der Regelstrecke und des Geschwindigkeitsreglers kommen
% Outputs.
%   - cff:  𝑢_V1(𝑡) Polynomialkoeffizienten

% WIE BEKOMMEN WIR HIER DIE ZEIT t REIN? => IDEE: DA DIE MATLABFUNKTION IN
% EIN SIMULINK BLOCK GEHT; EINFACH CLOCK ALS INPUT ADDEN; MEINUNG?
% Simulationszeit definieren


% cff = (c(6).*t.^5) + (c(5)+5*Ti*c(6)* ((1/(k*kr))+1) ).*t.^4 + ...
%     (c(4) + 4*Ti*c(5)* ((1/(k*kr))+1) + (20*Ti*c(6) * (P_p_T+P_p_Tt))/ (k*kr) ) *t.^3 + ...
%     (c(3) + 3*Ti*c(4)* ((1/(k*kr))+1) + (12*Ti*c(5) * (P_p_T+P_p_Tt))/ (k*kr) + (60*P_p_T* Ti* P_p_Tt*c(6)) / (k*kr) ) .* t.^2 + ...
%     (c(2) + 2*Ti*c(3)* ((1/(k*kr))+1) + ( 6*Ti*c(4) * (P_p_T+P_p_Tt))/ (k*kr) + (24*P_p_T* Ti* P_p_Tt*c(5)) / (k*kr) ) .* t + ...
%     c(1) + Ti*c(2)* ((1/(k*kr))+1)    + ( 2*Ti*c(3) * (P_p_T+P_p_Tt))/ (k*kr) + ( 6*P_p_T* Ti* P_p_Tt*c(4)) / (k*kr);


cff = [c(6);
     (c(5)+5*Ti*c(6)* ((1/(k*kr))+1) );
     (c(4) + 4*Ti*c(5)* ((1/(k*kr))+1) + (20*Ti*c(6) * (P_p_T+P_p_Tt))/ (k*kr));
     (c(3) + 3*Ti*c(4)* ((1/(k*kr))+1) + (12*Ti*c(5) * (P_p_T+P_p_Tt))/ (k*kr) + (60*P_p_T* Ti* P_p_Tt*c(6)) / (k*kr) );
     (c(2) + 2*Ti*c(3)* ((1/(k*kr))+1) + ( 6*Ti*c(4) * (P_p_T+P_p_Tt))/ (k*kr) + (24*P_p_T* Ti* P_p_Tt*c(5)) / (k*kr) );
     c(1) + Ti*c(2)* ((1/(k*kr))+1)    + ( 2*Ti*c(3) * (P_p_T+P_p_Tt))/ (k*kr) + ( 6*P_p_T* Ti* P_p_Tt*c(4)) / (k*kr)]
end
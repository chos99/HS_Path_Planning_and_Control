function cff = cd_refpoly_ff(c,k,P_p_T,P_p_Tt,kr,Ti)
% Inputs:
%   - c:            Polynomialkoeffizienten --> aus funktion "cd_refpoly_vmax.m"
%   -               𝑘
%   - P_p_T:        𝑇
%   - P_p_Tt:       𝑇𝑡    
%   - kr            𝑘𝑟  --> aus funktion "s6_data.m"
%   - Ti            𝑇𝑖  --> aus funktion "s6_data.m" !!! WIR HABEN T_i IN LONGITUDINAL_7_4 VERWENDET UND IN DER s6_data ABER MIT Ti   !!!!!!
%   wobei k, T, Tt, kr, Ti aus der Regelstrecke und des Geschwindigkeitsreglers kommen
% Outputs.
%   - cff:  𝑢_V1(𝑡) Polynomialkoeffizienten

% WIE BEKOMMEN WIR HIER DIE ZEIT t REIN? => IDEE: DA DIE MATLABFUNKTION IN
% EIN SIMULINK BLOCK GEHT; EINFACH CLOCK ALS INPUT ADDEN; MEINUNG?

cff = c(5)*t^5 +( c(4)+5*Ti*c(5)* ((1/k*kr)+1) )*t^4 + ...
    (c(3) + 4*Ti*c(4)* ((1/k*kr)+1) + (20*Ti*c(5) * (P_p_T+P_p_Tt))/ (k*kr) ) *t^3 + ...
    (c(2) + 3*Ti*c(3)* ((1/k*kr)+1) + (12*Ti*c(4) * (P_p_T+P_p_Tt))/ (k*kr) + (60*P_p_T* Ti* P_p_T*c(5)) / (k*kr) ) * t^2 + ...
    (c(1) + 2*Ti*c(2)* ((1/k*kr)+1) + ( 6*Ti*c(3) * (P_p_T+P_p_Tt))/ (k*kr) + (24*P_p_T* Ti* P_p_T*c(4)) / (k*kr) ) * t + ...
    c(0) + Ti*c(1)* ((1/k*kr)+1)    + ( 2*Ti*c(2) * (P_p_T+P_p_Tt))/ (k*kr) + ( 6*P_p_T* Ti* P_p_T*c(3)) / (k*kr)
end
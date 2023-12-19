function  track =  mbc_clothoid_create(track, a, rad, w, opening)
% track = mbc_clothoid_create(track, r, rad, w) adds a clothoid arc 
% as a new segment to track
% 
%   track - existing track created by mbc_track_create.
%           The return value track contains the original track plus
%           the new segment.
%   a   - specifies the shape of the clothoid, the higher it is, the
%   stepper the curve
%   rad - arc length [ rad ]
%   w - track width [ m ]
%   opening - if the clothid opens or closes [0 or 1]

%   If rad > 0 then mbc_clothoid_create creates a left turn.
%   If rad < 0 then mbc_clothoid_create creates a right turn.
%
% MODBAS CAR mbc
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

cnt = mbc_track_get_cnt(track);
p = track.points{cnt+1};

% Berechnung obere Integrationsgrenze, an welcher Bogenlänge erreicht ist
tau = abs(rad);
xe = sqrt(tau*2*a^2); % path length (siehe Formel https://www.frassek.org/2d-mathe/klothoide-cornu-spirale/)
xe = sqrt(2*abs(rad) / a);

% Aufstellen der Gleichungen abhängig von opening
a = a * sign(rad);  
if opening == 1

    s1_func = @(x) cos(-a/2 * x.^2 + a*xe.*x + p.psi);
    s2_func = @(x) sin(-a/2 * x.^2 + a*xe.*x + p.psi);
else
    s1_func = @(x) cos(a/2 * x.^2 + p.psi);
    s2_func = @(x) sin(a/2 * x.^2 + p.psi);
end

% Berechnung Fresnel-Integral
s1_integ = integral(s1_func, 0, xe);    % Start: p.x
s2_integ = integral(s2_func, 0, xe);    % Start: p.x

s1 = s1_integ + p.s1;
s2 = s2_integ + p.s2;

track.points{cnt+2} = ...
    struct('s1', s1, ...
    's2', s2, ...
    'psi', p.psi + rad, ...
    'x', p.x + abs(xe));
track.tracks{cnt+1} = struct('type', 'clothoid', ...
    'a', a, 'opening', opening, 'xe', xe, 'w', w);

%mbc_clothoid_plot(a, xe, w, opening);
end


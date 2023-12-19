function points = mbc_clothoid_get_points(track, idx, xstart, dx, alpha)
% points = mbc_clothoid_get_points(track, idx, xstart, dx, alpha)
% computes the accurate line points on the track segment.
%
%   track - track object
%   idx - the index of the track segment
%   xstart - the arc length of the segment start positon [ m ]
%   dx - the arc distance of two neighbor points [ m ]
%   alpha - the line position on the road [ 0 ; 1 ]
%   points - the points as a 3 x n matrix
%
%   points(1, :) is the arc length at each point
%   points(2, :) is the s1 position
%   points(3, :) is the s2 position
%
%   If alpha == 0 then the right line points are generated.
%   If alpha == 0.5 then the center line points are generated.
%   If alpha == 1 then the left line points are generated.
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

if nargin < 4
    alpha = 0.5; % return center line points
end
p = track.points{idx};
t = track.tracks{idx};

% r = t.r - sign(t.xe) * (alpha - 0.5) * t.w;

idx = 0:floor((abs(t.xe) - (xstart - p.x) + mbc_cmp_eps)/dx);
x = (xstart - p.x) + dx * idx;

% Aufstellen der Gleichungen abhängig von opening
a = t.a;  % Links- oder Rechtskurve ACHTUNG: WIR WISSEN NICHT ob - links oder rechts ist!!!!!!
xe = t.xe;
if t.opening == 1
    s1_func = @(x) cos(-a/2 * x.^2 + a*xe.*x + p.psi);
    s2_func = @(x) sin(-a/2 * x.^2 + a*xe.*x + p.psi);
else
    s1_func = @(x) cos(a/2 * x.^2 + p.psi);
    s2_func = @(x) sin(a/2 * x.^2 + p.psi);
end


s1_integ = zeros(size(x));
s2_integ = zeros(size(x));

for i = 1:length(x)
    s1_integ(i) = integral(s1_func, xstart, xstart +x(i));
    s2_integ(i) = integral(s2_func, xstart, xstart +x(i));
end

s1 = s1_integ + p.s1;
s2 = s2_integ + p.s2;

points = [ p.x + x ; ...
    s1; ...
    s2];
end


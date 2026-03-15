function decoded_dir = decode_direction(responses, pref_dirs)
% DECODE_DIRECTION Decode stimulus direction using the population vector method.
%
%   decoded_dir = decode_direction(responses, pref_dirs)
%
%   Uses the population vector approach: each neuron "votes" for its
%   preferred direction, weighted by its firing rate. The sum of all
%   votes gives a vector that points toward the decoded direction.
%
%   Inputs:
%       responses  - 1 x N vector of firing rates (one per neuron)
%       pref_dirs  - 1 x N vector of preferred directions in degrees
%
%   Output:
%       decoded_dir - decoded stimulus direction in degrees (-180 to 180)
%                     Use mod(decoded_dir, 360) to get 0-360 range
%
%   Example:
%       pref_dirs = [0 45 90 135 180 225 270 315];
%       responses = [10 20 25 15 5 3 8 12];
%       decoded = decode_direction(responses, pref_dirs);
%       fprintf('Decoded direction: %.1f degrees\n', mod(decoded, 360));
%
%   Reference: Georgopoulos et al. (1986) population vector method

% Compute the population vector components
% Each neuron contributes a vector pointing in its preferred direction,
% scaled by its firing rate
pop_vec_x = sum(responses .* cosd(pref_dirs));
pop_vec_y = sum(responses .* sind(pref_dirs));

% The decoded direction is the angle of the population vector
decoded_dir = atan2d(pop_vec_y, pop_vec_x);

end

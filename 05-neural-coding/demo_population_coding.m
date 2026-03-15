% MODULE 05: NEURAL CODING -- Population Coding and Decoding
% 8 neurons encode a movement direction. Can we decode it?
%
% Part of the Matlab for Computational Neuroscience course
% Module 05: Neural Coding
%
% What you'll see when you run this:
%   Figure 1: Population activity heatmap for one stimulus direction
%   Figure 2: Population vector showing decoded direction
%   Figure 3: Decoded vs actual direction for many stimuli

clear; clc; close all;
rng(42);

%% 1. Create a Population of 8 Neurons
% Each neuron has a different preferred direction, evenly spaced.

n_neurons = 8;
pref_dirs = linspace(0, 315, n_neurons);  % 0, 45, 90, ..., 315 degrees
baseline = 10;   % baseline firing rate (Hz)
gain = 15;       % modulation depth (Hz)
noise_std = 3;   % noise level (Hz)

fprintf('--- Population of %d Neurons ---\n', n_neurons);
fprintf('Preferred directions: ');
fprintf('%d ', pref_dirs);
fprintf('degrees\n');
fprintf('Baseline: %d Hz, Gain: %d Hz, Noise: %d Hz\n\n', ...
    baseline, gain, noise_std);

%% 2. Simulate Response to One Stimulus Direction
% Stimulus at 60 degrees. Each neuron fires according to its tuning curve + noise.

stimulus_dir = 60;

% Compute noisy responses
responses = baseline + gain * cosd(pref_dirs - stimulus_dir) ...
    + randn(1, n_neurons) * noise_std;
responses = max(responses, 0);  % firing rates can't be negative

% Plot as a heatmap (neurons x 1)
figure;
imagesc(responses');
colorbar;
colormap('hot');
set(gca, 'YTick', 1:n_neurons);
neuron_labels = cell(1, n_neurons);
for i = 1:n_neurons
    neuron_labels{i} = sprintf('%d deg', pref_dirs(i));
end
set(gca, 'YTickLabel', neuron_labels);
set(gca, 'XTick', []);
xlabel('Stimulus at 60 degrees');
ylabel('Neuron (preferred direction)');
title('Population Activity Heatmap');

fprintf('--- Response to %d deg stimulus ---\n', stimulus_dir);
for i = 1:n_neurons
    fprintf('Neuron %d (pref %3d deg): %.1f Hz\n', i, pref_dirs(i), responses(i));
end
fprintf('\n');

%% 3. Decode with Population Vector
% Each neuron "votes" for its preferred direction, weighted by firing rate.
% The sum of votes gives the decoded direction.

decoded_dir = decode_direction(responses, pref_dirs);

% Handle negative decoded direction for display
decoded_display = mod(decoded_dir, 360);

fprintf('--- Population Vector Decoding ---\n');
fprintf('Actual:  %d deg\n', stimulus_dir);
fprintf('Decoded: %.1f deg\n', decoded_display);
fprintf('Error:   %.1f deg\n\n', abs(stimulus_dir - decoded_display));

% Visualize the population vector
figure;
% Draw each neuron's "vote" (thin arrows)
for i = 1:n_neurons
    quiver(0, 0, responses(i) * cosd(pref_dirs(i)), ...
        responses(i) * sind(pref_dirs(i)), ...
        'Color', [0.7 0.7 0.7], 'LineWidth', 1, 'MaxHeadSize', 0.3);
    hold on;
end

% Draw the population vector (thick arrow)
pop_vec_x = sum(responses .* cosd(pref_dirs));
pop_vec_y = sum(responses .* sind(pref_dirs));
quiver(0, 0, pop_vec_x, pop_vec_y, 'r-', 'LineWidth', 3, 'MaxHeadSize', 0.3);

% Draw the true stimulus direction (dashed)
r_max = max(abs([pop_vec_x, pop_vec_y])) * 1.2;
plot([0 r_max * cosd(stimulus_dir)], [0 r_max * sind(stimulus_dir)], ...
    'b--', 'LineWidth', 2);

hold off;
axis equal;
grid on;
legend('Neuron votes', '', '', '', '', '', '', '', ...
    'Population vector', 'True direction');
title(sprintf('Population Vector (actual=%d, decoded=%.0f deg)', ...
    stimulus_dir, decoded_display));
xlabel('x component');
ylabel('y component');

%% 4. Test Across Many Directions
% Decode multiple stimulus directions and compare decoded vs actual.

test_dirs = 0:15:345;  % test every 15 degrees
n_tests = length(test_dirs);
decoded_dirs = zeros(1, n_tests);

for i = 1:n_tests
    % Simulate noisy responses
    test_responses = baseline + gain * cosd(pref_dirs - test_dirs(i)) ...
        + randn(1, n_neurons) * noise_std;
    test_responses = max(test_responses, 0);

    % Decode
    decoded_dirs(i) = mod(decode_direction(test_responses, pref_dirs), 360);
end

% Plot decoded vs actual
figure;
plot(test_dirs, decoded_dirs, 'bo', 'MarkerSize', 8, 'MarkerFaceColor', 'b');
hold on;
plot([0 360], [0 360], 'k--', 'LineWidth', 1);  % perfect decoding line
hold off;
xlabel('Actual Direction (degrees)');
ylabel('Decoded Direction (degrees)');
title('Decoded vs Actual Direction');
legend('Decoded', 'Perfect decoding', 'Location', 'northwest');
xlim([0 360]);
ylim([0 360]);
grid on;

% Compute overall error
errors = abs(test_dirs - decoded_dirs);
% Handle wraparound (e.g., actual=350, decoded=10 -> error=20, not 340)
errors = min(errors, 360 - errors);

fprintf('--- Decoding Accuracy ---\n');
fprintf('Tested %d directions\n', n_tests);
fprintf('Mean error: %.1f degrees\n', mean(errors));
fprintf('Max error:  %.1f degrees\n', max(errors));
fprintf('Std error:  %.1f degrees\n', std(errors));
fprintf('\nWith %d neurons, the population vector decoder\n', n_neurons);
fprintf('can recover the stimulus direction quite well!\n');

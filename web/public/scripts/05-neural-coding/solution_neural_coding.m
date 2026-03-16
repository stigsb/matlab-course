% solution_neural_coding.m - Complete solution for neural coding exercise
% Part of: Matlab for Computational Neuroscience, Module 05
%
% This is the solution file. Try the exercise first!
%
clear; clc; close all;
rng(42);

%% Part 1: Spike Train Basics (3 TODOs)
% Generate a spike train and look at it.

% SOLUTION 1: Set the firing rate, time step, and total time.
rate = 25;       % firing rate in Hz
dt = 0.001;      % time step in seconds (1 ms)
T = 1;           % total recording time in seconds

n_steps = T / dt;
time = (1:n_steps) * dt;

% SOLUTION 2: Generate a spike train using rand() < rate * dt.
spikes = rand(1, n_steps) < rate * dt;

% SOLUTION 3: Plot the raster and compute the actual firing rate.
figure;
spike_times = time(spikes);
for s = 1:length(spike_times)
    plot([spike_times(s) spike_times(s)], [0.6 1.4], 'k-');
    hold on;
end
hold off;
xlabel('Time (s)'); ylabel('Spike');
title('My Spike Train');
ylim([0 2]);

actual_rate = sum(spikes) / T;
fprintf('Part 1: Requested %d Hz, got %.1f Hz (%d spikes in %.1f s)\n', ...
    rate, actual_rate, sum(spikes), T);

%% Part 2: Tuning Curves (3 TODOs)
% Create a neuron and plot its tuning curve.

% SOLUTION 4: Define the neuron's properties.
preferred_dir = 135;  % degrees
baseline = 12;        % baseline firing rate (Hz)
gain_val = 18;        % modulation depth (Hz)

% Test all directions
directions = 0:10:350;

% SOLUTION 5: Compute firing rates using cosine tuning.
firing_rates = baseline + gain_val * cosd(directions - preferred_dir);

% SOLUTION 6: Plot the tuning curve.
% Polar plot:
figure;
polarplot(deg2rad([directions 360]), [firing_rates firing_rates(1)], ...
    'b-o', 'LineWidth', 2);
title(sprintf('Tuning Curve (preferred = %d deg)', preferred_dir));

% Line plot:
figure;
plot(directions, firing_rates, 'b-o', 'LineWidth', 2);
xlabel('Stimulus Direction (degrees)');
ylabel('Firing Rate (Hz)');
title('Tuning Curve');
xlim([0 360]);

fprintf('Part 2: Preferred dir = %d deg\n', preferred_dir);
fprintf('  Max rate: %.1f Hz (should be at %d deg)\n', ...
    max(firing_rates), preferred_dir);
fprintf('  Min rate: %.1f Hz (should be at %d deg)\n', ...
    min(firing_rates), mod(preferred_dir + 180, 360));

%% Part 3: Population Coding (3 TODOs)
% Create a population of 8 neurons and see their response.

stimulus_dir = 120;
noise_std = 3;

% SOLUTION 7: Create 8 neurons with evenly spaced preferred directions.
pref_dirs = 0:45:315;
n_neurons = length(pref_dirs);

% SOLUTION 8: Simulate noisy responses.
responses = baseline + gain_val * cosd(pref_dirs - stimulus_dir) ...
    + randn(1, n_neurons) * noise_std;
responses = max(responses, 0);

% SOLUTION 9: Plot the population activity as a heatmap.
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
ylabel('Neuron (preferred direction)');
title(sprintf('Population Response to %d deg stimulus', stimulus_dir));

fprintf('Part 3: Stimulus at %d deg\n', stimulus_dir);
fprintf('  Brightest neuron should be near %d deg\n', stimulus_dir);
for i = 1:n_neurons
    fprintf('  Neuron %d (pref %3d deg): %.1f Hz\n', i, pref_dirs(i), responses(i));
end

%% Part 4: Decoding (2 TODOs)
% Decode the stimulus direction from population activity.

% SOLUTION 10: Decode using population vector.
decoded_dir = decode_direction(responses, pref_dirs);
decoded_display = mod(decoded_dir, 360);

% SOLUTION 11: Compute the decoding error.
error_deg = abs(stimulus_dir - decoded_display);

fprintf('\nPart 4: Decoding\n');
fprintf('  Actual:  %d deg\n', stimulus_dir);
fprintf('  Decoded: %.1f deg\n', decoded_display);
fprintf('  Error:   %.1f deg\n', error_deg);

%% Challenge: Decoder Accuracy Test (1 TODO)
% Test decoder across all directions at different noise levels.

% SOLUTION 12: Loop over directions and noise levels.
test_dirs = 0:15:345;
noise_levels = [1, 5, 10];

figure;
hold on;
colors = {'g', 'b', 'r'};
for nl = 1:length(noise_levels)
    decoded_results = zeros(1, length(test_dirs));
    for d = 1:length(test_dirs)
        % Average over 10 trials
        trial_decoded = zeros(1, 10);
        for trial = 1:10
            test_resp = baseline + gain_val * cosd(pref_dirs - test_dirs(d)) ...
                + randn(1, n_neurons) * noise_levels(nl);
            test_resp = max(test_resp, 0);
            trial_decoded(trial) = mod(decode_direction(test_resp, pref_dirs), 360);
        end
        decoded_results(d) = mean(trial_decoded);
    end
    plot(test_dirs, decoded_results, [colors{nl} 'o'], ...
        'MarkerSize', 6, 'MarkerFaceColor', colors{nl});
end
plot([0 360], [0 360], 'k--', 'LineWidth', 1);
hold off;
xlabel('Actual Direction (degrees)');
ylabel('Decoded Direction (degrees)');
title('Decoder Accuracy at Different Noise Levels');
legend('Low noise (1 Hz)', 'Medium noise (5 Hz)', 'High noise (10 Hz)', ...
    'Perfect', 'Location', 'northwest');
xlim([0 360]); ylim([0 360]);
grid on;

fprintf('\nChallenge: Decoder accuracy at different noise levels\n');
fprintf('  Low noise should track the diagonal closely\n');
fprintf('  High noise should scatter more around the diagonal\n');

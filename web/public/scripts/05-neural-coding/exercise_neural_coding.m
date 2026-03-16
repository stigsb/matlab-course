% exercise_neural_coding.m - Practice spike trains, tuning curves, and decoding
% Part of: Matlab for Computational Neuroscience, Module 05
%
% Instructions: Fill in each TODO, then uncomment the fprintf line below it.
% Run the script after each part to check your work!
%
% There are 12 TODOs across 4 parts plus an optional challenge.
%
clear; clc; close all;
rng(42);

%% Part 1: Spike Train Basics (3 TODOs)
% Let's generate a spike train and look at it.

% --- Parameters ---
% We want a neuron firing at 25 Hz for 1 second.
% The time step is 1 ms.

% TODO 1: Set the firing rate, time step, and total time.
% rate = ???    % firing rate in Hz
% dt = ???      % time step in seconds (1 ms)
% T = ???       % total recording time in seconds

% n_steps = T / dt;
% time = (1:n_steps) * dt;

% TODO 2: Generate a spike train using rand() < rate * dt.
% This creates a logical vector where 1 = spike, 0 = no spike.
% spikes = ???

% TODO 3: Plot the raster and compute the actual firing rate.
% Use a loop to draw vertical lines at each spike time.
% figure;
% spike_times = time(spikes);
% for s = 1:length(spike_times)
%     plot([spike_times(s) spike_times(s)], [0.6 1.4], 'k-');
%     hold on;
% end
% hold off;
% xlabel('Time (s)'); ylabel('Spike');
% title('My Spike Train');
% ylim([0 2]);

% Uncomment to check:
% actual_rate = sum(spikes) / T;
% fprintf('Part 1: Requested %d Hz, got %.1f Hz (%d spikes in %.1f s)\n', ...
%     rate, actual_rate, sum(spikes), T);

%% Part 2: Tuning Curves (3 TODOs)
% Let's create a neuron and plot its tuning curve.

% --- We'll define a neuron that prefers 135 degrees ---
% baseline = 12 Hz, gain = 18 Hz

% TODO 4: Define the neuron's properties.
% preferred_dir = ???  % degrees
% baseline = ???       % baseline firing rate (Hz)
% gain_val = ???       % modulation depth (Hz)

% Test all directions (every 10 degrees around the circle)
directions = 0:10:350;

% TODO 5: Compute firing rates using the cosine tuning formula.
% Remember to use cosd() since our directions are in degrees.
% firing_rates = ???

% TODO 6: Plot the tuning curve as a polar plot and a line plot.
% Polar plot:
% figure;
% polarplot(deg2rad([directions 360]), [firing_rates firing_rates(1)], ...
%     'b-o', 'LineWidth', 2);
% title(sprintf('Tuning Curve (preferred = %d deg)', preferred_dir));

% Line plot:
% figure;
% plot(directions, firing_rates, 'b-o', 'LineWidth', 2);
% xlabel('Stimulus Direction (degrees)');
% ylabel('Firing Rate (Hz)');
% title('Tuning Curve');
% xlim([0 360]);

% Uncomment to check:
% fprintf('Part 2: Preferred dir = %d deg\n', preferred_dir);
% fprintf('  Max rate: %.1f Hz (should be at %d deg)\n', ...
%     max(firing_rates), preferred_dir);
% fprintf('  Min rate: %.1f Hz (should be at %d deg)\n', ...
%     min(firing_rates), mod(preferred_dir + 180, 360));

%% Part 3: Population Coding (3 TODOs)
% Let's create a population of 8 neurons and see their response.

% --- The stimulus is at 120 degrees ---
stimulus_dir = 120;
noise_std = 3;

% TODO 7: Create 8 neurons with evenly spaced preferred directions.
% pref_dirs = ???  % should be 0, 45, 90, 135, 180, 225, 270, 315
% n_neurons = length(pref_dirs);

% TODO 8: Simulate noisy responses for each neuron.
% Each neuron fires according to: baseline + gain * cosd(pref - stim) + noise
% Use randn() for noise and max() to prevent negative rates.
% Use the baseline and gain_val from Part 2.
% responses = ???

% TODO 9: Plot the population activity as a heatmap.
% figure;
% imagesc(responses');
% colorbar;
% colormap('hot');
% set(gca, 'YTick', 1:n_neurons);
% neuron_labels = cell(1, n_neurons);
% for i = 1:n_neurons
%     neuron_labels{i} = sprintf('%d deg', pref_dirs(i));
% end
% set(gca, 'YTickLabel', neuron_labels);
% set(gca, 'XTick', []);
% ylabel('Neuron (preferred direction)');
% title(sprintf('Population Response to %d deg stimulus', stimulus_dir));

% Uncomment to check:
% fprintf('Part 3: Stimulus at %d deg\n', stimulus_dir);
% fprintf('  Brightest neuron should be near %d deg\n', stimulus_dir);
% for i = 1:n_neurons
%     fprintf('  Neuron %d (pref %3d deg): %.1f Hz\n', i, pref_dirs(i), responses(i));
% end

%% Part 4: Decoding (2 TODOs)
% Let's decode the stimulus direction from the population activity.

% TODO 10: Use the decode_direction() function to decode the stimulus.
% decoded_dir = ???
% decoded_display = mod(decoded_dir, 360);

% TODO 11: Compute and print the decoding error.
% error_deg = ???  % absolute difference between actual and decoded

% Uncomment to check:
% fprintf('\nPart 4: Decoding\n');
% fprintf('  Actual:  %d deg\n', stimulus_dir);
% fprintf('  Decoded: %.1f deg\n', decoded_display);
% fprintf('  Error:   %.1f deg\n', error_deg);

%% Challenge: Decoder Accuracy Test (1 TODO)
% How well does the decoder work across all directions?
% Test 24 directions, with 10 trials each, at different noise levels.

% TODO 12: Loop over test directions and noise levels, decode each,
% and plot decoded vs actual for each noise level.
%
% test_dirs = 0:15:345;
% noise_levels = [1, 5, 10];
%
% figure;
% hold on;
% colors = {'g', 'b', 'r'};
% for nl = 1:length(noise_levels)
%     decoded_results = zeros(1, length(test_dirs));
%     for d = 1:length(test_dirs)
%         % Average over 10 trials
%         trial_decoded = zeros(1, 10);
%         for trial = 1:10
%             test_resp = baseline + gain_val * cosd(pref_dirs - test_dirs(d)) ...
%                 + randn(1, n_neurons) * noise_levels(nl);
%             test_resp = max(test_resp, 0);
%             trial_decoded(trial) = mod(decode_direction(test_resp, pref_dirs), 360);
%         end
%         decoded_results(d) = mean(trial_decoded);
%     end
%     plot(test_dirs, decoded_results, [colors{nl} 'o'], ...
%         'MarkerSize', 6, 'MarkerFaceColor', colors{nl});
% end
% plot([0 360], [0 360], 'k--', 'LineWidth', 1);
% hold off;
% xlabel('Actual Direction (degrees)');
% ylabel('Decoded Direction (degrees)');
% title('Decoder Accuracy at Different Noise Levels');
% legend('Low noise (1 Hz)', 'Medium noise (5 Hz)', 'High noise (10 Hz)', ...
%     'Perfect', 'Location', 'northwest');
% xlim([0 360]); ylim([0 360]);
% grid on;

% Uncomment to check:
% fprintf('\nChallenge: Decoder accuracy at different noise levels\n');
% fprintf('  Low noise should track the diagonal closely\n');
% fprintf('  High noise should scatter more around the diagonal\n');

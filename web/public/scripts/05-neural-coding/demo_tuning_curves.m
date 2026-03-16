% MODULE 05: NEURAL CODING -- Tuning Curves
% Cosine tuning curves: what direction does each neuron prefer?
%
% Part of the Matlab for Computational Neuroscience course
% Module 05: Neural Coding
%
% What you'll see when you run this:
%   Figure 1: Polar plot of a single neuron's tuning curve
%   Figure 2: Line plot of the same tuning curve (easier to read values)
%   Figure 3: Four neurons with different preferred directions (polar)
%   Figure 4: Four neurons with different preferred directions (line plot)
%   Figure 5: Noisy tuning curves (realistic firing rates)

clear; clc; close all;
rng(42);

%% 1. Single Neuron Tuning Curve
% This neuron prefers 90 degrees (upward movement).
% Its firing rate follows a cosine: maximum at preferred, minimum at opposite.

preferred_dir = 90;   % preferred direction in degrees
baseline = 10;        % baseline firing rate (Hz)
gain = 15;            % modulation depth (Hz)

% Test all directions (every 10 degrees around the circle)
directions = 0:10:350;

% Compute firing rate for each direction using cosine tuning
% cosd() works in degrees -- no conversion needed
firing_rates = baseline + gain * cosd(directions - preferred_dir);

fprintf('--- Single Neuron Tuning ---\n');
fprintf('Preferred direction: %d degrees\n', preferred_dir);
fprintf('Baseline rate: %d Hz\n', baseline);
fprintf('Gain: %d Hz\n', gain);
fprintf('Max firing rate: %.1f Hz (at %d deg)\n', max(firing_rates), preferred_dir);
fprintf('Min firing rate: %.1f Hz (at %d deg)\n\n', min(firing_rates), ...
    mod(preferred_dir + 180, 360));

% Polar plot: angle = direction, distance = firing rate
figure;
% polarplot needs radians for angle, but our values are in degrees
polarplot(deg2rad([directions 360]), [firing_rates firing_rates(1)], ...
    'b-o', 'LineWidth', 2);
title(sprintf('Tuning Curve (preferred = %d deg)', preferred_dir));

% Line plot: direction on x-axis, rate on y-axis
figure;
plot(directions, firing_rates, 'b-o', 'LineWidth', 2, 'MarkerSize', 4);
xlabel('Stimulus Direction (degrees)');
ylabel('Firing Rate (Hz)');
title(sprintf('Tuning Curve (preferred = %d deg)', preferred_dir));
% Mark the preferred direction
hold on;
plot(preferred_dir, max(firing_rates), 'rv', 'MarkerSize', 12, ...
    'MarkerFaceColor', 'r');
hold off;
legend('Firing rate', 'Preferred direction');
xlim([0 360]);

%% 2. Four Neurons with Different Preferences
% In motor cortex, different neurons prefer different movement directions.
% Let's create 4 neurons that cover the cardinal directions.

pref_dirs = [0, 90, 180, 270];  % right, up, left, down
colors = {'r', 'b', 'g', 'm'};
labels = {'0 deg (right)', '90 deg (up)', '180 deg (left)', '270 deg (down)'};

% Polar plot of all 4 neurons
figure;
for n = 1:length(pref_dirs)
    rates = baseline + gain * cosd(directions - pref_dirs(n));
    polarplot(deg2rad([directions 360]), [rates rates(1)], ...
        [colors{n} '-'], 'LineWidth', 2);
    hold on;
end
hold off;
title('Four Neurons: Different Preferred Directions');
legend(labels, 'Location', 'southoutside');

% Line plot of all 4 neurons
figure;
for n = 1:length(pref_dirs)
    rates = baseline + gain * cosd(directions - pref_dirs(n));
    plot(directions, rates, [colors{n} '-'], 'LineWidth', 2);
    hold on;
end
hold off;
xlabel('Stimulus Direction (degrees)');
ylabel('Firing Rate (Hz)');
title('Four Neurons: Different Preferred Directions');
legend(labels, 'Location', 'best');
xlim([0 360]);

fprintf('--- Four Neurons ---\n');
for n = 1:length(pref_dirs)
    fprintf('Neuron %d: preferred = %d deg\n', n, pref_dirs(n));
end
fprintf('\n');

%% 3. Noisy Tuning Curves
% Real neurons don't fire at exact rates. There's trial-to-trial variability.
% Let's add noise to see what realistic data looks like.

n_repeats = 5;  % 5 repeated measurements per direction

figure;
hold on;
for n = 1:length(pref_dirs)
    for rep = 1:n_repeats
        % True rate + Gaussian noise (clipped at zero)
        noisy_rates = baseline + gain * cosd(directions - pref_dirs(n)) ...
            + randn(1, length(directions)) * 4;
        noisy_rates = max(noisy_rates, 0);  % firing rates can't be negative

        plot(directions, noisy_rates, [colors{n} '.'], 'MarkerSize', 8);
    end
    % Also plot the "true" tuning curve
    true_rates = baseline + gain * cosd(directions - pref_dirs(n));
    plot(directions, true_rates, [colors{n} '-'], 'LineWidth', 2);
end
hold off;
xlabel('Stimulus Direction (degrees)');
ylabel('Firing Rate (Hz)');
title('Noisy Tuning Curves (dots = single measurements, lines = true curves)');
legend(labels, 'Location', 'best');
xlim([0 360]);

fprintf('--- Noisy Tuning ---\n');
fprintf('Noise std: 4 Hz\n');
fprintf('Each direction measured %d times\n', n_repeats);
fprintf('Notice: individual measurements scatter around the true curve.\n');
fprintf('This is why you need multiple trials to estimate a tuning curve!\n');

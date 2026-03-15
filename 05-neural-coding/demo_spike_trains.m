% MODULE 05: NEURAL CODING -- Spike Train Generation and Visualization
% Generate Poisson spike trains and visualize with raster plots, PSTH, and ISI.
%
% Part of the Matlab for Computational Neuroscience course
% Module 05: Neural Coding
%
% What you'll see when you run this:
%   Figure 1: Single-trial raster plot of a 30 Hz spike train
%   Figure 2: Multi-trial raster plot (20 trials)
%   Figure 3: PSTH (peri-stimulus time histogram) -- average firing rate
%   Figure 4: Interspike interval histogram

clear; clc; close all;
rng(42);

%% 1. Generate a Single Spike Train
% A neuron fires at 30 Hz (30 spikes per second).
% At each 1 ms time step, the probability of a spike is rate * dt.

rate = 30;           % firing rate in Hz
dt = 0.001;          % time step: 1 ms
T = 2;               % total recording time: 2 seconds
n_steps = T / dt;    % number of time steps
time = (1:n_steps) * dt;

% Generate spikes: random number < rate*dt means spike
spikes = rand(1, n_steps) < rate * dt;

% Find spike times
spike_times = time(spikes);
actual_rate = sum(spikes) / T;

fprintf('--- Single Spike Train ---\n');
fprintf('Requested rate: %d Hz\n', rate);
fprintf('Generated spikes: %d\n', sum(spikes));
fprintf('Actual rate: %.1f Hz\n', actual_rate);
fprintf('Duration: %.1f seconds\n\n', T);

% Plot raster for single trial
figure;
for s = 1:length(spike_times)
    plot([spike_times(s) spike_times(s)], [0.6 1.4], 'k-', 'LineWidth', 1);
    hold on;
end
hold off;
xlabel('Time (s)');
ylabel('Trial');
title(sprintf('Single Spike Train (%d Hz, %d spikes)', rate, sum(spikes)));
ylim([0 2]);
set(gca, 'YTick', 1, 'YTickLabel', {'1'});

%% 2. Multi-Trial Raster Plot
% Generate 20 trials and plot all spike trains together.
% Each trial is a new random realization of the same 30 Hz process.

n_trials = 20;

figure;
hold on;
for trial = 1:n_trials
    trial_spikes = rand(1, n_steps) < rate * dt;
    trial_spike_times = time(trial_spikes);
    % Plot each spike as a short vertical line
    for s = 1:length(trial_spike_times)
        plot([trial_spike_times(s) trial_spike_times(s)], ...
            [trial-0.4 trial+0.4], 'k-', 'LineWidth', 0.5);
    end
end
hold off;
xlabel('Time (s)');
ylabel('Trial');
title(sprintf('Raster Plot: %d Trials at %d Hz', n_trials, rate));
ylim([0 n_trials + 1]);

fprintf('--- Multi-Trial Raster ---\n');
fprintf('Trials: %d\n', n_trials);
fprintf('Each trial: %.1f seconds at %d Hz\n\n', T, rate);

%% 3. PSTH (Peri-Stimulus Time Histogram)
% Average the spike counts across trials in time bins.
% This reveals the underlying firing rate over time.

bin_size = 0.05;  % 50 ms bins
bin_edges = 0:bin_size:T;
total_counts = zeros(1, length(bin_edges) - 1);

rng(42);  % reset for reproducibility
for trial = 1:n_trials
    trial_spikes = rand(1, n_steps) < rate * dt;
    trial_spike_times = time(trial_spikes);
    counts = histcounts(trial_spike_times, bin_edges);
    total_counts = total_counts + counts;
end

% Convert counts to firing rate: counts / (n_trials * bin_size)
firing_rate_psth = total_counts / (n_trials * bin_size);
bin_centers = bin_edges(1:end-1) + bin_size / 2;

figure;
bar(bin_centers, firing_rate_psth, 1);
xlabel('Time (s)');
ylabel('Firing Rate (Hz)');
title(sprintf('PSTH: Average Firing Rate Over Time (%d trials)', n_trials));
% Add a reference line at the expected rate
hold on;
plot([0 T], [rate rate], 'r--', 'LineWidth', 2);
hold off;
legend('PSTH', sprintf('Expected rate (%d Hz)', rate));

fprintf('--- PSTH ---\n');
fprintf('Bin size: %.0f ms\n', bin_size * 1000);
fprintf('Number of bins: %d\n', length(bin_centers));
fprintf('Mean PSTH rate: %.1f Hz (expected: %d Hz)\n\n', mean(firing_rate_psth), rate);

%% 4. Interspike Interval Histogram
% The time between consecutive spikes.
% For a Poisson process, ISIs follow an exponential distribution.

rng(42);
all_spikes = rand(1, n_steps) < rate * dt;
all_spike_times = time(all_spikes);
isis = diff(all_spike_times);  % interspike intervals

figure;
histogram(isis * 1000, 30);  % convert to ms
xlabel('Interspike Interval (ms)');
ylabel('Count');
title('ISI Histogram (should look exponential for Poisson)');

% Add expected exponential curve
hold on;
x_ms = linspace(0, max(isis) * 1000, 100);
% For a Poisson process: P(ISI = t) = rate * exp(-rate * t)
expected = length(isis) * (x_ms(2) - x_ms(1)) / 1000 * rate * exp(-rate * x_ms / 1000);
plot(x_ms, expected, 'r-', 'LineWidth', 2);
hold off;
legend('Observed ISIs', 'Expected (exponential)');

fprintf('--- ISI Statistics ---\n');
fprintf('Number of ISIs: %d\n', length(isis));
fprintf('Mean ISI: %.1f ms (expected: %.1f ms)\n', mean(isis) * 1000, 1000 / rate);
fprintf('Std ISI:  %.1f ms\n', std(isis) * 1000);
fprintf('Min ISI:  %.1f ms\n', min(isis) * 1000);
fprintf('Max ISI:  %.1f ms\n', max(isis) * 1000);

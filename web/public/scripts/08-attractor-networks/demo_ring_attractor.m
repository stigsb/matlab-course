% MODULE 08: ATTRACTOR NETWORKS -- Ring Attractor Simulation
% Simulate a ring attractor network that maintains a stable bump of activity
% representing head direction.
%
% Part of the Matlab for Computational Neuroscience course
% Module 08: Attractor Networks
%
% What you'll see when you run this:
%   Figure 1: Activity heatmap over time (stable bump)
%   Figure 2: Initial and final bump profiles (same position)
%   Figure 3: Activity of 3 example neurons over time

clear; clc; close all;
rng(42);

%% 1. Set Up the Ring Network
N = 100;  % 100 neurons arranged on a ring

% Each neuron has a preferred direction evenly spaced around 360 degrees
theta = linspace(0, 2*pi, N+1);
theta = theta(1:end-1);  % Remove duplicate at 2*pi

% Convert to degrees for display
theta_deg = theta * 180 / pi;

fprintf('Ring attractor: %d neurons with preferred directions 0-360 degrees.\n', N);

%% 2. Build Mexican-Hat Connectivity
% Neurons with similar preferred directions excite each other.
% Neurons with different preferred directions inhibit each other.

W = zeros(N, N);
for i = 1:N
    for j = 1:N
        W(i, j) = cos(theta(i) - theta(j)) - 0.5;
    end
end
W(1:N+1:end) = 0;  % No self-connections

fprintf('Connectivity: Mexican-hat (cosine - 0.5).\n');
fprintf('  Neighbors: excitation. Distant neurons: inhibition.\n\n');

%% 3. Initialize Activity Bump
% Start with a bump centered at 90 degrees (pi/2)

bump_center = pi/2;  % 90 degrees
activity = exp(5 * cos(theta - bump_center));
activity = activity / sum(activity);  % Normalize

fprintf('Initial bump centered at %.0f degrees.\n', bump_center * 180 / pi);

%% 4. Simulate Dynamics
tau = 1;      % Time constant
dt = 0.1;     % Time step
T = 50;       % Total simulation time
n_steps = round(T / dt);

% Store activity history for visualization
activity_history = zeros(n_steps, N);

for step = 1:n_steps
    activity_history(step, :) = activity;

    % Compute input from other neurons
    input = (W * activity')';

    % Update with time constant
    activity = activity + (dt / tau) * (-activity + input);

    % Rectify: no negative firing rates
    activity = max(0, activity);

    % Normalize to prevent blow-up
    if sum(activity) > 0
        activity = activity / sum(activity);
    end
end

%% 5. Find Bump Position Over Time
% Track the peak position at each time step
time_axis = (1:n_steps) * dt;
peak_positions = zeros(1, n_steps);
for step = 1:n_steps
    [~, peak_idx] = max(activity_history(step, :));
    peak_positions(step) = theta_deg(peak_idx);
end

fprintf('Bump maintains position at ~%.0f degrees without external input.\n', ...
    peak_positions(end));
fprintf('Drift from initial: %.1f degrees over %.0f seconds.\n\n', ...
    abs(peak_positions(end) - bump_center * 180 / pi), T);

%% 6. Visualize: Activity Heatmap Over Time
figure;
imagesc(time_axis, theta_deg, activity_history');
set(gca, 'YDir', 'normal');
colorbar;
xlabel('Time (s)');
ylabel('Preferred Direction (degrees)');
title('Ring Attractor: Stable Bump of Activity');
set(gca, 'FontSize', 12);

fprintf('Figure 1: Heatmap shows the bump persists at the same position over time.\n');

%% 7. Visualize: Initial vs Final Bump Profile
figure;

subplot(1, 2, 1);
bar(theta_deg, activity_history(1, :), 1, 'FaceColor', [0.2 0.5 0.8]);
xlabel('Preferred Direction (degrees)');
ylabel('Activity');
title('Initial Bump');
xlim([0 360]);
set(gca, 'FontSize', 11);

subplot(1, 2, 2);
bar(theta_deg, activity_history(end, :), 1, 'FaceColor', [0.8 0.3 0.2]);
xlabel('Preferred Direction (degrees)');
ylabel('Activity');
title(sprintf('Final Bump (t = %d s)', T));
xlim([0 360]);
set(gca, 'FontSize', 11);

sgtitle('Bump Profile: Start vs End');

fprintf('Figure 2: Bump profile is maintained after %d seconds of simulation.\n', T);

%% 8. Example Neuron Activity Over Time
figure;
example_neurons = [25, 50, 75];  % Different preferred directions

for i = 1:length(example_neurons)
    n_idx = example_neurons(i);
    plot(time_axis, activity_history(:, n_idx), 'LineWidth', 2);
    hold on;
end
hold off;

legend_entries = cell(1, length(example_neurons));
for i = 1:length(example_neurons)
    legend_entries{i} = sprintf('Neuron %d (pref: %.0f deg)', ...
        example_neurons(i), theta_deg(example_neurons(i)));
end
legend(legend_entries, 'Location', 'best');
xlabel('Time (s)');
ylabel('Activity');
title('Individual Neuron Activity');
set(gca, 'FontSize', 12);

fprintf('Figure 3: Only neurons near 90 degrees maintain high activity.\n');
fprintf('\nKey insight: The bump persists because of the network connectivity,\n');
fprintf('not because of external input. This is how the brain remembers\n');
fprintf('head direction even in the dark.\n');

% MODULE 07: DIMENSIONALITY REDUCTION -- PCA on Neural Population Data
% Apply PCA to simulated neural population recordings.
% Circular stimuli map to a ring in PC space!
%
% Part of the Matlab for Computational Neuroscience course
% Module 07: Dimensionality Reduction
%
% What you'll see when you run this:
%   Figure 1: Tuning curves of all 8 neurons
%   Figure 2: PC1 vs PC2 colored by stimulus direction -- a ring!
%   Figure 3: Scree plot showing variance explained
%
% Connection to Module 05: The neurons use cosine tuning curves,
% exactly as you learned in Module 05 (population coding).

clear; clc; close all;
rng(42);

%% 1. Simulate 8 Neurons with Cosine Tuning
n_neurons = 8;
n_trials = 200;
pref_dirs = linspace(0, 315, n_neurons);  % degrees: 0, 45, 90, ..., 315

fprintf('=== PCA on Neural Population Data ===\n\n');
fprintf('Simulating %d neurons with preferred directions:\n', n_neurons);
fprintf('  [%s] degrees\n\n', num2str(pref_dirs));

% Generate random stimulus directions for each trial
stimulus_dirs = rand(n_trials, 1) * 360;

% Compute firing rates: cosine tuning + baseline + noise
% (Same model as Module 05!)
baseline = 10;  % Hz
gain = 15;      % Hz
noise_level = 3;

data = zeros(n_trials, n_neurons);
for i = 1:n_trials
    data(i, :) = baseline + gain * cosd(pref_dirs - stimulus_dirs(i)) ...
                 + noise_level * randn(1, n_neurons);
    data(i, :) = max(0, data(i, :));  % firing rates can't be negative
end

fprintf('Data matrix: %d trials x %d neurons\n', size(data));

%% 2. Show Tuning Curves
figure(1);
test_dirs = 0:10:350;
for k = 1:n_neurons
    subplot(2, 4, k);
    rates = baseline + gain * cosd(test_dirs - pref_dirs(k));
    plot(test_dirs, rates, 'b-', 'LineWidth', 1.5);
    xlabel('Direction (deg)');
    ylabel('Rate (Hz)');
    title(sprintf('Neuron %d (pref=%d)', k, pref_dirs(k)));
    xlim([0 360]);
end
sgtitle('Cosine Tuning Curves of 8 Neurons');

%% 3. Perform PCA (same 6 steps as demo_pca_steps)
% Step 2: Mean-center
centered = data - mean(data);

% Step 3: Covariance matrix
C = cov(centered);

% Step 4: Eigendecompose
[V, D] = eig(C);

% Step 5: Sort descending
[eigenvalues, idx] = sort(diag(D), 'descend');
V = V(:, idx);

% Variance explained
var_explained = 100 * eigenvalues / sum(eigenvalues);
fprintf('\nVariance explained per component:\n');
for k = 1:n_neurons
    fprintf('  PC%d: %.1f%%\n', k, var_explained(k));
end
fprintf('Top 2 components: %.1f%%\n\n', sum(var_explained(1:2)));

% Step 6: Project onto top 2 PCs
projected = centered * V(:, 1:2);

%% 4. The Key Plot: PC1 vs PC2 Colored by Stimulus Direction
figure(2);
scatter(projected(:,1), projected(:,2), 20, stimulus_dirs, 'filled');
colorbar;
colormap(hsv);  % circular colormap for circular stimulus
xlabel('PC1'); ylabel('PC2');
title('Neural Population in PC Space');
axis equal;

% Add annotation
text(min(projected(:,1)), max(projected(:,2)), ...
    'Circular stimulus maps to a ring in PC space!', ...
    'FontSize', 10, 'FontWeight', 'bold', 'Color', 'k', ...
    'VerticalAlignment', 'top');

fprintf('Look at the scatter plot: the points form a RING!\n');
fprintf('Similar stimulus directions are close together on the ring.\n');
fprintf('PCA revealed the circular structure hidden in 8 dimensions.\n');

%% 5. Scree Plot
figure(3);
subplot(1,2,1);
bar(var_explained);
xlabel('Principal Component');
ylabel('Variance Explained (%)');
title('Scree Plot');

subplot(1,2,2);
cumulative = cumsum(var_explained);
plot(1:length(cumulative), cumulative, 'bo-', 'LineWidth', 2);
hold on;
yline(90, 'r--', '90% threshold');
hold off;
xlabel('Number of Components');
ylabel('Cumulative Variance (%)');
title('Cumulative Variance Explained');
ylim([0 105]);

sgtitle('How Many Components Capture the Neural Code?');

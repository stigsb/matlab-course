% MODULE 07: DIMENSIONALITY REDUCTION -- Why Reduce?
% Visual motivation: high-dimensional neural data is really low-dimensional
%
% Part of the Matlab for Computational Neuroscience course
% Module 07: Dimensionality Reduction
%
% What you'll see when you run this:
%   Figure 1: 50 neurons recorded over time -- too many dimensions!
%   Figure 2: Scatter plot of first 3 neurons (all we can plot from 50D)
%   Figure 3: PCA projection onto top 2 components vs 3-neuron view

clear; clc; close all;
rng(42);

%% 1. Generate 50-Neuron Simulated Data
% Most neurons are driven by 2-3 common signals plus noise.
% This mimics real recordings where neurons share inputs.

n_neurons = 50;
n_timepoints = 300;

% Three common signals (the "real" dimensions driving the population)
t = linspace(0, 6*pi, n_timepoints)';
signal1 = sin(t);
signal2 = cos(1.5*t);
signal3 = sin(0.7*t + pi/4);

% Each neuron gets a random mix of these signals plus noise
data = zeros(n_timepoints, n_neurons);
for i = 1:n_neurons
    w1 = randn * 0.5;
    w2 = randn * 0.5;
    w3 = randn * 0.3;
    data(:, i) = w1*signal1 + w2*signal2 + w3*signal3 + 0.3*randn(n_timepoints, 1);
end

fprintf('Data shape: %d timepoints x %d neurons\n', size(data));
fprintf('We CANNOT plot 50 dimensions.\n');
fprintf('But PCA can find the few directions that capture most variance.\n\n');

%% 2. Visualize -- We Can Only Show 3 of 50 Neurons
figure(1);
subplot(1,2,1);
plot(data(:, 1:5));
xlabel('Time point');
ylabel('Activity');
title('First 5 of 50 Neurons');
legend('N1','N2','N3','N4','N5', 'Location', 'best');

subplot(1,2,2);
imagesc(data');
xlabel('Time point');
ylabel('Neuron');
title('All 50 Neurons (heatmap)');
colorbar;
sgtitle('50 Neurons Recorded -- How Do We Understand This?');

%% 3. 3D Scatter of First 3 Neurons
% This is ALL we can plot directly from 50D data.
figure(2);
scatter3(data(:,1), data(:,2), data(:,3), 10, t, 'filled');
xlabel('Neuron 1'); ylabel('Neuron 2'); zlabel('Neuron 3');
title('3D Scatter: Neurons 1-3 Only (ignoring 47 neurons!)');
colorbar;
view(45, 30);

%% 4. Quick PCA to Reveal the True Structure
% Step-by-step PCA (see demo_pca_steps for detailed walkthrough)
centered = data - mean(data);
[V, D] = eig(cov(centered));
[eigenvalues, idx] = sort(diag(D), 'descend');
V = V(:, idx);

% Variance explained
var_explained = 100 * eigenvalues / sum(eigenvalues);
fprintf('Variance explained by top components:\n');
for k = 1:5
    fprintf('  PC%d: %.1f%%\n', k, var_explained(k));
end
fprintf('  Top 3 together: %.1f%%\n', sum(var_explained(1:3)));

% Project onto top 2 PCs
projected = centered * V(:, 1:2);

%% 5. Compare: 3-Neuron View vs PCA View
figure(3);
subplot(1,2,1);
scatter(data(:,1), data(:,2), 10, t, 'filled');
xlabel('Neuron 1'); ylabel('Neuron 2');
title('Arbitrary 2 Neurons');
colorbar;

subplot(1,2,2);
scatter(projected(:,1), projected(:,2), 10, t, 'filled');
xlabel('PC1'); ylabel('PC2');
title('PCA: Top 2 Components');
colorbar;

sgtitle('PCA Finds the Best "Camera Angle" for 50D Data');

fprintf('\nPCA reveals the low-dimensional structure that was hidden\n');
fprintf('in the 50-dimensional recording.\n');

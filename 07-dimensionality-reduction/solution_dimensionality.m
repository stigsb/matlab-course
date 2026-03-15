% solution_dimensionality.m - Complete solution for Module 07 exercise
% Part of: Matlab for Computational Neuroscience, Module 07
%
% This file has all TODOs filled in and produces all expected plots.
%
clear; clc; close all;
rng(42);

%% Part 1: Data Exploration (3 TODOs)

% --- Data generation (provided) ---
n = 200;
t = linspace(0, 4*pi, n)';
data = [2*cos(t) + 0.3*randn(n,1), ...
        1.5*sin(t) + 0.3*randn(n,1), ...
        0.2*randn(n,1)];
labels = t;
% -----------------------------------

fprintf('Data size: %d observations x %d variables\n\n', size(data));

% TODO 1: Compute the mean of each column
mu = mean(data);
fprintf('Column means: [%.3f, %.3f, %.3f]\n', mu);

% TODO 2: Mean-center the data
centered = data - mu;
fprintf('Centered means: [%.6f, %.6f, %.6f] (should be ~0)\n', mean(centered));

% TODO 3: Verify centering
is_centered = all(abs(mean(centered)) < 1e-10);
fprintf('Centering verified: %d\n\n', is_centered);


%% Part 2: Manual PCA (4 TODOs)

% TODO 4: Covariance matrix
C = cov(centered);
fprintf('Covariance matrix size: %dx%d\n', size(C));
disp(C);

% TODO 5: Eigendecompose
[V, D] = eig(C);

% TODO 6: Sort descending
[eigenvalues, idx] = sort(diag(D), 'descend');
V = V(:, idx);
fprintf('Sorted eigenvalues: %.4f, %.4f, %.4f\n', eigenvalues);

% TODO 7: Variance explained
var_explained = eigenvalues / sum(eigenvalues) * 100;
fprintf('Variance explained: %.1f%%, %.1f%%, %.1f%%\n\n', var_explained);


%% Part 3: Projection and Visualization (3 TODOs)

% TODO 8: Project onto top 2 PCs
projected = centered * V(:, 1:2);
fprintf('Projected data size: %dx%d\n', size(projected));

% TODO 9: Scatter plot of projected data
figure;
scatter(projected(:,1), projected(:,2), 10, labels, 'filled');
xlabel('PC1'); ylabel('PC2');
title('PCA Projection: Top 2 Components');
colorbar;

% TODO 10: Scree plot
figure;
bar(var_explained);
xlabel('Principal Component');
ylabel('Variance Explained (%)');
title('Scree Plot');
set(gca, 'XTickLabel', {'PC1', 'PC2', 'PC3'});


%% Part 4: Neural Data PCA (2 TODOs)

% --- Neural data generation (provided) ---
n_neurons = 8;
n_trials = 200;
pref_dirs = linspace(0, 315, n_neurons);
stimulus_dirs = rand(n_trials, 1) * 360;

neural_data = zeros(n_trials, n_neurons);
for i = 1:n_trials
    neural_data(i, :) = 10 + 15 * cosd(pref_dirs - stimulus_dirs(i)) ...
                        + 3 * randn(1, n_neurons);
    neural_data(i, :) = max(0, neural_data(i, :));
end
% ------------------------------------------

% TODO 11: Complete PCA on neural data
neural_centered = neural_data - mean(neural_data);
C_neural = cov(neural_centered);
[V_neural, D_neural] = eig(C_neural);
[eigenvalues_neural, idx_neural] = sort(diag(D_neural), 'descend');
V_neural = V_neural(:, idx_neural);
projected_neural = neural_centered * V_neural(:, 1:2);

var_neural = eigenvalues_neural / sum(eigenvalues_neural) * 100;
fprintf('\nNeural PCA variance explained:\n');
for k = 1:n_neurons
    fprintf('  PC%d: %.1f%%\n', k, var_neural(k));
end

% TODO 12: Plot neural PCA
figure;
scatter(projected_neural(:,1), projected_neural(:,2), 20, stimulus_dirs, 'filled');
colormap(hsv);
xlabel('PC1'); ylabel('PC2');
title('Neural Population in PC Space');
colorbar;
axis equal;

fprintf('\nWhat shape do you see in the neural PCA plot?\n');
fprintf('The circular stimulus maps to a RING in PC space!\n');


%% Optional Challenge: Reconstruction

% Reconstruct from 1 PC
reconstructed_1pc = projected(:, 1) * V(:, 1)' + mu;
error_1pc = mean(sum((data - reconstructed_1pc).^2, 2));

% Reconstruct from 2 PCs
reconstructed_2pc = projected(:, 1:2) * V(:, 1:2)' + mu;
error_2pc = mean(sum((data - reconstructed_2pc).^2, 2));

fprintf('\n=== Optional Challenge: Reconstruction ===\n');
fprintf('Reconstruction error with 1 PC: %.4f\n', error_1pc);
fprintf('Reconstruction error with 2 PCs: %.4f\n', error_2pc);
fprintf('Using 2 PCs gives %.1fx less error than 1 PC.\n', error_1pc / error_2pc);
fprintf('2 PCs capture %.1f%% of the variance, so very little is lost.\n', sum(var_explained(1:2)));

figure;
subplot(1,3,1);
scatter3(data(:,1), data(:,2), data(:,3), 10, labels, 'filled');
title('Original 3D'); view(45, 30);
subplot(1,3,2);
scatter3(reconstructed_1pc(:,1), reconstructed_1pc(:,2), reconstructed_1pc(:,3), 10, labels, 'filled');
title(sprintf('From 1 PC (error=%.2f)', error_1pc)); view(45, 30);
subplot(1,3,3);
scatter3(reconstructed_2pc(:,1), reconstructed_2pc(:,2), reconstructed_2pc(:,3), 10, labels, 'filled');
title(sprintf('From 2 PCs (error=%.2f)', error_2pc)); view(45, 30);
sgtitle('Reconstruction Quality');

fprintf('\n=== Solution complete! ===\n');

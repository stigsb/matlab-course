% exercise_dimensionality.m - Practice PCA step-by-step
% Part of: Matlab for Computational Neuroscience, Module 07
%
% Instructions: Fill in each TODO, then uncomment the fprintf line below it.
% Run the script after each part to check your work!
%
% There are 12 TODOs across 4 parts plus an optional challenge.
%
clear; clc; close all;
rng(42);

%% Part 1: Data Exploration (3 TODOs)
% We have 3D data -- let's look at it before doing PCA.

% --- Data generation (provided -- don't modify) ---
n = 200;
t = linspace(0, 4*pi, n)';
data = [2*cos(t) + 0.3*randn(n,1), ...
        1.5*sin(t) + 0.3*randn(n,1), ...
        0.2*randn(n,1)];
labels = t;  % we'll use this for coloring plots later
% ------------------------------------------------

fprintf('Data size: %d observations x %d variables\n\n', size(data));

% TODO 1: Compute the mean of each column (variable).
% Hint: mean(data) gives a 1x3 vector of column means.
% mu = ???

% Expected: mu should be close to [0, 0, 0] (but not exactly zero)
% fprintf('Column means: [%.3f, %.3f, %.3f]\n', mu);

% TODO 2: Mean-center the data by subtracting mu from data.
% centered = ???

% fprintf('Centered means: [%.6f, %.6f, %.6f] (should be ~0)\n', mean(centered));

% TODO 3: Verify that centering worked by checking the new means.
% Compute mean(centered) and check that all values are close to zero.
% is_centered = ???  % true if all means are < 1e-10

% fprintf('Centering verified: %d\n\n', is_centered);


%% Part 2: Manual PCA (4 TODOs)
% Now perform PCA step by step, just like demo_pca_steps.

% TODO 4: Compute the covariance matrix of the centered data.
% Hint: use cov()
% C = ???

% fprintf('Covariance matrix size: %dx%d\n', size(C));
% disp(C);

% TODO 5: Find eigenvalues and eigenvectors using eig().
% Remember: [V, D] = eig(C) where V has eigenvectors as columns,
% and D is a diagonal matrix with eigenvalues.
% [V, D] = ???

% TODO 6: Sort eigenvalues in DESCENDING order.
% IMPORTANT: eig() returns ascending order! PCA needs descending!
% Hint: [eigenvalues, idx] = sort(diag(D), 'descend');
% Then reorder V to match: V = V(:, idx);
% eigenvalues = ???
% idx = ???
% V = ???

% fprintf('Sorted eigenvalues: %.4f, %.4f, %.4f\n', eigenvalues);

% TODO 7: Compute the percentage of variance explained by each component.
% Hint: divide each eigenvalue by the sum of all eigenvalues, then multiply by 100.
% var_explained = ???

% fprintf('Variance explained: %.1f%%, %.1f%%, %.1f%%\n', var_explained);


%% Part 3: Projection and Visualization (3 TODOs)
% Project the data and create plots.

% TODO 8: Project the centered data onto the top 2 principal components.
% Hint: multiply centered data by the first 2 columns of V.
% projected = ???

% fprintf('Projected data size: %dx%d\n', size(projected));

% TODO 9: Create a scatter plot of the projected data.
% Color the points using the 'labels' variable (which is t, the position along the spiral).
% figure;
% scatter(???, ???, 10, ???, 'filled');
% xlabel('PC1'); ylabel('PC2');
% title('PCA Projection: Top 2 Components');
% colorbar;

% TODO 10: Create a scree plot (bar chart of variance explained).
% figure;
% bar(???);
% xlabel('Principal Component');
% ylabel('Variance Explained (%)');
% title('Scree Plot');


%% Part 4: Neural Data PCA (2 TODOs)
% Apply PCA to simulated neural population data.

% --- Neural data generation (provided -- don't modify) ---
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
% --------------------------------------------------------

% TODO 11: Perform complete PCA on neural_data.
% Do all the steps: center, covariance, eigendecompose, sort, project to 2D.
% neural_centered = ???
% C_neural = ???
% [V_neural, D_neural] = ???
% [eigenvalues_neural, idx_neural] = ???
% V_neural = ???
% projected_neural = ???

% TODO 12: Plot PC1 vs PC2 colored by stimulus direction.
% What shape do you see? (Hint: it should be a ring!)
% figure;
% scatter(???, ???, 20, stimulus_dirs, 'filled');
% colormap(hsv);
% xlabel('PC1'); ylabel('PC2');
% title('Neural Population in PC Space');
% colorbar;
% axis equal;

% fprintf('What shape do you see in the neural PCA plot?\n');
% fprintf('The circular stimulus maps to a ______ in PC space!\n');


%% Optional Challenge: Reconstruction
% Can you reconstruct the original 3D data from only 1 PC?
% How does it compare to using 2 PCs?

% Hint: To reconstruct from k PCs:
%   reconstructed = projected(:, 1:k) * V(:, 1:k)' + mu;
%
% Try k=1 and k=2, then compute the reconstruction error:
%   error = mean(sum((data - reconstructed).^2, 2));
%
% Which gives a smaller error? Why?

fprintf('\n=== Exercise complete! ===\n');
fprintf('Check your plots and compare to the demo scripts.\n');

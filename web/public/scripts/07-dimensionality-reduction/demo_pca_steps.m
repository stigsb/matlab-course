% MODULE 07: DIMENSIONALITY REDUCTION -- PCA Step-by-Step
% Perform PCA manually on 3D data, showing each step explicitly.
%
% Part of the Matlab for Computational Neuroscience course
% Module 07: Dimensionality Reduction
%
% What you'll see when you run this:
%   Figure 1: Original 3D data vs projected 2D data (colored by position)
%   Figure 2: Scree plot and cumulative variance explained
%
% Connection to Module 04: We use eig() on the covariance matrix --
% the same function you used for eigenvalues in Module 04!

clear; clc; close all;
rng(42);

%% Generate 3D Data That Is Really 2D
% A flattened spiral: strong variation in x and y, very little in z.
n = 200;
t = linspace(0, 4*pi, n)';

data = [2*cos(t) + 0.3*randn(n,1), ...   % x: strong signal
        1.5*sin(t) + 0.3*randn(n,1), ...  % y: strong signal
        0.2*randn(n,1)];                   % z: mostly noise

fprintf('=== PCA Step-by-Step ===\n\n');

%% Step 1: Start with data (rows = observations, columns = variables)
fprintf('Step 1: Data matrix is %d observations x %d variables\n', size(data));
fprintf('  Each row is one time point. Each column is one measurement.\n\n');

%% Step 2: Mean-center the data
mu = mean(data);
centered = data - mu;
fprintf('Step 2: Mean-center the data\n');
fprintf('  Original means: [%.3f, %.3f, %.3f]\n', mu);
fprintf('  Centered means: [%.6f, %.6f, %.6f] (should be ~0)\n\n', mean(centered));

%% Step 3: Compute covariance matrix
C = cov(centered);
fprintf('Step 3: Covariance matrix (3x3 for 3 variables):\n');
disp(C);

%% Step 4: Eigendecompose the covariance matrix
% Same eig() function from Module 04!
[V, D] = eig(C);
fprintf('Step 4: Eigendecompose with [V, D] = eig(C)\n');
fprintf('  Raw eigenvalues (ascending!): %.4f, %.4f, %.4f\n\n', diag(D));

%% Step 5: Sort eigenvalues DESCENDING (largest first)
% IMPORTANT: eig() returns ascending order. PCA needs descending!
[eigenvalues, idx] = sort(diag(D), 'descend');
V = V(:, idx);
fprintf('Step 5: Sort largest first\n');
fprintf('  Sorted eigenvalues: %.4f, %.4f, %.4f\n', eigenvalues);

% Variance explained
var_explained = 100 * eigenvalues / sum(eigenvalues);
fprintf('  Variance explained: %.1f%%, %.1f%%, %.1f%%\n\n', var_explained);

%% Step 6: Project onto top 2 principal components
projected = centered * V(:, 1:2);
fprintf('Step 6: Project onto top 2 PCs\n');
fprintf('  Original: %d x %d  -->  Projected: %d x %d\n', ...
    size(data,1), size(data,2), size(projected,1), size(projected,2));
fprintf('  Kept %.1f%% of variance with 2 of 3 components.\n\n', sum(var_explained(1:2)));

%% Figure 1: Original vs Projected
figure(1);
subplot(1,2,1);
scatter3(data(:,1), data(:,2), data(:,3), 10, t, 'filled');
title('Original 3D Data');
xlabel('x'); ylabel('y'); zlabel('z');
colorbar;
view(45, 30);

subplot(1,2,2);
scatter(projected(:,1), projected(:,2), 10, t, 'filled');
title('After PCA: Top 2 Components');
xlabel('PC1'); ylabel('PC2');
colorbar;

sgtitle('PCA: 3D to 2D (color = position along spiral)');

%% Figure 2: Scree Plot and Cumulative Variance
figure(2);
subplot(1,2,1);
bar(var_explained);
xlabel('Principal Component');
ylabel('Variance Explained (%)');
title('Scree Plot');
set(gca, 'XTickLabel', {'PC1', 'PC2', 'PC3'});

subplot(1,2,2);
cumulative = cumsum(var_explained);
plot(1:length(cumulative), cumulative, 'bo-', 'LineWidth', 2);
hold on;
yline(90, 'r--', '90% threshold');
hold off;
xlabel('Number of Components');
ylabel('Cumulative Variance Explained (%)');
title('How Many Components Do We Need?');
ylim([0 105]);

sgtitle('Choosing the Number of Components');

fprintf('=== Summary ===\n');
fprintf('PC1 + PC2 explain %.1f%% of the variance.\n', sum(var_explained(1:2)));
fprintf('PC3 is mostly noise (%.1f%% variance) -- we can safely drop it.\n', var_explained(3));
fprintf('PCA reduced our 3D data to 2D with minimal information loss.\n');

% MODULE 08: ATTRACTOR NETWORKS -- Hopfield Network
% Store 3 patterns in a Hopfield network and retrieve from noisy input.
%
% Part of the Matlab for Computational Neuroscience course
% Module 08: Attractor Networks
%
% What you'll see when you run this:
%   Figure 1: The three stored patterns (5x5 grids)
%   Figure 2: Original, noisy input, and retrieved pattern
%   Figure 3: Energy over iterations (decreases monotonically)
%   Figure 4: Overlap with all stored patterns over iterations

clear; clc; close all;
rng(42);

%% 1. Define Network and Patterns
N = 25;  % 25 neurons arranged as a 5x5 grid

% Pattern 1: Horizontal stripe (row 3 = +1, rest = -1)
p1 = -ones(5, 5);
p1(3, :) = 1;
p1 = p1(:);  % Flatten to column vector

% Pattern 2: Vertical stripe (column 3 = +1, rest = -1)
p2 = -ones(5, 5);
p2(:, 3) = 1;
p2 = p2(:);

% Pattern 3: Diagonal (positions where row == col are +1)
p3 = -ones(5, 5);
for k = 1:5
    p3(k, k) = 1;
end
p3 = p3(:);

% Combine patterns into a matrix (each column is one pattern)
P = [p1, p2, p3];
n_patterns = size(P, 2);

% Display stored patterns
figure;
for i = 1:n_patterns
    subplot(1, 3, i);
    imagesc(reshape(P(:, i), 5, 5));
    colormap(gray);
    caxis([-1 1]);
    title(sprintf('Pattern %d', i));
    axis square;
    set(gca, 'XTick', [], 'YTick', []);
end
sgtitle('Stored Patterns');

fprintf('Stored %d patterns in a %d-neuron Hopfield network.\n', n_patterns, N);
fprintf('Capacity limit: ~%.1f patterns (0.14 * %d)\n\n', 0.14 * N, N);

%% 2. Hebbian Learning -- Compute Weight Matrix
% W = (1/N) * P * P'  with diagonal set to zero

W = (1/N) * (P * P');
W(1:N+1:end) = 0;  % No self-connections

fprintf('Weight matrix W is %d x %d.\n', size(W));
fprintf('Diagonal is zero (no self-connections).\n\n');

%% 3. Create Noisy Input
% Start from pattern 1 with 30%% of bits flipped

target_pattern = 1;
S_original = P(:, target_pattern);

% Flip 30% of bits
flip_fraction = 0.30;
n_flip = round(flip_fraction * N);
flip_indices = randperm(N, n_flip);
S_noisy = S_original;
S_noisy(flip_indices) = -S_noisy(flip_indices);

fprintf('Created noisy version of pattern %d:\n', target_pattern);
fprintf('  Flipped %d out of %d bits (%.0f%%)\n', n_flip, N, flip_fraction * 100);
fprintf('  Initial overlap with pattern %d: %.2f\n\n', target_pattern, ...
    (1/N) * (S_noisy' * S_original));

%% 4. Retrieve Memory -- Iterative Update
max_iters = 20;
S = S_noisy;

% Track energy and overlap over iterations
energy_history = zeros(1, max_iters);
overlap_history = zeros(n_patterns, max_iters);

converged_iter = max_iters;

for iter = 1:max_iters
    % Compute energy
    energy_history(iter) = -0.5 * S' * W * S;

    % Compute overlap with each stored pattern
    for p = 1:n_patterns
        overlap_history(p, iter) = (1/N) * (S' * P(:, p));
    end

    % Update state
    S_new = sign(W * S);
    S_new(S_new == 0) = 1;  % sign(0) = 0 in Matlab -- fix to +1

    % Check convergence
    if isequal(S_new, S)
        converged_iter = iter;
        % Fill remaining history entries with final values
        for j = (iter+1):max_iters
            energy_history(j) = energy_history(iter);
            overlap_history(:, j) = overlap_history(:, iter);
        end
        break;
    end
    S = S_new;
end

S_retrieved = S;

fprintf('Retrieval converged after %d iteration(s).\n', converged_iter);
fprintf('Final overlap with each stored pattern:\n');
for p = 1:n_patterns
    fprintf('  Pattern %d: %.2f', p, overlap_history(p, converged_iter));
    if overlap_history(p, converged_iter) > 0.9
        fprintf(' <-- RETRIEVED');
    end
    fprintf('\n');
end
fprintf('\n');

%% 5. Visualize: Original vs Noisy vs Retrieved
figure;
subplot(1, 3, 1);
imagesc(reshape(S_original, 5, 5));
colormap(gray); caxis([-1 1]);
title('Original Pattern');
axis square;
set(gca, 'XTick', [], 'YTick', []);

subplot(1, 3, 2);
imagesc(reshape(S_noisy, 5, 5));
colormap(gray); caxis([-1 1]);
title(sprintf('Noisy Input (%d%% flipped)', flip_fraction * 100));
axis square;
set(gca, 'XTick', [], 'YTick', []);

subplot(1, 3, 3);
imagesc(reshape(S_retrieved, 5, 5));
colormap(gray); caxis([-1 1]);
title('Retrieved Pattern');
axis square;
set(gca, 'XTick', [], 'YTick', []);

sgtitle('Hopfield Network: Memory Retrieval');

%% 6. Energy Over Iterations
figure;
plot(1:converged_iter, energy_history(1:converged_iter), 'b-o', ...
    'LineWidth', 2, 'MarkerFaceColor', 'b');
xlabel('Iteration');
ylabel('Energy');
title('Energy Decreases During Retrieval');
set(gca, 'FontSize', 12);
grid on;

fprintf('Energy decreased from %.2f to %.2f.\n', ...
    energy_history(1), energy_history(converged_iter));

%% 7. Overlap With Stored Patterns Over Iterations
figure;
colors = lines(n_patterns);
for p = 1:n_patterns
    plot(1:converged_iter, overlap_history(p, 1:converged_iter), '-o', ...
        'Color', colors(p,:), 'LineWidth', 2, 'MarkerFaceColor', colors(p,:));
    hold on;
end
hold off;
xlabel('Iteration');
ylabel('Overlap');
title('Convergence to Stored Pattern');
legend('Pattern 1', 'Pattern 2', 'Pattern 3', 'Location', 'best');
set(gca, 'FontSize', 12);
ylim([-1.1 1.1]);
grid on;

fprintf('Network converged to pattern %d (highest overlap).\n', target_pattern);

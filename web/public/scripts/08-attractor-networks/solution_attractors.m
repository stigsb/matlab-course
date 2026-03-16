% solution_attractors.m - Complete solution for attractor networks exercise
% Part of: Matlab for Computational Neuroscience, Module 08
%
clear; clc; close all;
rng(42);

%% Part 1: Energy Landscapes (3 TODOs)

x = linspace(-2.5, 2.5, 500);

% TODO 1: Compute the energy
E = 0.5 * x.^4 - 2 * x.^2;

% TODO 2: Plot the energy landscape
figure;
plot(x, E, 'b-', 'LineWidth', 2);
xlabel('Network State');
ylabel('Energy');
title('Double-Well Energy Landscape');

% TODO 3: Add ball markers at starting positions
start_positions = [-2, -0.5, 0.5, 1.5];
hold on;
for i = 1:length(start_positions)
    [~, idx] = min(abs(x - start_positions(i)));
    plot(x(idx), E(idx), 'ro', 'MarkerSize', 12, 'MarkerFaceColor', 'r');
end
hold off;

% Predictions:
% x = -2.0 --> rolls to valley at left  (x ~ -1.41)
% x = -0.5 --> rolls to valley at left  (x ~ -1.41)
% x =  0.5 --> rolls to valley at right (x ~ +1.41)
% x =  1.5 --> rolls to valley at right (x ~ +1.41)

fprintf('Part 1 done: energy landscape with ball markers.\n');


%% Part 2: Building a Hopfield Network (4 TODOs)

N = 25;

% Pattern 1: Cross shape
p1 = -ones(5, 5);
p1(3, :) = 1;
p1(:, 3) = 1;
p1 = p1(:);

% Pattern 2: Frame/box shape
p2 = ones(5, 5);
p2(2:4, 2:4) = -1;
p2 = p2(:);

P = [p1, p2];
n_patterns = size(P, 2);

% TODO 4: Compute Hebbian weight matrix
W = (1/N) * (P * P');

% TODO 5: Set diagonal to zero
W(1:N+1:end) = 0;

% Create noisy version of pattern 1
flip_fraction = 0.30;
n_flip = round(flip_fraction * N);
flip_idx = randperm(N, n_flip);
S = p1;
S(flip_idx) = -S(flip_idx);
S_noisy = S;  % Save for visualization

% TODO 6: Run retrieval loop
max_iters = 20;
energy_history = zeros(1, max_iters);
converged_iter = max_iters;

for iter = 1:max_iters
    energy_history(iter) = -0.5 * S' * W * S;
    S_new = sign(W * S);
    S_new(S_new == 0) = 1;
    if isequal(S_new, S)
        converged_iter = iter;
        break;
    end
    S = S_new;
end

% TODO 7: Compute overlap
fprintf('Part 2 done: Hopfield network with %d patterns.\n', n_patterns);
fprintf('Converged after %d iterations.\n', converged_iter);
for p = 1:n_patterns
    ov = (1/N) * (S' * P(:, p));
    fprintf('  Overlap with pattern %d: %.2f\n', p, ov);
end


%% Part 3: Analyzing Retrieval (3 TODOs)

% TODO 8: Display triptych
figure;
subplot(1, 3, 1);
imagesc(reshape(p1, 5, 5));
colormap(gray); caxis([-1 1]);
title('Original');
axis square;
set(gca, 'XTick', [], 'YTick', []);

subplot(1, 3, 2);
imagesc(reshape(S_noisy, 5, 5));
colormap(gray); caxis([-1 1]);
title('Noisy Input');
axis square;
set(gca, 'XTick', [], 'YTick', []);

subplot(1, 3, 3);
imagesc(reshape(S, 5, 5));
colormap(gray); caxis([-1 1]);
title('Retrieved');
axis square;
set(gca, 'XTick', [], 'YTick', []);
sgtitle('Hopfield Retrieval');

% TODO 9: Print overlap with each pattern
fprintf('\nFinal overlaps:\n');
for p = 1:n_patterns
    ov = (1/N) * (S' * P(:, p));
    fprintf('Overlap with pattern %d: %.2f\n', p, ov);
end

% TODO 10: Plot energy over iterations
figure;
plot(1:converged_iter, energy_history(1:converged_iter), 'b-o', 'LineWidth', 2);
xlabel('Iteration');
ylabel('Energy');
title('Energy During Retrieval');
grid on;
set(gca, 'FontSize', 12);

fprintf('Part 3 done: visualization and analysis.\n');


%% Part 4: Ring Attractor (2 TODOs)

N_ring = 100;
theta = linspace(0, 2*pi, N_ring+1);
theta = theta(1:end-1);

% Pre-built connectivity matrix (Mexican hat)
W_ring = zeros(N_ring, N_ring);
for i = 1:N_ring
    for j = 1:N_ring
        W_ring(i, j) = cos(theta(i) - theta(j)) - 0.5;
    end
end
W_ring(1:N_ring+1:end) = 0;

% Initialize bump at 90 degrees
activity = exp(5 * cos(theta - pi/2));
activity = activity / sum(activity);

tau = 1;
dt = 0.1;
T = 50;
n_steps = round(T / dt);

% TODO 11: Run simulation loop
activity_history = zeros(n_steps, N_ring);
for step = 1:n_steps
    activity_history(step, :) = activity;
    input = (W_ring * activity')';
    activity = activity + (dt / tau) * (-activity + input);
    activity = max(0, activity);
    if sum(activity) > 0
        activity = activity / sum(activity);
    end
end

% TODO 12: Create heatmap
time_axis = (1:n_steps) * dt;
figure;
imagesc(time_axis, theta * 180/pi, activity_history');
set(gca, 'YDir', 'normal');
colorbar;
xlabel('Time (s)');
ylabel('Preferred Direction (degrees)');
title('Ring Attractor: Stable Bump');
set(gca, 'FontSize', 12);

fprintf('Part 4 done: ring attractor simulation.\n');

% Find final bump position
[~, peak_idx] = max(activity_history(end, :));
fprintf('Final bump position: %.0f degrees (started at 90 degrees).\n', ...
    theta(peak_idx) * 180/pi);


%% Optional Challenge: Overloading Memory

fprintf('\n--- Optional Challenge: Overloading Memory ---\n');

N_ch = 25;
n_test_patterns = 5;

% Create 5 random patterns
patterns_ch = sign(randn(N_ch, n_test_patterns));
patterns_ch(patterns_ch == 0) = 1;

% Hebbian learning
W_ch = (1/N_ch) * (patterns_ch * patterns_ch');
W_ch(1:N_ch+1:end) = 0;

fprintf('Storing %d patterns in %d neurons (capacity ~%.1f).\n', ...
    n_test_patterns, N_ch, 0.14 * N_ch);

% Try to retrieve each pattern from 30% noise
for p = 1:n_test_patterns
    S_ch = patterns_ch(:, p);
    n_flip_ch = round(0.30 * N_ch);
    flip_ch = randperm(N_ch, n_flip_ch);
    S_ch(flip_ch) = -S_ch(flip_ch);

    for iter = 1:50
        S_new_ch = sign(W_ch * S_ch);
        S_new_ch(S_new_ch == 0) = 1;
        if isequal(S_new_ch, S_ch)
            break;
        end
        S_ch = S_new_ch;
    end

    ov = (1/N_ch) * (S_ch' * patterns_ch(:, p));
    if ov > 0.9
        status = 'SUCCESS';
    else
        status = 'FAILED';
    end
    fprintf('  Pattern %d: overlap = %.2f [%s]\n', p, ov, status);
end

fprintf('\nWith 5 patterns (above capacity ~3.5), some retrievals fail.\n');
fprintf('The stored memories interfere with each other.\n');

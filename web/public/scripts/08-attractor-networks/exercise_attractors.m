% exercise_attractors.m - Practice energy landscapes, Hopfield networks, and ring attractors
% Part of: Matlab for Computational Neuroscience, Module 08
%
% Instructions: Fill in each TODO, then uncomment the fprintf line below it.
% Run the script after each part to check your work!
%
% There are 12 TODOs across 4 parts plus an optional challenge.
%
clear; clc; close all;
rng(42);

%% Part 1: Energy Landscapes (3 TODOs)
% Visualize a double-well energy landscape and predict attractor dynamics.

% The energy function is: E(x) = 0.5*x^4 - 2*x^2
x = linspace(-2.5, 2.5, 500);

% TODO 1: Compute the energy E for each value of x.
% E = ???

% TODO 2: Plot the energy landscape.
% figure;
% plot(x, E, 'b-', 'LineWidth', 2);
% xlabel('Network State');
% ylabel('Energy');
% title('Double-Well Energy Landscape');

% TODO 3: Add ball markers at these starting positions: x = -2, -0.5, 0.5, 1.5
% For each position, plot a red circle at (x, E(x)).
% Hint: find the nearest index with [~, idx] = min(abs(x - target_x));
% start_positions = [-2, -0.5, 0.5, 1.5];
% hold on;
% for i = 1:length(start_positions)
%     [~, idx] = min(abs(x - start_positions(i)));
%     plot(???, ???, 'ro', 'MarkerSize', 12, 'MarkerFaceColor', 'r');
% end
% hold off;

% Predict: which valley does each ball roll to? (Answer in comments)
% x = -2.0 --> rolls to valley at ??? (left / right)
% x = -0.5 --> rolls to valley at ??? (left / right)
% x =  0.5 --> rolls to valley at ??? (left / right)
% x =  1.5 --> rolls to valley at ??? (left / right)

% Uncomment to check:
% fprintf('Part 1 done: energy landscape with ball markers.\n');


%% Part 2: Building a Hopfield Network (4 TODOs)
% Store 2 patterns in a 25-neuron (5x5) Hopfield network.

N = 25;

% Pattern 1: Cross shape
p1 = -ones(5, 5);
p1(3, :) = 1;      % Horizontal bar
p1(:, 3) = 1;      % Vertical bar
p1 = p1(:);         % Flatten to column vector

% Pattern 2: Frame/box shape (border = +1, inside = -1)
p2 = ones(5, 5);
p2(2:4, 2:4) = -1;  % Hollow center
p2 = p2(:);

% Combine into pattern matrix
P = [p1, p2];
n_patterns = size(P, 2);

% TODO 4: Compute the Hebbian weight matrix W = (1/N) * (P * P')
% W = ???

% TODO 5: Set the diagonal of W to zero (no self-connections).
% Hint: the diagonal indices are 1, N+2, 2*N+3, ... or use 1:N+1:end
% W(???) = 0;

% Create a noisy version of pattern 1 for retrieval
flip_fraction = 0.30;
n_flip = round(flip_fraction * N);
flip_idx = randperm(N, n_flip);
S = p1;
S(flip_idx) = -S(flip_idx);

% TODO 6: Run the retrieval loop. Update S using sign(W * S).
% Remember: sign(0) = 0 in Matlab, replace with +1!
% max_iters = 20;
% energy_history = zeros(1, max_iters);
% converged_iter = max_iters;
%
% for iter = 1:max_iters
%     energy_history(iter) = -0.5 * S' * W * S;
%     S_new = sign(???);
%     S_new(S_new == 0) = 1;
%     if isequal(S_new, S)
%         converged_iter = iter;
%         break;
%     end
%     S = S_new;
% end

% TODO 7: Compute the overlap of the retrieved state with each stored pattern.
% overlap = (1/N) * (S' * pattern)
% for p = 1:n_patterns
%     ov = (1/N) * (S' * P(:, p));
%     fprintf('  Overlap with pattern %d: %.2f\n', p, ov);
% end

% Uncomment to check:
% fprintf('Part 2 done: Hopfield network with %d patterns.\n', n_patterns);
% fprintf('Converged after %d iterations.\n', converged_iter);


%% Part 3: Analyzing Retrieval (3 TODOs)
% Visualize the retrieval process.

% TODO 8: Display original, noisy, and retrieved patterns as a subplot triptych.
% Use imagesc(reshape(pattern, 5, 5)) with gray colormap.
% figure;
% subplot(1, 3, 1);
% imagesc(reshape(p1, 5, 5));
% colormap(gray); caxis([-1 1]);
% title('Original');
% axis square;
%
% subplot(1, 3, 2);
% imagesc(reshape(???, 5, 5));  % The noisy input (need to save it before loop!)
% colormap(gray); caxis([-1 1]);
% title('Noisy Input');
% axis square;
%
% subplot(1, 3, 3);
% imagesc(reshape(???, 5, 5));  % The retrieved state
% colormap(gray); caxis([-1 1]);
% title('Retrieved');
% axis square;

% TODO 9: Print the overlap with each stored pattern.
% for p = 1:n_patterns
%     ov = ???;
%     fprintf('Overlap with pattern %d: %.2f\n', p, ov);
% end

% TODO 10: Plot energy over iterations.
% figure;
% plot(1:converged_iter, energy_history(1:converged_iter), 'b-o', 'LineWidth', 2);
% xlabel('Iteration');
% ylabel('Energy');
% title('Energy During Retrieval');

% Uncomment to check:
% fprintf('Part 3 done: visualization and analysis.\n');


%% Part 4: Ring Attractor (2 TODOs)
% Simulate a ring attractor that maintains a bump of activity.

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

% Simulation parameters
tau = 1;
dt = 0.1;
T = 50;
n_steps = round(T / dt);

% TODO 11: Run the simulation loop.
% For each step:
%   1. Store current activity in activity_history(step, :)
%   2. Compute input = (W_ring * activity')'
%   3. Update: activity = activity + (dt/tau) * (-activity + input)
%   4. Rectify: activity = max(0, activity)
%   5. Normalize: activity = activity / sum(activity)
%
% activity_history = zeros(n_steps, N_ring);
% for step = 1:n_steps
%     ???
% end

% TODO 12: Create a heatmap of activity over time.
% time_axis = (1:n_steps) * dt;
% figure;
% imagesc(time_axis, theta * 180/pi, activity_history');
% set(gca, 'YDir', 'normal');
% colorbar;
% xlabel('Time (s)');
% ylabel('Preferred Direction (degrees)');
% title('Ring Attractor: Stable Bump');

% Uncomment to check:
% fprintf('Part 4 done: ring attractor simulation.\n');


%% Optional Challenge: Overloading Memory
% What happens when you exceed the Hopfield network's capacity?
%
% The capacity limit is ~0.14 * N. For N = 25, that's about 3.5 patterns.
% Try storing 5 patterns and retrieving each one.
%
% 1. Create 5 random patterns: patterns = sign(randn(N, 5));
%    (replace zeros with +1)
% 2. Compute W using Hebbian learning
% 3. For each pattern, add 30% noise and try to retrieve
% 4. Compute overlap after retrieval
%
% Questions:
%   - Which patterns are retrieved correctly (overlap > 0.9)?
%   - Which ones fail? Why?
%   - What happens if you try 10 patterns?

% Your code here:

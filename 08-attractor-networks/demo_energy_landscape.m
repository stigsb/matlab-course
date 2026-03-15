% MODULE 08: ATTRACTOR NETWORKS -- Energy Landscape Visualization
% Visualize energy landscapes as the ball-in-bowl metaphor for attractors.
%
% Part of the Matlab for Computational Neuroscience course
% Module 08: Attractor Networks
%
% What you'll see when you run this:
%   Figure 1: 1D double-well potential with two valleys (memories)
%   Figure 2: Multiple starting positions rolling to different valleys
%   Figure 3: 2D energy landscape with two basins (surface + contour)

clear; clc; close all;
rng(42);

%% 1. Double-Well Energy Landscape (1D)
% Energy function: E(x) = 0.5*x^4 - 2*x^2
% This creates two valleys (stable states) separated by a hill.

x = linspace(-2.5, 2.5, 500);
E = 0.5 * x.^4 - 2 * x.^2;

% Find the two minima and the maximum between them
[~, idx_min1] = min(abs(x - (-sqrt(2))));  % Left valley at x = -sqrt(2)
[~, idx_min2] = min(abs(x - sqrt(2)));     % Right valley at x = +sqrt(2)
[~, idx_max]  = min(abs(x));               % Hill at x = 0

figure;
plot(x, E, 'b-', 'LineWidth', 2);
hold on;

% Mark the valleys
plot(x(idx_min1), E(idx_min1), 'ro', 'MarkerSize', 15, 'MarkerFaceColor', 'r');
plot(x(idx_min2), E(idx_min2), 'ro', 'MarkerSize', 15, 'MarkerFaceColor', 'r');

% Label valleys and hill
text(x(idx_min1), E(idx_min1) - 0.4, 'Memory 1', ...
    'HorizontalAlignment', 'center', 'FontSize', 12, 'FontWeight', 'bold');
text(x(idx_min2), E(idx_min2) - 0.4, 'Memory 2', ...
    'HorizontalAlignment', 'center', 'FontSize', 12, 'FontWeight', 'bold');
text(0, E(idx_max) + 0.3, 'Unstable', ...
    'HorizontalAlignment', 'center', 'FontSize', 11, 'Color', [0.6 0 0]);

hold off;
xlabel('Network State');
ylabel('Energy');
title('Energy Landscape: Two Valleys = Two Memories');
set(gca, 'FontSize', 12);

fprintf('Valleys = stable states (memories). The ball always rolls downhill.\n');
fprintf('Left valley at x = %.2f, Energy = %.2f\n', x(idx_min1), E(idx_min1));
fprintf('Right valley at x = %.2f, Energy = %.2f\n', x(idx_min2), E(idx_min2));
fprintf('Hill (unstable) at x = 0, Energy = %.2f\n\n', E(idx_max));

%% 2. Multiple Starting Positions -- Where Does the Ball Roll?
% Different initial states roll to different valleys.

start_positions = [-2.0, -0.8, -0.3, 0.3, 1.0, 2.2];
colors = lines(length(start_positions));

figure;
plot(x, E, 'b-', 'LineWidth', 2);
hold on;

% Mark valleys
plot(x(idx_min1), E(idx_min1), 'ko', 'MarkerSize', 12, 'MarkerFaceColor', [0.3 0.8 0.3]);
plot(x(idx_min2), E(idx_min2), 'ko', 'MarkerSize', 12, 'MarkerFaceColor', [0.3 0.8 0.3]);

% Show each starting position with an arrow toward its destination valley
for i = 1:length(start_positions)
    sx = start_positions(i);
    [~, si] = min(abs(x - sx));
    se = E(si);

    % Plot starting ball
    plot(sx, se, 'o', 'MarkerSize', 10, 'MarkerFaceColor', colors(i,:), ...
        'MarkerEdgeColor', 'k');

    % Determine which valley it rolls to
    if sx < 0
        dest_x = x(idx_min1);
    else
        dest_x = x(idx_min2);
    end

    % Draw arrow showing direction of roll
    arrow_dx = (dest_x - sx) * 0.3;
    quiver(sx, se, arrow_dx, 0, 0, 'Color', colors(i,:), ...
        'LineWidth', 1.5, 'MaxHeadSize', 0.8);

    label = sprintf('Start at %.1f', sx);
    text(sx, se + 0.3, label, 'HorizontalAlignment', 'center', ...
        'FontSize', 9, 'Color', colors(i,:));
end

hold off;
xlabel('Network State');
ylabel('Energy');
title('Different Starting States Roll to Different Memories');
set(gca, 'FontSize', 12);

fprintf('Each starting position rolls to the nearest valley:\n');
for i = 1:length(start_positions)
    if start_positions(i) < 0
        dest = 'Memory 1 (left)';
    else
        dest = 'Memory 2 (right)';
    end
    fprintf('  Start at %.1f --> %s\n', start_positions(i), dest);
end
fprintf('\n');

%% 3. 2D Energy Landscape
% Two basins of attraction in 2D, visualized as a surface.

[X, Y] = meshgrid(linspace(-2.5, 2.5, 100));

% Two Gaussian basins creating a landscape with two valleys
E2D = 2 - 1.5 * exp(-((X-1).^2 + (Y-1).^2) / 0.8) ...
        - 1.5 * exp(-((X+1).^2 + (Y+1).^2) / 0.8) ...
        + 0.1 * (X.^2 + Y.^2);

figure;

% Surface plot
subplot(1, 2, 1);
surf(X, Y, E2D, 'EdgeColor', 'none', 'FaceAlpha', 0.9);
colormap(parula);
xlabel('State Dimension 1');
ylabel('State Dimension 2');
zlabel('Energy');
title('2D Energy Landscape');
view(-35, 45);
set(gca, 'FontSize', 11);

% Contour plot (top-down view)
subplot(1, 2, 2);
contourf(X, Y, E2D, 20);
colorbar;
hold on;
% Mark the two basins
plot(1, 1, 'r*', 'MarkerSize', 15, 'LineWidth', 2);
plot(-1, -1, 'r*', 'MarkerSize', 15, 'LineWidth', 2);
text(1.3, 1, 'Basin 1', 'FontSize', 11, 'FontWeight', 'bold', 'Color', 'r');
text(-0.7, -1, 'Basin 2', 'FontSize', 11, 'FontWeight', 'bold', 'Color', 'r');
hold off;
xlabel('State Dimension 1');
ylabel('State Dimension 2');
title('Top-Down View (Contour)');
set(gca, 'FontSize', 11);

fprintf('2D landscape: two basins of attraction visible as dark regions in contour plot.\n');
fprintf('Each basin pulls nearby states toward its center.\n');

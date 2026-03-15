% demo_vector_arrows.m - Visualize 2D vectors as arrows using quiver()
% Part of: Matlab for Computational Neuroscience, Module 02
%
% Run this script to see: vectors drawn as arrows, vector addition
% head-to-tail, and direction vs magnitude visualizations.
%
% This is the "notation bridge" demo: you will SEE vectors as arrows
% before learning any math notation.
%
clear; clc; close all;

%% Two Vectors as Arrows
% A vector tells you where to walk from the origin.
% v1 = [3, 4] means "3 steps east, 4 steps north"
% v2 = [-2, 1] means "2 steps west, 1 step north"

v1 = [3, 4];
v2 = [-2, 1];

figure(1);
quiver(0, 0, v1(1), v1(2), 0, 'b', 'LineWidth', 2);
hold on;
quiver(0, 0, v2(1), v2(2), 0, 'r', 'LineWidth', 2);

% Mark the origin
plot(0, 0, 'ko', 'MarkerSize', 8, 'MarkerFaceColor', 'k');
hold off;

axis equal;
grid on;
xlim([-4, 5]);
ylim([-1, 6]);
xlabel('East-West');
ylabel('North-South');
title('Vectors as Arrows: Direction and Magnitude');
legend(sprintf('v1 = [3, 4], length = %.1f', norm(v1)), ...
       sprintf('v2 = [-2, 1], length = %.1f', norm(v2)), ...
       'Origin', 'Location', 'northwest');

fprintf('v1 = [3, 4], magnitude = %.1f\n', norm(v1));
fprintf('v2 = [-2, 1], magnitude = %.1f\n', norm(v2));

%% Vector Addition: Head to Tail
% To add vectors: place the tail of v2 at the tip of v1.
% The sum goes from the origin to where you end up.

v_sum = v1 + v2;

figure(2);
% Draw v1 from origin (blue)
quiver(0, 0, v1(1), v1(2), 0, 'b', 'LineWidth', 2);
hold on;

% Draw v2 starting from the TIP of v1 (red)
quiver(v1(1), v1(2), v2(1), v2(2), 0, 'r', 'LineWidth', 2);

% Draw the sum from origin (green, dashed)
quiver(0, 0, v_sum(1), v_sum(2), 0, 'g', 'LineWidth', 2.5);

% Mark key points
plot(0, 0, 'ko', 'MarkerSize', 8, 'MarkerFaceColor', 'k');
plot(v_sum(1), v_sum(2), 'g^', 'MarkerSize', 10, 'MarkerFaceColor', 'g');
hold off;

axis equal;
grid on;
xlim([-3, 5]);
ylim([-1, 7]);
xlabel('East-West');
ylabel('North-South');
title('Vector Addition: Head to Tail');
legend(sprintf('v1 = [%d, %d]', v1), ...
       sprintf('v2 = [%d, %d]', v2), ...
       sprintf('v1 + v2 = [%d, %d]', v_sum), ...
       'Origin', 'End point', 'Location', 'northwest');

fprintf('\nVector addition:\n');
fprintf('v1 + v2 = [%d, %d] + [%d, %d] = [%d, %d]\n', ...
    v1(1), v1(2), v2(1), v2(2), v_sum(1), v_sum(2));
fprintf('Sum magnitude = %.1f\n', norm(v_sum));

%% Direction and Magnitude
% Direction = where the arrow points
% Magnitude = how long the arrow is (use norm())

figure(3);

% Subplot 1: Same LENGTH, different DIRECTIONS (unit circle points)
subplot(1, 2, 1);
n_arrows = 8;
angles = linspace(0, 2*pi, n_arrows + 1);
angles = angles(1:end-1);  % Remove duplicate at 2*pi

colors = lines(n_arrows);
for i = 1:n_arrows
    vx = cos(angles(i));
    vy = sin(angles(i));
    quiver(0, 0, vx, vy, 0, 'Color', colors(i,:), 'LineWidth', 2);
    hold on;
end
plot(0, 0, 'ko', 'MarkerSize', 6, 'MarkerFaceColor', 'k');
hold off;

axis equal;
grid on;
xlim([-1.5, 1.5]);
ylim([-1.5, 1.5]);
title('Same Magnitude, Different Directions');
xlabel('x');
ylabel('y');

% Subplot 2: Same DIRECTION, different LENGTHS
subplot(1, 2, 2);
direction = [1, 1] / norm([1, 1]);  % Unit vector pointing northeast
lengths = [0.5, 1.0, 1.5, 2.0, 2.5];

colors_len = lines(length(lengths));
legend_entries = cell(1, length(lengths));
for i = 1:length(lengths)
    v = direction .* lengths(i);
    quiver(0, 0, v(1), v(2), 0, 'Color', colors_len(i,:), 'LineWidth', 2);
    hold on;
    legend_entries{i} = sprintf('length = %.1f', lengths(i));
end
plot(0, 0, 'ko', 'MarkerSize', 6, 'MarkerFaceColor', 'k');
hold off;

axis equal;
grid on;
xlim([-0.5, 2.5]);
ylim([-0.5, 2.5]);
title('Same Direction, Different Magnitudes');
xlabel('x');
ylabel('y');
legend(legend_entries, 'Location', 'southeast');

sgtitle('Direction vs Magnitude');

% Print magnitudes
fprintf('\n--- Magnitude (norm) of each vector ---\n');
fprintf('v1 = [3, 4]: norm = %.1f\n', norm(v1));
fprintf('v2 = [-2, 1]: norm = %.1f\n', norm(v2));
fprintf('v1 + v2 = [%d, %d]: norm = %.1f\n', v_sum(1), v_sum(2), norm(v_sum));

fprintf('\nDone! You should see 3 figures.\n');
fprintf('Remember: norm(v) in Matlab = ||v|| in math = Pythagoras!\n');

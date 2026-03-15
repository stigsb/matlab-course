% solution_plotting.m - Complete solution for exercise_plotting.m
% Part of: Matlab for Computational Neuroscience, Module 02
%
% This is the solution file. Try the exercise first!
% Running this script produces a multi-panel figure.
%
clear; clc; close all;

%% Part 1: Line Plot

x = linspace(0, 4*pi, 200);

% TODO 1: Compute y = sin(x)
y = sin(x);

figure(1);
plot(x, y, 'b-', 'LineWidth', 2);
xlabel('Angle (radians)');
ylabel('sin(x)');
title('A Beautiful Sine Wave');
grid on;

fprintf('Part 1: Sine wave plotted\n');

%% Part 2: Scatter Plot

rng(42);
x_data = rand(1, 30) .* 10;
y_data = rand(1, 30) .* 10;

% TODO 2: Create a scatter plot
figure(2);
scatter(x_data, y_data, 80, 'filled');
xlabel('X');
ylabel('Y');
title('Random Scatter Plot');
grid on;

fprintf('Part 2: Scatter plot created\n');

%% Part 3: Bar Chart

% TODO 3: Create a vector of 5 horse riding speeds
speeds = [6, 15, 25, 45, 55];

horse_gaits = {'Walk', 'Trot', 'Canter', 'Gallop', 'Sprint'};

% TODO 4: Create the bar chart
figure(3);
bar(speeds);
set(gca, 'XTickLabel', horse_gaits);
ylabel('Speed (km/h)');
title('Horse Riding Speeds');
grid on;

fprintf('Part 3: Bar chart of horse speeds\n');

%% Part 4: Heatmap

% TODO 5: Create a 6x6 random matrix
heat_data = rand(6, 6);

% TODO 6: Display as heatmap with colorbar
figure(4);
imagesc(heat_data);
colorbar;
xlabel('Column');
ylabel('Row');
title('Random Heatmap');

fprintf('Part 4: Heatmap displayed\n');

%% Part 5: Challenge -- Subplot

figure(5);

% Top-left: Line plot
subplot(2, 2, 1);
plot(x, y, 'b-', 'LineWidth', 2);
title('Sine Wave');
grid on;

% Top-right: Scatter plot
subplot(2, 2, 2);
scatter(x_data, y_data, 80, 'filled');
title('Scatter');
grid on;

% Bottom-left: Bar chart
subplot(2, 2, 3);
bar(speeds);
set(gca, 'XTickLabel', horse_gaits);
title('Horse Speeds');
grid on;

% Bottom-right: Heatmap
subplot(2, 2, 4);
imagesc(heat_data);
colorbar;
title('Heatmap');

sgtitle('My Four-Panel Figure');

fprintf('Part 5: Four-panel subplot figure created\n');
fprintf('\nAll done! You should see 5 figures.\n');

% demo_plotting.m - All four plot types with labels, legend, and subplots
% Part of: Matlab for Computational Neuroscience, Module 02
%
% Run this script to see: line plots, scatter plots, bar charts,
% heatmaps, and a combined subplot figure.
%
clear; clc; close all;

%% Line Plot
% Sine and cosine waves -- the bread and butter of scientific plotting

x = linspace(0, 2*pi, 100);
y_sin = sin(x);
y_cos = cos(x);

figure(1);
plot(x, y_sin, 'b-', 'LineWidth', 2);
hold on;
plot(x, y_cos, 'r--', 'LineWidth', 2);
hold off;

xlabel('Angle (radians)');
ylabel('Value');
title('Sine and Cosine Waves');
legend('sin(x)', 'cos(x)', 'Location', 'southwest');
grid on;

fprintf('Figure 1: Line plot of sin and cos\n');

%% Scatter Plot
% Random data with colored points -- imagine cat weights vs ages

rng(42);  % Set random seed for reproducibility
cat_ages = [2, 5, 1, 8, 3, 6, 4, 7, 10, 12];
cat_weights = [3.5, 4.2, 2.8, 5.1, 3.8, 4.7, 4.0, 5.3, 4.9, 4.5];
cat_happiness = [8, 7, 9, 6, 8, 5, 7, 4, 6, 5];  % For coloring

figure(2);
scatter(cat_ages, cat_weights, 100, cat_happiness, 'filled');
colorbar;

xlabel('Cat Age (years)');
ylabel('Cat Weight (kg)');
title('Cat Age vs Weight (color = happiness score)');
grid on;

fprintf('Figure 2: Scatter plot of cats\n');

%% Bar Chart
% Family member ages -- simple and clear

family_names = {'Stig', 'Christel', 'Ravn', 'Helena'};
family_ages = [42, 40, 11, 8];

figure(3);
bar(family_ages, 'FaceColor', [0.3 0.7 0.4]);
set(gca, 'XTickLabel', family_names);
ylabel('Age (years)');
title('Family Ages');
grid on;

fprintf('Figure 3: Bar chart of family ages\n');

%% Heatmap
% A 5x5 matrix visualized as colors -- like a temperature map

garden_data = rand(5, 5) .* 30 + 10;  % Random "temperatures" between 10 and 40

figure(4);
imagesc(garden_data);
colorbar;
xlabel('Column');
ylabel('Row');
title('Garden Soil Temperatures (°C)');

fprintf('Figure 4: Heatmap of garden temperatures\n');

%% Subplots -- All Four in One Figure
% Use subplot(rows, cols, position) to arrange plots

figure(5);

% Top-left: Line plot
subplot(2, 2, 1);
plot(x, y_sin, 'b-', 'LineWidth', 2);
hold on;
plot(x, y_cos, 'r--', 'LineWidth', 2);
hold off;
title('Line Plot');
xlabel('x');
ylabel('y');
legend('sin', 'cos', 'Location', 'southwest');
grid on;

% Top-right: Scatter plot
subplot(2, 2, 2);
scatter(cat_ages, cat_weights, 80, cat_happiness, 'filled');
colorbar;
title('Scatter Plot');
xlabel('Age');
ylabel('Weight');
grid on;

% Bottom-left: Bar chart
subplot(2, 2, 3);
bar(family_ages, 'FaceColor', [0.3 0.7 0.4]);
set(gca, 'XTickLabel', family_names);
title('Bar Chart');
ylabel('Age');
grid on;

% Bottom-right: Heatmap
subplot(2, 2, 4);
imagesc(garden_data);
colorbar;
title('Heatmap');

sgtitle('Four Ways to Visualize Data');

fprintf('Figure 5: All four plot types combined with subplot\n');
fprintf('\nDone! You should see 5 figures.\n');

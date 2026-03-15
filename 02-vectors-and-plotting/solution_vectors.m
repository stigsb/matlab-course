% solution_vectors.m - Complete solution for exercise_vectors.m
% Part of: Matlab for Computational Neuroscience, Module 02
%
% This is the solution file. Try the exercise first!
%
clear; clc; close all;

%% Part 1: Create Vectors

% Example: Cat weights using bracket notation
cat_weights = [4.2, 3.8, 5.1, 3.5, 4.7];
fprintf('Cat weights: ');
fprintf('%.1f ', cat_weights);
fprintf('\n');

% TODO 1: Create a vector of 7 daily temperatures
daily_temps = [18.5, 20.1, 19.3, 22.0, 21.5, 17.8, 20.0];

fprintf('Daily temperatures: ');
fprintf('%.1f ', daily_temps);
fprintf('\n');

% TODO 2: Create a vector of numbers from 1 to 100 using the colon operator
numbers = 1:100;

fprintf('Numbers vector has %d elements\n', length(numbers));

% TODO 3: Create 50 evenly spaced points from 0 to 2*pi using linspace
smooth_angles = linspace(0, 2*pi, 50);

fprintf('Smooth angles has %d points, from %.2f to %.2f\n', ...
    length(smooth_angles), smooth_angles(1), smooth_angles(end));

%% Part 2: Indexing Practice

plant_heights = [12, 8, 15, 22, 6, 18, 10, 14];
fprintf('\nPlant heights: ');
fprintf('%d ', plant_heights);
fprintf('\n');

% TODO 4: Get the 3rd element
third_plant = plant_heights(3);

fprintf('Third plant height: %d cm\n', third_plant);

% TODO 5: Get elements 2 through 5
middle_plants = plant_heights(2:5);

fprintf('Plants 2 to 5: ');
fprintf('%d ', middle_plants);
fprintf('\n');

% TODO 6: Get the last element using end
last_plant = plant_heights(end);

fprintf('Last plant height: %d cm\n', last_plant);

% TODO 7: Get all elements except the first one
all_but_first = plant_heights(2:end);

fprintf('All except first: ');
fprintf('%d ', all_but_first);
fprintf('\n');

%% Part 3: Matrix Practice

%              Length  Width  Height
garden = [     2.5,    1.2,   0.3;
               3.0,    1.5,   0.4;
               1.8,    2.0,   0.3;
               2.2,    1.0,   0.5];

fprintf('\nGarden measurements matrix:\n');
disp(garden);

% TODO 8: Get element at row 2, column 3
plot2_height = garden(2, 3);

fprintf('Garden plot 2 height: %.1f m\n', plot2_height);

% TODO 9: Get entire first row
plot1_all = garden(1, :);

fprintf('Garden plot 1: length=%.1f, width=%.1f, height=%.1f\n', ...
    plot1_all(1), plot1_all(2), plot1_all(3));

% TODO 10: Get entire second column (all widths)
all_widths = garden(:, 2);

fprintf('All widths: ');
fprintf('%.1f ', all_widths);
fprintf('\n');

% TODO 11: Use size() to find dimensions
[num_plots, num_measurements] = size(garden);

fprintf('Garden matrix: %d plots x %d measurements\n', num_plots, num_measurements);

%% Part 4: Element-wise Operations

horse_speeds_kmh = [12, 25, 40, 55, 35];
fprintf('\nHorse speeds (km/h): ');
fprintf('%d ', horse_speeds_kmh);
fprintf('\n');

% TODO 12: Convert to miles per hour
horse_speeds_mph = horse_speeds_kmh .* 0.621;

fprintf('Horse speeds (mph): ');
fprintf('%.1f ', horse_speeds_mph);
fprintf('\n');

% TODO 13: Square each speed
speeds_squared = horse_speeds_kmh .^ 2;

fprintf('Speeds squared: ');
fprintf('%d ', speeds_squared);
fprintf('\n');

% Visualization
figure;
subplot(1, 2, 1);
bar([horse_speeds_kmh; horse_speeds_mph]', 'grouped');
legend('km/h', 'mph');
title('Horse Speeds: km/h vs mph');
ylabel('Speed');
grid on;

subplot(1, 2, 2);
bar(speeds_squared, 'FaceColor', [0.8 0.4 0.4]);
title('Horse Speeds Squared');
ylabel('Speed^2');
grid on;

fprintf('\nAll done! You should see a figure with two bar charts.\n');

% exercise_vectors.m - Practice with vectors, indexing, and element-wise operations
% Part of: Matlab for Computational Neuroscience, Module 02
%
% Instructions: Fill in the lines marked with % TODO.
% After each TODO, uncomment the fprintf/disp line below it to check your answer.
%
clear; clc; close all;

%% Part 1: Create Vectors
% Three ways to create vectors in Matlab

% Example: Cat weights using bracket notation
cat_weights = [4.2, 3.8, 5.1, 3.5, 4.7];
fprintf('Cat weights: ');
fprintf('%.1f ', cat_weights);
fprintf('\n');

% TODO 1: Create a vector of 7 daily temperatures (make up realistic values in Celsius)
% Hint: Use bracket notation, e.g., [18, 20, ...]
% daily_temps = ???

% fprintf('Daily temperatures: ');
% fprintf('%.1f ', daily_temps);
% fprintf('\n');

% TODO 2: Create a vector of numbers from 1 to 100 using the colon operator
% Hint: start:stop
% numbers = ???

% fprintf('Numbers vector has %d elements\n', length(numbers));

% TODO 3: Create 50 evenly spaced points from 0 to 2*pi using linspace
% Hint: linspace(start, stop, number_of_points)
% smooth_angles = ???

% fprintf('Smooth angles has %d points, from %.2f to %.2f\n', ...
%     length(smooth_angles), smooth_angles(1), smooth_angles(end));

%% Part 2: Indexing Practice
% Getting specific elements from a vector

plant_heights = [12, 8, 15, 22, 6, 18, 10, 14];
fprintf('\nPlant heights: ');
fprintf('%d ', plant_heights);
fprintf('\n');

% TODO 4: Get the 3rd element of plant_heights
% Hint: vector(index) -- remember, Matlab starts at 1!
% third_plant = ???

% fprintf('Third plant height: %d cm\n', third_plant);

% TODO 5: Get elements 2 through 5 of plant_heights
% Hint: vector(start:stop)
% middle_plants = ???

% fprintf('Plants 2 to 5: ');
% fprintf('%d ', middle_plants);
% fprintf('\n');

% TODO 6: Get the last element using the end keyword
% Hint: vector(end)
% last_plant = ???

% fprintf('Last plant height: %d cm\n', last_plant);

% TODO 7: Get all elements EXCEPT the first one
% Hint: vector(2:end)
% all_but_first = ???

% fprintf('All except first: ');
% fprintf('%d ', all_but_first);
% fprintf('\n');

%% Part 3: Matrix Practice
% Working with rows and columns

% Garden plot measurements (4 plots, 3 measurements each)
%              Length  Width  Height
garden = [     2.5,    1.2,   0.3;
               3.0,    1.5,   0.4;
               1.8,    2.0,   0.3;
               2.2,    1.0,   0.5];

fprintf('\nGarden measurements matrix:\n');
disp(garden);

% TODO 8: Get the element at row 2, column 3 (height of garden plot 2)
% Hint: matrix(row, column)
% plot2_height = ???

% fprintf('Garden plot 2 height: %.1f m\n', plot2_height);

% TODO 9: Get the entire first row (all measurements of garden plot 1)
% Hint: matrix(row, :) -- the colon means "all columns"
% plot1_all = ???

% fprintf('Garden plot 1: length=%.1f, width=%.1f, height=%.1f\n', ...
%     plot1_all(1), plot1_all(2), plot1_all(3));

% TODO 10: Get the entire second column (all widths)
% Hint: matrix(:, column) -- the colon means "all rows"
% all_widths = ???

% fprintf('All widths: ');
% fprintf('%.1f ', all_widths);
% fprintf('\n');

% TODO 11: Use size() to find the dimensions of the garden matrix
% Hint: [rows, cols] = size(matrix)
% [num_plots, num_measurements] = ???

% fprintf('Garden matrix: %d plots x %d measurements\n', num_plots, num_measurements);

%% Part 4: Element-wise Operations
% Remember the dot-prefix rule: .* ./ .^ mean "do it to each element"

horse_speeds_kmh = [12, 25, 40, 55, 35];  % Different gaits in km/h
fprintf('\nHorse speeds (km/h): ');
fprintf('%d ', horse_speeds_kmh);
fprintf('\n');

% TODO 12: Convert speeds to miles per hour (1 km = 0.621 miles)
% Hint: Use .* for element-wise multiplication
% horse_speeds_mph = ???

% fprintf('Horse speeds (mph): ');
% fprintf('%.1f ', horse_speeds_mph);
% fprintf('\n');

% TODO 13: Compute the square of each speed using .^
% Hint: vector .^ power
% speeds_squared = ???

% fprintf('Speeds squared: ');
% fprintf('%d ', speeds_squared);
% fprintf('\n');

% Visualize the results -- this part is pre-written!
% Uncomment after completing TODOs 12 and 13:

% figure;
% subplot(1, 2, 1);
% bar([horse_speeds_kmh; horse_speeds_mph]', 'grouped');
% legend('km/h', 'mph');
% title('Horse Speeds: km/h vs mph');
% ylabel('Speed');
% grid on;
%
% subplot(1, 2, 2);
% bar(speeds_squared, 'FaceColor', [0.8 0.4 0.4]);
% title('Horse Speeds Squared');
% ylabel('Speed^2');
% grid on;

fprintf('\nDone! If you filled all TODOs, uncomment the fprintf lines to check.\n');
fprintf('Then uncomment the figure code at the end for a nice bar chart.\n');

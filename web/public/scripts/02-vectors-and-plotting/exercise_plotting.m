% exercise_plotting.m - Practice creating plots with labels and formatting
% Part of: Matlab for Computational Neuroscience, Module 02
%
% Instructions: Fill in the lines marked with % TODO.
% Most of the plotting code is already written -- you just need to
% create the data or add the right plot command.
%
clear; clc; close all;

%% Part 1: Line Plot
% Plot a sine wave

x = linspace(0, 4*pi, 200);

% TODO 1: Compute y = sin(x)
% Hint: y = sin(x) -- Matlab has built-in trig functions
% y = ???

% The plotting code is ready -- just fill in the TODO above
% figure(1);
% plot(x, y, 'b-', 'LineWidth', 2);
% xlabel('Angle (radians)');
% ylabel('sin(x)');
% title('A Beautiful Sine Wave');
% grid on;

fprintf('Part 1: Fill in TODO 1, then uncomment the figure code\n');

%% Part 2: Scatter Plot
% Visualize random data as scattered points

rng(42);  % Makes the random numbers the same every time
x_data = rand(1, 30) .* 10;   % 30 random x values from 0 to 10
y_data = rand(1, 30) .* 10;   % 30 random y values from 0 to 10

% TODO 2: Create a scatter plot of x_data vs y_data
% Use size 80 and 'filled' style
% Hint: scatter(x, y, size, 'filled')
% figure(2);
% ???
% xlabel('X');
% ylabel('Y');
% title('Random Scatter Plot');
% grid on;

fprintf('Part 2: Fill in TODO 2 with a scatter() call\n');

%% Part 3: Bar Chart
% Compare horse riding speeds

% TODO 3: Create a vector of 5 horse riding speeds in km/h
% Use realistic values: walk ~6, trot ~15, canter ~25, gallop ~45, sprint ~55
% Hint: speeds = [6, 15, ...]
% speeds = ???

horse_gaits = {'Walk', 'Trot', 'Canter', 'Gallop', 'Sprint'};

% TODO 4: Create the bar chart using bar(speeds)
% Hint: bar(values) creates a bar chart
% figure(3);
% ???
% set(gca, 'XTickLabel', horse_gaits);
% ylabel('Speed (km/h)');
% title('Horse Riding Speeds');
% grid on;

fprintf('Part 3: Fill in TODOs 3 and 4\n');

%% Part 4: Heatmap
% Visualize a matrix as colors

% TODO 5: Create a 6x6 matrix of random numbers using rand()
% Hint: rand(rows, cols)
% heat_data = ???

% TODO 6: Display it as a heatmap using imagesc() and add a colorbar
% Hint: imagesc(matrix) then colorbar on the next line
% figure(4);
% ???
% ???
% xlabel('Column');
% ylabel('Row');
% title('Random Heatmap');

fprintf('Part 4: Fill in TODOs 5 and 6\n');

%% Part 5: Challenge -- Subplot
% Combine all four plots in a 2x2 grid using subplot()
% This is the challenge section -- bring it all together!

% TODO 7: Create a figure with all four plots arranged in a 2x2 grid
% The subplot() calls are provided -- fill in the plot commands

% figure(5);
%
% % Top-left: Line plot (use x and y from Part 1)
% subplot(2, 2, 1);
% % TODO: Add your plot command here
% title('Sine Wave');
% grid on;
%
% % Top-right: Scatter plot (use x_data and y_data from Part 2)
% subplot(2, 2, 2);
% % TODO: Add your scatter command here
% title('Scatter');
% grid on;
%
% % Bottom-left: Bar chart (use speeds from Part 3)
% subplot(2, 2, 3);
% % TODO: Add your bar command here
% set(gca, 'XTickLabel', horse_gaits);
% title('Horse Speeds');
% grid on;
%
% % Bottom-right: Heatmap (use heat_data from Part 4)
% subplot(2, 2, 4);
% % TODO: Add your imagesc command here
% colorbar;
% title('Heatmap');
%
% sgtitle('My Four-Panel Figure');

fprintf('Part 5 (Challenge): Fill in TODO 7 to make a subplot figure\n');
fprintf('\nRemember: uncomment each section after filling its TODOs!\n');

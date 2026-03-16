% demo_vectors.m - Creating vectors, indexing, and element-wise operations
% Part of: Matlab for Computational Neuroscience, Module 02
%
% Run this script to see: bar charts of cat weights, indexing examples,
% and element-wise operations in action.
%
clear; clc; close all;

%% Creating Vectors
% Three ways to create vectors in Matlab

% Way 1: Bracket notation -- type the numbers
cat_weights = [4.2, 3.8, 5.1, 3.5, 4.7];
cat_names = {'Whiskers', 'Mittens', 'Enzo', 'Shadow', 'Luna'};

% Show a plot RIGHT AWAY
figure(1);
bar(cat_weights, 'FaceColor', [0.4 0.7 0.9]);
set(gca, 'XTickLabel', cat_names);
ylabel('Weight (kg)');
title('Cat Weights at the Vet');
grid on;

fprintf('Cat weights (kg): ');
fprintf('%.1f ', cat_weights);
fprintf('\n');

% Way 2: Colon operator -- create a range
days = 1:7;
fprintf('Days of the week: %d %d %d %d %d %d %d\n', days);

angles = 0:0.5:2*pi;
fprintf('Angles from 0 to 2*pi (step 0.5): %d values\n', length(angles));

% Way 3: linspace -- evenly spaced points
smooth_x = linspace(0, 10, 50);
fprintf('Linspace created %d evenly spaced points from 0 to 10\n', length(smooth_x));

%% Row vs Column Vectors
% The difference matters!

row = [1, 2, 3];       % row vector (horizontal)
col = [1; 2; 3];       % column vector (vertical)

fprintf('\nRow vector size: %d x %d\n', size(row));
fprintf('Column vector size: %d x %d\n', size(col));

% Transpose flips between them
row_from_col = col';   % column becomes row
fprintf('Transposed column size: %d x %d\n', size(row_from_col));

%% Indexing and Slicing
% Getting specific elements from a vector

fprintf('\n--- Indexing cat_weights ---\n');
fprintf('First cat (index 1): %.1f kg\n', cat_weights(1));
fprintf('Third cat (index 3): %.1f kg -- that is Enzo!\n', cat_weights(3));
fprintf('Last cat (using end): %.1f kg\n', cat_weights(end));

% Slicing -- grab a range
first_three = cat_weights(1:3);
fprintf('First three cats: ');
fprintf('%.1f ', first_three);
fprintf('\n');

last_two = cat_weights(end-1:end);
fprintf('Last two cats: ');
fprintf('%.1f ', last_two);
fprintf('\n');

% What happens with index 0? Uncomment to see the error:
% cat_weights(0)   % ERROR: "Index must be a positive integer or logical"

%% Matrices
% A matrix is like a spreadsheet -- rows and columns

% Garden plot measurements: 3 plots, 4 measurements each
%            Length  Width  Height  Area
garden = [    2.5,   1.2,   0.3,   3.0;
              3.0,   1.5,   0.4,   4.5;
              1.8,   2.0,   0.3,   3.6;
              2.2,   1.0,   0.5,   2.2];

fprintf('\n--- Garden Measurements Matrix ---\n');
fprintf('Matrix size: %d rows x %d columns\n', size(garden));
fprintf('Element at row 2, col 3: %.1f\n', garden(2, 3));

% Get entire row 1 (first garden plot)
plot1 = garden(1, :);
fprintf('Garden plot 1 (all measurements): ');
fprintf('%.1f ', plot1);
fprintf('\n');

% Get entire column 1 (all lengths)
all_lengths = garden(:, 1);
fprintf('All lengths: ');
fprintf('%.1f ', all_lengths);
fprintf('\n');

%% Element-wise Operations
% The dot-prefix rule: .* ./ .^ mean "do it to each element"

% Convert cat weights from kg to pounds
lbs_per_kg = 2.205;
cat_weights_lbs = cat_weights .* lbs_per_kg;

fprintf('\n--- Element-wise Operations ---\n');
fprintf('Weights in kg:  ');
fprintf('%.1f ', cat_weights);
fprintf('\n');
fprintf('Weights in lbs: ');
fprintf('%.1f ', cat_weights_lbs);
fprintf('\n');

% Square each weight (just to practice the .^ operator)
weights_squared = cat_weights .^ 2;
fprintf('Weights squared: ');
fprintf('%.1f ', weights_squared);
fprintf('\n');

% Compare kg vs pounds side by side
figure(2);
subplot(1, 2, 1);
bar(cat_weights, 'FaceColor', [0.4 0.7 0.9]);
set(gca, 'XTickLabel', cat_names);
ylabel('Weight (kg)');
title('Cat Weights (kg)');
grid on;
ylim([0, 12]);

subplot(1, 2, 2);
bar(cat_weights_lbs, 'FaceColor', [0.9 0.5 0.3]);
set(gca, 'XTickLabel', cat_names);
ylabel('Weight (lbs)');
title('Cat Weights (pounds)');
grid on;
ylim([0, 12]);

sgtitle('Kilograms vs Pounds -- Element-wise Multiplication');

fprintf('\nDone! You should see two figures.\n');

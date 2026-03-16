% MODULE 03: PROGRAMMING TOOLS -- Functions Demo
% Demonstrates how to define and call functions in Matlab.
%
% Part of the Matlab for Computational Neuroscience course
% Module 03: Programming Tools
%
% What you'll see when you run this:
%   - Enzo's BMI computed using a function
%   - Multiple cat BMIs compared in a bar chart
%   - Data statistics using a function with multiple outputs

clear; clc; close all;

%% Section 1: A Simple Function -- Computing Cat BMI
% We define compute_bmi as a local function (see bottom of this file).
% Let's use it for Enzo the cat!

enzo_weight = 5.2;   % kg
enzo_height = 0.25;  % meters (approximate body length)

enzo_bmi = compute_bmi(enzo_weight, enzo_height);
fprintf('Enzo weighs %.1f kg and is %.2f m long\n', enzo_weight, enzo_height);
fprintf('Enzo BMI: %.1f\n\n', enzo_bmi);

%% Section 2: Using a Function on Multiple Cats
% The beauty of functions: call them as many times as you want!

cat_names = {'Enzo', 'Whiskers', 'Luna', 'Milo', 'Bella'};
cat_weights = [5.2, 4.1, 3.8, 6.0, 4.5];   % kg
cat_heights = [0.25, 0.23, 0.22, 0.28, 0.24]; % meters

% Compute BMI for each cat using our function
cat_bmis = zeros(1, length(cat_weights));  % pre-allocate result
for i = 1:length(cat_weights)
    cat_bmis(i) = compute_bmi(cat_weights(i), cat_heights(i));
end

% Print all results
fprintf('Cat BMI Results:\n');
for i = 1:length(cat_names)
    fprintf('  %s: %.1f\n', cat_names{i}, cat_bmis(i));
end
fprintf('\n');

% Plot: bar chart comparing cat BMIs
figure;
bar(cat_bmis);
set(gca, 'XTickLabel', cat_names);
ylabel('BMI');
title('Cat BMI Comparison');
grid on;

% Highlight Enzo's bar
hold on;
bar(1, cat_bmis(1), 'FaceColor', [0.85 0.33 0.1]);
hold off;
legend('Other cats', 'Enzo', 'Location', 'northwest');

%% Section 3: Functions with Multiple Outputs
% A function can return more than one value.
% describe_data returns the mean, standard deviation, and range.

daily_temps = [12, 14, 13, 15, 18, 20, 19, 17, 15, 16, 18, 21, 22, 20];

[avg_temp, std_temp, range_temp] = describe_data(daily_temps);

fprintf('Two weeks of temperatures:\n');
fprintf('  Average: %.1f C\n', avg_temp);
fprintf('  Std deviation: %.1f C\n', std_temp);
fprintf('  Range: %.1f C\n\n', range_temp);

%% Section 4: Calling the square Function
% One more simple example: squaring a number.

x = 7;
result = square_number(x);
fprintf('%d squared = %d\n', x, result);

disp('Functions let you write a computation once and reuse it forever!');

%% Local Functions
% In Matlab, local functions go at the BOTTOM of the script.
% They are only available inside this script file.

function bmi = compute_bmi(weight_kg, height_m)
    % COMPUTE_BMI  Calculate Body Mass Index for a cat
    %   bmi = COMPUTE_BMI(weight_kg, height_m) returns BMI
    bmi = weight_kg / height_m^2;
end

function [m, s, r] = describe_data(data)
    % DESCRIBE_DATA  Compute basic statistics of a dataset
    %   [m, s, r] = DESCRIBE_DATA(data) returns mean, std, and range
    m = mean(data);
    s = std(data);
    r = max(data) - min(data);
end

function y = square_number(x)
    % SQUARE_NUMBER  Compute the square of a number
    %   y = SQUARE_NUMBER(x) returns x^2
    y = x^2;
end

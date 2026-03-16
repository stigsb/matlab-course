% MODULE 03: PROGRAMMING TOOLS -- Loops Demo
% Demonstrates for-loops, while-loops, and the loop-and-accumulate pattern.
%
% Part of the Matlab for Computational Neuroscience course
% Module 03: Programming Tools
%
% What you'll see when you run this:
%   - Plant heights printed one by one
%   - A bar chart with tall plants highlighted in a different color
%   - While-loop halving a number until it drops below 1
%   - Collected tall plants displayed

clear; clc; close all;

%% Section 1: For-Loop -- Print Each Plant Height
% Let's loop through garden measurements and print each one.

plant_heights = [12, 8, 15, 22, 6, 18, 10, 14, 25, 9];

fprintf('Garden plant heights:\n');
for i = 1:length(plant_heights)
    fprintf('  Plant %d: %d cm\n', i, plant_heights(i));
end
fprintf('\n');

%% Section 2: Loop-and-Accumulate -- Collect Tall Plants
% Start with an empty collection and add items that meet a condition.

threshold = 15;  % cm
tall_plants = [];
tall_indices = [];

for i = 1:length(plant_heights)
    if plant_heights(i) > threshold
        tall_plants = [tall_plants, plant_heights(i)];
        tall_indices = [tall_indices, i];
    end
end

fprintf('Plants taller than %d cm:\n', threshold);
for i = 1:length(tall_plants)
    fprintf('  Plant %d: %d cm\n', tall_indices(i), tall_plants(i));
end
fprintf('Total: %d out of %d plants\n\n', length(tall_plants), length(plant_heights));

%% Section 3: Visualize -- Bar Chart with Tall Plants Highlighted
% Green bars for tall plants, gray for the rest.

figure;
colors = zeros(length(plant_heights), 3);  % RGB colors, one row per bar
for i = 1:length(plant_heights)
    if plant_heights(i) > threshold
        colors(i, :) = [0.2, 0.7, 0.3];  % green for tall
    else
        colors(i, :) = [0.7, 0.7, 0.7];  % gray for short
    end
end

b = bar(plant_heights);
b.FaceColor = 'flat';
b.CData = colors;

hold on;
yline(threshold, 'r--', 'LineWidth', 1.5);
hold off;

xlabel('Plant Number');
ylabel('Height (cm)');
title(sprintf('Garden Plants (tall = above %d cm)', threshold));
legend(b, 'Plant heights', 'Location', 'northwest');
grid on;

%% Section 4: While-Loop -- Keep Halving Until Below 1
% A while-loop repeats as long as a condition stays true.
% Here: keep dividing by 2 until the number drops below 1.

number = 1000;
steps = 0;

fprintf('While-loop: halving %d until below 1:\n', number);
while number >= 1
    fprintf('  Step %d: %.2f\n', steps + 1, number);
    number = number / 2;
    steps = steps + 1;
end

fprintf('Reached %.4f after %d steps\n\n', number, steps);

%% Section 5: Break and Continue
% break = stop the loop entirely
% continue = skip to the next iteration

fprintf('Finding the first plant taller than 20 cm:\n');
for i = 1:length(plant_heights)
    if plant_heights(i) > 20
        fprintf('  Found it! Plant %d is %d cm\n', i, plant_heights(i));
        break;
    end
end

fprintf('\nPrinting only the short plants (skipping tall ones with continue):\n');
for i = 1:length(plant_heights)
    if plant_heights(i) > threshold
        continue;  % skip this iteration
    end
    fprintf('  Plant %d: %d cm (short)\n', i, plant_heights(i));
end

fprintf('\nLoops let you process data item by item!\n');

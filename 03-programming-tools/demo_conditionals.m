% MODULE 03: PROGRAMMING TOOLS -- Conditionals Demo
% Demonstrates if/elseif/else, comparison and logical operators,
% and combining loops with conditionals to filter data.
%
% Part of the Matlab for Computational Neuroscience course
% Module 03: Programming Tools
%
% What you'll see when you run this:
%   - Temperature classification (cold/comfortable/hot)
%   - Reaction times classified as fast/medium/slow
%   - A scatter plot of reaction times colored by category

clear; clc; close all;

%% Section 1: Simple If/Elseif/Else -- Temperature Classification
% Classify today's temperature into a category.

temperature = 22;

fprintf('Temperature: %d C\n', temperature);
if temperature < 10
    fprintf('  Category: Cold! Wear a jacket.\n');
elseif temperature < 20
    fprintf('  Category: Cool. A sweater will do.\n');
else
    fprintf('  Category: Warm! T-shirt weather.\n');
end
fprintf('\n');

%% Section 2: Comparison Operators
% Quick demo of all six comparison operators.

x = 15;
fprintf('x = %d\n', x);
fprintf('  x == 15: %d (equal?)\n', x == 15);
fprintf('  x ~= 10: %d (not equal?)\n', x ~= 10);
fprintf('  x < 20:  %d (less than?)\n', x < 20);
fprintf('  x > 10:  %d (greater than?)\n', x > 10);
fprintf('  x <= 15: %d (less or equal?)\n', x <= 15);
fprintf('  x >= 20: %d (greater or equal?)\n', x >= 20);
fprintf('  (1 means true, 0 means false)\n\n');

%% Section 3: Logical Operators -- && (AND), || (OR), ~ (NOT)

age = 25;
has_ticket = true;

fprintf('age = %d, has_ticket = %d\n', age, has_ticket);

if age >= 18 && has_ticket
    fprintf('  Both conditions met: Welcome to the concert!\n');
end

if age < 18 || ~has_ticket
    fprintf('  At least one condition failed: Sorry, no entry.\n');
else
    fprintf('  Neither failure condition: Enjoy the show!\n');
end
fprintf('\n');

%% Section 4: Loop + Conditional -- Classify Reaction Times
% Process each reaction time and classify it as fast, medium, or slow.

reaction_times = [320, 510, 280, 620, 410, 390, 710, 340, 450, 380, ...
                  550, 290, 660, 370, 480, 530, 310, 420, 590, 350];

% Categories
fast = [];
medium = [];
slow = [];

% Classify each reaction time
for i = 1:length(reaction_times)
    rt = reaction_times(i);
    if rt < 350
        fast = [fast, rt];
    elseif rt < 500
        medium = [medium, rt];
    else
        slow = [slow, rt];
    end
end

fprintf('Reaction time classification:\n');
fprintf('  Fast   (< 350 ms): %d trials\n', length(fast));
fprintf('  Medium (350-499 ms): %d trials\n', length(medium));
fprintf('  Slow   (>= 500 ms): %d trials\n', length(slow));
fprintf('  Total: %d trials\n\n', length(reaction_times));

%% Section 5: Visualize -- Scatter Plot Colored by Category
% Color each reaction time by its category:
%   Fast = green, Medium = yellow/orange, Slow = red

figure;
trial_numbers = 1:length(reaction_times);

% We'll plot each category separately for the legend
hold on;

% Plot fast trials
for i = 1:length(reaction_times)
    rt = reaction_times(i);
    if rt < 350
        scatter(i, rt, 80, [0.2 0.7 0.3], 'filled');
    elseif rt < 500
        scatter(i, rt, 80, [1.0 0.7 0.0], 'filled');
    else
        scatter(i, rt, 80, [0.9 0.2 0.2], 'filled');
    end
end

% Add reference lines for the category boundaries
yline(350, 'g--', 'Fast/Medium', 'LineWidth', 1.5, 'LabelHorizontalAlignment', 'left');
yline(500, 'r--', 'Medium/Slow', 'LineWidth', 1.5, 'LabelHorizontalAlignment', 'left');

hold off;

xlabel('Trial Number');
ylabel('Reaction Time (ms)');
title('Reaction Times by Category');
grid on;

% Create dummy plots for legend
hold on;
h1 = scatter(nan, nan, 80, [0.2 0.7 0.3], 'filled');
h2 = scatter(nan, nan, 80, [1.0 0.7 0.0], 'filled');
h3 = scatter(nan, nan, 80, [0.9 0.2 0.2], 'filled');
hold off;
legend([h1 h2 h3], {'Fast (< 350 ms)', 'Medium (350-499 ms)', 'Slow (>= 500 ms)'}, ...
    'Location', 'northwest');

%% Section 6: Summary Statistics per Category

fprintf('Summary:\n');
if ~isempty(fast)
    fprintf('  Fast:   avg = %.0f ms (range: %d - %d)\n', mean(fast), min(fast), max(fast));
end
if ~isempty(medium)
    fprintf('  Medium: avg = %.0f ms (range: %d - %d)\n', mean(medium), min(medium), max(medium));
end
if ~isempty(slow)
    fprintf('  Slow:   avg = %.0f ms (range: %d - %d)\n', mean(slow), min(slow), max(slow));
end

fprintf('\nConditionals let your code make decisions about each data point!\n');

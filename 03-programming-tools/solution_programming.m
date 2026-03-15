% solution_programming.m - Complete solution for the programming exercise
% Part of: Matlab for Computational Neuroscience, Module 03
%
% This file has all 12 TODOs filled in. Compare with your own answers!
%
clear; clc; close all;

%% Part 1: Functions (3 TODOs)

% --- Example (done for you) ---
enzo_kg = 5.2;
enzo_lbs = kg_to_pounds(enzo_kg);
fprintf('Enzo weighs %.1f kg = %.1f lbs\n', enzo_kg, enzo_lbs);

% TODO 1: celsius_to_fahrenheit is defined as a local function below.
boiling_c = 100;
celsius_to_fahrenheit_result = celsius_to_fahrenheit(boiling_c);
fprintf('%.0f C = %.1f F\n', boiling_c, celsius_to_fahrenheit_result);

% TODO 2: Call celsius_to_fahrenheit for body temp and freezing point.
body_temp_f = celsius_to_fahrenheit(37);
freezing_f = celsius_to_fahrenheit(0);
fprintf('Body temp: %.0f C = %.1f F\n', 37, body_temp_f);
fprintf('Freezing:  %.0f C = %.1f F\n', 0, freezing_f);

% TODO 3: Test the average_value function file.
test_data = [10, 20, 30, 40, 50];
test_avg = average_value(test_data);
fprintf('Average of test_data: %.1f (should be 30.0)\n', test_avg);

%% Part 2: Loops (4 TODOs)

daily_temps = [8, 12, 15, 11, 18, 22, 20, 19, 14, 10, 9, 16, 21, 17];
fprintf('\nDaily temperatures for two weeks:\n');
disp(daily_temps);

% TODO 4: Find the hottest day using a for-loop.
max_temp = daily_temps(1);
hottest_day = 1;
for i = 2:length(daily_temps)
    if daily_temps(i) > max_temp
        max_temp = daily_temps(i);
        hottest_day = i;
    end
end
fprintf('Hottest day: day %d with %d C\n', hottest_day, max_temp);

% TODO 5: Collect all temperatures above 15 into warm_days.
warm_days = [];
for i = 1:length(daily_temps)
    if daily_temps(i) > 15
        warm_days = [warm_days, daily_temps(i)];
    end
end
fprintf('Warm days (> 15 C): ');
disp(warm_days);

% TODO 6: Compute the sum of all temperatures manually.
total = 0;
for i = 1:length(daily_temps)
    total = total + daily_temps(i);
end
fprintf('Sum of all temps: %d (should be %d)\n', total, sum(daily_temps));

% TODO 7: Double 1 until it exceeds 1000.
number = 1;
count = 0;
while number <= 1000
    number = number * 2;
    count = count + 1;
end
fprintf('Doubled 1 a total of %d times to get %d (> 1000)\n', count, number);

%% Part 3: Conditionals (3 TODOs)

fprintf('\n--- Conditionals ---\n');

% TODO 8: Classify a temperature value.
test_temp = 18;
if test_temp < 5
    category = 'Freezing';
elseif test_temp < 15
    category = 'Cold';
elseif test_temp < 25
    category = 'Comfortable';
else
    category = 'Hot';
end
fprintf('%d C is: %s\n', test_temp, category);

% TODO 9: Classify ALL daily_temps.
fprintf('\nClassifying all daily temperatures:\n');
for i = 1:length(daily_temps)
    t = daily_temps(i);
    if t < 5
        cat = 'Freezing';
    elseif t < 15
        cat = 'Cold';
    elseif t < 25
        cat = 'Comfortable';
    else
        cat = 'Hot';
    end
    fprintf('  Day %2d: %2d C -> %s\n', i, t, cat);
end

% TODO 10: Find warm weekend days using logical operators.
fprintf('\nWarm weekend days:\n');
for i = 1:length(daily_temps)
    is_warm = daily_temps(i) > 15;
    is_weekend = (i == 6 || i == 7 || i == 13 || i == 14);
    if is_warm && is_weekend
        fprintf('  Day %d: %d C (warm weekend!)\n', i, daily_temps(i));
    end
end

%% Part 4: Putting It Together (2 TODOs + Optional Challenge)

fprintf('\n--- Putting It All Together ---\n');

reaction_times = [320, 510, 280, 620, 410, 390, 710, 340, 450, 380, ...
                  550, 290, 660, 370, 480, 530, 310, 420, 590, 350];

% TODO 11: Test the filter_data function file.
fast_rts = filter_data(reaction_times, 0);
slow_rts = filter_data(reaction_times, 500);
fprintf('Total trials: %d\n', length(fast_rts));
fprintf('Slow trials (> 500 ms): %d\n', length(slow_rts));

% TODO 12: Complete analysis of reaction times.
fast = [];
medium = [];
slow = [];

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

fprintf('Fast   (< 350 ms): %d trials, avg = %.0f ms\n', length(fast), average_value(fast));
fprintf('Medium (350-499 ms): %d trials, avg = %.0f ms\n', length(medium), average_value(medium));
fprintf('Slow   (>= 500 ms): %d trials, avg = %.0f ms\n', length(slow), average_value(slow));

%% Optional Challenge: Bar Chart of Trial Counts

figure;
counts = [length(fast), length(medium), length(slow)];
b = bar(counts);
b.FaceColor = 'flat';
b.CData = [0.2 0.7 0.3; 1.0 0.7 0.0; 0.9 0.2 0.2];
set(gca, 'XTickLabel', {'Fast', 'Medium', 'Slow'});
ylabel('Number of Trials');
title('Reaction Time Categories');
grid on;

%% Local Functions

function lbs = kg_to_pounds(kg)
    % KG_TO_POUNDS  Convert kilograms to pounds
    lbs = kg * 2.205;
end

% TODO 1: celsius_to_fahrenheit function
function f = celsius_to_fahrenheit(c)
    % CELSIUS_TO_FAHRENHEIT  Convert Celsius to Fahrenheit
    %   f = CELSIUS_TO_FAHRENHEIT(c) returns c * 9/5 + 32
    f = c * 9/5 + 32;
end

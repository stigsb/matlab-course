% exercise_programming.m - Practice writing functions, loops, and conditionals
% Part of: Matlab for Computational Neuroscience, Module 03
%
% Instructions: Fill in each TODO, then uncomment the fprintf line below it.
% Run the script after each part to check your work!
%
% There are 12 TODOs across 4 parts. Work through them in order.
%
clear; clc; close all;

%% Part 1: Functions (3 TODOs)
% Let's write some functions!

% --- Example (done for you) ---
% This local function converts kg to pounds.
enzo_kg = 5.2;
enzo_lbs = kg_to_pounds(enzo_kg);
fprintf('Enzo weighs %.1f kg = %.1f lbs\n', enzo_kg, enzo_lbs);

% TODO 1: Write a local function called celsius_to_fahrenheit at the bottom
% of this file. It should take a temperature in Celsius and return Fahrenheit.
% Formula: F = C * 9/5 + 32
% (Scroll to the bottom of the file to write your function)

boiling_c = 100;
% celsius_to_fahrenheit_result = celsius_to_fahrenheit(boiling_c);

% Uncomment to check:
% fprintf('%.0f C = %.1f F\n', boiling_c, celsius_to_fahrenheit_result);

% TODO 2: Call your celsius_to_fahrenheit function for body temperature (37 C)
% and freezing point (0 C). Store results in variables.
% body_temp_f = ???
% freezing_f = ???

% Uncomment to check:
% fprintf('Body temp: %.0f C = %.1f F\n', 37, body_temp_f);
% fprintf('Freezing:  %.0f C = %.1f F\n', 0, freezing_f);

% TODO 3: Create a separate function file called average_value.m
% It should take a vector and return the average (mean).
% The file should contain:
%   function avg = average_value(data)
%       avg = mean(data);
%   end
% Then test it here:

test_data = [10, 20, 30, 40, 50];
% test_avg = average_value(test_data);

% Uncomment to check:
% fprintf('Average of test_data: %.1f (should be 30.0)\n', test_avg);

%% Part 2: Loops (4 TODOs)
% Let's iterate over data!

daily_temps = [8, 12, 15, 11, 18, 22, 20, 19, 14, 10, 9, 16, 21, 17];
fprintf('\nDaily temperatures for two weeks:\n');
disp(daily_temps);

% TODO 4: Write a for-loop that finds the hottest day.
% Loop through daily_temps, keep track of the maximum temperature
% and which day it occurred on.
% Hint: start with max_temp = daily_temps(1) and hottest_day = 1,
%        then update them if you find a higher temperature.
% max_temp = daily_temps(1);
% hottest_day = 1;
% for i = 2:length(daily_temps)
%     ???
% end

% Uncomment to check:
% fprintf('Hottest day: day %d with %d C\n', hottest_day, max_temp);

% TODO 5: Use the loop-and-accumulate pattern to collect all temperatures
% above 15 degrees into a new vector called warm_days.
% Start with warm_days = [] and add temps that are > 15.
% warm_days = [];
% for i = 1:length(daily_temps)
%     ???
% end

% Uncomment to check:
% fprintf('Warm days (> 15 C): ');
% disp(warm_days);

% TODO 6: Write a for-loop that computes the sum of all temperatures.
% Do NOT use the built-in sum() function -- do it manually with a loop.
% Start with total = 0 and add each temperature.
% total = 0;
% for i = 1:length(daily_temps)
%     ???
% end

% Uncomment to check:
% fprintf('Sum of all temps: %d (should be %d)\n', total, sum(daily_temps));

% TODO 7: Write a while-loop that counts how many times you need to
% double the number 1 to exceed 1000.
% Start with number = 1 and count = 0. Keep doubling until number > 1000.
% number = 1;
% count = 0;
% while ???
%     ???
% end

% Uncomment to check:
% fprintf('Doubled 1 a total of %d times to get %d (> 1000)\n', count, number);

%% Part 3: Conditionals (3 TODOs)
% Let's make decisions based on data!

fprintf('\n--- Conditionals ---\n');

% TODO 8: Write an if/elseif/else that classifies a temperature value.
% Use the variable test_temp below.
% Categories:
%   Below 5: "Freezing"
%   5 to 14: "Cold"
%   15 to 24: "Comfortable"
%   25 and above: "Hot"
test_temp = 18;
% if ???
%     category = 'Freezing';
% elseif ???
%     category = 'Cold';
% elseif ???
%     category = 'Comfortable';
% else
%     category = 'Hot';
% end

% Uncomment to check:
% fprintf('%d C is: %s\n', test_temp, category);

% TODO 9: Combine a loop and conditional to classify ALL daily_temps.
% For each temperature, print its day number and category
% (use the same categories as TODO 8).
% fprintf('\nClassifying all daily temperatures:\n');
% for i = 1:length(daily_temps)
%     t = daily_temps(i);
%     if ???
%         cat = 'Freezing';
%     elseif ???
%         cat = 'Cold';
%     elseif ???
%         cat = 'Comfortable';
%     else
%         cat = 'Hot';
%     end
%     fprintf('  Day %2d: %2d C -> %s\n', i, t, cat);
% end

% TODO 10: Use logical operators (&& and ||) to find days that are
% BOTH warm (> 15) AND on a weekend (day 6, 7, 13, or 14).
% Print each matching day.
% Hint: a day is a weekend if (i == 6 || i == 7 || i == 13 || i == 14)
% fprintf('\nWarm weekend days:\n');
% for i = 1:length(daily_temps)
%     is_warm = daily_temps(i) > 15;
%     is_weekend = (i == 6 || i == 7 || i == 13 || i == 14);
%     if ???
%         fprintf('  Day %d: %d C (warm weekend!)\n', i, daily_temps(i));
%     end
% end

%% Part 4: Putting It Together (2 TODOs + Optional Challenge)
% Combine functions, loops, and conditionals!

fprintf('\n--- Putting It All Together ---\n');

reaction_times = [320, 510, 280, 620, 410, 390, 710, 340, 450, 380, ...
                  550, 290, 660, 370, 480, 530, 310, 420, 590, 350];

% TODO 11: Create a separate function file called filter_data.m
% It should take a vector and a threshold, and return only the elements
% above the threshold.
% The file should contain:
%   function filtered = filter_data(data, threshold)
%       filtered = data(data > threshold);
%   end
% Then test it here:

% fast_rts = filter_data(reaction_times, 0);    % get all (threshold = 0)
% slow_rts = filter_data(reaction_times, 500);  % get only slow ones

% Uncomment to check:
% fprintf('Total trials: %d\n', length(fast_rts));
% fprintf('Slow trials (> 500 ms): %d\n', length(slow_rts));

% TODO 12: Write a complete analysis of reaction_times.
% Use a loop to classify each RT as fast (< 350), medium (350-499),
% or slow (>= 500). Count how many are in each category.
% Then use average_value() to compute the mean of each category.
% fast = [];
% medium = [];
% slow = [];
%
% for i = 1:length(reaction_times)
%     rt = reaction_times(i);
%     if ???
%         fast = [fast, rt];
%     elseif ???
%         medium = [medium, rt];
%     else
%         slow = [slow, rt];
%     end
% end
%
% fprintf('Fast   (< 350 ms): %d trials, avg = %.0f ms\n', length(fast), average_value(fast));
% fprintf('Medium (350-499 ms): %d trials, avg = %.0f ms\n', length(medium), average_value(medium));
% fprintf('Slow   (>= 500 ms): %d trials, avg = %.0f ms\n', length(slow), average_value(slow));

%% Optional Challenge: Make a Plot!
% If you completed all 12 TODOs above, try this:
% Create a bar chart showing the COUNT of fast, medium, and slow trials.
% Color the bars green, yellow, and red respectively.
% Add a title and axis labels.

% Your code here (optional):


%% Local Functions
% Write your local functions below this line.
% -----------------------------------------------

function lbs = kg_to_pounds(kg)
    % KG_TO_POUNDS  Convert kilograms to pounds
    lbs = kg * 2.205;
end

% TODO 1: Write your celsius_to_fahrenheit function here:
% function f = celsius_to_fahrenheit(c)
%     ???
% end

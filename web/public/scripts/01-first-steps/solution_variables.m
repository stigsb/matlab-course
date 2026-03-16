% solution_variables.m - Complete solution for the variables exercise
% Part of: Matlab for Computational Neuroscience, Module 01
%
% Run this script to see: all variable exercises solved with output
%
clear; clc; close all;

%% Part 1: Create Some Variables

% The cat Enzo weighs 5.2 kg
enzo_weight = 5.2;
fprintf('Enzo weighs %.1f kg\n', enzo_weight);

% Ravn is 11 years old
ravn_age = 11;
fprintf('Ravn is %d years old\n', ravn_age);

% Helena is 8 years old
helena_age = 8;
fprintf('Helena is %d years old\n', helena_age);

% The cat's name is Enzo
cat_name = 'Enzo';
fprintf('The cat is called %s\n', cat_name);

%% Part 2: Do Some Math

% Age difference between Ravn and Helena
age_diff = ravn_age - helena_age;  % 11 - 8 = 3
fprintf('Age difference: %d years\n', age_diff);

% Total age of both kids
total_family_age = ravn_age + helena_age;  % 11 + 8 = 19
fprintf('Total kids age: %d years\n', total_family_age);

% Convert Enzo's weight to pounds
enzo_weight_pounds = enzo_weight * 2.205;  % 5.2 * 2.205 = 11.466
fprintf('Enzo weighs %.1f pounds\n', enzo_weight_pounds);

%% Part 3: Your First Vector

% Heights of 5 garden plants in cm
garden_plant_heights = [15, 42, 68, 23, 55];

figure;
bar(garden_plant_heights);
xlabel('Plant number');
ylabel('Height (cm)');
title('Garden Plant Heights');
grid on;
fprintf('You have %d plants. The tallest is %.1f cm.\n', ...
    length(garden_plant_heights), max(garden_plant_heights));

%% Part 4: Challenge (Optional)

% Daily temperatures for a week in Trondheim (March)
temps = [2, 4, 1, -1, 3, 5, 3];
days = 1:7;

figure;
plot(days, temps, 'b-o', 'LineWidth', 2);
xlabel('Day');
ylabel('Temperature (C)');
title('Weekly Temperatures in Trondheim');
grid on;
fprintf('Warmest day: %.0f C, coldest day: %.0f C\n', max(temps), min(temps));

disp('All exercises complete!');

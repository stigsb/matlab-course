% exercise_variables.m - Practice creating variables and doing math
% Part of: Matlab for Computational Neuroscience, Module 01
%
% Run this script to see: practice creating variables and doing math
%
% Instructions: Fill in each TODO, then uncomment the fprintf line below it.
% Run the script after each section to check your work!
%
clear; clc; close all;

%% Part 1: Create Some Variables
% Let's store some information. The first one is done for you.

% The cat Enzo weighs 5.2 kg
enzo_weight = 5.2;
fprintf('Enzo weighs %.1f kg\n', enzo_weight);

% TODO: Create a variable for Ravn's age (he is 11)
% ravn_age = ???

% Uncomment this line after filling in the TODO above:
% fprintf('Ravn is %d years old\n', ravn_age);

% TODO: Create a variable for Helena's age (she is 8)
% helena_age = ???

% Uncomment this line after filling in the TODO above:
% fprintf('Helena is %d years old\n', helena_age);

% TODO: Create a variable for the cat's name (Enzo)
% Hint: text goes in single quotes, like 'hello'
% cat_name = ???

% Uncomment this line after filling in the TODO above:
% fprintf('The cat is called %s\n', cat_name);

%% Part 2: Do Some Math
% Use the variables you created above to calculate new values.

% TODO: Calculate the age difference between Ravn and Helena
% Hint: subtract the smaller age from the larger one
% age_diff = ???

% Uncomment this line after filling in the TODO above:
% fprintf('Age difference: %d years\n', age_diff);

% TODO: Calculate the total age of both kids combined
% total_family_age = ???

% Uncomment this line after filling in the TODO above:
% fprintf('Total kids age: %d years\n', total_family_age);

% TODO: Convert Enzo's weight from kg to pounds (multiply by 2.205)
% enzo_weight_pounds = ???

% Uncomment this line after filling in the TODO above:
% fprintf('Enzo weighs %.1f pounds\n', enzo_weight_pounds);

%% Part 3: Your First Vector
% A vector is a list of numbers inside square brackets.
% Imagine measuring the height (in cm) of 5 plants in the garden.

% TODO: Create a vector called garden_plant_heights with 5 heights
% Pick any numbers you like (realistic plant heights are 10-80 cm)
% garden_plant_heights = ???

% This code will plot your vector as a bar chart.
% It will work once you've created garden_plant_heights above.
% Uncomment the lines below after filling in the TODO:
%
% figure;
% bar(garden_plant_heights);
% xlabel('Plant number');
% ylabel('Height (cm)');
% title('Garden Plant Heights');
% grid on;
% fprintf('You have %d plants. The tallest is %.1f cm.\n', ...
%     length(garden_plant_heights), max(garden_plant_heights));

%% Part 4: Challenge (Optional)
% This section has less scaffolding. Try it if you want more practice!
%
% Task: Create a vector of daily temperatures for a week (7 values).
% Then plot them as a line chart and add labels.
%
% Hints:
%   - Create: temps = [your 7 numbers here]
%   - Days:   days = 1:7
%   - Plot:   plot(days, temps, 'b-o', 'LineWidth', 2)
%   - Labels: xlabel('Day'), ylabel('Temperature'), title('Weekly Temps')
%   - Grid:   grid on
%
% Write your code below:

% demo_variables.m - Variables, types, basic arithmetic, and a vector preview
% Part of: Matlab for Computational Neuroscience, Module 01
%
% Run this script to see: printed text about variables and a bar chart of cat weights
%
clear; clc; close all;

%% Section 1: Numbers (Scalars)
% A scalar is just a single number stored with a name.

enzo_weight = 5.2;       % Enzo the cat weighs 5.2 kg
ravn_age = 11;           % Ravn is 11 years old
helena_age = 8;          % Helena is 8 years old

fprintf('--- Numbers ---\n');
fprintf('Enzo weighs %.1f kg\n', enzo_weight);
fprintf('Ravn is %d years old\n', ravn_age);
fprintf('Helena is %d years old\n', helena_age);

%% Section 2: Text and Booleans
% You can also store text (character arrays) and true/false values.

cat_name = 'Enzo';
favorite_plant = 'tomato';
is_cat = true;
likes_rain = false;

fprintf('\n--- Text and Booleans ---\n');
fprintf('Cat name: %s\n', cat_name);
fprintf('Favorite plant: %s\n', favorite_plant);
fprintf('Is %s a cat? %d (1 = true, 0 = false)\n', cat_name, is_cat);
fprintf('Does %s like rain? %d\n', cat_name, likes_rain);

%% Section 3: Arithmetic
% Matlab is a powerful calculator. Use +, -, *, /, ^ for math.

age_diff = ravn_age - helena_age;
total_family_age = ravn_age + helena_age;
enzo_weight_pounds = enzo_weight * 2.205;

fprintf('\n--- Arithmetic ---\n');
fprintf('Age difference: %d years\n', age_diff);
fprintf('Total kids age: %d years\n', total_family_age);
fprintf('Enzo in pounds: %.1f lbs\n', enzo_weight_pounds);

%% Section 4: Your First Vector
% A vector is a list of numbers inside square brackets.
% Here are the weights of 5 cats at the vet:

cat_weights = [4.2, 3.8, 5.1, 3.5, 4.7];

fprintf('\n--- Vectors ---\n');
fprintf('Number of cats weighed: %d\n', length(cat_weights));
fprintf('First cat weighs: %.1f kg\n', cat_weights(1));
fprintf('Heaviest cat weighs: %.1f kg\n', max(cat_weights));

% Let's make a bar chart of the cat weights
figure;
cat_names = {'Luna', 'Milo', 'Enzo', 'Bella', 'Oscar'};
bar(cat_weights);
set(gca, 'XTickLabel', cat_names);
xlabel('Cat');
ylabel('Weight (kg)');
title('Cat Weights at the Vet');
grid on;

fprintf('\nLook at the bar chart to see the weights visually!\n');
disp('Done! You now know about variables, types, arithmetic, and vectors.');

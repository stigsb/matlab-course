% demo_hello.m - Your very first Matlab script!
% Part of: Matlab for Computational Neuroscience, Module 01
%
% Run this script to see: a plot of x-squared and a bar chart of family ages
%
clear; clc; close all;

%% Section 1: Your First Plot
% Let's make something happen RIGHT NOW.
% These next few lines create some data and plot it.

x = 1:10;
y = x.^2;
plot(x, y, 'ro-', 'LineWidth', 2);
title('Your First Plot - You Made This!');
xlabel('x');
ylabel('x squared');
grid on;

% What just happened?
% -------------------
% Line by line:
%   x = 1:10         -> Created a list of numbers from 1 to 10
%   y = x.^2         -> Squared each number (the dot means "do it to each element")
%   plot(x, y, ...)  -> Drew a line connecting the points
%   'ro-'            -> r = red, o = circle markers, - = solid line
%   'LineWidth', 2   -> Made the line thicker so it's easy to see
%   title(...)       -> Added a title at the top
%   xlabel/ylabel    -> Labeled the axes
%   grid on          -> Added grid lines for easier reading

%% Section 2: A Bar Chart of Family Ages
% Let's try a different kind of plot: a bar chart.
% This time we'll use some real data.

figure;  % Opens a new figure window (so we keep the first plot too)

names = {'Ravn', 'Helena', 'Enzo (cat years)'};
ages = [11, 8, 3];

bar(ages);
set(gca, 'XTickLabel', names);
ylabel('Age');
title('Family Ages');
grid on;

fprintf('Ravn is %d, Helena is %d, and Enzo is %d (in cat years).\n', ages(1), ages(2), ages(3));
disp('You just made two plots with a few lines of code!');

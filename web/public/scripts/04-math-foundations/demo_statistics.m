% MODULE 04: MATH FOUNDATIONS -- Statistics and Visualization
% Compute mean, standard deviation, and correlation -- always with plots.
%
% Part of the Matlab for Computational Neuroscience course
% Module 04: Math Foundations
%
% What you'll see when you run this:
%   Figure 1: Daily temperatures with mean and +/- 1 std bands
%   Figure 2: Histogram of reaction times with mean line
%   Figure 3: Correlation scatter plot -- temperature vs ice cream sales

clear; clc; close all;

%% 1. Mean and Standard Deviation
% Mean = the typical value. Std = how spread out.

% Two weeks of daily temperatures (Celsius)
days = 1:14;
daily_temps = [12, 14, 13, 15, 18, 20, 19, 17, 15, 16, 18, 21, 22, 20];

% Compute statistics
m = mean(daily_temps);
s = std(daily_temps);

fprintf('--- Daily Temperature Statistics ---\n');
fprintf('Mean temperature: %.1f C\n', m);
fprintf('Std deviation:    %.1f C\n', s);
fprintf('Variance:         %.1f C^2  (that is std squared)\n', var(daily_temps));
fprintf('Range:            %d to %d C\n', min(daily_temps), max(daily_temps));

% Plot with mean and std bands
figure(1);
bar(days, daily_temps, 'FaceColor', [0.5 0.7 0.9]);
hold on;
yline(m, 'r-', 'LineWidth', 2);
yline(m + s, 'r--', 'LineWidth', 1);
yline(m - s, 'r--', 'LineWidth', 1);
hold off;
xlabel('Day');
ylabel('Temperature (C)');
title(sprintf('Daily Temperatures: mean = %.1f C, std = %.1f C', m, s));
legend('Temperature', 'Mean', '+/- 1 Std Dev', 'Location', 'northwest');
grid on;

%% 2. Histograms: The Shape of Your Data
% A histogram shows how data is distributed. The shape tells a story.

% Simulate 500 reaction times (normally distributed, mean=300ms, std=50ms)
rng(42);  % Set seed so results are reproducible
reaction_times = randn(500, 1) * 50 + 300;

rt_mean = mean(reaction_times);
rt_std = std(reaction_times);

fprintf('\n--- Reaction Time Statistics ---\n');
fprintf('Mean reaction time: %.1f ms\n', rt_mean);
fprintf('Std deviation:      %.1f ms\n', rt_std);
fprintf('Fastest:            %.1f ms\n', min(reaction_times));
fprintf('Slowest:            %.1f ms\n', max(reaction_times));

figure(2);
histogram(reaction_times, 25, 'FaceColor', [0.6 0.8 0.5]);
hold on;
xline(rt_mean, 'r-', 'LineWidth', 2);
xline(rt_mean + rt_std, 'r--', 'LineWidth', 1);
xline(rt_mean - rt_std, 'r--', 'LineWidth', 1);
hold off;
xlabel('Reaction Time (ms)');
ylabel('Count');
title(sprintf('Reaction Times: mean = %.0f ms, std = %.0f ms', rt_mean, rt_std));
legend('Data', 'Mean', '+/- 1 Std Dev');
grid on;

%% 3. Correlation: Do These Move Together?
% Correlation measures whether two variables increase together.

% When it is warmer, people buy more ice cream
% temps already defined above as daily_temps
rng(7);  % Reproducible
ice_cream_sales = daily_temps * 3.5 + randn(1, 14) * 5 + 10;

% Compute correlation
% IMPORTANT: corrcoef returns a MATRIX, not a number!
R = corrcoef(daily_temps, ice_cream_sales);
r = R(1,2);   % Extract the single correlation value

fprintf('\n--- Correlation Demo ---\n');
fprintf('The full correlation matrix R:\n');
disp(R);
fprintf('The correlation between temps and sales: r = %.2f\n', r);
fprintf('(r close to +1 means they increase together)\n');

figure(3);
scatter(daily_temps, ice_cream_sales, 60, 'filled', ...
    'MarkerFaceColor', [0.9 0.4 0.3]);
xlabel('Temperature (C)');
ylabel('Ice Cream Sales');
title(sprintf('Temperature vs Ice Cream Sales (r = %.2f)', r));
grid on;

% Add a trend line for visual clarity
hold on;
p = polyfit(daily_temps, ice_cream_sales, 1);
x_fit = linspace(min(daily_temps), max(daily_temps), 100);
y_fit = polyval(p, x_fit);
plot(x_fit, y_fit, 'k--', 'LineWidth', 1.5);
hold off;
legend('Data Points', 'Trend Line', 'Location', 'northwest');

fprintf('\nDone! You should see three figures.\n');

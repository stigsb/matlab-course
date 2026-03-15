% MODULE 06: INFORMATION THEORY -- Entropy: Measuring Surprise
% Compute entropy for different distributions and visualize.
%
% Part of the Matlab for Computational Neuroscience course
% Module 06: Information Theory
%
% What you'll see when you run this:
%   Figure 1: Five distributions side by side with their entropy values
%   Figure 2: Horizontal bar chart comparing entropies
%   Figure 3: Entropy vs bias for a coin -- the classic inverted-U shape

clear; clc; close all;

%% 1. Five Distributions: From Boring to Surprising
% Entropy measures surprise. If you already know what will happen,
% there is no surprise (low entropy). If anything could happen,
% maximum surprise (high entropy).

% Define five probability distributions
names = {'Fair coin', 'Biased coin (90/10)', 'Fair 4-sided die', ...
         'Loaded 4-sided die', 'Certain outcome'};
distributions = {[0.5, 0.5], ...
                 [0.9, 0.1], ...
                 [0.25, 0.25, 0.25, 0.25], ...
                 [0.7, 0.1, 0.1, 0.1], ...
                 [1, 0, 0, 0]};

% Compute entropy of each
H = zeros(1, length(distributions));
for i = 1:length(distributions)
    H(i) = compute_entropy(distributions{i});
end

fprintf('--- Entropy of Five Distributions ---\n');
for i = 1:length(distributions)
    fprintf('  %-25s  H = %.2f bits\n', names{i}, H(i));
end

%% 2. Visualize Each Distribution with Its Entropy
figure(1);
for i = 1:length(distributions)
    subplot(2, 3, i);
    p = distributions{i};
    bar(p, 'FaceColor', [0.4 0.6 0.9]);
    ylim([0 1.1]);
    title(sprintf('%s\nH = %.2f bits', names{i}, H(i)));
    xlabel('Outcome');
    ylabel('Probability');
    grid on;
end
sgtitle('Distributions and Their Entropy');

%% 3. Compare Entropies Side by Side
figure(2);
barh(H, 'FaceColor', [0.3 0.7 0.5]);
set(gca, 'YTick', 1:length(names), 'YTickLabel', names);
xlabel('Entropy (bits)');
title('More Uncertainty = More Entropy');
grid on;

% Add value labels on the bars
for i = 1:length(H)
    text(H(i) + 0.05, i, sprintf('%.2f', H(i)), 'VerticalAlignment', 'middle');
end

%% 4. How Entropy Changes: The Coin Curve
% For a coin with probability p of heads and (1-p) of tails,
% entropy peaks at p = 0.5 (fair coin) and drops to 0 at the extremes.

p_range = 0.001:0.001:0.999;
H_curve = zeros(size(p_range));
for i = 1:length(p_range)
    p_coin = [p_range(i), 1 - p_range(i)];
    H_curve(i) = compute_entropy(p_coin);
end

figure(3);
plot(p_range, H_curve, 'b-', 'LineWidth', 2);
hold on;
% Mark the fair coin
plot(0.5, 1.0, 'ro', 'MarkerSize', 12, 'LineWidth', 2);
text(0.52, 0.95, 'Fair coin: H = 1.0 bit', 'FontSize', 10);
% Mark a biased coin
plot(0.9, compute_entropy([0.9, 0.1]), 'gs', 'MarkerSize', 10, ...
    'LineWidth', 2, 'MarkerFaceColor', 'g');
text(0.72, 0.55, sprintf('90/10 coin: H = %.2f', compute_entropy([0.9, 0.1])), ...
    'FontSize', 10);
hold off;
xlabel('Probability of heads (p)');
ylabel('Entropy (bits)');
title('Entropy vs Coin Bias: Maximum Surprise at p = 0.5');
grid on;

%% Key Insight
fprintf('\n--- Key Insight ---\n');
fprintf('  Fair coin: exactly 1 bit of entropy.\n');
fprintf('  That is because 1 bit answers exactly 1 yes/no question.\n');
fprintf('  "Is it heads?" If you need 1 question, you have 1 bit of uncertainty.\n');
fprintf('  Certain outcome: 0 bits. No surprise, no information.\n');

fprintf('\nDone! You should see three figures.\n');

% MODULE 06: INFORMATION THEORY -- Logarithms: The Scale of Information
% Visual introduction to logarithms and why they matter for information.
%
% Part of the Matlab for Computational Neuroscience course
% Module 06: Information Theory
%
% What you'll see when you run this:
%   Figure 1: "How many times do you double?" -- bar chart of log2 values
%   Figure 2: Linear vs log scale -- why log compresses big numbers
%   Figure 3: Comparing log2, log, and log10 side by side
%   Figure 4: Exponential data as a straight line with semilogy

clear; clc; close all;

%% 1. "How Many Times Do You Double?"
% log2(8) = 3 because you double 1 three times: 1 -> 2 -> 4 -> 8.
% Logarithms are the "undo" button for exponents.

values = [1, 2, 4, 8, 16, 32, 64, 128, 256];
log_values = log2(values);

fprintf('--- How Many Times Do You Double? ---\n');
for i = 1:length(values)
    fprintf('  log2(%3d) = %d\n', values(i), log_values(i));
end

figure(1);
bar(log_values, 'FaceColor', [0.3 0.6 0.8]);
set(gca, 'XTickLabel', values);
xlabel('Number');
ylabel('log_2(number)');
title('Logarithm = "How many times do you double 1 to get here?"');
grid on;

%% 2. Linear vs Log: Why Log Is the Right Scale
% Doubling the number of possibilities adds just 1 bit.
% On a linear scale, 256 looks huge. On a log scale, it is just 8.

x = 1:256;

figure(2);
subplot(2, 1, 1);
plot(x, x, 'b-', 'LineWidth', 2);
xlabel('Number of possibilities');
ylabel('Linear scale');
title('Linear: 256 seems enormous');
grid on;

subplot(2, 1, 2);
plot(x, log2(x), 'r-', 'LineWidth', 2);
xlabel('Number of possibilities');
ylabel('Log_2 scale (bits)');
title('Log: doubling possibilities adds just 1 bit');
grid on;

%% 3. Logarithms Turn Multiplication into Addition
% log2(a * b) = log2(a) + log2(b)
% This is the key property that makes logarithms useful everywhere.

a = 8;
b = 4;
product = a * b;

fprintf('\n--- Multiplication -> Addition ---\n');
fprintf('  a = %d,  b = %d,  a*b = %d\n', a, b, product);
fprintf('  log2(%d) = %.0f\n', a, log2(a));
fprintf('  log2(%d) = %.0f\n', b, log2(b));
fprintf('  log2(%d) + log2(%d) = %.0f + %.0f = %.0f\n', ...
    a, b, log2(a), log2(b), log2(a) + log2(b));
fprintf('  log2(%d * %d) = log2(%d) = %.0f  <-- same thing!\n', ...
    a, b, product, log2(product));

fprintf('\n  Another example: log2(16 * 64) = log2(16) + log2(64)\n');
fprintf('  = %d + %d = %d\n', log2(16), log2(64), log2(16) + log2(64));
fprintf('  log2(1024) = %d  <-- matches!\n', log2(1024));

%% 4. Key Values to Remember
fprintf('\n--- Key log2 Values ---\n');
fprintf('  log2(1)    = %.0f   (no doublings)\n', log2(1));
fprintf('  log2(2)    = %.0f   (one doubling)\n', log2(2));
fprintf('  log2(8)    = %.0f   (three doublings)\n', log2(8));
fprintf('  log2(1024) = %.0f  (ten doublings -- roughly 1000)\n', log2(1024));

%% 5. Three Types of Logarithm in Matlab
% log2  -> base 2  (bits, information theory)
% log   -> base e  (nats, natural processes)
% log10 -> base 10 (orders of magnitude)

x_plot = linspace(0.1, 20, 200);

figure(3);
plot(x_plot, log2(x_plot), 'b-', 'LineWidth', 2); hold on;
plot(x_plot, log(x_plot), 'r-', 'LineWidth', 2);
plot(x_plot, log10(x_plot), 'g-', 'LineWidth', 2);
hold off;
xlabel('x');
ylabel('log(x)');
title('Three Logarithms: Same Shape, Different Scale');
legend('log_2 (bits)', 'ln = log_e (nats)', 'log_{10} (orders of magnitude)', ...
    'Location', 'southeast');
grid on;

fprintf('\n--- Comparing Bases for x = 8 ---\n');
fprintf('  log2(8)  = %.2f  (bits)\n', log2(8));
fprintf('  log(8)   = %.2f  (nats)\n', log(8));
fprintf('  log10(8) = %.2f  (orders of magnitude)\n', log10(8));
fprintf('  They are all proportional: log2(8) = log(8) / log(2) = %.2f / %.2f = %.2f\n', ...
    log(8), log(2), log(8)/log(2));

%% 6. Bonus: Semilogy Makes Exponential Growth a Straight Line
% This is incredibly useful for spotting exponential trends.

x_exp = 1:10;
y_exp = 2 .^ x_exp;   % exponential growth

figure(4);
subplot(1, 2, 1);
plot(x_exp, y_exp, 'bo-', 'LineWidth', 2, 'MarkerSize', 8);
xlabel('x');
ylabel('2^x');
title('Linear Scale: Curved');
grid on;

subplot(1, 2, 2);
semilogy(x_exp, y_exp, 'ro-', 'LineWidth', 2, 'MarkerSize', 8);
xlabel('x');
ylabel('2^x (log scale)');
title('Log Scale: Straight Line!');
grid on;

fprintf('\nDone! You should see four figures.\n');

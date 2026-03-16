% MODULE 04: MATH FOUNDATIONS -- Matrix Transformations
% See what a matrix DOES to vectors: it stretches, rotates, and squishes.
%
% Part of the Matlab for Computational Neuroscience course
% Module 04: Math Foundations
%
% What you'll see when you run this:
%   Figure 1: Before/after quiver plots -- circle becomes an ellipse
%   Figure 2: Dot product visualization -- how similar are two directions?
%   Figure 3: Matrix multiply -- chaining two transformations

clear; clc; close all;

%% 1. A Matrix Transforms Vectors
% Think of a matrix as a machine: feed a vector in, get a transformed vector out.

% Create a circle of unit vectors (arrows pointing outward)
theta = linspace(0, 2*pi, 30);
arrows = [cos(theta); sin(theta)];   % 2x30 matrix: each column is a vector

% Our transformation matrix
A = [2 1; 0 1.5];

% Apply the transformation: multiply EVERY vector by A
transformed = A * arrows;

% Plot before and after
figure(1);
subplot(1, 2, 1);
quiver(zeros(1, 30), zeros(1, 30), arrows(1,:), arrows(2,:), 0, ...
    'LineWidth', 1.5, 'Color', [0.2 0.5 0.8]);
axis equal; grid on;
xlim([-3 3]); ylim([-3 3]);
title('Before: Circle of Arrows');
xlabel('x'); ylabel('y');

subplot(1, 2, 2);
quiver(zeros(1, 30), zeros(1, 30), transformed(1,:), transformed(2,:), 0, ...
    'LineWidth', 1.5, 'Color', [0.8 0.3 0.2]);
axis equal; grid on;
xlim([-3 3]); ylim([-3 3]);
title('After: Matrix Squishes the Circle');
xlabel('x'); ylabel('y');

sgtitle(sprintf('Matrix A = [%g %g; %g %g] transforms every vector', ...
    A(1,1), A(1,2), A(2,1), A(2,2)));

fprintf('Transformation matrix A:\n');
disp(A);
fprintf('A single vector [1; 0] transforms to:\n');
disp(A * [1; 0]);
fprintf('A single vector [0; 1] transforms to:\n');
disp(A * [0; 1]);

%% 2. Dot Product: How Similar Are Two Directions?
% The dot product measures how much two vectors point in the same direction.

a = [1, 0];     % pointing right
b = [0, 1];     % pointing up
c = [0.7, 0.7]; % pointing diagonally (roughly)

% Compute dot products
dot_ab = dot(a, b);   % perpendicular -> 0
dot_ac = dot(a, c);   % partly same direction -> positive
dot_aa = dot(a, a);   % identical direction -> maximum

fprintf('\n--- Dot Product Demo ---\n');
fprintf('dot(right, up)       = %.2f  (perpendicular)\n', dot_ab);
fprintf('dot(right, diagonal) = %.2f  (partly same direction)\n', dot_ac);
fprintf('dot(right, right)    = %.2f  (identical direction)\n', dot_aa);

% Visualize
figure(2);
quiver(0, 0, a(1), a(2), 0, 'b-', 'LineWidth', 2, 'MaxHeadSize', 0.5);
hold on;
quiver(0, 0, b(1), b(2), 0, 'r-', 'LineWidth', 2, 'MaxHeadSize', 0.5);
quiver(0, 0, c(1), c(2), 0, 'g-', 'LineWidth', 2, 'MaxHeadSize', 0.5);
hold off;
axis equal; grid on;
xlim([-0.5 1.5]); ylim([-0.5 1.5]);
legend(sprintf('a = [1,0]'), ...
       sprintf('b = [0,1], dot = %.1f', dot_ab), ...
       sprintf('c = [0.7,0.7], dot = %.1f', dot_ac));
title('Dot Product: How Similar Are Two Directions?');
xlabel('x'); ylabel('y');

%% 3. Matrix Multiplication: Chaining Transformations
% Multiplying two matrices = doing one transformation, then the other.

% Transformation 1: stretch x by 2
B1 = [2 0; 0 1];

% Transformation 2: shear (lean to the right)
B2 = [1 0.5; 0 1];

% Combined: first B1 (stretch), then B2 (shear)
C = B2 * B1;

% Apply each separately and combined
step1 = B1 * arrows;         % after stretch only
step2 = B2 * step1;          % after stretch then shear
combined = C * arrows;       % same result in one step

figure(3);
subplot(1, 3, 1);
quiver(zeros(1, 30), zeros(1, 30), step1(1,:), step1(2,:), 0, ...
    'LineWidth', 1.2, 'Color', [0.2 0.5 0.8]);
axis equal; grid on;
xlim([-3 3]); ylim([-3 3]);
title('Step 1: Stretch x by 2');

subplot(1, 3, 2);
quiver(zeros(1, 30), zeros(1, 30), step2(1,:), step2(2,:), 0, ...
    'LineWidth', 1.2, 'Color', [0.8 0.3 0.2]);
axis equal; grid on;
xlim([-3 3]); ylim([-3 3]);
title('Step 2: Then Shear');

subplot(1, 3, 3);
quiver(zeros(1, 30), zeros(1, 30), combined(1,:), combined(2,:), 0, ...
    'LineWidth', 1.2, 'Color', [0.4 0.7 0.3]);
axis equal; grid on;
xlim([-3 3]); ylim([-3 3]);
title('Combined (Same Result!)');

sgtitle('Matrix Multiply = Chaining Transformations');

fprintf('\n--- Matrix Multiplication ---\n');
fprintf('B1 (stretch x):\n');
disp(B1);
fprintf('B2 (shear):\n');
disp(B2);
fprintf('Combined C = B2 * B1:\n');
disp(C);
fprintf('Order matters! B1 * B2 gives a different result:\n');
disp(B1 * B2);

fprintf('\nDone! You should see three figures.\n');

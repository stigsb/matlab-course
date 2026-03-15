% MODULE 04: MATH FOUNDATIONS -- Eigenvalues: Directions That Survive
% Most vectors change direction when transformed. Eigenvectors don't.
%
% Part of the Matlab for Computational Neuroscience course
% Module 04: Math Foundations
%
% What you'll see when you run this:
%   Figure 1: All transformed vectors (gray) with eigenvectors highlighted
%   Figure 2: Verification -- eigenvectors before and after, same direction

clear; clc; close all;

%% 1. The Transformation
% Same matrix from demo_matrix_transform.m

A = [2 1; 0 1.5];

% Create a circle of arrows
theta = linspace(0, 2*pi, 40);
arrows = [cos(theta); sin(theta)];

% Transform all arrows
transformed = A * arrows;

%% 2. Find the Eigenvectors
% Eigenvectors are the special directions that KEEP their direction.

[V, D] = eig(A);

% Extract eigenvectors and eigenvalues
ev1 = V(:,1);   lambda1 = D(1,1);
ev2 = V(:,2);   lambda2 = D(2,2);

fprintf('--- Eigenvalue Decomposition ---\n');
fprintf('Matrix A:\n');
disp(A);
fprintf('Eigenvector 1: [%.3f; %.3f],  eigenvalue = %.2f\n', ev1(1), ev1(2), lambda1);
fprintf('Eigenvector 2: [%.3f; %.3f],  eigenvalue = %.2f\n', ev2(1), ev2(2), lambda2);

%% 3. Visualize: Directions That Survive
% Gray arrows: all vectors after transformation (they changed direction)
% Colored arrows: eigenvectors -- they KEPT their direction

figure(1);

% All transformed vectors in light gray
quiver(zeros(1, 40), zeros(1, 40), transformed(1,:), transformed(2,:), 0, ...
    'Color', [0.75 0.75 0.75], 'LineWidth', 0.8);
hold on;

% Eigenvector 1: before (dashed) and after (solid)
scale = 1.5;
quiver(0, 0, ev1(1)*scale, ev1(2)*scale, 0, 'b--', 'LineWidth', 2, 'MaxHeadSize', 0.5);
quiver(0, 0, ev1(1)*scale*lambda1, ev1(2)*scale*lambda1, 0, 'b-', 'LineWidth', 3, 'MaxHeadSize', 0.5);

% Eigenvector 2: before (dashed) and after (solid)
quiver(0, 0, ev2(1)*scale, ev2(2)*scale, 0, 'r--', 'LineWidth', 2, 'MaxHeadSize', 0.5);
quiver(0, 0, ev2(1)*scale*lambda2, ev2(2)*scale*lambda2, 0, 'r-', 'LineWidth', 3, 'MaxHeadSize', 0.5);

hold off;
axis equal; grid on;
xlim([-4 4]); ylim([-3 3]);
title('Eigenvectors: Directions That Survive the Transformation');
xlabel('x'); ylabel('y');
legend('Transformed vectors', ...
    sprintf('Eigenvector 1 before (\\lambda=%.1f)', lambda1), ...
    'Eigenvector 1 after (same direction, stretched)', ...
    sprintf('Eigenvector 2 before (\\lambda=%.1f)', lambda2), ...
    'Eigenvector 2 after (same direction, stretched)', ...
    'Location', 'southwest');

%% 4. Verify: A*v = lambda*v
% The eigenvalue equation: multiplying by the matrix gives the same result
% as multiplying by the scalar eigenvalue.

fprintf('\n--- Verification: A*v = lambda*v ---\n');

result1_matrix = A * ev1;
result1_scalar = lambda1 * ev1;
fprintf('Eigenvector 1:\n');
fprintf('  A * v1      = [%.4f; %.4f]\n', result1_matrix(1), result1_matrix(2));
fprintf('  lambda1 * v1 = [%.4f; %.4f]\n', result1_scalar(1), result1_scalar(2));
fprintf('  Same? %s\n', mat2str(round(result1_matrix - result1_scalar, 10) == 0));

result2_matrix = A * ev2;
result2_scalar = lambda2 * ev2;
fprintf('Eigenvector 2:\n');
fprintf('  A * v2      = [%.4f; %.4f]\n', result2_matrix(1), result2_matrix(2));
fprintf('  lambda2 * v2 = [%.4f; %.4f]\n', result2_scalar(1), result2_scalar(2));
fprintf('  Same? %s\n', mat2str(round(result2_matrix - result2_scalar, 10) == 0));

%% 5. Side-by-Side: Before and After
% A clearer view: eigenvectors stand out while everything else rotates.

figure(2);

subplot(1, 2, 1);
% Original arrows
quiver(zeros(1, 40), zeros(1, 40), arrows(1,:), arrows(2,:), 0, ...
    'Color', [0.75 0.75 0.75], 'LineWidth', 0.8);
hold on;
% Highlight eigenvectors in original
quiver(0, 0, ev1(1)*scale, ev1(2)*scale, 0, 'b-', 'LineWidth', 2.5, 'MaxHeadSize', 0.5);
quiver(0, 0, ev2(1)*scale, ev2(2)*scale, 0, 'r-', 'LineWidth', 2.5, 'MaxHeadSize', 0.5);
hold off;
axis equal; grid on;
xlim([-3 3]); ylim([-3 3]);
title('Before Transformation');
legend('All vectors', 'Eigenvector 1', 'Eigenvector 2', 'Location', 'southwest');

subplot(1, 2, 2);
% Transformed arrows
quiver(zeros(1, 40), zeros(1, 40), transformed(1,:), transformed(2,:), 0, ...
    'Color', [0.75 0.75 0.75], 'LineWidth', 0.8);
hold on;
% Highlight eigenvectors after transformation (same direction, different length)
quiver(0, 0, ev1(1)*scale*lambda1, ev1(2)*scale*lambda1, 0, 'b-', 'LineWidth', 2.5, 'MaxHeadSize', 0.5);
quiver(0, 0, ev2(1)*scale*lambda2, ev2(2)*scale*lambda2, 0, 'r-', 'LineWidth', 2.5, 'MaxHeadSize', 0.5);
hold off;
axis equal; grid on;
xlim([-4 4]); ylim([-3 3]);
title('After Transformation');
legend('All vectors', ...
    sprintf('Eigenvector 1 (stretched by %.1f)', lambda1), ...
    sprintf('Eigenvector 2 (stretched by %.1f)', lambda2), ...
    'Location', 'southwest');

sgtitle('Eigenvectors Keep Their Direction -- Only the Length Changes');

fprintf('\nDone! You should see two figures.\n');
fprintf('\nKey insight: Eigenvectors are the directions that SURVIVE\n');
fprintf('a transformation. Everything else gets twisted around.\n');

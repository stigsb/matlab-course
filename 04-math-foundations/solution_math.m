% MODULE 04: MATH FOUNDATIONS -- Exercise Solution
% Complete solution with all TODOs filled in.
%
% Part of the Matlab for Computational Neuroscience course
% Module 04: Math Foundations
%
% What you'll see when you run this:
%   Figure 1: Before/after rotation transformation
%   Figure 2: Plant height histogram with mean/std lines
%   Figure 3: Sunlight vs plant height correlation scatter
%   Figure 4: Eigenvector visualization for matrix [3 1; 0 2]

clear; clc; close all;

%% Part 1: Matrix Transformations

% A rotation matrix that rotates vectors by 45 degrees
angle = pi/4;
R = [cos(angle), -sin(angle);
     sin(angle),  cos(angle)];

% Create a circle of unit vectors
theta = linspace(0, 2*pi, 30);
arrows = [cos(theta); sin(theta)];

% TODO 1: Apply the rotation matrix R to the arrows.
transformed = R * arrows;

% Plot before and after
figure(1);
subplot(1, 2, 1);
quiver(zeros(1, 30), zeros(1, 30), arrows(1,:), arrows(2,:), 0, ...
    'LineWidth', 1.2, 'Color', [0.2 0.5 0.8]);
axis equal; grid on; xlim([-2 2]); ylim([-2 2]);
title('Before: Circle of Arrows');

subplot(1, 2, 2);
quiver(zeros(1, 30), zeros(1, 30), transformed(1,:), transformed(2,:), 0, ...
    'LineWidth', 1.2, 'Color', [0.8 0.3 0.2]);
axis equal; grid on; xlim([-2 2]); ylim([-2 2]);
title('After: Rotated by 45 degrees');
sgtitle('Rotation Transformation');

% TODO 2: Compute the dot product.
a = [1, 0];
b = [0.5, 0.866];
similarity = dot(a, b);

fprintf('Dot product of a and b: %.3f\n', similarity);
fprintf('(Should be 0.5 -- they are 60 degrees apart)\n');

% TODO 3: Compute the combined transformation matrix.
S = [3 0; 0 1];
combined = R * S;

fprintf('Combined matrix:\n');
disp(combined);
fprintf('Applying combined to [1;0]: [%.2f; %.2f]\n', combined * [1; 0]);

%% Part 2: Statistics

plant_heights = [15, 22, 18, 25, 12, 20, 28, 16, 23, 19, 21, 17, 24, 14, 26];

% TODO 4: Compute the mean.
avg_height = mean(plant_heights);
fprintf('\nMean plant height: %.1f cm\n', avg_height);

% TODO 5: Compute the standard deviation.
spread = std(plant_heights);
fprintf('Std deviation: %.1f cm\n', spread);

% TODO 6: Plot histogram with mean and std lines.
figure(2);
histogram(plant_heights, 8, 'FaceColor', [0.5 0.8 0.5]);
hold on;
xline(avg_height, 'r-', 'LineWidth', 2);
xline(avg_height + spread, 'r--', 'LineWidth', 1);
xline(avg_height - spread, 'r--', 'LineWidth', 1);
hold off;
xlabel('Height (cm)');
ylabel('Count');
title(sprintf('Plant Heights: mean = %.1f, std = %.1f', avg_height, spread));
legend('Data', 'Mean', '+/- 1 Std');
grid on;

% Correlation
rng(42);
sunlight_hours = plant_heights * 0.3 + randn(1, 15) * 1.5 + 2;

% TODO 7: Compute the correlation.
R = corrcoef(plant_heights, sunlight_hours);
r = R(1,2);

fprintf('\nCorrelation between plant heights and sunlight: r = %.2f\n', r);

figure(3);
scatter(sunlight_hours, plant_heights, 60, 'filled', ...
    'MarkerFaceColor', [0.3 0.7 0.4]);
xlabel('Sunlight (hours/day)');
ylabel('Plant Height (cm)');
title(sprintf('Sunlight vs Plant Height (r = %.2f)', r));
grid on;

%% Part 3: Eigenvalues

A = [3 1; 0 2];

% TODO 8: Compute eigenvectors and eigenvalues.
[V, D] = eig(A);

% TODO 9: Extract first eigenvector and eigenvalue.
ev1 = V(:,1);
lambda1 = D(1,1);

fprintf('\nEigenvector 1: [%.3f; %.3f]\n', ev1(1), ev1(2));
fprintf('Eigenvalue 1:  %.2f\n', lambda1);
fprintf('Verification: A*v1 = [%.3f; %.3f]\n', A*ev1);
fprintf('              lambda1*v1 = [%.3f; %.3f]\n', lambda1*ev1);

% TODO 10: Plot with eigenvectors highlighted.
figure(4);
theta_plot = linspace(0, 2*pi, 40);
circle = [cos(theta_plot); sin(theta_plot)];
transformed_circle = A * circle;

% Gray: all transformed vectors
quiver(zeros(1, 40), zeros(1, 40), ...
    transformed_circle(1,:), transformed_circle(2,:), 0, ...
    'Color', [0.75 0.75 0.75]);
hold on;

% Blue: first eigenvector before and after
sc = 1.5;
quiver(0, 0, ev1(1)*sc, ev1(2)*sc, 0, 'b--', 'LineWidth', 2, 'MaxHeadSize', 0.5);
quiver(0, 0, ev1(1)*sc*lambda1, ev1(2)*sc*lambda1, 0, 'b-', 'LineWidth', 3, 'MaxHeadSize', 0.5);

% Red: second eigenvector before and after
ev2 = V(:,2); lambda2 = D(2,2);
quiver(0, 0, ev2(1)*sc, ev2(2)*sc, 0, 'r--', 'LineWidth', 2, 'MaxHeadSize', 0.5);
quiver(0, 0, ev2(1)*sc*lambda2, ev2(2)*sc*lambda2, 0, 'r-', 'LineWidth', 3, 'MaxHeadSize', 0.5);

hold off;
axis equal; grid on;
title('Eigenvectors: Directions That Survive');
xlabel('x'); ylabel('y');
legend('Transformed vectors', ...
    sprintf('Eigenvec 1 before (\\lambda=%.1f)', lambda1), ...
    'Eigenvec 1 after', ...
    sprintf('Eigenvec 2 before (\\lambda=%.1f)', lambda2), ...
    'Eigenvec 2 after', ...
    'Location', 'southwest');

%% Part 4: Challenge

% TODO 11: Stretch matrix.
stretch_matrix = [3 0; 0 1];

test_vectors = [1 0 1; 0 1 1];
stretched = stretch_matrix * test_vectors;
fprintf('\nChallenge: Stretch x by 3\n');
fprintf('  [1;0] -> [%.1f; %.1f]\n', stretched(:,1));
fprintf('  [0;1] -> [%.1f; %.1f]\n', stretched(:,2));
fprintf('  [1;1] -> [%.1f; %.1f]\n', stretched(:,3));

% TODO 12: Eigenvectors of the stretch matrix.
[V_stretch, D_stretch] = eig(stretch_matrix);

fprintf('Eigenvectors of stretch matrix:\n');
fprintf('  v1 = [%.1f; %.1f], lambda = %.1f\n', V_stretch(:,1), D_stretch(1,1));
fprintf('  v2 = [%.1f; %.1f], lambda = %.1f\n', V_stretch(:,2), D_stretch(2,2));

fprintf('\nDone! You should see four figures.\n');

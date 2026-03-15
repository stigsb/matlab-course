% MODULE 04: MATH FOUNDATIONS -- Exercise
% Practice with matrix transformations, statistics, and eigenvalues.
%
% Part of the Matlab for Computational Neuroscience course
% Module 04: Math Foundations
%
% Instructions: Fill in the lines marked with % TODO.
% After each TODO, uncomment the fprintf/plot lines below to check your answer.
%
% What you'll produce when complete:
%   Figure 1: Before/after transformation of a circle of arrows
%   Figure 2: Histogram of plant heights with mean and std lines
%   Figure 3: Scatter plot showing correlation
%   Figure 4: Eigenvector visualization

clear; clc; close all;

%% Part 1: Matrix Transformations (3 TODOs)
% Apply a matrix to vectors and visualize the transformation.

% A rotation matrix that rotates vectors by 45 degrees
angle = pi/4;   % 45 degrees in radians
R = [cos(angle), -sin(angle);
     sin(angle),  cos(angle)];

% Create a circle of unit vectors
theta = linspace(0, 2*pi, 30);
arrows = [cos(theta); sin(theta)];

% TODO 1: Apply the rotation matrix R to the arrows.
% Hint: matrix-vector multiplication uses the * operator
% transformed = ???

% Uncomment to plot:
% figure(1);
% subplot(1, 2, 1);
% quiver(zeros(1, 30), zeros(1, 30), arrows(1,:), arrows(2,:), 0, ...
%     'LineWidth', 1.2, 'Color', [0.2 0.5 0.8]);
% axis equal; grid on; xlim([-2 2]); ylim([-2 2]);
% title('Before: Circle of Arrows');
%
% subplot(1, 2, 2);
% quiver(zeros(1, 30), zeros(1, 30), transformed(1,:), transformed(2,:), 0, ...
%     'LineWidth', 1.2, 'Color', [0.8 0.3 0.2]);
% axis equal; grid on; xlim([-2 2]); ylim([-2 2]);
% title('After: Rotated by 45 degrees');
% sgtitle('Rotation Transformation');

% TODO 2: Compute the dot product of these two vectors.
% Hint: use the dot() function
a = [1, 0];    % pointing right
b = [0.5, 0.866];  % pointing at 60 degrees
% similarity = ???

% Uncomment to check:
% fprintf('Dot product of a and b: %.3f\n', similarity);
% fprintf('(Should be 0.5 -- they are 60 degrees apart)\n');

% TODO 3: Compute the combined transformation matrix.
% First scale x by 3 (S), then rotate by 45 degrees (R).
% Hint: combined = second_transform * first_transform
S = [3 0; 0 1];   % scale x by 3, leave y alone
% combined = ???

% Uncomment to check:
% fprintf('Combined matrix:\n');
% disp(combined);
% fprintf('Applying combined to [1;0]: [%.2f; %.2f]\n', combined * [1; 0]);

%% Part 2: Statistics (4 TODOs)
% Compute statistics and visualize with plots.

% Plant heights measured in a garden (cm)
plant_heights = [15, 22, 18, 25, 12, 20, 28, 16, 23, 19, 21, 17, 24, 14, 26];

% TODO 4: Compute the mean of plant_heights.
% Hint: use the mean() function
% avg_height = ???

% Uncomment to check:
% fprintf('\nMean plant height: %.1f cm\n', avg_height);

% TODO 5: Compute the standard deviation of plant_heights.
% Hint: use the std() function
% spread = ???

% Uncomment to check:
% fprintf('Std deviation: %.1f cm\n', spread);

% TODO 6: Plot a histogram with mean and std lines.
% Hint: use histogram(), then hold on, xline() for mean and +/- 1 std
% figure(2);
% histogram(plant_heights, 8, 'FaceColor', [0.5 0.8 0.5]);
% hold on;
% ??? % draw a red solid line at the mean
% ??? % draw red dashed lines at mean + spread and mean - spread
% hold off;
% xlabel('Height (cm)');
% ylabel('Count');
% title(sprintf('Plant Heights: mean = %.1f, std = %.1f', avg_height, spread));
% legend('Data', 'Mean', '+/- 1 Std');
% grid on;

% Sunlight hours for the same plants (roughly correlated with height)
rng(42);
sunlight_hours = plant_heights * 0.3 + randn(1, 15) * 1.5 + 2;

% TODO 7: Compute the correlation between plant_heights and sunlight_hours.
% IMPORTANT: corrcoef returns a MATRIX. Extract the value at position (1,2).
% Hint: R = corrcoef(x, y); r = R(1,2);
% R = ???
% r = ???

% Uncomment to plot:
% figure(3);
% scatter(sunlight_hours, plant_heights, 60, 'filled', ...
%     'MarkerFaceColor', [0.3 0.7 0.4]);
% xlabel('Sunlight (hours/day)');
% ylabel('Plant Height (cm)');
% title(sprintf('Sunlight vs Plant Height (r = %.2f)', r));
% grid on;

%% Part 3: Eigenvalues (3 TODOs)
% Find the directions that survive a transformation.

% A transformation matrix
A = [3 1; 0 2];

% TODO 8: Compute the eigenvectors and eigenvalues of A.
% Hint: [V, D] = eig(A)  -- V columns are eigenvectors, D diagonal has eigenvalues
% [V, D] = ???

% TODO 9: Extract the first eigenvector and its eigenvalue.
% Hint: first eigenvector is V(:,1), first eigenvalue is D(1,1)
% ev1 = ???
% lambda1 = ???

% Uncomment to check:
% fprintf('\nEigenvector 1: [%.3f; %.3f]\n', ev1(1), ev1(2));
% fprintf('Eigenvalue 1:  %.2f\n', lambda1);
% fprintf('Verification: A*v1 = [%.3f; %.3f]\n', A*ev1);
% fprintf('              lambda1*v1 = [%.3f; %.3f]\n', lambda1*ev1);

% TODO 10: Plot the transformation with eigenvectors highlighted.
% The scaffolding below creates the plot. Fill in the eigenvector arrows.
% figure(4);
% theta_plot = linspace(0, 2*pi, 40);
% circle = [cos(theta_plot); sin(theta_plot)];
% transformed_circle = A * circle;
%
% % Gray: all transformed vectors
% quiver(zeros(1, 40), zeros(1, 40), ...
%     transformed_circle(1,:), transformed_circle(2,:), 0, ...
%     'Color', [0.75 0.75 0.75]);
% hold on;
%
% % Blue: first eigenvector before and after
% sc = 1.5;
% quiver(0, 0, ev1(1)*sc, ev1(2)*sc, 0, 'b--', 'LineWidth', 2);
% ??? % Plot the TRANSFORMED first eigenvector (ev1 * lambda1 * sc) as solid blue
%
% % Red: second eigenvector before and after
% ev2 = V(:,2); lambda2 = D(2,2);
% quiver(0, 0, ev2(1)*sc, ev2(2)*sc, 0, 'r--', 'LineWidth', 2);
% ??? % Plot the TRANSFORMED second eigenvector as solid red
%
% hold off;
% axis equal; grid on;
% title('Eigenvectors: Directions That Survive');
% xlabel('x'); ylabel('y');

%% Part 4: Challenge (2 TODOs, optional)
% Design your own transformation matrix.

% TODO 11 (Challenge): Create a 2x2 matrix that stretches the x-direction
% by 3 and leaves the y-direction unchanged.
% Hint: Think about what [3 0; 0 ?] should be.
% stretch_matrix = ???

% Uncomment to test:
% test_vectors = [1 0 1; 0 1 1];  % right, up, diagonal
% stretched = stretch_matrix * test_vectors;
% fprintf('\nChallenge: Stretch x by 3\n');
% fprintf('  [1;0] -> [%.1f; %.1f]\n', stretched(:,1));
% fprintf('  [0;1] -> [%.1f; %.1f]\n', stretched(:,2));
% fprintf('  [1;1] -> [%.1f; %.1f]\n', stretched(:,3));

% TODO 12 (Challenge): What are the eigenvectors of your stretch matrix?
% Predict them first, then compute to check.
% Prediction: the eigenvectors should be [1;0] and [0;1] because
% stretching along x does not change the direction of either axis.
% [V_stretch, D_stretch] = ???

% Uncomment to verify your prediction:
% fprintf('Eigenvectors of stretch matrix:\n');
% fprintf('  v1 = [%.1f; %.1f], lambda = %.1f\n', V_stretch(:,1), D_stretch(1,1));
% fprintf('  v2 = [%.1f; %.1f], lambda = %.1f\n', V_stretch(:,2), D_stretch(2,2));

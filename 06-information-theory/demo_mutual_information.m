% MODULE 06: INFORMATION THEORY -- Mutual Information
% How much does a neural response tell you about the stimulus?
%
% Part of the Matlab for Computational Neuroscience course
% Module 06: Information Theory
%
% What you'll see when you run this:
%   Figure 1: Joint probability matrix (stimulus x response bins)
%   Figure 2: Marginal distributions of stimulus and response
%   Figure 3: Real vs shuffled MI comparison
%   Figure 4: Conceptual Venn diagram of entropy and MI

clear; clc; close all;
rng(42);  % Reproducible results

%% 1. Simulate a Neural Experiment
% 4 stimuli, each presented 100 times. The neuron responds differently
% to each stimulus (with noise).

n_stimuli = 4;
trials_per_stim = 100;
n_trials = n_stimuli * trials_per_stim;

% Create stimulus sequence (equal number of each)
stimuli = repelem(1:n_stimuli, trials_per_stim);

% Neuron responds with different mean spike counts for each stimulus
mean_responses = [3, 6, 10, 15];  % spikes per trial
responses = zeros(1, n_trials);
for i = 1:n_trials
    % Noisy response: mean + Gaussian noise, clipped to >= 0
    responses(i) = max(0, round(mean_responses(stimuli(i)) + randn * 2));
end

fprintf('--- Neural Experiment ---\n');
fprintf('  Stimuli: %d types, %d trials each (%d total)\n', ...
    n_stimuli, trials_per_stim, n_trials);
fprintf('  Mean responses per stimulus: [%s]\n', num2str(mean_responses));

%% 2. Build Joint Probability Matrix
% Count how often each (stimulus, response) pair occurs.

% Bin the responses into discrete categories
resp_edges = 0:3:21;  % bins: 0-2, 3-5, 6-8, ..., 18-20
n_resp_bins = length(resp_edges) - 1;
[~, ~, resp_bins] = histcounts(responses, resp_edges);

% Build joint count matrix
joint = zeros(n_stimuli, n_resp_bins);
for s = 1:n_stimuli
    for r = 1:n_resp_bins
        joint(s, r) = sum(stimuli == s & resp_bins == r);
    end
end

% Normalize to probabilities
joint_prob = joint / sum(joint(:));

% Marginal distributions
p_stim = sum(joint_prob, 2)';   % sum over response bins
p_resp = sum(joint_prob, 1);    % sum over stimuli

%% 3. Compute Entropy and Mutual Information

% H(response) -- overall uncertainty about the response
H_resp = compute_entropy(p_resp);

% H(response | stimulus) -- remaining uncertainty given the stimulus
H_resp_given_stim = 0;
for s = 1:n_stimuli
    if p_stim(s) > 0
        p_r_given_s = joint_prob(s, :) / p_stim(s);
        % Weighted by probability of this stimulus
        H_resp_given_stim = H_resp_given_stim + ...
            p_stim(s) * compute_entropy(p_r_given_s);
    end
end

% MI = H(R) - H(R|S)
MI = H_resp - H_resp_given_stim;

fprintf('\n--- Information Quantities ---\n');
fprintf('  H(response)          = %.2f bits\n', H_resp);
fprintf('  H(response|stimulus) = %.2f bits\n', H_resp_given_stim);
fprintf('  MI(stimulus;response) = %.2f bits\n', MI);
fprintf('  Interpretation: knowing the stimulus reduces response\n');
fprintf('  uncertainty by %.2f bits (out of %.2f total).\n', MI, H_resp);

%% 4. Visualize the Joint Distribution
figure(1);
imagesc(joint_prob);
colorbar;
colormap('parula');
xlabel('Response bin');
ylabel('Stimulus');
title(sprintf('Joint Probability P(stimulus, response)\nMI = %.2f bits', MI));
set(gca, 'YTick', 1:n_stimuli);
resp_labels = cell(1, n_resp_bins);
for r = 1:n_resp_bins
    resp_labels{r} = sprintf('%d-%d', resp_edges(r), resp_edges(r+1)-1);
end
set(gca, 'XTick', 1:n_resp_bins, 'XTickLabel', resp_labels);
xtickangle(45);

%% 5. Plot Marginal Distributions
figure(2);
subplot(1, 2, 1);
bar(1:n_stimuli, p_stim, 'FaceColor', [0.4 0.6 0.9]);
xlabel('Stimulus');
ylabel('Probability');
title(sprintf('P(stimulus)\nH = %.2f bits', compute_entropy(p_stim)));
grid on;

subplot(1, 2, 2);
bar(1:n_resp_bins, p_resp, 'FaceColor', [0.9 0.5 0.3]);
xlabel('Response bin');
ylabel('Probability');
title(sprintf('P(response)\nH = %.2f bits', H_resp));
grid on;
sgtitle('Marginal Distributions');

%% 6. Control: Shuffled Data Should Have MI Near Zero
% If we break the stimulus-response pairing, the neuron's response
% should not tell us anything about the stimulus.

shuffled_stimuli = stimuli(randperm(n_trials));

% Rebuild joint distribution with shuffled pairing
joint_shuf = zeros(n_stimuli, n_resp_bins);
for s = 1:n_stimuli
    for r = 1:n_resp_bins
        joint_shuf(s, r) = sum(shuffled_stimuli == s & resp_bins == r);
    end
end
joint_prob_shuf = joint_shuf / sum(joint_shuf(:));

p_stim_shuf = sum(joint_prob_shuf, 2)';
p_resp_shuf = sum(joint_prob_shuf, 1);

H_resp_shuf = compute_entropy(p_resp_shuf);
H_resp_given_stim_shuf = 0;
for s = 1:n_stimuli
    if p_stim_shuf(s) > 0
        p_r_given_s = joint_prob_shuf(s, :) / p_stim_shuf(s);
        H_resp_given_stim_shuf = H_resp_given_stim_shuf + ...
            p_stim_shuf(s) * compute_entropy(p_r_given_s);
    end
end
MI_shuf = H_resp_shuf - H_resp_given_stim_shuf;

fprintf('\n--- Shuffled Control ---\n');
fprintf('  H(response)          = %.2f bits\n', H_resp_shuf);
fprintf('  H(response|stimulus) = %.2f bits\n', H_resp_given_stim_shuf);
fprintf('  MI(stimulus;response) = %.3f bits  (should be near 0)\n', MI_shuf);

% Compare real vs shuffled
figure(3);
bar([MI, MI_shuf], 'FaceColor', [0.3 0.7 0.5]);
set(gca, 'XTickLabel', {'Real pairing', 'Shuffled (control)'});
ylabel('Mutual Information (bits)');
title('Real vs Shuffled: Does the Neuron Carry Information?');
grid on;
text(1, MI + 0.05, sprintf('%.2f bits', MI), ...
    'HorizontalAlignment', 'center', 'FontWeight', 'bold');
text(2, MI_shuf + 0.05, sprintf('%.3f bits', MI_shuf), ...
    'HorizontalAlignment', 'center', 'FontWeight', 'bold');

%% 7. Conceptual Venn Diagram
% H(X), H(Y), and their overlap = MI(X;Y)

figure(4);
% Draw two overlapping circles using rectangle with Curvature
ax = axes;
hold on;

% Left circle: H(stimulus)
H_stim = compute_entropy(p_stim);
rectangle('Position', [1, 1, 4, 4], 'Curvature', [1 1], ...
    'EdgeColor', [0.2 0.4 0.8], 'LineWidth', 2.5);
% Right circle: H(response)
rectangle('Position', [3, 1, 4, 4], 'Curvature', [1 1], ...
    'EdgeColor', [0.8 0.3 0.2], 'LineWidth', 2.5);

% Labels
text(2.0, 3, sprintf('H(S)\n%.2f bits', H_stim), ...
    'HorizontalAlignment', 'center', 'FontSize', 11, ...
    'Color', [0.2 0.4 0.8], 'FontWeight', 'bold');
text(6.0, 3, sprintf('H(R)\n%.2f bits', H_resp), ...
    'HorizontalAlignment', 'center', 'FontSize', 11, ...
    'Color', [0.8 0.3 0.2], 'FontWeight', 'bold');
text(4.0, 3, sprintf('MI\n%.2f\nbits', MI), ...
    'HorizontalAlignment', 'center', 'FontSize', 10, ...
    'Color', [0.1 0.6 0.1], 'FontWeight', 'bold');

% Title and formatting
title('Entropy Venn Diagram: MI Is the Overlap');
axis equal;
xlim([0, 8]);
ylim([0, 6]);
axis off;

% Legend text
text(4, 0.5, 'MI(S;R) = H(R) - H(R|S) = what the response tells you about the stimulus', ...
    'HorizontalAlignment', 'center', 'FontSize', 9, 'FontStyle', 'italic');

hold off;

fprintf('\nDone! You should see four figures.\n');

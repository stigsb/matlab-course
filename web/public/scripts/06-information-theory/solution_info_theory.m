% MODULE 06: INFORMATION THEORY -- Solution
% Complete solution with all TODOs filled in.
%
% Part of the Matlab for Computational Neuroscience course
% Module 06: Information Theory

clear; clc; close all;
rng(42);

%% Part 1: Logarithm Warm-Up

% TODO 1: Compute log2 of these values
values = [1, 2, 4, 8, 16, 64, 256, 1024];
my_logs = log2(values);

fprintf('--- Logarithm Warm-Up ---\n');
for i = 1:length(values)
    fprintf('  log2(%4d) = %.0f\n', values(i), my_logs(i));
end
fprintf('  log2(1) should be 0, log2(1024) should be 10.\n');

% TODO 2: Verify multiplication -> addition property
way1 = log2(16 * 32);
way2 = log2(16) + log2(32);

fprintf('\n  log2(16 * 32) = %.0f\n', way1);
fprintf('  log2(16) + log2(32) = %.0f + %.0f = %.0f\n', ...
    log2(16), log2(32), way2);
fprintf('  Same? %s\n', mat2str(way1 == way2));

%% Part 2: Entropy

% TODO 3: Fair 6-sided die
p_fair_die = ones(1, 6) / 6;

fprintf('\n--- Entropy ---\n');
fprintf('  Fair die probabilities: [%s]\n', num2str(p_fair_die, '%.3f '));
fprintf('  Sum = %.4f (should be 1.0000)\n', sum(p_fair_die));

% TODO 4: Entropy of fair die
H_fair = compute_entropy(p_fair_die);

fprintf('  Entropy of fair 6-sided die: %.2f bits\n', H_fair);
fprintf('  Maximum possible for 6 outcomes: %.2f bits (= log2(6))\n', log2(6));

% TODO 5: Loaded die
p_loaded_die = [0.4, 0.2, 0.15, 0.1, 0.1, 0.05];
H_loaded = compute_entropy(p_loaded_die);

fprintf('  Entropy of loaded die: %.2f bits\n', H_loaded);
fprintf('  Loaded die has LESS entropy (less surprise) than fair die.\n');

% TODO 6: Plot both distributions
figure(1);
subplot(1, 2, 1);
bar(p_fair_die, 'FaceColor', [0.4 0.6 0.9]);
ylim([0 0.5]);
xlabel('Outcome'); ylabel('Probability');
title(sprintf('Fair Die\nH = %.2f bits', H_fair));
grid on;

subplot(1, 2, 2);
bar(p_loaded_die, 'FaceColor', [0.9 0.5 0.3]);
ylim([0 0.5]);
xlabel('Outcome'); ylabel('Probability');
title(sprintf('Loaded Die\nH = %.2f bits', H_loaded));
grid on;
sgtitle('Fair vs Loaded: More Uniform = More Entropy');

%% Part 3: Mutual Information

n_stimuli = 3;
trials_per_stim = 80;
n_trials = n_stimuli * trials_per_stim;
stimuli = repelem(1:n_stimuli, trials_per_stim);
mean_spike_counts = [4, 8, 14];

% TODO 7: Simulate noisy responses
responses = round(mean_spike_counts(stimuli) + randn(1, n_trials) * 3);
responses = max(responses, 0);

% TODO 8: Build joint probability matrix
resp_edges = 0:3:24;
n_resp_bins = length(resp_edges) - 1;
[~, ~, resp_bins] = histcounts(responses, resp_edges);

joint = zeros(n_stimuli, n_resp_bins);
for s = 1:n_stimuli
    for r = 1:n_resp_bins
        joint(s, r) = sum(stimuli == s & resp_bins == r);
    end
end
joint_prob = joint / sum(joint(:));

figure(2);
imagesc(joint_prob);
colorbar;
xlabel('Response bin'); ylabel('Stimulus');
title('Joint Probability Matrix');

% TODO 9: Compute H(response) and H(response | stimulus)
p_resp = sum(joint_prob, 1);
p_stim = sum(joint_prob, 2)';
H_resp = compute_entropy(p_resp);

H_resp_given_stim = 0;
for s = 1:n_stimuli
    p_r_given_s = joint_prob(s, :) / p_stim(s);
    H_resp_given_stim = H_resp_given_stim + ...
        p_stim(s) * compute_entropy(p_r_given_s);
end

% TODO 10: Calculate MI
MI = H_resp - H_resp_given_stim;

fprintf('\n--- Mutual Information ---\n');
fprintf('  H(response)           = %.2f bits\n', H_resp);
fprintf('  H(response | stimulus) = %.2f bits\n', H_resp_given_stim);
fprintf('  MI(stimulus; response) = %.2f bits\n', MI);
fprintf('  The neuron carries %.2f bits about which stimulus was shown.\n', MI);

%% Part 4: Challenge

% TODO 11: MI vs noise level
noise_levels = [0.5, 1, 2, 4, 8, 16, 32];
MI_vs_noise = zeros(size(noise_levels));

for n_idx = 1:length(noise_levels)
    noise = noise_levels(n_idx);
    responses_n = max(0, round(mean_spike_counts(stimuli) + randn(1, n_trials) * noise));
    [~, ~, rb] = histcounts(responses_n, resp_edges);

    jt = zeros(n_stimuli, n_resp_bins);
    for s = 1:n_stimuli
        for r = 1:n_resp_bins
            jt(s, r) = sum(stimuli == s & rb == r);
        end
    end
    jp = jt / sum(jt(:));
    pr = sum(jp, 1);
    ps = sum(jp, 2)';
    hr = compute_entropy(pr);
    hrs = 0;
    for s = 1:n_stimuli
        prs = jp(s, :) / ps(s);
        hrs = hrs + ps(s) * compute_entropy(prs);
    end
    MI_vs_noise(n_idx) = hr - hrs;
end

figure(3);
plot(noise_levels, MI_vs_noise, 'bo-', 'LineWidth', 2, 'MarkerSize', 8);
xlabel('Noise Level (std of Gaussian noise)');
ylabel('Mutual Information (bits)');
title('More Noise = Less Information');
grid on;

% TODO 12: Explanation
% With infinite noise, the response distribution becomes the same
% regardless of which stimulus was shown. That means
% P(response | stimulus) = P(response) for all stimuli,
% so H(response | stimulus) = H(response), and MI = 0.
% The noise completely drowns out the signal, so the neuron's
% response tells you nothing about the stimulus.

fprintf('\nDone! You should see three figures.\n');

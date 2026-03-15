% MODULE 06: INFORMATION THEORY -- Exercise
% Practice with logarithms, entropy, and mutual information.
%
% Part of the Matlab for Computational Neuroscience course
% Module 06: Information Theory
%
% Instructions: Fill in the lines marked with % TODO.
% After each TODO, uncomment the fprintf/plot lines below to check your answer.
%
% What you'll produce when complete:
%   Figure 1: Two dice distributions with entropy values
%   Figure 2: Joint probability heatmap for stimulus-response
%   Figure 3: MI vs noise level (challenge)

clear; clc; close all;
rng(42);  % Reproducible results

%% Part 1: Logarithm Warm-Up (2 TODOs)
% Verify your intuition: "How many times do you double?"

% TODO 1: Compute log2 of these values and store in a vector.
% values = [1, 2, 4, 8, 16, 64, 256, 1024]
% Hint: log2() works on entire vectors at once.
% my_logs = ???

% Uncomment to check:
% fprintf('--- Logarithm Warm-Up ---\n');
% for i = 1:length(values)
%     fprintf('  log2(%4d) = %.0f\n', values(i), my_logs(i));
% end
% fprintf('  log2(1) should be 0, log2(1024) should be 10.\n');

% TODO 2: Verify that log2 turns multiplication into addition.
% Compute log2(16 * 32) in two ways:
%   Way 1: log2(16 * 32) directly
%   Way 2: log2(16) + log2(32)
% Store in way1 and way2.
% way1 = ???
% way2 = ???

% Uncomment to check:
% fprintf('\n  log2(16 * 32) = %.0f\n', way1);
% fprintf('  log2(16) + log2(32) = %.0f + %.0f = %.0f\n', ...
%     log2(16), log2(32), way2);
% fprintf('  Same? %s\n', isequal(way1, way2));

%% Part 2: Entropy (4 TODOs)
% Compute entropy and understand what it measures.

% TODO 3: Create a probability distribution for a fair 6-sided die.
% Hint: all 6 outcomes have equal probability. Use ones() and divide.
% p_fair_die = ???

% Uncomment to check:
% fprintf('\n--- Entropy ---\n');
% fprintf('  Fair die probabilities: [%s]\n', num2str(p_fair_die, '%.3f '));
% fprintf('  Sum = %.4f (should be 1.0000)\n', sum(p_fair_die));

% TODO 4: Use compute_entropy() to find the entropy of the fair die.
% Hint: the function is in compute_entropy.m in this same folder.
% H_fair = ???

% Uncomment to check:
% fprintf('  Entropy of fair 6-sided die: %.2f bits\n', H_fair);
% fprintf('  Maximum possible for 6 outcomes: %.2f bits (= log2(6))\n', log2(6));

% TODO 5: Create a loaded die distribution and compute its entropy.
% Use these probabilities: [0.4, 0.2, 0.15, 0.1, 0.1, 0.05]
% (The die is weighted toward outcome 1.)
% p_loaded_die = ???
% H_loaded = ???

% Uncomment to check:
% fprintf('  Entropy of loaded die: %.2f bits\n', H_loaded);
% fprintf('  Loaded die has LESS entropy (less surprise) than fair die.\n');

% TODO 6: Plot both distributions and their entropies side by side.
% Create a figure with 2 subplots (1 row, 2 columns).
% Left: bar chart of p_fair_die, title includes H_fair
% Right: bar chart of p_loaded_die, title includes H_loaded
% figure(1);
% subplot(1, 2, 1);
% ??? % bar chart of fair die
% ylim([0 0.5]);
% xlabel('Outcome'); ylabel('Probability');
% title(sprintf('Fair Die\nH = %.2f bits', H_fair));
% grid on;
%
% subplot(1, 2, 2);
% ??? % bar chart of loaded die
% ylim([0 0.5]);
% xlabel('Outcome'); ylabel('Probability');
% title(sprintf('Loaded Die\nH = %.2f bits', H_loaded));
% grid on;
% sgtitle('Fair vs Loaded: More Uniform = More Entropy');

%% Part 3: Mutual Information (4 TODOs)
% Simulate a neuron and compute how much its response tells you about the stimulus.

% Setup: 3 stimulus categories, 80 trials each
n_stimuli = 3;
trials_per_stim = 80;
n_trials = n_stimuli * trials_per_stim;
stimuli = repelem(1:n_stimuli, trials_per_stim);

% The neuron responds with different mean spike counts per stimulus
mean_spike_counts = [4, 8, 14];  % low, medium, high

% TODO 7: Simulate the neuron's noisy response.
% For each trial, generate a spike count:
%   response = round(mean_spike_counts(stimulus) + randn * 3)
% Clip to >= 0 (no negative spike counts).
% Store in a vector called responses.
% Hint: use a for loop over trials, or try vectorized: round(mean_spike_counts(stimuli) + randn(1,n_trials)*3)
% responses = ???
% responses = max(responses, 0);

% TODO 8: Build the joint probability matrix from stimulus-response data.
% Bin responses using edges 0:3:24 and histcounts.
% Then count co-occurrences of each (stimulus, response_bin) pair.
% resp_edges = 0:3:24;
% n_resp_bins = length(resp_edges) - 1;
% [~, ~, resp_bins] = histcounts(responses, resp_edges);
%
% joint = zeros(n_stimuli, n_resp_bins);
% for s = 1:n_stimuli
%     for r = 1:n_resp_bins
%         ??? % count how many trials have stimulus==s AND resp_bins==r
%     end
% end
% joint_prob = joint / sum(joint(:));  % normalize to probabilities

% Uncomment to visualize:
% figure(2);
% imagesc(joint_prob);
% colorbar;
% xlabel('Response bin'); ylabel('Stimulus');
% title('Joint Probability Matrix');

% TODO 9: Compute H(response) and H(response | stimulus).
% Use compute_entropy() for each.
% p_resp = sum(joint_prob, 1);     % marginal response distribution
% p_stim = sum(joint_prob, 2)';    % marginal stimulus distribution
% H_resp = ???  % entropy of the response marginal
%
% H_resp_given_stim = 0;
% for s = 1:n_stimuli
%     p_r_given_s = joint_prob(s, :) / p_stim(s);
%     H_resp_given_stim = H_resp_given_stim + ...
%         p_stim(s) * ???;  % entropy of conditional distribution
% end

% TODO 10: Calculate MI and print the result.
% MI = H(response) - H(response | stimulus)
% MI = ???

% Uncomment to check:
% fprintf('\n--- Mutual Information ---\n');
% fprintf('  H(response)           = %.2f bits\n', H_resp);
% fprintf('  H(response | stimulus) = %.2f bits\n', H_resp_given_stim);
% fprintf('  MI(stimulus; response) = %.2f bits\n', MI);
% fprintf('  The neuron carries %.2f bits about which stimulus was shown.\n', MI);

%% Part 4: Challenge (2 TODOs, optional)
% How does noise affect mutual information?

% TODO 11 (Challenge): Vary the noise level and compute MI for each.
% Try noise_levels = [0.5, 1, 2, 4, 8, 16, 32].
% For each noise level, repeat the simulation from Part 3 but use
% randn * noise_level instead of randn * 3.
% Store MI values in a vector.
% noise_levels = [0.5, 1, 2, 4, 8, 16, 32];
% MI_vs_noise = zeros(size(noise_levels));
%
% for n_idx = 1:length(noise_levels)
%     noise = noise_levels(n_idx);
%     responses_n = max(0, round(mean_spike_counts(stimuli) + randn(1,n_trials)*noise));
%     [~, ~, rb] = histcounts(responses_n, resp_edges);
%
%     jt = zeros(n_stimuli, n_resp_bins);
%     for s = 1:n_stimuli
%         for r = 1:n_resp_bins
%             jt(s, r) = sum(stimuli == s & rb == r);
%         end
%     end
%     jp = jt / sum(jt(:));
%     pr = sum(jp, 1);
%     ps = sum(jp, 2)';
%     hr = compute_entropy(pr);
%     hrs = 0;
%     for s = 1:n_stimuli
%         prs = jp(s,:) / ps(s);
%         hrs = hrs + ps(s) * compute_entropy(prs);
%     end
%     MI_vs_noise(n_idx) = ???;
% end
%
% figure(3);
% plot(noise_levels, MI_vs_noise, 'bo-', 'LineWidth', 2, 'MarkerSize', 8);
% xlabel('Noise Level (std of Gaussian noise)');
% ylabel('Mutual Information (bits)');
% title('More Noise = Less Information');
% grid on;

% TODO 12 (Challenge): Explain in a comment why MI goes to 0 with
% infinite noise.
% Hint: what happens to the conditional distribution P(response | stimulus)
% when noise completely swamps the signal?
% ???

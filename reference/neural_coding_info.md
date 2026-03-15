# Neural Coding and Information Theory Quick Reference

Covers Module 05 (Neural Coding) and Module 06 (Information Theory).

## Spike Train Generation

```matlab
% Poisson spike train: at each time step, spike with probability rate * dt
rate = 30;           % firing rate in Hz
dt = 0.001;          % time step (1 ms)
T = 2;               % duration (seconds)
n_steps = T / dt;
time = (1:n_steps) * dt;

spikes = rand(1, n_steps) < rate * dt;   % logical vector: 1=spike, 0=no spike
spike_times = time(spikes);               % times when spikes occurred
isis = diff(spike_times);                 % interspike intervals
actual_rate = sum(spikes) / T;            % measured firing rate
```

**Key point:** `rate * dt` must be small (< 0.1) for a good Poisson approximation.

## Raster Plot

```matlab
% Single trial: vertical lines at spike times
for s = 1:length(spike_times)
    plot([spike_times(s) spike_times(s)], [0.6 1.4], 'k-');
    hold on;
end

% Multi-trial: each trial on its own row
for trial = 1:n_trials
    spikes = rand(1, n_steps) < rate * dt;
    st = time(spikes);
    for s = 1:length(st)
        plot([st(s) st(s)], [trial-0.4 trial+0.4], 'k-');
        hold on;
    end
end
```

## PSTH (Peri-Stimulus Time Histogram)

```matlab
bin_size = 0.05;  % 50 ms bins
bin_edges = 0:bin_size:T;
total_counts = zeros(1, length(bin_edges)-1);

for trial = 1:n_trials
    spikes = rand(1, n_steps) < rate * dt;
    counts = histcounts(time(spikes), bin_edges);
    total_counts = total_counts + counts;
end

firing_rate = total_counts / (n_trials * bin_size);  % Hz
bar(bin_edges(1:end-1) + bin_size/2, firing_rate);
```

## Cosine Tuning Curves

```matlab
% Tuning curve formula: f(theta) = r0 + g * cos(theta - theta_pref)
preferred_dir = 90;   % degrees
baseline = 10;        % r0: baseline firing rate (Hz)
gain = 15;            % g: modulation depth (Hz)
directions = 0:10:350;

firing_rates = baseline + gain * cosd(directions - preferred_dir);
% Max rate = baseline + gain   (at preferred direction)
% Min rate = baseline - gain   (at opposite direction)
```

**Use `cosd()`/`sind()` for degrees.** Don't mix `cos()` (radians) with degree values.

## Polar Plot

```matlab
% Tuning curve as a polar plot (angle = direction, radius = rate)
polarplot(deg2rad([directions 360]), [firing_rates firing_rates(1)], 'b-o');
```

## Population Coding

```matlab
% 8 neurons with evenly spaced preferred directions
pref_dirs = 0:45:315;
n_neurons = length(pref_dirs);

% Simulate noisy responses to a stimulus
stimulus_dir = 60;
responses = baseline + gain * cosd(pref_dirs - stimulus_dir) ...
    + randn(1, n_neurons) * noise_std;
responses = max(responses, 0);  % can't be negative

% Heatmap visualization
imagesc(responses');
colorbar; colormap('hot');
```

## Neural Decoding (Population Vector)

```matlab
% Each neuron votes for its preferred direction, weighted by firing rate
pop_vec_x = sum(responses .* cosd(pref_dirs));
pop_vec_y = sum(responses .* sind(pref_dirs));
decoded_dir = atan2d(pop_vec_y, pop_vec_x);

% Or use the decode_direction function:
decoded_dir = decode_direction(responses, pref_dirs);
decoded_dir = mod(decoded_dir, 360);  % convert to 0-360 range
```

## Logarithms

| Function    | Base | Unit                | Example              |
|-------------|------|---------------------|----------------------|
| `log2(x)`   | 2    | bits                | `log2(8) = 3`        |
| `log(x)`    | e    | nats                | `log(exp(1)) = 1`    |
| `log10(x)`  | 10   | orders of magnitude | `log10(1000) = 3`    |

**"How many times do you double to get here?"** -- log2(8) = 3 because 2^3 = 8.

**Key properties:**
```matlab
log2(a * b) == log2(a) + log2(b)   % multiplication -> addition
log2(a^n)   == n * log2(a)         % powers -> multiplication
log2(1)     == 0                    % log of 1 is always 0
```

**Change of base:** `log_b(x) = log(x) / log(b)`

## Entropy

```matlab
% Shannon entropy: H = -sum(p * log2(p))
% CRITICAL: handle 0*log(0) = 0 convention by filtering zeros
H = -sum(p(p > 0) .* log2(p(p > 0)));

% Or use the reusable function:
H = compute_entropy(p);   % in 06-information-theory/compute_entropy.m
```

| Distribution           | H (bits) | Note                      |
|------------------------|----------|---------------------------|
| Fair coin [0.5, 0.5]  | 1.00     | 1 yes/no question         |
| Biased coin [0.9, 0.1]| 0.47     | Mostly predictable        |
| Fair N-sided die       | log2(N)  | Maximum for N outcomes    |
| Certain [1, 0, ...]   | 0.00     | No surprise               |

**Maximum entropy:** Uniform distribution. H_max = log2(N) for N outcomes.

## Mutual Information

```matlab
% MI = H(response) - H(response | stimulus)
% How much does knowing the stimulus reduce uncertainty about the response?

% 1. Build joint probability matrix
joint_prob = joint_counts / sum(joint_counts(:));

% 2. Marginal distributions
p_resp = sum(joint_prob, 1);     % sum over stimuli
p_stim = sum(joint_prob, 2)';    % sum over responses

% 3. H(response)
H_resp = compute_entropy(p_resp);

% 4. H(response | stimulus) -- weighted average of conditional entropies
H_resp_given_stim = 0;
for s = 1:n_stimuli
    p_r_given_s = joint_prob(s,:) / p_stim(s);
    H_resp_given_stim = H_resp_given_stim + ...
        p_stim(s) * compute_entropy(p_r_given_s);
end

% 5. Mutual information
MI = H_resp - H_resp_given_stim;
```

**Sanity check:** Shuffle stimulus-response pairs with `randperm()`. MI should drop to ~0.

**Equivalent formula:** MI = H(S) + H(R) - H(S,R)

## Common Gotchas

| Problem | Symptom | Fix |
|---------|---------|-----|
| Degrees vs radians | Tuning curve shape is wrong | Use `cosd()`/`sind()` for degree inputs |
| Negative firing rates | Rates below 0 | Add `max(responses, 0)` |
| `0 * log2(0)` | Entropy returns NaN | Filter: `p(p > 0) .* log2(p(p > 0))` |
| `log()` instead of `log2()` | Entropy in nats, not bits | Use `log2()` for bits |
| Rate vs probability | 100% spikes every step | Multiply by dt: `rate * dt` not `rate` |
| `atan` vs `atan2` | Wrong quadrant | Always use `atan2d(y, x)` |
| Probabilities don't sum to 1 | Entropy too large | Normalize: `p = counts / sum(counts)` |
| Too few trials for MI | MI biased upward | Need ~10+ trials per response bin |
| `histc` / `hist` | Deprecated functions | Use `histcounts` / `histogram` |

## Key Matlab Functions

| Function | Purpose | Example |
|----------|---------|---------|
| `rand(1, n)` | Uniform random numbers [0,1] | Spike generation |
| `randn(1, n)` | Normal random numbers | Adding noise |
| `cosd(x)` | Cosine (degrees) | Tuning curves |
| `sind(x)` | Sine (degrees) | Population vector |
| `atan2d(y, x)` | Angle from components (degrees) | Decoding direction |
| `deg2rad(x)` | Convert degrees to radians | For `polarplot` |
| `polarplot(theta, r)` | Polar coordinate plot | Tuning curves |
| `imagesc(data)` | Heatmap visualization | Population activity, joint prob |
| `colorbar` | Add color scale | After `imagesc` |
| `histcounts(data, edges)` | Bin counts | PSTH, ISI, probability estimation |
| `histogram(data, n)` | Plot histogram directly | ISI distribution |
| `stem(x, y)` | Discrete data plot | Spike raster |
| `quiver(x, y, u, v)` | Arrow/vector plot | Population vector |
| `log2(x)` | Base-2 logarithm | Entropy (bits) |
| `semilogy(x, y)` | Log y-axis plot | Exponential as straight line |
| `repelem(v, n)` | Repeat elements | Balanced stimulus sequence |
| `randperm(n)` | Random permutation | Shuffle control for MI |

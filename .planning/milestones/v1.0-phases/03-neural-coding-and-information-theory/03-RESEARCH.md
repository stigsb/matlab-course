# Phase 3: Neural Coding and Information Theory - Research

**Researched:** 2026-03-15
**Domain:** Neural coding (tuning curves, spike trains, population coding, decoding) + Information theory (entropy, mutual information) + Logarithms
**Confidence:** HIGH

## Summary

Phase 3 transitions from math/programming foundations to the actual NEVR3004 course content. It has three interleaved pillars: (1) Neural coding -- how individual neurons encode stimuli via tuning curves and spike trains, how populations of neurons encode information together, and how to decode neural activity; (2) Information theory -- entropy as a measure of uncertainty, mutual information as shared information between stimulus and response; and (3) Logarithms -- the mathematical tool that makes information theory work, introduced here because this is where the learner first needs them.

The key pedagogical challenge is that neural coding and information theory are deeply intertwined but conceptually distinct. Tuning curves and spike trains are visual and intuitive -- you can SEE what a neuron responds to. Information theory is more abstract -- you compute numbers that quantify how much a neural response tells you about the stimulus. The logarithm sits between them: it is the mathematical reason we measure information in bits, and it must be introduced visually (as "the scale that turns multiplication into addition" and "the scale that matches how we perceive differences") before being used in formulas.

All implementations use base Matlab only (no toolboxes). Spike trains are generated using `rand()` against a Poisson rate, entropy is computed manually with `histcounts` and `log2`, and decoding uses simple population vector or maximum-likelihood approaches. This phase continues modules 05 and 06 following the established numbering from Phases 1-2.

**Primary recommendation:** Split into two plans: (03-01) Neural Coding covering spike trains, tuning curves, population coding, and decoding with Module 05; (03-02) Information Theory covering logarithms, entropy, mutual information, and their connection to neural coding with Module 06.

<phase_requirements>
## Phase Requirements

| ID | Description | Research Support |
|----|-------------|-----------------|
| NEUR-01 | Learner can plot and interpret tuning curves from simulated neural data | Cosine tuning functions, simulated firing rates as function of stimulus direction, `plot()` with labeled axes showing preferred direction |
| NEUR-02 | Learner understands population coding and can visualize how groups of neurons encode information | Multiple neurons with different preferred directions, heatmap of population activity (`imagesc`), population vector visualization |
| NEUR-03 | Learner can generate and analyze simulated spike trains | Poisson spike generation using `rand() < rate*dt`, raster plots, PSTH (peri-stimulus time histogram), interspike interval histogram |
| NEUR-04 | Learner can implement a basic neural decoder that reads information from population activity | Population vector decoder (weighted sum of preferred directions), or simple maximum-likelihood decoder. Compare decoded vs actual stimulus. |
| INFO-01 | Learner can compute entropy of a discrete distribution and explain what it measures | `H = -sum(p .* log2(p))` computed manually. Visualize entropy for different distributions (uniform = max entropy, peaked = low entropy). |
| INFO-02 | Learner can compute mutual information between stimulus and neural response | `MI = H(response) - H(response|stimulus)` or equivalently via joint distribution. Build from entropy. |
| INFO-03 | Learner can visualize information-theoretic quantities with plots and diagrams | Venn diagram of H(X), H(Y), MI(X;Y). Bar charts comparing entropy of different distributions. Stimulus-response matrices with color coding. |
| MATH-07 | Learner understands logarithms visually and can use them in information-theoretic calculations | Visual introduction: log as "how many times do you halve?" and "the scale that turns multiplication into addition". `log2()`, `log()`, `log10()` in Matlab. |
</phase_requirements>

## Standard Stack

### Core
| Library | Version | Purpose | Why Standard |
|---------|---------|---------|--------------|
| Matlab (core) | R2024a+ | Everything | All needed functions are built-in. No toolboxes required. |

### Key Built-in Functions (Phase 3)

**Spike Train Generation and Analysis:**
| Function/Syntax | Purpose | Example |
|-----------------|---------|---------|
| `rand(1, n_steps)` | Generate uniform random numbers for Poisson spike train | `spikes = rand(1, n_steps) < rate * dt` |
| `find(spikes)` | Get spike times from binary vector | `spike_times = find(spikes) * dt` |
| `diff(spike_times)` | Compute interspike intervals | `isis = diff(spike_times)` |
| `histcounts(data, edges)` | Bin spike counts for PSTH or ISI histogram | `counts = histcounts(isis, 50)` |
| `cumsum(spikes)` | Cumulative spike count | `cum_spikes = cumsum(spikes)` |

**Tuning Curves and Population Coding:**
| Function | Purpose | Example |
|----------|---------|---------|
| `cos(theta)` | Cosine tuning function | `rate = baseline + gain * cos(theta - preferred)` |
| `max()` + indexing | Find preferred direction | `[~, idx] = max(rates)` |
| `imagesc(matrix)` | Visualize population activity as heatmap | `imagesc(directions, neurons, activity)` |
| `quiver(x,y,u,v)` | Draw population vector | `quiver(0, 0, pop_vec(1), pop_vec(2))` |

**Logarithms:**
| Function | Purpose | Example |
|----------|---------|---------|
| `log2(x)` | Base-2 logarithm (bits) | `log2(8)` gives 3 |
| `log(x)` | Natural logarithm (nats) | `log(exp(1))` gives 1 |
| `log10(x)` | Base-10 logarithm | `log10(100)` gives 2 |
| `2.^x` | Powers of 2 (inverse of log2) | `2.^3` gives 8 |
| `semilogy(x, y)` | Plot with log y-axis | Shows exponential growth as straight line |
| `loglog(x, y)` | Plot with log-log axes | Shows power laws as straight lines |

**Information Theory (manual computation):**
| Function | Purpose | Example |
|----------|---------|---------|
| `histcounts(data, edges)` | Count occurrences for probability estimation | `counts = histcounts(responses, edges)` |
| `p .* log2(p)` | Element-wise entropy terms | Handle `0*log(0)` = 0 convention |
| `sum()` | Sum entropy terms | `H = -sum(p(p>0) .* log2(p(p>0)))` |
| `accumarray()` | Compute conditional distributions | Group responses by stimulus |

**Plotting (extending Phase 1-2):**
| Function | Purpose | Example |
|----------|---------|---------|
| `imagesc(matrix)` | Heatmap (population activity, joint distribution) | `imagesc(joint_prob); colorbar` |
| `colorbar` | Add color scale to heatmap | After `imagesc()` |
| `colormap(map)` | Set color scheme | `colormap('hot')` or `colormap('parula')` |
| `stem(x, y)` | Discrete data plot (spike raster) | `stem(spike_times, ones(size(spike_times)))` |
| `area(x, y)` | Filled area plot (distributions) | `area(bins, probabilities)` |

### Alternatives Considered
| Instead of | Could Use | Tradeoff |
|------------|-----------|----------|
| `rand() < rate*dt` for spikes | `poissrnd()` (Statistics Toolbox) | rand() approach is base Matlab, teaches the concept directly, and matches how Poisson processes actually work |
| Manual entropy computation | `entropy()` (Image Processing Toolbox) | Manual computation teaches the formula, which IS the learning objective |
| Manual MI computation | Information Theory Toolbox (File Exchange) | Manual computation is essential for understanding; toolbox hides the math |
| `histcounts()` for binning | `histc()` (deprecated) | histcounts is the modern replacement since R2014b |

## Architecture Patterns

### Recommended Project Structure (Phase 3 Deliverables)
```
matlab-course/
├── 05-neural-coding/
│   ├── lesson.md                  # Tuning curves, spike trains, population coding, decoding
│   ├── demo_spike_trains.m        # Generate and visualize Poisson spike trains
│   ├── demo_tuning_curves.m       # Cosine tuning, plot what neurons respond to
│   ├── demo_population_coding.m   # Population activity heatmap + population vector decoder
│   ├── exercise_neural_coding.m   # Scaffolded practice: generate spikes, plot tuning, decode
│   ├── solution_neural_coding.m   # Complete solution
│   └── decode_direction.m         # Function file: population vector decoder
├── 06-information-theory/
│   ├── lesson.md                  # Logarithms, entropy, mutual information
│   ├── demo_logarithms.m          # Visual introduction to logarithms
│   ├── demo_entropy.m             # Entropy of different distributions, visual comparison
│   ├── demo_mutual_information.m  # MI between stimulus and neural response
│   ├── exercise_info_theory.m     # Scaffolded practice: compute entropy, MI
│   ├── solution_info_theory.m     # Complete solution
│   └── compute_entropy.m          # Function file: entropy of discrete distribution
└── reference/
    ├── matlab_basics.md           # (existing from Phase 1)
    ├── programming_and_math.md    # (existing from Phase 2)
    └── neural_coding_info.md      # Quick-lookup: spike trains, tuning curves, entropy, MI
```

### Pattern 1: Poisson Spike Train Generation (No Toolbox)
**What:** Generate spike trains using the fundamental Poisson process: at each small time step dt, a spike occurs with probability rate * dt. This uses only base Matlab.
**When to use:** Whenever simulated neural data is needed (NEUR-03, NEUR-01, NEUR-02).
**Example:**
```matlab
% Source: Harvard Poisson Tutorial + MathWorks rand() documentation
% Generate a spike train for a neuron firing at 20 Hz for 2 seconds
rate = 20;           % firing rate in Hz (spikes per second)
dt = 0.001;          % time step: 1 millisecond
T = 2;               % total time in seconds
n_steps = T / dt;    % number of time steps
time = (1:n_steps) * dt;

% At each time step, spike occurs with probability rate * dt
spikes = rand(1, n_steps) < rate * dt;  % logical vector: 1 = spike, 0 = no spike

% Find spike times
spike_times = time(spikes);
fprintf('Generated %d spikes in %.1f seconds (rate: %.1f Hz)\n', ...
    sum(spikes), T, sum(spikes)/T);

% Raster plot
figure;
stem(spike_times, ones(size(spike_times)), 'k|', 'MarkerSize', 10);
xlabel('Time (s)'); ylabel('Spikes');
title(sprintf('Spike Train (firing rate = %d Hz)', rate));
ylim([0 1.5]);
```

### Pattern 2: Cosine Tuning Curve
**What:** Neurons in motor cortex and visual cortex often have cosine-shaped tuning curves: they fire most for their preferred direction and least for the opposite direction.
**When to use:** Teaching NEUR-01, NEUR-02.
**Example:**
```matlab
% Source: Computational neuroscience standard (Georgopoulos et al., 1982)
% Neuron with preferred direction at 90 degrees
preferred_dir = 90;  % degrees
baseline = 10;       % baseline firing rate (Hz)
gain = 15;           % modulation depth (Hz)

% Test all directions
directions = 0:10:350;  % stimulus directions in degrees
firing_rates = baseline + gain * cosd(directions - preferred_dir);
% cosd() works in degrees -- no conversion needed

figure;
polarplot(deg2rad(directions), firing_rates, 'b-o', 'LineWidth', 2);
title(sprintf('Tuning Curve (preferred = %d deg)', preferred_dir));
```

### Pattern 3: Population Vector Decoder
**What:** The simplest neural decoder: each neuron "votes" for its preferred direction, weighted by its firing rate. The sum of all votes gives the decoded direction.
**When to use:** Teaching NEUR-04, demonstrating population coding (NEUR-02).
**Example:**
```matlab
% Source: Georgopoulos et al. (1986) population vector method
% 8 neurons with evenly spaced preferred directions
n_neurons = 8;
pref_dirs = linspace(0, 315, n_neurons);  % degrees
baseline = 10;
gain = 15;

% Simulate responses to a stimulus at 45 degrees
stimulus_dir = 45;
responses = baseline + gain * cosd(pref_dirs - stimulus_dir);
% Add some noise
responses = responses + randn(1, n_neurons) * 3;
responses = max(responses, 0);  % firing rates can't be negative

% Population vector: weighted sum of preferred directions
pop_vec_x = sum(responses .* cosd(pref_dirs));
pop_vec_y = sum(responses .* sind(pref_dirs));
decoded_dir = atan2d(pop_vec_y, pop_vec_x);

fprintf('Actual: %d deg, Decoded: %.1f deg\n', stimulus_dir, decoded_dir);
```

### Pattern 4: Manual Entropy Computation
**What:** Compute Shannon entropy from a discrete probability distribution using base Matlab. Handle the 0*log(0) = 0 convention by filtering out zeros.
**When to use:** Teaching INFO-01.
**Example:**
```matlab
% Source: Shannon (1948), standard information theory
% Entropy of a fair coin vs biased coin
p_fair = [0.5, 0.5];
p_biased = [0.9, 0.1];

% H = -sum(p * log2(p)), but handle p=0 case
H_fair = -sum(p_fair(p_fair > 0) .* log2(p_fair(p_fair > 0)));
H_biased = -sum(p_biased(p_biased > 0) .* log2(p_biased(p_biased > 0)));

fprintf('Fair coin entropy: %.2f bits\n', H_fair);    % 1.00 bits
fprintf('Biased coin entropy: %.2f bits\n', H_biased); % 0.47 bits
```

### Pattern 5: Stimulus-Response Matrix for Mutual Information
**What:** Build a joint probability table from stimulus-response data, then compute MI as H(response) - H(response|stimulus).
**When to use:** Teaching INFO-02.
**Example:**
```matlab
% Source: Timme & Lapish (2018), information theory tutorial
% Simulate: 4 stimuli, neuron responds with different spike counts
n_trials = 200;
n_stimuli = 4;
stimuli = randi(n_stimuli, 1, n_trials);  % random stimulus each trial
responses = zeros(1, n_trials);

% Neuron responds differently to each stimulus (with noise)
for i = 1:n_trials
    responses(i) = round(stimuli(i) * 3 + randn * 2);  % noisy linear
end
responses = max(responses, 0);  % no negative counts

% Bin responses into discrete categories
edges = 0:2:20;
[~, ~, resp_bins] = histcounts(responses, edges);

% Joint probability matrix
joint = zeros(n_stimuli, length(edges)-1);
for s = 1:n_stimuli
    for r = 1:length(edges)-1
        joint(s, r) = sum(stimuli == s & resp_bins == r);
    end
end
joint_prob = joint / sum(joint(:));  % normalize

% Marginal probabilities
p_stim = sum(joint_prob, 2);   % sum over responses
p_resp = sum(joint_prob, 1);   % sum over stimuli

% Entropy of response
H_resp = -sum(p_resp(p_resp > 0) .* log2(p_resp(p_resp > 0)));

% Conditional entropy H(R|S)
H_resp_given_stim = 0;
for s = 1:n_stimuli
    p_r_given_s = joint_prob(s, :) / p_stim(s);
    p_r_given_s = p_r_given_s(p_r_given_s > 0);
    H_resp_given_stim = H_resp_given_stim - p_stim(s) * sum(p_r_given_s .* log2(p_r_given_s));
end

MI = H_resp - H_resp_given_stim;
fprintf('H(response) = %.2f bits\n', H_resp);
fprintf('H(response|stimulus) = %.2f bits\n', H_resp_given_stim);
fprintf('Mutual Information = %.2f bits\n', MI);
```

### Anti-Patterns to Avoid
- **Using poissrnd() without explaining it:** Even if the Statistics Toolbox is available, generating spikes with `rand() < rate*dt` teaches the underlying concept. Use this approach.
- **Jumping to mutual information before entropy:** Entropy must be understood first. Build MI as "entropy minus conditional entropy."
- **Abstract log formulas before visual intuition:** Never write `H = -sum(p*log2(p))` before the learner has seen what log2 does visually with concrete examples.
- **Too many neurons in population coding:** Start with 4-8 neurons. The learner can see each neuron's contribution. 100 neurons is for demonstrations only.
- **Real neural data in Phase 3:** All data should be simulated so the learner controls the ground truth. Real data comes in Phase 4 or v2.
- **Teaching joint probability before conditional probability:** The learner needs to understand "given stimulus X, what is the response distribution?" before computing the full joint.

## Don't Hand-Roll

| Problem | Don't Build | Use Instead | Why |
|---------|-------------|-------------|-----|
| Trigonometry in degrees | Manual `cos(x * pi/180)` conversion | `cosd(x)`, `sind(x)`, `atan2d(y,x)` | Built-in degree functions avoid conversion errors |
| Polar plots | Cartesian plot with angle conversion | `polarplot(theta, r)` | Built-in, handles angular axis labels |
| Histogram bin counts | Manual loop counting | `histcounts(data, edges)` | Correct edge handling, efficient |
| Finding max and its index | Manual loop search | `[val, idx] = max(data)` | Returns both value and index |
| Random permutation | Manual shuffle | `randperm(n)` | Correct uniform random permutation |
| Colorbar on heatmap | Manual axis labels | `imagesc(data); colorbar` | Proper color scale display |

**Key insight:** For this phase, the things that SHOULD be hand-rolled are the actual learning objectives: entropy computation, spike train generation, and decoding. The Matlab utility functions (trig, plotting, histogram counting) should use built-ins so the learner focuses on the neuroscience concepts.

## Common Pitfalls

### Pitfall 1: 0 * log2(0) in Entropy Calculation
**What goes wrong:** Computing `p .* log2(p)` when some probabilities are zero produces NaN, which poisons the entire sum.
**Why it happens:** log2(0) = -Inf, and 0 * -Inf = NaN in Matlab.
**How to avoid:** Filter out zeros before computing: `H = -sum(p(p>0) .* log2(p(p>0)))`. Explain the convention: if p=0, that outcome never happens, so it contributes 0 bits of surprise.
**Warning signs:** Entropy returns NaN.

### Pitfall 2: Probabilities Don't Sum to 1
**What goes wrong:** Using `histcounts` counts without normalizing gives meaningless "entropy" values.
**Why it happens:** Counts are not probabilities. Must divide by total.
**How to avoid:** Always normalize: `p = counts / sum(counts)`. Verify with `sum(p)` which should be 1.0 (or very close due to floating point).
**Warning signs:** Entropy values that are implausibly large.

### Pitfall 3: Confusing Rate and Probability in Spike Generation
**What goes wrong:** Using `rand() < rate` where rate is in Hz (e.g., 50) means every time step produces a spike. Need `rand() < rate * dt`.
**Why it happens:** The learner forgets to multiply by the time step duration.
**How to avoid:** Explain clearly: "A neuron firing at 50 Hz means 50 spikes per second. In a 1ms time step, the probability of a spike is 50 * 0.001 = 0.05, or 5%."
**Warning signs:** Every time step has a spike (100% firing), or spike rates don't match the requested rate.

### Pitfall 4: Degrees vs Radians in Tuning Curves
**What goes wrong:** Using `cos()` (radians) with direction values in degrees (0-360). Results in wrong tuning curves.
**Why it happens:** Matlab `cos()` expects radians. Directions are naturally in degrees.
**How to avoid:** Use `cosd()` and `sind()` consistently for degree inputs. Or convert: `cos(deg2rad(theta))`. Pick one convention and stick to it throughout.
**Warning signs:** Tuning curve has wrong shape, preferred direction appears at wrong location.

### Pitfall 5: Negative Firing Rates
**What goes wrong:** Cosine tuning can produce negative values when gain > baseline. Firing rates cannot be negative.
**Why it happens:** `baseline + gain * cosd(theta - preferred)` goes negative when cos is at its minimum (-1) and gain > baseline.
**How to avoid:** Either rectify: `max(0, rate)`, or use a tuning function that stays positive (e.g., `baseline + gain * (1 + cosd(...))/2`). Show both options.
**Warning signs:** Negative values in firing rate array, negative spike counts.

### Pitfall 6: Too Few Trials for Mutual Information
**What goes wrong:** MI estimate is biased upward with few trials. Even independent variables appear to have nonzero MI.
**Why it happens:** With limited samples, estimated joint probabilities deviate from true independence, creating apparent information.
**How to avoid:** Use enough trials (at least 10 per stimulus-response bin combination, per Timme & Lapish 2018). Mention this limitation but don't deep-dive into bias correction at this level.
**Warning signs:** High MI values between variables that should be independent.

### Pitfall 7: log2 vs log vs log10 Confusion
**What goes wrong:** Using `log()` (natural log) instead of `log2()` gives entropy in nats, not bits.
**Why it happens:** Matlab `log()` is natural log, unlike some other languages where `log` is base-10.
**How to avoid:** Always use `log2()` for information in bits. Explain: "We use log2 because information is measured in bits -- each bit is a yes/no question."
**Warning signs:** Entropy of a fair coin comes out as 0.693 (nats) instead of 1.0 (bits).

## Code Examples

Verified patterns from official sources and standard computational neuroscience:

### Raster Plot for Multiple Trials
```matlab
% Source: Standard computational neuroscience visualization
% Generate spike trains for 20 trials at 30 Hz
rate = 30; dt = 0.001; T = 1.0;
n_trials = 20;
n_steps = T / dt;
time = (1:n_steps) * dt;

figure;
hold on;
for trial = 1:n_trials
    spikes = rand(1, n_steps) < rate * dt;
    spike_times = time(spikes);
    % Plot each spike as a short vertical line at its trial height
    for s = 1:length(spike_times)
        plot([spike_times(s) spike_times(s)], [trial-0.4 trial+0.4], 'k-');
    end
end
hold off;
xlabel('Time (s)'); ylabel('Trial');
title('Raster Plot: 20 Trials');
ylim([0 n_trials+1]);
```

### PSTH (Peri-Stimulus Time Histogram)
```matlab
% Source: Standard neuroscience analysis
% Count spikes across trials in time bins
bin_size = 0.05;  % 50 ms bins
bin_edges = 0:bin_size:T;
total_counts = zeros(1, length(bin_edges)-1);

for trial = 1:n_trials
    spikes = rand(1, n_steps) < rate * dt;
    spike_times = time(spikes);
    counts = histcounts(spike_times, bin_edges);
    total_counts = total_counts + counts;
end

% Convert to firing rate: counts / (n_trials * bin_size)
firing_rate = total_counts / (n_trials * bin_size);
bin_centers = bin_edges(1:end-1) + bin_size/2;

figure;
bar(bin_centers, firing_rate);
xlabel('Time (s)'); ylabel('Firing Rate (Hz)');
title('PSTH: Average Firing Rate Over Time');
```

### Logarithm Visual Introduction
```matlab
% Source: Base Matlab log2 documentation
clear; clc; close all;

% "How many times do you halve?"
values = [1 2 4 8 16 32 64 128 256];
log_values = log2(values);

figure;
subplot(2,1,1);
bar(log_values);
set(gca, 'XTickLabel', values);
xlabel('Number'); ylabel('log_2(number)');
title('Logarithm = "How many times do you double to get here?"');

% Show why log is the right scale for information
subplot(2,1,2);
x = 1:100;
plot(x, x, 'b-', x, log2(x), 'r-', 'LineWidth', 2);
xlabel('Number of possibilities'); ylabel('Amount');
legend('Linear scale', 'Log scale (bits)');
title('Log scale: doubling possibilities adds just 1 bit');
```

### Entropy Comparison Visualization
```matlab
% Source: Shannon information theory, standard visualization
% Compare entropy of different distributions
distributions = {
    [0.5 0.5],             'Fair coin';
    [0.9 0.1],             'Biased coin';
    [0.25 0.25 0.25 0.25], 'Fair 4-sided die';
    [0.7 0.1 0.1 0.1],     'Loaded 4-sided die';
    [1 0 0 0],              'Certain outcome';
};

H_values = zeros(size(distributions, 1), 1);
labels = cell(size(distributions, 1), 1);
for i = 1:size(distributions, 1)
    p = distributions{i, 1};
    H_values(i) = -sum(p(p>0) .* log2(p(p>0)));
    labels{i} = distributions{i, 2};
end

figure;
barh(H_values);
set(gca, 'YTick', 1:length(labels), 'YTickLabel', labels);
xlabel('Entropy (bits)');
title('More Uncertainty = More Entropy');
```

## State of the Art

| Old Approach | Current Approach | When Changed | Impact |
|--------------|------------------|--------------|--------|
| `histc()` for binning | `histcounts()` | R2014b | Modern, better defaults |
| `hist()` for histogram plots | `histogram()` | R2014b | Proper object returned, better defaults |
| `polar()` for polar plots | `polarplot()` | R2016a | Better formatting, works with `hold on` |
| Manual raster plot loops | Still manual in base Matlab | N/A | No built-in raster plot function; manual `plot()` is standard |
| `deg2rad()` / manual conversion | `cosd()`, `sind()`, `atan2d()` | Available since at least R2006a | Cleaner code, fewer conversion bugs |

**Deprecated/outdated:**
- `hist()`: Replaced by `histogram()`. Still works but not recommended.
- `histc()`: Replaced by `histcounts()`. Still works but not recommended.
- `polar()`: Replaced by `polarplot()`. Still works but has formatting limitations.

## Open Questions

1. **Module numbering continuation**
   - What we know: Phase 1 produced modules 01-02, Phase 2 produced modules 03-04.
   - What's unclear: Nothing -- continue with 05 and 06.
   - Recommendation: Module 05 for neural coding, Module 06 for information theory.

2. **Logarithm depth**
   - What we know: MATH-07 requires visual understanding and use in info-theoretic calculations. The learner has basic algebra but likely limited exposure to logarithms.
   - What's unclear: How much logarithm background Christel has from high school.
   - Recommendation: Start from scratch visually. "How many times do you halve/double?" is the key intuition. Connect to information: "each bit answers one yes/no question." Keep it practical -- log2 for bits, don't belabor log rules beyond what's needed for entropy.

3. **Decoder complexity**
   - What we know: NEUR-04 says "basic neural decoder." Population vector is the simplest.
   - What's unclear: Whether NEVR3004 expects Bayesian decoding.
   - Recommendation: Implement population vector decoder (simplest, most visual). Mention maximum likelihood as a concept but don't require implementation. Bayesian decoding is too much for this level.

4. **polarplot() availability**
   - What we know: `polarplot()` was introduced in R2016a. NTNU likely has R2024a+.
   - Recommendation: Use `polarplot()` for tuning curves. Fall back to regular `plot()` with angle on x-axis if needed.

## Validation Architecture

### Test Framework
| Property | Value |
|----------|-------|
| Framework | Manual validation (educational content, not software) |
| Config file | None |
| Quick run command | Open each .m file in Matlab and press F5 (Run) |
| Full suite command | Run all demo_*.m and solution_*.m scripts; verify each produces expected figures |

### Phase Requirements to Test Map
| Req ID | Behavior | Test Type | Automated Command | File Exists? |
|--------|----------|-----------|-------------------|-------------|
| NEUR-01 | Tuning curve plotted showing preferred direction | manual | Run demo_tuning_curves.m, inspect polar/line plot | Wave 0 |
| NEUR-02 | Population activity heatmap and population vector shown | manual | Run demo_population_coding.m, inspect heatmap and vector plot | Wave 0 |
| NEUR-03 | Spike train generated and raster plot displayed | manual | Run demo_spike_trains.m, inspect raster plot and PSTH | Wave 0 |
| NEUR-04 | Decoder output compared to actual stimulus direction | manual | Run demo_population_coding.m, verify decoded vs actual printed | Wave 0 |
| INFO-01 | Entropy computed for multiple distributions, values printed | manual | Run demo_entropy.m, verify fair coin = 1.0 bits | Wave 0 |
| INFO-02 | MI computed between stimulus and response, value printed | manual | Run demo_mutual_information.m, verify MI > 0 for correlated data | Wave 0 |
| INFO-03 | Information quantities visualized with bar charts and heatmaps | manual | Run demo_entropy.m and demo_mutual_information.m, inspect figures | Wave 0 |
| MATH-07 | Logarithm visualized and used in entropy formula | manual | Run demo_logarithms.m, inspect "how many times do you double" plot | Wave 0 |

### Sampling Rate
- **Per task commit:** Run all .m files in the module, verify figures appear without errors
- **Per wave merge:** Run all .m files across all modules, verify no cross-module issues
- **Phase gate:** All demo and solution scripts run clean; exercises run clean when TODOs are filled per solutions

### Wave 0 Gaps
- All content is new -- no existing files. Wave 0 creates the module content.
- Function files (e.g., decode_direction.m, compute_entropy.m) must be in the correct directory for Matlab to find them.
- Validation is manual (run Matlab scripts, inspect output).

## Sources

### Primary (HIGH confidence)
- [MathWorks - rand](https://www.mathworks.com/help/matlab/ref/rand.html) - uniform random numbers for spike generation
- [MathWorks - histcounts](https://www.mathworks.com/help/matlab/ref/double.histcounts.html) - histogram bin counts (base Matlab since R2014b)
- [MathWorks - log2](https://www.mathworks.com/help/matlab/ref/log2.html) - base-2 logarithm
- [MathWorks - imagesc](https://www.mathworks.com/help/matlab/ref/imagesc.html) - heatmap visualization
- [MathWorks - polarplot](https://www.mathworks.com/help/matlab/ref/polarplot.html) - polar coordinate plotting
- [MathWorks - cosd, sind](https://www.mathworks.com/help/matlab/ref/cosd.html) - trigonometric functions in degrees

### Secondary (MEDIUM confidence)
- [Harvard Poisson Tutorial](https://www.hms.harvard.edu/bss/neuro/bornlab/nb204/statistics/poissonTutorial.txt) - Poisson spike train generation in Matlab
- [Timme & Lapish (2018) - Information Theory Tutorial for Neuroscience](https://pmc.ncbi.nlm.nih.gov/articles/PMC6131830/) - entropy, MI, pitfalls in neuroscience applications
- [NTNU NEVR3004 Course Page](https://www.ntnu.edu/studies/courses/NEVR3004) - course content alignment
- [Poisson Model of Spike Generation (Heeger, 2000)](https://www.cns.nyu.edu/~david/handouts/poisson.pdf) - theoretical foundation

### Tertiary (LOW confidence)
- Optimal split between neural coding and information theory modules -- may need adjustment based on learner pace
- Whether NEVR3004 expects Bayesian decoding or population vector is sufficient
- Exact depth of logarithm treatment needed for Christel

## Metadata

**Confidence breakdown:**
- Standard stack: HIGH - All functions verified as base Matlab, no toolboxes needed
- Architecture: HIGH - Follows established Phase 1-2 patterns, module numbering is clear
- Neural coding patterns: HIGH - Poisson spike trains and cosine tuning are standard computational neuroscience
- Information theory: HIGH - Shannon entropy and MI formulas are well-established, manual computation verified
- Pitfalls: HIGH - Common errors (0*log(0), rate vs probability, degrees vs radians) well-documented
- Pedagogy: MEDIUM - Logarithm visual introduction and sequencing (logs before entropy) is sound but untested with this learner

**Research date:** 2026-03-15
**Valid until:** 2026-04-15 (stable domain, no moving targets)

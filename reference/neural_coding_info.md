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

## Information Theory (Placeholder for Module 06)

### Entropy

```matlab
% Shannon entropy: H = -sum(p * log2(p))
% Handle 0*log(0) = 0 convention
H = -sum(p(p > 0) .* log2(p(p > 0)));

% Fair coin: H = 1.0 bits
% Biased coin (90/10): H = 0.47 bits
% Certain outcome: H = 0 bits
```

### Mutual Information

```matlab
% MI(X;Y) = H(Y) - H(Y|X)
% How much does knowing X reduce uncertainty about Y?
% Full computation covered in Module 06.
```

### Logarithms

```matlab
log2(x)    % base-2 (bits) -- used for information theory
log(x)     % natural log (nats)
log10(x)   % base-10
```

**"How many times do you double to get here?"** -- log2(8) = 3 because 2^3 = 8.

## Common Gotchas

| Problem | Symptom | Fix |
|---------|---------|-----|
| Degrees vs radians | Tuning curve shape is wrong | Use `cosd()`/`sind()` for degree inputs |
| Negative firing rates | Rates below 0 | Add `max(responses, 0)` |
| `0 * log2(0)` | Entropy returns NaN | Filter: `p(p > 0) .* log2(p(p > 0))` |
| Rate vs probability | 100% spikes every step | Multiply by dt: `rate * dt` not `rate` |
| `atan` vs `atan2` | Wrong quadrant | Always use `atan2d(y, x)` |
| Probabilities don't sum to 1 | Entropy too large | Normalize: `p = counts / sum(counts)` |

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
| `imagesc(data)` | Heatmap visualization | Population activity |
| `colorbar` | Add color scale | After `imagesc` |
| `histcounts(data, edges)` | Bin counts | PSTH, ISI histogram |
| `histogram(data, n)` | Plot histogram directly | ISI distribution |
| `stem(x, y)` | Discrete data plot | Spike raster |
| `quiver(x, y, u, v)` | Arrow/vector plot | Population vector |
| `log2(x)` | Base-2 logarithm | Entropy (bits) |

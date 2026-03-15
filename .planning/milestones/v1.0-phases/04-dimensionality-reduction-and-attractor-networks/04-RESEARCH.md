# Phase 4: Dimensionality Reduction and Attractor Networks - Research

**Researched:** 2026-03-15
**Domain:** Dimensionality reduction (PCA) + Attractor networks (Hopfield, ring attractor) for computational neuroscience
**Confidence:** HIGH

## Summary

Phase 4 is the capstone of the course, covering two major NEVR3004 topics: (1) Dimensionality reduction via PCA -- reducing high-dimensional neural recordings to interpretable low-dimensional representations; and (2) Attractor networks -- neural circuit models that store memories (Hopfield networks) and maintain stable representations of continuous variables like head direction (ring attractors).

The key pedagogical bridge is that PCA uses eigenvalues/eigenvectors (taught in Phase 2, Module 04) applied to neural data (from Phase 3, Module 05). The learner already knows that eigenvectors are "directions that survive a transformation" -- PCA reframes this as "directions of maximum variance in data." This makes PCA the natural next step rather than a new concept. Attractor networks are more novel but can be taught visually using the ball-in-bowl energy landscape metaphor, where stored memories are valleys and retrieval is a ball rolling downhill to the nearest valley.

Both topics can be implemented entirely in base Matlab. PCA uses `cov()`, `eig()`, and matrix multiplication -- all functions the learner has already used. Hopfield networks use only matrix operations and the `sign()` function. Ring attractors need a simple recurrent update loop. No toolboxes are required. This phase continues the established module numbering with Module 07 (Dimensionality Reduction) and Module 08 (Attractor Networks).

**Primary recommendation:** Split into two plans: (04-01) Dimensionality Reduction covering PCA motivation, step-by-step implementation, and interpretation with Module 07; (04-02) Attractor Networks covering Hopfield memory networks and ring attractors with Module 08.

<phase_requirements>
## Phase Requirements

| ID | Description | Research Support |
|----|-------------|-----------------|
| DIMR-01 | Learner understands why high-dimensional neural data needs dimensionality reduction | Visual example: 100 neurons recording simultaneously -- can't plot 100D, but PCA finds the 2-3 directions that capture most variance. Analogy: "finding the best camera angle for a 3D sculpture" |
| DIMR-02 | Learner can perform PCA step-by-step (covariance matrix, eigenvalues, projection) | Manual PCA using `cov()`, `eig()`, sort eigenvalues descending, project with matrix multiplication. Connects directly to Phase 2 eigenvalue knowledge. |
| DIMR-03 | Learner can interpret PCA results with variance-explained plots | Scree plot (bar chart of eigenvalues), cumulative variance explained plot. "How many components do we need to capture 90% of the variance?" |
| ATTR-01 | Learner understands attractor dynamics visually (energy landscapes, ball-in-bowl) | Ball-in-bowl metaphor: valleys = stable states (memories), hills = unstable states. Energy function E decreases during retrieval. Visualize with `surf()` or 1D energy plots. |
| ATTR-02 | Learner can implement and simulate a simple Hopfield network for memory storage | Hebbian learning rule: W = (1/N) * patterns * patterns'. State update: S = sign(W * S). Store 2-3 simple 5x5 binary patterns, retrieve from noisy input. |
| ATTR-03 | Learner can implement and visualize a ring attractor for head direction / navigation | Ring of neurons with Mexican-hat connectivity (local excitation, distant inhibition). Activity bump maintains head direction. Visualize bump position over time. |
</phase_requirements>

## Standard Stack

### Core
| Library | Version | Purpose | Why Standard |
|---------|---------|---------|--------------|
| Matlab (core) | R2024a+ | Everything | All needed functions are built-in. No toolboxes required. |

### Key Built-in Functions (Phase 4)

**PCA / Dimensionality Reduction:**
| Function/Syntax | Purpose | Example |
|-----------------|---------|---------|
| `cov(X)` | Covariance matrix of data (columns = variables) | `C = cov(data)` |
| `[V, D] = eig(C)` | Eigenvalues and eigenvectors of covariance matrix | Already used in Phase 2 |
| `diag(D)` | Extract eigenvalues from diagonal matrix | `eigenvalues = diag(D)` |
| `sort(vals, 'descend')` | Sort eigenvalues largest-first | `[sorted, idx] = sort(eigenvalues, 'descend')` |
| `mean(X)` | Column means for centering | `mu = mean(data)` |
| `X - mean(X)` | Mean-center data (with implicit expansion) | `centered = data - mean(data)` |
| `projected = centered * V(:, 1:k)` | Project onto top k principal components | Matrix multiplication |
| `cumsum(vals) / sum(vals)` | Cumulative variance explained | For scree/elbow plots |
| `randn(n, d)` | Generate synthetic high-dimensional data | For creating demonstrations |

**Attractor Networks:**
| Function/Syntax | Purpose | Example |
|-----------------|---------|---------|
| `sign(x)` | Threshold to +1/-1 (Hopfield state update) | `S = sign(W * S)` |
| `reshape(vec, rows, cols)` | Reshape pattern vector to 2D grid for display | `imagesc(reshape(pattern, 5, 5))` |
| `surf(X, Y, Z)` or `mesh()` | 3D energy landscape visualization | `surf(x_grid, y_grid, energy)` |
| `contour(X, Y, Z)` | 2D contour plot of energy landscape | For top-down view |
| `cos(theta_i - theta_j)` | Mexican-hat connectivity for ring attractor | Cosine similarity between neuron positions |
| `max(0, x)` | Rectification (non-negative firing rates) | `rates = max(0, input)` |
| `circshift(vec, k)` | Shift bump position on ring | For testing ring attractor |

**Plotting (extending Phase 1-3):**
| Function | Purpose | Example |
|----------|---------|---------|
| `scatter(x, y)` | 2D scatter of projected data | PCA results in 2D |
| `scatter3(x, y, z)` | 3D scatter of original data | Show 3D cloud before PCA |
| `bar(eigenvalues)` | Scree plot | Variance per component |
| `surf(X, Y, Z)` | 3D energy landscape | Attractor dynamics |
| `plot(theta, activity)` | Ring attractor activity profile | Bump visualization |
| `subplot(r, c, n)` | Multi-panel figures | Before/after comparisons |

### Alternatives Considered
| Instead of | Could Use | Tradeoff |
|------------|-----------|----------|
| Manual PCA with `cov`+`eig` | `pca()` (Statistics Toolbox) | Manual approach teaches the concept step-by-step, which IS the learning objective. `pca()` hides the math. |
| Manual `cov()` computation | `(X'*X)/(n-1)` | `cov()` is base Matlab and cleaner. Manual formula is good for understanding but not necessary when `cov()` is available without toolboxes. |
| `sign()` for Hopfield update | Custom threshold function | `sign()` is perfect for binary +1/-1 states. Base Matlab. |
| `surf()` for energy landscape | `contourf()` or `imagesc()` | `surf()` gives 3D perspective that matches the "ball rolling in landscape" metaphor. Use `contourf()` as a complementary 2D view. |
| Manual ring attractor | Neural network toolbox | Manual implementation is essential for understanding the dynamics. |

## Architecture Patterns

### Recommended Project Structure (Phase 4 Deliverables)
```
matlab-course/
├── 07-dimensionality-reduction/
│   ├── lesson.md                      # Why dimensionality reduction, PCA step-by-step, interpretation
│   ├── demo_why_reduce.m              # Visual motivation: 3D data that's really 2D, high-D neural data
│   ├── demo_pca_steps.m               # PCA step-by-step: center, covariance, eigendecompose, project
│   ├── demo_pca_neural.m              # PCA applied to simulated neural population data
│   ├── exercise_dimensionality.m      # Scaffolded practice
│   └── solution_dimensionality.m      # Complete solution
├── 08-attractor-networks/
│   ├── lesson.md                      # Attractor dynamics, Hopfield networks, ring attractors
│   ├── demo_energy_landscape.m        # Ball-in-bowl, energy landscapes, attractor concepts
│   ├── demo_hopfield.m                # Hopfield network: store patterns, retrieve from noise
│   ├── demo_ring_attractor.m          # Ring attractor: head direction, bump dynamics
│   ├── exercise_attractors.m          # Scaffolded practice
│   └── solution_attractors.m          # Complete solution
└── reference/
    ├── neural_coding_info.md          # (existing, from Phase 3 -- extend with PCA + attractor sections)
    └── (or new reference card)        # Quick-lookup for PCA steps, Hopfield rules, ring attractor
```

### Pattern 1: Manual PCA Step-by-Step
**What:** Perform PCA manually using base Matlab functions, making each step visible and interpretable.
**When to use:** Teaching DIMR-02, DIMR-03.
**Example:**
```matlab
% Source: Standard linear algebra PCA procedure
% Step 1: Start with data (observations x variables)
% Simulate 200 data points in 3D where most variance is in 2D
rng(42);
n = 200;
t = linspace(0, 4*pi, n)';
data = [2*cos(t) + 0.3*randn(n,1), ...   % x: strong signal
        1.5*sin(t) + 0.3*randn(n,1), ...  % y: strong signal
        0.2*randn(n,1)];                   % z: mostly noise

% Step 2: Mean-center the data
mu = mean(data);
centered = data - mu;

% Step 3: Compute covariance matrix
C = cov(centered);  % 3x3 matrix
fprintf('Covariance matrix:\n');
disp(C);

% Step 4: Find eigenvalues and eigenvectors
[V, D] = eig(C);
eigenvalues = diag(D);

% Step 5: Sort by largest eigenvalue first
[eigenvalues, idx] = sort(eigenvalues, 'descend');
V = V(:, idx);

fprintf('Eigenvalues (sorted): %.3f, %.3f, %.3f\n', eigenvalues);
fprintf('Variance explained: %.1f%%, %.1f%%, %.1f%%\n', ...
    100 * eigenvalues / sum(eigenvalues));

% Step 6: Project onto top 2 components
projected = centered * V(:, 1:2);

% Visualize
figure;
subplot(1,2,1);
scatter3(data(:,1), data(:,2), data(:,3), 10, t, 'filled');
title('Original 3D Data');
xlabel('x'); ylabel('y'); zlabel('z');
colorbar; view(45, 30);

subplot(1,2,2);
scatter(projected(:,1), projected(:,2), 10, t, 'filled');
title('After PCA: Top 2 Components');
xlabel('PC1'); ylabel('PC2');
colorbar;
```

### Pattern 2: Variance Explained / Scree Plot
**What:** Visualize how much variance each principal component captures, helping decide how many to keep.
**When to use:** Teaching DIMR-03.
**Example:**
```matlab
% Source: Standard PCA interpretation
var_explained = eigenvalues / sum(eigenvalues) * 100;
cumulative = cumsum(var_explained);

figure;
subplot(1,2,1);
bar(var_explained);
xlabel('Principal Component');
ylabel('Variance Explained (%)');
title('Scree Plot');

subplot(1,2,2);
plot(1:length(cumulative), cumulative, 'bo-', 'LineWidth', 2);
hold on;
yline(90, 'r--', '90% threshold');
hold off;
xlabel('Number of Components');
ylabel('Cumulative Variance Explained (%)');
title('How Many Components Do We Need?');
ylim([0 105]);
```

### Pattern 3: Hopfield Network (Simple Implementation)
**What:** Store binary patterns in a network and retrieve them from noisy input. Uses only matrix multiplication and `sign()`.
**When to use:** Teaching ATTR-01, ATTR-02.
**Example:**
```matlab
% Source: Hopfield (1982), Neuronal Dynamics Ch. 17.2
% Store 3 simple 5x5 patterns as +1/-1 vectors
rng(42);
N = 25;  % 5x5 grid = 25 neurons

% Create patterns (simple letters or shapes)
% Pattern 1: horizontal stripe
p1 = -ones(5,5); p1(3,:) = 1; p1 = p1(:);
% Pattern 2: vertical stripe
p2 = -ones(5,5); p2(:,3) = 1; p2 = p2(:);
% Pattern 3: diagonal
p3 = -ones(5,5);
for i = 1:5, p3(i,i) = 1; end
p3 = p3(:);

patterns = [p1, p2, p3];  % N x M matrix

% Hebbian learning: weight matrix
W = (1/N) * (patterns * patterns');
W(1:N+1:end) = 0;  % no self-connections

% Retrieve from noisy version of pattern 1
noise_level = 0.3;
noisy = p1;
flip_idx = rand(N, 1) < noise_level;
noisy(flip_idx) = -noisy(flip_idx);

% Iterative retrieval
S = noisy;
for iter = 1:20
    S_new = sign(W * S);
    S_new(S_new == 0) = 1;  % break ties
    if isequal(S, S_new), break; end
    S = S_new;
end

% Visualize: noisy input vs retrieved pattern vs original
figure;
subplot(1,3,1); imagesc(reshape(p1, 5, 5)); title('Original');
axis square; colormap(gray);
subplot(1,3,2); imagesc(reshape(noisy, 5, 5)); title('Noisy Input');
axis square;
subplot(1,3,3); imagesc(reshape(S, 5, 5)); title('Retrieved');
axis square;
sgtitle('Hopfield Network: Memory Retrieval');

% Check overlap with stored patterns
overlap = (1/N) * (patterns' * S);
fprintf('Overlap with stored patterns: %.2f, %.2f, %.2f\n', overlap);
```

### Pattern 4: Energy Landscape Visualization
**What:** Show the ball-in-bowl metaphor with a concrete energy function that has valleys at stored memories.
**When to use:** Teaching ATTR-01.
**Example:**
```matlab
% Source: Hopfield energy function E = -0.5 * S' * W * S
% 1D energy landscape metaphor
x = linspace(-3, 3, 200);
% Energy with two valleys (two memories)
energy = 0.5*x.^4 - 2*x.^2;  % double-well potential

figure;
plot(x, energy, 'b-', 'LineWidth', 2);
hold on;
% Ball in the left valley
plot(-1.41, -2, 'ro', 'MarkerSize', 15, 'MarkerFaceColor', 'r');
% Label valleys as memories
text(-1.41, -2.5, 'Memory 1', 'HorizontalAlignment', 'center');
text(1.41, -2.5, 'Memory 2', 'HorizontalAlignment', 'center');
% Label hill as unstable
text(0, 0.5, 'Unstable', 'HorizontalAlignment', 'center', 'Color', 'r');
hold off;
xlabel('Network State');
ylabel('Energy');
title('Energy Landscape: Valleys = Memories');
legend('Energy', 'Current state (ball)');
```

### Pattern 5: Ring Attractor for Head Direction
**What:** A ring of neurons with Mexican-hat connectivity maintains a stable activity bump representing head direction.
**When to use:** Teaching ATTR-03.
**Example:**
```matlab
% Source: Ring attractor model (Skaggs et al. 1995, Zhang 1996)
% Ring of N neurons, each with a preferred direction
N = 100;
theta = linspace(0, 2*pi, N+1); theta = theta(1:end-1);  % neuron positions on ring

% Mexican-hat connectivity: excite neighbors, inhibit distant neurons
W = zeros(N, N);
for i = 1:N
    for j = 1:N
        d = theta(i) - theta(j);
        W(i,j) = cos(d) - 0.5;  % local excitation, global inhibition
    end
end
W(1:N+1:end) = 0;  % no self-connections

% Parameters
tau = 1;            % time constant
dt = 0.1;           % time step
T = 50;             % total time
n_steps = T / dt;

% Initialize with a bump centered at pi/2
activity = exp(5 * cos(theta - pi/2));
activity = activity / max(activity);

% Store activity over time for visualization
activity_history = zeros(N, n_steps);

% Simulate
for t = 1:n_steps
    input = W * activity';
    input = max(0, input);  % rectify (no negative rates)
    activity = activity + dt/tau * (-activity + input');
    activity = max(0, activity);  % keep non-negative
    activity = activity / (max(activity) + 0.01);  % normalize
    activity_history(:, t) = activity;
end

% Visualize
figure;
subplot(2,1,1);
imagesc((1:n_steps)*dt, rad2deg(theta), activity_history);
xlabel('Time'); ylabel('Preferred Direction (deg)');
title('Ring Attractor: Bump Maintains Head Direction');
colorbar;

subplot(2,1,2);
plot(rad2deg(theta), activity_history(:, end), 'b-', 'LineWidth', 2);
xlabel('Preferred Direction (deg)');
ylabel('Activity');
title('Final Activity Profile: Stable Bump');
```

### Anti-Patterns to Avoid
- **Using `pca()` from Statistics Toolbox:** The whole point is learning the steps. Manual PCA with `cov()` + `eig()` is the learning objective.
- **Jumping to PCA without motivation:** Always start with the "why" -- show 100-neuron data, ask "how do we visualize this?" Show that most variance lives in a few dimensions.
- **Skipping the eigenvalue connection:** PCA is NOT a new concept for this learner. It is eigenvalues applied to data. Make this connection explicit: "Remember eigenvectors? They're back, and this time they're finding the most important directions in your data."
- **Complex patterns in Hopfield network:** Start with 5x5 grids (25 neurons). Simple geometric patterns (stripes, diagonals, crosses). The learner needs to SEE the retrieval, not debug a 100-neuron network.
- **Abstract ring attractor math:** The ring attractor should be presented as "neurons arranged in a circle, neighbors excite each other, distant neurons inhibit." The Mexican-hat connectivity is visual, not a formula to memorize.
- **Too much theory before code:** Energy landscapes should be shown as plots (ball rolling in valleys) before any equation. The equation E = -0.5 * S' * W * S comes AFTER the visual intuition.

## Don't Hand-Roll

| Problem | Don't Build | Use Instead | Why |
|---------|-------------|-------------|-----|
| Covariance matrix | Manual (X'*X)/(n-1) loop | `cov(X)` | Base Matlab, handles normalization correctly |
| Eigendecomposition | Power iteration or custom solver | `[V, D] = eig(C)` | Base Matlab, already taught in Phase 2 |
| Mean-centering | Manual loop subtraction | `X - mean(X)` | Implicit expansion handles broadcasting |
| 3D surface plots | Manual mesh construction | `surf(X, Y, Z)` or `[X,Y] = meshgrid(...)` | Built-in, handles interpolation and coloring |
| Colormap scaling | Manual normalization | `imagesc(data); colorbar` | Automatic scaling to data range |
| Pattern storage format | Cell arrays or structs | Matrix columns: `patterns = [p1, p2, p3]` | Matrix operations work directly |

**Key insight:** In this phase, the things that SHOULD be hand-rolled are: PCA steps (center, covariance, eigendecompose, project), Hopfield weight matrix and retrieval, and ring attractor dynamics. The Matlab utility functions (covariance, eigenvalues, plotting) should use built-ins so the learner focuses on the concepts.

## Common Pitfalls

### Pitfall 1: eig() Returns Eigenvalues in ASCENDING Order
**What goes wrong:** PCA needs the LARGEST eigenvalues first, but Matlab's `eig()` returns them in ascending order by default. If you skip sorting, the first component captures the LEAST variance.
**Why it happens:** `eig()` sorts by magnitude ascending. PCA needs descending.
**How to avoid:** Always sort: `[eigenvalues, idx] = sort(diag(D), 'descend'); V = V(:, idx);`. Make this an explicit step with a comment: "% Step 5: Sort largest first."
**Warning signs:** PC1 captures less variance than PC2, projected data looks wrong.

### Pitfall 2: Forgetting to Mean-Center Before PCA
**What goes wrong:** PCA without mean-centering finds directions influenced by the mean, not the variance structure. Results are skewed.
**Why it happens:** The learner applies `eig(cov(data))` but projects the uncentered data.
**How to avoid:** Make mean-centering an explicit step: "Step 2: Subtract the mean." Both `cov()` and projection must use centered data.
**Warning signs:** First PC looks like it points toward the data centroid rather than along the data spread.

### Pitfall 3: sign(0) = 0 in Hopfield Network
**What goes wrong:** `sign(0)` returns 0 in Matlab, but Hopfield neurons should be +1 or -1. A zero state propagates and corrupts the network.
**Why it happens:** Exact zero input to a neuron (rare but possible, especially with few patterns).
**How to avoid:** After `sign()`, replace zeros: `S(S == 0) = 1;` or add small noise. Explain: "ties get broken randomly."
**Warning signs:** Patterns with zeros in them, retrieval looks partially blank.

### Pitfall 4: Hopfield Capacity Limit
**What goes wrong:** Storing too many patterns in a Hopfield network causes retrieval failures (spurious states, mixed patterns).
**Why it happens:** The capacity limit is approximately 0.14 * N patterns for N neurons. A 25-neuron network can reliably store about 3 patterns.
**How to avoid:** Keep pattern count low: 2-3 patterns for 25 neurons. Mention the capacity limit as a concept: "like trying to store too many memories -- they start to blend together."
**Warning signs:** Retrieved pattern is a mix of two stored patterns, or converges to a pattern not stored.

### Pitfall 5: Ring Attractor Blow-Up
**What goes wrong:** Activity values grow without bound, producing NaN or Inf.
**Why it happens:** The excitatory connections amplify activity faster than inhibition controls it. Without normalization or saturation, positive feedback dominates.
**How to avoid:** Either normalize activity each step (`activity = activity / max(activity)`) or use a saturating nonlinearity (e.g., `tanh()`). Keep the time step small enough for stability.
**Warning signs:** Activity values become very large, NaN appears, plot shows uniform high activity.

### Pitfall 6: Confusing Rows and Columns in Data Matrix for PCA
**What goes wrong:** If data is arranged as variables-in-rows instead of variables-in-columns, `cov()` computes the wrong covariance matrix (observations x observations instead of variables x variables).
**Why it happens:** Some textbooks use one convention, Matlab uses another. `cov(X)` expects columns = variables.
**How to avoid:** Always state: "Each row is one observation (one time point). Each column is one variable (one neuron)." Verify `cov(X)` produces a matrix that is variables x variables, not observations x observations.
**Warning signs:** Covariance matrix is 200x200 instead of 3x3 (for 200 observations of 3 variables).

## Code Examples

Verified patterns from official sources and standard computational neuroscience:

### Motivation: Why Dimensionality Reduction?
```matlab
% Source: Standard neuroscience data analysis
% 50 neurons recorded simultaneously -- how do we understand this?
rng(42);
n_neurons = 50;
n_timepoints = 300;

% Most neurons are correlated (driven by a common signal)
common_signal = sin(linspace(0, 6*pi, n_timepoints));
data = zeros(n_timepoints, n_neurons);
for i = 1:n_neurons
    weight = randn * 0.5;  % each neuron responds differently
    data(:, i) = weight * common_signal' + 0.3 * randn(n_timepoints, 1);
end

fprintf('Data shape: %d timepoints x %d neurons\n', size(data));
fprintf('We CANNOT plot 50 dimensions. But PCA can find the\n');
fprintf('few directions that capture most of the variance.\n');

% Quick PCA
centered = data - mean(data);
[V, D] = eig(cov(centered));
eigenvalues = sort(diag(D), 'descend');
var_explained = 100 * eigenvalues / sum(eigenvalues);

fprintf('\nTop 5 components explain: %.1f%% of total variance\n', sum(var_explained(1:5)));
fprintf('Component 1 alone explains: %.1f%%\n', var_explained(1));
```

### PCA on Simulated Neural Population Activity
```matlab
% Source: Standard approach in systems neuroscience
% 8 neurons respond to a circular stimulus (like head direction)
rng(42);
n_neurons = 8;
n_trials = 200;
pref_dirs = linspace(0, 315, n_neurons);  % degrees

% Generate population responses to random stimulus directions
stimulus_dirs = rand(n_trials, 1) * 360;
data = zeros(n_trials, n_neurons);
for i = 1:n_trials
    data(i, :) = 10 + 15 * cosd(pref_dirs - stimulus_dirs(i)) + 3*randn(1, n_neurons);
    data(i, :) = max(0, data(i, :));
end

% PCA
centered = data - mean(data);
C = cov(centered);
[V, D] = eig(C);
[eigenvalues, idx] = sort(diag(D), 'descend');
V = V(:, idx);

projected = centered * V(:, 1:2);

% Plot: color by stimulus direction
figure;
scatter(projected(:,1), projected(:,2), 20, stimulus_dirs, 'filled');
colorbar;
xlabel('PC1'); ylabel('PC2');
title('Neural Population in PC Space (color = stimulus direction)');
% The circular stimulus maps to a ring in PC space!
```

### Hopfield Energy During Retrieval
```matlab
% Source: Hopfield (1982) energy function
% Track energy decrease during pattern retrieval
energies = zeros(1, 20);
S = noisy;  % start from noisy pattern
for iter = 1:20
    energies(iter) = -0.5 * S' * W * S;
    S_new = sign(W * S);
    S_new(S_new == 0) = 1;
    if isequal(S, S_new), energies(iter+1:end) = energies(iter); break; end
    S = S_new;
end

figure;
plot(energies, 'bo-', 'LineWidth', 2);
xlabel('Iteration');
ylabel('Energy');
title('Hopfield Retrieval: Energy Always Decreases');
% Energy decreases monotonically -- guaranteed convergence
```

## State of the Art

| Old Approach | Current Approach | When Changed | Impact |
|--------------|------------------|--------------|--------|
| `hist()` for histograms | `histogram()` | R2014b | Better defaults |
| `eigs()` for large sparse matrices | `eig()` fine for small matrices (< 1000x1000) | N/A | For teaching: `eig()` is simpler and correct |
| Manual meshgrid for surface plots | `[X,Y] = meshgrid(...)` + `surf()` | Long established | Standard 3D visualization |
| Hopfield with `newhop()` (Neural Network Toolbox) | Manual implementation | N/A for teaching | Manual is the learning objective |

**Deprecated/outdated:**
- `polar()`: Replaced by `polarplot()`. Still works but has formatting limitations.
- `hist()`: Replaced by `histogram()`.
- Neural Network Toolbox Hopfield functions: Not needed and hide the concepts.

## Open Questions

1. **Module numbering**
   - What we know: Phase 1 = Modules 01-02, Phase 2 = 03-04, Phase 3 = 05-06.
   - What's unclear: Nothing -- continue with 07 and 08.
   - Recommendation: Module 07 for dimensionality reduction, Module 08 for attractor networks.

2. **Ring attractor complexity**
   - What we know: The full biophysical ring attractor model involves differential equations and time constants. ATTR-03 requires implementation and visualization.
   - What's unclear: Exactly how simplified the model can be while still demonstrating bump persistence and movement.
   - Recommendation: Use a discrete-time, rate-based model with rectification. Mexican-hat connectivity via `cos(theta_i - theta_j) - offset`. Normalize activity each step to prevent blow-up. Show: (a) bump forms spontaneously, (b) bump persists without input, (c) external input can shift the bump. Keep equations simple -- the visualization is the payoff.

3. **Connection between PCA and attractor networks**
   - What we know: These are taught as separate topics in NEVR3004 but can be connected: PCA reveals low-dimensional structure, attractor networks explain WHY neural activity is low-dimensional (it lives on attractor manifolds).
   - Recommendation: Mention this connection briefly in the attractor lesson ("remember how PCA showed the data lives in a low-dimensional space? Attractor networks explain why"). Don't over-belabor it.

4. **Christel's math readiness for this phase**
   - What we know: She now has eigenvalues (Phase 2), matrix operations (Phase 2), and population coding (Phase 3). PCA directly extends these. Hopfield networks use matrix multiplication and sign function. Ring attractors need a simple loop.
   - Recommendation: Lean heavily on the Phase 2 connection: "Remember eigenvectors from Module 04? PCA is EXACTLY that, applied to data instead of a transformation matrix." This is the strongest pedagogical link in the whole course.

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
| DIMR-01 | Motivation example shows high-D data reduced to 2D with clear visual | manual | Run demo_why_reduce.m, inspect 3D vs 2D comparison | Wave 0 |
| DIMR-02 | PCA step-by-step produces correct eigenvalues and projection | manual | Run demo_pca_steps.m, verify eigenvalues printed and plots shown | Wave 0 |
| DIMR-03 | Scree plot and cumulative variance explained displayed | manual | Run demo_pca_steps.m or demo_pca_neural.m, inspect variance plots | Wave 0 |
| ATTR-01 | Energy landscape plotted with ball-in-bowl metaphor | manual | Run demo_energy_landscape.m, inspect 1D/2D energy plots with labeled valleys | Wave 0 |
| ATTR-02 | Hopfield stores patterns and retrieves from noisy input | manual | Run demo_hopfield.m, verify original vs noisy vs retrieved comparison | Wave 0 |
| ATTR-03 | Ring attractor shows stable bump that persists | manual | Run demo_ring_attractor.m, verify bump in activity-over-time heatmap | Wave 0 |

### Sampling Rate
- **Per task commit:** Run all .m files in the module, verify figures appear without errors
- **Per wave merge:** Run all .m files across all modules, verify no cross-module issues
- **Phase gate:** All demo and solution scripts run clean; exercises run clean when TODOs are filled per solutions

### Wave 0 Gaps
- All content is new -- no existing files. Wave 0 creates the module content.
- Existing reference card (reference/neural_coding_info.md) should be extended or a new card created.
- Validation is manual (run Matlab scripts, inspect output).

## Sources

### Primary (HIGH confidence)
- [MathWorks - eig](https://www.mathworks.com/help/matlab/ref/eig.html) - eigenvalues and eigenvectors (base Matlab)
- [MathWorks - cov](https://www.mathworks.com/help/matlab/ref/cov.html) - covariance matrix (base Matlab)
- [MathWorks - sign](https://www.mathworks.com/help/matlab/ref/sign.html) - signum function (base Matlab)
- [MathWorks - surf](https://www.mathworks.com/help/matlab/ref/surf.html) - 3D surface plots (base Matlab)
- [Neuronal Dynamics Ch. 17.2 - Hopfield Model](https://neuronaldynamics.epfl.ch/online/Ch17.S2.html) - Hopfield network theory and equations
- [Neuronal Dynamics Ch. 18.3 - Bump Attractors](https://neuronaldynamics.epfl.ch/online/Ch18.S3.html) - Ring attractor / bump attractor model

### Secondary (MEDIUM confidence)
- [Neuromatch Academy - PCA Tutorial](https://compneuro.neuromatch.io/tutorials/W1D4_DimensionalityReduction/student/W1D4_Tutorial2.html) - PCA for computational neuroscience
- [NTNU NEVR3004 Course Page](https://www.ntnu.edu/studies/courses/NEVR3004) - course content alignment
- [Nicky Case - Interactive Attractor Landscapes](https://ncase.me/attractors/) - visual attractor dynamics without calculus
- [Dynamical systems, attractors, and neural circuits (PMC)](https://pmc.ncbi.nlm.nih.gov/articles/PMC4930057/) - attractor networks in neuroscience context
- [Goldman Lab - Hopfield Network](https://goldmanlab.faculty.ucdavis.edu/wp-content/uploads/sites/263/2016/07/HopfieldNetwork.pdf) - Hopfield tutorial for neuroscience course

### Tertiary (LOW confidence)
- Exact ring attractor parameter tuning (connectivity strength, inhibition offset) may need experimentation during implementation
- Whether NEVR3004 covers t-SNE or UMAP as nonlinear alternatives to PCA -- left out of scope for this phase as requirements only mention PCA

## Metadata

**Confidence breakdown:**
- Standard stack: HIGH - All functions verified as base Matlab, no toolboxes needed. `cov()`, `eig()`, `sign()`, `surf()` all confirmed base Matlab.
- Architecture: HIGH - Follows established Phase 1-3 patterns. Module numbering continues naturally (07, 08).
- PCA patterns: HIGH - Manual PCA procedure is well-established. Steps verified against multiple sources. Direct connection to Phase 2 eigenvalue content.
- Hopfield network: HIGH - Equations verified from Neuronal Dynamics textbook (Gerstner et al.). Weight rule and update rule are straightforward matrix operations.
- Ring attractor: MEDIUM - Basic model is well-understood, but specific parameter choices (connectivity strength, normalization method, time constants) may need tuning during implementation. The simplified discrete-time model is pedagogically appropriate but not a standard textbook formulation.
- Pitfalls: HIGH - Common errors (eig sorting, mean-centering, sign(0), capacity limits) well-documented in Matlab community.

**Research date:** 2026-03-15
**Valid until:** 2026-04-15 (stable domain, no moving targets)

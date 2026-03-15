# PCA and Attractor Networks Quick Reference

Covers Module 07 (Dimensionality Reduction) and Module 08 (Attractor Networks).

## PCA (Principal Component Analysis)

```matlab
% Center the data (subtract mean of each variable)
data_centered = data - mean(data);

% Compute covariance matrix
C = cov(data);    % or (1/(n-1)) * data_centered' * data_centered

% Eigendecomposition
[V, D] = eig(C);                   % V = eigenvectors, D = eigenvalues
eigenvalues = diag(D);
[eigenvalues, order] = sort(eigenvalues, 'descend');
V = V(:, order);                   % Sort by decreasing variance

% Project data onto top k components
k = 2;
scores = data_centered * V(:, 1:k);   % Projected coordinates

% Variance explained
var_explained = eigenvalues / sum(eigenvalues) * 100;
cumulative = cumsum(var_explained);
```

### Key Operations

| Operation | Code | What It Does |
|-----------|------|--------------|
| Center data | `data - mean(data)` | Remove mean so PCA finds variance directions |
| Covariance | `cov(data)` | How variables co-vary (symmetric matrix) |
| Eigendecomposition | `[V,D] = eig(C)` | Find principal directions and their variances |
| Sort by variance | `sort(diag(D), 'descend')` | Most important component first |
| Project | `data * V(:,1:k)` | Reduce to k dimensions |
| Variance explained | `eigenvalues/sum(eigenvalues)*100` | How much each PC captures |

### Scree Plot

```matlab
figure;
bar(var_explained);
xlabel('Principal Component');
ylabel('Variance Explained (%)');
title('Scree Plot');
```

---

## Hopfield Networks

### Learning Rule

| Step | Code | What It Does |
|------|------|--------------|
| Store patterns | `P = [p1, p2, p3]` | Each column is a pattern of +1/-1 |
| Hebbian learning | `W = (1/N) * (P * P')` | "Neurons that fire together wire together" |
| Remove self-connections | `W(1:N+1:end) = 0` | Diagonal to zero |

### Retrieval

```matlab
S = noisy_pattern;           % Start from corrupted input
for iter = 1:max_iters
    S_new = sign(W * S);     % Multiply and threshold
    S_new(S_new == 0) = 1;   % Fix sign(0) = 0 pitfall
    if isequal(S_new, S)
        break;               % Converged
    end
    S = S_new;
end
```

### Key Operations

| Operation | Code | What It Does |
|-----------|------|--------------|
| Weight matrix | `W = (1/N) * (P * P')` | Hebbian learning from patterns |
| State update | `S = sign(W * S)` | Each neuron sums inputs, thresholds |
| Energy | `E = -0.5 * S' * W * S` | Always decreases during retrieval |
| Overlap | `(1/N) * (S' * pattern)` | +1 = match, -1 = inverted, 0 = random |
| Capacity | `~0.14 * N` | Max reliable patterns |

### Pitfalls

| Pitfall | Problem | Fix |
|---------|---------|-----|
| `sign(0)` | Returns 0, but network needs +1/-1 | `S(S==0) = 1` after `sign()` |
| Self-connections | Trivial feedback locks states | `W(1:N+1:end) = 0` |
| Too many patterns | Memories interfere, retrieval fails | Keep below `0.14 * N` |

---

## Ring Attractors

### Components

| Component | Code | Purpose |
|-----------|------|---------|
| Neuron positions | `theta = linspace(0, 2*pi, N+1); theta(1:end-1)` | Preferred directions on ring |
| Mexican-hat weights | `W(i,j) = cos(theta(i)-theta(j)) - 0.5` | Excite neighbors, inhibit distant |
| No self-connections | `W(1:N+1:end) = 0` | Prevent trivial feedback |
| Initial bump | `exp(5*cos(theta - center))` | Von Mises-shaped activity |
| Normalize | `activity / sum(activity)` | Prevent blow-up |

### Simulation Loop

```matlab
for step = 1:n_steps
    input = (W * activity')';
    activity = activity + (dt/tau) * (-activity + input);
    activity = max(0, activity);          % Rectify
    activity = activity / sum(activity);  % Normalize
end
```

### Parameters

| Parameter | Typical Value | Effect |
|-----------|--------------|--------|
| N | 100 | Number of neurons on ring |
| tau | 1 | Time constant (higher = slower) |
| dt | 0.1 | Time step (must be < tau) |
| Offset (-0.5) | Adjustable | Controls inhibition strength |

### Stability Tips

- Always normalize activity each step to prevent blow-up
- Rectify with `max(0, ...)` -- firing rates cannot be negative
- Check `sum(activity) > 0` before normalizing to avoid division by zero
- Use `imagesc` heatmap (time x direction) to verify stable bump

---

## Connecting PCA and Attractors

| PCA Shows... | Attractors Explain... |
|-------------|----------------------|
| Data lives in low dimensions | Connectivity creates low-D manifolds |
| Principal components capture variance | Attractor valleys constrain activity |
| Scree plot drops off | Only a few attractor states exist |
| Neural trajectories stay near manifold | Energy landscape keeps states in valleys |

**Key insight:** PCA describes the *shape* of neural activity (low-dimensional). Attractor networks explain the *mechanism* (connectivity creates energy valleys that constrain dynamics to low-dimensional manifolds).

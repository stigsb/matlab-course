# Quick Reference: PCA and Attractor Networks

## PCA Step-by-Step

| Step | Code | What It Does |
|------|------|--------------|
| 1. Organize data | `data` (rows=obs, cols=vars) | Each row is one time point, each column is one neuron |
| 2. Mean-center | `centered = data - mean(data)` | Shift data so mean is at origin |
| 3. Covariance matrix | `C = cov(centered)` | How each pair of variables co-varies (p x p matrix) |
| 4. Eigendecompose | `[V, D] = eig(C)` | Find principal component directions and their variances |
| 5. Sort descending | `[vals, idx] = sort(diag(D), 'descend'); V = V(:,idx)` | Put the most important component first |
| 6. Project | `projected = centered * V(:, 1:k)` | Reduce to k dimensions |

## Key Functions

| Function | Purpose | Example |
|----------|---------|---------|
| `mean(X)` | Column means for centering | `mu = mean(data)` |
| `cov(X)` | Covariance matrix (columns = variables) | `C = cov(centered)` |
| `eig(C)` | Eigenvalues and eigenvectors | `[V, D] = eig(C)` |
| `diag(D)` | Extract eigenvalues from diagonal matrix | `eigenvalues = diag(D)` |
| `sort(v, 'descend')` | Sort largest first with index | `[vals, idx] = sort(eigenvalues, 'descend')` |
| `cumsum(v)` | Cumulative sum (for cumulative variance) | `cumvar = cumsum(var_explained)` |

## Common Pitfalls

| Pitfall | Problem | Fix |
|---------|---------|-----|
| `eig()` order | Returns ascending, PCA needs descending | Always `sort(diag(D), 'descend')` |
| Forgetting mean-center | PCA finds mean direction, not variance direction | Always subtract `mean(data)` before PCA |
| Rows vs columns | `cov()` expects columns = variables | If 200 timepoints, 3 neurons: matrix is 200x3, NOT 3x200 |
| Projecting uncentered data | Projection offset from true PC space | Use `centered * V`, not `data * V` |

## Interpreting Results

### Scree Plot
- Bar chart of eigenvalues (or % variance explained)
- Look for the **elbow**: where bars suddenly get small
- Components after the elbow are mostly noise

### Variance Explained Thresholds
| Threshold | Meaning | Common Use |
|-----------|---------|------------|
| 90% | Standard threshold | Most analyses |
| 95% | Conservative | When you want to preserve more detail |
| 80% | Aggressive | When you need very few dimensions |

### Variance Explained Formula
```matlab
var_explained = eigenvalues / sum(eigenvalues) * 100;
cumulative = cumsum(var_explained);
```

---

## Attractor Networks

*Covered in Module 08. Placeholders below.*

### Hopfield Network

| Concept | Description |
|---------|-------------|
| Purpose | Store and retrieve binary patterns (associative memory) |
| Neurons | Binary states: +1 or -1 |
| Weight rule | `W = (1/N) * patterns * patterns'` (Hebbian learning) |
| Update rule | `S = sign(W * S)` (threshold at zero) |
| Energy | `E = -0.5 * S' * W * S` (decreases during retrieval) |
| Capacity | ~0.14 * N patterns for N neurons |

### Ring Attractor

| Concept | Description |
|---------|-------------|
| Purpose | Maintain continuous variable (e.g., head direction) |
| Structure | Neurons arranged on a ring, each with preferred direction |
| Connectivity | Mexican-hat: local excitation, distant inhibition |
| Key feature | Stable activity bump that persists without input |
| Used for | Head direction cells, spatial navigation |

---

*See Module 07 lesson.md for PCA tutorial. See Module 08 lesson.md for attractor network tutorial.*

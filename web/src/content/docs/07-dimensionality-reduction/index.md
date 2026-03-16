---
title: "Module 7: Dimensionality Reduction"
description: "Find structure in neural data with PCA -- from eigenvalues to principal components, step by step."
sidebar:
  order: 7
---

## What you'll learn

By the end of this module, you'll be able to:
- Explain **why** we need dimensionality reduction for neural data
- Perform **PCA step-by-step** using base Matlab functions you already know
- Read a **scree plot** and **cumulative variance plot** to decide how many components to keep
- Apply PCA to **neural population data** and interpret the results

## What you need

- Completed Modules 01-06 (especially Module 04: eigenvalues and eigenvectors)
- Matlab open with the `07-dimensionality-reduction` folder as your current directory

## Why this matters

In Module 05, you learned to record and decode neural populations. But real experiments record from 50, 100, or even thousands of neurons simultaneously. You can't plot 100 dimensions. You can't eyeball a 1000-column data matrix.

**Dimensionality reduction** finds the few directions that matter in your data. And the tool we'll use -- PCA -- is built on eigenvectors, which you already know from Module 04. This module connects everything you've learned so far.

---

## Part 1: The Curse of Dimensions (10-15 minutes)

### The camera angle analogy

Imagine you're photographing a 3D sculpture. From some angles, you see all the interesting detail. From others, the sculpture looks like a flat blob. **Dimensionality reduction is finding the best camera angle for your data.**

When you record from 50 neurons simultaneously, you get 50 numbers at each time point -- one firing rate per neuron. Each time point is a single point in a 50-dimensional space. We can't visualize 50 dimensions, but here's the key insight:

> Most of the interesting variation in neural data happens in just a few directions. The rest is noise.

This is because neurons don't fire independently. They share inputs, connect to each other, and respond to the same stimuli. If 50 neurons are all driven by 2-3 common signals, then the data really lives in a 2-3 dimensional subspace of the 50-dimensional recording space.

### What PCA does

**Principal Component Analysis (PCA)** finds the directions of greatest variance in your data, from the most important to the least. Then you project your data onto just the top few directions, throwing away the noisy dimensions.

Think of it as:
1. Find the direction of maximum spread (PC1)
2. Find the next direction of maximum spread, perpendicular to PC1 (PC2)
3. Continue until you've explained all the variance
4. Keep only the top 2-3 components -- that's your "best camera angle"

> **Run** `demo_why_reduce` to see 50 neurons reduced to 2-3 meaningful dimensions.

---

## Part 2: PCA Step-by-Step (20-25 minutes)

### The eigenvalue connection

Remember eigenvectors from Module 04? You learned that eigenvectors are **directions that survive a transformation** -- they only get stretched, not rotated. You found them using `[V, D] = eig(A)`.

PCA uses exactly the same math, applied to a different matrix. Instead of a transformation matrix, we eigendecompose the **covariance matrix** of our data. The eigenvectors of the covariance matrix are the **directions of maximum variance** -- the principal components.

| Module 04 (eigenvalues) | Module 07 (PCA) |
|-------------------------|-----------------|
| Matrix A (any transformation) | Covariance matrix C (describes data spread) |
| Eigenvectors = directions that survive | Eigenvectors = directions of maximum variance |
| Eigenvalues = how much stretching | Eigenvalues = how much variance in each direction |
| `[V, D] = eig(A)` | `[V, D] = eig(cov(data))` |

This is not a coincidence -- it's the **same mathematical operation** applied to a specific matrix. If you understood Module 04, you already understand PCA.

### The six steps

Here are the steps, each using Matlab functions you already know:

**Step 1: Organize your data**
- Rows = observations (time points, trials)
- Columns = variables (neurons, features)
- If you have 200 time points and 3 neurons, your matrix is 200 x 3

**Step 2: Mean-center the data**
```matlab
mu = mean(data);           % mean of each column
centered = data - mu;      % subtract the mean
```
This shifts the data so it's centered at the origin. PCA finds directions of variance, not directions toward the mean.

**Step 3: Compute the covariance matrix**
```matlab
C = cov(centered);         % variables x variables matrix
```
The covariance matrix tells you how each pair of variables co-varies. For 3 variables, you get a 3x3 matrix.

**Step 4: Eigendecompose the covariance matrix**
```matlab
[V, D] = eig(C);           % V = eigenvectors, D = eigenvalues on diagonal
```
Same function as Module 04! The eigenvectors (columns of V) are the principal component directions. The eigenvalues (diagonal of D) tell you how much variance each direction captures.

**Step 5: Sort by largest eigenvalue first**
```matlab
[eigenvalues, idx] = sort(diag(D), 'descend');
V = V(:, idx);
```
**Important:** Matlab's `eig()` returns eigenvalues in **ascending** order. PCA needs them in **descending** order (most important first). Always sort!

**Step 6: Project onto the top components**
```matlab
projected = centered * V(:, 1:2);   % project onto top 2 PCs
```
This gives you a 2D view of your high-dimensional data, capturing the most important structure.

> **Run** `demo_pca_steps` to see each step applied to 3D data projected down to 2D.

---

## Part 3: Interpreting PCA (10-15 minutes)

### How many components do you need?

After PCA, you have eigenvalues telling you how much variance each component captures. The question is: **how many components should you keep?**

Two tools help you decide:

**Scree plot** -- A bar chart of eigenvalues (or variance explained percentages). Look for the "elbow" where the bars suddenly get small. Components after the elbow are mostly noise.

**Cumulative variance plot** -- Shows total variance explained as you add components. Draw a line at 90% (or whatever threshold you choose). The number of components where you cross that line is your answer.

### Variance explained

Each eigenvalue tells you the variance captured by that component. The percentage of total variance explained by component k is:

```
variance_explained(k) = eigenvalue(k) / sum(all_eigenvalues) * 100
```

In Matlab:
```matlab
var_explained = eigenvalues / sum(eigenvalues) * 100;
cumulative = cumsum(var_explained);
```

### Notation bridge

In textbooks, you may see PCA written as:

| Symbol | Meaning | Matlab |
|--------|---------|--------|
| **X** | Data matrix (n x p) | `data` |
| **X-bar** or mu | Column means | `mean(data)` |
| **C** or Sigma | Covariance matrix (p x p) | `cov(centered)` |
| **v_k** | k-th eigenvector (principal component direction) | `V(:, k)` |
| lambda_k | k-th eigenvalue (variance along v_k) | `eigenvalues(k)` |
| **Z** | Projected data (scores) | `centered * V(:, 1:k)` |

Don't let the Greek letters intimidate you -- it's the same six steps you just learned.

> **Run** `demo_pca_steps` again and look at the scree plot and cumulative variance plot (Figure 2).

---

## Part 4: PCA on Neural Data (15-20 minutes)

### Population responses to circular stimuli

In Module 05, you learned that neurons have preferred directions. When you record a population of neurons, each with a different preferred direction, the population response encodes the stimulus direction.

What happens when you apply PCA to this population data? Something beautiful: **circular stimuli map to circular patterns in PC space.**

If you have 8 neurons evenly covering all directions and stimulate with random directions, the data in PC space forms a **ring**. Points at similar stimulus directions are close together on the ring. This is PCA revealing the underlying circular structure that you can't see by looking at 8 neurons individually.

### Why this works

Each neuron responds with a cosine tuning curve (maximum at preferred direction, minimum at opposite). With neurons spread evenly around the circle:
- PC1 captures one axis of the circular variation
- PC2 captures the perpendicular axis
- Together, PC1 and PC2 reconstruct the circular stimulus space

This is exactly what neuroscientists use PCA for: discovering the **low-dimensional structure** hidden in high-dimensional population recordings.

> **Run** `demo_pca_neural` to see the ring of neural data in PC space.

---

## Exercises

Complete `exercise_dimensionality.m` to practice all the PCA steps yourself.

## Quick reference

See `reference/pca_attractors.md` for a lookup table of PCA steps, functions, and common pitfalls.

## Download Scripts

Download these files and open them in MATLAB Desktop:

- [demo_pca_neural.m](/matlab-course/scripts/07-dimensionality-reduction/demo_pca_neural.m)
- [demo_pca_steps.m](/matlab-course/scripts/07-dimensionality-reduction/demo_pca_steps.m)
- [demo_why_reduce.m](/matlab-course/scripts/07-dimensionality-reduction/demo_why_reduce.m)
- [exercise_dimensionality.m](/matlab-course/scripts/07-dimensionality-reduction/exercise_dimensionality.m)
- [solution_dimensionality.m](/matlab-course/scripts/07-dimensionality-reduction/solution_dimensionality.m)

:::tip
To run these scripts, save them to a folder, set that folder as your MATLAB Current Folder, then press F5 or click Run.
:::

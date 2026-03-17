---
title: "Module 4: Math Foundations"
description: "Build the mathematical foundation for computational neuroscience: matrices as transformations, statistics, and eigenvalues."
sidebar:
  order: 4
---

## Overview

This module builds the mathematical foundation you need for computational neuroscience. You will learn three big ideas:

1. **Matrices as transformations** -- a matrix is a machine that takes a vector in and spits a different vector out
2. **Statistics** -- mean, standard deviation, and correlation, always with plots that make the numbers meaningful
3. **Eigenvalues** -- the special directions that survive a transformation (this is the key to PCA later)

Each idea follows the same pattern: see it visually first, then write the code, then connect it to the math notation.

**Prerequisites:** Modules 01-03 (variables, vectors, plotting, functions, loops)

**Time estimate:** 45-60 minutes

---

## Part 1: Matrices as Transformations (15-20 min)

### The Big Idea

A matrix is not just a grid of numbers. A matrix **does something** to vectors.

Think of it like a machine:
- You feed a vector in one end
- The matrix stretches it, rotates it, squishes it, or flips it
- A transformed vector comes out the other end

```
   Input vector   -->  [ Matrix Machine ]  -->  Output vector
      [1; 0]      -->    [2 1; 0 1.5]     -->     [2; 0]
```

### See It: Before and After

Imagine a circle made of arrows (vectors) all pointing outward from the origin. Now multiply every arrow by a 2x2 matrix. The circle becomes an ellipse -- the matrix has stretched and skewed it.

Run `demo_matrix_transform.m` to see this. The quiver plots show the "before" (a perfect circle of arrows) and the "after" (a squished, tilted ellipse).

### Code It: Matrix-Vector Multiplication

```matlab
% A 2x2 transformation matrix
A = [2 1; 0 1.5];

% A single vector
v = [1; 0];

% Apply the transformation
result = A * v;   % This is matrix-vector multiplication
```

The `*` operator here does **matrix multiplication**, not element-wise multiplication. This is different from `.*` which you learned in Module 02.

| Operation | Symbol | What it does |
|-----------|--------|-------------|
| Matrix multiply | `A * v` | Linear algebra multiplication (rows times columns) |
| Element-wise multiply | `A .* B` | Multiply each pair of elements separately |

**Common mistake:** Using `*` when you mean `.*`, or vice versa. If you get a "dimensions don't agree" error, check which one you need.

### Dot Product: How Similar Are Two Directions?

The dot product of two vectors tells you how much they point in the same direction:

```matlab
a = [1, 0];    % pointing right
b = [0, 1];    % pointing up
c = [1, 1];    % pointing diagonally

dot(a, b)   % = 0  (perpendicular -- completely different directions)
dot(a, c)   % = 1  (some overlap -- partly the same direction)
dot(a, a)   % = 1  (identical direction -- maximum similarity)
```

**Notation bridge:**
- Visual: two arrows, one long, one short, at some angle
- Code: `dot(a, b)` or `sum(a .* b)`
- Math notation: **a** . **b** = |a| |b| cos(theta)

### Matrix Multiplication: Chaining Transformations

Multiplying two matrices is like chaining two transformations. First do transformation B, then do transformation A:

```matlab
A = [2 0; 0 1];    % stretch x by 2
B = [1 0; 0 0.5];  % squish y by half

% Combined transformation: first B, then A
C = A * B;          % C = [2 0; 0 0.5]
```

Order matters! `A * B` is not the same as `B * A` for most matrices.

### Try It

1. Run `demo_matrix_transform.m` -- watch the circle become an ellipse
2. Change the matrix `A` to `[1 0; 0 1]` (the identity matrix) -- what happens to the circle?
3. Try `A = [0 -1; 1 0]` -- this is a 90-degree rotation. Does the circle change shape?

---

## Part 2: Statistics -- Making Sense of Data (15-20 min)

### The Big Idea

Statistics answer three questions about your data:
1. **What is typical?** -- the mean (average)
2. **How spread out is it?** -- standard deviation (std)
3. **Do these variables move together?** -- correlation

The key rule: **never compute a statistic without plotting it.** A number without a picture is meaningless.

### Mean: The Typical Value

```matlab
daily_temps = [12, 14, 13, 15, 18, 20, 19, 17, 15, 16, 18, 21, 22, 20];
m = mean(daily_temps);
fprintf('Average temperature: %.1f C\n', m);   % 17.1 C
```

The mean is the balance point of your data. On a histogram, it is where you would place your finger to balance it.

### Standard Deviation: How Spread Out

```matlab
s = std(daily_temps);
fprintf('Std deviation: %.1f C\n', s);   % about 3.0 C
```

Standard deviation tells you how far values typically are from the mean. About 68% of values fall within one standard deviation of the mean.

**Variance** is just the standard deviation squared: `var(daily_temps)` equals `std(daily_temps)^2`.

### Always Plot It

```matlab
histogram(daily_temps, 8);
hold on;
xline(m, 'r-', 'LineWidth', 2);         % mean line
xline(m + s, 'r--', 'LineWidth', 1);    % +1 std
xline(m - s, 'r--', 'LineWidth', 1);    % -1 std
hold off;
title(sprintf('Mean = %.1f, Std = %.1f', m, s));
```

Run `demo_statistics.m` to see this in action.

### Correlation: Do These Move Together?

Correlation measures whether two variables increase together (positive), move in opposite directions (negative), or have no relationship (near zero).

```matlab
% Do ice cream sales go up when temperature goes up?
R = corrcoef(temps, ice_cream_sales);
r = R(1,2);    % Extract the correlation value
```

**Important:** `corrcoef(x, y)` returns a **2x2 matrix**, not a single number!

```matlab
R = corrcoef(x, y)
%     x     y
% x [ 1.00  0.85 ]    <-- r is here: R(1,2)
% y [ 0.85  1.00 ]
```

The correlation `r` is always between -1 and +1:
- `r = +1`: perfect positive (both go up together)
- `r = 0`: no relationship
- `r = -1`: perfect negative (one goes up, the other goes down)

### Try It

1. Run `demo_statistics.m` -- look at the histogram and scatter plot
2. Change the data and re-run. How does the histogram shape change?
3. Look at the correlation scatter plot. Does the cloud of points slope up or down?

---

## Part 3: Eigenvalues -- Directions That Survive (15-20 min)

### The Big Idea

You saw in Part 1 that a matrix transforms vectors -- it stretches, rotates, and squishes them. Most vectors change both their direction AND their length.

But some special vectors only get stretched or shrunk. **They keep pointing in the same direction.** These are called **eigenvectors**, and the stretch factor is the **eigenvalue**.

Think of it this way:
- Apply the matrix to 100 random arrows
- Most arrows get twisted around
- But a few stubborn arrows **refuse to change direction** -- they just get longer or shorter
- Those stubborn arrows are the eigenvectors

### See It

Run `demo_eigenvalues.m` to see this. The plot shows:
- Gray arrows: all the vectors after transformation (they changed direction)
- Colored arrows: the eigenvectors before (dashed) and after (solid) transformation
- Notice: the colored arrows point in the **same direction** before and after -- they just got stretched

### Code It

```matlab
A = [2 1; 0 1.5];
[V, D] = eig(A);
```

What comes out:
- `V` is a matrix where each **column** is an eigenvector
- `D` is a diagonal matrix where the diagonal entries are the eigenvalues

```matlab
ev1 = V(:,1);        % first eigenvector (a direction)
lambda1 = D(1,1);    % first eigenvalue (the stretch factor)

ev2 = V(:,2);        % second eigenvector
lambda2 = D(2,2);    % second eigenvalue
```

The eigenvalue equation says: `A * ev1 = lambda1 * ev1`. The matrix does the same thing as just multiplying by a number -- it only stretches, no rotation.

### Notation Bridge

- **Visual:** The colored arrows that keep their direction in the plot
- **Code:** `[V, D] = eig(A)` -- V columns are eigenvectors, D diagonal has eigenvalues
- **Math notation:** **Av** = lambda **v** -- "the matrix times the vector equals a scalar times the vector"

### Important Notes

**Eigenvector sign ambiguity:** Matlab normalizes eigenvectors to unit length and may flip the sign. If a textbook says the eigenvector is `[1; 0]` and Matlab gives `[-1; 0]`, they are the same direction -- the direction is what matters, not the sign.

**Eigenvalues can be complex:** For some matrices, eigenvalues are complex numbers. In this course we use matrices where eigenvalues are real numbers. If you see imaginary parts (numbers with `i`), the matrix has rotational behavior.

### Try It

1. Run `demo_eigenvalues.m` -- find the arrows that keep their direction
2. Verify: compute `A * V(:,1)` and `D(1,1) * V(:,1)` -- are they the same?
3. Try changing the matrix. What happens to the eigenvectors?

---

## Summary

| Concept | Matlab Code | What It Means |
|---------|------------|---------------|
| Matrix-vector multiply | `A * v` | Transform vector v using matrix A |
| Dot product | `dot(a, b)` | How similar are directions a and b? |
| Matrix multiply | `A * B` | Chain transformation B then A |
| Mean | `mean(x)` | The typical value |
| Standard deviation | `std(x)` | How spread out the data is |
| Correlation | `R = corrcoef(x,y); r = R(1,2);` | Do x and y move together? |
| Eigenvalues | `[V,D] = eig(A)` | Directions that survive transformation |

### What is Next

In Module 05 (Phase 3), you will use these tools on real neural data -- spike rates, membrane potentials, and information coding. In Phase 4, eigenvalues become the foundation for PCA (Principal Component Analysis), which finds the most important directions in high-dimensional data.

---

## Files in This Module

| File | What it does |
|------|-------------|
| `demo_matrix_transform.m` | Quiver plots showing matrix transformation, dot product, matrix multiply |
| `demo_statistics.m` | Histogram with mean/std lines, correlation scatter plot |
| `demo_eigenvalues.m` | Eigenvector visualization -- "directions that survive" |
| `exercise_math.m` | Scaffolded practice (fill in the TODOs) |
| `solution_math.m` | Complete solutions for the exercise |

## Download Scripts

Download these files and open them in MATLAB Desktop:

- [demo_eigenvalues.m](/scripts/04-math-foundations/demo_eigenvalues.m)
- [demo_matrix_transform.m](/scripts/04-math-foundations/demo_matrix_transform.m)
- [demo_statistics.m](/scripts/04-math-foundations/demo_statistics.m)
- [exercise_math.m](/scripts/04-math-foundations/exercise_math.m)
- [solution_math.m](/scripts/04-math-foundations/solution_math.m)

:::tip
To run these scripts, save them to a folder, set that folder as your MATLAB Current Folder, then press F5 or click Run.
:::

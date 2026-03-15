# Phase 2: Programming and Math Foundations - Research

**Researched:** 2026-03-15
**Domain:** Matlab programming constructs (functions, loops, conditionals) + linear algebra and statistics foundations
**Confidence:** HIGH

## Summary

Phase 2 bridges the gap between "running scripts" (Phase 1) and "writing programs" (Phase 3+). It has two interleaved pillars: (1) Matlab programming constructs -- functions, for-loops, while-loops, and if/else conditionals -- and (2) the math foundations that NEVR3004 builds on -- matrix operations, dot products, eigenvalues/eigenvectors, probability distributions, and descriptive statistics (mean, variance, correlation).

The programming content is straightforward core Matlab with no toolboxes. The key pedagogical challenge is keeping the math visual and grounded. Eigenvalues/eigenvectors in particular require careful visual treatment -- the learner must see them as "directions that survive a transformation" before encountering any notation. Statistics must be tied to concrete data the learner can relate to (garden measurements, daily temperatures, cat weights across a week). Probability distributions should be introduced through histograms of concrete data before any formal distribution theory.

This phase produces two modules: one focused on programming (functions, loops, conditionals) and one focused on math (matrices as transformations, statistics, eigenvalues). Both follow the See-Code-Do pattern and notation bridge from Phase 1.

**Primary recommendation:** Split into two plans: (02-01) Programming Tools covering functions, loops, and conditionals with practical data-processing exercises; (02-02) Math Foundations covering matrix transformations, statistics, and eigenvalues with heavy visual emphasis.

<phase_requirements>
## Phase Requirements

| ID | Description | Research Support |
|----|-------------|-----------------|
| MATL-05 | Learner can write functions that accept inputs and return outputs | `function` keyword syntax, function files (.m), local functions. Key functions: `function [out] = name(in)`, file naming rules, multiple outputs. |
| MATL-06 | Learner can use for-loops and while-loops to repeat computations | `for i = 1:n ... end`, `while condition ... end`, `break`, `continue`. Iterate over vectors and matrices. |
| MATL-07 | Learner can use if/else conditionals to control program flow | `if/elseif/else/end` syntax. Comparison operators (`==`, `~=`, `<`, `>`, `<=`, `>=`), logical operators (`&&`, `\|\|`, `~`). |
| MATH-02 | Learner understands matrices as transformations and can visualize what they do to vectors | Apply 2x2 matrix to grid of vectors using quiver, show rotation/scaling/shearing. Before/after visualization. |
| MATH-03 | Learner can compute and interpret dot products and matrix multiplication | `dot(a,b)`, `A * B` (matrix multiply), geometric interpretation of dot product as projection/similarity. |
| MATH-04 | Learner understands eigenvalues/eigenvectors visually | `[V,D] = eig(A)`. Visualize: most vectors change direction under transformation, eigenvectors only stretch/shrink. "Directions that survive." |
| MATH-05 | Learner understands probability distributions and can plot/interpret histograms | `histogram()`, `randn()`, `rand()`. Generate data, bin it, interpret shape. Normal distribution as "bell curve." |
| MATH-06 | Learner can compute and interpret mean, variance, standard deviation, and correlation | `mean()`, `var()`, `std()`, `corrcoef()`. Visualize with scatter plots showing correlation, bar charts comparing means. |
</phase_requirements>

## Standard Stack

### Core
| Library | Version | Purpose | Why Standard |
|---------|---------|---------|--------------|
| Matlab (core) | R2024a+ | Everything | All needed functions are built-in. No toolboxes required. |

### Key Built-in Functions (Phase 2)

**Programming Constructs:**
| Function/Syntax | Purpose | Example |
|-----------------|---------|---------|
| `function` | Define function | `function y = square(x)` |
| `for ... end` | For loop | `for i = 1:10 ... end` |
| `while ... end` | While loop | `while x > 0 ... end` |
| `if/elseif/else/end` | Conditionals | `if x > 5 ... elseif x > 0 ... else ... end` |
| `break` | Exit loop early | `if found, break; end` |
| `continue` | Skip to next iteration | `if skip, continue; end` |
| `return` | Exit function early | `if error, return; end` |

**Linear Algebra:**
| Function | Purpose | Example |
|----------|---------|---------|
| `A * B` | Matrix multiplication | `C = A * B` |
| `dot(a, b)` | Dot product | `d = dot([1 2], [3 4])` gives 11 |
| `A'` | Transpose | `A_transposed = A'` |
| `inv(A)` | Matrix inverse | `A_inv = inv(A)` |
| `det(A)` | Determinant | `d = det(A)` |
| `eig(A)` | Eigenvalues only | `lambda = eig(A)` |
| `[V,D] = eig(A)` | Eigenvectors + eigenvalues | V = eigenvectors (columns), D = diagonal eigenvalues |
| `eye(n)` | Identity matrix | `I = eye(3)` |

**Statistics:**
| Function | Purpose | Example |
|----------|---------|---------|
| `mean(x)` | Arithmetic mean | `m = mean(data)` |
| `var(x)` | Variance | `v = var(data)` |
| `std(x)` | Standard deviation | `s = std(data)` |
| `median(x)` | Median | `med = median(data)` |
| `corrcoef(x, y)` | Correlation coefficient matrix | `R = corrcoef(x, y)` |
| `cov(x, y)` | Covariance matrix | `C = cov(x, y)` |
| `histogram(x)` | Histogram plot | `histogram(data, 20)` |
| `randn(m, n)` | Normal random numbers | `data = randn(1000, 1)` |
| `rand(m, n)` | Uniform random numbers | `data = rand(1000, 1)` |
| `min(x)`, `max(x)` | Min and max | `[mn, idx] = min(data)` |
| `sum(x)` | Sum | `total = sum(data)` |
| `cumsum(x)` | Cumulative sum | `running = cumsum(data)` |
| `sort(x)` | Sort | `sorted = sort(data)` |

### Alternatives Considered
| Instead of | Could Use | Tradeoff |
|------------|-----------|----------|
| `corrcoef()` (base Matlab) | `corr()` (Statistics Toolbox) | corrcoef is in base Matlab, no toolbox needed. corr has more options but requires Statistics Toolbox. |
| `histogram()` | `hist()` (deprecated) | histogram() is the modern replacement. hist() still works but is not recommended. |
| Manual eigenvalue computation | `eig()` | Always use eig(). Manual computation is for understanding only, never for actual use. |

## Architecture Patterns

### Recommended Project Structure (Phase 2 Deliverables)
```
matlab-course/
├── 03-programming-tools/
│   ├── lesson.md                  # Functions, loops, conditionals
│   ├── demo_functions.m           # Writing and calling functions
│   ├── demo_loops.m               # For-loops, while-loops, break/continue
│   ├── demo_conditionals.m        # If/elseif/else with data filtering
│   ├── exercise_programming.m     # Scaffolded practice: write functions, use loops
│   ├── solution_programming.m     # Complete solution
│   ├── average_value.m            # Example function file (learner creates)
│   └── filter_data.m              # Example function file (learner creates)
├── 04-math-foundations/
│   ├── lesson.md                  # Matrix transforms, statistics, eigenvalues
│   ├── demo_matrix_transform.m    # Visualize what matrices do to vectors
│   ├── demo_statistics.m          # Mean, variance, correlation with plots
│   ├── demo_eigenvalues.m         # Eigenvectors as "directions that survive"
│   ├── exercise_math.m            # Scaffolded practice: compute stats, interpret transforms
│   ├── solution_math.m            # Complete solution
│   └── compute_stats.m            # Example function file (learner creates)
└── reference/
    ├── matlab_basics.md           # (existing from Phase 1)
    └── programming_and_math.md    # Quick-lookup: functions, loops, stats, linear algebra
```

### Pattern 1: Function File Convention
**What:** In Matlab, a function must be in its own .m file whose name matches the function name, OR it can be a local function at the bottom of a script file.
**When to use:** Teach both patterns. Start with local functions (easier, no extra files), then graduate to function files.
**Example:**
```matlab
% Method 1: Local function at bottom of script
clear; clc; close all;

result = square(5);
fprintf('5 squared = %d\n', result);

function y = square(x)
    y = x^2;
end
```
```matlab
% Method 2: Separate file (square.m)
function y = square(x)
    % SQUARE  Compute the square of a number
    %   y = SQUARE(x) returns x^2
    y = x^2;
end
```

### Pattern 2: Loop-and-Accumulate
**What:** Use a for-loop to iterate over data, accumulating results. This is the core pattern for processing experimental data trial by trial.
**When to use:** Processing neural data, filtering by condition, computing statistics per group.
**Example:**
```matlab
% Process each trial, keeping only the ones where reaction time < 500ms
reaction_times = [320, 510, 280, 620, 410, 390, 710, 340];
fast_trials = [];  % start with empty result

for i = 1:length(reaction_times)
    if reaction_times(i) < 500
        fast_trials = [fast_trials, reaction_times(i)];
    end
end

fprintf('Found %d fast trials out of %d total\n', length(fast_trials), length(reaction_times));
```

### Pattern 3: Matrix-as-Transformation Visualization
**What:** Show what a 2x2 matrix does to a grid of vectors. Before: evenly spaced arrows. After: transformed arrows. Eigenvectors are highlighted as the arrows that kept their direction.
**When to use:** Teaching MATH-02 and MATH-04.
**Example:**
```matlab
% Create a grid of unit vectors (circle of arrows)
theta = linspace(0, 2*pi, 20);
arrows = [cos(theta); sin(theta)];  % 2xN matrix

% Transformation matrix
A = [2 1; 0 1.5];

% Apply transformation
transformed = A * arrows;

% Plot before and after
figure;
subplot(1,2,1);
quiver(zeros(1,20), zeros(1,20), arrows(1,:), arrows(2,:), 0);
axis equal; grid on; title('Before: Unit Circle');

subplot(1,2,2);
quiver(zeros(1,20), zeros(1,20), transformed(1,:), transformed(2,:), 0);
axis equal; grid on; title('After: Transformed');
```

### Pattern 4: Statistics with Visual Verification
**What:** Every statistical computation is immediately followed by a plot that makes the number meaningful. Mean is shown as a vertical line on a histogram. Correlation is shown as a scatter plot with the r-value in the title.
**When to use:** Teaching MATH-05 and MATH-06.
**Example:**
```matlab
data = randn(1000, 1) * 15 + 100;  % IQ-like data
m = mean(data);
s = std(data);

figure;
histogram(data, 30);
hold on;
xline(m, 'r-', 'LineWidth', 2);
xline(m + s, 'r--', 'LineWidth', 1);
xline(m - s, 'r--', 'LineWidth', 1);
hold off;
title(sprintf('Mean = %.1f, Std = %.1f', m, s));
xlabel('Value'); ylabel('Count');
legend('Data', 'Mean', '+/- 1 Std Dev');
```

### Anti-Patterns to Avoid
- **Teaching function handles before function files:** Anonymous functions (`@(x) x^2`) are confusing for beginners. Teach named functions first.
- **Abstract loop examples:** Never use `for i = 1:10, disp(i), end` as the primary example. Use data-driven examples (loop through cat weights, daily temperatures).
- **Matrix math without visualization:** Never show `A * B` without immediately plotting what it does. The visual is the understanding.
- **Statistics without context:** Never compute `mean(x)` on abstract data. Use garden plant heights, daily temperatures, reaction times.
- **Eigenvalue notation before visual:** Never write lambda or eigenvalue equations before showing the transformation plot. The notation bridge pattern applies here too.

## Don't Hand-Roll

| Problem | Don't Build | Use Instead | Why |
|---------|-------------|-------------|-----|
| Mean of a dataset | Manual sum/length | `mean(x)` | Built-in, handles matrices correctly (column-wise) |
| Standard deviation | Manual sqrt of variance | `std(x)` | Handles N-1 normalization (sample std) by default |
| Correlation | Manual formula | `corrcoef(x, y)` | Returns full correlation matrix, handles edge cases |
| Covariance | Manual computation | `cov(x, y)` | Correct normalization, matrix output |
| Eigenvalues | Manual characteristic polynomial | `eig(A)` or `[V,D] = eig(A)` | Numerically stable, handles complex eigenvalues |
| Matrix inverse | Manual adjugate/determinant | `inv(A)` or `A \ b` for solving | Backslash operator is more numerically stable than inv() |
| Dot product | Manual sum of products | `dot(a, b)` | Handles row/column vectors correctly |
| Histogram binning | Manual bin counting | `histogram(data, nbins)` | Proper bin edge handling, good default styling |

**Key insight:** For this course, understanding what the functions compute matters more than implementing them manually. Use `mean()`, `std()`, `eig()` etc. and focus energy on interpreting results visually.

## Common Pitfalls

### Pitfall 1: Function File Naming Mismatch
**What goes wrong:** Learner saves a function as `myFunction.m` but the function inside is named `my_function`. Matlab uses the filename, not the function name, leading to confusing errors.
**Why it happens:** Matlab associates functions with filenames, and beginners don't realize they must match.
**How to avoid:** Explicitly teach: "The filename MUST match the function name. `average_value.m` contains `function y = average_value(x)`." Show the error that occurs when they don't match.
**Warning signs:** "Undefined function or variable" when calling a function that clearly exists.

### Pitfall 2: Forgetting to Return Output from Function
**What goes wrong:** Function computes a result but never assigns it to the output variable. The function returns 0 or an empty result.
**Why it happens:** The learner computes the answer in a local variable but doesn't assign it to the declared output parameter.
**How to avoid:** Show the pattern clearly: "The output variable in `function y = myFunc(x)` is `y`. You MUST assign to `y` before the function ends."
**Warning signs:** Function returns unexpected zeros or empty values.

### Pitfall 3: Growing Arrays in Loops (Performance)
**What goes wrong:** `result = [result, new_value]` inside a loop copies the entire array each iteration. Slow for large data.
**Why it happens:** Matlab doesn't automatically pre-allocate like some languages.
**How to avoid:** For this course level, the performance impact is negligible with small datasets. Mention pre-allocation as a concept but don't make it a focus: "For small data this is fine. For millions of data points, pre-allocate with `zeros()`."
**Warning signs:** Slow execution on large datasets (unlikely in this course).

### Pitfall 4: Using = Instead of == in Conditions
**What goes wrong:** `if x = 5` assigns 5 to x instead of comparing. Matlab catches this as an error, but the error message is confusing.
**Why it happens:** Common mistake across all programming languages for beginners.
**How to avoid:** Explicitly teach: "`=` means assign. `==` means compare. `if x == 5` asks the question. `x = 5` gives the answer."
**Warning signs:** "Error: Incorrect use of '=' operator."

### Pitfall 5: Confusing Matrix Multiply and Element-wise Multiply
**What goes wrong:** Learner uses `*` when they mean `.*` (or vice versa). Matrix multiply has strict dimension requirements; element-wise requires same-size arrays.
**Why it happens:** Phase 1 introduced `.*` but matrix multiply `*` is new in Phase 2. The distinction needs reinforcement.
**How to avoid:** Side-by-side demo: show `A * B` (matrix multiply) next to `A .* B` (element-wise). Emphasize: "Matrix multiply is the math operation. Element-wise is 'multiply each pair.'"
**Warning signs:** Dimension mismatch errors, or unexpected single-number results.

### Pitfall 6: Eigenvector Sign/Scaling Ambiguity
**What goes wrong:** Learner expects eigenvectors to match textbook examples exactly, but Matlab normalizes eigenvectors to unit length and may flip the sign.
**Why it happens:** Eigenvectors are defined up to a scalar multiple. `eig()` returns unit-length eigenvectors, but the sign can be either positive or negative.
**How to avoid:** Explain: "Eigenvectors show the DIRECTION, not a specific vector. Matlab normalizes them to length 1. The direction is what matters, not the exact numbers." Visualize with arrows to make this clear.
**Warning signs:** "My eigenvector is the negative of the textbook answer."

### Pitfall 7: corrcoef Returns a Matrix, Not a Number
**What goes wrong:** Learner expects `corrcoef(x, y)` to return a single correlation value, but it returns a 2x2 matrix.
**Why it happens:** corrcoef returns the full correlation matrix. The correlation between x and y is in position (1,2) or (2,1).
**How to avoid:** Teach the pattern: `R = corrcoef(x, y); r = R(1,2);` to extract the single correlation value. Show what the full matrix means.
**Warning signs:** "Why did I get a matrix instead of a number?"

## Code Examples

### Writing and Calling a Function
```matlab
% Source: MathWorks - Create Functions in Files
% File: compute_bmi.m
function bmi = compute_bmi(weight_kg, height_m)
    % COMPUTE_BMI  Calculate Body Mass Index
    %   bmi = COMPUTE_BMI(weight_kg, height_m) returns BMI
    bmi = weight_kg / height_m^2;
end
```

```matlab
% Calling it from a script:
enzo_bmi = compute_bmi(5.2, 0.25);  % Cat BMI (not real, just fun)
fprintf('Enzo BMI: %.1f\n', enzo_bmi);
```

### Function with Multiple Outputs
```matlab
% Source: MathWorks - function reference
function [m, s, r] = describe_data(data)
    % DESCRIBE_DATA  Compute basic statistics
    %   [m, s, r] = DESCRIBE_DATA(data) returns mean, std, and range
    m = mean(data);
    s = std(data);
    r = max(data) - min(data);
end
```

### For-Loop Processing Data
```matlab
% Source: MathWorks - for loop reference
% Count how many garden plants are taller than 15 cm
plant_heights = [12, 8, 15, 22, 6, 18, 10, 14, 25, 9];
tall_count = 0;

for i = 1:length(plant_heights)
    if plant_heights(i) > 15
        tall_count = tall_count + 1;
        fprintf('Plant %d is tall: %d cm\n', i, plant_heights(i));
    end
end
fprintf('Total tall plants: %d out of %d\n', tall_count, length(plant_heights));
```

### Matrix as Transformation (Visual)
```matlab
% Source: MathWorks - eig documentation, linear algebra tutorials
clear; clc; close all;

% A 2x2 matrix that stretches and rotates
A = [2 1; 0 1.5];

% Create a circle of unit vectors
theta = linspace(0, 2*pi, 30);
original = [cos(theta); sin(theta)];

% Transform them
transformed = A * original;

% Plot before and after
figure;
subplot(1,2,1);
quiver(zeros(1,30), zeros(1,30), original(1,:), original(2,:), 0);
axis equal; grid on; xlim([-3 3]); ylim([-3 3]);
title('Before: Circle of Arrows');

subplot(1,2,2);
quiver(zeros(1,30), zeros(1,30), transformed(1,:), transformed(2,:), 0);
axis equal; grid on; xlim([-3 3]); ylim([-3 3]);
title('After: Matrix Squishes the Circle');
```

### Eigenvalue Visualization ("Directions That Survive")
```matlab
% Source: MathWorks - eig documentation
clear; clc; close all;

A = [2 1; 0 1.5];
[V, D] = eig(A);

% V columns are eigenvectors, D diagonal has eigenvalues
ev1 = V(:,1);  lambda1 = D(1,1);
ev2 = V(:,2);  lambda2 = D(2,2);

figure;
% Show many vectors before and after transformation
theta = linspace(0, 2*pi, 40);
arrows = [cos(theta); sin(theta)];
transformed = A * arrows;

% Light gray: all transformed vectors
quiver(zeros(1,40), zeros(1,40), transformed(1,:), transformed(2,:), 0, ...
    'Color', [0.7 0.7 0.7]);
hold on;

% Highlight eigenvectors: before (dashed) and after (solid)
scale = 2;
quiver(0, 0, ev1(1)*scale, ev1(2)*scale, 0, 'b--', 'LineWidth', 2);
quiver(0, 0, ev1(1)*scale*lambda1, ev1(2)*scale*lambda1, 0, 'b-', 'LineWidth', 3);

quiver(0, 0, ev2(1)*scale, ev2(2)*scale, 0, 'r--', 'LineWidth', 2);
quiver(0, 0, ev2(1)*scale*lambda2, ev2(2)*scale*lambda2, 0, 'r-', 'LineWidth', 3);
hold off;

axis equal; grid on;
title('Eigenvectors: Directions That Survive the Transformation');
legend('Other vectors', ...
    sprintf('Eigenvector 1 (before), lambda=%.1f', lambda1), ...
    'Eigenvector 1 (after: same direction, stretched)', ...
    sprintf('Eigenvector 2 (before), lambda=%.1f', lambda2), ...
    'Eigenvector 2 (after: same direction, stretched)');
```

### Statistics with Visualization
```matlab
% Source: MathWorks - mean, std, corrcoef, histogram documentation
clear; clc; close all;

% Generate daily temperatures for two weeks
days = 1:14;
temps = [12, 14, 13, 15, 18, 20, 19, 17, 15, 16, 18, 21, 22, 20];

% Compute statistics
m = mean(temps);
s = std(temps);
fprintf('Mean temperature: %.1f C\n', m);
fprintf('Std deviation: %.1f C\n', s);

figure;
subplot(1,2,1);
bar(days, temps);
hold on;
yline(m, 'r-', 'LineWidth', 2);
yline(m+s, 'r--'); yline(m-s, 'r--');
hold off;
xlabel('Day'); ylabel('Temperature (C)');
title(sprintf('Daily Temps (mean=%.1f, std=%.1f)', m, s));
legend('Temperature', 'Mean', '+/- 1 Std');

% Correlation example
ice_cream_sales = temps * 3.5 + randn(1,14) * 5 + 10;
R = corrcoef(temps, ice_cream_sales);
r = R(1,2);

subplot(1,2,2);
scatter(temps, ice_cream_sales, 50, 'filled');
xlabel('Temperature (C)'); ylabel('Ice Cream Sales');
title(sprintf('Correlation: r = %.2f', r));
grid on;
```

### Histogram and Distribution
```matlab
% Source: MathWorks - histogram, randn documentation
clear; clc; close all;

% Generate 1000 random "reaction times" (normally distributed)
reaction_times = randn(1000, 1) * 50 + 300;  % mean=300ms, std=50ms

figure;
histogram(reaction_times, 30);
hold on;
xline(mean(reaction_times), 'r-', 'LineWidth', 2);
hold off;
xlabel('Reaction Time (ms)');
ylabel('Count');
title('Distribution of Reaction Times');
legend('Data', sprintf('Mean = %.0f ms', mean(reaction_times)));
```

## State of the Art

| Old Approach | Current Approach | When Changed | Impact |
|--------------|------------------|--------------|--------|
| `hist()` for histograms | `histogram()` | R2014b | Better defaults, more options, proper object returned |
| Teaching eigen math first | Visual transformation first | Modern pedagogy | Students understand eigenvalues when they SEE the transformation |
| Separate math and programming courses | Integrated: learn math BY programming it | Course design decision | Immediate visual feedback makes abstract math concrete |
| `xline()` / `yline()` not available | `xline()` and `yline()` available | R2018b | Easy way to add reference lines to plots |

## Open Questions

1. **Module numbering continuation**
   - What we know: Phase 1 produced modules 01 and 02 (directories 01-first-steps and 02-vectors-and-plotting)
   - What's unclear: Should Phase 2 continue with modules 03 and 04?
   - Recommendation: Yes, continue sequential numbering. Module 03 for programming, Module 04 for math foundations.

2. **Depth of eigenvalue treatment**
   - What we know: MATH-04 says "visually" and the success criterion says "directions that survive a transformation." Phase 4 needs eigenvalues for PCA.
   - What's unclear: How much eigenvalue theory is needed now vs. in Phase 4 when PCA actually uses it?
   - Recommendation: Keep it visual and intuitive here. Show the 2D transformation, highlight eigenvectors, explain lambda as "how much it stretches." Save the connection to covariance matrices and PCA for Phase 4.

3. **xline() availability**
   - What we know: `xline()` was introduced in R2018b. NTNU likely has R2024a+.
   - What's unclear: Exact NTNU Matlab version.
   - Recommendation: Use `xline()` -- it has been available for 6+ years. If needed, fall back to `plot([x x], ylim, 'r-')`.

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
| MATL-05 | Function defined and called, returns correct output | manual | Run demo_functions.m, verify output values | Wave 0 |
| MATL-06 | For-loop and while-loop iterate over data correctly | manual | Run demo_loops.m, verify printed output | Wave 0 |
| MATL-07 | If/else conditionals filter data correctly | manual | Run demo_conditionals.m, verify filtered output | Wave 0 |
| MATH-02 | Matrix transformation visualized as before/after | manual | Run demo_matrix_transform.m, inspect quiver plots | Wave 0 |
| MATH-03 | Dot product and matrix multiply computed and explained | manual | Run demo_matrix_transform.m, verify computed values | Wave 0 |
| MATH-04 | Eigenvectors shown as "directions that survive" | manual | Run demo_eigenvalues.m, inspect eigenvector overlay plot | Wave 0 |
| MATH-05 | Histogram of distribution plotted and interpreted | manual | Run demo_statistics.m, inspect histogram figure | Wave 0 |
| MATH-06 | Mean, std, correlation computed and visualized | manual | Run demo_statistics.m, verify computed statistics | Wave 0 |

### Sampling Rate
- **Per task commit:** Run all .m files in the module, verify figures appear without errors
- **Per wave merge:** Run all .m files across all modules, verify no cross-module issues
- **Phase gate:** All demo and solution scripts run clean; exercises run clean when TODOs are filled per solutions

### Wave 0 Gaps
- All content is new -- no existing files. Wave 0 creates the module content.
- Function files (e.g., average_value.m, compute_stats.m) must be in the correct directory for Matlab to find them.
- Validation is manual (run Matlab scripts, inspect output).

## Sources

### Primary (HIGH confidence)
- [MathWorks - Create Functions in Files](https://www.mathworks.com/help/matlab/matlab_prog/create-functions-in-files.html) - function syntax, file naming rules, local functions
- [MathWorks - function reference](https://www.mathworks.com/help/matlab/ref/function.html) - function definition statement
- [MathWorks - Loops and Conditional Statements](https://www.mathworks.com/help/matlab/control-flow.html) - for, while, if/else syntax
- [MathWorks - eig](https://www.mathworks.com/help/matlab/ref/eig.html) - eigenvalue/eigenvector computation
- [MathWorks - Eigenvalues](https://www.mathworks.com/help/matlab/math/eigenvalues.html) - eigenvalue concepts and usage
- [MathWorks - corrcoef](https://www.mathworks.com/help/matlab/ref/corrcoef.html) - correlation coefficient computation
- [MathWorks - cov](https://www.mathworks.com/help/matlab/ref/cov.html) - covariance computation

### Secondary (MEDIUM confidence)
- [Eigenvectors and Eigenvalues explained visually](https://setosa.io/ev/eigenvectors-and-eigenvalues/) - interactive visual explanation
- [GeoGebra - Linear transformations and eigenvectors](https://www.geogebra.org/m/mdvN0HTt) - interactive 2D visualization
- Phase 1 RESEARCH.md and deliverables - established patterns for this project

### Tertiary (LOW confidence)
- Optimal split between programming and math modules -- may need adjustment based on Phase 1 feedback
- Whether learner has seen any linear algebra concepts informally in NEVR3004 lectures

## Metadata

**Confidence breakdown:**
- Standard stack: HIGH - Core Matlab, all functions verified against MathWorks docs
- Architecture: HIGH - Follows established Phase 1 patterns (See-Code-Do, notation bridge, scaffolded exercises)
- Pitfalls: HIGH - Common beginner errors well-documented in MathWorks community
- Math pedagogy: MEDIUM - Visual-first approach for eigenvalues is well-supported but calibration to this specific learner is untested

**Research date:** 2026-03-15
**Valid until:** 2026-04-15 (stable domain, no moving targets)

# Phase 1: Matlab Survival Kit - Research

**Researched:** 2026-03-15
**Domain:** Matlab fundamentals (variables, vectors, matrices, indexing, plotting, scripts) + pedagogical framework establishment
**Confidence:** HIGH

## Summary

Phase 1 covers two interleaved goals: (1) get Christel writing and running Matlab code that produces visual output, and (2) establish the pedagogical pattern (visual-first, scaffolded, chunked) that all future lessons will follow. The Matlab content spans variables, vectors, matrices, basic indexing, .m scripts, and plotting (line plots, scatter, bar, imagesc, quiver for vector arrows). The math content is limited to vectors as arrows with direction and magnitude -- visualized in 2D with `quiver()`.

The technical domain is straightforward: core Matlab with no toolboxes. The real complexity is pedagogical design. Every lesson must produce visual output within the first 5 minutes. Exercises must be 70-80% pre-written with strategic blanks. Content must use relatable analogies from Christel's life (kids Ravn 11 and Helena 8, cat Enzo, gardening, horses). Math notation appears only after the concept has been shown visually and in code ("notation bridge" pattern).

**Primary recommendation:** Build two modules (01-first-steps, 02-vectors-and-plotting) following the See-Code-Do pattern: lesson.md explains one concept with analogy, demo_*.m produces plots immediately, exercise_*.m has TODO blanks for the learner to fill. Every .m file must produce a figure within the first 5-10 lines of execution.

<phase_requirements>
## Phase Requirements

| ID | Description | Research Support |
|----|-------------|-----------------|
| MATL-01 | Create and manipulate variables, vectors, and matrices | Module 01 (variables, scalars) and Module 02 (vectors, matrices). Core Matlab syntax: `[]`, `:`, `linspace()`, `zeros()`, `ones()`, `rand()`. |
| MATL-02 | Use indexing and slicing to access parts of vectors and matrices | Module 02 content. Parenthetical indexing `v(3)`, `M(2,3)`, colon slicing `v(1:5)`, `M(:,2)`, logical indexing. |
| MATL-03 | Write, save, and run .m script files | Module 01 content. Script creation in editor, save, run button or `F5`, `cd` to script directory, `clear`/`clc` at top of scripts. |
| MATL-04 | Create plots (line, scatter, bar, imagesc) with labels and titles | Module 02 content. Functions: `plot()`, `scatter()`, `bar()`, `imagesc()`, `xlabel()`, `ylabel()`, `title()`, `legend()`, `grid on`, `figure()`, `subplot()`. |
| MATH-01 | Understand vectors as arrows/directions, visualize in 2D plots | Module 02 content. Use `quiver()` to draw arrows from origin showing direction and magnitude. Analogy: "vectors are like GPS directions." |
| PEDA-01 | Every lesson produces visual output within first 5 minutes | Structural requirement: every demo_*.m starts with a plot. Exercise templates include pre-written plotting code so learner sees output even before filling blanks. |
| PEDA-02 | Lessons chunked into 15-20 minute segments with clear checkpoints | Each module has 2-3 activities (read lesson, run demo, do exercise) each taking 5-10 minutes. Checkpoint = "run this script, you should see this plot." |
| PEDA-03 | Math introduced visually first, then connected to notation ("notation bridge") | Pattern: show plot of arrows -> explain direction/length in words -> then introduce `v = [3, 4]` notation and `norm(v)` for magnitude. |
| PEDA-04 | Exercises scaffolded (70-80% pre-written, learner fills key parts) | Exercise files use `% TODO:` markers. Provide data loading, figure setup, axis labels. Learner fills the core computation (1-3 lines per TODO). |
| PEDA-05 | Examples use relatable analogies from everyday life and Christel's interests | Use cat weights, garden measurements, horseback riding speeds, family ages. Variable names like `cat_weight`, `garden_lengths`. |
</phase_requirements>

## Standard Stack

### Core
| Library | Version | Purpose | Why Standard |
|---------|---------|---------|--------------|
| Matlab (core) | R2024a+ | Everything | NTNU provides Matlab license. All needed functions are built-in. No toolboxes required for Phase 1. |

### Key Built-in Functions (Phase 1)

**Variables and Arrays:**
| Function | Purpose | Example |
|----------|---------|---------|
| `[]` | Create vectors/matrices | `v = [1 2 3]; M = [1 2; 3 4]` |
| `:` operator | Ranges and slicing | `1:10`, `0:0.1:2*pi`, `v(2:5)` |
| `linspace()` | Evenly spaced vector | `linspace(0, 2*pi, 100)` |
| `zeros()`, `ones()` | Initialized arrays | `zeros(3,3)`, `ones(1,5)` |
| `rand()` | Random numbers | `rand(1,10)` for 10 random values |
| `size()`, `length()` | Array dimensions | `size(M)` returns [rows, cols] |

**Plotting:**
| Function | Purpose | Example |
|----------|---------|---------|
| `plot()` | Line plot | `plot(x, y, 'b-o')` |
| `scatter()` | Scatter plot | `scatter(x, y, 50, 'filled')` |
| `bar()` | Bar chart | `bar(categories, values)` |
| `imagesc()` | Matrix as heatmap | `imagesc(M); colorbar` |
| `quiver()` | Vector arrows | `quiver(0, 0, 3, 4, 0)` |
| `figure()` | New figure window | `figure(1)` |
| `subplot()` | Multiple plots | `subplot(2,2,1)` |
| `xlabel()`, `ylabel()` | Axis labels | `xlabel('Time (s)')` |
| `title()` | Plot title | `title('My First Plot')` |
| `legend()` | Legend | `legend('data', 'fit')` |
| `grid on` | Grid lines | `grid on` |
| `hold on/off` | Overlay plots | `hold on; plot(...); hold off` |
| `axis equal` | Equal axis scaling | Required for correct vector arrow display |

**Script Essentials:**
| Function | Purpose | Example |
|----------|---------|---------|
| `clear` | Clear workspace | Always at top of scripts |
| `clc` | Clear command window | Always at top of scripts |
| `close all` | Close all figures | At top of demo scripts |
| `disp()` | Print text | `disp('Hello Christel!')` |
| `fprintf()` | Formatted print | `fprintf('The answer is %d\n', x)` |
| `%` | Comment | `% This is a comment` |
| `%%` | Section break | Creates runnable sections in editor |

### Alternatives Considered
| Instead of | Could Use | Tradeoff |
|------------|-----------|----------|
| .m scripts | .mlx Live Scripts | .mlx mixes code and output nicely but is less portable, harder to diff in git, and adds complexity. .m is the project decision. |
| `quiver()` | `annotation('arrow', ...)` | annotation works in normalized figure coordinates, harder to teach. quiver uses data coordinates -- much more intuitive. |

## Architecture Patterns

### Recommended Project Structure (Phase 1 Deliverables)
```
matlab-course/
├── 01-first-steps/
│   ├── lesson.md                # Variables, types, workspace, command window
│   ├── demo_hello.m             # First script: prints, creates variables, makes a plot
│   ├── demo_variables.m         # Variables, types, basic arithmetic, vectors intro
│   ├── exercise_variables.m     # Scaffolded practice: create variables, do arithmetic
│   └── solution_variables.m     # Complete solution
├── 02-vectors-and-plotting/
│   ├── lesson.md                # Vectors, matrices, indexing, plotting, vector arrows
│   ├── demo_vectors.m           # Creating vectors, indexing, element-wise operations
│   ├── demo_plotting.m          # Line plots, scatter, bar, labels, subplots
│   ├── demo_vector_arrows.m     # quiver() to visualize 2D vectors as arrows
│   ├── exercise_vectors.m       # Practice: create vectors, index, slice
│   ├── exercise_plotting.m      # Practice: make labeled plots from data
│   ├── solution_vectors.m
│   └── solution_plotting.m
└── reference/
    └── matlab_basics.md         # Quick-lookup: syntax, operators, common functions
```

### Pattern 1: See-Code-Do (Lesson Flow)
**What:** Every concept follows three steps: (1) read the lesson.md explanation with analogy and visuals, (2) run the demo script to see it working, (3) do the exercise to practice.
**When to use:** Every module, every concept.
**Example flow:**
1. lesson.md: "A vector is like a shopping list -- an ordered collection of numbers. Imagine writing down the weights of 5 cats at the vet..."
2. demo_vectors.m: Creates `cat_weights = [4.2, 3.8, 5.1, 3.5, 4.7]`, plots them as a bar chart with labels
3. exercise_vectors.m: "Create a vector of garden plant heights and plot them"

### Pattern 2: Immediate Visual Payoff
**What:** Every .m file produces a plot within the first 5-10 lines of execution. Never make the learner wait through setup code before seeing output.
**When to use:** All demo and exercise scripts.
**Example:**
```matlab
% demo_hello.m - Your first Matlab script!
clear; clc; close all;

% Let's make something happen RIGHT NOW
x = 1:10;
y = x.^2;
plot(x, y, 'ro-', 'LineWidth', 2);
title('Your First Plot - You Made This!');
xlabel('x'); ylabel('x squared');
grid on;

% Now let's understand what we just did...
```

### Pattern 3: Scaffolded Exercise Template
**What:** Exercise files are 70-80% pre-written. The learner fills strategic blanks marked with `% TODO:`. Each TODO has a hint and expected output.
**When to use:** All exercises.
**Example:**
```matlab
% exercise_variables.m - Practice with variables
clear; clc; close all;

% --- Part 1: Create some variables ---

% The cat Enzo weighs 5.2 kg
enzo_weight = 5.2;

% TODO: Create a variable for Ravn's age (he is 11)
% ravn_age = ???

% TODO: Create a variable for Helena's age (she is 8)
% helena_age = ???

% Check your work:
fprintf('Enzo weighs %.1f kg\n', enzo_weight);
% fprintf('Ravn is %d years old\n', ravn_age);    % Uncomment after filling TODO
% fprintf('Helena is %d years old\n', helena_age); % Uncomment after filling TODO

% --- Part 2: Do some math ---
% TODO: Calculate the age difference between Ravn and Helena
% age_diff = ???
% fprintf('Age difference: %d years\n', age_diff);
```

### Pattern 4: Notation Bridge (Math Integration)
**What:** Show the visual first, then the code, then the math notation. Never start with notation.
**When to use:** Whenever introducing a math concept (vectors as arrows in this phase).
**Example sequence:**
1. Show a quiver plot of an arrow pointing right and up
2. "This arrow goes 3 steps right and 4 steps up. In Matlab: `v = [3, 4]`"
3. "The length of this arrow is 5 (remember Pythagoras?). In Matlab: `norm(v)` gives 5"
4. "Mathematicians write this as ||v|| = sqrt(3^2 + 4^2) = 5"

### Anti-Patterns to Avoid
- **Math notation first:** Never show `v in R^n` before showing a plot of arrows. Kills motivation.
- **Long unbroken scripts:** Never write 100+ lines without a `%%` section break or a `figure()` call. The learner must see incremental results.
- **Abstract variable names:** Use `cat_weights` not `x`. Use `plant_heights` not `data`. Context aids memory.
- **Exercises without verification:** Every exercise must print or plot expected output so the learner knows if they got it right.
- **Missing `clear; clc; close all;` at script top:** Leftover variables from previous runs cause confusion. Always start clean.

## Don't Hand-Roll

| Problem | Don't Build | Use Instead | Why |
|---------|-------------|-------------|-----|
| Vector magnitude | Manual sqrt(sum(v.^2)) | `norm(v)` | Built-in, handles edge cases, standard |
| Evenly spaced points | Manual calculation | `linspace(start, stop, n)` | Cleaner, avoids off-by-one |
| Creating ranges | Manual vector entry | `:` operator (e.g., `1:0.5:10`) | Core Matlab idiom |
| Matrix dimensions | Counting manually | `size(M)`, `length(v)` | Always use built-in inspection |
| Plotting arrows | Line segments with manual arrowheads | `quiver(x, y, u, v, 0)` | Proper arrows with heads, auto-scaled |

**Key insight:** Matlab's built-in functions handle the common operations. Teaching `norm()` instead of `sqrt(sum(v.^2))` is not laziness -- it is correct Matlab style and reduces errors.

## Common Pitfalls

### Pitfall 1: Row vs Column Vector Confusion
**What goes wrong:** Learner creates `v = [1 2 3]` (row) but a function expects a column vector, or matrix multiplication fails with dimension mismatch.
**Why it happens:** Matlab defaults to row vectors with space/comma separation. Semicolons create column vectors. The distinction is invisible until an operation fails.
**How to avoid:** Explicitly teach the difference early. Show `v = [1 2 3]` vs `v = [1; 2; 3]`. Show `v'` (transpose). Use `size()` to check. Demo a dimension mismatch error and how to fix it.
**Warning signs:** "Error using *: Inner matrix dimensions must agree"

### Pitfall 2: 1-Based Indexing Surprise
**What goes wrong:** Learner tries `v(0)` expecting the first element (coming from Python or general programming intuition).
**Why it happens:** Most modern languages use 0-based indexing. Matlab uses 1-based.
**How to avoid:** State it explicitly and early: "In Matlab, the first element is v(1), not v(0)." Demo the error message from `v(0)`.
**Warning signs:** "Index must be a positive integer or logical"

### Pitfall 3: Forgetting `hold on` for Overlaying Plots
**What goes wrong:** Second `plot()` call replaces the first plot instead of adding to it.
**Why it happens:** Default Matlab behavior clears the axes on each new `plot()` call.
**How to avoid:** Teach `hold on` / `hold off` pattern explicitly. Show the before (one line) and after (two lines) side by side.
**Warning signs:** "Where did my first plot go?"

### Pitfall 4: Script Not Running (Wrong Directory)
**What goes wrong:** Learner writes a script but gets "Unrecognized function or variable" when trying to run it.
**Why it happens:** Matlab's current directory is not where the script is saved. Matlab only runs scripts on the path.
**How to avoid:** Teach: (1) save the file first, (2) check Current Folder panel in Matlab matches file location, (3) use `cd` if needed. Include this in the first lesson's troubleshooting section.
**Warning signs:** "Undefined function or variable"

### Pitfall 5: Element-wise vs Matrix Operations
**What goes wrong:** `v1 * v2` fails or gives unexpected result when `v1 .* v2` was intended.
**Why it happens:** `*` is matrix multiplication. `.*` is element-wise multiplication. Beginners do not know the distinction.
**How to avoid:** Introduce `.*`, `./`, `.^` explicitly with the dot-prefix rule: "A dot before the operator means do it to each element separately." Demo both and show different results.
**Warning signs:** Dimension errors or unexpected single-number output from what should be element-wise operation.

### Pitfall 6: quiver() Auto-Scaling Distortion
**What goes wrong:** Vector arrows in quiver plot are shortened/lengthened and no longer represent true magnitude.
**Why it happens:** `quiver()` auto-scales arrows by default to prevent overlap.
**How to avoid:** Use `quiver(x, y, u, v, 0)` -- the `0` disables auto-scaling. Also use `axis equal` to maintain aspect ratio.
**Warning signs:** Arrow lengths do not match `norm()` values.

## Code Examples

### Creating Variables and Basic Types
```matlab
% Source: MathWorks official documentation
% Scalars
age = 11;
weight = 5.2;
name = 'Enzo';
is_cat = true;

% Display
disp(age);
fprintf('%s weighs %.1f kg\n', name, weight);
```

### Creating Vectors and Matrices
```matlab
% Source: MathWorks official docs - Basic Matrix Operations
% Row vector
cat_weights = [4.2, 3.8, 5.1, 3.5, 4.7];

% Column vector
temperatures = [18; 21; 19; 22; 20];

% Using colon operator
days = 1:7;            % [1 2 3 4 5 6 7]
t = 0:0.1:2*pi;        % 0 to 2*pi in steps of 0.1

% Using linspace
x = linspace(0, 10, 50);  % 50 points from 0 to 10

% Matrix
M = [1 2 3; 4 5 6; 7 8 9];

% Special matrices
Z = zeros(3, 3);
O = ones(2, 4);
R = rand(3, 3);
```

### Indexing and Slicing
```matlab
% Source: MathWorks official docs
v = [10 20 30 40 50 60 70 80 90 100];

% Single element (1-based!)
first = v(1);      % 10
third = v(3);      % 30

% Slice
first_three = v(1:3);    % [10 20 30]
last_three = v(end-2:end); % [80 90 100]

% Matrix indexing
M = [1 2 3; 4 5 6; 7 8 9];
element = M(2, 3);        % 6 (row 2, column 3)
row2 = M(2, :);           % [4 5 6] (entire row 2)
col1 = M(:, 1);           % [1; 4; 7] (entire column 1)
```

### Basic Plotting with Labels
```matlab
% Source: MathWorks - Add Title and Axis Labels to Chart
clear; clc; close all;

x = linspace(0, 2*pi, 100);
y1 = sin(x);
y2 = cos(x);

figure;
plot(x, y1, 'b-', 'LineWidth', 2);
hold on;
plot(x, y2, 'r--', 'LineWidth', 2);
hold off;

xlabel('Angle (radians)');
ylabel('Value');
title('Sine and Cosine Waves');
legend('sin(x)', 'cos(x)', 'Location', 'southwest');
grid on;
```

### Visualizing 2D Vectors as Arrows (quiver)
```matlab
% Source: MathWorks - quiver documentation
clear; clc; close all;

% Define two vectors
v1 = [3, 4];    % "Walk 3 blocks east, 4 blocks north"
v2 = [-2, 1];   % "Walk 2 blocks west, 1 block north"

figure;
% quiver(startX, startY, directionX, directionY, scale)
% scale=0 disables auto-scaling
quiver(0, 0, v1(1), v1(2), 0, 'b', 'LineWidth', 2);
hold on;
quiver(0, 0, v2(1), v2(2), 0, 'r', 'LineWidth', 2);
hold off;

axis equal;
grid on;
xlim([-4, 5]);
ylim([-1, 6]);
xlabel('East-West');
ylabel('North-South');
title('Vectors as Arrows: Direction and Magnitude');
legend(sprintf('v1: length = %.1f', norm(v1)), ...
       sprintf('v2: length = %.1f', norm(v2)));
```

### Script Template (Standard Header)
```matlab
% script_name.m - Brief description of what this script does
% Part of: Matlab for Computational Neuroscience, Module XX
%
% Run this script to see: [what visual output to expect]
%
clear; clc; close all;

%% Section 1: [Name]
% Explanation of what this section does

% ... code that produces a figure ...

%% Section 2: [Name]
% ... more code ...
```

## State of the Art

| Old Approach | Current Approach | When Changed | Impact |
|--------------|------------------|--------------|--------|
| Teaching Matlab via .mlx Live Scripts | .m scripts for portability | Project decision | Simpler toolchain, git-friendly, works in any editor |
| Math prerequisites first | Math integrated at point of need | Pedagogical research consensus | Better engagement and retention for non-math-background learners |
| Open-ended exercises | Scaffolded fill-in-the-blank | ADHD-informed pedagogy | Prevents blank-page paralysis, maintains engagement |

## Open Questions

1. **Matlab version at NTNU**
   - What we know: NTNU provides Matlab licenses, likely R2024a or R2024b
   - What's unclear: Exact version installed on NTNU computers
   - Recommendation: All Phase 1 content uses core functions stable since R2014. Version does not matter for this phase.

2. **Christel's current Matlab exposure**
   - What we know: She has Matlab installed and is taking NEVR3004
   - What's unclear: Has she already used the Matlab command window? Does she know how to open the editor?
   - Recommendation: Module 01 should start from absolute zero (opening Matlab, identifying panels) to be safe. A learner who already knows this will skim through quickly.

3. **Lesson length calibration**
   - What we know: PEDA-02 says 15-20 minute segments. ADHD research says short chunks.
   - What's unclear: Exact right length for Christel specifically
   - Recommendation: Target 10-15 minutes per activity (read lesson OR run demo OR do exercise). Adjust after Phase 1 based on feedback.

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
| MATL-01 | Variables, vectors, matrices created and manipulated | manual | Run demo_variables.m, check workspace | Wave 0 |
| MATL-02 | Indexing and slicing demonstrated and exercised | manual | Run demo_vectors.m, check output | Wave 0 |
| MATL-03 | .m script created, saved, runs successfully | manual | Run demo_hello.m from editor | Wave 0 |
| MATL-04 | Plots with labels and titles produced | manual | Run demo_plotting.m, inspect figures | Wave 0 |
| MATH-01 | 2D vector arrows visualized, direction/magnitude explained | manual | Run demo_vector_arrows.m, inspect quiver plot | Wave 0 |
| PEDA-01 | Every script produces visual output in first 5 min | manual | Time from F5 to first figure appearing | Wave 0 |
| PEDA-02 | Lessons are 15-20 min chunks | manual | Read-through timing of each lesson.md | Wave 0 |
| PEDA-03 | Math visual before notation | manual | Review lesson.md ordering | Wave 0 |
| PEDA-04 | Exercises are 70-80% scaffolded | manual | Count lines vs TODO lines in exercise files | Wave 0 |
| PEDA-05 | Relatable analogies used | manual | Review variable names and lesson text | Wave 0 |

### Sampling Rate
- **Per task commit:** Run all .m files in the module, verify figures appear without errors
- **Per wave merge:** Run all .m files across all modules, verify no cross-module issues
- **Phase gate:** All demo and solution scripts run clean; all exercises run clean when TODOs are filled per solutions

### Wave 0 Gaps
- All content is new -- no existing files. Wave 0 creates the first module content.
- Validation is manual (run Matlab scripts, inspect output). No automated test framework needed for educational content.

## Sources

### Primary (HIGH confidence)
- [MathWorks - Basic Matrix Operations](https://www.mathworks.com/help/matlab/math/basic-matrix-operations.html) - vectors, matrices, indexing
- [MathWorks - plot](https://www.mathworks.com/help/matlab/ref/plot.html) - 2D line plot documentation
- [MathWorks - quiver](https://www.mathworks.com/help/matlab/ref/quiver.html) - vector arrow plotting
- [MathWorks - Add Title and Axis Labels](https://www.mathworks.com/help/matlab/creating_plots/add-title-axis-labels-and-legend-to-graph.html) - labeling plots
- [MathWorks - Scripts](https://www.mathworks.com/help/matlab/learn_matlab/scripts.html) - writing and running .m files

### Secondary (MEDIUM confidence)
- [MathWorks Teaching Resources](https://github.com/MathWorks-Teaching-Resources) - exercise template patterns
- [Scaffolding in Education](https://www.structural-learning.com/post/scaffolding-in-education-a-teachers-guide) - scaffolding pedagogy patterns
- Project domain research (.planning/research/ARCHITECTURE.md, SUMMARY.md) - course structure and pedagogical patterns

### Tertiary (LOW confidence)
- Optimal lesson length for this specific learner -- needs calibration after Phase 1 delivery

## Metadata

**Confidence breakdown:**
- Standard stack: HIGH - Core Matlab, no ambiguity, verified against MathWorks docs
- Architecture: HIGH - Folder structure and file patterns established in domain research, well-proven educational pattern
- Pitfalls: HIGH - Common Matlab beginner errors are extensively documented in MathWorks community and teaching resources
- Pedagogy: HIGH - ADHD-informed scaffolding and visual-first patterns well-supported by research; specific calibration to Christel is MEDIUM

**Research date:** 2026-03-15
**Valid until:** 2026-04-15 (stable domain, no moving targets)

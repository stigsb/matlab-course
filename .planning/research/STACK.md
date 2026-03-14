# Technology Stack

**Project:** Matlab for Computational Neuroscience (NEVR3004 prep)
**Researched:** 2026-03-14

## Recommended Stack

### Core Platform

| Technology | Version | Purpose | Why |
|------------|---------|---------|-----|
| Matlab | R2024b+ (NTNU license) | All coding and visualization | Required by NEVR3004; NTNU provides campus license. Use whatever version NTNU's license server offers. |
| Plain .m scripts | N/A | Course lesson files | Decision already made in PROJECT.md. Git-friendly, portable, works in any editor. No .mlx binary format headaches. |
| Markdown (.md) | N/A | Written explanations, lesson text | Pairs with .m scripts. Readable anywhere, lightweight, version-controllable. |

### Matlab Toolboxes

**Important:** NEVR3004 is a course for neuroscience students, not Matlab power users. Most topics can be taught with core Matlab. Avoid toolbox dependencies where built-in functions suffice.

| Toolbox | Required? | Purpose | Why |
|---------|-----------|---------|-----|
| **None (core Matlab)** | YES | Vectors, matrices, plotting, basic programming | Core Matlab covers 90% of NEVR3004 needs: plot(), subplot(), eig(), cov(), mean(), std(), hist(), imagesc(), rand(), randn() |
| Statistics and Machine Learning Toolbox | NICE-TO-HAVE | PCA via `pca()`, distribution fitting | The `pca()` function is convenient, but PCA can be taught from scratch using `eig()` and `cov()` on the covariance matrix. Teaching it manually is actually better pedagogy for this learner. Use toolbox only if already available. |
| Signal Processing Toolbox | NO | Spectral analysis, filtering | NEVR3004 does not focus on signal processing. Overkill for this course. |
| Deep Learning Toolbox | NO | Neural networks (ML sense) | NEVR3004 is computational neuroscience, not machine learning. Explicitly out of scope per PROJECT.md. |
| Image Processing Toolbox | NO | Image analysis | Not relevant to NEVR3004 topics. |
| Symbolic Math Toolbox | NO | Symbolic computation | Would add complexity. Better to teach math numerically and visually. |

**Confidence: HIGH** -- The NEVR3004 course description focuses on neural coding/decoding, information theory, dimensionality reduction, and attractor networks. All of these can be implemented with core Matlab functions.

### Key Matlab Functions by Topic

#### Matlab Fundamentals
| Function | Purpose | Lesson Context |
|----------|---------|----------------|
| `plot()`, `subplot()`, `figure()` | 2D plotting | Every lesson -- visual-first approach |
| `imagesc()`, `colorbar()` | Matrix visualization | Visualizing weight matrices, correlation matrices |
| `xlabel()`, `ylabel()`, `title()`, `legend()` | Plot labeling | Making plots self-documenting |
| `linspace()`, `zeros()`, `ones()`, `rand()`, `randn()` | Creating vectors/matrices | Building data and model parameters |
| `size()`, `length()`, `numel()` | Inspecting data | Debugging and understanding data shapes |

#### Linear Algebra (for dimensionality reduction, attractor networks)
| Function | Purpose | Lesson Context |
|----------|---------|----------------|
| `*` (matrix multiply) | Matrix multiplication | Core operation for neural network models |
| `'` (transpose) | Matrix transpose | Data manipulation, network weight matrices |
| `eig()` | Eigenvalue decomposition | PCA from scratch, stability analysis of attractor networks |
| `cov()` | Covariance matrix | PCA, neural population analysis |
| `inv()` | Matrix inverse | Understanding least squares, network dynamics |
| `dot()` | Dot product | Neural coding, similarity measures |
| `norm()` | Vector/matrix norms | Distance measures, normalization |

#### Statistics (for neural data analysis, information theory)
| Function | Purpose | Lesson Context |
|----------|---------|----------------|
| `mean()`, `std()`, `var()` | Descriptive statistics | Spike rate analysis, firing rate distributions |
| `histogram()`, `histcounts()` | Distribution visualization | Spike count distributions, tuning curves |
| `corrcoef()` | Correlation | Noise correlations, signal correlations |
| `log2()` | Logarithm base 2 | Information theory: entropy, mutual information |
| `cumsum()` | Cumulative sum | Random walks, integration models |

#### Simulation and Modeling (for attractor networks)
| Function | Purpose | Lesson Context |
|----------|---------|----------------|
| `for`/`while` loops | Time-stepping simulations | Simulating network dynamics over time |
| `tanh()`, `exp()` | Activation functions | Transfer functions in neural network models |
| `ode45()` | ODE solver | Continuous-time network dynamics (if needed) |
| Anonymous functions `@(x)` | Inline function definitions | Defining activation functions, rate models |

#### Data I/O
| Function | Purpose | Lesson Context |
|----------|---------|----------------|
| `load()`, `save()` | Load/save .mat files | Working with provided neural datasets |
| `csvread()` / `readmatrix()` | Load CSV data | Alternative data formats |

### Reference Materials

#### Primary Textbook (NEVR3004 reference)

| Resource | Author(s) | Why |
|----------|-----------|-----|
| **Neural Networks and Brain Function** | Rolls & Treves (1998, Oxford UP) | Referenced directly in NEVR3004 prerequisites (appendices A1-A2 for math background). Covers autoassociation, pattern association, attractor networks -- the exact models NEVR3004 teaches. This is the course's theoretical backbone. |

**Confidence: HIGH** -- NTNU's NEVR3004 page explicitly references appendices from this book for prerequisite math knowledge.

#### Supplementary Textbooks

| Resource | Author(s) | Why | When to Use |
|----------|-----------|-----|-------------|
| **Matlab for Neuroscientists** (2nd ed.) | Wallisch et al. (2014, Academic Press) | The standard Matlab-in-neuroscience textbook. Covers data analysis, visualization, and modeling with Matlab code examples. | Reference for Matlab patterns and idioms. Cherry-pick examples, don't follow sequentially. |
| **An Introductory Course in Computational Neuroscience** | Paul Miller (2018, MIT Press) | Matlab-based tutorials covering neural models, network dynamics, with freely available code. | Source of simulation exercises. Closest match to NEVR3004 modeling topics. |
| **Theoretical Neuroscience** | Dayan & Abbott (2001, MIT Press) | The canonical computational neuroscience textbook. Covers neural coding, information theory, network models mathematically. | Reference for theory. Too math-heavy to use directly, but good for understanding what to simplify. |

**Confidence: MEDIUM** -- These are the standard textbooks in the field. However, NEVR3004's actual assigned readings may differ; course materials are listed as "to be announced."

#### Free Online Resources

| Resource | URL | Why | When to Use |
|----------|-----|-----|-------------|
| MathWorks Onramp (free) | mathworks.com/learn/tutorials/matlab-onramp.html | Interactive 2-hour Matlab intro, free with MathWorks account | Quick-start if she needs to get oriented in the IDE |
| Neuromatch Academy CompNeuro | compneuro.neuromatch.io | Open-access computational neuroscience course with tutorials on PCA, neural coding, information theory | Conceptual reference (note: uses Python, not Matlab -- adapt concepts only) |
| Information Theory in Neuroscience Tutorial | doi.org/10.1523/ENEURO.0052-18.2018 | Published tutorial with Matlab toolbox for computing entropy and mutual information | Direct resource for the information theory module |
| UCL Intro to Matlab | (linked from NEVR3004 page) | Basic Matlab skills, recommended by NEVR3004 itself | Supplementary self-study |

**Confidence: HIGH** -- These are established, free resources. The Information Theory tutorial includes a Matlab toolbox (Neuroscience Information Theory Toolbox) that could be directly useful.

### Course Material Format

| Component | Format | Purpose |
|-----------|--------|---------|
| Lesson text | Markdown (.md) | Explanations, analogies, context. Rendered nicely on GitHub or any markdown viewer. |
| Code exercises | Plain Matlab scripts (.m) | Runnable, modifiable code. Heavily commented with `%` for inline explanations. |
| Data files | .mat files | Pre-built datasets for exercises (synthetic neural data, etc.) |
| Figures | Generated by scripts (not static images) | Every script produces its own visualizations. She runs it, she sees it. |

#### Script Structure Convention

Each .m lesson script should follow this pattern:
```matlab
%% Lesson Title
% Brief description of what this lesson covers

%% Section 1: Concept Name
% Explanation in comments (keep it short, conversational)
% ...

% Code that demonstrates the concept
x = linspace(0, 2*pi, 100);
y = sin(x);
plot(x, y);
title('A sine wave - the building block of signals');

%% Section 2: Next Concept
% ...
```

Using `%%` section breaks allows running sections independently in Matlab (Ctrl+Enter on a section). This supports the small-chunk, quick-win learning style.

## Alternatives Considered

| Category | Recommended | Alternative | Why Not |
|----------|-------------|-------------|---------|
| Script format | .m scripts | .mlx Live Scripts | PROJECT.md already decided: .m for portability, git-friendliness, simpler toolchain. Live Scripts are nice but add complexity and binary format headaches. |
| Language | Matlab | Python | NEVR3004 uses Matlab. Non-negotiable. |
| Math teaching | Integrated into code | Separate math primer | PROJECT.md decided: math in context, not separate. Matches ADHD-friendly chunked approach. |
| PCA implementation | Manual (eig + cov) | `pca()` from Stats Toolbox | Teaching the manual approach builds understanding. Toolbox function is a black box. Can mention `pca()` as "the shortcut" after understanding. |
| Visualization | Built-in plot functions | Third-party viz libraries | Core Matlab plotting is sufficient and exactly what NEVR3004 expects. No extra dependencies. |
| IDE | Matlab Desktop | VS Code + Matlab extension | Matlab Desktop is what NEVR3004 assumes. Integrated variable browser and plot windows are invaluable for a visual learner. |

## What NOT to Use

| Technology | Why Not |
|------------|---------|
| Simulink | Overkill. NEVR3004 doesn't use it. Adds massive complexity. |
| Deep Learning Toolbox | Wrong domain. NEVR3004 is computational neuroscience, not ML. |
| .mlx Live Scripts | Binary format, poor git support, fragile. Already decided against in PROJECT.md. |
| Python | NEVR3004 uses Matlab. Period. |
| Jupyter/MATLAB kernel | Adds toolchain complexity. Plain .m scripts are simpler and more portable. |
| Symbolic Math Toolbox | Math should be taught numerically and visually, not symbolically. Symbolic math adds cognitive load without payoff for this learner. |
| App Designer / GUIs | Christel needs to write and understand scripts, not build apps. |

## Installation

```bash
# No command-line installation needed.
# Matlab is installed and licensed through NTNU's campus license.
#
# Verify she has:
# 1. Matlab installed (any recent version, R2023b+ is fine)
# 2. NTNU license activated
# 3. The Matlab Desktop (not Matlab Online, unless preferred)
#
# Check available toolboxes in Matlab:
#   >> ver
#
# Core Matlab is sufficient. If Statistics Toolbox is available, great.
# If not, no problem -- we teach PCA manually.
```

## Sources

- [NTNU NEVR3004 Course Page](https://www.ntnu.edu/studies/courses/NEVR3004) -- Course description, prerequisites, recommended resources
- [Neural Networks and Brain Function (Oxford Academic)](https://academic.oup.com/book/4417) -- Referenced by NEVR3004 for prerequisite math
- [Matlab for Neuroscientists (MathWorks listing)](https://www.mathworks.com/academia/books/matlab-for-neuroscientists-wallisch.html) -- Standard Matlab-neuro textbook
- [An Introductory Course in Computational Neuroscience (MIT Press)](https://mitpress.mit.edu/9780262038256/) -- Matlab-based comp neuro textbook with free code
- [Theoretical Neuroscience (MIT Press)](https://mitpress.mit.edu/9780262041997/theoretical-neuroscience/) -- Canonical theory reference
- [Neuromatch Academy Computational Neuroscience](https://compneuro.neuromatch.io/) -- Open-access tutorials (Python, adapt concepts)
- [Information Theory in Neuroscience Tutorial (eNeuro)](https://www.eneuro.org/content/5/3/ENEURO.0052-18.2018) -- Matlab toolbox for entropy/mutual information
- [MathWorks: Neuroscience Solutions](https://www.mathworks.com/solutions/neuroscience.html) -- Toolbox overview
- [MathWorks: When to use script vs live script](https://www.mathworks.com/matlabcentral/discussions/tips/841861-when-to-use-a-script-vs-a-live-script) -- Format decision rationale
- [MathWorks: pca function](https://www.mathworks.com/help/stats/pca.html) -- PCA toolbox function reference

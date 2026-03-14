# Feature Landscape

**Domain:** Computational neuroscience education (personalized Matlab course)
**Target course:** NEVR3004 Neural Networks, NTNU (exam June 5, 2026)
**Researched:** 2026-03-14

## Table Stakes

Features that are non-negotiable for NEVR3004 success. Without these, Christel cannot pass the exam.

### Matlab Fundamentals

| Feature | Why Expected | Complexity | Notes |
|---------|--------------|------------|-------|
| Variables, vectors, matrices | Foundation for everything else in Matlab | Low | Start here day 1 |
| Indexing and slicing | Neural data is arrays; can't work without this | Low | Visual: highlight which elements get selected |
| Basic plotting (plot, scatter, bar, histogram) | NEVR3004 requires data visualization; exam is pen-and-paper but understanding plots is core | Low | This is the hook -- immediate visual payoff |
| Functions and scripts | Course assignments require writing and modifying code | Med | .m files only, no .mlx |
| Loops and conditionals | Needed for simulations and data processing | Med | Show loop execution visually with animations |
| Loading and saving data | Neural data analysis requires reading data files | Low | Use realistic but small datasets |

### Math Foundations (Taught In Context)

| Feature | Why Expected | Complexity | Notes |
|---------|--------------|------------|-------|
| Vectors and dot products | Neural coding uses population vectors; dot product is everywhere in neural models | Med | Visualize as arrows, show geometric meaning |
| Matrix multiplication | Core to understanding neural network models, transformations | Med | Animate row-by-column with visual grids |
| Eigenvalues and eigenvectors (conceptual) | Needed for PCA/dimensionality reduction | High | Focus on geometric intuition: stretch directions |
| Probability distributions | Neural firing is probabilistic; Poisson process, Gaussian | Med | Plot distributions, sample from them, see variability |
| Basic statistics (mean, variance, covariance) | Data analysis and neural variability | Low | Compute on real-ish neural data |
| Derivatives as rate of change | Membrane potential dynamics, learning rules | Med | Visualize as slope of tangent line, animate |
| Exponentials and decay | Time constants, membrane equation, firing rate adaptation | Med | Plot exponential curves, relate to physical intuition (hot coffee cooling) |
| Summation notation (sigma) | Reading equations in Dayan & Abbott and lecture slides | Low | Translate notation to Matlab for loops/sum() |

### NEVR3004 Core Topics

| Feature | Why Expected | Complexity | Notes |
|---------|--------------|------------|-------|
| Neural coding: tuning curves | How neurons represent stimuli; foundational concept | Med | Plot firing rate vs. stimulus, fit curves |
| Neural coding: population coding | How populations of neurons encode information together | Med | Visualize population vectors, cosine tuning |
| Neural decoding: Bayesian basics | Estimating stimulus from neural activity | High | Prior * likelihood; visualize with plots |
| Information theory: entropy | Quantifying uncertainty in neural responses | High | Start with coin flips, build to spike trains |
| Information theory: mutual information | How much does neural activity tell us about stimulus? | High | Venn diagram intuition, compute on examples |
| Dimensionality reduction: PCA | Extracting structure from high-dimensional neural data | High | 2D->1D visual first, then extend to neural data |
| Attractor networks: concept | Memory as stable states in recurrent networks | High | Energy landscape visualization, ball-in-valley |
| Attractor networks: Hopfield-style | Storing and retrieving patterns | High | Animate pattern completion |
| Attractor networks: continuous (ring/bump) | Head direction cells, spatial navigation | High | Animate bump of activity moving on a ring |
| Neural data analysis workflow | Loading, preprocessing, visualizing neural recordings | Med | Step-by-step with real-format data |

### Exam Preparation

| Feature | Why Expected | Complexity | Notes |
|---------|--------------|------------|-------|
| Equation reading skills | 4-hour written exam; must read and interpret math notation | Med | Practice translating equations to Matlab and back |
| Conceptual summary sheets | Quick-reference for each major topic | Low | One page per topic, visual layout |
| Practice problems (pen and paper) | Exam is written, no computer | Med | Work through calculations by hand, verify with Matlab |

## Differentiators

Features that address Christel's specific learning profile. Not required by NEVR3004 directly, but dramatically increase the probability of success.

### Visual-First Pedagogy

| Feature | Value Proposition | Complexity | Notes |
|---------|-------------------|------------|-------|
| Every concept gets a plot or animation | Visual thinker -- abstract concepts only click when seen | Med | Non-negotiable design principle, not a separate feature |
| Animated simulations (.m scripts) | See dynamics unfold over time instead of static equations | Med | Use Matlab's drawnow/pause for frame-by-frame |
| Color-coded matrix operations | Matrix math is opaque without visual structure | Low | Use imagesc, color grids |
| Interactive parameter exploration | Change a value, see what happens immediately | Med | Scripts with clearly marked "try changing this" sections |
| Geometric intuition before algebra | Show the shape of an idea before the formula | Low | 3Blue1Brown-inspired approach |
| Before/after comparison plots | Show effect of operations (e.g., PCA before/after) | Low | Side-by-side subplot layout |

### ADHD-Friendly Structure

| Feature | Value Proposition | Complexity | Notes |
|---------|-------------------|------------|-------|
| 15-20 minute lesson chunks | Matches attention cycles; prevents overwhelm | Low | Design constraint, not a feature to build |
| Quick wins in every lesson | Early dopamine hit from seeing something work | Low | First exercise in each lesson should run and produce output in < 2 minutes |
| Progressive complexity within lessons | Start trivially simple, add one thing at a time | Low | "Now try this" incremental steps |
| Clear "what you'll be able to do" at lesson start | Motivation and expectation setting | Low | One sentence, concrete outcome |
| Minimal prerequisites per lesson | Each lesson should be as self-contained as possible | Med | Reduces decision paralysis about "which lesson next" |
| Checkpoint exercises (not graded) | Verify understanding without stress | Low | "Can you modify this to do X?" |
| Relatable analogies from everyday life | Cats, gardening, kids, music -- connect abstract to familiar | Low | Per PROJECT.md context |

### Math Bridge Content

| Feature | Value Proposition | Complexity | Notes |
|---------|-------------------|------------|-------|
| "Math moment" mini-sections | Just-in-time math when a concept requires it | Med | Embedded in lessons, not separate |
| Visual proof before formal proof | Show WHY something works with pictures first | Med | e.g., why dot product measures similarity -- arrow diagram |
| Notation decoder | Translate math symbols to English and Matlab | Low | Recurring reference: "sigma means sum(), which in Matlab is..." |
| Scaffolded formula building | Build complex formulas from simple pieces | Med | Start with parts, combine step by step |
| "Why this math matters here" context | Motivation for each math concept | Low | One sentence connecting math to neuroscience question |

## Anti-Features

Features to explicitly NOT build. These would waste time, add complexity, or harm the learning experience.

| Anti-Feature | Why Avoid | What to Do Instead |
|--------------|-----------|-------------------|
| Video lectures | Time-intensive to produce; text + scripts are faster to create and iterate; she can re-read but not easily re-watch at her own pace | Written lessons with runnable .m scripts |
| Comprehensive textbook coverage | She needs to pass NEVR3004, not become a Matlab expert; scope creep kills momentum | Cover exactly what NEVR3004 requires, nothing more |
| Separate math course/module | Math taught in isolation loses context and motivation; she'll disengage | Integrate math into the neuroscience lessons where it's needed |
| Deep learning / modern ML | NEVR3004 is computational neuroscience, not machine learning; CNNs/transformers are out of scope | Stay focused on classical neural network models (Hopfield, ring attractors) |
| Matlab toolbox dependencies | Adds installation complexity; NTNU license may not include all toolboxes | Use base Matlab + Statistics toolbox only |
| .mlx Live Scripts | Ties content to Matlab editor; less portable; harder to version control | Plain .m scripts + markdown |
| Automated grading/testing | She's the only student; overhead of test infrastructure is pure waste | Checkpoint exercises with expected output shown |
| Exhaustive error handling in scripts | She's learning science, not software engineering | Keep scripts clean and simple; comment what might go wrong |
| Long unbroken theory sections | ADHD + visual learner = walls of text are actively harmful | Max 3-4 paragraphs before a code block or plot |
| Competitive/timed exercises | Pressure and time constraints exacerbate ADHD challenges | Self-paced, low-stakes practice |
| References to reduced capacity or ADHD in materials | Per constraints -- sensitivity requirement | Design for the learning style without labeling it |

## Feature Dependencies

```
Matlab Fundamentals (variables, vectors, matrices)
  |
  +-> Basic plotting
  |     |
  |     +-> Tuning curves
  |     +-> Probability distributions (visual)
  |     +-> Every subsequent topic (plots are universal)
  |
  +-> Functions and scripts
  |     |
  |     +-> Neural data analysis workflow
  |     +-> All simulation exercises
  |
  +-> Loops and conditionals
        |
        +-> Animated simulations
        +-> Neural network models

Math: Vectors and dot products
  |
  +-> Matrix multiplication
  |     |
  |     +-> Eigenvalues/eigenvectors (conceptual)
  |           |
  |           +-> PCA / dimensionality reduction
  |
  +-> Population coding (neural vectors)
  +-> Attractor networks (weight matrices)

Math: Probability and statistics
  |
  +-> Neural coding (Poisson firing, variability)
  +-> Bayesian decoding (prior * likelihood)
  +-> Information theory (entropy, mutual information)

Math: Derivatives and exponentials
  |
  +-> Membrane equation basics
  +-> Learning rules (if covered)
  +-> Rate of change in neural dynamics
```

## MVP Recommendation

Given the urgency (course already underway, exam June 5, 2026), prioritize ruthlessly:

### Phase 1: Matlab + First Neuroscience Win (immediate)
1. Matlab fundamentals (variables, vectors, matrices, indexing)
2. Plotting (this is the visual payoff that hooks engagement)
3. Tuning curves (first real neuroscience concept; uses only arrays + plotting)

### Phase 2: Math Foundations + Neural Coding (weeks 1-2)
4. Vectors, dot products, matrix multiplication (with visual animations)
5. Probability and statistics basics
6. Population coding and neural coding concepts
7. Functions, loops, conditionals (as needed for exercises)

### Phase 3: Information Theory + Decoding (weeks 3-4)
8. Entropy and mutual information
9. Bayesian decoding basics
10. Derivatives and exponentials (as needed for dynamics)

### Phase 4: Dimensionality Reduction + Attractors (weeks 4-6)
11. PCA (requires eigenvalue intuition)
12. Attractor networks (Hopfield, ring/bump)
13. Neural data analysis workflow

### Phase 5: Exam Prep (final weeks)
14. Equation reading and pen-and-paper practice
15. Conceptual summary sheets
16. Practice problems mirroring exam format

**Defer:** Nothing from table stakes can be deferred -- the exam covers all of it. The differentiators (visual-first, ADHD-friendly structure, math bridge) are not separate phases but design principles applied to every lesson.

## Sources

- [NTNU NEVR3004 Course Page](https://www.ntnu.edu/studies/courses/NEVR3004)
- [NYU Computational Neuroscience Syllabus Fall 2025](https://www.cns.nyu.edu/~david/courses/compNeuro/syllabus2025.html)
- [Coursera Computational Neuroscience](https://www.coursera.org/learn/computational-neuroscience)
- [INCF Essentials of Neuroscience with MATLAB](https://training.incf.org/collection/essentials-neuroscience-matlab)
- [Matlab for Neuroscientists (textbook)](https://www.sciencedirect.com/book/9780123745514/matlab-for-neuroscientists)
- [An Introductory Course in Computational Neuroscience (MathWorks)](https://www.mathworks.com/academia/books/an-introductory-course-in-computational-neuroscience-miller.html)
- [Information Theory Tutorial in Neuroscience (eNeuro)](https://www.eneuro.org/content/5/3/ENEURO.0052-18.2018)
- [Dayan & Abbott - Theoretical Neuroscience (MIT Press)](https://mitpress.mit.edu/9780262041997/theoretical-neuroscience/)
- [UDL for Children with ADHD (PMC)](https://pmc.ncbi.nlm.nih.gov/articles/PMC10453933/)
- [Active Learning for STEM Majors with ADHD (CBE-LSE)](https://www.lifescied.org/doi/10.1187/cbe.21-12-0329)
- [Math Is Visual](https://mathisvisual.com/)
- [Computational Neuroscience Course on MATLAB Central](https://www.mathworks.com/matlabcentral/fileexchange/90491-computational-neuroscience-course)

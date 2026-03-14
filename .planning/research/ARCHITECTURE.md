# Architecture Research

**Domain:** Self-paced computational neuroscience course (Matlab + math foundations)
**Researched:** 2026-03-14
**Confidence:** HIGH

## System Overview

This is not a software system -- it is an educational course. The "architecture" defines the component types (what kinds of materials exist), their internal structure (what each lesson/exercise looks like), the learning progression (what depends on what), and the folder organization.

```
┌─────────────────────────────────────────────────────────────┐
│                    Course Materials                          │
├─────────────────────────────────────────────────────────────┤
│  ┌───────────┐  ┌───────────┐  ┌───────────┐               │
│  │  Modules  │  │ Reference │  │   Data    │               │
│  │  (01-10)  │  │  Sheets   │  │   Files   │               │
│  └─────┬─────┘  └───────────┘  └───────────┘               │
│        │                                                    │
│  Per module:                                                │
│  ┌───────────┐  ┌───────────┐  ┌───────────┐               │
│  │  Lesson   │  │ Exercise  │  │ Solutions │               │
│  │  (.md)    │  │  (.m)     │  │   (.m)    │               │
│  └───────────┘  └───────────┘  └───────────┘               │
│  ┌───────────┐                                              │
│  │  Demo     │                                              │
│  │  (.m)     │                                              │
│  └───────────┘                                              │
└─────────────────────────────────────────────────────────────┘
```

## Component Types

| Component | Format | Purpose | Typical Length |
|-----------|--------|---------|---------------|
| Lesson | Markdown (.md) | Explain one concept with visuals, analogies, and examples | 300-600 words (5-10 min read) |
| Demo script | Matlab (.m) | Runnable code that produces plots/animations demonstrating the concept | 30-80 lines with heavy comments |
| Exercise | Matlab (.m) | Fill-in-the-blank or guided coding tasks the learner completes | 20-60 lines with TODO markers |
| Solution | Matlab (.m) | Complete working version of the exercise | Same as exercise |
| Reference sheet | Markdown (.md) | Quick-lookup cheat sheet for syntax, functions, or math formulas | 1-2 pages |
| Data file | .mat or .csv | Sample neural data for analysis exercises | Variable |

### Component Design Principles

**Lessons (Markdown):**
- One concept per lesson, never two
- Start with a concrete analogy or everyday example
- Show the math notation, then immediately show the Matlab code that implements it
- Include at least one figure description or reference to the demo script's output
- End with a "Try it" prompt pointing to the exercise
- No walls of text -- use headers, bullet points, and code blocks to break up content

**Demo Scripts (.m):**
- Self-contained: run the script, get plots
- Heavy commenting that mirrors the lesson text
- Use `figure()` and `subplot()` to produce clear, labeled visualizations
- Include `pause` or section breaks (`%%`) so the learner can step through
- Use Christel's context for variable naming where natural (e.g., `cat_weights` not `abstract_vector_x`)

**Exercises (.m):**
- Scaffolded: provide the structure, leave strategic blanks
- Mark blanks with `% TODO: ...` comments explaining what to fill in
- Include verification: after each TODO, print expected output or plot expected result
- Progressive difficulty within each exercise (easy first tasks, harder later ones)
- 3-5 TODOs per exercise (keeps scope manageable)

**Reference Sheets:**
- One per major topic area (Matlab basics, plotting, linear algebra, statistics)
- Organized as lookup tables, not tutorials
- Include both the math notation and the Matlab function side by side

## Recommended Folder Structure

```
matlab-course/
├── 01-first-steps/
│   ├── lesson.md              # What is Matlab? Variables and the command window
│   ├── demo_variables.m       # Runnable demo showing variables, basic operations
│   ├── exercise_variables.m   # Fill-in-the-blank practice
│   └── solution_variables.m   # Complete solution
├── 02-vectors-and-plotting/
│   ├── lesson.md
│   ├── demo_vectors.m
│   ├── demo_plotting.m
│   ├── exercise_vectors.m
│   └── solution_vectors.m
├── 03-matrices/
│   ├── lesson.md
│   ├── demo_matrices.m
│   ├── exercise_matrices.m
│   └── solution_matrices.m
├── ...
├── reference/
│   ├── matlab_basics.md       # Quick syntax reference
│   ├── plotting_guide.md      # Common plot types and customization
│   ├── linear_algebra.md      # Math notation <-> Matlab functions
│   └── statistics.md          # Stats functions reference
├── data/
│   ├── sample_spikes.mat      # Example neural spike data
│   ├── sample_tuning.mat      # Tuning curve data
│   └── ...
└── README.md                  # Course overview and how to use
```

### Structure Rationale

- **Numbered module folders:** Explicit ordering makes progression obvious. Learner always knows where they are and what comes next.
- **Consistent file naming within modules:** `lesson.md`, `demo_*.m`, `exercise_*.m`, `solution_*.m` -- predictable pattern reduces cognitive load.
- **Separate `reference/` folder:** Reference sheets are not sequential learning material. They are lookup resources that span multiple modules.
- **Separate `data/` folder:** Shared data files used across multiple modules. Avoids duplication.
- **No deep nesting:** Everything is one level deep. Matlab's path management is simpler this way, and the learner never gets lost in subdirectories.

## Learning Progression

### Dependency Graph

```
Module 1: First Steps (variables, types, basic operations)
    │
    ▼
Module 2: Vectors and Plotting (arrays, indexing, basic plots)
    │
    ├──────────────────────────┐
    ▼                          ▼
Module 3: Matrices             Module 4: Programming
(2D arrays, matrix ops,        (functions, loops,
 intro linear algebra)         conditionals, scripts)
    │                          │
    ├──────────────────────────┘
    ▼
Module 5: Statistics and Data (mean, std, histograms, loading data)
    │
    ▼
Module 6: Neural Coding (spike trains, firing rates, tuning curves)
    │
    ├──────────────────────────┐
    ▼                          ▼
Module 7: Information Theory   Module 8: Dimensionality
(entropy, mutual info,         Reduction (PCA, eigenvalues,
 probability basics)           high-dim data)
    │                          │
    ├──────────────────────────┘
    ▼
Module 9: Attractor Networks (recurrent networks, memory, navigation)
    │
    ▼
Module 10: Neural Data Analysis (real data workflows, putting it all together)
```

### Progression Rationale

1. **Modules 1-2** are pure Matlab fundamentals. No neuroscience yet. The goal is to get comfortable with the tool and see immediate visual results (plots). This is where quick wins build confidence.

2. **Modules 3-4** can be done in either order or interleaved. Matrices introduce linear algebra concepts visually (transformations as stretching/rotating). Programming introduces control flow needed for simulations.

3. **Module 5** bridges Matlab skills and neuroscience. Statistics is the connective tissue -- you need means, distributions, and hypothesis testing to do any neural data analysis. This is also where calculus concepts (rate of change) get introduced via derivatives of data.

4. **Module 6** is the first NEVR3004-specific module. Neural coding (spike trains, firing rates, tuning curves) is the entry point to computational neuroscience and uses all prior skills.

5. **Modules 7-8** cover the two major theoretical pillars of NEVR3004. Information theory needs probability (from Module 5). Dimensionality reduction needs linear algebra (from Module 3). These are independent of each other.

6. **Module 9** (attractor networks) builds on everything -- matrix operations for network weights, programming for simulations, statistics for analysis.

7. **Module 10** is a capstone: work with real neural data using all accumulated skills.

### Math Integration Points

Math is never taught as a standalone topic. It is introduced at the moment of need:

| Math Concept | Introduced In | Context |
|--------------|---------------|---------|
| Vectors as lists of numbers | Module 2 | Representing time series, sensor readings |
| Dot product | Module 3 | Similarity between neural response patterns |
| Matrix multiplication | Module 3 | Transforming data, network connectivity |
| Eigenvalues/eigenvectors | Module 8 | PCA -- "which directions matter most in data" |
| Mean, variance, std | Module 5 | Summarizing neural firing rates |
| Probability distributions | Module 5 | What firing rate distributions look like |
| Derivatives | Module 5 | Rate of change in neural signals |
| Entropy | Module 7 | How much information does a neuron carry? |
| Logarithms | Module 7 | Used in entropy/information calculations |
| Bayes' theorem | Module 6 | Neural decoding -- inferring stimulus from spikes |

## Pedagogical Patterns

### Pattern 1: See-Code-Do

**What:** Every concept follows a three-step pattern: (1) read the explanation with visuals in the lesson, (2) run the demo script to see it working, (3) do the exercise to practice it yourself.
**When to use:** Every module, every concept.
**Trade-offs:** Predictable structure helps ADHD-friendly pacing. May feel repetitive, but repetition is the point.

### Pattern 2: Scaffolded Exercises

**What:** Exercises provide 70-80% of the code already written. The learner fills in the critical 20-30% -- the part that demonstrates understanding. Include verification (expected output printed or plotted) so the learner gets immediate feedback.
**When to use:** All exercises, especially early modules.
**Trade-offs:** More scaffolding means less open-ended problem solving, but it prevents the "blank page paralysis" that kills motivation. Later modules can reduce scaffolding progressively.

### Pattern 3: Concrete Before Abstract

**What:** Always show the concrete example first, then name the abstract concept. Show a plot of cat weights as a bar chart, then say "this is a vector." Show spike counts across trials, then introduce "mean and variance."
**When to use:** Especially for math concepts. Critical for a learner without strong math background.
**Trade-offs:** Takes more lesson space. Worth it for comprehension.

### Pattern 4: Running Examples

**What:** Use a small set of recurring examples/datasets across modules so the learner builds familiarity. A set of simulated spike trains introduced in Module 6 gets reused for information theory in Module 7 and dimensionality reduction in Module 8.
**When to use:** Modules 6-10 (neuroscience content). Provide continuity.
**Trade-offs:** Requires upfront design of example data that works across multiple analyses.

## Build Order (Implementation Priority)

The build order is driven by urgency (she is behind in the course) and dependencies:

### Phase 1: Matlab Survival Kit (Modules 1-2)
Build first. She needs to be able to write and run basic Matlab code immediately. These modules have no dependencies and provide the foundation for everything else.

### Phase 2: Core Skills (Modules 3-5)
Build second. These unlock the neuroscience content. Can be built somewhat in parallel since Modules 3 and 4 are independent.

### Phase 3: NEVR3004 Content (Modules 6-8)
Build third. This is the course-specific material. Neural coding (Module 6) must come first. Information theory (Module 7) and dimensionality reduction (Module 8) can be built in parallel after Module 6.

### Phase 4: Advanced + Capstone (Modules 9-10)
Build last. These depend on all prior modules and represent the most advanced material.

### Phase 0: Reference Sheets
Build incrementally alongside modules. Each reference sheet can be started when its topic area is first covered and expanded as later modules add concepts.

## Anti-Patterns

### Anti-Pattern 1: Math-First Teaching

**What people do:** Teach a full linear algebra unit before using matrices in Matlab.
**Why it is wrong:** Abstract math without immediate application kills motivation, especially for a visual learner with gaps in math background. It also wastes time -- she does not need the full theory, just enough to use the tools.
**Do this instead:** Introduce math concepts in the lesson at the moment they are needed, with a visual example and immediate Matlab code. Reference sheets provide the lookup table for later.

### Anti-Pattern 2: Long Monolithic Lessons

**What people do:** Write a 2000-word lesson covering multiple concepts with exercises at the end.
**Why it is wrong:** Cognitive overload. For an ADHD learner, a long lesson without interaction points means losing focus before reaching the exercises.
**Do this instead:** One concept per lesson (300-600 words). Lesson links directly to a demo script and exercise. Total engagement time per module: 30-45 minutes broken into 3-4 activities.

### Anti-Pattern 3: Unscaffolded Exercises

**What people do:** "Write a function that computes the firing rate of a neuron given a spike train."
**Why it is wrong:** Too much blank-page anxiety. A learner who is still building confidence does not know where to start with an open prompt.
**Do this instead:** Provide the function skeleton, the loading of data, and the plot. Leave the core computation as a TODO with a clear hint. Gradually reduce scaffolding in later modules.

### Anti-Pattern 4: Separate "Math Prerequisites" Section

**What people do:** Create a "Prerequisites: Math Review" section at the start of the course.
**Why it is wrong:** Math review without application context feels like homework. The learner may skip it or disengage, then still struggle when the concepts appear later.
**Do this instead:** Integrate math into the relevant module. The reference sheet serves as the "review" -- available on demand, not forced upfront.

## Sources

- [NEVR3004 - Neural Networks, NTNU](https://www.ntnu.edu/studies/courses/NEVR3004) -- course description, learning outcomes, exam format
- [Neuromatch Academy: Computational Neuroscience Prerequisites](https://compneuro.neuromatch.io/prereqs/ComputationalNeuroscience.html) -- required math, programming, and neuroscience knowledge
- [NYU Computational Neuroscience Fall 2025 Syllabus](https://www.cns.nyu.edu/~david/courses/compNeuro/syllabus2025.html) -- topic progression example
- [INCF Training: Essentials of Neuroscience with MATLAB](https://training.incf.org/collection/essentials-neuroscience-matlab) -- Matlab + neuroscience course structure
- [MATLAB Academy: MATLAB Onramp](https://matlabacademy.mathworks.com/details/matlab-onramp/gettingstarted) -- self-paced Matlab learning structure
- [Coursera: Computational Neuroscience (University of Washington)](https://www.coursera.org/learn/computational-neuroscience) -- topic coverage and progression
- [ADHD-friendly curriculum differentiation](https://behaviourhelp.com/behaviour-blog/positive-behaviour-support/empowering-learners-differentiating-the-curriculum-for-students-with-adhd) -- chunking, task breakdown, pacing strategies

---
*Architecture research for: Matlab for Computational Neuroscience course*
*Researched: 2026-03-14*

# Roadmap: Matlab for Computational Neuroscience

## Overview

This roadmap takes Christel from zero Matlab to independently coding computational neuroscience models for NEVR3004. It starts with getting her productive immediately (writing code, seeing plots), builds the math and programming foundations she needs, then applies those skills to the actual course topics: neural coding, information theory, dimensionality reduction, and attractor networks. Every phase produces working, visual Matlab scripts she can run and learn from.

## Phases

**Phase Numbering:**
- Integer phases (1, 2, 3): Planned milestone work
- Decimal phases (2.1, 2.2): Urgent insertions (marked with INSERTED)

Decimal phases appear between their surrounding integers in numeric order.

- [x] **Phase 1: Matlab Survival Kit** - Variables, vectors, plotting, and first scripts with visual output (completed 2026-03-15)
- [ ] **Phase 2: Programming and Math Foundations** - Functions, loops, conditionals, linear algebra, and statistics
- [ ] **Phase 3: Neural Coding and Information Theory** - Tuning curves, spike trains, population coding, entropy, mutual information
- [ ] **Phase 4: Dimensionality Reduction and Attractor Networks** - PCA, Hopfield networks, ring attractors

## Phase Details

### Phase 1: Matlab Survival Kit
**Goal**: Christel can write and run Matlab scripts that produce visual output, and the pedagogical pattern for all future lessons is established
**Depends on**: Nothing (first phase)
**Requirements**: MATL-01, MATL-02, MATL-03, MATL-04, MATH-01, PEDA-01, PEDA-02, PEDA-03, PEDA-04, PEDA-05
**Success Criteria** (what must be TRUE):
  1. Learner can create vectors and matrices, access elements by index, and explain what she built
  2. Learner can write a .m script from scratch, save it, and run it to produce a labeled plot
  3. Learner can visualize 2D vectors as arrows and describe what direction and magnitude mean
  4. Every lesson script produces visual output within the first 5 minutes of running it
  5. Lesson format is established: small chunks, visual-first, scaffolded exercises, relatable analogies
**Plans**: 2 plans

Plans:
- [ ] 01-01-PLAN.md — Module 01: First Steps (variables, types, scripts, first plots)
- [ ] 01-02-PLAN.md — Module 02: Vectors and Plotting (vectors, matrices, indexing, all plot types, vectors as arrows)

### Phase 2: Programming and Math Foundations
**Goal**: Christel can write structured Matlab programs using functions and loops, and understands the linear algebra and statistics concepts that NEVR3004 builds on
**Depends on**: Phase 1
**Requirements**: MATL-05, MATL-06, MATL-07, MATH-02, MATH-03, MATH-04, MATH-05, MATH-06
**Success Criteria** (what must be TRUE):
  1. Learner can write a function that takes inputs, does computation, and returns outputs
  2. Learner can use for-loops and conditionals to process data (e.g., loop through trials, filter by condition)
  3. Learner can multiply matrices, compute dot products, and explain what these operations do visually
  4. Learner can compute mean, variance, and correlation of a dataset and interpret the results using plots
  5. Learner can explain eigenvalues/eigenvectors as "directions that survive a transformation" and visualize them
**Plans**: 2 plans

Plans:
- [ ] 02-01-PLAN.md — Module 03: Programming Tools (functions, loops, conditionals)
- [ ] 02-02-PLAN.md — Module 04: Math Foundations (matrix transforms, statistics, eigenvalues)

### Phase 3: Neural Coding and Information Theory
**Goal**: Christel can analyze how neurons encode and transmit information, using both neural coding analysis and information-theoretic measures
**Depends on**: Phase 2
**Requirements**: NEUR-01, NEUR-02, NEUR-03, NEUR-04, INFO-01, INFO-02, INFO-03, MATH-07
**Success Criteria** (what must be TRUE):
  1. Learner can generate simulated spike trains and plot tuning curves that show what a neuron responds to
  2. Learner can visualize population coding and implement a basic decoder that reads information from neural activity
  3. Learner can compute entropy of a distribution and mutual information between stimulus and response, and explain what these quantities mean
  4. Learner can use logarithms in information-theoretic calculations and explain why log is the right scale
**Plans**: TBD

Plans:
- [ ] 03-01: TBD
- [ ] 03-02: TBD

### Phase 4: Dimensionality Reduction and Attractor Networks
**Goal**: Christel can reduce high-dimensional neural data to interpretable low-dimensional representations and simulate network models of memory and navigation
**Depends on**: Phase 3
**Requirements**: DIMR-01, DIMR-02, DIMR-03, ATTR-01, ATTR-02, ATTR-03
**Success Criteria** (what must be TRUE):
  1. Learner can perform PCA step-by-step (covariance matrix, eigenvalues, projection) and interpret the results with variance-explained plots
  2. Learner can explain why high-dimensional neural data needs dimensionality reduction using a concrete visual example
  3. Learner can implement a Hopfield network that stores and retrieves simple patterns
  4. Learner can implement a ring attractor and visualize how it maintains a stable heading direction
  5. Learner can explain attractor dynamics using the ball-in-bowl metaphor and energy landscape visualizations
**Plans**: TBD

Plans:
- [ ] 04-01: TBD
- [ ] 04-02: TBD

## Progress

**Execution Order:**
Phases execute in numeric order: 1 → 2 → 3 → 4

| Phase | Plans Complete | Status | Completed |
|-------|----------------|--------|-----------|
| 1. Matlab Survival Kit | 2/2 | Complete   | 2026-03-15 |
| 2. Programming and Math Foundations | 0/2 | Not started | - |
| 3. Neural Coding and Information Theory | 0/? | Not started | - |
| 4. Dimensionality Reduction and Attractor Networks | 0/? | Not started | - |

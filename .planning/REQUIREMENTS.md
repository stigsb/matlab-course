# Requirements: Matlab for Computational Neuroscience

**Defined:** 2026-03-14
**Core Value:** Christel can independently write and understand Matlab code for neural data analysis and computational neuroscience modeling

## v1 Requirements

### Matlab Fundamentals

- [x] **MATL-01**: Learner can create and manipulate variables, vectors, and matrices in Matlab
- [x] **MATL-02**: Learner can use indexing and slicing to access parts of vectors and matrices
- [x] **MATL-03**: Learner can write, save, and run .m script files
- [x] **MATL-04**: Learner can create plots (line, scatter, bar, imagesc) with labels and titles
- [x] **MATL-05**: Learner can write functions that accept inputs and return outputs
- [x] **MATL-06**: Learner can use for-loops and while-loops to repeat computations
- [x] **MATL-07**: Learner can use if/else conditionals to control program flow

### Math Foundations (Integrated)

- [x] **MATH-01**: Learner understands vectors as arrows/directions and can visualize them in 2D/3D plots
- [x] **MATH-02**: Learner understands matrices as transformations and can visualize what they do to vectors
- [x] **MATH-03**: Learner can compute and interpret dot products and matrix multiplication
- [x] **MATH-04**: Learner understands eigenvalues/eigenvectors visually (directions that don't change under transformation)
- [x] **MATH-05**: Learner understands probability distributions and can plot/interpret histograms
- [x] **MATH-06**: Learner can compute and interpret mean, variance, standard deviation, and correlation
- [x] **MATH-07**: Learner understands logarithms visually and can use them in information-theoretic calculations

### Neural Coding and Decoding

- [x] **NEUR-01**: Learner can plot and interpret tuning curves from simulated neural data
- [x] **NEUR-02**: Learner understands population coding and can visualize how groups of neurons encode information
- [x] **NEUR-03**: Learner can generate and analyze simulated spike trains
- [x] **NEUR-04**: Learner can implement a basic neural decoder that reads information from population activity

### Information Theory

- [x] **INFO-01**: Learner can compute entropy of a discrete distribution and explain what it measures
- [x] **INFO-02**: Learner can compute mutual information between stimulus and neural response
- [x] **INFO-03**: Learner can visualize information-theoretic quantities with plots and diagrams

### Dimensionality Reduction

- [ ] **DIMR-01**: Learner understands why high-dimensional neural data needs dimensionality reduction
- [ ] **DIMR-02**: Learner can perform PCA step-by-step (covariance matrix → eigenvalues → projection)
- [ ] **DIMR-03**: Learner can interpret PCA results (variance explained, principal components) with visualizations

### Attractor Networks

- [ ] **ATTR-01**: Learner understands attractor dynamics visually (energy landscapes, ball-in-bowl)
- [ ] **ATTR-02**: Learner can implement and simulate a simple Hopfield network for memory storage
- [ ] **ATTR-03**: Learner can implement and visualize a ring attractor for head direction / navigation

### Pedagogy

- [x] **PEDA-01**: Every lesson produces visual output (plots, diagrams, or animations) within the first 5 minutes
- [x] **PEDA-02**: Lessons are chunked into 15-20 minute segments with clear checkpoints
- [x] **PEDA-03**: Math concepts are introduced visually first, then connected to notation ("notation bridge")
- [x] **PEDA-04**: Exercises are scaffolded (70-80% pre-written, learner fills key parts)
- [x] **PEDA-05**: Examples use relatable analogies drawn from everyday life and Christel's interests

## v2 Requirements

### Exam Preparation

- **EXAM-01**: Notation reading practice — connect visual understanding to textbook math notation
- **EXAM-02**: Pen-and-paper problem sets mimicking exam format
- **EXAM-03**: Summary/reference sheets for each topic (quick-reference cards)

### Advanced Topics

- **ADVN-01**: Neural data analysis with real experimental datasets
- **ADVN-02**: Model comparison and fitting techniques
- **ADVN-03**: Advanced visualization techniques (3D, animation)

## Out of Scope

| Feature | Reason |
|---------|--------|
| Deep learning (CNNs, RNNs, transformers) | NEVR3004 is computational neuroscience, not CS-style ML |
| Matlab toolboxes beyond base | Core Matlab covers everything needed |
| .mlx Live Scripts | .m scripts are more portable and simpler |
| Video lectures | Building text + interactive scripts |
| Separate standalone math course | Math is integrated into Matlab lessons |
| Software engineering practices | She needs to do science, not ship software |
| Norwegian language content | English matches NTNU course and Matlab docs |

## Traceability

Which phases cover which requirements. Updated during roadmap creation.

| Requirement | Phase | Status |
|-------------|-------|--------|
| MATL-01 | Phase 1 | Complete |
| MATL-02 | Phase 1 | Complete |
| MATL-03 | Phase 1 | Complete |
| MATL-04 | Phase 1 | Complete |
| MATL-05 | Phase 2 | Complete |
| MATL-06 | Phase 2 | Complete |
| MATL-07 | Phase 2 | Complete |
| MATH-01 | Phase 1 | Complete |
| MATH-02 | Phase 2 | Complete |
| MATH-03 | Phase 2 | Complete |
| MATH-04 | Phase 2 | Complete |
| MATH-05 | Phase 2 | Complete |
| MATH-06 | Phase 2 | Complete |
| MATH-07 | Phase 3 | Complete |
| NEUR-01 | Phase 3 | Complete |
| NEUR-02 | Phase 3 | Complete |
| NEUR-03 | Phase 3 | Complete |
| NEUR-04 | Phase 3 | Complete |
| INFO-01 | Phase 3 | Complete |
| INFO-02 | Phase 3 | Complete |
| INFO-03 | Phase 3 | Complete |
| DIMR-01 | Phase 4 | Pending |
| DIMR-02 | Phase 4 | Pending |
| DIMR-03 | Phase 4 | Pending |
| ATTR-01 | Phase 4 | Pending |
| ATTR-02 | Phase 4 | Pending |
| ATTR-03 | Phase 4 | Pending |
| PEDA-01 | Phase 1 | Complete |
| PEDA-02 | Phase 1 | Complete |
| PEDA-03 | Phase 1 | Complete |
| PEDA-04 | Phase 1 | Complete |
| PEDA-05 | Phase 1 | Complete |

**Coverage:**
- v1 requirements: 32 total
- Mapped to phases: 32
- Unmapped: 0

---
*Requirements defined: 2026-03-14*
*Last updated: 2026-03-14 after roadmap creation*

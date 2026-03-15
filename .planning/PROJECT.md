# Matlab for Computational Neuroscience

## What This Is

A personalized, visual-first course that teaches Matlab and the necessary math foundations to a neuroscience student (Christel) who needs to rapidly get productive in NEVR3004 (Neural Networks) at NTNU. The course covers 8 modules from basic variables through attractor networks, with written lessons paired with interactive Matlab scripts (.m files) that emphasize plots, diagrams, and animations to make abstract concepts concrete.

## Core Value

Christel can independently write and understand Matlab code for neural data analysis and computational neuroscience modeling — the specific skills NEVR3004 requires.

## Requirements

### Validated

- ✓ Matlab fundamentals: variables, vectors, matrices, indexing, plotting — v1.0
- ✓ Matlab programming: functions, loops, conditionals, scripts — v1.0
- ✓ Math foundation: vectors and matrices (linear algebra basics) integrated into lessons — v1.0
- ✓ Math foundation: probability and statistics concepts integrated into lessons — v1.0
- ✓ Math foundation: eigenvalues and eigenvectors as "directions that survive" — v1.0
- ✓ Math foundation: logarithms introduced visually for information theory — v1.0
- ✓ Neural coding and decoding: understanding and implementing in Matlab — v1.0
- ✓ Information theory: entropy, mutual information — concepts and Matlab implementation — v1.0
- ✓ Dimensionality reduction: PCA step-by-step in Matlab — v1.0
- ✓ Attractor networks: Hopfield memory and ring attractor modeling — v1.0
- ✓ Every lesson includes visual elements: plots, diagrams, or animations — v1.0
- ✓ Lessons use relatable examples and analogies drawn from everyday life — v1.0
- ✓ Math is taught in context — introduced right when needed, not as a separate block — v1.0

### Active

- [ ] Notation reading practice — connect visual understanding to textbook math notation
- [ ] Pen-and-paper problem sets mimicking exam format
- [ ] Summary/reference sheets for each topic (quick-reference cards exist, may need exam focus)

### Out of Scope

- Deep learning / modern ML (CNNs, RNNs, transformers) — NEVR3004 is computational neuroscience, not CS-style ML
- Production code quality / software engineering practices — she needs to do science, not ship software
- Matlab toolboxes beyond what NEVR3004 requires — keep it focused
- Norwegian language — material in English to match course and Matlab documentation
- Video lectures — we're building text + interactive scripts, not a video course
- Separate standalone math course — math is integrated into the Matlab lessons
- .mlx Live Scripts — .m scripts are more portable and simpler
- Neural data analysis with real experimental datasets — v2 candidate if needed
- Advanced visualization techniques (3D, animation) — v2 candidate if needed

## Context

- **Learner profile:** Christel has a psychology background, now in neuroscience at NTNU. Basic algebra is solid, but there are significant gaps in higher math (linear algebra, calculus, statistics) stemming from weak STEM education in high school.
- **Learning style:** Strong visual thinker — concepts click when she can see them as plots, diagrams, or animations. Prefers learning by doing over reading theory.
- **Capacity:** Has ADHD and reduced capacity. Lessons must be concise, chunked into small pieces, and maintain engagement. Quick wins early to build confidence.
- **Course context:** NEVR3004 covers computational neuroscience — neural coding/decoding, information theory, dimensionality reduction, attractor networks, neural data analysis. This is brain-modeling, not machine learning.
- **Tools:** Matlab is installed and licensed through NTNU. Course material is markdown/text lessons and .m script files she can run and modify.
- **Cultural context:** Lives in Trondheim with family (kids Ravn 11 and Helena 8, cat Enzo). Interests include gardening, metalcore, horseback riding, and cats. These inform relatable examples and analogies in the material.
- **Current state:** v1.0 shipped with 45 Matlab scripts (5,985 LOC), 12 lessons (2,723 lines), and 4 reference cards. 8 modules covering full NEVR3004 syllabus.

## Constraints

- **Timeline**: Urgent — course is already underway, she needs to catch up
- **Math level**: Basic algebra only — all higher math must be taught from scratch, visually, in context
- **Cognitive load**: Small chunks, frequent visual reinforcement, no walls of text or abstract notation without visualization
- **Tech stack**: Matlab .m scripts + markdown lessons (no .mlx — stick to plain scripts for portability)
- **Sensitivity**: Do not reference fatigue or reduced capacity in any course material

## Key Decisions

| Decision | Rationale | Outcome |
|----------|-----------|---------|
| Integrate math into Matlab lessons | She learns math best when she can immediately see it working in code and visualizations | ✓ Good — math taught in context throughout all 8 modules |
| English language | Matches NTNU course language and Matlab documentation | ✓ Good |
| Visual-first pedagogy (See-Code-Do) | Visual thinker — every concept gets a plot, diagram, or animation | ✓ Good — every demo produces plot in first 5 lines |
| .m scripts not .mlx | Better portability, simpler toolchain, works with any editor | ✓ Good |
| 4 coarse phases following learning progression | Natural topic progression, each phase builds on previous | ✓ Good — clear dependency chain |
| PEDA requirements in Phase 1 | Establish pedagogical pattern early for all future modules | ✓ Good — pattern carried through all 8 modules |
| Eigenvalues taught as "directions that survive" | Visual-first approach with explicit bridge to PCA in Phase 4 | ✓ Good — explicit bridge in Module 07 |
| Population vector decoder as standalone function file | Demonstrates function-file pattern from Phase 2, enables reuse | ✓ Good |
| Reference cards as lookup tables, not tutorial prose | Quick scanning during exercises, not re-reading lessons | ✓ Good |

---
*Last updated: 2026-03-15 after v1.0 milestone*

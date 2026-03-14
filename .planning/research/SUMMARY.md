# Research Summary: Matlab for Computational Neuroscience

**Domain:** Self-paced computational neuroscience education (NEVR3004 prep)
**Researched:** 2026-03-14
**Overall confidence:** HIGH

## Executive Summary

NEVR3004 (Neural Networks) at NTNU is a computational neuroscience course covering neural coding/decoding, information theory, dimensionality reduction, attractor networks, and neural data analysis. The exam is June 5, 2026 (4-hour written, pen-and-paper via Inspera). The course references Rolls & Treves' "Neural Networks and Brain Function" for prerequisite math and expects students to program in Matlab. Christel is behind and needs to catch up rapidly.

The good news: the technical stack is dead simple. Core Matlab -- no toolboxes required -- covers everything NEVR3004 needs. Vectors, matrices, plotting, basic statistics, eigenvalue decomposition, and simulation loops are all built-in. The Statistics and Machine Learning Toolbox adds a convenient `pca()` function but is not required; teaching PCA from `eig()` and `cov()` is actually better pedagogy.

The real challenge is not technical but pedagogical. Christel has a psychology background with significant math gaps (linear algebra, calculus, probability), is a strong visual thinker, and has ADHD. Every research dimension -- stack, features, architecture, pitfalls -- points to the same core design principles: visual-first, small chunks, math-in-context, and neuroscience motivation before abstraction. The biggest risk is not "wrong technology" but "wrong teaching approach" -- specifically, front-loading abstract math or creating lessons that are too long/dense.

The course material format is settled: plain .m scripts (not .mlx) paired with Markdown explanations. This is git-friendly, portable, and simple. Each lesson module contains a README.md for explanations, demo scripts for runnable visualizations, exercises with scaffolding, and solutions for self-checking.

## Key Findings

**Stack:** Core Matlab only. No toolboxes required. Key functions: plot(), eig(), cov(), mean(), std(), histogram(), imagesc(), for loops.

**Architecture:** Numbered module folders (01-10), each with lesson.md + demo scripts + exercises + solutions. Self-contained scripts, no dependency chains.

**Critical pitfall:** Math-first teaching order. Leading with notation instead of visuals will trigger math anxiety and disengage the learner. Always: plot first, explain second, notation last.

## Implications for Roadmap

Based on research, suggested phase structure:

1. **Matlab Survival Kit** (Modules 1-2) - Get her writing and running code with visual output immediately
   - Addresses: Matlab fundamentals, plotting, vectors, basic indexing
   - Avoids: Boredom from generic tutorials by using neuroscience-flavored examples

2. **Core Skills** (Modules 3-5) - Build the math and programming foundation NEVR3004 requires
   - Addresses: Matrices, linear algebra basics, programming constructs, statistics
   - Avoids: Cognitive overload by separating new syntax from new math concepts

3. **NEVR3004 Content: Neural Coding** (Module 6) - First direct course topic
   - Addresses: Tuning curves, population coding, spike train analysis
   - Avoids: Assuming math knowledge by building probability concepts inline

4. **NEVR3004 Content: Theory** (Modules 7-8) - Information theory and PCA
   - Addresses: Entropy, mutual information, dimensionality reduction
   - Avoids: Black-box PCA by teaching it step-by-step from eigenvectors

5. **NEVR3004 Content: Networks + Capstone** (Modules 9-10) - Attractor networks, neural data analysis
   - Addresses: Hopfield networks, ring attractors, real data workflows
   - Avoids: Dynamics confusion by using ball-in-bowl animations

6. **Exam Prep** - Notation reading, pen-and-paper practice, summary sheets
   - Addresses: Written exam format (no computer)
   - Avoids: Overconfidence from "I can do it in Matlab" when exam requires hand calculations

**Phase ordering rationale:**
- Phases 1-2 must come first: everything depends on basic Matlab skills and math foundations
- Phase 3 (neural coding) is the entry point to NEVR3004 content and uses all prior skills
- Phases 4a and 4b (information theory, PCA) are independent of each other but both require Phase 3
- Phase 5 (attractor networks) is the most complex and builds on everything
- Exam prep is ongoing but intensifies at the end

**Research flags for phases:**
- Phase 4 (Information Theory): Needs careful scaffolding -- probability and logarithms may be entirely new
- Phase 5 (Attractor Networks): Likely needs deeper research on how to teach dynamics without calculus
- Phase 6 (Exam Prep): May need to obtain past exam papers to calibrate difficulty

## Confidence Assessment

| Area | Confidence | Notes |
|------|------------|-------|
| Stack | HIGH | Core Matlab is unambiguous. NEVR3004 course page confirms Matlab. No toolbox decisions to make. |
| Features | HIGH | NEVR3004 topics are clearly defined on the course page. Feature list maps directly to course content. |
| Architecture | HIGH | Module structure follows established patterns from Matlab for Neuroscientists and Neuromatch Academy. |
| Pitfalls | HIGH | Pedagogical pitfalls well-documented in ADHD learning research and computational neuroscience teaching literature. |
| Reference materials | MEDIUM | Rolls & Treves confirmed as course reference. Other textbooks are standard in the field but NEVR3004's actual assigned readings are "TBA." |

## Gaps to Address

- **Actual NEVR3004 lecture slides and assignments:** Would significantly improve content alignment. Christel may be able to share these.
- **Past exam papers:** Critical for exam prep phase. Available through NTNU's exam archive or from the course.
- **Specific Matlab version at NTNU:** Should verify which version is on the NTNU license server (likely R2024a or R2024b).
- **Attractor network pedagogy without calculus:** Need to research or design visual approaches to teaching network dynamics to someone without differential equations background.
- **Paul Miller's textbook code:** Freely available Matlab code from "An Introductory Course in Computational Neuroscience" could be adapted for exercises. Worth downloading and reviewing.

## Sources

- [NTNU NEVR3004 Course Page](https://www.ntnu.edu/studies/courses/NEVR3004)
- [Neural Networks and Brain Function (Rolls & Treves, Oxford)](https://academic.oup.com/book/4417)
- [Matlab for Neuroscientists (Wallisch et al., MathWorks)](https://www.mathworks.com/academia/books/matlab-for-neuroscientists-wallisch.html)
- [An Introductory Course in Computational Neuroscience (Miller, MIT Press)](https://mitpress.mit.edu/9780262038256/)
- [Theoretical Neuroscience (Dayan & Abbott, MIT Press)](https://mitpress.mit.edu/9780262041997/theoretical-neuroscience/)
- [Neuromatch Academy Computational Neuroscience](https://compneuro.neuromatch.io/)
- [Information Theory in Neuroscience Tutorial (eNeuro)](https://www.eneuro.org/content/5/3/ENEURO.0052-18.2018)
- [MathWorks Neuroscience Solutions](https://www.mathworks.com/solutions/neuroscience.html)
- [Coursera: Computational Neuroscience (U. Washington)](https://www.coursera.org/learn/computational-neuroscience)

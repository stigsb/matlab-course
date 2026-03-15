# Project Retrospective

*A living document updated after each milestone. Lessons feed forward into future planning.*

## Milestone: v1.0 — Matlab for Computational Neuroscience

**Shipped:** 2026-03-15
**Phases:** 4 | **Plans:** 8 | **Sessions:** ~3

### What Was Built
- 8-module visual-first Matlab course covering full NEVR3004 syllabus
- 45 Matlab scripts (5,985 LOC) with immediate visual output
- 12 lesson documents (2,723 lines) with notation bridges and relatable analogies
- Scaffolded exercises in every module (70-80% pre-written, TODO blanks)
- 4 quick-reference cards as lookup tables
- Reusable function files (decode_direction.m, compute_entropy.m)

### What Worked
- Coarse 4-phase structure mapped cleanly to the learning progression
- See-Code-Do pedagogical pattern established in Phase 1 carried through effortlessly
- Parallel plan execution within phases (wave-1 plans ran simultaneously)
- Consistent ~4 min per plan — no surprises, no blockers
- Eigenvalue → PCA bridge was explicitly designed in and paid off

### What Was Inefficient
- ROADMAP.md phases 3-4 checkboxes weren't updated by execution (cosmetic but caused audit noise)
- VERIFICATION.md files were never generated during execute-phase (workflow.verifier was false)
- Phase 3 state tracking incomplete (03-02 duration/tasks not fully propagated to STATE.md)

### Patterns Established
- See-Code-Do: lesson.md explains → demo_*.m shows → exercise_*.m practices
- Immediate Visual Payoff: plot within first 5 executable lines
- Notation Bridge: visual → code → math notation
- Scaffolded Exercise: 70-80% pre-written with TODO markers
- Standard Script Header: description, module reference, clear;clc;close all
- Function files in module directories for Matlab path convenience
- Reference cards as terse lookup tables, not tutorial prose

### Key Lessons
1. Educational content projects execute faster than software because there are no integration bugs or test failures
2. The research phase for each module was high-value — knowing pedagogy pitfalls upfront prevented rework
3. With verifier disabled, verification becomes a manual post-hoc step — consider enabling for v2

### Cost Observations
- Model mix: ~30% opus (orchestration), ~70% sonnet (execution agents)
- Sessions: ~3 (init, execute phases 1-2, execute phases 3-4 + audit)
- Notable: Entire 8-module course built in under 2 hours wall-clock time

---

## Cross-Milestone Trends

### Process Evolution

| Milestone | Sessions | Phases | Key Change |
|-----------|----------|--------|------------|
| v1.0 | ~3 | 4 | First milestone — established all patterns |

### Cumulative Quality

| Milestone | Scripts | Lessons | Reference Cards |
|-----------|---------|---------|-----------------|
| v1.0 | 45 | 12 | 4 |

### Top Lessons (Verified Across Milestones)

1. Visual-first pedagogy works — every concept anchored to a plot before notation
2. Coarse phase granularity (4 phases) is ideal for educational content

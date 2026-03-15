---
phase: 01
slug: matlab-survival-kit
status: draft
nyquist_compliant: false
wave_0_complete: false
created: 2026-03-15
---

# Phase 01 — Validation Strategy

> Per-phase validation contract for feedback sampling during execution.

---

## Test Infrastructure

| Property | Value |
|----------|-------|
| **Framework** | Manual validation (educational content, not software) |
| **Config file** | None |
| **Quick run command** | Open each .m file in Matlab and press F5 (Run) |
| **Full suite command** | Run all demo_*.m and solution_*.m scripts; verify each produces expected figures |
| **Estimated runtime** | ~5 minutes (manual inspection) |

---

## Sampling Rate

- **After every task commit:** Run all .m files in the module, verify figures appear without errors
- **After every plan wave:** Run all .m files across all modules, verify no cross-module issues
- **Before `/gsd:verify-work`:** All demo and solution scripts run clean; all exercises run clean when TODOs are filled per solutions
- **Max feedback latency:** ~60 seconds per script

---

## Per-Task Verification Map

| Task ID | Plan | Wave | Requirement | Test Type | Automated Command | File Exists | Status |
|---------|------|------|-------------|-----------|-------------------|-------------|--------|
| 01-01-01 | 01 | 1 | MATL-01 | manual | Run demo_variables.m, check workspace | ❌ W0 | ⬜ pending |
| 01-01-02 | 01 | 1 | MATL-02 | manual | Run demo_vectors.m, check output | ❌ W0 | ⬜ pending |
| 01-01-03 | 01 | 1 | MATL-03 | manual | Run demo_hello.m from editor | ❌ W0 | ⬜ pending |
| 01-01-04 | 01 | 1 | MATL-04 | manual | Run demo_plotting.m, inspect figures | ❌ W0 | ⬜ pending |
| 01-02-01 | 02 | 1 | MATH-01 | manual | Run demo_vector_arrows.m, inspect quiver plot | ❌ W0 | ⬜ pending |
| 01-01-05 | 01 | 1 | PEDA-01 | manual | Time from F5 to first figure appearing | ❌ W0 | ⬜ pending |
| 01-01-06 | 01 | 1 | PEDA-02 | manual | Read-through timing of each lesson.md | ❌ W0 | ⬜ pending |
| 01-01-07 | 01 | 1 | PEDA-03 | manual | Review lesson.md ordering | ❌ W0 | ⬜ pending |
| 01-01-08 | 01 | 1 | PEDA-04 | manual | Count lines vs TODO lines in exercise files | ❌ W0 | ⬜ pending |
| 01-01-09 | 01 | 1 | PEDA-05 | manual | Review variable names and lesson text | ❌ W0 | ⬜ pending |

*Status: ⬜ pending · ✅ green · ❌ red · ⚠️ flaky*

---

## Wave 0 Requirements

- All content is new — no existing files. Wave 0 creates the first module content.
- Validation is manual (run Matlab scripts, inspect output). No automated test framework needed for educational content.

*Existing infrastructure covers all phase requirements via manual verification.*

---

## Manual-Only Verifications

| Behavior | Requirement | Why Manual | Test Instructions |
|----------|-------------|------------|-------------------|
| Variables/vectors/matrices created | MATL-01 | Educational content — visual inspection | Run demo_variables.m, verify workspace shows correct types |
| Indexing demonstrated | MATL-02 | Educational content — visual inspection | Run demo_vectors.m, verify slicing output matches |
| .m script runs | MATL-03 | Educational content — run in editor | Open demo_hello.m, press F5, verify output |
| Labeled plots produced | MATL-04 | Educational content — visual inspection | Run demo_plotting.m, check title/axis labels |
| 2D vector arrows | MATH-01 | Educational content — visual inspection | Run demo_vector_arrows.m, verify quiver arrows |
| Visual output in 5 min | PEDA-01 | Timing-based | Time from script start to first figure |
| 15-20 min chunks | PEDA-02 | Read-through timing | Read each lesson.md, verify manageable length |
| Visual before notation | PEDA-03 | Content ordering | Review lesson.md structure |
| 70-80% scaffolded | PEDA-04 | Line counting | Count provided vs TODO lines in exercises |
| Relatable analogies | PEDA-05 | Content review | Check variable names and explanatory text |

---

## Validation Sign-Off

- [ ] All tasks have `<automated>` verify or Wave 0 dependencies
- [ ] Sampling continuity: no 3 consecutive tasks without automated verify
- [ ] Wave 0 covers all MISSING references
- [ ] No watch-mode flags
- [ ] Feedback latency < 60s
- [ ] `nyquist_compliant: true` set in frontmatter

**Approval:** pending

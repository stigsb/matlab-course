---
phase: 2
slug: programming-and-math-foundations
status: draft
nyquist_compliant: false
wave_0_complete: false
created: 2026-03-15
---

# Phase 2 — Validation Strategy

> Per-phase validation contract for feedback sampling during execution.

---

## Test Infrastructure

| Property | Value |
|----------|-------|
| **Framework** | Manual validation (educational content, not software) |
| **Config file** | None |
| **Quick run command** | Open each .m file in Matlab and press F5 (Run) |
| **Full suite command** | Run all demo_*.m and solution_*.m scripts; verify each produces expected figures |
| **Estimated runtime** | ~30 seconds per script |

---

## Sampling Rate

- **After every task commit:** Run all .m files in the module, verify figures appear without errors
- **After every plan wave:** Run all .m files across all modules, verify no cross-module issues
- **Before `/gsd:verify-work`:** All demo and solution scripts run clean; exercises run clean when TODOs are filled per solutions
- **Max feedback latency:** 30 seconds

---

## Per-Task Verification Map

| Task ID | Plan | Wave | Requirement | Test Type | Automated Command | File Exists | Status |
|---------|------|------|-------------|-----------|-------------------|-------------|--------|
| 02-01-01 | 01 | 1 | MATL-05 | manual | Run demo_functions.m, verify output values | ❌ W0 | ⬜ pending |
| 02-01-02 | 01 | 1 | MATL-06 | manual | Run demo_loops.m, verify printed output | ❌ W0 | ⬜ pending |
| 02-01-03 | 01 | 1 | MATL-07 | manual | Run demo_conditionals.m, verify filtered output | ❌ W0 | ⬜ pending |
| 02-02-01 | 02 | 1 | MATH-02 | manual | Run demo_matrix_transform.m, inspect quiver plots | ❌ W0 | ⬜ pending |
| 02-02-02 | 02 | 1 | MATH-03 | manual | Run demo_matrix_transform.m, verify computed values | ❌ W0 | ⬜ pending |
| 02-02-03 | 02 | 1 | MATH-04 | manual | Run demo_eigenvalues.m, inspect eigenvector overlay plot | ❌ W0 | ⬜ pending |
| 02-02-04 | 02 | 1 | MATH-05 | manual | Run demo_statistics.m, inspect histogram figure | ❌ W0 | ⬜ pending |
| 02-02-05 | 02 | 1 | MATH-06 | manual | Run demo_statistics.m, verify computed statistics | ❌ W0 | ⬜ pending |

*Status: ⬜ pending · ✅ green · ❌ red · ⚠️ flaky*

---

## Wave 0 Requirements

- All content is new — no existing files. Wave 0 creates the module content.
- Function files (e.g., average_value.m, compute_stats.m) must be in the correct directory for Matlab to find them.

*Existing infrastructure covers all phase requirements.*

---

## Manual-Only Verifications

| Behavior | Requirement | Why Manual | Test Instructions |
|----------|-------------|------------|-------------------|
| Function defined and called correctly | MATL-05 | Educational content — verify by running demo | Run demo_functions.m, check output matches expected values |
| Loops iterate and accumulate correctly | MATL-06 | Educational content — verify by running demo | Run demo_loops.m, check printed output matches expected |
| Conditionals filter data correctly | MATL-07 | Educational content — verify by running demo | Run demo_conditionals.m, check filtered results |
| Matrix transformation visualized | MATH-02 | Visual output — requires human inspection | Run demo_matrix_transform.m, verify quiver plots show before/after |
| Dot product and matrix multiply explained | MATH-03 | Educational content — verify computed values | Run demo, verify dot() and * produce expected results |
| Eigenvectors shown as surviving directions | MATH-04 | Visual output — requires human inspection | Run demo_eigenvalues.m, verify eigenvector overlay plot |
| Histogram plotted and interpretable | MATH-05 | Visual output — requires human inspection | Run demo_statistics.m, verify histogram with mean line |
| Statistics computed and visualized | MATH-06 | Visual + numerical — requires human verification | Run demo_statistics.m, verify mean/std/correlation values and plots |

---

## Validation Sign-Off

- [ ] All tasks have manual verify instructions
- [ ] Sampling continuity: no 3 consecutive tasks without verification
- [ ] Wave 0 covers all MISSING references
- [ ] No watch-mode flags
- [ ] Feedback latency < 30s
- [ ] `nyquist_compliant: true` set in frontmatter

**Approval:** pending

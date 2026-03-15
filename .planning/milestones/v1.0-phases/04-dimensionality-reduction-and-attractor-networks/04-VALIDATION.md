---
phase: 04
slug: dimensionality-reduction-and-attractor-networks
status: draft
nyquist_compliant: false
wave_0_complete: false
created: 2026-03-15
---

# Phase 04 — Validation Strategy

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
- **Before `/gsd:verify-work`:** Full suite must be green
- **Max feedback latency:** ~60 seconds per script

---

## Per-Task Verification Map

| Task ID | Plan | Wave | Requirement | Test Type | Automated Command | File Exists | Status |
|---------|------|------|-------------|-----------|-------------------|-------------|--------|
| 04-01-01 | 01 | 1 | DIMR-01 | manual | Run demo_why_reduce.m, inspect 3D vs 2D comparison | ❌ W0 | ⬜ pending |
| 04-01-01 | 01 | 1 | DIMR-02 | manual | Run demo_pca_steps.m, verify eigenvalues printed and plots shown | ❌ W0 | ⬜ pending |
| 04-01-01 | 01 | 1 | DIMR-03 | manual | Run demo_pca_steps.m, inspect scree/cumulative variance plots | ❌ W0 | ⬜ pending |
| 04-02-01 | 02 | 1 | ATTR-01 | manual | Run demo_energy_landscape.m, inspect energy plots with labeled valleys | ❌ W0 | ⬜ pending |
| 04-02-01 | 02 | 1 | ATTR-02 | manual | Run demo_hopfield.m, verify original vs noisy vs retrieved comparison | ❌ W0 | ⬜ pending |
| 04-02-01 | 02 | 1 | ATTR-03 | manual | Run demo_ring_attractor.m, verify bump in activity-over-time heatmap | ❌ W0 | ⬜ pending |

*Status: ⬜ pending · ✅ green · ❌ red · ⚠️ flaky*

---

## Wave 0 Requirements

- All content is new — no existing files. Wave 0 creates the module content.
- Existing reference card (reference/neural_coding_info.md) should be extended or a new card created.
- Validation is manual (run Matlab scripts, inspect output).

*Existing infrastructure covers all phase requirements via manual validation.*

---

## Manual-Only Verifications

| Behavior | Requirement | Why Manual | Test Instructions |
|----------|-------------|------------|-------------------|
| High-D data reduced to 2D with clear visual | DIMR-01 | Visual output inspection | Run demo_why_reduce.m, compare 3D scatter vs 2D projection |
| PCA step-by-step produces correct eigenvalues | DIMR-02 | Numerical output + plot inspection | Run demo_pca_steps.m, verify eigenvalues match manual calculation |
| Scree plot and cumulative variance | DIMR-03 | Plot inspection | Run demo, check scree plot shape and cumulative curve |
| Energy landscape with ball-in-bowl | ATTR-01 | Visual metaphor inspection | Run demo_energy_landscape.m, verify labeled valleys/hills |
| Hopfield stores and retrieves patterns | ATTR-02 | Pattern comparison | Run demo_hopfield.m, compare original/noisy/retrieved |
| Ring attractor maintains stable bump | ATTR-03 | Heatmap inspection | Run demo_ring_attractor.m, verify persistent activity bump |

---

## Validation Sign-Off

- [ ] All tasks have manual verify instructions
- [ ] Sampling continuity: no 3 consecutive tasks without verification
- [ ] Wave 0 covers all MISSING references
- [ ] No watch-mode flags
- [ ] Feedback latency < 60s
- [ ] `nyquist_compliant: true` set in frontmatter

**Approval:** pending

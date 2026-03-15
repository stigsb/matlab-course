---
phase: 3
slug: neural-coding-and-information-theory
status: draft
nyquist_compliant: false
wave_0_complete: false
created: 2026-03-15
---

# Phase 3 — Validation Strategy

> Per-phase validation contract for feedback sampling during execution.

---

## Test Infrastructure

| Property | Value |
|----------|-------|
| **Framework** | Manual validation (educational content — Matlab scripts, not software) |
| **Config file** | None |
| **Quick run command** | Open .m file in Matlab and press F5 (Run) |
| **Full suite command** | Run all demo_*.m and solution_*.m scripts; verify each produces expected figures |
| **Estimated runtime** | ~30 seconds per script (manual) |

---

## Sampling Rate

- **After every task commit:** Run all .m files in the module, verify figures appear without errors
- **After every plan wave:** Run all .m files across all modules, verify no cross-module issues
- **Before `/gsd:verify-work`:** All demo and solution scripts run clean; exercises run clean when TODOs are filled per solutions
- **Max feedback latency:** ~30 seconds per script

---

## Per-Task Verification Map

| Task ID | Plan | Wave | Requirement | Test Type | Automated Command | File Exists | Status |
|---------|------|------|-------------|-----------|-------------------|-------------|--------|
| 03-01-01 | 01 | 1 | NEUR-03 | manual | Run demo_spike_trains.m, inspect raster plot and PSTH | ❌ W0 | ⬜ pending |
| 03-01-02 | 01 | 1 | NEUR-01 | manual | Run demo_tuning_curves.m, inspect polar/line plot | ❌ W0 | ⬜ pending |
| 03-01-03 | 01 | 1 | NEUR-02 | manual | Run demo_population_coding.m, inspect heatmap and vector plot | ❌ W0 | ⬜ pending |
| 03-01-04 | 01 | 1 | NEUR-04 | manual | Run demo_population_coding.m, verify decoded vs actual printed | ❌ W0 | ⬜ pending |
| 03-02-01 | 02 | 1 | MATH-07 | manual | Run demo_logarithms.m, inspect visual plots | ❌ W0 | ⬜ pending |
| 03-02-02 | 02 | 1 | INFO-01 | manual | Run demo_entropy.m, verify fair coin = 1.0 bits | ❌ W0 | ⬜ pending |
| 03-02-03 | 02 | 1 | INFO-02 | manual | Run demo_mutual_information.m, verify MI > 0 | ❌ W0 | ⬜ pending |
| 03-02-04 | 02 | 1 | INFO-03 | manual | Run demo_entropy.m and demo_mutual_information.m, inspect figures | ❌ W0 | ⬜ pending |

*Status: ⬜ pending · ✅ green · ❌ red · ⚠️ flaky*

---

## Wave 0 Requirements

- All content is new — no existing files. Wave 0 creates the module content.
- Function files (e.g., `decode_direction.m`, `compute_entropy.m`) must be in the correct directory for Matlab to find them.

*Existing infrastructure covers all phase requirements via manual validation.*

---

## Manual-Only Verifications

| Behavior | Requirement | Why Manual | Test Instructions |
|----------|-------------|------------|-------------------|
| Tuning curve shows preferred direction | NEUR-01 | Visual inspection of plot | Run demo_tuning_curves.m, verify polar plot peaks at preferred direction |
| Population heatmap shows activity pattern | NEUR-02 | Visual inspection of heatmap | Run demo_population_coding.m, verify heatmap colors match expected pattern |
| Spike raster displays correctly | NEUR-03 | Visual inspection of raster | Run demo_spike_trains.m, verify vertical tick marks at spike times |
| Decoder output matches stimulus | NEUR-04 | Compare printed values | Run decoder demo, verify decoded direction is close to actual |
| Entropy of fair coin = 1.0 bits | INFO-01 | Verify printed value | Run demo_entropy.m, check output |
| MI > 0 for correlated stimulus-response | INFO-02 | Verify printed value | Run demo_mutual_information.m, check output |
| Information visualizations readable | INFO-03 | Visual inspection of figures | Run demos, verify bar charts and heatmaps are labeled and interpretable |
| Logarithm visual makes sense | MATH-07 | Visual inspection of plot | Run demo_logarithms.m, verify "doubling" intuition is clear |

---

## Validation Sign-Off

- [ ] All tasks have manual verify instructions
- [ ] Sampling continuity: every task has a verification step
- [ ] Wave 0 covers all MISSING references
- [ ] No watch-mode flags
- [ ] Feedback latency < 30s per script
- [ ] `nyquist_compliant: true` set in frontmatter

**Approval:** pending

---
phase: 5
slug: site-foundation-and-deploy
status: draft
nyquist_compliant: false
wave_0_complete: false
created: 2026-03-16
---

# Phase 5 — Validation Strategy

> Per-phase validation contract for feedback sampling during execution.

---

## Test Infrastructure

| Property | Value |
|----------|-------|
| **Framework** | Astro build + manual verification |
| **Config file** | `web/package.json` (scripts section) |
| **Quick run command** | `cd web && npm run build` |
| **Full suite command** | `cd web && npm run build && npm run preview` |
| **Estimated runtime** | ~15 seconds |

---

## Sampling Rate

- **After every task commit:** Run `cd web && npm run build`
- **After every plan wave:** Run `cd web && npm run build && npm run preview` + visual spot-check of 2 modules
- **Before `/gsd:verify-work`:** Full suite must be green, all 8 modules render, all download links work
- **Max feedback latency:** 15 seconds

---

## Per-Task Verification Map

| Task ID | Plan | Wave | Requirement | Test Type | Automated Command | File Exists | Status |
|---------|------|------|-------------|-----------|-------------------|-------------|--------|
| 05-01-XX | 01 | 1 | DLVR-01 | smoke | `cd web && npm run build` | ❌ W0 | ⬜ pending |
| 05-01-XX | 01 | 1 | DLVR-02 | manual | Visual: click through all 8 modules in sidebar | manual-only | ⬜ pending |
| 05-01-XX | 01 | 1 | DLVR-03 | manual | Visual: search for "eigenvalue" in Pagefind search | manual-only | ⬜ pending |
| 05-01-XX | 01 | 1 | DLVR-04 | manual | Visual: click dark mode toggle | manual-only | ⬜ pending |
| 05-01-XX | 01 | 1 | DLVR-05 | manual | Browser dev tools responsive mode check | manual-only | ⬜ pending |
| 05-01-XX | 01 | 1 | CODE-01 | manual | Visual: code blocks show colored MATLAB syntax | manual-only | ⬜ pending |
| 05-01-XX | 01 | 1 | CODE-02 | manual | Click copy button on code block, paste elsewhere | manual-only | ⬜ pending |
| 05-02-XX | 02 | 1 | CODE-03 | manual | Click download link, verify .m file downloads | manual-only | ⬜ pending |
| 05-02-XX | 02 | 2 | DEPL-01 | smoke | `curl -s -o /dev/null -w "%{http_code}" https://stigsb.github.io/matlab-course/` | ❌ W0 | ⬜ pending |
| 05-02-XX | 02 | 2 | DEPL-02 | smoke | Push commit, verify GitHub Actions run succeeds | manual-only | ⬜ pending |

*Status: ⬜ pending · ✅ green · ❌ red · ⚠️ flaky*

---

## Wave 0 Requirements

- [ ] `web/` — entire Astro/Starlight project needs scaffolding (npm init, package.json, astro.config.mjs)
- [ ] `.github/workflows/deploy.yml` — GitHub Actions workflow for Pages deployment
- [ ] GitHub Pages must be enabled in repo settings (Source: GitHub Actions)

---

## Manual-Only Verifications

| Behavior | Requirement | Why Manual | Test Instructions |
|----------|-------------|------------|-------------------|
| Sidebar navigation | DLVR-02 | UI interaction | Click through all 8 modules in sidebar, verify navigation |
| Search works | DLVR-03 | Pagefind UI interaction | Search for "eigenvalue", verify results appear |
| Dark mode toggle | DLVR-04 | Visual/CSS behavior | Click toggle, verify colors change |
| Mobile responsive | DLVR-05 | Visual layout check | Open browser dev tools, test at 375px width |
| MATLAB syntax highlighting | CODE-01 | Visual color check | Verify code blocks show colored syntax |
| Copy to clipboard | CODE-02 | Clipboard interaction | Click copy button, paste in editor |
| Download .m files | CODE-03 | File download | Click download links, verify .m files download |
| Auto-deploy on push | DEPL-02 | GitHub Actions pipeline | Push commit, check Actions tab for successful run |

---

## Validation Sign-Off

- [ ] All tasks have `<automated>` verify or Wave 0 dependencies
- [ ] Sampling continuity: no 3 consecutive tasks without automated verify
- [ ] Wave 0 covers all MISSING references
- [ ] No watch-mode flags
- [ ] Feedback latency < 15s
- [ ] `nyquist_compliant: true` set in frontmatter

**Approval:** pending

# Roadmap: Matlab for Computational Neuroscience

## Milestones

- v1.0 Matlab for Computational Neuroscience - Phases 1-4 (shipped 2026-03-15)
- v1.1 Interactive Version - Phases 5-7 (in progress)

## Phases

<details>
<summary>v1.0 (Phases 1-4) - SHIPPED 2026-03-15</summary>

- [x] Phase 1: Matlab Survival Kit (2/2 plans) - completed 2026-03-15
- [x] Phase 2: Programming and Math Foundations (2/2 plans) - completed 2026-03-15
- [x] Phase 3: Neural Coding and Information Theory (2/2 plans) - completed 2026-03-15
- [x] Phase 4: Dimensionality Reduction and Attractor Networks (2/2 plans) - completed 2026-03-15

</details>

### v1.1 Interactive Version

**Milestone Goal:** Deploy the course as an interactive web app on GitHub Pages with guided lesson flow, code downloads, progress tracking, and AI-powered exercise feedback.

**Phase Numbering:**
- Integer phases (5, 6, 7): Planned milestone work
- Decimal phases (5.1, 5.2): Urgent insertions (marked with INSERTED)

- [ ] **Phase 5: Site Foundation and Deploy** - Scaffold Astro/Starlight site, migrate all content, configure code display, and deploy to GitHub Pages
- [ ] **Phase 6: Progress Tracking** - localStorage-based progress with Done buttons, sidebar indicators, dashboard, and export/import backup
- [ ] **Phase 7: AI-Powered Feedback** - Exercise code submission with AI correctness checking via OpenAI API

## Phase Details

### Phase 5: Site Foundation and Deploy
**Goal**: Christel can browse all 8 modules as a navigable website with syntax-highlighted code, copy/download scripts, and access the site publicly on GitHub Pages
**Depends on**: v1.0 content (complete)
**Requirements**: DLVR-01, DLVR-02, DLVR-03, DLVR-04, DLVR-05, CODE-01, CODE-02, CODE-03, DEPL-01, DEPL-02
**Success Criteria** (what must be TRUE):
  1. User can read all 12 lessons as formatted web pages with headings, lists, and code blocks
  2. User can navigate between modules and lessons via a sidebar, and search across all content
  3. User sees MATLAB code with syntax highlighting and can copy snippets or download .m files
  4. Site works on mobile devices and supports dark mode toggle
  5. Site is publicly accessible on GitHub Pages and auto-deploys on push
**Plans:** 3 plans

Plans:
- [ ] 05-01-PLAN.md — Scaffold Astro/Starlight project, configure for GitHub Pages, create landing page and deploy workflow
- [ ] 05-02-PLAN.md — Migrate all 8 lessons, 4 reference cards, and 45 .m scripts into the site
- [ ] 05-03-PLAN.md — Deploy to GitHub Pages and visual verification of complete site

### Phase 6: Progress Tracking
**Goal**: Christel can track her completion across all modules with persistent progress that survives browser sessions
**Depends on**: Phase 5
**Requirements**: PROG-01, PROG-02, PROG-03, PROG-04, PROG-05
**Success Criteria** (what must be TRUE):
  1. User can mark any lesson or exercise as "Done" and the state persists across browser sessions
  2. User sees completion indicators (checkmarks) in the sidebar navigation
  3. User can view a progress dashboard showing completion percentage per module
  4. User can export progress data as a file and import it back (backup against localStorage loss)
**Plans**: TBD

Plans:
- [ ] 06-01: TBD
- [ ] 06-02: TBD

### Phase 7: AI-Powered Feedback
**Goal**: Christel can get instant feedback on her exercise code without waiting for human review
**Depends on**: Phase 5 (lesson pages with code blocks), Phase 6 (exercise completion tracking)
**Requirements**: CODE-04, CODE-05
**Success Criteria** (what must be TRUE):
  1. User can paste or type exercise code into a submission area and receive AI-generated correctness feedback
  2. User can configure their OpenAI API key in a settings page, persisted in localStorage
**Plans**: TBD

Plans:
- [ ] 07-01: TBD

## Progress

**Execution Order:**
Phases execute in numeric order: 5 -> 5.x -> 6 -> 6.x -> 7

| Phase | Milestone | Plans Complete | Status | Completed |
|-------|-----------|----------------|--------|-----------|
| 1. Matlab Survival Kit | v1.0 | 2/2 | Complete | 2026-03-15 |
| 2. Programming and Math Foundations | v1.0 | 2/2 | Complete | 2026-03-15 |
| 3. Neural Coding and Information Theory | v1.0 | 2/2 | Complete | 2026-03-15 |
| 4. Dimensionality Reduction and Attractor Networks | v1.0 | 2/2 | Complete | 2026-03-15 |
| 5. Site Foundation and Deploy | v1.1 | 0/3 | Not started | - |
| 6. Progress Tracking | v1.1 | 0/? | Not started | - |
| 7. AI-Powered Feedback | v1.1 | 0/? | Not started | - |

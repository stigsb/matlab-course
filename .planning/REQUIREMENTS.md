# Requirements: Matlab for Computational Neuroscience

**Defined:** 2026-03-16
**Core Value:** Christel can independently write and understand Matlab code for neural data analysis and computational neuroscience modeling

## v1.1 Requirements

Requirements for interactive web version. Each maps to roadmap phases.

### Content Delivery

- [ ] **DLVR-01**: User can read course lessons as web pages with formatted text and code blocks
- [ ] **DLVR-02**: User can navigate between modules and lessons via sidebar
- [ ] **DLVR-03**: User can search across all course content
- [ ] **DLVR-04**: User can toggle dark mode
- [ ] **DLVR-05**: User can use the site on mobile devices with responsive layout

### Code Workflow

- [ ] **CODE-01**: User sees MATLAB code with syntax highlighting in lessons
- [ ] **CODE-02**: User can copy code snippets to clipboard with one click
- [ ] **CODE-03**: User can download .m script files from lesson pages
- [ ] **CODE-04**: User can submit exercise code for AI-powered correctness feedback
- [ ] **CODE-05**: User can configure their OpenAI API key in settings (persisted in localStorage)

### Progress Tracking

- [ ] **PROG-01**: User can mark a lesson or exercise as "Done"
- [ ] **PROG-02**: User sees completion indicators in the sidebar navigation
- [ ] **PROG-03**: User can view a progress dashboard showing module completion status
- [ ] **PROG-04**: User can export/import progress data as backup
- [ ] **PROG-05**: Progress storage layer is abstracted to allow future cloud backend (e.g. Cloudflare D1)

### Deployment

- [ ] **DEPL-01**: Site is deployed to GitHub Pages and publicly accessible
- [ ] **DEPL-02**: Site rebuilds and deploys automatically on push via GitHub Actions

## Future Requirements

### Notation & Exam Prep

- **NOTN-01**: User can practice reading mathematical notation connected to visual understanding
- **NOTN-02**: User can work through pen-and-paper problem sets
- **NOTN-03**: User can access summary/reference sheets for each topic

### Cloud Storage

- **CLOUD-01**: User progress syncs to cloud backend (e.g. Cloudflare D1)

## Out of Scope

| Feature | Reason |
|---------|--------|
| Browser-based MATLAB execution | No production-ready WASM port exists; Christel has MATLAB Desktop via NTNU |
| User accounts / authentication | Single user, localStorage is sufficient for v1.1 |
| Backend server | Static site on GitHub Pages; AI grading uses client-side API calls |
| Video content | Text + interactive scripts is the established format |
| MATLAB Online embedding | Auth/iframe restrictions make it impractical |

## Traceability

Which phases cover which requirements. Updated during roadmap creation.

| Requirement | Phase | Status |
|-------------|-------|--------|
| DLVR-01 | Phase 5 | Pending |
| DLVR-02 | Phase 5 | Pending |
| DLVR-03 | Phase 5 | Pending |
| DLVR-04 | Phase 5 | Pending |
| DLVR-05 | Phase 5 | Pending |
| CODE-01 | Phase 5 | Pending |
| CODE-02 | Phase 5 | Pending |
| CODE-03 | Phase 5 | Pending |
| CODE-04 | Phase 7 | Pending |
| CODE-05 | Phase 7 | Pending |
| PROG-01 | Phase 6 | Pending |
| PROG-02 | Phase 6 | Pending |
| PROG-03 | Phase 6 | Pending |
| PROG-04 | Phase 6 | Pending |
| PROG-05 | Phase 6 | Pending |
| DEPL-01 | Phase 5 | Pending |
| DEPL-02 | Phase 5 | Pending |

**Coverage:**
- v1.1 requirements: 17 total
- Mapped to phases: 17
- Unmapped: 0

---
*Requirements defined: 2026-03-16*
*Last updated: 2026-03-16 after roadmap creation*

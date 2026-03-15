# Research Summary: v1.1 Interactive Web App

**Domain:** Interactive course delivery web app (GitHub Pages)
**Researched:** 2026-03-16 (updated for stack decision)
**Overall confidence:** HIGH

## Executive Summary

The v1.1 milestone adds a web delivery layer to the existing 8-module Matlab course. The content is done (45 scripts, 12 lessons, 4 reference cards). The new work is purely about presentation and interaction: render lessons as a navigable website, track progress with localStorage, and provide easy download/copy of .m scripts.

The recommended stack is **Astro 5.x + Starlight + Preact islands + nanostores/persistent**. Starlight provides sidebar navigation, full-text search (Pagefind), dark mode, responsive layout, MATLAB syntax highlighting (Shiki), and code copy-to-clipboard out of the box. This covers roughly 80% of the table-stakes features with zero custom code. The remaining 20% -- progress tracking via "Mark as Done" buttons and a progress dashboard -- is implemented as Preact islands using nanostores/persistent for localStorage state management.

Browser-based MATLAB execution is **not feasible** for a static site. There is no production-ready WebAssembly port of MATLAB, and Octave WASM alternatives are experimental. Since Christel already has MATLAB installed via NTNU's campus license, the correct approach is a download workflow: view syntax-highlighted code in the browser, copy or download the .m file, run it in MATLAB Desktop.

The biggest risk is **overengineering**. This is a single-user course site, not a learning management system. Every technology choice should be justified by "does this help Christel learn MATLAB faster?" not "is this architecturally elegant?" Starlight makes this easier by providing good defaults that don't need customization.

## Key Findings

**Stack:** Astro 5.x + Starlight 0.37.x for static site generation, Preact for interactive islands, nanostores/persistent for localStorage progress tracking. Shiki (bundled) for MATLAB syntax highlighting. Deploy via GitHub Actions to GitHub Pages.

**Architecture:** Starlight's content collections map directly to the 8 module directories. Existing lesson.md files need frontmatter additions. .m files serve from public/scripts/ for download. Interactive progress tracking runs as isolated Preact islands within an otherwise fully static site.

**Critical pitfall:** Safari's ITP can evict localStorage after 7 days of inactivity. Build an export/import progress backup alongside the initial implementation, not as an afterthought.

## Implications for Roadmap

Based on research, suggested phase structure:

1. **Project Scaffolding + Content Migration** - Set up Astro/Starlight, migrate lesson markdown with frontmatter, verify all 8 modules render correctly
   - Addresses: Lesson rendering, sidebar navigation, search, dark mode, responsive layout
   - Avoids: Overengineering (Pitfall 2) by using Starlight defaults

2. **Code Display + Downloads** - Configure MATLAB syntax highlighting, add download links for .m files, verify copy-to-clipboard works
   - Addresses: Code highlighting, file downloads, copy-to-clipboard
   - Avoids: Attempting browser-based MATLAB execution (Pitfall 4)

3. **Progress Tracking** - Implement nanostores/persistent store, "Mark as Done" Preact islands, sidebar completion indicators
   - Addresses: Per-lesson progress, persistent state, module completion visualization
   - Avoids: localStorage eviction surprise (Pitfall 1) by including export/import backup

4. **Progress Dashboard + Polish** - Build dashboard page, "continue where you left off", encouraging completion messaging
   - Addresses: Progress overview, session resumption
   - Avoids: Punishing dashboard design (Pitfall 7) by showing completed items, not remaining

5. **Deploy to GitHub Pages** - GitHub Actions workflow, verify production build, test on multiple devices
   - Addresses: Public accessibility
   - Avoids: Shipping broken content (Pitfall 10) by requiring end-to-end test first

**Phase ordering rationale:**
- Phase 1 must come first: everything depends on content rendering correctly in Starlight
- Phase 2 naturally follows: code display is part of lesson pages
- Phase 3 is the core differentiator and depends on lesson pages existing
- Phase 4 builds on Phase 3's progress store
- Phase 5 can happen as early as after Phase 1 (deploy early, iterate), but full feature deployment waits for Phase 4

**Research flags for phases:**
- Phase 1: May need research on Starlight component overrides if lesson.md format needs adaptation
- Phase 3: Starlight sidebar override for completion indicators may need investigation
- Phase 5: Standard GitHub Actions workflow, unlikely to need research

## Confidence Assessment

| Area | Confidence | Notes |
|------|------------|-------|
| Stack (Astro/Starlight) | HIGH | Astro is the leading content-site framework. Starlight powers docs for Cloudflare, Google, Microsoft, OpenAI. Well-documented GitHub Pages deployment. |
| Stack (Preact + nanostores) | HIGH | Astro-recommended pattern for interactive islands with shared state. Official recipes in Astro docs. |
| Features | HIGH | Table stakes are Starlight defaults. Differentiators are well-scoped. Anti-features clearly identified. |
| Architecture | HIGH | Content collections + islands is Astro's core architecture. No custom patterns needed. |
| MATLAB in-browser | HIGH | Definitively not feasible for static site. Download workflow is the right answer. |
| Pitfalls | HIGH | localStorage eviction is well-documented. Overengineering risk is real but Starlight mitigates it. |

## Gaps to Address

- **Starlight sidebar component override for progress indicators:** How exactly to inject completion checkmarks into Starlight's sidebar. The override API exists but specifics need investigation during Phase 3.
- **Astro 5 vs 6 timing:** Astro 6 released March 10, 2026. Currently recommending 5.x for stability. May upgrade if Starlight 0.38+ stabilizes during development.
- **Content migration details:** Exact frontmatter format and whether existing lesson.md files need structural changes beyond adding a YAML header. Needs hands-on testing.
- **Safari localStorage behavior verification:** Need to verify current Safari ITP behavior with a real test, not just documented claims.

## Sources

All sources documented in individual research files:
- [STACK.md](/Users/stig/git/stigsb/matlab-course/.planning/research/STACK.md) -- Technology decisions with rationale
- [FEATURES.md](/Users/stig/git/stigsb/matlab-course/.planning/research/FEATURES.md) -- Feature landscape and prioritization
- [ARCHITECTURE.md](/Users/stig/git/stigsb/matlab-course/.planning/research/ARCHITECTURE.md) -- System structure and patterns
- [PITFALLS.md](/Users/stig/git/stigsb/matlab-course/.planning/research/PITFALLS.md) -- Domain pitfalls and mitigations

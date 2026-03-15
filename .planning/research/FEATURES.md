# Feature Landscape: v1.1 Interactive Web App

**Domain:** Interactive course delivery web app (GitHub Pages)
**Researched:** 2026-03-16 (updated for Starlight stack decision)
**Scope:** NEW features for web delivery only. Course content features already validated in v1.0.

## Table Stakes

Features users expect. Missing = product feels incomplete. With Starlight, most of these are free.

| Feature | Why Expected | Complexity | Notes |
|---------|--------------|------------|-------|
| Sidebar navigation by module | Structured content needs structured navigation | **Free** | Starlight generates from directory structure + frontmatter |
| Rendered markdown lessons | Raw markdown is unacceptable | **Free** | Starlight's core purpose |
| MATLAB syntax highlighting | Code must be readable | **Free** | Shiki built into Astro, MATLAB grammar included |
| Mobile-responsive layout | May study on phone | **Free** | Starlight default theme is responsive |
| Dark mode toggle | Modern web standard | **Free** | Starlight includes this |
| Full-text search | Finding topics across 12 lessons | **Free** | Pagefind built into Starlight |
| Table of contents per lesson | Jump to sections in long lessons | **Free** | Starlight generates from headings |
| Copy-to-clipboard on code blocks | Quick way to grab snippets | **Free** | Expressive Code built into Starlight |
| Downloadable .m script files | She needs to run these in MATLAB | Low | HTML5 `download` links to files in public/scripts/ |
| Prev/next lesson navigation | Sequential course flow | **Free** | Starlight generates from sidebar order |

**Key insight:** Starlight provides 9 of 10 table-stakes features with zero custom code. The only custom work is organizing .m files for download.

## Differentiators

Features that make this more than "content on a website."

| Feature | Value Proposition | Complexity | Notes |
|---------|-------------------|------------|-------|
| Per-lesson "Mark as Done" button | Progress tracking. ADHD-friendly completion feedback. | Medium | Preact island + nanostores/persistent. Core v1.1 feature. |
| Progress dashboard | Visual overview of completion across 8 modules. | Medium | Preact island reading same nanostores progress map. |
| Module completion indicators in sidebar | At-a-glance status without visiting dashboard. | Medium | Starlight sidebar component override. Could be deferred if complex. |
| "Continue where you left off" | Reduces session-start friction. | Low | Store last visited lesson in nanostores, show on landing page. |
| Exercise/solution reveal | Hide solutions by default to encourage attempting first. | Low | Starlight `<details>` element or custom Aside component. |
| Download links per module | Grouped script downloads next to relevant lessons. | Low | Static links in markdown content. |
| Estimated time per lesson | Reduces anxiety about starting; helps plan study sessions. | Low | Static frontmatter metadata. |

## Anti-Features

Features to explicitly NOT build.

| Anti-Feature | Why Avoid | What to Do Instead |
|--------------|-----------|-------------------|
| Browser-based MATLAB execution | No production-ready solution. Pedagogically wrong. | Download/copy workflow with syntax-highlighted preview. |
| User accounts / authentication | Single user, static site, no backend. | localStorage for all state. |
| Cloud-synced progress | Requires backend. One user, one or two devices. | localStorage + export/import backup. |
| Embedded code editor (Monaco/CodeMirror) | Wrong workflow. She should edit in MATLAB Desktop. | Read-only code blocks with copy-to-clipboard. |
| Quiz/assessment engine | Overkill. Pen-and-paper practice is better exam prep. | Collapsible self-check questions in markdown. |
| Tailwind CSS | Fights Starlight's design system. Two CSS systems is worse than one. | Starlight CSS custom properties for theming. |
| Analytics / tracking | Privacy-invasive, unnecessary for single user. | None. |
| Gamification | One student, no social comparison. Hollow without community. | Simple completion tracking with encouraging messages. |
| Complex animations | MATLAB generates the plots. JS recreation is wasted effort. | Show plot screenshots from MATLAB output. |
| PWA / Service Workers | Offline unnecessary. She needs MATLAB to do exercises. | Simple static site. |
| i18n | Course is English-only per PROJECT.md. | No internationalization infrastructure. |

## Feature Dependencies

```
Starlight (provides free features)
  ├── Sidebar navigation (free)
  ├── Markdown rendering + Shiki highlighting (free)
  ├── Search / Pagefind (free)
  ├── Dark mode (free)
  ├── Copy-to-clipboard (free)
  ├── Table of contents (free)
  ├── Prev/next navigation (free)
  └── Responsive layout (free)

nanostores/persistent store (custom)
  ├── "Mark as Done" buttons (Preact island)
  ├── Progress dashboard (Preact island)
  ├── Sidebar completion indicators (Starlight override)
  ├── "Continue where you left off" (reads last visited)
  └── Export/import progress backup

Static file serving (public/)
  └── Download links for .m files

Content markdown
  ├── Exercise/solution reveal (<details>)
  └── Estimated time (frontmatter metadata)
```

## MVP Recommendation

### Ship first (Phase 1-2): Content readable and downloadable

All Starlight free features + download links. No custom interactive code needed.

1. All 8 module lessons rendered in Starlight
2. Sidebar navigation with module grouping
3. MATLAB syntax highlighting in all code blocks
4. Copy-to-clipboard on code blocks
5. Downloadable .m files per lesson
6. Full-text search
7. Dark mode, responsive layout, table of contents

### Ship second (Phase 3): Progress tracking

The core differentiator.

8. Per-lesson "Mark as Done" button (Preact island)
9. Progress stored in localStorage via nanostores/persistent
10. Export/import progress backup (Safari eviction protection)

### Ship third (Phase 4): Dashboard and polish

11. Progress dashboard page
12. "Continue where you left off" on landing page
13. Sidebar completion indicators (or simpler per-page indicator)
14. Exercise/solution collapsible sections
15. Estimated time per lesson (frontmatter)

### Defer indefinitely

- Browser MATLAB execution
- User accounts
- Cloud sync
- Embedded editor
- Gamification
- Analytics

## Sources

- [Starlight: Built-in Features](https://starlight.astro.build/) -- What comes free
- [Starlight: Using Components](https://starlight.astro.build/components/using-components/) -- Built-in component library
- [Expressive Code](https://expressive-code.com/) -- Code block features (copy, highlighting)
- [Astro: Share State Between Islands](https://docs.astro.build/en/recipes/sharing-state-islands/) -- Progress tracking pattern
- [@nanostores/persistent](https://github.com/nanostores/persistent) -- localStorage persistence

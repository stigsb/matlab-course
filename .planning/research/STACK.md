# Technology Stack: v1.1 Interactive Web App

**Project:** Matlab for Computational Neuroscience -- Interactive Version
**Researched:** 2026-03-16
**Scope:** NEW stack additions for GitHub Pages web app delivery. Does NOT replace v1.0 STACK.md (Matlab course content stack remains unchanged).

## Recommended Stack

### Static Site Generator

| Technology | Version | Purpose | Why |
|------------|---------|---------|-----|
| Astro | ^5.18 (latest 5.x) | Static site framework | Content-driven by design. Zero JS by default, islands for interactive bits. Content Collections map perfectly to 8 course modules. Built-in Markdown rendering with Shiki syntax highlighting (MATLAB supported). GitHub Pages deployment is a first-class workflow with official GitHub Action. |
| @astrojs/starlight | ^0.37 | Documentation theme | Purpose-built for structured content with sidebar navigation, search (Pagefind), dark mode, mobile-responsive layout. Saves weeks of UI work. Supports component overrides for custom progress tracking UI. |

**Why Astro 5.x, not Astro 6:** Astro 6.0 released March 10, 2026 (6 days ago). It requires Node 22+ and introduces breaking changes. Starlight 0.38 adds Astro 6 support but is hours old. For a course site where stability matters more than bleeding-edge features, stick with Astro 5.x + Starlight 0.37.x. Upgrade to Astro 6 after the ecosystem stabilizes (1-2 months).

**Why Starlight, not plain Astro:** This is structured educational content with a clear sidebar hierarchy (8 modules, lessons within each). Starlight provides sidebar navigation, full-text search, table of contents, mobile layout, and accessibility out of the box. Building this from scratch in plain Astro would take weeks for zero pedagogical benefit.

**Why not Jekyll/Hugo/MkDocs:** Jekyll is fine for simple sites but lacks the island architecture needed for interactive progress tracking without a full SPA. Hugo and MkDocs are documentation-focused but don't support interactive client-side components as cleanly as Astro's islands. Astro lets us add localStorage-backed progress tracking as isolated interactive islands within an otherwise static site.

### Interactive Components (Progress Tracking)

| Technology | Version | Purpose | Why |
|------------|---------|---------|-----|
| @astrojs/preact | ^4.1 | Client-side interactive islands | Preact is 3KB (vs React's 40KB+). Sufficient for progress buttons, dashboard, and state display. Astro's `client:load` directive hydrates only these components. |
| nanostores | ^0.11 | State management across islands | Astro-recommended solution for sharing state between islands. 286 bytes. Works with Preact out of the box. |
| @nanostores/persistent | ^0.10 | localStorage persistence | Wraps nanostores with automatic localStorage sync. Progress survives page reloads and browser restarts. Syncs across tabs. |

**Why Preact, not React:** The interactive surface area is tiny -- "Mark as Done" buttons and a progress dashboard. Preact's 3KB footprint vs React's 40KB+ is the right trade for a site that should feel fast. Preact's API is React-compatible, so no learning curve cost.

**Why nanostores, not raw localStorage:** Multiple interactive islands on a page (e.g., a "Done" button and a progress indicator in the sidebar) need shared state. Nanostores + @nanostores/persistent gives reactive state that auto-persists to localStorage and syncs across tabs. Rolling your own with raw localStorage means writing event listeners, JSON serialization, and cross-tab sync from scratch.

### Syntax Highlighting

| Technology | Version | Purpose | Why |
|------------|---------|---------|-----|
| Shiki (built into Astro) | N/A (bundled) | MATLAB code highlighting | Astro uses Shiki by default. Shiki supports MATLAB via the official MathWorks TextMate grammar (`mathworks/MATLAB-Language-grammar`). No configuration needed -- just use `matlab` as the language identifier in fenced code blocks. VS Code-quality highlighting out of the box. |

### Search

| Technology | Version | Purpose | Why |
|------------|---------|---------|-----|
| Pagefind (built into Starlight) | N/A (bundled) | Full-text search across all lessons | Starlight includes Pagefind automatically. Runs at build time to index all content, then provides instant client-side search with no server. Zero configuration needed. |

### Deployment

| Technology | Version | Purpose | Why |
|------------|---------|---------|-----|
| GitHub Pages | N/A | Static hosting | Free, already where the repo lives. No server to manage. Custom domain optional but unnecessary for a personal course. |
| GitHub Actions | N/A | Build + deploy pipeline | Astro provides an official `withastro/action` GitHub Action. Push to main, site deploys automatically. |

### File Downloads

| Technology | Version | Purpose | Why |
|------------|---------|---------|-----|
| Static file serving | N/A | Downloadable .m files | Astro's `public/` directory serves static files as-is. Place .m files there (or in a structured subdirectory), link with `<a href="/scripts/demo_hello.m" download>`. No library needed. HTML5 `download` attribute handles it. |

## Browser-Based MATLAB Execution: Assessment

### Verdict: DO NOT BUILD. Recommend download workflow instead.

**Why not:**

1. **MATLAB cannot run in-browser.** There is no WebAssembly port of MATLAB. MathWorks offers MATLAB Online (cloud-hosted, requires license login) and MATLAB Web App Server (requires server infrastructure). Neither works as an embedded static-site component.

2. **GNU Octave WebAssembly exists but is experimental.** The Sable/matwably project is a research prototype, not production-ready. RunMat offers browser-based MATLAB-compatible execution via WebAssembly but is a third-party service, not embeddable.

3. **Christel already has MATLAB installed.** She has an NTNU campus license. The value of browser execution is low when the target user already has the real tool.

4. **Pedagogical mismatch.** A sandboxed browser environment would not match the real MATLAB Desktop experience she needs for NEVR3004. Learning in a different environment creates transfer problems.

### Recommended Alternative: Download + Copy Workflow

- Each lesson page shows MATLAB code with syntax highlighting (Shiki)
- "Download .m file" button links to the actual script
- "Copy to clipboard" button on code blocks (Starlight supports this via Expressive Code)
- She opens the .m file in MATLAB Desktop and runs it there
- Optional: link to MATLAB Online for quick experiments (but don't depend on it)

This is simpler, more reliable, and teaches in the actual environment she'll use.

## What NOT to Add

| Technology | Why Not |
|------------|---------|
| React | Overkill. 40KB+ for a few buttons. Preact does the same at 3KB. |
| Next.js / Remix / SvelteKit | These are application frameworks. This is a content site with tiny interactive islands, not a web app. |
| Tailwind CSS | Starlight has its own design system. Adding Tailwind creates two styling systems fighting each other. Use Starlight's CSS custom properties for theming. |
| Database / Supabase / Firebase | localStorage is sufficient for single-user progress tracking. A database adds auth, hosting, and complexity for zero benefit. |
| MATLAB WebAssembly / Octave WASM | See assessment above. Not production-ready, not needed, pedagogically wrong. |
| Monaco Editor / CodeMirror | Embedding a code editor is tempting but unnecessary. She should edit in MATLAB Desktop. A read-only syntax-highlighted code block with copy-to-clipboard is the right UX. |
| Service Workers / PWA | Adds complexity. GitHub Pages serves fast static files. Offline support is unnecessary -- she needs MATLAB installed to do the exercises anyway. |
| MDX | Starlight supports MDX but plain Markdown with Astro components is simpler. MDX adds a compilation layer and makes content less portable. Use Starlight's built-in component system instead. |
| i18n | Course is English-only per PROJECT.md. Don't add internationalization infrastructure. |

## Alternatives Considered

| Category | Recommended | Alternative | Why Not |
|----------|-------------|-------------|---------|
| Framework | Astro + Starlight | Jekyll | No island architecture for interactive progress tracking. Would need a separate JS bundle. |
| Framework | Astro + Starlight | Hugo | Same issue. Great for static docs, poor for interactive islands. |
| Framework | Astro + Starlight | MkDocs Material | Python-based, interactive components require custom JS escape hatches. |
| Framework | Astro + Starlight | VitePress | Vue-based, decent option, but less mature ecosystem for custom islands than Astro. |
| UI library | Preact | Vanilla JS | Vanilla works for one button, breaks down for reactive state across multiple islands. Nanostores integration requires a framework. |
| UI library | Preact | Svelte | Also good. Chose Preact because Astro docs specifically recommend nanostores + Preact for island state sharing. |
| State | nanostores | Zustand | Zustand is React-specific and 1KB vs nanostores' 286 bytes. Nanostores is framework-agnostic. |
| Progress storage | localStorage | IndexedDB | IndexedDB is for large/complex data. Progress is a simple object mapping lesson IDs to booleans. localStorage is the right tool. |

## Installation

```bash
# Create new Astro project with Starlight template
npm create astro@latest -- --template starlight

# Add Preact integration for interactive islands
npx astro add preact

# Add state management for progress tracking
npm install nanostores @nanostores/persistent

# Dev dependencies (already included by Astro)
# - shiki (syntax highlighting, bundled)
# - pagefind (search, bundled by Starlight)
```

### Project Structure (new files only)

```
matlab-course/
  web/                          # New: Astro project root
    astro.config.mjs            # Astro + Starlight + Preact config
    src/
      content/
        docs/                   # Course content as .md files
          01-first-steps/
            index.md            # Converted from lesson.md
          02-vectors-and-plotting/
            index.md
          ...
      components/
        ProgressButton.tsx      # Preact "Mark as Done" island
        ProgressDashboard.tsx   # Preact progress overview island
      stores/
        progress.ts             # nanostores/persistent store
    public/
      scripts/                  # Downloadable .m files
        01-first-steps/
          demo_hello.m
          demo_variables.m
          ...
```

### Content Migration Strategy

Existing markdown lessons in each module's `lesson.md` become Starlight pages in `src/content/docs/`. The .m script files move to `public/scripts/` for download serving. Starlight's frontmatter handles sidebar ordering and titles:

```markdown
---
title: First Steps with MATLAB
sidebar:
  order: 1
---

# Welcome to MATLAB

[existing lesson content here]

## Download Scripts

- [demo_hello.m](/scripts/01-first-steps/demo_hello.m)
- [demo_variables.m](/scripts/01-first-steps/demo_variables.m)
```

## Integration Points

### Content Collections <-> Existing Modules

Each of the 8 existing module directories maps to a Starlight docs section. Lesson markdown content is already written -- it needs frontmatter addition and minor formatting adjustments, not a rewrite.

### Progress Store <-> Lesson Pages

The nanostores/persistent store holds a simple map:

```typescript
// stores/progress.ts
import { persistentMap } from '@nanostores/persistent'

export const progress = persistentMap<Record<string, boolean>>('course-progress:', {})
```

Each lesson page includes a `<ProgressButton client:load lessonId="01-01" />` island that reads/writes this store. The sidebar or a dashboard page reads the same store to show completion status.

### .m Files <-> Download Links

The existing .m files are copied (or symlinked at build time) into `public/scripts/`. Each lesson page's markdown includes download links. Expressive Code (built into Starlight) provides copy-to-clipboard on code blocks.

## Version Compatibility Matrix

| Package | Version | Node Requirement | Notes |
|---------|---------|------------------|-------|
| astro | ^5.18 | Node 18+ | Stable. Avoid 6.x until ecosystem catches up. |
| @astrojs/starlight | ^0.37 | (via Astro) | Latest 0.37.x for Astro 5 compat. |
| @astrojs/preact | ^4.1 | (via Astro) | Maintained by Astro core team. |
| preact | ^10.x | (via @astrojs/preact) | Auto-installed as peer dependency. |
| nanostores | ^0.11 | Any | 286 bytes, zero dependencies. |
| @nanostores/persistent | ^0.10 | Any | ~400 bytes, depends on nanostores. |

## Sources

- [Astro Documentation: Deploy to GitHub Pages](https://docs.astro.build/en/guides/deploy/github/) -- Official deployment guide
- [Astro Documentation: Islands Architecture](https://docs.astro.build/en/concepts/islands/) -- Island hydration model
- [Astro Documentation: Share State Between Islands](https://docs.astro.build/en/recipes/sharing-state-islands/) -- Nanostores recipe
- [Starlight Documentation: Getting Started](https://starlight.astro.build/getting-started/) -- Starlight setup and features
- [Starlight Documentation: Overriding Components](https://starlight.astro.build/guides/overriding-components/) -- Custom component injection
- [Starlight GitHub: Releases](https://github.com/withastro/starlight/releases) -- Version history and changelogs
- [Astro 6 Release Blog](https://astro.build/blog/astro-6/) -- Why we're waiting on 6.x
- [@nanostores/persistent GitHub](https://github.com/nanostores/persistent) -- localStorage persistence for nanostores
- [Shiki Languages](https://shiki.style/languages) -- Confirms MATLAB grammar support via mathworks/MATLAB-Language-grammar
- [MathWorks MATLAB-Language-grammar](https://github.com/mathworks/MATLAB-Language-grammar) -- Official TextMate grammar used by Shiki
- [Expressive Code: Syntax Highlighting](https://expressive-code.com/key-features/syntax-highlighting/) -- Starlight's code block rendering engine
- [Sable/matwably GitHub](https://github.com/Sable/matwably) -- MATLAB WebAssembly research prototype (NOT recommended)
- [MATLAB Online](https://www.mathworks.com/products/matlab-online.html) -- MathWorks cloud option (requires login)

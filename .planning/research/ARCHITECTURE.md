# Architecture Patterns: v1.1 Interactive Web App

**Domain:** Static course web app on GitHub Pages with progress tracking
**Researched:** 2026-03-16 (updated for Starlight stack decision)
**Confidence:** HIGH

## System Overview

The web app is a **Starlight documentation site** wrapping existing course content. Starlight handles rendering, navigation, search, and theming. Custom Preact islands handle progress tracking. The architecture is deliberately simple: static HTML with tiny interactive islands.

```
┌─────────────────────────────────────────────────────────────────┐
│                     EXISTING (unchanged)                        │
│                                                                 │
│  01-first-steps/          05-neural-coding/                     │
│    lesson.md                lesson.md                           │
│    demo_hello.m             demo_spike_trains.m                 │
│    exercise_variables.m     ...                                 │
│    solution_variables.m   reference/                            │
│    ...                      matlab_basics.md                    │
│  02-vectors-and-plotting/   ...                                 │
│    ...                                                          │
│  (8 module dirs total)                                          │
├─────────────────────────────────────────────────────────────────┤
│                     NEW (Starlight web layer)                   │
│                                                                 │
│  web/                         ← Astro project root              │
│    astro.config.mjs           ← Starlight + Preact config       │
│    src/                                                         │
│      content/                                                   │
│        docs/                  ← Starlight content directory      │
│          01-first-steps/                                        │
│            index.md           ← lesson.md + frontmatter          │
│            exercises.md       ← optional: exercise listing       │
│          02-vectors-and-plotting/                                │
│            index.md                                              │
│          ...                  ← 8 module sections                │
│          reference/                                              │
│            matlab-basics.md                                      │
│            ...                                                   │
│      components/                                                │
│        ProgressButton.tsx     ← Preact "Mark as Done" island     │
│        ProgressDashboard.tsx  ← Preact progress overview         │
│        ProgressSidebar.astro  ← Starlight sidebar override       │
│      stores/                                                    │
│        progress.ts            ← nanostores/persistent store      │
│    public/                                                      │
│      scripts/                 ← .m files for download            │
│        01-first-steps/                                           │
│        02-vectors-and-plotting/                                  │
│        ...                                                       │
│    .github/workflows/                                           │
│      deploy.yml               ← GitHub Actions to Pages          │
└─────────────────────────────────────────────────────────────────┘
```

## Recommended Architecture: Astro + Starlight

### Why Starlight (not plain Astro)

Starlight is Astro's official documentation theme. It provides:

1. **Sidebar navigation** from directory structure and frontmatter. No custom code.
2. **Full-text search** via Pagefind. Built-in, zero config.
3. **MATLAB syntax highlighting** via Shiki with MathWorks TextMate grammar. Built-in.
4. **Copy-to-clipboard** on code blocks via Expressive Code. Built-in.
5. **Dark mode toggle.** Built-in.
6. **Mobile-responsive layout.** Built-in.
7. **Table of contents** per page. Built-in.
8. **Component override API** for injecting progress tracking into the existing layout.

Without Starlight, these features require 500-1000 lines of custom code and CSS. With Starlight, the custom code is limited to progress tracking (~150 lines of Preact + nanostores).

### Component Boundaries

| Component | Responsibility | Communicates With |
|-----------|---------------|-------------------|
| Starlight (framework) | Renders markdown pages, sidebar, search, TOC, dark mode | Content collection |
| Content collection (build-time) | Reads lesson markdown with frontmatter, validates schema | Starlight pages |
| ProgressButton.tsx (Preact island) | "Mark as Done" toggle per lesson | nanostores progress store |
| ProgressDashboard.tsx (Preact island) | Module completion overview, "continue where you left off" | nanostores progress store |
| ProgressSidebar.astro (Starlight override) | Completion indicators in sidebar | nanostores progress store |
| progress.ts (nanostores/persistent) | Reactive state synced to localStorage | All Preact islands |
| public/scripts/ (static files) | Downloadable .m files | Download links in lesson pages |

### Data Flow

```
BUILD TIME:
  lesson markdown (with frontmatter) → Astro content collection → Starlight pages
  .m files → public/scripts/ → static download URLs

BROWSER (page load):
  Static HTML renders immediately (Starlight)
  Preact islands hydrate (client:load)
  nanostores reads localStorage → progress state available
  ProgressButton shows current done/not-done state
  ProgressSidebar shows module completion indicators

BROWSER (user interaction):
  User clicks "Mark as Done" → nanostores.set() → localStorage.setItem()
  All subscribed islands react (ProgressButton checked, sidebar updated)
  nanostores/persistent syncs across browser tabs automatically
```

## Integration with Existing Content

### Content Migration Strategy

**Approach: Copy lesson content into Starlight's docs directory.** Starlight expects content in `src/content/docs/`. The existing module directories stay at the repo root for direct Matlab use.

Two practical options:

**Option A (recommended): Maintain docs content directly in web/src/content/docs/**
Create the Starlight docs content as new files that import/adapt the existing lesson.md content. This avoids build-time copy scripts and keeps the Astro project self-contained. The existing lesson.md files remain the "raw" source, and the Starlight versions add frontmatter and any web-specific formatting.

**Option B: Symlink or prebuild script**
A build script copies `*/lesson.md` to `web/src/content/docs/` with frontmatter injection. More automated but adds a build step that can break.

**Recommendation: Option A** for initial implementation. The content is stable (v1.0 shipped). Maintaining a parallel set of markdown files in Starlight's expected location is simpler than build-time file manipulation. If content changes frequently, revisit Option B.

### Frontmatter Format (Starlight)

```markdown
---
title: First Steps with MATLAB
description: Variables, the command window, and your first plot
sidebar:
  order: 1
  badge:
    text: Module 1
    variant: note
---

[lesson content here]

## Download Scripts

import { FileTree } from '@astrojs/starlight/components';

<FileTree>
- [demo_hello.m](/scripts/01-first-steps/demo_hello.m)
- [demo_variables.m](/scripts/01-first-steps/demo_variables.m)
- [exercise_variables.m](/scripts/01-first-steps/exercise_variables.m)
- [solution_variables.m](/scripts/01-first-steps/solution_variables.m)
</FileTree>
```

### Files NOT Modified

- All `.m` scripts -- untouched, copied to public/scripts/ for serving
- `.planning/` -- unaffected
- Module directories at repo root -- remain for direct Matlab use

## Patterns to Follow

### Pattern 1: Starlight Content with Custom Islands

**What:** Starlight renders all markdown content. Interactive elements are Preact islands injected via Astro's `client:load` directive.

**Why:** Keeps the static/interactive boundary clean. 95% of the site is static HTML. Only progress buttons and dashboard are interactive.

```astro
---
// In a Starlight page or custom component
---
<p>Lesson content rendered by Starlight...</p>

<!-- Interactive island -->
import ProgressButton from '../../components/ProgressButton';
<ProgressButton client:load lessonId="01-first-steps" />
```

### Pattern 2: nanostores/persistent for Progress State

**What:** A single reactive store backed by localStorage. All Preact islands subscribe to it.

**Why:** Multiple islands on a page (Done button + sidebar indicator) need shared state. nanostores handles reactivity. @nanostores/persistent handles serialization and cross-tab sync.

```typescript
// stores/progress.ts
import { persistentMap } from '@nanostores/persistent'

export const progress = persistentMap<Record<string, boolean>>(
  'matlab-course:', // localStorage key prefix
  {}                // default: nothing completed
)

// Usage in Preact component:
// import { useStore } from '@nanostores/preact'
// const $progress = useStore(progress)
```

### Pattern 3: Starlight Component Override for Sidebar

**What:** Override Starlight's Sidebar component to inject completion checkmarks.

**Why:** Starlight's override API lets you wrap or replace any built-in component. Adding a green checkmark next to completed modules requires reading from the progress store.

```javascript
// astro.config.mjs
export default defineConfig({
  integrations: [
    starlight({
      components: {
        // Override sidebar to add progress indicators
        Sidebar: './src/components/ProgressSidebar.astro',
      },
    }),
  ],
});
```

### Pattern 4: Static Download Links

**What:** .m files live in `public/scripts/` and are linked with HTML5 `download` attribute.

**Why:** No server-side processing needed. GitHub Pages serves static files directly. The `download` attribute ensures the browser downloads rather than navigating.

```html
<a href="/scripts/01-first-steps/demo_hello.m" download="demo_hello.m">
  Download demo_hello.m
</a>
```

## Anti-Patterns to Avoid

### Anti-Pattern 1: Client-Side Markdown Rendering

**What:** Loading markdown at runtime and rendering with a JS library.
**Why bad:** Slower page loads, flash of unstyled content, requires JS framework runtime. Defeats Starlight's static rendering.
**Instead:** All markdown is rendered at build time by Starlight. Ship HTML.

### Anti-Pattern 2: SPA with Client-Side Routing

**What:** Using React Router or similar for page transitions.
**Why bad:** Starlight generates real HTML files for each page. Client-side routing would fight Starlight's architecture, break search, and complicate deployment.
**Instead:** Standard multi-page navigation. Starlight handles prev/next links and sidebar.

### Anti-Pattern 3: Fighting Starlight's Design System

**What:** Adding Tailwind CSS or a custom design system on top of Starlight.
**Why bad:** Two CSS systems competing. Starlight's CSS custom properties are designed to be themed, not overridden wholesale.
**Instead:** Use Starlight's CSS custom properties for color/font changes. Accept Starlight's layout unless there's a specific pedagogical reason to change it.

### Anti-Pattern 4: Moving .m Files into src/

**What:** Restructuring the repo so Matlab scripts live inside `src/content/`.
**Why bad:** Breaks Christel's workflow of opening .m files from the repo root in Matlab.
**Instead:** .m files stay at repo root. Copy to `public/scripts/` for web serving.

### Anti-Pattern 5: Complex State for Simple Data

**What:** Using Redux, Zustand, or a database for progress tracking.
**Why bad:** Progress is a map of lesson IDs to booleans. One user, one browser. localStorage + nanostores handles this in ~20 lines.
**Instead:** nanostores/persistent with a flat Record<string, boolean>.

## Build and Deploy Pipeline

```
1. npm run build (in web/ directory)
   ├── Astro/Starlight builds:
   │   ├── Reads src/content/docs/ markdown with frontmatter
   │   ├── Renders to static HTML with Shiki highlighting
   │   ├── Generates sidebar from directory structure
   │   ├── Runs Pagefind to index all content
   │   └── Outputs to dist/
   └── dist/ ready for deployment

2. GitHub Actions workflow:
   ├── Trigger: push to main
   ├── Install Node 18+ and npm ci
   ├── Run build in web/ directory
   └── Deploy dist/ to GitHub Pages via withastro/action
```

## Scalability Considerations

Not relevant. Single user, 8 modules, ~50 files. Starlight handles this trivially. Build time will be under 10 seconds.

## Sources

- [Starlight: Getting Started](https://starlight.astro.build/getting-started/) -- Project setup
- [Starlight: Overriding Components](https://starlight.astro.build/guides/overriding-components/) -- Custom sidebar, custom page elements
- [Starlight: Overrides Reference](https://starlight.astro.build/reference/overrides/) -- Full list of overridable components
- [Astro: Islands Architecture](https://docs.astro.build/en/concepts/islands/) -- Client-side hydration model
- [Astro: Share State Between Islands](https://docs.astro.build/en/recipes/sharing-state-islands/) -- Nanostores pattern
- [Astro: Deploy to GitHub Pages](https://docs.astro.build/en/guides/deploy/github/) -- Official deployment workflow
- [Astro: Content Collections](https://docs.astro.build/en/guides/content-collections/) -- Schema validation, typed frontmatter
- [Shiki Languages](https://shiki.style/languages) -- MATLAB grammar confirmation
- [@nanostores/persistent](https://github.com/nanostores/persistent) -- localStorage sync for nanostores

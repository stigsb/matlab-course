# Phase 5: Site Foundation and Deploy - Research

**Researched:** 2026-03-16
**Domain:** Astro/Starlight static site generation, GitHub Pages deployment, content migration
**Confidence:** HIGH

## Summary

Phase 5 converts 8 existing course modules (12 lessons, 45 .m scripts, 4 reference cards) into a navigable Starlight documentation site deployed to GitHub Pages. The prior v1.1 research (in `.planning/research/`) already locked the technology stack: Astro + Starlight + Preact islands. This phase-level research validates those choices against current versions, resolves the Astro 5 vs 6 question, and provides concrete implementation details.

The critical update since the v1.1 stack research: **Starlight 0.38.1 now requires Astro 6**, which requires Node 22+. Astro 5 + Starlight 0.37.7 remains an option but is end-of-line. Since we are starting fresh with no existing Astro project, use Astro 6 + Starlight 0.38.1 (the current supported path). Astro 6 has been stable since March 10 with patch 6.0.4 already released.

**Primary recommendation:** Scaffold a new Astro 6 project with Starlight 0.38.1 in a `web/` subdirectory. Migrate lesson content by copying markdown with added frontmatter into `src/content/docs/`. Copy .m files to `public/scripts/` for download serving. Deploy to GitHub Pages with `withastro/action@v5`. Progress tracking (Phase 6) is deferred -- this phase delivers a read-only content site with navigation, search, code highlighting, and copy/download.

<phase_requirements>
## Phase Requirements

| ID | Description | Research Support |
|----|-------------|-----------------|
| DLVR-01 | User can read course lessons as web pages with formatted text and code blocks | Starlight renders markdown to HTML with Shiki syntax highlighting. All 8 lesson.md files already use `matlab` code fence identifier. |
| DLVR-02 | User can navigate between modules and lessons via sidebar | Starlight auto-generates sidebar from `src/content/docs/` directory structure + frontmatter `sidebar.order`. |
| DLVR-03 | User can search across all course content | Pagefind is built into Starlight. Zero-config full-text search at build time. |
| DLVR-04 | User can toggle dark mode | Starlight has built-in dark mode toggle with localStorage preference persistence. |
| DLVR-05 | User can use the site on mobile devices with responsive layout | Starlight default theme is mobile-responsive. |
| CODE-01 | User sees MATLAB code with syntax highlighting | Shiki (built into Astro) supports MATLAB via MathWorks TextMate grammar. All existing code blocks use `matlab` identifier. |
| CODE-02 | User can copy code snippets to clipboard with one click | Expressive Code (built into Starlight) adds copy-to-clipboard button on all code blocks by default. |
| CODE-03 | User can download .m script files from lesson pages | .m files placed in `public/scripts/` are served as static files. HTML5 `download` attribute on links. |
| DEPL-01 | Site is deployed to GitHub Pages and publicly accessible | `withastro/action@v5` + `actions/deploy-pages@v4`. Astro `site` + `base` config for project page. |
| DEPL-02 | Site rebuilds and deploys automatically on push via GitHub Actions | GitHub Actions workflow on `push: branches: [main]`. |
</phase_requirements>

## Standard Stack

### Core

| Library | Version | Purpose | Why Standard |
|---------|---------|---------|--------------|
| Astro | ^6.0.4 | Static site framework | Content-driven, zero JS by default, islands architecture. Current stable release. |
| @astrojs/starlight | ^0.38.1 | Documentation theme | Purpose-built for structured content: sidebar, search, dark mode, responsive, code highlighting. Requires Astro 6. |
| Node.js | 22+ (LTS) | Runtime | Required by Astro 6. Node 22 is current LTS. |

### Supporting (Phase 5 only -- no interactive components yet)

| Library | Version | Purpose | When to Use |
|---------|---------|---------|-------------|
| Shiki | bundled with Astro | MATLAB syntax highlighting | Automatic for all `matlab` code fences |
| Pagefind | bundled with Starlight | Full-text search | Automatic at build time |
| Expressive Code | bundled with Starlight | Code block copy-to-clipboard, titles, line highlighting | Automatic for all code blocks |

### Deferred to Phase 6

| Library | Version | Purpose |
|---------|---------|---------|
| @astrojs/preact | ^4.1 | Interactive islands for progress tracking |
| preact | ^10.x | UI framework for Done buttons, dashboard |
| nanostores | ^0.11 | Reactive state management |
| @nanostores/persistent | ^0.10 | localStorage persistence |

### Alternatives Considered

| Instead of | Could Use | Tradeoff |
|------------|-----------|----------|
| Astro 6 + Starlight 0.38 | Astro 5 + Starlight 0.37.7 | Works with Node 18+ but is end-of-line. No future Starlight updates for Astro 5. |
| Starlight | Plain Astro | Would need to build sidebar, search, dark mode, responsive layout from scratch. Weeks of work for zero benefit. |
| Starlight | VitePress | Vue-based, decent option, but less mature island architecture for future interactive components. |

**Installation:**

```bash
# Create new Astro project with Starlight template (in web/ subdirectory)
npm create astro@latest -- --template starlight ./web

# Verify versions after install
cd web && npx astro --version
```

**Note:** Do NOT install Preact or nanostores in Phase 5. Those are Phase 6 dependencies.

## Architecture Patterns

### Project Structure

```
matlab-course/
  01-first-steps/              # EXISTING - untouched
    lesson.md
    demo_hello.m
    demo_variables.m
    exercise_variables.m
    solution_variables.m
  02-vectors-and-plotting/     # EXISTING - untouched
    lesson.md
    ...
  ... (8 module dirs)
  reference/                   # EXISTING - untouched
    matlab_basics.md
    neural_coding_info.md
    pca_attractors.md
    programming_and_math.md
  web/                         # NEW - Astro project root
    astro.config.mjs
    package.json
    src/
      content.config.ts        # Content collection with docsLoader + docsSchema
      content/
        docs/                  # Starlight content directory
          index.md             # Landing page / course home
          01-first-steps/
            index.md           # Adapted from ../../01-first-steps/lesson.md
          02-vectors-and-plotting/
            index.md
          03-programming-tools/
            index.md
          04-math-foundations/
            index.md
          05-neural-coding/
            index.md
          06-information-theory/
            index.md
          07-dimensionality-reduction/
            index.md
          08-attractor-networks/
            index.md
          reference/
            matlab-basics.md
            neural-coding-info.md
            pca-attractors.md
            programming-and-math.md
    public/
      scripts/                 # .m files for download
        01-first-steps/
          demo_hello.m
          demo_variables.m
          exercise_variables.m
          solution_variables.m
        02-vectors-and-plotting/
          ...
        ... (all 45 .m files)
    .github/                   # Note: must be at repo root, not in web/
```

**Important:** The `.github/workflows/` directory must be at the repository root, not inside `web/`. The `withastro/action` supports a `path` parameter to specify the Astro project subdirectory.

### Pattern 1: Content Collections with docsLoader (Astro 6 / Starlight 0.38)

**What:** Starlight 0.38 uses the new Content Layer API with `docsLoader()` instead of the legacy content collections.

**Example:**

```typescript
// web/src/content.config.ts
import { defineCollection } from 'astro:content';
import { docsLoader } from '@astrojs/starlight/loaders';
import { docsSchema } from '@astrojs/starlight/schema';

export const collections = {
  docs: defineCollection({
    loader: docsLoader(),
    schema: docsSchema(),
  }),
};
```

**Confidence:** HIGH -- from official Starlight 0.38 manual setup documentation.

### Pattern 2: Astro Config for GitHub Pages

**What:** Configure site URL and base path for GitHub Pages project site.

```javascript
// web/astro.config.mjs
import { defineConfig } from 'astro/config';
import starlight from '@astrojs/starlight';

export default defineConfig({
  site: 'https://stigsb.github.io',
  base: '/matlab-course',
  integrations: [
    starlight({
      title: 'MATLAB for Computational Neuroscience',
      sidebar: [
        {
          label: 'Course Modules',
          items: [
            { label: 'Module 1: First Steps', slug: '01-first-steps' },
            { label: 'Module 2: Vectors and Plotting', slug: '02-vectors-and-plotting' },
            { label: 'Module 3: Programming Tools', slug: '03-programming-tools' },
            { label: 'Module 4: Math Foundations', slug: '04-math-foundations' },
            { label: 'Module 5: Neural Coding', slug: '05-neural-coding' },
            { label: 'Module 6: Information Theory', slug: '06-information-theory' },
            { label: 'Module 7: Dimensionality Reduction', slug: '07-dimensionality-reduction' },
            { label: 'Module 8: Attractor Networks', slug: '08-attractor-networks' },
          ],
        },
        {
          label: 'Reference',
          autogenerate: { directory: 'reference' },
        },
      ],
    }),
  ],
});
```

**Confidence:** HIGH -- from official Astro GitHub Pages deployment guide.

### Pattern 3: Lesson Frontmatter Format

**What:** Each lesson.md gets Starlight frontmatter when copied to the docs directory.

```markdown
---
title: "Module 1: First Steps"
description: "Variables, the command window, and your first plot"
sidebar:
  order: 1
---

[lesson content from 01-first-steps/lesson.md]

## Download Scripts

- [demo_hello.m](/matlab-course/scripts/01-first-steps/demo_hello.m)
- [demo_variables.m](/matlab-course/scripts/01-first-steps/demo_variables.m)
- [exercise_variables.m](/matlab-course/scripts/01-first-steps/exercise_variables.m)
- [solution_variables.m](/matlab-course/scripts/01-first-steps/solution_variables.m)
```

**Note:** Download URLs must include the base path `/matlab-course/` since the site is deployed as a GitHub Pages project site.

### Pattern 4: Code Block Titles for .m Files

**What:** Expressive Code allows adding filenames to code blocks shown in lessons, making it clear which script the code comes from.

````markdown
```matlab title="demo_hello.m"
x = -10:0.1:10;
y = x.^2;
plot(x, y, 'r-', 'LineWidth', 2);
title('My First Plot');
```
````

**Confidence:** HIGH -- Expressive Code title syntax is documented and built into Starlight.

### Pattern 5: GitHub Actions Deploy Workflow

**What:** Auto-deploy on push to main using `withastro/action@v5` with `path` parameter for subdirectory.

```yaml
# .github/workflows/deploy.yml (at repo root)
name: Deploy to GitHub Pages

on:
  push:
    branches: [main]
  workflow_dispatch:

permissions:
  contents: read
  pages: write
  id-token: write

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v5
      - name: Build Astro site
        uses: withastro/action@v5
        with:
          path: ./web
          node-version: 22

  deploy:
    needs: build
    runs-on: ubuntu-latest
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    steps:
      - name: Deploy to GitHub Pages
        id: deployment
        uses: actions/deploy-pages@v4
```

**Confidence:** HIGH -- from official Astro deployment guide and withastro/action documentation.

### Anti-Patterns to Avoid

- **Using MDX when Markdown suffices:** All Starlight built-in features (asides with `:::`, code blocks, tables) work in plain `.md`. MDX adds compilation complexity for no benefit in this phase.
- **Fighting Starlight's design system:** Do not add Tailwind or custom CSS frameworks. Use Starlight's CSS custom properties for any theming.
- **Moving .m files into src/:** Keep original module directories at repo root for direct MATLAB use. Copy .m files to `public/scripts/` for web serving.
- **Client-side markdown rendering:** All content is rendered at build time by Starlight. Ship static HTML.
- **Installing Phase 6 dependencies early:** Do not add Preact or nanostores in Phase 5. Keep the site static.

## Don't Hand-Roll

| Problem | Don't Build | Use Instead | Why |
|---------|-------------|-------------|-----|
| Sidebar navigation | Custom nav component | Starlight sidebar config | Auto-generates from directory structure, handles mobile, keyboard navigation |
| Full-text search | Custom search with lunr.js | Pagefind (built into Starlight) | Build-time indexing, instant client-side search, zero config |
| MATLAB syntax highlighting | Custom tokenizer or Prism plugin | Shiki with MathWorks grammar (built into Astro) | Official TextMate grammar, VS Code-quality highlighting |
| Dark mode | Custom CSS toggle + localStorage | Starlight built-in dark mode | Handles system preference, manual toggle, persists choice |
| Code copy-to-clipboard | Custom JS clipboard handler | Expressive Code (built into Starlight) | Handles all code blocks, terminal frame stripping, accessibility |
| Mobile responsive layout | Media queries + custom CSS | Starlight default theme | Tested, accessible, collapsible sidebar on mobile |
| GitHub Pages deployment | Custom build scripts | `withastro/action@v5` | Official action, handles Node install, build, upload artifacts |

**Key insight:** Starlight provides 9 of 10 Phase 5 requirements out of the box. The only custom work is content migration (adding frontmatter to lessons) and organizing .m file downloads.

## Common Pitfalls

### Pitfall 1: Base Path Breaks All Asset Links

**What goes wrong:** Site deploys to `https://stigsb.github.io/matlab-course/` but all CSS, JS, images, and download links assume root `/`. Everything 404s.
**Why it happens:** GitHub Pages project sites serve from a subdirectory. Astro needs `base: '/matlab-course'` in config.
**How to avoid:** Set `site` and `base` in `astro.config.mjs` immediately. Use `import.meta.env.BASE_URL` for dynamic URLs. Download links in markdown must include the base path.
**Warning signs:** Any 404 on the deployed site. Test with `npm run preview` locally (it respects the base path).

### Pitfall 2: Content Migration Formatting Drift

**What goes wrong:** Existing lesson.md files render differently in Starlight than on GitHub. Heading levels, table formatting, or raw HTML behaves differently.
**Why it happens:** Starlight uses Astro's remark/rehype pipeline, which differs from GitHub's markdown renderer in edge cases.
**How to avoid:** Visual test ALL 8 lessons in the dev server before deploying. The existing lessons already use standard GFM features and `matlab` code fences, so issues should be minimal.
**Warning signs:** Broken tables, missing syntax highlighting, raw HTML not rendering.

### Pitfall 3: .github/workflows/ in Wrong Location

**What goes wrong:** GitHub Actions workflow does not trigger because the `.github/` directory is inside `web/` instead of at the repository root.
**Why it happens:** The Astro project lives in `web/` but GitHub only looks for workflows at `<repo-root>/.github/workflows/`.
**How to avoid:** Place `.github/workflows/deploy.yml` at the repo root. Use the `path: ./web` parameter in `withastro/action@v5`.

### Pitfall 4: Overengineering Phase 5

**What goes wrong:** Adding interactive features, custom components, or progress tracking in Phase 5 instead of shipping a static content site first.
**Why it happens:** Temptation to build everything at once.
**How to avoid:** Phase 5 is read-only content delivery. No Preact, no nanostores, no custom interactive components. Those are Phase 6.
**Warning signs:** Installing @astrojs/preact, writing .tsx files, or adding client:load directives in Phase 5.

### Pitfall 5: Node 22 Not Available in CI

**What goes wrong:** GitHub Actions build fails because the default Node version is not 22+.
**Why it happens:** Astro 6 requires Node 22. `withastro/action@v5` defaults to Node 22 but explicit is better.
**How to avoid:** Set `node-version: 22` in the workflow. Verify locally with `node --version` (should be 22+).

## Code Examples

### Content Collection Config (Starlight 0.38 + Astro 6)

```typescript
// web/src/content.config.ts
// Source: https://starlight.astro.build/manual-setup/
import { defineCollection } from 'astro:content';
import { docsLoader } from '@astrojs/starlight/loaders';
import { docsSchema } from '@astrojs/starlight/schema';

export const collections = {
  docs: defineCollection({
    loader: docsLoader(),
    schema: docsSchema(),
  }),
};
```

### Lesson Page with Download Section

```markdown
---
title: "Module 1: First Steps"
description: "Variables, the command window, and your first plot"
---

<!-- Existing lesson content from 01-first-steps/lesson.md -->

## Download Scripts

Download these files and open them in MATLAB Desktop:

- [demo_hello.m](/matlab-course/scripts/01-first-steps/demo_hello.m) -- Your first script
- [demo_variables.m](/matlab-course/scripts/01-first-steps/demo_variables.m) -- Working with variables
- [exercise_variables.m](/matlab-course/scripts/01-first-steps/exercise_variables.m) -- Practice exercise
- [solution_variables.m](/matlab-course/scripts/01-first-steps/solution_variables.m) -- Exercise solution

:::tip
To run these scripts, save them to a folder, set that folder as your MATLAB Current Folder, then press F5 or click Run.
:::
```

### Landing Page

```markdown
---
title: MATLAB for Computational Neuroscience
description: A visual-first course teaching MATLAB and math foundations for NEVR3004
template: splash
hero:
  tagline: From zero to neural network models -- one visual concept at a time
  actions:
    - text: Start Module 1
      link: /matlab-course/01-first-steps/
      icon: right-arrow
      variant: primary
    - text: Browse all modules
      link: /matlab-course/02-vectors-and-plotting/
      variant: minimal
---
```

## State of the Art

| Old Approach (v1.1 Research) | Current Approach | When Changed | Impact |
|------------------------------|------------------|--------------|--------|
| Astro 5.x + Starlight 0.37 | Astro 6.0 + Starlight 0.38.1 | March 10-11, 2026 | Requires Node 22+. Uses `docsLoader()` instead of legacy content collections. |
| `withastro/action@v4` | `withastro/action@v5` | Recent | Defaults to Node 22. |
| `src/content/config.ts` | `src/content.config.ts` | Astro 5+ Content Layer API | Config file moved to project root of src/. Uses `docsLoader()` + `docsSchema()`. |

**Updated from prior research:**
- Astro 5 + Starlight 0.37: Still works but end-of-line. No future Starlight updates for Astro 5.
- Astro 6 + Starlight 0.38.1: Current supported path. Stable since March 10, 2026.

## Content Inventory

Exact content to migrate in Phase 5:

| Source | Files | Lines | Destination |
|--------|-------|-------|-------------|
| `*/lesson.md` (8 files) | 8 | 2,023 total | `web/src/content/docs/{module}/index.md` |
| `reference/*.md` (4 files) | 4 | 700 total | `web/src/content/docs/reference/*.md` |
| `**/*.m` (45 files) | 45 | ~5,985 LOC | `web/public/scripts/{module}/*.m` |

All lesson.md files already use `matlab` code fence identifiers. No code block language fixes needed.

Migration work per lesson:
1. Copy content to `web/src/content/docs/{module}/index.md`
2. Add Starlight frontmatter (title, description, sidebar order)
3. Add "Download Scripts" section at bottom with links to .m files
4. Remove the `# Module XX: Title` H1 heading (Starlight generates it from frontmatter title)
5. Verify rendering in dev server

## Validation Architecture

### Test Framework

| Property | Value |
|----------|-------|
| Framework | Astro build + manual verification |
| Config file | `web/package.json` (scripts section) |
| Quick run command | `cd web && npm run build` |
| Full suite command | `cd web && npm run build && npm run preview` |

### Phase Requirements to Test Map

| Req ID | Behavior | Test Type | Automated Command | File Exists? |
|--------|----------|-----------|-------------------|-------------|
| DLVR-01 | Lessons render as web pages | smoke | `cd web && npm run build` (build succeeds = content renders) | Wave 0 |
| DLVR-02 | Sidebar navigation works | manual | Visual check in preview: click through all 8 modules | manual-only |
| DLVR-03 | Search works across content | manual | Visual check: search for "eigenvalue" in Pagefind search | manual-only |
| DLVR-04 | Dark mode toggle works | manual | Visual check: click dark mode toggle | manual-only |
| DLVR-05 | Mobile responsive layout | manual | Browser dev tools responsive mode check | manual-only |
| CODE-01 | MATLAB syntax highlighting | manual | Visual check: code blocks show colored syntax | manual-only |
| CODE-02 | Copy to clipboard | manual | Click copy button on code block, paste elsewhere | manual-only |
| CODE-03 | Download .m files | manual | Click download link, verify file downloads | manual-only |
| DEPL-01 | Site publicly accessible | smoke | `curl -s -o /dev/null -w "%{http_code}" https://stigsb.github.io/matlab-course/` | Wave 0 |
| DEPL-02 | Auto-deploy on push | smoke | Push commit, verify GitHub Actions run succeeds | manual-only |

### Sampling Rate

- **Per task commit:** `cd web && npm run build` (build must succeed)
- **Per wave merge:** Full build + preview + visual spot-check of 2 modules
- **Phase gate:** All 8 modules render, all download links work, site deployed and accessible

### Wave 0 Gaps

- [ ] `web/` -- entire Astro project needs scaffolding
- [ ] `.github/workflows/deploy.yml` -- GitHub Actions workflow
- [ ] GitHub Pages must be enabled in repo settings (Source: GitHub Actions)

## Open Questions

1. **GitHub username for Pages URL**
   - What we know: Site will be at `https://{username}.github.io/matlab-course/`
   - What's unclear: Confirm the GitHub username is `stigsb` (used in config examples)
   - Recommendation: Verify and update `site` in astro.config.mjs accordingly

2. **Lesson content: copy vs symlink**
   - What we know: Prior research recommended Option A (copy content directly)
   - What's unclear: Whether a build script to auto-copy from root lesson.md would be better
   - Recommendation: Copy and adapt directly. Content is stable (v1.0 shipped). Avoids build-time complexity.

3. **Reference cards in sidebar grouping**
   - What we know: 4 reference cards exist in `reference/` directory
   - What's unclear: Best sidebar placement (separate group vs. under each module)
   - Recommendation: Separate "Reference" group in sidebar using `autogenerate: { directory: 'reference' }`

## Sources

### Primary (HIGH confidence)

- [Astro GitHub Pages Deployment Guide](https://docs.astro.build/en/guides/deploy/github/) -- site/base config, workflow YAML
- [Starlight Getting Started](https://starlight.astro.build/getting-started/) -- Installation, project structure
- [Starlight Manual Setup](https://starlight.astro.build/manual-setup/) -- docsLoader + docsSchema for Astro 6
- [Starlight Authoring Content](https://starlight.astro.build/guides/authoring-content/) -- Markdown features, code blocks, asides
- [withastro/action GitHub](https://github.com/withastro/action) -- v5, path parameter, node-version
- [Starlight Releases](https://github.com/withastro/starlight/releases) -- 0.38.0/0.38.1 require Astro 6

### Secondary (MEDIUM confidence)

- [Expressive Code Configuration](https://expressive-code.com/reference/configuration/) -- Code block titles, copy button
- [Astro 6 Release Blog](https://astro.build/blog/astro-6/) -- Breaking changes, Node 22 requirement

### Tertiary (LOW confidence)

- None. All findings verified against official documentation.

## Metadata

**Confidence breakdown:**
- Standard stack: HIGH -- verified against current npm versions and official docs
- Architecture: HIGH -- Starlight project structure is well-documented, patterns from prior research validated
- Pitfalls: HIGH -- base path issue is well-known, other pitfalls from prior research still apply
- Content migration: HIGH -- existing content uses standard GFM + `matlab` code fences, minimal adaptation needed

**Research date:** 2026-03-16
**Valid until:** 2026-04-16 (Astro/Starlight ecosystem is active; check for minor version updates)

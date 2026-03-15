# Domain Pitfalls: v1.1 Interactive Web App

**Domain:** Static course web app on GitHub Pages with progress tracking
**Researched:** 2026-03-16 (updated for Starlight stack decision)

This document covers pitfalls specific to adding a web delivery layer to the existing v1.0 course content. For pedagogical pitfalls (cognitive overload, notation-first teaching, pacing), see the v1.0 research in milestones/v1.0-phases.

## Critical Pitfalls

### Pitfall 1: localStorage Data Eviction on Safari

**What goes wrong:** Progress data silently disappears. Safari's Intelligent Tracking Prevention (ITP) can delete localStorage for origins with no user interaction in the last 7 days. If Christel takes a week off, she returns to find all progress reset. On iOS Safari private browsing, localStorage writes throw exceptions (quota is 0).

**Why it happens:** Apple treats script-created storage as potential tracking data and aggressively evicts it.

**Consequences:** Complete loss of progress tracking. For a learner with ADHD, a reset progress dashboard is a motivation killer.

**Prevention:**
- Wrap all localStorage access in try/catch (nanostores/persistent does this)
- Build an **export/import progress** feature (JSON download/upload) as backup -- ship this alongside initial progress tracking, not later
- Show a warning banner if localStorage is unavailable
- Design the UI so the site is fully functional without saved progress -- progress is a convenience, not a gate
- Consider an alternative: store progress as a JSON file committed to the repo (she has write access)

**Detection:** Test in Safari with a 7+ day gap. Test iOS Safari private mode.

### Pitfall 2: Overengineering the Web Layer

**What goes wrong:** The web app becomes the project instead of the course content being the project. Weeks spent on framework configuration, custom components, and build tooling when Starlight provides 80% of what's needed out of the box.

**Why it happens:** Developer instinct to customize everything. Starlight's defaults are good enough for a single-user course site. The temptation to add Tailwind, custom layouts, animation libraries, or a design system is strong but counterproductive.

**Consequences:** Delivery delay. Christel gets the web app later because the developer is tweaking CSS variables instead of shipping content.

**Prevention:**
- Use Starlight's default theme. Accept its visual choices.
- Custom code should be limited to progress tracking (Preact islands + nanostores). Everything else should be Starlight defaults.
- Hard rule: if the web layer takes more than 2 phases to build, it is overengineered.
- If you find yourself writing more than 500 lines of custom CSS, stop and reconsider.

**Detection:** Count custom files vs generated/default files. If custom code exceeds 300 lines total (excluding content), you've gone too far for an MVP.

### Pitfall 3: Attempting Browser-Based MATLAB Execution

**What goes wrong:** Weeks spent trying to get MATLAB code running in the browser via WebAssembly, Octave.js, or MATLAB Online embedding. None work for a static site.

**Why it happens:** "Browser-based Matlab coding if feasible" is in PROJECT.md. The instinct is to try. MATLAB Online requires auth. Octave WASM (Sable/matwably) is a research prototype. RunMat is new and unembeddable.

**Consequences:** Significant time wasted on something that either doesn't work or covers only a subset of functions the course uses (eig, imagesc, ode45).

**Prevention:**
- The answer is: download workflow. View code in browser, copy or download .m file, run in MATLAB Desktop.
- Christel already has MATLAB installed. Browser execution adds no value.
- Do not spend more than 1 hour exploring this. The research is done.

**Detection:** If you're writing code related to browser MATLAB execution, stop immediately.

## Moderate Pitfalls

### Pitfall 4: Content Migration Formatting Issues

**What goes wrong:** Existing lesson.md files render differently in Starlight than on GitHub. Different heading sizes, code block treatment, table formatting, or missing GFM features. MATLAB code blocks may not get syntax highlighting if the language identifier is wrong.

**Why it happens:** The lessons were written for GitHub's markdown renderer. Starlight uses Astro's markdown pipeline (remark/rehype) with Shiki for code highlighting. Most GFM features work but edge cases exist.

**Prevention:**
- Test all 8 lesson.md files in Starlight before building any other features
- Verify MATLAB code blocks use the `matlab` language identifier (check existing lessons; fix if they use `m` or no identifier)
- Starlight renders GFM (tables, task lists, strikethrough) by default via remark-gfm
- If any lesson uses raw HTML in markdown, verify it renders correctly (Astro treats HTML in markdown differently than GitHub)

**Detection:** Visual diff of every lesson in Starlight vs GitHub rendering. Any code block without proper highlighting or any broken table needs fixing.

### Pitfall 5: Progress Dashboard That Feels Punishing

**What goes wrong:** The dashboard prominently displays uncompleted items, creating a visual representation of "how much you haven't done." For a learner with ADHD who is already behind, a dashboard full of empty progress is anxiety-inducing.

**Why it happens:** Progress dashboards default to showing completion percentage or remaining items. This is the wrong model for this learner.

**Prevention:**
- Show what has been completed, not what remains. "You've finished 3 modules!" not "5 modules remaining."
- Use a bar that fills up rather than a checklist of incomplete items
- Never show percentage prominently -- "25% done" reads as "75% failure"
- Celebrate completed milestones
- Consider a "last active" indicator that rewards returning rather than punishing absence

**Detection:** Look at the dashboard with 2/8 modules complete. Does it feel encouraging or overwhelming?

### Pitfall 6: Starlight Sidebar Override Complexity

**What goes wrong:** Overriding Starlight's sidebar to add progress checkmarks turns into a rabbit hole. The sidebar component has internal dependencies, and overriding it requires understanding Starlight's component internals. Version updates may break overrides.

**Why it happens:** Starlight's override API is powerful but the sidebar is one of the more complex components. Adding reactive state (from nanostores) to a server-rendered Astro component requires careful hydration.

**Prevention:**
- Start without sidebar progress indicators. Get the basic site working first.
- Implement progress indicators in the sidebar only after the ProgressButton and ProgressDashboard work correctly
- Consider an alternative: instead of overriding the sidebar, add a small progress indicator at the top of each page (simpler, doesn't require sidebar override)
- Pin Starlight version and test upgrades carefully

**Detection:** If the sidebar override takes more than 4 hours to implement, use the simpler per-page indicator approach instead.

### Pitfall 7: GitHub Pages Base Path Configuration

**What goes wrong:** All asset links (CSS, JS, images, .m file downloads) are broken on GitHub Pages because the site is served from `https://username.github.io/matlab-course/` (with a base path) but the links assume the root `/`.

**Why it happens:** GitHub Pages project sites use a base path matching the repo name. Astro needs to know this to generate correct URLs.

**Prevention:**
- Set `base` in astro.config.mjs: `base: '/matlab-course'`
- Use `import.meta.env.BASE_URL` for all dynamic URLs
- Starlight handles this for navigation and content links automatically
- Download links to .m files in public/ must also use the base path

**Detection:** Deploy to GitHub Pages and click every link. Any 404 on assets means the base path is wrong.

### Pitfall 8: Code Display Without Copy/Download Affordance

**What goes wrong:** Code is highlighted but there's no easy way to get it into MATLAB Desktop.

**Why it happens:** Developers focus on making code look good rather than making it usable.

**Prevention:**
- Starlight's Expressive Code provides copy-to-clipboard by default on all code blocks
- Add explicit download links for each .m file referenced in a lesson
- Consider a "Download all module scripts" link per module
- The repo clone is also a valid download mechanism -- provide clear instructions

**Detection:** Time from reading code in browser to running it in MATLAB. Should be under 30 seconds.

## Minor Pitfalls

### Pitfall 9: Deploying Before Content Renders Correctly

**What goes wrong:** The site deploys with a beautiful Starlight shell but broken content. Lessons render incorrectly, links are broken, some modules are missing.

**Prevention:**
- Deploy only when at least Module 01 renders correctly end-to-end
- Test: landing page -> Module 01 -> read lesson -> view code -> copy/download -> mark done -> see progress update
- Use Starlight's built-in 404 page rather than broken links for in-progress modules

**Detection:** Click every link on the deployed site. Any 404 or rendering error means it shipped too early.

### Pitfall 10: "Done" Button Ambiguity

**What goes wrong:** "Done" buttons exist but it's unclear what "done" means. "I read it"? "I ran the code"? "I understood it"? Ambiguity causes anxiety.

**Prevention:**
- Label clearly: "I've completed this lesson" or "Mark as complete"
- Allow toggling (unmark). If she revisits and realizes she didn't understand, she can uncheck.
- No verification or quiz tied to the button. Purely self-reported.

**Detection:** Would the learner hesitate before clicking? If the label is ambiguous, clarify.

### Pitfall 11: Ignoring Astro 6 Migration Path

**What goes wrong:** Building on Astro 5.x without considering that Astro 6 is now released. When eventually upgrading, breaking changes require rework.

**Prevention:**
- Avoid deprecated Astro 5 APIs (check Astro 6 migration guide for what's changing)
- Use Starlight's public APIs, not internal component paths
- Keep dependencies minimal so there are fewer things to upgrade
- The upgrade path from Astro 5 to 6 is documented and should be straightforward when the time comes

**Detection:** Run `npx @astrojs/upgrade` periodically to check for recommended updates.

## Phase-Specific Warnings

| Phase Topic | Likely Pitfall | Mitigation |
|-------------|---------------|------------|
| Project scaffolding | Base path wrong for GitHub Pages (Pitfall 7) | Set `base` in config immediately. Test with `npm run preview`. |
| Content migration | Markdown rendering differences (Pitfall 4) | Visual test all 8 lessons before building further. |
| Code display | Copy/download not prominent enough (Pitfall 8) | Verify Expressive Code copy button works. Add download links. |
| Progress tracking | localStorage eviction (Pitfall 1) | Build export/import alongside initial implementation. |
| Progress dashboard | Dashboard feels punishing (Pitfall 5) | Show completed items, not remaining. Celebrate progress. |
| Sidebar override | Override complexity (Pitfall 6) | Start simple. Fallback to per-page indicator if sidebar override is hard. |
| Deployment | Shipping broken content (Pitfall 9) | Full end-to-end test of Module 01 before first deploy. |
| MATLAB in browser | Attempting browser execution (Pitfall 3) | Do not attempt. Download workflow only. |

## Pitfalls Resolved by Starlight

These were risks with a custom Astro build but are handled by Starlight:

| Former Risk | How Starlight Resolves It |
|-------------|--------------------------|
| SPA routing breaks on GitHub Pages | Starlight generates real HTML files. No SPA routing. |
| Mobile responsiveness | Starlight's layout is responsive by default. |
| Search implementation | Pagefind is built in and runs at build time. |
| Syntax highlighting configuration | Shiki with MATLAB grammar is built in. |
| Dark mode implementation | Built-in toggle with localStorage preference. |
| Navigation cognitive overload | Starlight's sidebar + prev/next is a well-tested pattern. |
| Accessibility | Starlight has accessibility features (keyboard nav, ARIA) built in. |

## Sources

- [Safari ITP localStorage eviction](https://bugs.webkit.org/show_bug.cgi?id=266559) -- Safari periodically erasing localStorage
- [Safari private browsing localStorage](https://github.com/mdn/content/issues/17827) -- iOS Safari private mode behavior
- [Storage quotas and eviction (MDN)](https://developer.mozilla.org/en-US/docs/Web/API/Storage_API/Storage_quotas_and_eviction_criteria) -- Browser storage documentation
- [Starlight: Overriding Components](https://starlight.astro.build/guides/overriding-components/) -- Override API and limitations
- [Astro: Deploy to GitHub Pages](https://docs.astro.build/en/guides/deploy/github/) -- Base path configuration
- [Astro 6 Migration Guide](https://docs.astro.build/en/guides/upgrade-to/v6/) -- Breaking changes to avoid in Astro 5 code
- [ADHD-friendly app design](https://www.monstermath.app/blog/adhd-friendly-app-design-what-to-look-for-and-what-to-avoid) -- Progress dashboard UX

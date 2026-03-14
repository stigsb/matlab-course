# Domain Pitfalls

**Domain:** Matlab-based computational neuroscience education for a visual learner with math gaps and ADHD
**Researched:** 2026-03-14

## Critical Pitfalls

Mistakes that cause the learner to disengage, fall behind, or require major rework of course material.

### Pitfall 1: Notation-First Math Teaching

**What goes wrong:** Introducing math concepts through formal notation (summation symbols, integrals, matrix notation) before the learner has a visual and intuitive grasp of what the math actually does. This is the default in computational neuroscience courses and textbooks (including Rolls & Treves, the NEVR3004 textbook).

**Why it happens:** Course designers who are comfortable with math forget that notation is a compressed representation of ideas the learner has not yet formed. They treat symbols as the concept rather than as a shorthand for it.

**Consequences:** Math anxiety triggers. The learner sees a wall of symbols, feels "I can't do this," and disengages. With ADHD, this disengagement happens faster and is harder to recover from. Once the learner believes the material is "too hard," motivation collapses.

**Prevention:**
- Always introduce math concepts visually first: plot the function, animate the process, show the data
- Use the Concrete-Representational-Abstract (CRA) sequence: Matlab code (concrete) -> plots/diagrams (representational) -> notation (abstract, and only when needed)
- Notation is introduced as "naming what you already understand," never as the entry point
- Keep notation minimal — only introduce what NEVR3004 absolutely requires

**Detection:** If a lesson draft contains math notation in the first half before any plot or code example, it needs restructuring.

**Phase relevance:** Every phase. This is a design principle, not a one-time fix.

### Pitfall 2: Cognitive Overload From Dual Novelty

**What goes wrong:** Teaching a new programming concept and a new math concept in the same lesson segment. Example: introducing matrix multiplication while also teaching Matlab's array indexing syntax for the first time.

**Why it happens:** In computational neuroscience, the math and the code are deeply intertwined. It feels natural to teach them together. But for a learner who is new to both programming AND linear algebra, each one consumes the entire working memory budget (approximately 4-5 items for someone with ADHD, vs 7 +/- 2 for neurotypical adults).

**Consequences:** The learner cannot tell whether their confusion is about the math or the code. Debugging becomes impossible. Frustration escalates rapidly. The learner blames themselves rather than the lesson design.

**Prevention:**
- Separate concerns ruthlessly: teach the Matlab syntax with familiar content first (numbers, simple arrays), then use that established syntax to explore new math
- Each lesson segment should have exactly ONE new concept. Everything else should be revision or already-mastered material
- Use a "scaffolding sandwich": familiar code -> new concept -> familiar code pattern applied to new concept
- Working memory research supports chunking into units of 3-4 items maximum per segment

**Detection:** If a lesson introduces more than one genuinely new idea (not just a variation), split it.

**Phase relevance:** All phases, but especially critical in early phases (Matlab fundamentals + basic linear algebra) where everything is new.

### Pitfall 3: The "Just Catch Up" Pacing Trap

**What goes wrong:** Because Christel is already behind in NEVR3004, there is pressure to move fast through foundational material to reach the course-relevant topics (neural coding, information theory, etc.). This leads to rushing through Matlab basics and math foundations, leaving gaps that compound into bigger problems later.

**Why it happens:** External deadline pressure from a university course that is already underway. The temptation is to skip "easy" material and jump to what the course is currently covering.

**Consequences:** Without solid foundations, every advanced topic requires re-teaching basics mid-lesson, which is slower than teaching them properly the first time. The learner develops a fragile understanding that collapses under exam pressure. This is the single most common failure mode in catch-up tutoring.

**Prevention:**
- Accept that the first 2-3 phases must build genuine foundations even if it feels "slow"
- Design the foundation phases to be maximally efficient, not skipped: tight lessons, no tangents, every example serves double duty (teaches Matlab AND previews a neuroscience concept)
- Make the connection to NEVR3004 explicit in every lesson ("you'll use this exact pattern when we analyze spike trains")
- Identify the absolute minimum Matlab and math skills needed for each NEVR3004 topic and sequence the foundations accordingly

**Detection:** If the learner is copying code patterns without understanding why they work, foundations were rushed.

**Phase relevance:** Phase 1-2 design. Getting the foundation right determines everything downstream.

### Pitfall 4: Visual Overload Instead of Visual Clarity

**What goes wrong:** Knowing the learner is visual, the course designer fills every lesson with plots, colors, animations, and diagrams — but without a clear visual hierarchy. Too many visual elements compete for attention.

**Why it happens:** Overcorrection. "She's a visual learner" becomes "more visuals = better." Research on ADHD and visual learning specifically warns against this: over-coloring confuses, and students with attention challenges struggle to absorb large amounts of simultaneous visual information.

**Consequences:** The learner cannot identify what is important in the visualization. Plots with 6 subplots, rainbow colormaps, and dense annotations become noise rather than signal. The visual "help" becomes another source of cognitive load.

**Prevention:**
- Limit to 3-4 colors per visualization
- One concept per plot. Multiple subplots only when comparing the same concept across conditions
- Use progressive disclosure: start with a simple plot, then layer complexity in subsequent code cells
- Annotations should highlight the ONE thing to notice, not label everything
- Prefer animations that build up step-by-step over static plots that show everything at once

**Detection:** If a plot requires more than 10 seconds of study to grasp the main point, it needs simplification.

**Phase relevance:** All phases. Establish a consistent visual style early and maintain it.

## Moderate Pitfalls

### Pitfall 5: Abstract-Before-Concrete Lesson Flow

**What goes wrong:** Lessons start with "theory" paragraphs explaining what will be learned, followed by code. For an ADHD learner, the theory paragraph is where attention dies. By the time the code appears, engagement is already lost.

**Prevention:**
- Start every lesson with a compelling visual output: "Run this script. See that plot? That's what we're building today."
- Show the result first, then explain how it works. Reverse the typical textbook flow.
- Keep explanatory text to 2-3 sentences between code blocks. Long prose sections are attention killers.

**Phase relevance:** All phases. This is a structural template for every lesson.

### Pitfall 6: Matlab Syntax Gotchas Derailing Learning

**What goes wrong:** Matlab has quirks that trip up beginners and consume debugging time that should be spent learning concepts: 1-based indexing (intuitive, but confusing if she reads any Python resources), row vs column vector confusion, semicolon suppression, cryptic error messages, parentheses for both indexing and function calls.

**Prevention:**
- Create a "Matlab Quirks" reference card she can keep open while working
- When introducing each syntax element, explicitly show the common mistake and its error message: "If you see 'Index exceeds array dimensions,' it usually means..."
- Use consistent variable naming conventions from lesson 1 (e.g., always use descriptive names, never single letters except i,j for loop counters and x,y for coordinates)
- Teach `size()`, `whos`, and `disp()` as debugging tools in the very first lesson

**Phase relevance:** Phase 1 (Matlab fundamentals). Front-load the debugging toolkit.

### Pitfall 7: Information Theory Without Intuition

**What goes wrong:** Information theory (entropy, mutual information) is one of the hardest NEVR3004 topics for students without a strong math background. The standard presentation uses logarithms, summations, and probability distributions — all potentially unfamiliar.

**Prevention:**
- Build information theory on the "guessing game" intuition: entropy is how surprised you are, on average
- Use concrete examples with small, countable outcomes before any formulas: coin flips, dice, "which neuron fired?"
- Visualize probability distributions as bar charts before ever writing a formula
- Connect to neuroscience immediately: "A neuron that fires randomly carries no information. A neuron that fires only when the cat appears carries a lot."
- Introduce logarithms as a practical tool ("it makes multiplication into addition") not as an abstract function

**Phase relevance:** The information theory phase specifically. Needs careful scaffolding.

### Pitfall 8: Linear Algebra as a Separate Topic

**What goes wrong:** Teaching "linear algebra basics" as a standalone module before using it in neuroscience context. The learner memorizes matrix operations but cannot connect them to anything meaningful, and the knowledge decays before it is needed.

**Prevention:**
- Introduce each linear algebra concept exactly when it is first needed: vectors when working with neural firing rates, matrices when doing population coding, eigenvalues when doing PCA
- Always pair the math with a neuroscience visualization: "Each column of this matrix is a neuron's response. Each row is a time point. Now watch what happens when we multiply..."
- Never teach matrix operations in the abstract. Every operation should answer a question the learner already cares about.

**Phase relevance:** Math foundations should be distributed across all phases, not front-loaded.

### Pitfall 9: Skipping the "Why Should I Care?" Step

**What goes wrong:** Jumping into implementation without establishing why a technique matters. "Today we'll learn about PCA" means nothing to someone who has never encountered a dataset with too many dimensions. Without motivation, the lesson feels arbitrary.

**Prevention:**
- Every new topic starts with a problem: "Here are recordings from 100 neurons. How do we make sense of this?" Then the technique is introduced as the solution.
- Use real or realistic neuroscience data whenever possible, not abstract toy examples
- Connect every technique to a concrete question a neuroscientist would ask

**Phase relevance:** All phases, but especially mid-to-late phases covering advanced NEVR3004 topics.

## Minor Pitfalls

### Pitfall 10: Inconsistent Lesson Structure

**What goes wrong:** Each lesson has a different format, different conventions, different density. The learner cannot predict what to expect, which increases cognitive load from navigating the material itself.

**Prevention:**
- Establish a consistent lesson template from day one: hook (visual output) -> concept (2-3 sentences) -> code (with comments) -> exercise (modify the code) -> checkpoint (what you should now understand)
- Use the same plotting style, color scheme, and variable naming across all lessons
- Keep lesson length consistent (15-20 minute target completion time to respect attention limits)

**Phase relevance:** Phase 1. Establish the pattern early.

### Pitfall 11: No Quick Wins in Early Lessons

**What goes wrong:** The first few lessons are all setup and syntax, producing no satisfying output. The learner never experiences the reward of "I made something cool" and motivation drops before real learning begins.

**Prevention:**
- Lesson 1 should produce a visually interesting plot within the first 5 minutes of coding
- Every lesson should have at least one moment of "look what I just did"
- Front-load the most visually rewarding Matlab capabilities (plotting, animation) before the less exciting parts (data types, control flow)

**Phase relevance:** Phase 1, especially the first 2-3 lessons. First impressions determine engagement.

### Pitfall 12: Underestimating the Notation Translation Burden

**What goes wrong:** NEVR3004 lecture slides and textbooks use standard mathematical notation. Even if our lessons teach concepts visually, the learner still needs to recognize and parse the notation she encounters in class.

**Prevention:**
- After establishing visual intuition, explicitly bridge to the notation used in NEVR3004: "In your course slides, you'll see this written as [notation]. That's just the formula version of what we plotted."
- Create a notation cheat sheet that maps symbols to plain English and to Matlab code
- Practice reading notation as a separate skill, distinct from understanding the concept

**Phase relevance:** All phases, but especially once NEVR3004-specific topics begin.

## Phase-Specific Warnings

| Phase Topic | Likely Pitfall | Mitigation |
|-------------|---------------|------------|
| Matlab fundamentals | Boring syntax drill kills motivation | Start with plotting, weave syntax around visual outputs |
| Vectors and matrices | Abstract notation before intuition | Introduce through neuroscience data (firing rates, time series) |
| Programming constructs (loops, functions) | Dual novelty overload (new syntax + new logic) | Teach logic with pseudocode/flowcharts first, then Matlab syntax |
| Neural coding/decoding | Math prerequisites assumed | Build up from counting spikes to rate codes to tuning curves, visually |
| Information theory | Logarithms and summation notation barrier | Guessing game intuition first, formulas last |
| Dimensionality reduction (PCA) | "Why do I need this?" unclear | Start with the problem (too many neurons), not the solution (eigenvectors) |
| Attractor networks | ODE/dynamics concepts missing | Animate the dynamics, show the attractor landscape as a ball rolling on a surface |
| Neural data analysis | Real data messiness overwhelms | Use pre-cleaned datasets first, introduce preprocessing only after core analysis is comfortable |

## Sources

- [NEVR3004 Course Page, NTNU](https://www.ntnu.edu/studies/courses/NEVR3004)
- [Neuromatch Academy Prerequisites](https://compneuro.neuromatch.io/prereqs/ComputationalNeuroscience.html)
- [Universal Design for Learning for Children with ADHD (PMC)](https://pmc.ncbi.nlm.nih.gov/articles/PMC10453933/)
- [Visualization to support ADHD learners in math (Wiley)](https://nasenjournals.onlinelibrary.wiley.com/doi/10.1111/1467-8578.12466)
- [Why Visual Thinkers Struggle with Abstract Math](https://www.monstermath.app/blog/visual-thinkers-and-math-learning)
- [3 Visual Teaching Strategies for Students with ADHD](https://www.teachercreatedmaterials.com/free-spirit-publishing/blog/3-visual-teaching-strategies-for-students-with-adhd)
- [Concreteness Fading / CRA Model](https://makemathmoments.com/concreteness-fading/)
- [CHADD: Executive Functioning Disorder and Mathematics](https://chadd.org/adhd-news/adhd-news-educators/executive-functioning-disorder-and-mathematics/)
- [neuroplausible: I Hate Matlab](https://neuroplausible.com/matlab) — common Matlab frustrations in neuroscience
- [Matlab for Psychology and Neuroscience (Nottingham)](https://schluppeck.github.io/matlab/)
- [Working Memory Limits in Programming](https://super-productivity.com/blog/working-memory-limits-developers/)

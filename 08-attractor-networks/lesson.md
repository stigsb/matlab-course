# Module 08: Attractor Networks -- Energy Landscapes, Hopfield Memory, and Ring Attractors

## What you'll learn

By the end of this module, you'll be able to:
- Visualize **energy landscapes** and understand valleys as stable states (memories)
- Build a **Hopfield network** that stores patterns and retrieves them from noisy input
- Simulate a **ring attractor** that maintains a stable bump of activity representing head direction
- Connect attractor dynamics to what you learned about PCA and population coding

## What you need

- Completed Modules 01-07 (especially matrix multiplication, sign(), cos(), population coding)
- Matlab open with the `08-attractor-networks` folder as your current directory

## Why this matters

In Module 07, PCA showed us something surprising: neural activity that *looks* high-dimensional (hundreds of neurons) actually lives in a low-dimensional space. But PCA just describes the pattern -- it doesn't explain **why** the brain constrains itself this way.

Attractor networks provide the answer. They show how simple rules for how neurons connect and influence each other can create **stable states** -- valleys in an energy landscape that the network naturally falls into. These stable states are memories, decisions, and representations of the world.

This is not just theory. Real neurons in the head direction system maintain a persistent representation of which way an animal is facing, even in complete darkness. Attractor networks explain how.

---

## Part 1: What Are Attractors? (10-15 minutes)

### The ball-in-bowl metaphor

Imagine placing a marble into a bowl. No matter where you release it, the marble rolls to the bottom. The bottom of the bowl is an **attractor** -- a stable state that the system naturally moves toward.

Now imagine a landscape with multiple bowls (valleys) separated by hills:

```
Energy
  ^
  |   /\        /\
  |  /  \  __  /  \
  | /    \/  \/    \
  |/ Valley1  Valley2 \
  +-----------------------> State
```

A marble placed on this landscape rolls to the **nearest valley**. Which valley it ends up in depends on where you started -- the starting position determines the outcome.

In a neural network:
- The **landscape** is determined by the connection weights between neurons
- The **marble** is the current state of all neurons (their activity pattern)
- The **valleys** are stored memories or stable representations
- **Rolling downhill** is the network's update rule adjusting activity toward a stable state

The key insight: **the network "remembers" by having valleys in the right places.** When you give it a noisy or partial input (dropping the marble near a valley), it rolls to the correct memory (reaches the bottom).

### Energy functions

We can make this metaphor precise. An **energy function** assigns a number to every possible state of the network. The update rule is designed so that energy always decreases -- the marble always rolls downhill. The network is guaranteed to reach a valley (a local minimum of the energy).

For the Hopfield network you'll build shortly, the energy is:

```
E = -0.5 * S' * W * S
```

where `S` is the state vector (pattern of +1 and -1 values) and `W` is the weight matrix. Every time we update the state, this energy goes down or stays the same -- never up.

---

## Part 2: Hopfield Networks (20-25 minutes)

### Storing memories with Hebbian learning

A Hopfield network is a group of neurons that can each be either "on" (+1) or "off" (-1). The connections between neurons are set so that specific patterns become valleys in the energy landscape.

The learning rule is beautifully simple -- it's the Hebbian rule: **"neurons that fire together wire together."** If two neurons are both +1 in a pattern, strengthen their connection. If one is +1 and the other is -1, weaken it.

For a set of patterns stored as columns of a matrix `P` (each column is one pattern):

```matlab
W = (1/N) * (P * P');    % Hebbian learning
W(1:N+1:end) = 0;        % No self-connections (diagonal = 0)
```

That's it. The weight matrix `W` now has valleys at each of the stored patterns.

### Retrieving memories

To retrieve a memory, start from a noisy or partial version of a pattern and let the network "roll downhill":

```matlab
S = noisy_pattern;          % Starting state (the marble)
for iter = 1:max_iters
    S_new = sign(W * S);    % Update rule: multiply and threshold
    S_new(S_new == 0) = 1;  % sign(0) = 0 in Matlab, fix to +1
    if isequal(S_new, S)
        break;              % Converged -- reached a valley
    end
    S = S_new;
end
```

The `sign()` function thresholds: positive values become +1, negative become -1. The matrix multiplication `W * S` computes the total input to each neuron from all other neurons.

### Important details

**No self-connections:** We set the diagonal of `W` to zero. A neuron shouldn't influence itself -- that would create trivial feedback.

**The sign(0) pitfall:** In Matlab, `sign(0)` returns `0`, but our network only has +1 and -1 states. Always replace zeros with +1 after calling `sign()`.

**Capacity limit:** A Hopfield network with `N` neurons can reliably store about `0.14 * N` patterns. Beyond this, memories start interfering with each other -- valleys merge or disappear. For 25 neurons, that's about 3-4 patterns maximum.

### Measuring retrieval

**Overlap** tells you how similar the current state is to a stored pattern:

```matlab
overlap = (1/N) * (S' * pattern);   % +1 = perfect match, -1 = inverted, 0 = random
```

Track this during retrieval to watch the network converge to the correct memory.

---

## Part 3: Ring Attractors (15-20 minutes)

### From discrete memories to continuous variables

Hopfield networks store discrete patterns -- a finite set of memories. But some things the brain represents are **continuous**: the direction you're facing, the position of your hand, the loudness of a sound.

A **ring attractor** solves this problem. It represents a continuous circular variable (like head direction, 0-360 degrees) using a "bump" of neural activity.

### Population coding meets attractor dynamics

Remember population coding from Module 05? Neurons in the head direction system each have a **preferred direction** -- they fire most when the animal faces a specific direction. Together, the population forms a pattern of activity where the most active neurons indicate the current heading.

A ring attractor takes this further: the neurons are connected so that a bump of activity **persists on its own**, even without sensory input. This is how the brain remembers which way you're facing in the dark.

### Mexican-hat connectivity

The trick is the connection pattern. Each neuron:
- **Excites** its neighbors (neurons with similar preferred directions)
- **Inhibits** distant neurons (neurons with very different preferred directions)

This creates a "Mexican hat" profile (wide brim = inhibition, crown = excitation):

```matlab
% N neurons with preferred directions evenly spaced around 360 degrees
theta = linspace(0, 2*pi, N+1);
theta = theta(1:end-1);

% Connectivity: excite neighbors, inhibit distant
W(i,j) = cos(theta(i) - theta(j)) - 0.5;
W(1:N+1:end) = 0;   % No self-connections
```

The `cos()` function is perfect here: it's +1 for neurons with the same preferred direction, -1 for opposite directions, and smoothly varies between.

### The simulation

Starting from a bump of activity at some direction, the network maintains that bump through its own dynamics:

```matlab
% Update rule (simplified)
input = W * activity';         % Total input to each neuron
activity = max(0, input');     % Rectify: no negative firing rates
activity = activity / sum(activity);  % Normalize to prevent blow-up
```

The bump stays put without any external input -- the network "remembers" the direction. External input (like a vestibular signal from head rotation) can smoothly shift the bump to a new position.

---

## Part 4: Attractors in Neuroscience (5-10 minutes)

### The PCA connection

Remember how PCA showed that neural population activity lives in a low-dimensional space? Attractor networks explain **why**:

- The connectivity between neurons creates an energy landscape with specific valleys
- These valleys form a low-dimensional **manifold** -- a surface within the high-dimensional space
- Neural activity is constrained to stay near this manifold
- PCA captures this low-dimensional structure from data; attractors explain the mechanism

In other words: PCA shows you the shape of the valleys. Attractor networks explain how the valleys got there.

### Real attractor networks in the brain

**Head direction cells** in the anterodorsal thalamus and postsubiculum maintain a persistent representation of facing direction, even in darkness. This is the ring attractor in action.

**Place cells** in the hippocampus fire at specific locations. Some models use attractor dynamics to explain how the brain maintains a "map" of space.

**Decision-making** can be modeled as a ball rolling between two valleys -- one for each choice. Evidence accumulates (tilts the landscape) until the ball rolls into one valley (a decision is made). This explains both the speed and the "all-or-nothing" nature of decisions.

### Summary

| Concept | Key Idea | Matlab Tool |
|---------|----------|-------------|
| Energy landscape | Valleys = stable states | `surf()`, function plotting |
| Hopfield network | Hebbian weights + sign threshold | `W = P*P'/N`, `sign(W*S)` |
| Ring attractor | Cosine connectivity + bump activity | `cos()`, `max(0,x)` |
| Attractor = memory | Network rolls to nearest valley | Iterative update loop |

---

## Next steps

- Run `demo_energy_landscape.m` to see the ball-in-bowl metaphor come alive
- Run `demo_hopfield.m` to store and retrieve patterns from noisy input
- Run `demo_ring_attractor.m` to see a bump of activity maintain head direction
- Work through `exercise_attractors.m` to build these systems yourself
- Check `reference/pca_attractors.md` for a quick-reference card

---

*This module completes the computational neuroscience arc: from basic Matlab (Modules 1-3), through mathematical foundations (Module 4), neural coding (Module 5), information theory (Module 6), dimensionality reduction (Module 7), to attractor dynamics (Module 8). You now have the tools to understand how the brain computes.*

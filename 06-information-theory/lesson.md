# Module 06: Information Theory

How much does a neural response actually *tell* you about the stimulus? Information theory gives us the tools to answer that question with a number.

This module introduces three ideas, each building on the last:
1. **Logarithms** -- the mathematical tool that makes it all work
2. **Entropy** -- how much uncertainty (surprise) is in a signal
3. **Mutual information** -- how much one signal tells you about another

---

## 1. Logarithms: The Scale of Information

### The Core Idea

How many times do you double 1 to get 8?

| Start | Double 1 | Double 2 | Double 3 |
|-------|----------|----------|----------|
| 1     | 2        | 4        | **8**    |

Three times. That is what log2(8) means: **log2(8) = 3**.

Logarithms are the "undo" button for exponents, like subtraction undoes addition:
- 2^3 = 8, so log2(8) = 3
- 2^10 = 1024, so log2(1024) = 10

### Why Log2?

We use base-2 logarithms because information is measured in **bits**. Each bit answers one yes/no question:

| Possibilities | Bits needed | Why                            |
|---------------|-------------|--------------------------------|
| 2             | 1           | "Heads or tails?"              |
| 4             | 2           | "Top/bottom?" then "left/right?" |
| 8             | 3           | Three yes/no questions          |
| 256           | 8           | One byte                        |

The key insight: **doubling the number of possibilities adds just 1 bit.**

### Logarithms Turn Multiplication into Addition

This is the property that makes logarithms so powerful:

```
log2(a * b) = log2(a) + log2(b)
```

Example: log2(8 x 4) = log2(8) + log2(4) = 3 + 2 = 5 = log2(32).

This is exactly why we use logarithms for information: combining two independent signals multiplies the possibilities but *adds* the information.

### In Matlab

```matlab
log2(8)       % 3 -- base-2 logarithm (bits)
log(8)        % 2.08 -- natural logarithm (base e, "nats")
log10(100)    % 2 -- base-10 logarithm (orders of magnitude)
```

**Watch out:** Matlab's `log()` is the *natural* log (base e), not base 10. Use `log2()` for information in bits.

### Notation Bridge

In textbooks you will see:

| Notation        | Meaning                | Matlab       |
|-----------------|------------------------|--------------|
| log_2(x)        | Base-2 logarithm       | `log2(x)`    |
| ln(x)           | Natural logarithm      | `log(x)`     |
| log_10(x)       | Base-10 logarithm      | `log10(x)`   |
| log_b(x)        | Base-b logarithm       | `log(x)/log(b)` |

Change of base formula: log_b(x) = ln(x) / ln(b). In Matlab: `log(x) / log(b)`.

---

## 2. Entropy: Measuring Surprise

### The Core Idea

Entropy measures **how surprised you will be** by the outcome.

Think about predicting the weather:
- **Sahara desert:** Sunny. Sunny. Sunny. Boring. Low entropy.
- **Bergen, Norway:** Rain? Sun? Sleet? Snow? Exciting. High entropy.

If you already know what will happen, there is no surprise and no information. If anything could happen, that is maximum surprise and maximum information.

### The Fair Coin: Exactly 1 Bit

A fair coin has two equally likely outcomes. Its entropy is:

```
H = -(0.5 * log2(0.5) + 0.5 * log2(0.5))
  = -(0.5 * (-1) + 0.5 * (-1))
  = -(-1)
  = 1.0 bit
```

One bit of entropy means you need exactly one yes/no question to remove all uncertainty: "Is it heads?"

### The Formula

For a distribution with outcomes that have probabilities p_1, p_2, ..., p_n:

```
H = -sum( p_i * log2(p_i) )
```

In Matlab:
```matlab
H = -sum(p .* log2(p));   % DANGER: breaks if any p is 0!
```

### The 0 * log(0) Trap

What happens when an outcome has probability 0?
- log2(0) = -Infinity
- 0 * (-Infinity) = NaN in Matlab

But the convention is: **0 * log2(0) = 0** (an impossible outcome contributes no surprise).

The fix in Matlab -- filter out zeros:
```matlab
H = -sum(p(p > 0) .* log2(p(p > 0)));
```

This is what our `compute_entropy()` function does.

### Entropy Examples

| Distribution              | H (bits) | Why                                |
|---------------------------|----------|------------------------------------|
| Fair coin [0.5, 0.5]     | 1.00     | Maximum uncertainty for 2 outcomes |
| Biased coin [0.9, 0.1]   | 0.47     | Mostly predictable                 |
| Fair 4-sided die          | 2.00     | 2 bits = 2 yes/no questions        |
| Certain outcome [1,0,0,0] | 0.00     | No surprise at all                 |

**Pattern:** Entropy is maximized when all outcomes are equally likely (uniform distribution). It is 0 when the outcome is certain.

### Notation Bridge

In textbooks you will see:

| Notation         | Meaning                                | Matlab                                       |
|------------------|----------------------------------------|----------------------------------------------|
| H(X)             | Entropy of random variable X           | `compute_entropy(p_x)`                       |
| H(X) = -sum p(x) log2 p(x) | The entropy formula     | `-sum(p(p>0) .* log2(p(p>0)))`               |
| H(X) <= log2(N)  | Entropy is at most log2 of outcomes    | Maximum when distribution is uniform          |

---

## 3. Mutual Information: What Does the Neuron Tell You?

### The Core Idea

You show a stimulus. A neuron fires. **How much did the neuron's firing tell you about which stimulus was shown?**

That is mutual information (MI). It measures the *shared* information between two signals.

Analogy: If a neuron fires a lot, and you know that pattern means "stimulus is on the right," then the neuron's firing gave you information about the stimulus location. If the neuron fires randomly regardless of stimulus, it tells you nothing.

### Building from Entropy

MI is built from two entropies:

1. **H(response)** -- How uncertain are you about the response, before knowing anything?
2. **H(response | stimulus)** -- How uncertain are you about the response, *given* you know the stimulus?

The difference is MI:

```
MI = H(response) - H(response | stimulus)
```

- If knowing the stimulus removes ALL uncertainty about the response: MI = H(response). Perfect information.
- If knowing the stimulus removes NO uncertainty: MI = 0. The neuron tells you nothing.

### Step by Step

**Step 1: Observe stimulus-response pairs.**
Run trials: show stimulus s, record response r. Build a table of joint observations.

**Step 2: Build the joint probability matrix.**
Count how often each (stimulus, response) pair occurs. Normalize to probabilities.

```matlab
joint_prob = joint_counts / sum(joint_counts(:));
```

**Step 3: Compute marginal distributions.**
```matlab
p_stim = sum(joint_prob, 2)';   % sum over responses
p_resp = sum(joint_prob, 1);    % sum over stimuli
```

**Step 4: Compute H(response).**
```matlab
H_resp = compute_entropy(p_resp);
```

**Step 5: Compute H(response | stimulus).**
For each stimulus, compute the conditional entropy, then take the weighted average:
```matlab
H_resp_given_stim = 0;
for s = 1:n_stimuli
    p_r_given_s = joint_prob(s, :) / p_stim(s);
    H_resp_given_stim = H_resp_given_stim + ...
        p_stim(s) * compute_entropy(p_r_given_s);
end
```

**Step 6: MI = H(R) - H(R|S).**

### The Venn Diagram

```
    H(stimulus)        H(response)
   ┌───────────┐    ┌───────────┐
   │           │    │           │
   │     ┌─────┼────┼─────┐    │
   │     │ MI  │    │     │    │
   │     │     │    │     │    │
   │     └─────┼────┼─────┘    │
   │           │    │           │
   └───────────┘    └───────────┘
```

- MI is the **overlap** -- the information shared between stimulus and response.
- H(response | stimulus) is the part of H(response) that is NOT in the overlap (noise).
- H(stimulus | response) is the part of H(stimulus) that is NOT in the overlap (lost information).

### Sanity Check: Shuffling

A good sanity check: shuffle the stimulus-response pairings randomly. If you break the real relationship, MI should drop to near zero. If it does not, something is wrong with your computation.

### Notation Bridge

In textbooks you will see:

| Notation          | Meaning                                      | Matlab                                |
|-------------------|----------------------------------------------|---------------------------------------|
| I(X;Y)            | Mutual information between X and Y           | `H_resp - H_resp_given_stim`         |
| I(X;Y) = H(Y) - H(Y\|X) | MI via conditional entropy          | As computed above                     |
| I(X;Y) = H(X) + H(Y) - H(X,Y) | MI via joint entropy        | Equivalent formula                    |
| H(Y\|X)           | Conditional entropy of Y given X             | Weighted average of conditional H     |

---

## 4. Visualizing Information

### Bar Charts
Compare entropies of different distributions side by side. Horizontal bar charts make labels easy to read.

### Heatmaps
The joint probability matrix is best shown with `imagesc()` and a `colorbar`. Each cell shows how likely a particular (stimulus, response) combination is.

### The Venn Diagram
Draw overlapping circles for H(X) and H(Y). The overlap region is MI. This diagram makes the relationship between entropy, conditional entropy, and MI visually clear.

### Stimulus-Response Matrices
For each stimulus, plot the response distribution as a bar chart. If the distributions look different across stimuli, the neuron carries information (high MI). If they all look the same, it does not (low MI).

---

## Common Gotchas

| Gotcha                        | What happens               | Fix                                   |
|-------------------------------|----------------------------|---------------------------------------|
| `0 * log2(0)`                 | Returns NaN                | Filter: `p(p>0) .* log2(p(p>0))`     |
| Using `log()` instead of `log2()` | Entropy in nats, not bits | Use `log2()` for bits                 |
| Probabilities not summing to 1 | Meaningless entropy values | Normalize: `p = counts / sum(counts)` |
| Too few trials for MI         | MI biased upward           | Use enough trials per bin              |
| `histc` instead of `histcounts` | Deprecated function       | Use `histcounts` (modern Matlab)      |

---

## Run the Demos

1. `demo_logarithms.m` -- See what logarithms do visually
2. `demo_entropy.m` -- Compare entropy of five distributions
3. `demo_mutual_information.m` -- Compute MI between stimulus and neural response

Then practice with `exercise_info_theory.m`.

---
title: "Module 5: Neural Coding"
description: "Simulate spike trains, plot tuning curves, visualize population coding, and build a population vector decoder."
sidebar:
  order: 5
---

## What you'll learn

By the end of this module, you'll be able to:
- Generate simulated **spike trains** and visualize them as raster plots
- Plot a **tuning curve** showing which stimulus a neuron prefers
- Visualize **population coding** -- how groups of neurons encode information together
- Build a **population vector decoder** that reads neural activity backwards to figure out the stimulus

## What you need

- Completed Modules 01-04 (variables, vectors, functions, loops, statistics)
- Matlab open with the `05-neural-coding` folder as your current directory

## Why this matters

So far, you've been learning Matlab itself -- syntax, plotting, math. Now we turn to the actual question of NEVR3004: **how do neurons encode and transmit information?**

This is the core puzzle of computational neuroscience. A neuron either fires or doesn't fire -- it's like a single telegraph pulse. How does the brain represent something as rich as "my hand is moving to the left at 30 cm/s" using nothing but these pulses?

The answer involves three levels:
1. **Single neuron coding** -- one neuron fires more for some stimuli than others
2. **Population coding** -- many neurons together give a much clearer signal
3. **Neural decoding** -- reading the neural code "backwards" to figure out the stimulus

---

## Part 1: Spike Trains (15-20 minutes)

### The telegraph analogy

Neurons communicate with electrical pulses called **spikes** (also called action potentials). Each spike is essentially identical -- there's no "big spike" or "small spike." The message is entirely in **when** the spikes happen.

Think of it like a telegraph: the operator can only tap or not tap. The message is in the timing and pattern of taps, not in how hard they press.

A **spike train** is the sequence of spike times for one neuron. If you record a neuron for 2 seconds, you might see something like:

```
Time:   |--*---*--*-----*---*--*---*------|
         0                                 2 seconds
```

Each `*` is one spike. This particular neuron fired about 3-4 times per second.

### Random firing: the Poisson model

Real neurons don't fire like a metronome at perfectly regular intervals. There's randomness in when each spike occurs. The simplest model for this randomness is a **Poisson process**: at each tiny time step, the neuron has some probability of firing, independently of when it last fired.

For example, a neuron with a firing rate of 30 Hz (30 spikes per second) doesn't fire exactly every 33 ms. Instead, in each 1 ms time step, it has a 3% chance of firing: 30 spikes/s * 0.001 s = 0.03.

To simulate this, we generate a random number at each time step. If it's less than rate * dt, we get a spike:

```matlab
spikes = rand(1, n_steps) < rate * dt;
```

This gives us a vector of 1s (spikes) and 0s (no spike). Simple, but it captures the essential randomness of real neural firing.

### Visualizing spike trains

**Raster plot:** Each spike is drawn as a short vertical tick mark at its time. When you have multiple trials, each trial gets its own row. This lets you see both the individual spikes and the overall pattern.

**PSTH (peri-stimulus time histogram):** Average the spike counts across trials in time bins. This smooths out the randomness and reveals the underlying firing rate over time.

**ISI histogram (interspike interval):** Plot the distribution of time gaps between consecutive spikes. For a Poisson process, this should be an exponential distribution.

> **Try it:** Run `demo_spike_trains.m` to see raster plots, a PSTH, and an ISI histogram.

### Notation Bridge

The firing rate is usually written as **lambda** (the Greek letter):

- **lambda** = average firing rate (spikes per second, or Hz)
- **dt** = the size of each time step (usually 0.001 s = 1 ms)
- **P(spike in one time step)** = lambda * dt

So for lambda = 30 Hz and dt = 1 ms:
P(spike) = 30 * 0.001 = 0.03 = 3%

The expected number of spikes in time T is: lambda * T. For a 2-second recording at 30 Hz, you'd expect about 60 spikes.

---

## Part 2: Tuning Curves (15-20 minutes)

### The radio antenna analogy

Different neurons respond to different things. In motor cortex, some neurons fire most when you move your hand to the right. Others prefer upward movement. Others prefer 37 degrees.

A **tuning curve** shows how much a neuron fires for each possible stimulus. It answers: "what does this neuron care about?"

Think of it like radio antennas: each antenna picks up one station best, but it can also faintly pick up nearby stations. The tuning curve shows the reception strength for each frequency.

### Cosine tuning

In 1982, Georgopoulos and colleagues discovered that many motor cortex neurons have a beautifully simple tuning curve: it follows a **cosine** shape. The neuron fires most for its preferred direction and least for the opposite direction.

The formula is:

```
firing_rate = baseline + gain * cos(direction - preferred_direction)
```

Where:
- **baseline** = the firing rate even when the stimulus is at the worst direction
- **gain** = how much extra the neuron fires for its preferred direction
- **preferred_direction** = the direction that makes the neuron fire most

In Matlab, since we work in degrees:

```matlab
firing_rates = baseline + gain * cosd(directions - preferred_dir);
```

### Visualizing tuning curves

A **polar plot** is the most intuitive way to show a tuning curve: the angle represents the stimulus direction, and the distance from center represents the firing rate. The result is a figure-eight shape that "points" toward the preferred direction.

A regular line plot (direction on x-axis, rate on y-axis) is clearer for reading exact values but less intuitive for understanding the directional preference.

> **Try it:** Run `demo_tuning_curves.m` to see polar plots and line plots of neuron tuning curves.

### Notation Bridge

The tuning curve equation is usually written as:

**f(theta) = r_0 + g * cos(theta - theta_pref)**

Where:
- **f(theta)** = firing rate as a function of stimulus direction theta
- **r_0** = baseline firing rate (Hz)
- **g** = gain or modulation depth (Hz)
- **theta_pref** = preferred direction (the peak of the cosine)

The maximum firing rate is r_0 + g (at the preferred direction).
The minimum firing rate is r_0 - g (at the opposite direction).

If g > r_0, the minimum would be negative, which is impossible for a firing rate. In practice, we clip at zero: max(0, rate).

---

## Part 3: Population Coding (15-20 minutes)

### The wisdom of crowds

One neuron is noisy and ambiguous. If a neuron with preferred direction 90 degrees fires 20 spikes, the stimulus could be at 90 degrees, or 80, or 100 -- you can't tell from one neuron alone.

But if you have **8 neurons** with different preferred directions, and each one fires according to its cosine tuning curve (plus noise), you get 8 noisy measurements. Together, they point clearly toward the stimulus.

This is like asking 8 friends to point toward a sound source. Each person's pointing is a bit off, but if you average all their estimates, you get a very good answer.

This is **population coding**: information is encoded not by any single neuron, but by the pattern of activity across the whole population.

### Visualizing population activity

A **heatmap** is an effective way to see population activity at a glance. Each row is a neuron (labeled by its preferred direction), and the color intensity shows how strongly it fires. The brightest row tells you roughly which direction the stimulus came from.

> **Try it:** Run `demo_population_coding.m` to see population activity heatmaps and decoded directions.

---

## Part 4: Neural Decoding (10-15 minutes)

### Reading the code backwards

So far we've gone from stimulus to neural response (encoding). **Decoding** goes the other direction: given the neural responses, what was the stimulus?

This is the question neuroscientists ask when they build brain-computer interfaces: "This patient's motor cortex neurons are firing with these rates -- which direction are they trying to move?"

### The population vector method

The simplest decoder is the **population vector**: each neuron "votes" for its preferred direction, weighted by how strongly it fires. The sum of all votes gives the decoded direction.

If the neuron that prefers 90 degrees fires a lot, and the neuron that prefers 0 degrees fires a little, the population vector will point somewhere between 0 and 90, closer to 90.

In Matlab:
```matlab
pop_vec_x = sum(responses .* cosd(pref_dirs));
pop_vec_y = sum(responses .* sind(pref_dirs));
decoded_dir = atan2d(pop_vec_y, pop_vec_x);
```

### Notation Bridge

The population vector is a **weighted sum** of the preferred direction vectors:

**P = sum_i( r_i * d_i )**

Where:
- **r_i** = firing rate of neuron i
- **d_i** = unit vector pointing in neuron i's preferred direction
- **P** = population vector (pointing toward the decoded direction)

In Cartesian coordinates:
- P_x = sum( r_i * cos(theta_pref_i) )
- P_y = sum( r_i * sin(theta_pref_i) )

The decoded direction is: **theta_decoded = atan2(P_y, P_x)**

`atan2` (or `atan2d` in degrees) correctly handles all four quadrants, unlike plain `atan`.

---

## What's next?

You can now simulate and visualize the basic neural code. In **Module 06: Information Theory**, you'll learn to *quantify* how much information a neural response carries about the stimulus -- using entropy, mutual information, and the mathematics of logarithms.

---

## Summary

| Concept | Key Idea | Matlab Function |
|---------|----------|-----------------|
| Spike train | Random firing at a given rate | `rand(1, n) < rate * dt` |
| Raster plot | Vertical ticks showing spike times | `plot([t t], [lo hi])` |
| PSTH | Average firing rate over time | `histcounts` + divide by trials |
| Tuning curve | How firing rate depends on stimulus | `baseline + gain * cosd(...)` |
| Polar plot | Show tuning curve as directional shape | `polarplot(theta, r)` |
| Population coding | Activity pattern across many neurons | `imagesc(activity); colorbar` |
| Population vector | Weighted sum of preferred directions | `sum(r .* cosd(pref))` |
| Decoded direction | Population vector angle | `atan2d(py, px)` |

## Download Scripts

Download these files and open them in MATLAB Desktop:

- [decode_direction.m](/scripts/05-neural-coding/decode_direction.m)
- [demo_population_coding.m](/scripts/05-neural-coding/demo_population_coding.m)
- [demo_spike_trains.m](/scripts/05-neural-coding/demo_spike_trains.m)
- [demo_tuning_curves.m](/scripts/05-neural-coding/demo_tuning_curves.m)
- [exercise_neural_coding.m](/scripts/05-neural-coding/exercise_neural_coding.m)
- [solution_neural_coding.m](/scripts/05-neural-coding/solution_neural_coding.m)

:::tip
To run these scripts, save them to a folder, set that folder as your MATLAB Current Folder, then press F5 or click Run.
:::

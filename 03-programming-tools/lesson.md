# Module 03: Programming Tools -- Functions, Loops, and Conditionals

## What you'll learn

By the end of this module, you'll be able to:
- Write your own **functions** that take inputs and produce outputs
- Use **for-loops** and **while-loops** to repeat computations over data
- Use **if/else conditionals** to make decisions in your code
- Combine all three to process and filter experimental data

## What you need

- Completed Module 01 (variables, scripts) and Module 02 (vectors, plotting)
- Matlab open with the `03-programming-tools` folder as your current directory

## Why this matters

So far, your scripts run top to bottom -- every line executes once, in order. That's fine for quick plots, but real data analysis needs more:

- **Functions** let you package up a computation so you can reuse it. Instead of copying the same five lines everywhere, you write them once and call them by name.
- **Loops** let you repeat a computation for every item in your data. Instead of writing the same line 100 times, you write it once inside a loop.
- **Conditionals** let your code make decisions. "If this reaction time is too slow, skip it."

Together, these three constructs turn you from someone who runs scripts into someone who writes programs.

---

## Part 1: Functions (15-20 minutes)

### The recipe analogy

Think of a function like a recipe. You give it **ingredients** (inputs), it follows some **steps** (the function body), and it produces a **dish** (output).

For example, a "compute BMI" recipe:
- **Ingredients:** weight in kg, height in meters
- **Steps:** divide weight by height squared
- **Dish:** the BMI number

In Matlab, that looks like this:

```matlab
function bmi = compute_bmi(weight_kg, height_m)
    bmi = weight_kg / height_m^2;
end
```

Let's break that down:
- `function` -- tells Matlab "this is a function, not a regular script"
- `bmi` -- the output variable (the "dish")
- `compute_bmi` -- the function's name (how you call it)
- `(weight_kg, height_m)` -- the inputs (the "ingredients")
- `bmi = weight_kg / height_m^2;` -- the computation
- `end` -- marks the end of the function

### Calling a function

Once defined, you call it just like `mean()` or `plot()`:

```matlab
enzo_bmi = compute_bmi(5.2, 0.25);
fprintf('Enzo BMI: %.1f\n', enzo_bmi);
```

### Multiple outputs

A function can return more than one thing. Wrap the outputs in square brackets:

```matlab
function [m, s, r] = describe_data(data)
    m = mean(data);
    s = std(data);
    r = max(data) - min(data);
end
```

Call it like this:

```matlab
[avg, spread, range] = describe_data([12, 8, 15, 22, 6]);
```

### Two ways to define functions

**Method 1: Local functions (at the bottom of a script)**

You can put functions at the end of any script file. They're only available inside that script:

```matlab
% my_script.m
clear; clc; close all;

result = square(5);
fprintf('5 squared = %d\n', result);

% Local functions go at the bottom
function y = square(x)
    y = x^2;
end
```

**Method 2: Function files (separate .m files)**

For functions you want to reuse across scripts, put them in their own file. The filename **must** match the function name:

- File `average_value.m` contains `function avg = average_value(data)`
- File `filter_data.m` contains `function filtered = filter_data(data, threshold)`

> **Common mistake:** If the filename and function name don't match, Matlab uses the filename but gets confused. Always make them identical.

### Key pitfall: Assign to the output variable!

The output variable in `function y = myFunc(x)` is `y`. You **must** assign a value to `y` before the function ends. If you compute the answer in a different variable and forget to assign it to `y`, the function returns garbage.

```matlab
% WRONG -- forgot to assign to y
function y = double_it(x)
    result = x * 2;  % computed it, but never put it in y!
end

% RIGHT -- assign to the declared output
function y = double_it(x)
    y = x * 2;
end
```

> **Try it:** Run `demo_functions.m` to see functions in action. Then come back here.

---

## Part 2: Loops (15-20 minutes)

### For-loops: "Do this for each item"

A for-loop repeats a block of code, once for each value in a list:

```matlab
plant_heights = [12, 8, 15, 22, 6, 18, 10, 14, 25, 9];

for i = 1:length(plant_heights)
    fprintf('Plant %d is %d cm tall\n', i, plant_heights(i));
end
```

This says: "For `i` going from 1 to the number of plants, print that plant's height."

You can also loop directly over the values:

```matlab
for height = plant_heights
    fprintf('Height: %d cm\n', height);
end
```

### The loop-and-accumulate pattern

This is the most important pattern for data processing. You start with an empty result and build it up:

```matlab
% Collect all plants taller than 15 cm
tall_plants = [];

for i = 1:length(plant_heights)
    if plant_heights(i) > 15
        tall_plants = [tall_plants, plant_heights(i)];
    end
end

fprintf('Found %d tall plants\n', length(tall_plants));
```

This pattern comes up constantly in neuroscience: "collect all trials where the reaction time was under 500ms," "accumulate the spike counts for each condition," etc.

> **Performance note:** For small datasets (hundreds of values), this is perfectly fine. If you ever work with millions of data points, you would pre-allocate with `zeros()` first. For this course, don't worry about it.

### While-loops: "Keep going until..."

A while-loop keeps repeating as long as a condition is true:

```matlab
number = 1000;
steps = 0;

while number >= 1
    number = number / 2;
    steps = steps + 1;
end

fprintf('Took %d steps to get below 1\n', steps);
```

While-loops are less common than for-loops, but useful when you don't know in advance how many iterations you need.

### Break and continue

- `break` -- exit the loop immediately
- `continue` -- skip to the next iteration

```matlab
% Find the first plant taller than 20 cm
for i = 1:length(plant_heights)
    if plant_heights(i) > 20
        fprintf('First tall plant: #%d (%d cm)\n', i, plant_heights(i));
        break;  % stop looking, we found one
    end
end
```

> **Try it:** Run `demo_loops.m` to see loops in action.

---

## Part 3: Conditionals (15-20 minutes)

### If/elseif/else: Making decisions

An if-statement lets your code choose what to do based on a condition:

```matlab
temperature = 22;

if temperature < 10
    fprintf('Cold! Wear a jacket.\n');
elseif temperature < 20
    fprintf('Cool. A sweater will do.\n');
else
    fprintf('Warm! T-shirt weather.\n');
end
```

The conditions are checked top to bottom. The first one that's true runs, and the rest are skipped.

### Comparison operators

| Operator | Meaning | Example |
|----------|---------|---------|
| `==` | Equal to | `x == 5` |
| `~=` | Not equal to | `x ~= 0` |
| `<` | Less than | `x < 10` |
| `>` | Greater than | `x > 0` |
| `<=` | Less than or equal | `x <= 100` |
| `>=` | Greater than or equal | `x >= 1` |

> **Critical pitfall: `=` vs `==`**
>
> - `=` means **assign**: `x = 5` stores 5 in x
> - `==` means **compare**: `x == 5` asks "is x equal to 5?"
>
> Writing `if x = 5` is a common mistake. Matlab will give you an error, but the error message can be confusing. Remember: one equals sign assigns, two equals signs compare.

### Logical operators

Combine conditions with:
- `&&` -- AND (both must be true)
- `||` -- OR (at least one must be true)
- `~` -- NOT (flips true to false)

```matlab
age = 25;
has_ticket = true;

if age >= 18 && has_ticket
    fprintf('Welcome to the concert!\n');
end
```

### Combining loops and conditionals

The real power comes from putting conditionals inside loops. This lets you process data and classify each item:

```matlab
reaction_times = [320, 510, 280, 620, 410, 390, 710, 340];

fast_count = 0;
slow_count = 0;

for i = 1:length(reaction_times)
    if reaction_times(i) < 400
        fast_count = fast_count + 1;
    else
        slow_count = slow_count + 1;
    end
end

fprintf('Fast reactions: %d, Slow reactions: %d\n', fast_count, slow_count);
```

> **Try it:** Run `demo_conditionals.m` to see conditionals in action.

---

## Part 4: Putting It Together (15-20 minutes)

Now let's combine all three constructs. Imagine you have reaction time data from an experiment and you want to:

1. **Write a function** that computes the average of a vector
2. **Loop** through all reaction times and classify each one
3. **Use conditionals** to sort them into categories

```matlab
% Define categories
reaction_times = [320, 510, 280, 620, 410, 390, 710, 340, 450, 380];

fast = [];
medium = [];
slow = [];

for i = 1:length(reaction_times)
    rt = reaction_times(i);
    if rt < 350
        fast = [fast, rt];
    elseif rt < 500
        medium = [medium, rt];
    else
        slow = [slow, rt];
    end
end

fprintf('Fast (<%d ms): %d trials, avg = %.0f ms\n', 350, length(fast), average_value(fast));
fprintf('Medium: %d trials, avg = %.0f ms\n', length(medium), average_value(medium));
fprintf('Slow (>%d ms): %d trials, avg = %.0f ms\n', 500, length(slow), average_value(slow));
```

Here, `average_value` is a function you write in its own file (`average_value.m`). That's the pattern: write reusable computation in function files, then use loops and conditionals in scripts to process your data.

> **Try it:** Work through `exercise_programming.m` to practice all three constructs.

---

## Quick Reference

| Construct | Syntax | Purpose |
|-----------|--------|---------|
| Function (local) | `function y = name(x) ... end` | Reusable computation at bottom of script |
| Function (file) | Same, in its own `.m` file | Reusable across scripts |
| For-loop | `for i = 1:n ... end` | Repeat for each item |
| While-loop | `while condition ... end` | Repeat until condition is false |
| If/else | `if ... elseif ... else ... end` | Make decisions |
| Break | `break` | Exit loop early |
| Continue | `continue` | Skip to next iteration |

## Common Mistakes Checklist

- [ ] Did I use `==` (not `=`) in my if-statement?
- [ ] Does my function filename match the function name?
- [ ] Did I assign a value to the output variable before the function ends?
- [ ] Did I end every `function`, `for`, `while`, and `if` with `end`?

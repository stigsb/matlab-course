# Module 02: Vectors, Matrices, and Plotting

In this module you will learn to work with collections of numbers (vectors and matrices) and turn them into beautiful plots.

By the end, you will be able to create data, slice it, dice it, and visualize it in four different ways. You will also meet your first real math concept -- vectors as arrows -- and discover that you already know the math behind it.

---

## Vectors -- Ordered Lists of Numbers

A vector is like a shopping list -- an ordered collection of items. Instead of groceries, we are collecting numbers.

Imagine weighing the five cats at the vet:

```matlab
cat_weights = [4.2, 3.8, 5.1, 3.5, 4.7];
```

That is a vector. Five numbers, in order. Enzo would be somewhere in there (probably the 5.1).

### Three Ways to Create Vectors

**1. Bracket notation** -- type the numbers yourself:

```matlab
family_ages = [42, 40, 11, 8];
```

**2. Colon operator** -- create a range:

```matlab
days = 1:7;            % [1 2 3 4 5 6 7]
angles = 0:0.1:2*pi;   % 0 to ~6.28 in steps of 0.1
```

The pattern is `start:step:stop`. If you leave out the step, it defaults to 1.

**3. linspace** -- evenly spaced points:

```matlab
smooth_x = linspace(0, 10, 50);   % 50 points from 0 to 10
```

Use `linspace` when you want a specific number of points (great for smooth plots).

### Row vs Column Vectors

Spaces or commas make a row vector (horizontal):

```matlab
row = [1 2 3];        % size: 1x3
```

Semicolons make a column vector (vertical):

```matlab
col = [1; 2; 3];      % size: 3x1
```

Check with `size()`:

```matlab
size(row)   % returns [1, 3]  -- 1 row, 3 columns
size(col)   % returns [3, 1]  -- 3 rows, 1 column
```

To flip between them, use the transpose operator `'` (apostrophe):

```matlab
col = row';   % row becomes column
row = col';   % column becomes row
```

---

## Grabbing Pieces -- Indexing and Slicing

Now that you have a vector, how do you get specific numbers out of it?

**Matlab starts counting at 1, not 0.** This is different from most programming languages. If you try `v(0)`, you will get an error.

Using our cat weights:

```matlab
cat_weights = [4.2, 3.8, 5.1, 3.5, 4.7];
```

### Single Elements

```matlab
cat_weights(1)       % 4.2  -- the first cat
cat_weights(3)       % 5.1  -- the third cat (probably Enzo)
cat_weights(end)     % 4.7  -- the last cat
```

The `end` keyword always means "the last one" -- useful when you do not know how long your vector is.

### Slicing -- Grabbing a Range

```matlab
cat_weights(1:3)       % [4.2, 3.8, 5.1]  -- first three cats
cat_weights(end-2:end) % [5.1, 3.5, 4.7]  -- last three cats
cat_weights(2:4)       % [3.8, 5.1, 3.5]  -- cats 2 through 4
```

### Matrix Indexing

For matrices (tables of numbers), you need two indices: row and column.

```matlab
M = [10 20 30;
     40 50 60;
     70 80 90];

M(2, 3)     % 60  -- row 2, column 3
M(2, :)     % [40 50 60]  -- entire row 2
M(:, 1)     % [10; 40; 70]  -- entire column 1
```

The colon `:` by itself means "all." So `M(2, :)` reads as "row 2, all columns."

---

## Matrices -- Tables of Numbers

A matrix is like a spreadsheet -- rows and columns of numbers.

Imagine measuring the length, width, and height of three garden plots:

```matlab
garden = [2.5, 1.2, 0.3;
          3.0, 1.5, 0.4;
          1.8, 2.0, 0.3];
```

Row 1 is the first garden plot. Column 1 is all the lengths.

### Quick Ways to Create Matrices

```matlab
Z = zeros(3, 3);    % 3x3 matrix of zeros
O = ones(2, 4);     % 2x4 matrix of ones
R = rand(3, 3);     % 3x3 matrix of random numbers (0 to 1)
```

Check the size:

```matlab
size(garden)    % returns [3, 3]  -- 3 rows, 3 columns
```

---

## Element-wise Operations

Here is an important Matlab rule: **a dot before an operator means "do it to each element separately."**

| Operator | Meaning | Example |
|----------|---------|---------|
| `.*` | multiply each element | `v1 .* v2` |
| `./` | divide each element | `v1 ./ v2` |
| `.^` | raise each element to a power | `v .^ 2` |

### Example

```matlab
cat_weights = [4.2, 3.8, 5.1, 3.5, 4.7];

% Convert kg to pounds (1 kg = 2.205 lbs)
cat_weights_lbs = cat_weights .* 2.205;

% Square each weight (just to practice)
weights_squared = cat_weights .^ 2;
```

### Why the dot matters

Without the dot, `*` means matrix multiplication -- a different operation entirely. If your vectors are not the right shape for matrix multiplication, you get an error:

```matlab
v = [1 2 3];
v * v        % ERROR! Cannot multiply 1x3 by 1x3
v .* v       % [1, 4, 9]  -- element-wise, works fine
```

When in doubt, use the dot.

---

## Making Plots

Matlab is fantastic at making plots. Here are the four types you will use most.

### Line Plot

```matlab
x = linspace(0, 2*pi, 100);
y = sin(x);
plot(x, y);
```

### Scatter Plot

```matlab
x = rand(1, 20);
y = rand(1, 20);
scatter(x, y, 50, 'filled');
```

### Bar Chart

```matlab
family_ages = [42, 40, 11, 8];
bar(family_ages);
```

### Heatmap

```matlab
data = rand(5, 5);
imagesc(data);
colorbar;
```

### Making Plots Pretty

Every plot should have labels and a title:

```matlab
xlabel('Time (seconds)');
ylabel('Voltage (mV)');
title('My Beautiful Plot');
legend('data1', 'data2');
grid on;
```

### Multiple Plots in One Figure

Use `subplot(rows, cols, position)` to arrange plots in a grid:

```matlab
subplot(2, 2, 1);   % top-left of a 2x2 grid
plot(x, y);
title('Plot 1');

subplot(2, 2, 2);   % top-right
bar([1 2 3]);
title('Plot 2');
```

### Overlaying Plots

By default, each `plot()` call replaces the previous one. Use `hold on` to overlay:

```matlab
plot(x, sin(x), 'b-');
hold on;
plot(x, cos(x), 'r--');
hold off;
legend('sin', 'cos');
```

See `demo_plotting.m` for all of these in action.

---

## Vectors as Arrows -- Your First Math Concept

This is the most important section in this module. We are going to learn a real math concept, but we are going to do it the right way: pictures first, code second, notation last.

### The Picture

Imagine standing at the origin of a map. A vector tells you where to walk: 3 steps east and 4 steps north. That journey -- the direction you walked and how far you went -- is the vector.

The arrow on the map pointing from where you started to where you ended up: that is what mathematicians mean by "a vector."

### The Code

In Matlab, you write that journey as:

```matlab
v = [3, 4];
```

And you draw it as an arrow using `quiver()`:

```matlab
quiver(0, 0, 3, 4, 0);
axis equal;
grid on;
```

Run `demo_vector_arrows.m` to see this.

### Direction

The arrow points northeast -- that is the **direction** of the vector. Different vectors point in different directions. The vector `[-2, 1]` points northwest.

### Magnitude

The arrow is 5 steps long -- that is the **magnitude** (length) of the vector. In Matlab:

```matlab
norm(v)    % returns 5
```

Why 5? Because of Pythagoras! The vector is the hypotenuse of a right triangle with sides 3 and 4:

```
sqrt(3^2 + 4^2) = sqrt(9 + 16) = sqrt(25) = 5
```

### The Notation

Now -- and only now -- let us see how mathematicians write this:

- The length of vector **v** is written as **||v||**
- **||v|| = sqrt(3^2 + 4^2) = 5**

You already knew this! It is Pythagoras. The vector is the hypotenuse. The mathematical notation `||v||` is just a fancy way of writing `norm(v)` in Matlab.

### Adding Vectors

If you walk 3 east and 4 north, then 2 west and 1 north, where do you end up? Just add the components:

```matlab
v1 = [3, 4];
v2 = [-2, 1];
v_sum = v1 + v2;    % [1, 5]  -- 1 step east, 5 steps north
```

Run `demo_vector_arrows.m` to see this drawn as arrows, head to tail.

---

## Checkpoint

You have covered a lot of ground. Before moving on:

1. Run `demo_vectors.m` -- you should see bar charts of cat weights in kg and pounds.
2. Run `demo_plotting.m` -- you should see line plots, scatter plots, bar charts, and heatmaps.
3. Run `demo_vector_arrows.m` -- you should see arrows on a grid.

If all three produce plots without errors, you are ready for the exercises.

Try `exercise_vectors.m` and `exercise_plotting.m` -- they are mostly pre-written, you just need to fill in the blanks marked with `% TODO`.

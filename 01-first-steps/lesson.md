# Module 01: First Steps

Welcome! By the end of this lesson you will have written and run your first Matlab script, created variables to store data, done some math, and — best of all — made a plot. Let's get started.

## The Matlab Desktop

When you open Matlab, you'll see several panels. Here are the ones that matter right now:

**Command Window** — The big panel in the center. This is where you type commands and see output. Think of it as a conversation with Matlab: you type something, it replies.

**Editor** — This is where you write scripts (files ending in `.m`). You open it by clicking "New Script" or by opening an existing `.m` file. This is where you'll spend most of your time.

**Workspace** — The panel on the right that shows all the variables you've created. Every time you create a variable, it appears here with its name, value, and size. It's like a table where Matlab keeps track of everything you've told it to remember.

**Current Folder** — The panel on the left that shows files in your working directory. This is important — Matlab can only run scripts that are in this folder (or on its search path).

Go ahead and open Matlab now. Can you find all four panels? If the Workspace or Current Folder panels are hidden, go to the "Home" tab and click "Layout" to restore the default layout.

## Your First Script

Instead of typing commands one by one in the Command Window, we'll write a script — a file that contains multiple commands that Matlab runs in order.

1. Click "New Script" in the Home tab (or press Ctrl+N)
2. A blank file opens in the Editor
3. Type the code from `demo_hello.m` (or open that file directly)
4. Save the file (Ctrl+S) — make sure it's saved in the same folder shown in your Current Folder panel
5. Press F5 (or click the green "Run" button)

You should see a plot appear. That's it — you just ran your first Matlab script!

Open `demo_hello.m` now and run it. You should see a red curve that goes upward. That curve is x-squared — but don't worry about the math yet. The point is: you wrote code, you ran it, and something visual happened. That's the pattern for everything we'll do.

## Variables — Giving Names to Things

A variable is just a name you give to a piece of data so you can use it later. It's like putting a label on a jar: the jar holds something, and the label tells you what's inside.

### Numbers

Let's store some information about your life:

```matlab
enzo_weight = 5.2;     % Enzo weighs 5.2 kg
ravn_age = 11;         % Ravn is 11 years old
helena_age = 8;        % Helena is 8 years old
```

The semicolon at the end tells Matlab "store this, but don't print it." If you leave it off, Matlab will print the value — handy for checking, but noisy when you have lots of variables.

After running these three lines, check your Workspace panel. You should see three variables listed there with their values.

### Text (Strings)

You can store text too:

```matlab
cat_name = 'Enzo';
favorite_plant = 'tomato';
```

In Matlab, text goes inside single quotes. These are called "character arrays" — but you can just think of them as text.

### True/False (Booleans)

Sometimes you need a simple yes or no:

```matlab
is_cat = true;
likes_rain = false;
```

### Seeing What You Have

Two ways to see what's stored in a variable:

```matlab
disp(enzo_weight);          % Prints: 5.2000
fprintf('Enzo weighs %.1f kg\n', enzo_weight);  % Prints: Enzo weighs 5.2 kg
```

`disp()` just dumps the value. `fprintf()` lets you build a sentence around it — the `%.1f` is a placeholder that gets replaced by the number (with 1 decimal place), and `\n` means "new line."

Run `demo_variables.m` now to see all of this in action.

## Basic Math

Matlab is a calculator. You can use it for arithmetic with the same symbols you'd expect:

| Operation      | Symbol | Example                          |
|----------------|--------|----------------------------------|
| Addition       | `+`    | `ravn_age + helena_age` gives 19 |
| Subtraction    | `-`    | `ravn_age - helena_age` gives 3  |
| Multiplication | `*`    | `enzo_weight * 2.205` (kg to pounds) |
| Division       | `/`    | `19 / 2` gives 9.5              |
| Power          | `^`    | `3^2` gives 9                   |

You can store the result of a calculation in a new variable:

```matlab
age_diff = ravn_age - helena_age;
total_family_age = ravn_age + helena_age;
enzo_weight_pounds = enzo_weight * 2.205;
```

This is exactly what a calculator does, except you get to give names to all the numbers. And since the names are descriptive, you can read your code like a sentence: "age_diff equals ravn_age minus helena_age."

## Your First Collection: Vectors

So far, every variable has held a single value. But what if you want to store a whole list of numbers? That's a vector.

Imagine you're at the vet and you weigh five cats:

```matlab
cat_weights = [4.2, 3.8, 5.1, 3.5, 4.7];
```

The square brackets `[]` create a vector. The commas separate the values. Now `cat_weights` is a single variable that holds five numbers.

You can ask how many items are in a vector:

```matlab
length(cat_weights)    % gives 5
```

And you can grab a single value by its position:

```matlab
cat_weights(1)    % gives 4.2 (the first cat)
cat_weights(3)    % gives 5.1 (the third cat)
```

Note: Matlab counts from 1, not from 0. The first element is always at position 1.

This is just a preview — Module 02 goes much deeper into vectors, matrices, and all the ways you can slice and dice collections of numbers.

## Checkpoint

Time to check that everything works:

1. Run `demo_hello.m` — you should see a plot (a curve going upward)
2. Run `demo_variables.m` — you should see printed text and a bar chart
3. Try `exercise_variables.m` — fill in the TODOs and run it to check your work

If all three scripts run without errors and produce output, you're done with Module 01!

## Troubleshooting

**"Undefined function or variable" error:**
This usually means Matlab can't find your script. Check the Current Folder panel — does it show the folder where your `.m` files are saved? If not, navigate to the right folder by clicking on it or typing `cd '/path/to/your/folder'` in the Command Window.

**"Variable not defined" in the middle of a script:**
This means you're using a variable that hasn't been created yet. Make sure you've run the earlier lines of the script first. In Matlab, pressing F5 runs the entire script from top to bottom, so all lines should run in order. If you're running lines one at a time, make sure you didn't skip any.

**Nothing happens when you press F5:**
Make sure the file is saved (Ctrl+S) and that you're in the Editor (click on the script tab). Also check the Command Window for any messages — sometimes Matlab prints an error there instead of showing a pop-up.

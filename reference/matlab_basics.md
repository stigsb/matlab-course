# Matlab Quick Reference

## Variables

```matlab
x = 5;              % number (scalar)
name = 'Enzo';      % text (character array)
flag = true;        % boolean (true/false)
```

Semicolon `;` suppresses output. Without it, Matlab prints the value.

## Vectors and Matrices

```matlab
v = [1 2 3];              % row vector (spaces or commas)
v = [1, 2, 3];            % same thing
v = [1; 2; 3];            % column vector (semicolons)
v = 1:10;                 % [1 2 3 4 5 6 7 8 9 10]
v = 0:0.5:3;              % [0 0.5 1 1.5 2 2.5 3]
v = linspace(0, 10, 50);  % 50 evenly spaced points from 0 to 10

M = [1 2 3; 4 5 6];       % 2x3 matrix
Z = zeros(3, 3);           % 3x3 matrix of zeros
O = ones(2, 4);            % 2x4 matrix of ones
R = rand(3, 3);            % 3x3 matrix of random numbers (0 to 1)
```

## Indexing

```matlab
v(1)          % first element (Matlab counts from 1!)
v(end)        % last element
v(2:5)        % elements 2 through 5
v(1:3)        % first three elements

M(2, 3)       % row 2, column 3
M(1, :)       % entire row 1
M(:, 2)       % entire column 2
M(end, :)     % last row
```

**Common mistake:** `v(0)` gives an error. Matlab starts at 1, not 0.

## Arithmetic

| Operation            | Symbol | Example            |
|----------------------|--------|--------------------|
| Addition             | `+`    | `3 + 4`            |
| Subtraction          | `-`    | `10 - 3`           |
| Multiplication       | `*`    | `5 * 2`            |
| Division             | `/`    | `10 / 3`           |
| Power                | `^`    | `2^3` (gives 8)    |
| Element-wise multiply| `.*`   | `[1 2 3] .* [4 5 6]` gives `[4 10 18]` |
| Element-wise divide  | `./`   | `[10 20] ./ [2 5]` gives `[5 4]`       |
| Element-wise power   | `.^`   | `[2 3].^2` gives `[4 9]`               |

**Rule:** A dot `.` before `*`, `/`, or `^` means "do it to each element separately."

## Plotting

```matlab
plot(x, y)                        % line plot
plot(x, y, 'ro-', 'LineWidth', 2) % red circles, solid line, thick
scatter(x, y, 50, 'filled')       % scatter plot
bar(values)                       % bar chart
imagesc(M); colorbar              % matrix as heatmap

xlabel('X axis label')
ylabel('Y axis label')
title('My Plot Title')
legend('data1', 'data2')
grid on
```

### Multiple Plots

```matlab
hold on     % keep current plot, add to it
plot(...)   % this goes on top of the previous plot
hold off    % stop adding (next plot will replace)

figure      % open a new figure window
subplot(2, 1, 1)  % 2 rows, 1 column, select plot 1
subplot(2, 1, 2)  % select plot 2
```

### Format Strings for plot()

| Code | Meaning     |
|------|-------------|
| `b`  | blue        |
| `r`  | red         |
| `g`  | green       |
| `k`  | black       |
| `-`  | solid line  |
| `--` | dashed line |
| `o`  | circles     |
| `*`  | stars       |
| `s`  | squares     |

Combine them: `'r--o'` = red dashed line with circles.

## Script Essentials

```matlab
clear          % remove all variables from workspace
clc            % clear the Command Window
close all      % close all figure windows

disp('Hello')                       % print text
disp(42)                            % print a number
fprintf('Name: %s, Age: %d\n', name, age)  % formatted print
```

### fprintf Format Codes

| Code  | Meaning                    |
|-------|----------------------------|
| `%d`  | integer                    |
| `%f`  | decimal number             |
| `%.2f`| decimal with 2 places      |
| `%s`  | text string                |
| `\n`  | new line                   |

### Comments and Sections

```matlab
% This is a comment (Matlab ignores it)

%% This is a section break
% Creates a runnable section in the Editor.
% You can run sections individually with Ctrl+Enter.
```

## Common Errors

**"Undefined function or variable 'x'"**
Matlab can't find `x`. Either you didn't create it yet, or your script is in a different folder than Matlab's Current Folder.

**"Index must be a positive integer or logical"**
You tried `v(0)` or a negative index. Remember: Matlab starts at 1.

**Second plot replaces the first**
You forgot `hold on`. Without it, each `plot()` call clears the previous one.

## Inspection

```matlab
size(M)      % [rows, cols] of a matrix
length(v)    % number of elements in a vector
whos         % list all variables with sizes and types
class(x)     % data type of x ('double', 'char', 'logical')
```

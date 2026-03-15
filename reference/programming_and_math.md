# Programming and Math Quick Reference

Covers Modules 03 (Programming Tools) and 04 (Math Foundations).

## Functions

```matlab
% Local function (at bottom of script file)
function y = square(x)
    y = x^2;
end

% Function file (save as average_value.m)
function avg = average_value(data)
    avg = mean(data);
end

% Multiple outputs
function [m, s] = describe(data)
    m = mean(data);
    s = std(data);
end

% Calling: [mu, sigma] = describe(my_data);
```

**Rules:**
- Filename MUST match function name (`square.m` contains `function y = square(x)`)
- Output variable MUST be assigned before function ends
- Local functions go at the **bottom** of the script file

## Loops

```matlab
% For loop (known number of iterations)
for i = 1:10
    fprintf('%d ', i);
end

% Loop over vector elements
for val = [3, 7, 11, 15]
    fprintf('Value: %d\n', val);
end

% While loop (unknown number of iterations)
x = 100;
while x > 1
    x = x / 2;
end

% Loop-and-accumulate pattern
result = [];
for i = 1:length(data)
    if data(i) > threshold
        result = [result, data(i)];
    end
end
```

| Keyword | Purpose |
|---------|---------|
| `break` | Exit the loop immediately |
| `continue` | Skip to the next iteration |

## Conditionals

```matlab
if x > 10
    disp('big');
elseif x > 0
    disp('small');
else
    disp('zero or negative');
end
```

### Comparison Operators

| Operator | Meaning |
|----------|---------|
| `==` | Equal to |
| `~=` | Not equal to |
| `<` | Less than |
| `>` | Greater than |
| `<=` | Less than or equal |
| `>=` | Greater than or equal |

### Logical Operators

| Operator | Meaning |
|----------|---------|
| `&&` | AND (scalars) |
| `\|\|` | OR (scalars) |
| `~` | NOT |
| `&` | AND (arrays, element-wise) |
| `\|` | OR (arrays, element-wise) |

## Matrix Operations

```matlab
C = A * B;        % matrix multiplication (rows x columns)
d = dot(a, b);    % dot product of two vectors
B = A';           % transpose (swap rows and columns)
I = eye(n);       % n x n identity matrix
d = det(A);       % determinant
Ainv = inv(A);    % matrix inverse (use A\b instead when solving equations)
x = A \ b;       % solve Ax = b (preferred over inv(A)*b)
```

| Operation | Code | Requirements |
|-----------|------|-------------|
| Matrix multiply | `A * B` | A columns == B rows |
| Element-wise multiply | `A .* B` | Same size |
| Dot product | `dot(a, b)` | Same length vectors |
| Transpose | `A'` | Any matrix |

## Statistics

```matlab
m   = mean(x);        % arithmetic mean
s   = std(x);         % standard deviation (sample, N-1)
v   = var(x);         % variance (= std^2)
med = median(x);      % median

% Correlation (returns a MATRIX!)
R = corrcoef(x, y);   % 2x2 correlation matrix
r = R(1,2);            % extract the correlation value

% Covariance
C = cov(x, y);         % 2x2 covariance matrix
```

### Random Numbers

```matlab
randn(m, n)    % m x n matrix, normal distribution (mean=0, std=1)
rand(m, n)     % m x n matrix, uniform distribution (0 to 1)
rng(42)        % set random seed for reproducibility
```

### Plotting Statistics

```matlab
histogram(data, nbins)              % histogram
xline(value, 'r-', 'LineWidth', 2)  % vertical reference line
yline(value, 'r-', 'LineWidth', 2)  % horizontal reference line
scatter(x, y, 50, 'filled')         % scatter plot for correlation
```

## Eigenvalues

```matlab
lambda = eig(A);       % eigenvalues only (column vector)
[V, D] = eig(A);       % V = eigenvectors (columns), D = eigenvalues (diagonal)

% Extract individual results
ev1 = V(:,1);          % first eigenvector
lam1 = D(1,1);         % first eigenvalue

% The eigenvalue equation: A * v = lambda * v
% Verify: A * ev1 should equal lam1 * ev1
```

**Key facts:**
- `V` columns are eigenvectors (unit length, direction may be flipped)
- `D` is diagonal: eigenvalues on the diagonal
- For 2x2 matrix: 2 eigenvectors, 2 eigenvalues
- Eigenvectors = directions that only get stretched, not rotated

## Common Gotchas

| Mistake | Fix |
|---------|-----|
| `if x = 5` (assignment) | `if x == 5` (comparison) |
| `A * B` when you want element-wise | `A .* B` |
| `A .* B` when you want matrix multiply | `A * B` |
| `corrcoef(x,y)` returns matrix | `R = corrcoef(x,y); r = R(1,2);` |
| Filename doesn't match function name | `square.m` must contain `function y = square(x)` |
| Function doesn't return output | Assign to the output variable: `y = x^2;` |
| Eigenvector sign differs from textbook | Direction matters, not sign. `[1;0]` and `[-1;0]` are the same eigenvector. |
| Growing array in loop is slow | For small data: fine. For large data: pre-allocate with `zeros()`. |

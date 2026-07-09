function [x, iter] = solveNonLinEqDS(f, x0, x1, tol, maxIter)
if nargin < 5
    maxIter = 100;
end
if nargin < 4
    tol = 1e-6;
end
x = x1;
x_prev = x0;
for iter = 1:maxIter
    fx = f(x);
    fx_prev = f(x_prev);
    if abs(fx) < tol
        return;
    end
    dfx = (fx - fx_prev) / (x - x_prev);
    if dfx == 0
        error('Approximate derivative is zero. No solution found.');
    end
    if abs(fx / dfx) < tol
        return;
    end
    x_new = x - fx / dfx;
    x_prev = x;
    x = x_new;
end
warning('Maximum iterations reached. Solution may not be accurate.');
end
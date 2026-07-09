function [x, iter] = solveNonLinEqNewton(f, df, x0, tol, maxIter)
if nargin < 5
    maxIter = 100;
end
if nargin < 4
    tol = 1e-6;
end

x = x0;
for iter = 1:maxIter
    fx = f(x);
    if abs(fx) < tol
        return;
    end
    dfx = df(x);
    if dfx == 0
        error('Derivative is zero. No solution found.');
    end
    if abs(fx / dfx) < tol
        return;
    end
    x = x - fx / dfx;
end
warning('Maximum iterations reached. Solution may not be accurate.');
end
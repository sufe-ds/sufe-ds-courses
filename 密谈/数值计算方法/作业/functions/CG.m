function [x, iter] = CG(A, b, x0, tol, maxIter)
if nargin < 5
    maxIter = 1000;
elseif nargin < 4
    tol = 1e-6;
elseif nargin < 3
    x0 = zeros(size(b));
end

x = x0;
r = b - A * x;
rho = r' * r;
iter = 1;

while iter <= maxIter && sqrt(rho) > tol
    if iter == 1
        p = r;
    else
        beta = rho / prev_rho;
        p = r + beta * p;
    end
    
    w = A * p;
    alpha = rho / (p' * w);
    x = x + alpha * p;
    r = r - alpha * w;
    
    prev_rho = rho;
    rho = r' * r;
    
    iter = iter + 1;
end

end
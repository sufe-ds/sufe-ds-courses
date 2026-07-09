function [x, iter] = AORIter(A, b, omega, r, x0, tol, maxIter)

if nargin < 7
    maxIter = 1000;
end
if nargin < 6
    tol = 1e-6;
end
if nargin < 5
    x0 = zeros(size(b));
end

D  = diag(diag(A));
L = D - tril(A);
U = D - triu(A);

x = x0;

for iter=1:maxIter
    L_omega_r = (D - r * L) \ ((1 - omega) * D + (omega - r) * L + omega * U);
    g_omega_r = omega * ((D - r * L) \ b);
    x = L_omega_r * x + g_omega_r;
    if norm(A*x - b, inf) < tol
        return;
    end
end

x = x0;
end
function [L, U, P] = myLU(A)
n = size(A, 1);
perm = 1:n;
for k=1:n-1
    [~, p] = max(abs(A(k:n, k)));
    p = p + k - 1;
    if p ~= k
        A([k, p], 1:n) = A([p, k], 1:n);
        perm([k, p]) = perm([p, k]);
    end

    if A(k, k) == 0
        error('Matrix is singular');
    end

    A(k+1:n, k) = A(k+1:n, k) / A(k, k);
    A(k+1:n, k+1:n) = A(k+1:n, k+1:n) - A(k+1:n, k) * A(k, k+1:n);
end
L = tril(A, -1) + eye(n);
U = triu(A);
P = eye(n);
P = P(perm, :);
end
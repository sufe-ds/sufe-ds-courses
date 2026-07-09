function [L, D, P] = myLDL(A)
n = size(A, 1);
perm = 1:n;

for k = 1:n-1
    [~, p] = max(abs(diag(A(k:n, k:n))));
    p = p + k - 1;
    if p ~= k
        A([k, p], :) = A([p, k], :);
        A(:, [k, p]) = A(:, [p, k]);
        perm([k, p]) = perm([p, k]);
    end

    if A(k, k) == 0
        error('Matrix is singular');
    end

    A(k+1:n, k) = A(k+1:n, k) / A(k, k);
    A(k+1:n, k+1:n) = A(k+1:n, k+1:n) - A(k+1:n, k) * A(k, k) * A(k+1:n, k)';
end

L = tril(A, -1) + eye(n);
D = diag(diag(A));
P = eye(n);
P = P(perm, :);
end


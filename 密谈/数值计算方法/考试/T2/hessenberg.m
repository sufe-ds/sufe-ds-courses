function A = hessenberg(A)
n = size(A, 1);
for iter = 1:(n - 2)
    x = A((iter+1):n, iter);

    [v, beta] = householder(x);
    H = eye(length(v)) - beta * (v * v');

    A((iter+1):n, iter:n) = H * A((iter+1):n, iter:n);
    A(1:n, (iter+1):n) = A(1:n, (iter+1):n) * H;
end
end

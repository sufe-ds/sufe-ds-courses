
function [Q, R] = HessenQR(A)
n = size(A, 1);
Q = eye(n);
for i = 1:n-1
    xi = A(i, i);
    xk = A(i+1, i);
    if xk ~= 0
        [c, s] = givens(xi, xk);
        G = [c, s; -s, c];
        A(i:i+1, 1:n) = G * A(i:i+1, 1:n);
        Q(1:n, i:i+1) = Q(1:n, i:i+1) * G';
    end
end
R = A;
end

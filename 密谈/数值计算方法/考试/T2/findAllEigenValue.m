
function [D, iter] = findAllEigenValue(A, tol, maxIter)
if nargin < 3
    maxIter = 5000;
end
if nargin < 2
    tol = 1e-8;
end

n = size(A, 1);
D = ones(n, 1);
iter = 0;

m = n;
A = hessenberg(A);

while iter < maxIter
    iter = iter + 1;

    l = 1;
    for k = m:-1:2
        if abs(A(k, k-1)) < tol
            if m - k + 1 <= 2
                D(k:m) = calcFewEigenValue(A(k:m, k:m));
                m = k - 1;
            else
                l = k;
                break;
            end
        end
    end

    if m <= 2
        D(1:m) = calcFewEigenValue(A(1:m, 1:m));
        break;
    end
    A(l:m, l:m) = shiftHessenQR(A(l:m, l:m));
end
end


function A = shiftHessenQR(A)
n = size(A, 1);
Q = eye(n);
mu = A(n, n);
A = A - mu * eye(n);
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
A(1:n, 1:n) = A(1:n, 1:n) * Q;
A = A + mu * eye(n);
end

function D = calcFewEigenValue(A)
n = size(A, 1);
if n == 1
    D = A(1,1);
elseif n == 2
    b = A(1, 1) + A(2, 2);
    c = A(1, 1) * A(2, 2) - A(1, 2) * A(2, 1);

    delta = b^2 - 4*c;
    x1 = (b + sqrt(delta)) / 2;
    x2 = (b - sqrt(delta)) / 2;

    D = [x1; x2];
else
    error('Matrix size must be 1x1 or 2x2.');
end
end
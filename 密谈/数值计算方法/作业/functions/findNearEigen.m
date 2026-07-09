function [lambda, v, iter] = findNearEigen(A, mu, x, tol, maxIter)
% 使用带原点位移的反幂迭代法计算矩阵 A 中最接近给定值 mu 的特征值及其对应的特征向量。
n = size(A,1);
if nargin < 5
    maxIter = 1000;
end
if nargin < 4
    tol = 1e-10;
end
if nargin < 3
    x = rand(n,1);
end

iter = 0;
[L, U, P] = lu(A - mu*eye(n));
x_max = max(abs(x));

while iter < maxIter
    x = x / x_max;
    x = U\(L\(P * x));
    new_x_max = max(abs(x));
    if abs(new_x_max - x_max) < tol
        break;
    end
    x_max = new_x_max;
    iter = iter + 1;
end

lambda = 1 / x_max + mu;
v = x / norm(x);
end

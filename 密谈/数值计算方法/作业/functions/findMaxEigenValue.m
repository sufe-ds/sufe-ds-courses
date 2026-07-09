function [maxEigenvalue, iter] = findMaxEigenValue(A, x, tol, maxIter)
% 使用幂法计算矩阵 A 的最大特征值。
if nargin < 4
    maxIter = 10000;
end
if nargin < 3
    tol = 1e-10; 
end
if nargin < 2
    x = rand(size(A,1),1); 
end

iter = 0;
while iter < maxIter
    m = max(abs(x));
    x = x / m;
    x = A * x;
    if abs(max(abs(x)) - m) < tol
        break;
    end
    iter = iter + 1;
end
maxEigenvalue = max(abs(x));
end
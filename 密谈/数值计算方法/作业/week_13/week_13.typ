#import "../homework.typ": config

#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *

#show: config.with("数值计算方法", "第十三周作业", "", "匿名", "20XXXXXXXX")

#show: codly-init.with()

= 上机题 1

#image("./img/image-1.png")

```matlab
function [lambda, v, iter] = findNearEigen(A, mu, x, tol, maxIter)
% findNearEigen finds the eigenvalue of matrix A nearest to mu using the
% inverse power method with shift.
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
```

= 上机题 2

#image("./img/image-2.png")



```matlab
function [D, iter] = findAllEigenValue(A, tol, maxIter)
% 使用 QR 算法计算矩阵 A 的所有特征值

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
    A(l:m, l:m) = hessenQR(A(l:m, l:m));
end
end

function A = hessenQR(A)
% 对 Hessenberg 矩阵 A 执行一次 QR 分解并重组 (A = R * Q)
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
A(1:n, 1:n) = A(1:n, 1:n) * Q;
end

function D = calcFewEigenValue(A)
% 计算 1x1 或 2x2 矩阵 A 的特征值

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
```
= 运行脚本

```matlab
clear; clc; close all;
addpath('./functions');

M = [3 2 3 4 5 6 7; 11 1 2 3 4 5 6; 2 8 9 1 2 3 4; -4 2 9 11 13 5 8; -1 -2 -3 -1 -1 -1 -1; 3 2 3 4 13 15 8; -2 -2 -3 -4 -5 -3 -3];

mu = 11;
[lambda, v, iter] = findNearEigen(M, mu);
fprintf('Computed Eigenvalue (%d iterations): %.8f\n', iter, lambda);
fprintf('Error of computed eigenpair: %.8e\n', norm(M*v - lambda*v));

eigenvalues = eig(M);
[~, idx] = min(abs(eigenvalues - mu));
fprintf('Nearest Eigenvalue from eig(): %.8f\n', eigenvalues(idx));

fprintf("-------------------------------\n");

[D, iter] = findAllEigenValue(M);
fprintf('Computed Eigenvalues (%d iterations):\n', iter);
disp(D);

eigenvalues = eig(M);
fprintf('Eigenvalues from eig():\n');
disp(eigenvalues);
```

== 输出

```
Computed Eigenvalue (9 iterations): 11.17731204
Error of computed eigenpair: 9.42513040e-13
Nearest Eigenvalue from eig(): 11.17731204
-------------------------------
Computed Eigenvalues (55 iterations):
  15.7401 + 0.0000i
  11.1773 + 0.0000i
   2.8030 + 3.6311i
   2.8030 - 3.6311i
   3.2020 + 0.0000i
  -2.1598 + 0.0000i
   1.4344 + 0.0000i

Eigenvalues from eig():
  15.7401 + 0.0000i
  11.1773 + 0.0000i
  -2.1598 + 0.0000i
   2.8030 + 3.6311i
   2.8030 - 3.6311i
   3.2020 + 0.0000i
   1.4344 + 0.0000i
```

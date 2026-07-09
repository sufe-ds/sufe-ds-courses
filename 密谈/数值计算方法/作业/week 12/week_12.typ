#import "../homework.typ": config

#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *

#show: config.with("数值计算方法", "第十二周作业", "", "匿名", "20XXXXXXXX")

#show: codly-init.with()

= 教材第六章习题第 8 题

#align(center, image("/assets/image-12.png"))

首先计算矩阵 $A$ 的特征值：

$
  det(A - lambda I) = (1 - lambda)^3 => lambda_1 = lambda_2 = lambda_3 = 1\
  (A - I) v = 0 => v_1 = v_2 = v_3 = mat(1; 0; 0)
$

注意到不满足 $abs(lambda_1) > abs(lambda_2)$，即矩阵 $A$ 没有完全特征向量系，所以需要特别分析。

注意到 $A = I + N$，其中 $ N = mat(0, 1, 0; 0, 0, 1; 0, 0, 0) $ 为幂零矩阵。

所以：

$
  A^k = (I + N)^k = mat(1, k, k(k-1)/2; 0, 1, k; 0, 0, 1) \
  x^((k)) = A^k u_0 = mat(k(k-1)/2; k; 1)
$

规范化后得到：

$
  y^((k)) = x^((k)) / norm(x^((k)))_oo = mat(1; 2 / (k-1); 2 / k(k - 1))\
  lim_(k->oo) y^((k)) = mat(1; 0; 0)
$

精确到 5 位数字即 $ max{abs(1 - 1), abs(2 / (k - 1) - 0), abs(2 / k(k - 1))} < 10^(-5) / 2 => 2 / (k - 1) < 5 times 10^(-6) => k - 1 > 4 times 10^5 $

综上，需要 $4 times 10^5 + 2$ 次迭代。

= 教材第六章上机习题第 1 题

#align(center, image("/assets/image-13.png"))
#align(center, image("/assets/image-14.png"))

不难发现

$
  det mat(x, 0, dots.c, 0, a_0; 1, x, dots.c, 0, a_1; , 1, dots.down, dots.v, a_2; , , dots.down, x, dots.v; , , , 1, x + a_(n - 1)) = x^n + a_(n - 1) x^(n - 1) + dots.c + a_1 x + a_0
$

所以：

== `solve.m`

```matlab
clear; clc; close all;

a1 = [3, -5, 1];
a2 = [-1, -3, 0];
a3 = [-1000, 790, -99902, 79108.9, 9802.08, 10891.01, 208.01, 101];

[maxRoot1, iter1] = findMaxEigenvalue(makeMatrix(a1));
[maxRoot2, iter2] = findMaxEigenvalue(makeMatrix(a2));
[maxRoot3, iter3] = findMaxEigenvalue(makeMatrix(a3));

fprintf('Max Root for poly 1: %.8f in %d iterations\n', maxRoot1, iter1);
fprintf('Max Root for poly 2: %.8f in %d iterations\n', maxRoot2, iter2);
fprintf('Max Root for poly 3: %.8f in %d iterations\n', maxRoot3, iter3);
```

== `findMaxEigenValue.m`

```matlab
function [maxEigenvalue, iter] = findMaxEigenvalue(A, x, tol, maxIter)
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
```
== `makeMatrix.m`

```matlab
function [A] = makeMatrix(a)
n = length(a);
A = zeros(n, n);
A(:, end) = -a;
A(2:end, 1:end-1) = eye(n-1);
end
```

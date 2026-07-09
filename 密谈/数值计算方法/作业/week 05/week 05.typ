#import "../homework.typ": config

#show: config.with("数值计算方法", "第五周作业", "", "匿名", "20XXXXXXXX")

= 证明教材定理2.1.5

== 1

根据向量内积的定义，不难得到，当两向量平行时，其内积的绝对值最大。

在这里，取 $y = (A x) / norm(A x)_2$。

$
  max {abs(y^T A x): x, y in C^n, norm(x)_2 = norm(y)_2 = 1}
    &= max {abs((A x)/norm(A x)_2 A x): x in C^n, norm(x)_2 = 1}\
    &= max_(norm(x)_2 = 1) norm(A x)_2\
    &= norm(A)_2
$

证毕。

== 2

矩阵的转置不改变其特征值，所以

$
  norm(A^T)_2 &= sqrt(lambda_max (A A^T))\
              &= sqrt(lambda_max [(A^T A)^T])\
              &= sqrt(lambda_max (A^T A))\
              &= norm(A)_2
$

根据定理 2.1.5.1，有

$
  norm(A^T A) &= max {abs(y^T A^T A x): x, y in C^n, norm(x)_2 = norm(y)_2 = 1}\
              &= max {abs((A y)^T A x): x, y in C^n, norm(x)_2 = norm(y)_2 = 1}
$

这里取 $y = 1$。

$
       &norm(A^T A) = max_(norm(x)=1) norm(A x)_2^2 = norm(A)_2^2\
  => &norm(A)_2 = sqrt(norm(A^T A)_2)
$

证毕

== 3

我们知道，左乘一个正交矩阵意味着“旋转”，即对于任意 $n$ 阶正交矩阵 $U$，有 $norm(U x)_2 = norm(x)_2$，其中 $x in R^n$。

所以

$
  norm(U A)_2 &= max_(norm(x)_2 = 1) norm(U A x)_2\
              &= max_(norm(x)_2 = 1) norm(A x)_2 = norm(A)_2
$

根据定理 2.1.5.2，正交矩阵的转置依旧是正交矩阵

$
  norm(A V)_2 &= norm((A V)^T)_2\
              &= norm(V^T A^T)_2\
              &= norm(A^T) = norm(A)_2
$

证毕。

= 教材第二章课后习题

== 1

=== 正定性

因为 $alpha_i > 0$，函数 $nu$ 的正定性易证。

=== 齐次性

$
  nu(a x) &= (sum_(i = 1)^n alpha_i (a x_i)^2)^(1/2)\
          &= (a^2 sum_(i = 1)^n alpha_i x_i^2)^(1/2)\
          &= abs(a) (sum_(i = 1)^n alpha_i x_i^2)^(1/2) = abs(a) nu(x)
$

齐次性得证。

=== 三角不等式

首先需要证明 $forall a, b >= 0, sqrt(a + b) <= sqrt(a) + sqrt(b)$

不等式两边平方，可得 $sqrt(a + b) <= sqrt(a) + sqrt(b) <=> a + b <= a + b + 2 sqrt(a b) <=> 0 <= 2 sqrt(a + b)$，得证。


$
  nu(x + y) &= (sum_(i = 1)^n alpha_i (x_i + y_i)^2)^(1/2) = (sum_(i = 1)^n alpha_i (x_i^2 + y_i^2 + 2 x_i y_i))^(1/2)\
            &<= (sum_(i = 1)^n alpha_i (x_i^2 + y_i^2))^(1/2)= (sum_(i = 1)^n alpha_i x_i^2 + sum_(i = 1)^n alpha_i y_i^2)^(1/2)\
            &<= (sum_(i = 1)^n alpha_i x_i^2)^(1/2) + (sum_(i = 1)^n alpha_i y_i^2)^(1/2) = nu(x) + nu(y)
$

得证。

=== 综上

函数 $nu: R^n -> R$ 满足范数的定义，是一个番薯。

== 9

=== $>=$

根据矩阵范数的定义和算子范数的性质，对于 $forall x in R^n, norm(x) = 1$

$
       &norm(x) = 1 = norm(A^(-1) A x) <= norm(A^(-1)) norm(A x)\
  => &norm(A^(-1))^(-1) <= norm(A x) => norm(A^(-1))^(-1) <= min_(norm(x)=1) norm(A x)
$

=== $<=$

取 $y in R^n$ 满足 $norm(y) = 1, norm(A^(-1)) = norm(A^(-1) y)$，其中 $y$ 的存在性是显然的。

令 $z = A^(-1) y$ 即 $y = A z$，则 $norm(A^(-1))=norm(z), 1 = norm(y) = norm(A z)$。

取 $x = z / norm(z)$，有

$
  norm(A x) = norm(A z / norm(z)) = norm(A z) / norm(z) = 1 / norm(z) = norm(A^(-1))^(-1)
  => min_(norm(x) = 1) norm(A x) <= norm(A^(-1))^(-1)
$


=== 综上

因为 $min_(norm(x) = 1) norm(A x) >= norm(A^(-1))^(-1)$ 和 $min_(norm(x) = 1) norm(A x) <= norm(A^(-1))^(-1)$ 同时成立，所以

$
  norm(A^(-1))^(-1) = min_(norm(x) = 1) norm(A x)
$

证毕。
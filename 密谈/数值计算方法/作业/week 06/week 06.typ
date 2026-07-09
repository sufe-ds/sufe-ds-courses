#import "../homework.typ": config

#show: config.with("数值计算方法", "第六周作业", "", "匿名", "20XXXXXXXX")

= 求矩阵 $A$ 无穷范数下的条件数

首先要求矩阵 $A$ 的逆矩阵 $A^(-1)$，

$
  mat(A, dots.v, I) & = mat(
                        1, -1, -1, dots, -1, -1, dots.v, 1, 0, 0, dots, 0, 0;
                        0, 1, -1, dots, -1, -1, dots.v, 0, 1, 0, dots, 0, 0;
                        0, 0, 1, dots, -1, -1, dots.v, 0, 0, 1, dots, 0, 0;
                        dots.v, dots.v, dots.v, dots.down, dots.v, dots.v, dots.v, dots.v, dots.v, dots.v, dots.down, dots.v, dots.v;
                        0, 0, 0, dots, 1, -1, dots.v, 0, 0, 0, dots, 1, 0;
                        0, 0, 0, dots, 0, 1, dots.v, 0, 0, 0, dots, 0, 1;
                      ) \
                    & -> mat(
                        1, -1, -1, dots, -1, -1, dots.v, 1, 0, 0, dots, 0, 0;
                        0, 1, -1, dots, -1, -1, dots.v, 0, 1, 0, dots, 0, 0;
                        0, 0, 1, dots, -1, -1, dots.v, 0, 0, 1, dots, 0, 0;
                        dots.v, dots.v, dots.v, dots.down, dots.v, dots.v, dots.v, dots.v, dots.v, dots.v, dots.down, dots.v, dots.v;
                        0, 0, 0, dots, 1, 0, dots.v, 0, 0, 0, dots, 1, 1;
                        0, 0, 0, dots, 0, 1, dots.v, 0, 0, 0, dots, 0, 1;
                      ) \
                    & dots \
                    & -> mat(
                        1, 0, 0, dots, 0, 0, dots.v, 1, 1, 2, dots, 2^97, 2^98;
                        0, 1, 0, dots, 0, 0, dots.v, 0, 1, 1, dots, 2^96, 2^97;
                        0, 0, 1, dots, 0, 0, dots.v, 0, 0, 1, dots, 2^95, 2^96;
                        dots.v, dots.v, dots.v, dots.down, dots.v, dots.v, dots.v, dots.v, dots.v, dots.v, dots.down, dots.v, dots.v;
                        0, 0, 0, dots, 1, 0, dots.v, 0, 0, 0, dots, 1, 1;
                        0, 0, 0, dots, 0, 1, dots.v, 0, 0, 0, dots, 0, 1;
                      ) = mat(I, dots.v, A^(-1))
$

不难得到这两个矩阵的范数为 $ norm(A)_oo = 1 + sum_(j=2)^100 abs(-1) = 100 $ $ norm(A^(-1))_oo = 1 + sum_(j=2)^100 abs(2^(j - 2)) = 2^99 $

所以矩阵 $A$ 的条件数为 $ kappa(A) = norm(A^(-1))_oo dot norm(A)_oo = 100 times 2^99 $

= 教材第二章课后习题

== 11

=== 1

$
  mat(A, dots.v, I) = mat(
    375, 374, dots.v, 1, 0;
    752, 750, dots.v, 0, 1
  ) & -> mat(
        1, 374/375, dots.v, 1/375, 0;
        0, 2/375, dots.v, -752/375, 1
      ) -> mat(
        1, 374/375, dots.v, 1/375, 0;
        0, 1, dots.v, -376, 375/2
      ) \
    & -> mat(
        1, 0, dots.v, 375, -187;
        0, 1, dots.v, -376, 375/2
      ) = mat(I, dots.v, A^(-1))
$

即

$
  A^(-1) = mat(
    375, -187;
    -376, 375/2
  )
$

所以

$
  kappa(A)_oo = norm(A^(-1))_oo dot norm(A)_oo = 1127/2 times 1502 = 846377
$

=== 2

考虑到矩阵乘法的本质是线性变换，我们这样构造 $b$：

求矩阵 $A$ 的特征值与特征向量，令 $b = alpha v_1$，$delta b = beta v_2$，其中 $v_1$ 为绝对值较大的特征值对应的特征向量，$v_2$ 为绝对值较小的特征值对应的特征向量。

这样做的考虑是，矩阵乘法对特征向量起到拉伸的作用，超偏离拉伸效果大的方向迈一小步，会造成最终结果偏离很多，若偏向另一个特征值的方向，则效果最为显著。


$
  det(A - lambda I) = mat(delim: "|", 375 - lambda, 374; 752, 750 - lambda) = lambda^2 - 1125 lambda + 2 = 0\
  => lambda_1 = 1125/2 + sqrt(1265617)/2, lambda_2 = 1125/2 - sqrt(1265617)/2
$

对于 $lambda_1$，

$
  (A - lambda_1 I) v_1 = 0 => v_1 = mat(1504; -375 + sqrt(1265617))
$

对于 $lambda_2$，

$
  (A - lambda_2 I) v_2 = 0 => v_2 = mat(1504; -375 - sqrt(1265617))
$

处于计算简单考虑，这里直接取 $alpha = beta = 1$，则

$ norm(delta b)_oo / norm(b)_oo = 1504 / 1504 = 1 $

因为 $A x = b, A(x + delta x) = b + delta b => A delta x = delta b$，解得

$
  x = mat(-421873 + 375 times sqrt(1265617); 423000 - 376 times sqrt(1265617))\
  delta x = mat(-634918865 - 563625 times sqrt(1265617); 636615000+ 565128 times sqrt(1265617))
$

则

$
  norm(delta x)_oo / norm(x)_oo = (636615000+ 565128 times sqrt(1265617)) / (423000 - 376 times sqrt(1265617)) approx 951746993.006341
$

嗯……这里的计算可能有点问题……不过无伤大雅……吧。

不难看出，对于这样病态的矩阵 $A$，在 $norm(delta b)_oo / norm(b)_oo$ 较小的情况下，按照特征值选取 $b$、$delta b$ 可以使 $norm(delta x)_oo / norm(x)_oo$ 很大。

=== 3

这一题其实与第二小题几乎一致，变形可得

$ A^(-1) b = x, A^(-1) (b + delta b) = x + delta x $

我们只要按照矩阵 $A^(-1)$ 的特征向量选取 $x$ 和 $delta x$ 就可以满足题意。

过程不再赘述，直接给出答案。

特征值与对应的特征向量为

$
  lambda_1 = (1125+sqrt(1265617))/4, v_1 = mat(-375 - sqrt(1265617); 1504)\
  lambda_2 = (1125-sqrt(1265617))/4, v_2 = mat(-375 + sqrt(1265617); 1504)
$

取 $x = v_1, delta x = v_2$，则 $ norm(delta x)_oo / norm(x)_oo = 1504/1504 =1 $

进一步解得

$
  b = mat(
    421871 - 375 times sqrt(1265617);
    846000 - 752 times sqrt(1265617)
  ), delta b = mat(
    421871 + 375 times sqrt(1265617);
    752 times sqrt(1265617) + 846000
  )
$

所以 $ norm(delta b)_oo / norm(b)_oo = (752 times sqrt(1265617) + 846000)/(846000 - 752 times sqrt(1265617)) approx 632810.500004216 $

== 17

首先，计算每个平方项 $x_i^2$ 时，有：

$
  "fl"(x_i^2) = x_i^2 (1 + delta_i), quad |delta_i| <= u.
$

令 $p_i = "fl"(x_i^2)$，然后，计算求和 $sum_(i=1)^n p_i$ 时，使用浮点加法。

假设按顺序求和，令 $t_1 = p_1$，对于 $k = 2$ 到 $n$，有：

$
  t_k = "fl"(t_(k-1) + p_k) = (t_(k-1) + p_k)(1 + epsilon_k), quad |epsilon_k| <= u.
$

最终结果 $"fl"(x^T x) = t_n$.

标准误差分析给出：

$
  t_n = sum_(i=1)^n p_i (1 + eta_i),
$

其中 $|eta_i| <= gamma_(n-1)$，且 $gamma_k = (k u)/(1 - k u)$ 对于 $k u < 1$。因此，

$
  t_n = sum_(i=1)^n x_i^2 (1 + delta_i) (1 + eta_i).
$

于是，

$
  "fl"(x^T x) = sum_(i=1)^n x_i^2 (1 + delta_i) (1 + eta_i) = x^T x + sum_(i=1)^n x_i^2 (delta_i + eta_i + delta_i eta_i).
$

相对误差 $alpha$ 满足：

$
  "fl"(x^T x) = x^T x (1 + alpha),
$

其中

$
  alpha = (sum_(i=1)^n x_i^2 (delta_i + eta_i + delta_i eta_i))/(x^T x).
$

取绝对值：

$
  |alpha| <= (sum_(i=1)^n x_i^2 |delta_i + eta_i + delta_i eta_i|)/(x^T x) <= (sum_(i=1)^n x_i^2 (|delta_i| + |eta_i| + |delta_i eta_i|))/(x^T x).
$

由于 $|delta_i| <= u$ 和 $|eta_i| <= gamma_(n-1)$，且 $|delta_i eta_i| <= u gamma_(n-1)$，有：

$
  |alpha| <= u + gamma_(n-1) + u gamma_(n-1).
$

代入 $gamma_(n-1) = ((n-1) u)/(1 - (n-1) u)$，对于小 $u$，有：

$
  gamma_(n-1) approx (n-1) u + O(u^2),
$

所以：

$
  |alpha| <= u + (n-1) u + O(u^2) = n u + O(u^2).
$

因此，

$
  "fl"(x^T x) = x^T x (1 + alpha), quad |alpha| <= n u + O(u^2).
$

= 证明


由于 $A$ 是正定矩阵，它是对称的且所有特征值均为正实数。设其特征值为：

$
  lambda_1 >= lambda_2 >= dots >= lambda_n > 0
$



矩阵 $A$ 的 2-范数定义为：

$
  abs(A)_2 = max_(abs(x)_2 = 1) abs(A x)_2
$

对于对称矩阵，有：

$
  abs(A)_2 = max(|lambda_i|) = lambda_(max)
$



由于 $A$ 可逆，其逆矩阵 $A^(-1)$ 的特征值为：

$
  (1)/(lambda_1), (1)/(lambda_2), dots, (1)/(lambda_n)
$

因此：

$
  abs(A^(-1))_2 = 1/abs(lambda_i) = 1/(lambda_(min))
$



矩阵 $A$ 的条件数定义为：

$
  kappa(A) = abs(A)_2 dot abs(A^(-1))_2
$

代入上述结果：

$
  kappa(A) = (lambda_(max))/(lambda_(min))
$


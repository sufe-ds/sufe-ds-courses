#import "./homework.typ": config
#import "@preview/physica:0.9.7": dd, dv, pdv

#show: config.with("概率论与数理统计", "第十一周作业", "", "匿名", "20XXXXXXXX")

= 习题 4-1

== 3

#image("img/week 11/image.png")

=== （1）

记试开次数为随机变量 $X$，则 $ P(X = k) = (n-1)/n (n-2)/(n-1) dots.c (n-k+1)/(n-k+2) 1/(n-k+1) = 1/n $

那么，期望为

$ E(X) = sum_(k=1)^n k P(X = k) = sum_(k=1)^n k/n = (n + 1) / 2 $

=== (2)

记试开次数为随机变量 $Y$，则 $ Y ~ G(1/n) $

那么，期望为

$ E(Y) = n $

== 5

#image("img/week 11/image-1.png")

=== (1)

根据题意，$X ~ "Exp"(2)$

$
  E(X^2) = D(X) + E(X)^2 = 1/lambda^2 + (1/lambda)^2 = 1/2
$

=== (2)

$
  E(Z) &= E(e^(-1/2 X^2 + 2X))\
       & = integral_(0)^(+oo) 2 e^(-1/2 x^2 + 2x) e^(-2x) dd(x) = 2 integral_(0)^(+oo) e^(-1/2 x^2) dd(x)\
       & = 2 sqrt(2 pi) integral_(0)^(+oo) 1/sqrt(2 pi) e^(-1/2 x^2) = 2 sqrt(2 pi) (1 - Phi(0))\
       & = sqrt(2 pi)
$


== 6

#image("img/week 11/image-2.png")

$
  E(X Y ) & = integral_(-oo)^(+oo) integral_(-oo)^(+oo) x y p(x, y) dd(x) dd(y)\
          & = integral_(0)^(1) integral_(0)^(-2x + 2) x y dd(y) dd(x) = integral_(0)^(1) 2 x (x - 1)^2 dd(x)\
          &= 1/6
$

== 7

#image("img/week 11/image-3.png")

每个球放入对于盒子的概率是 $1/n$，则最终期望是 $1$。

= 习题 4-2

== 1

#image("img/week 11/image-4.png")

$
  E(X) = 0.2 times (-1) + (0.5 - 0.2) times 0 + (0.8 - 0.5) times 1 + (1 - 0.8) times 2 = 0.5\
  E(X^2) = (0.2 + 0.3) times 1 + 0.3 times 0 + 0.2 times 4 = 1.3\
  D(X) = E(X^2) - E(X)^2 = 1.05
$

== 2

#image("img/week 11/image-5.png")

$
  p(x)   &= F'(x) = cases(1/(pi sqrt(1 - x^2)) ", " -1 <= x < 1, 0 ", 其他")\
  E(X)   &= integral_(-oo)^(+oo) x p(x) dd(x) = integral_(-1)^(1) x / (pi sqrt(1 - x^2)) dd(x) = 0\
  E(X^2) &= integral_(-oo)^(+oo) x^2 p(x) dd(x) = integral_(-1)^(1) x^2 / (pi sqrt(1 - x^2)) dd(x) \
         &= 2/pi integral_(0)^(1) x^2 / sqrt(1-x^2) dd(x) = 2/pi integral_(0)^(pi/2) (sin^2 theta) / (cos theta) cos theta dd(theta)\
         &= 2 / pi integral_(0)^(pi/2) (1 - sin 2theta)/2 dd(theta) = 1/2\
  D(X)   &= E(X^2) - E(X)^2 = 1/2
$

== 3

#image("img/week 11/image-6.png")

记随机变量 $I_i$ 表示第i次抽出卡片的号码。不难发现 $I$ 相互独立。

对于 $forall i$，$ E(I_i) = (1 + n) / 2, D(I_i) = (n^2 - 1) / 12 $

则 $ E(X) = (n+1)/2 r, D(X) = (n^2 - 1) / 12 r $

== 4

#image("img/week 11/image-7.png")

根据切比雪夫不等式，有 

$
  P(abs(X - 10) >= epsilon) < 10 / epsilon^2
$

当 $epsilon = 10$ 时，有

$
  P(0 < X < 20) >= 0.9
$

== 6

#image("img/week 11/image-8.png")

$
  E(X) = (2000 + 4000) / 2 = 3000
$

设货源 $a$ 吨，随机变量 $Q$ 表示企业收益，则

$
  Q = 3 min{a, X} - max{0, a - X} = cases(3 a ", " a < X, 4 X - a ", " a >= X)
$

$
  E(Q) &= 1/2000 integral_2000^(a) (4x - a) dd(x) + 1/2000 integral_(a)^4000 3a dd(x) = -a^2/1000 + 7 a - 4000
$

当 $a=3500$ 时，企业收益最大。

= 习题 4-3

== 2

#image("img/week 11/image-9.png")

=== （1）

$
  p_X (x) &= integral_(-oo)^(+oo) p(x, y) dd(y) = cases(integral_(1-x)^1 2 dd(y) ", " 0 < x < 1, 0 ", 其他") = cases(2x ", " 0 < x < 1, 0 ", 其他")\
  E(X)    &= integral_(-oo)^(+oo) x p_X (x) dd(x) = integral_0^1 2x^2 dd(x) = 2/3\
  E(X^2)  &= integral_(-oo)^(+oo) x^2 p_X (x) dd(x) = integral_0^1 2x^3 dd(x) = 1/2\
  D(X)    &= E(X^2) - E(X)^2 = 1/18
$

$
  p_Y (y) &= integral_(-oo)^(+oo) p(x, y) dd(y) = cases(integral_(1-y)^1 2 dd(y) ", " 0 < x < 1, 0 ", 其他") = cases(2y ", " 0 < y < 1, 0 ", 其他")\
  E(Y)    &= integral_(-oo)^(+oo) y p_Y (y) dd(y) = integral_0^1 2y^2 dd(y) = 2/3\
  E(Y^2)  &= integral_(-oo)^(+oo) y^2 p_Y (y) dd(y) = integral_0^1 2y^3 dd(y) = 1/2\
  D(Y)    &= E(Y^2) - E(Y)^2 = 1/18
$

$
  E(X Y) &= integral_(-oo)^(+oo) x y p(x, y) dd(x) dd(y) = integral_0^1 integral_(1-x)^1 2 x y dd(y) dd(x) \
         &=integral_0^1 x (2x - x^2) dd(x) = 5/12
$

$
  rho_(X Y) = (E(X Y) - E(X) E(Y)) / sqrt(D(X) D(Y)) = (5/12 - 2/3 2/3) / sqrt(1/18 1/18) = -1/2
$

=== （2）

$
  D(X - Y + 2) = D(X) + D(Y) =1/9
$

== 3

#image("img/week 11/image-10.png")

=== （1）

$
  "Cov"(X, Y)     &= rho_(X Y) sqrt(D(X) D(Y)) = -6\
  "Cov"(X/3, Y/2) &= 1/3 1/2 (-6) = -1\
  E(Z)            &= E(X) / 3 + E(Y) / 2 = 1/3\
  D(Z)            &= 1/9 D(X) + 1/4 D(Y) + 2 "Cov"(X/3, Y/2) = 3
$

=== (2)

$
  "Cov"(X, Z) & = "Cov"(X, X/3+Y/2) = 1/3 D(X) + 1/2 "Cov"(X, Y) = 0\
  rho_(X Z)   &= ("Cov"(X, Z)) / sqrt(D(X) D(Z)) = 0
$


== 4

#image("img/week 11/image-11.png")

=== (1)

$
  E(Z)      & = sin alpha E(X) + cos alpha E(Y)\
  E(W)      & = cos beta E(X) + sin beta E(Y)\
  E(Z) E(W) &= cos(alpha - beta) E(X)^2\
  E(Z W)    &= E((sin alpha cos beta) X^2 + cos(alpha - beta) X Y + (sin beta cos alpha) Y^2)\
            &= sin(alpha + beta) E(X^2) + cos(alpha - beta) E(X)^2
$

综上，若不相关，则 $E(Z W) = E(Z) E(W)$，也就是 $sin(alpha + beta) = 0$。

=== （2）

$
  "Cov"(Z, W) &= sin(alpha + beta) E(X^2)\
  D(Z)        &= D(X) = E(X^2) - E(X)^2\
  D(W)        &= D(X) = E(X^2) - E(X)^2
$

如完全线性相关，则

$
       &"Cov"(Z, W) ^2 = D(Z) D(W)\
  <=>& sin^2 (alpha + beta) E(X^2)^2 = E(X^2)^2 + E(X)^4 - 2 E(X^2) E(X)^2\
  <=>& 0 = cos(alpha + beta) E(X^2)^2
$

综上，若完全线性相关，则 $cos(alpha + beta) = 0$。

== 5

#image("img/week 11/image-12.png")

$
  D(X)        & = E(X^2) - E(X)^2 = 329/6 - 49 = 35/6\
  D(Y)        & = E(Y^2) - E(Y)^2 = 35/6 - 0 = 35/6\
  E(X Y)      &= 0\
  "Cov"(X, Y) &= E(X Y) - E(X) E(Y) = 0\
  rho_(X Y)   &= "Cov"(X, Y) / sqrt(D(X) D(Y)) = 0
$

不独立，因为

$
  p_(2, 0) = 1/36, p_(x=2) = 1/36, p_(y=0) = 1/6
$
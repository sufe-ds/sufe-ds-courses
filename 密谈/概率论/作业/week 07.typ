#import "./homework.typ": config
#import "@preview/physica:0.9.7": dd, dv

#show: config.with("概率论与数理统计", "第七次作业", "", "匿名", "20XXXXXXXX")

= 总复习题二

== 2

=== （1）

$ P(X = k) = cases(binom(3, k-1) / binom(13, k-1) times 10 / (14 - k) ", " 0 <= k <= 3, 1 ", " 4 <= x) $

=== （2）

$ P(X = k) = 10/13 (3/13)^(k-1) $

=== （3）

$
  P(X = k) = cases(10/13 ", " k = 1, 3/13 11/14 ", " k = 2, 3/13 2/14 12/15 ", " k = 3, 1 ", " 4 <= k)
$

== 4

=== （1）

$ p = 0.7 + 0.3 times 0.8 = 0.94 $

=== （2）

$ alpha = binom(20, 2) (1 - p)^2 p^18 approx 0.32805 $

=== （3）

$ beta = 1 - p^20 - binom(20, 1) (1-p) p^19 approx 0.33955 $

== 5

$ p = 0.0005^2000 $


== 7

$ P(X = k) = (5/6 5/6)^(k-1) (1 - 5/6 5/6) = 11/36 (25/36)^(k-1) $

== 9

=== （1）

$ integral_(-oo)^(+oo) p(x) dd(x) = A integral_(-pi/2)^(pi/2) cos x dd(x) = 2 A = 1 => A = 1/2 $

=== （2）

$
  p &= integral_(0)^(pi/4) p(x) dd(x) = 1/2 integral_0^(pi/2) cos x dd(x) \
    &= 1/2 [sin x]_0^(pi/4) = sqrt(2) / 4
$

=== （3）

$
  P(x) = integral_(-oo)^x p(y) dd(y) = cases(1/2 sin x + 1/2 ", " abs(x) <= pi / 2, 0 ", " pi / 2 < abs(x))
$

== 10

根据题意，$ Y ~ B(3, P(X <= 1/2)) $

其中，

$
  P(X <= 1/2) = integral_(-oo)^(1/2) p(x) dd(x) = 2 integral_0^(1/2) x dd(x) = 1/4
$

所以，$ P(Y=2)=binom(3, 2) (1/4)^2 3/4 = 9/64 $

== 11

$
  P(x) = cases(0 ", " x <= 0, x/a ", " 0 < x <= a, 0 ", " a < x)
$

== 12

令随机变量 $Y ~ "Exp"(lambda)$，则 $X ~ B(n, P(Y >= T))$。

$
  P(Y >= T) = integral_T^(+oo) lambda e^(-lambda x) dd(x) = [-e^(-lambda x)]_T^(+oo) = e^(-lambda T)
$

则

$
  P(X = k) = binom(n, k) e^(-lambda T)^k (1 - e^(-lambda T))^(n - k)
$

== 13

$
  1 &= integral_(-oo)^(+oo) p(x) dd(x) \
    &= A integral_(-oo)^(+oo) e^(-(x - 1/2)^2 + 1/4) dd(x)\
    &= A e^(1/4) integral_(-oo)^(+oo) e^(-u^2) dd(u) = A e^(1/4) sqrt(pi) => A = 1 / (sqrt(pi) e^(1/4))
$


== 14

可得 $(X - mu) / 4 ~ N(0, 1^2)$，则

$
  p_1 = P(X <= mu - 4) = P((X - mu) / 4 <= -1) = Phi(-1)
$

同理

$
  p_2 = P(Y >= mu + 5) = P(1 <= (Y - mu) / 5) = 1 - Phi(1) = Phi(-1)
$

综上

$
  p_1 = p_2 = Phi(-1)
$

== 16

=== （1）

记事件 $A_1$ 为“不超过 200V”，$A_2$ 为“200V~240V”，$A_3$为“超过240V”，事件 $B$ 为“损坏”。

则

$
  P(A_1) &= P(X <= 200) = P((X - 220)/25 <= -4/5) approx 0.21186\

  P(A_2) &= 1 - 2 times P(A_1) approx 0.57629\

  P(A_3) &= P(A_1) approx 0.21186
$

所以，

$
  alpha = P(B) = sum_(i=1)^3 P(B|A_i) P(A_i) approx 0.04295
$

=== （2）

$
  beta = P(A_2 | B) = (P(B|A_2) P(A_2)) / alpha approx 0.00899
$

== 18

根据题意，

$
  P(Y = 1)  &= integral_(0)^(+oo) p(x) dd(x) = 2/pi integral_0^(+oo) dd(x)/(e^x + e^(-x)) = 2/pi integral_1^(+oo) dd(u) / (u^2 + 1) = 2/pi [arctan u]_1^(+oo) = 1/2 \
  P(Y = -1) &= 1 - P(Y = 1) = 1/2
$

#figure(table(columns: (auto, 1fr, 1fr), inset: 10pt, $X$, $1$, $-1$, $P$, $1/2$, $1/2$), caption: [$Y$ 的随机分布])

== 19

先求分布函数

$
  P_Y (y) = P(sin X <= y) = cases(0 ", " &y < -1, 1/pi arcsin (y) + 1/2 ", " &-1 <= y <= 1, 1 ", " &1 < y)
$

则密度函数为

$
  p_Y (y) = dv(P_Y, y)(y) = cases(1/(pi sqrt(1 - y^2)) ", " -1 <= y <= 1, 0 ",其他 ")
$

== 20

先求 $X$ 的分布函数

$
  P(X <= k) = cases(1 - e^(-5k) ", " 0 < k, 0 ", " k <= 0)
$

再求 $Y$ 的分布函数

$
  P(Y <= l) &= P(1 - e^(-5X) <= l) = P(X <= -1/5ln(1 - l) )\
            &= cases(l ", " 0 < l < 1, 0 ", 其他")
$

所以 $ Y ~ U(0, 1) $

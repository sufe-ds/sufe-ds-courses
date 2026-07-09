#import "./homework.typ": config
#import "@preview/physica:0.9.7": dd, dv, pdv

#show: config.with("概率论与数理统计", "第十周作业", "", "匿名", "20XXXXXXXX")

#set table(inset: 10pt, stroke: 0.5pt)
= 习题 3-3

== 1

#image("img/week 10/image-12.png")

=== （1）

#align(center, table(columns: 4, $U$, $1$, $2$, $3$, $P$, $1/6$, $2/3$, $1/6$))

=== （2）

#align(center, table(columns: 3, $V$, $1$, $2$, $P$, $1/3$, $2/3$))

=== (3)

#align(center, table(columns: 5, $Z$, $2$, $3$, $4$, $5$, $P$, $1/6$, $4/9$, $5/18$, $1/9$))

== 2

#image("img/week 10/image-13.png")

=== （1）

$
  p_Z (z) & = p_(2Z) (2z) abs(dv(2z, z)) = 2 integral_(-oo)^(+oo) p_X (x) p_Y (2z - x) dd(x) \
$

其中

$
  p_X (x) = integral_(-oo)^(+oo) p(x, y) dd(y) = integral_(0)^(+oo) e^(-(x+y)) dd(y) = e^(-x)
$

$
  p_Y (y) = integral_(-oo)^(+oo) p(x,y) dd(x) = integral_(0)^(+oo) e^(-(x+y)) dd(x) = e^(-y)
$

所以

$
  p_Z (z) = cases(2 integral_(0)^(2z) e^(-x) e^(x - 2z) dd(x) ", " 0 < z, 0 ", " z <= 0) = cases(4z e^(2z) ", " 0 < z, 0 ", " z <= 0)
$

=== (2)

$
  F_U (u) & = P (U <= u) \
          & = P (max{X, Y} <= u) \
          & = P (X <= u, Y <= u) \
          & = P(X <= u) P(Y <= u) \
          & = cases(integral_(0)^(u) e^(-x) dd(x) dot.c integral_(0)^(u) e^(-y) dd(y) ", " 0 < u, 0 ", " u <= 0) \
          & = cases((1-e^(u))^2 ", " 0 < u, 0 ", " u <= 0)
$

所以

$
  p_U (u) = dv(F_U, u)(u) = cases(2(e^(-u) - e^(-2u)) ", " 0 < u, 0 ", " u <= 0)
$

同理

$
  F_V (v) & = cases(1 - P(X > v) P(Y > v) ", " 0 < v, 0 ", " v <= 0) \
          & = cases(1 - integral_(v)^(+oo) e^(-x) dd(x) integral_(v)^(+oo) e^(-y) dd(y) ", " 0 < v, 0 ", " v <= 0) \
          & = cases(1 - e^(-2v) ", " 0 < v, 0 ", " v <= 0)
$

$
  p_V (v) & = cases(2 e^(-2v) ", " 0 < v, 0 ", " v <= 0)
$

综上

$
  p_U (u) = cases(2(e^(-u) - e^(-2u)) ", " 0 < u, 0 ", " u <= 0), p_V (v) = cases(2 e^(-2v) ", " 0 < v, 0 ", " v <= 0)
$

== 4

#image("img/week 10/image-14.png")

=== (1)

令 $X$ 表示一个试管所含细菌数，则 $X ~ P(1 + 1)$

$
  P(X = 0) & = 2^0 / 0! e^(-2) = e^-2
$

所以 $ P_1 = 1 - P(X = 0) = 1 - e^(-2) $


=== (2)

$
  P_2 = P_1^5 = (1-e^(-2))^5
$

=== (3)

$
  P_3 = binom(5, 3) P_1^3 (1-P_1)^2 = 10 e^(-4) (1-e^(-2))^3
$

== 5

#image("img/week 10/image-15.png")

=== (1)

根据正态分布的可加性 $Y ~ N(2 times 1 + 3 times 0 - 2, 2^2 times 2 + 3^2 times 3 + (-1)^2 times 1)$，也就是 $Y~N(0, 36)$

所以 $ p_Y (y) = 1/(6 sqrt(2 pi) ) e^(-y^2 / 72) $

=== （2）

$
  P(0 <= Y <= 6) & = P(0 <= Y/6 <= 1) \
                 & = Phi(1) - Phi(0) \
                 & approx 0.3413
$

= 总复习题三

== 1

#image("img/week 10/image-16.png")

#align(center, table(
  columns: 1 + 3 + 1,
  [X\\Y],
  $1$,
  $2$,
  $3$,
  $p_X$,
  $3$,
  $1/10$,
  [],
  [],
  $1/10$,
  $4$,
  $1/5$,
  $1/10$,
  [],
  $3/10$,
  $5$,
  $3/10$,
  $1/5$,
  $1/10$,
  $3/5$,
  $p_Y$,
  $3/5$,
  $3/10$,
  $1/10$,
  $1$,
))

== 2

#image("img/week 10/image-17.png")

$
  P(X Y = 0) & = P(X=0) + P(Y=0) - P(X=0, Y=0) \
             & = 1/2 + 1/2 - P(X=0, Y=0) \
             & = 1
$

所以 $P(X=Y=0) = 0$。又因为 $P(X Y = 0)$，所以$P(X=Y=-1) = P(X=Y=1)=0$。

综上，$ P(X=Y) = 0 $

== 3

#image("img/week 10/image-18.png")

$
  p_X (x) & = integral_(-oo)^(+oo) p(x, y) dd(y) \
          & =cases(
    integral_(-oo)^(0) 1/pi e^(-(x^2+y^2)/2) dd(y) ", " x > 0,
    integral_(0)^(+oo) 1/pi e^(-(x^2+y^2)/2) dd(y) ", " x <= 0,

  ) \
          & =1/(sqrt(2 pi)) e^(-x^2/2)
$

同理

$
  p_Y (y) =1/(sqrt(2 pi)) e^(-y^2/2)
$

== 5

#image("img/week 10/image-19.png")

=== (1) (2)

#align(center, table(
  columns: 1 + 3 + 1,
  [X\\Y],
  $1$,
  $2$,
  $3$,
  $p_X$,
  $1$,
  $0$,
  $1/6$,
  $1/12$,
  $1/4$,
  $2$,
  $1/6$,
  $1/6$,
  $1/6$,
  $1/2$,
  $3$,
  $1/12$,
  $1/6$,
  $0$,
  $1/4$,
  $p_Y$,
  $1/4$,
  $1/2$,
  $1/4$,
  $1$,
))

=== (3)

不难注意到 $P(X=2,Y=2)!=P(X=2) P(Y=2)$。

不独立。

=== （4）

$
  P(X=Y) = sum_(i=1)^3 P(X=i, Y=i) = 1/6
$

== 7

#image("img/week 10/image-20.png")

=== (1)

$
  p_X (x) = integral_(-oo)^(+oo) p(x,y) dd(y) = cases(integral_(x)^(1) 8 x y dd(y) ", " 0 < x < 1, 0 ", 其他") = cases(4x(1-x^2) ", " 0 < x < 1, 0 ", 其他")
$

$
  p_Y (y) = integral_(-oo)^(+oo) p(x,y) dd(x) = cases(integral_(0)^(y) 8 x y dd(x) ", " 0 < y < 1, 0 ", 其他") = cases(4y^3 ", " 0 < y < 1, 0 ", 其他")
$

=== (2)

注意到在 $0<y<x<1$ 时 $p(x) p(y) != 0$。

不独立。

=== (3)

$
  P(X + Y <= 1) = integral_(0)^(1/2) integral_(0)^(y) 8 x y dd(x) dd(y) +integral_(1/2)^(1) integral_(0)^(1-y) 8 x y dd(x) dd(y) = 1/6
$

== 9

#image("img/week 10/image-21.png")

根据概率的性质

$
  P(max{X, Y} >= 0) = P(X >= 0) + P(Y >= 0) - P(X >= 0, Y >= 0) = 5/7
$

== 10

#image("img/week 10/image-22.png")

$
  p_Z (z) & = integral_(-oo)^(+oo) p_X (x) p_Y (z - x) dd(x) \
          & = cases(
    integral_(0)^(z) 2 (z - x) dd(x) ", " 0 <= z <= 1,
    integral_(z-1)^(1) 2 (z - x) dd(x) ", " 1 < z <= 2,
    0 ", 其他",

  ) \
          & = cases(z^2 ", " 0 <= z <= 1, 2 z - z^2 ", " 1 < z <= 2, 0 ", 其他")
$

== 11

#image("img/week 10/image-23.png")

两台机器的工作时间 $X ~ "Exp"(0.2) Y ~ "Exp"(0.2)$，根据题意 $ T = min{2, X, Y} $

先考虑 $Z = min{X, Y}$

$
  F_Z (z) & = P(min{X, Y} <= z) \
          & = 1 - P(min{X, Y} > z) \
          & = 1 - P(X > z, Y > z) \
          & = 1 - P(X > z) P(Y > z) \
          & = 1 - integral_(z)^(+oo) 0.2 e^(-0.2 x) dd(x) dot.c integral_(z)^(+oo) 0.2 e^(-0.2 y) dd(y) \
          & = 1 - e^(-0.4z)
$

则

$
  p_Z (z) & = dv(F_Z, z) (z) = 0.4 e^(-0.4 z)
$

所以

$
  F_T (t) & = P(min{2, Z} < t) \
          & = 1 - P(min{2, Z} > t) \
          & = cases(integral_(0)^(t) p_Z (z) dd(z), 1 ", " 2 < t) \
          & = cases(0 ", " t < 0, 1 - e^(-0.4 t) ", " 0 <= t <= 2, 1 ", " 2 < t)
$

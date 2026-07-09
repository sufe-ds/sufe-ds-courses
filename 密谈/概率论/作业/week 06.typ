#import "./homework.typ": config
#import "@preview/physica:0.9.7": dd

#show: config.with("概率论与数理统计", "第六次作业", "", "匿名", "20XXXXXXXX")

= 习题 2-3

== 6

=== （1）

方程的 $Delta$ 为 $ Delta = (4 X)^2 - 4 times 4 times (X + 2) = 8 (2 X^2 - 2 X - 1) $

令 $Delta = 0$，有 $ 2 X^2 - 2 X - 1 = 0 => X_1 = (1 + sqrt(3)) / 2 approx 1.36603, X_2 = (1 - sqrt(3)) / 2 approx -0.36602 $

综上，

$
  P("有重根") &= P((X = X_1) + (X = X_2))\ 
              & = P(X = (1 + sqrt(3)) / 2) + P(X = (1 - sqrt(3)) / 2) = 0 + 0 = 0
$

=== （2）

$
  P("没有实根") &= P(X_2 <= X <= X_1)\ 
                &= ((1 + sqrt(3)) / 2 - (1 - sqrt(3)) / 2) / (3 - (-3)) = sqrt(3) / 6
$

== 9

根据题意，$ Y ~ B(5, P(X >= 10)) $

其中，

$
  P(X >= 10) &= integral_10^(+oo) p(x) dd(x)\
             &= [-e^(- x/5)]_10^(+oo)\
             &= 0 - (-e^(-2)) = e^(-2)
$

所以，$ P(Y = k) = binom(10, k) e^(-2k) (1 - e^(-2))^(10 - k) $

$
  P(Y >= 1) &= 1 - P(Y = 0)\
            &= 1 - (1 - e^(-2))^10 approx 0.76690
$

== 11

根据题意，$ (ln X - 1) / 2 ~ N(0, 1^2) $

所以，

$
  P(1/2 < X < 2) &= P((-ln 2 - 1) / 2 < (ln X - 1) / 2< (ln 2 - 1) / 2)\
                 &= Phi((ln 2 - 1) / 2) - Phi((- ln 2 - 1) / 2) approx 0.24041
$

== 14

首先估算一共有多少人参加考试，

$
  "#总人数" = 100 / P(60 <= X) = 100 / (1 - Phi(-1))
$

那么，有

$
  20 / "#总人数" = P(k <= X) = 1 - Phi((k - 70) / 10) approx 0.16826
$

查表得

$
  (k - 70) / 10 approx 0.96 => k approx 79.6
$

= 习题 2-4

== 1

=== （1）

#figure(
  table(inset: 10pt, columns: (auto, 1fr, 1fr, 1fr), $X$, $-1$, $0$, $1$, $P$, $1/4$, $1/2$, $1/4$),
  caption: [$cos X$ 的概率分布],
)

=== （2）

#figure(table(inset: 10pt, columns: (auto, 1fr, 1fr), $X$, $0$, $1$, $P$, $1/2$, $1/2$), caption: [$sin X$ 的概率分布])

== 3

$
  p'(y) = cases(abs((y - 1) / 2) ", " -1 < y < 3, 0 ", 其他")
$

== 4

$
  p(y) = cases(2 / sqrt(2 pi) e^(-y^2 / 2) ", " 0 < y, 0 ", 其他")
$
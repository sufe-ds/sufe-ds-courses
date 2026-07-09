#import "./homework.typ": config
#import "@preview/physica:0.9.6": dd, dv
#import "@preview/cetz:0.4.2"

#show: config.with("概率论与数理统计", "第五次作业", "", "匿名", "20XXXXXXXX")

= 习题 2-2

== 1

根据题意，随机变量 $X$ 服从超几何分布，其分布为

$
  P(X = 0) & = (binom(2, 0) binom(4, 3)) / binom(6, 3) = 1 / 5 \
  P(X = 1) & = (binom(2, 1) binom(4, 2)) / binom(6, 3) = 3 / 5 \
  P(X = 2) & = (binom(2, 2) binom(4, 1)) / binom(6, 3) = 1 / 5
$

可以被刻画为

$
  P(X = i) = (binom(2, i) binom(4, 3 - i)) / binom(6, 3), i = 0, 1, 2
$

画成表格为

#figure(
  table(columns: 4, inset: 10pt, align: horizon, $X$, $1$, $2$, $3$, $P(X)$, $1/5$, $3/5$, $1/5$),
  caption: "习题 2-2 1 概率分布表",
)

其分布函数为右连续的阶梯函数

$
  F(X) = cases(0 ", " & x < 0, 0.2 ", " & 0 <= x < 1, 0.8 ", " & 1 <= x < 2, 1 ", " & 2 <= x)
$

画成图像为

#figure(cetz.canvas({
  import cetz.draw: *
  let r = 0.075
  grid((-1, -1), (3, 2), step: 1, stroke: gray + 0.2pt)
  line((-1, 0), (3, 0), mark: (end: "straight"))
  line((0, -1), (0, 2), mark: (end: "straight"))

  line((-1, 0), (0 - r, 0), stroke: blue + 1.5pt)
  line((0 + r, 0.2), (1 - r, 0.2), stroke: blue + 1.5pt)
  line((1 + r, 0.8), (2 - r, 0.8), stroke: blue + 1.5pt)
  line((2 + r, 1), (3, 1), stroke: blue + 1.5pt)

  circle((0, 0), radius: r, stroke: blue + 1pt)
  circle((0, 0.2), radius: r, stroke: blue + 1pt, fill: blue)
  circle((1, 0.2), radius: r, stroke: blue + 1pt)
  circle((1, 0.8), radius: r, stroke: blue + 1pt, fill: blue)
  circle((2, 0.8), radius: r, stroke: blue + 1pt)
  circle((2, 1), radius: r, stroke: blue + 1pt, fill: blue)

  for x in (0, 1, 2) {
    content((x + 0.125, 0 - 0.25), [#x])
  }
  content((0 - 0.125, 1), [1])

  content((0 - 0.7, 0.2 + 0.25), $(0,0.2)$)
  content((1, 0.8 + 0.25), $(1,0.8)$)
  content((2, 1 + 0.25), $(2,1)$)
}, length: 1.25cm), caption: "习题 2-2 1 分布函数图像")

== 4

根据题意，

$
  P(X = 0) & = (1 - p_1) (1 - p_2) (1 - p_3) = 1/4 \
  P(X = 1) & = p_1 (1 - p_2) (1 - p_3) + (1 - p_1) p_2 (1 - p_3) + (1 - p_1) (1 - p_2) p_3 = 11 / 24 \
  P(X = 2) & = p_1 p_2 (1 - p_3) + p_1 (1 - p_2) p_3 +(1 - p_1) p_2 p_3 = 1/4 \
  P(X = 3) & = p_1 p_2 p_3 = 1/24
$

所以

#figure(
  table(columns: 1 + 4, inset: 10pt, align: horizon, $X$, $0$, $1$, $2$, $3$, $P(X)$, $1/4$, $11/24$, $1/4$, $1/24$),
  caption: "习题 2-2 4 概率分布表",
)

概率分布函数为

$
  F(X) = cases(0 ", " x < 0, 1/4 ", " 0 <= x < 1, 17/24 ", " 1 <= x < 2, 23/24 ", " 2 <= x < 1, 1 ", " 1 <= x)
$

== 7

根据题意，可以理解为单个用户任意时刻使用电话的概率为 $p = 1/5$

假设有 $k$ 条电话路线，则任意时刻能为所有电话用户服务的概率为

$
  P_k = sum_(i=0)^k binom(10, i) p^i (1 - p)^(10 - i) = (1-p)^10 sum_(i=0)^k binom(10, i) (p / (1-p))^i
$

计算得到

$
  P_4 approx 0.96721, P_5 approx 0.99363
$

综上，应当设置 5 条电话线路。

== 8

根据题意，每月销售 $k$ 个该种商品的概率为

$
  P_k = (5^k e^(-5)) / 5!
$

计算可得 $ 1 - P_14 approx 0.99953, 1 - P_15 approx 0.99984 $

所以，库存 15 个该种商品可以保证不脱销的概率在 0.99977 以上

== 10

根据题意，$ P(X = k) = (1/4)^(k - 1) 3/4 $

= 习题 2-3

== 2

根据题意，

$
  integral_(-oo)^(1/3) p(x) dd(x) = integral_(1/3)^(oo) p(x) dd(x)
$

也就是说

$
  [1/2 a x^2 + b x]_0^(1/3) = [1/2 a^2 + b x]_(1/3)^1
  => 1/18 a + 1/3 b = 4/9 a + 2/3 b => 7 a + 6 b = 0
$

又因为

$
  integral_(-oo)^oo p(x) dd(x) = 1
$

所以

$
  [1/2 a x^2 b x]_0^1 = 1/2 a + b = 1 => a + 2 b = 2
$

综上，

$
  a = -3/2, b = 7/4
$

== 3

$
  F(x) & = integral_(-oo)^x p(y) dd(y) = 1/2 integral_(-oo)^x e^(-abs(y)) \
       & = cases(
    1 / 2 integral_(-oo)^x e^y dd(y) ", " x < 0,
    1/2(integral_(-oo)^0 e^y dd(y) + integral_0^x e^(-y) dd(y)) ", " 0 <= x,

  ) \
       & =cases(1/2 e^x ", " x < 0, 1 - 1/2 e^(-x) ", " 0 <= x)
$

== 4

=== 1

根据题意，

$
  cases(A = B, B = 1 - A)
$

所以 $ A = B = 1/2 $

=== 2

$
  p(x) & = dv(P, x)(x) = cases(1/2 e^x ", " x < 0, 0 ", " 0 <= x < 1, 1/2 e^(-(x - 1)) ", " 1 <= x)
$

=== 3

$
  P(X > 1/3) & = integral_(1/3)^(+oo) p(x) dd(x) \
             & = 1/2 integral_(1)^(+oo) e^(-(x - 1)) dd(x) \
             & = 1/2 [-e^(-(x - 1))]_1^(+oo) = 1/2
$

== 5

=== 1

$
  P(X >= 150) & = integral_(150)^(+oo) p(x) dd(x) \
              & = integral_(150)^(+oo) 100 / x^2 dd(x) \
              & = [-100 / x]_(150)^(+oo) = 2/3
$

=== 2

$
  p_2 = P(X >= 150)^3 = 8/27
$


===

$
  p_3 = 1 - [1 - P(x >= 150)]^3 = 26 / 27
$

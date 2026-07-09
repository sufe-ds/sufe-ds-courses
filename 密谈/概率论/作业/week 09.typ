#import "./homework.typ": config
#import "@preview/physica:0.9.7": dd, dv, pdv
#show: config.with("概率论与数理统计", "第九周作业", "", "匿名", "20XXXXXXXX")

#set table(inset: 10pt, stroke: 0.5pt)

= 习题 3-1


== 3

#image("img/week 09/image-3.png")

=== (1)

$
  1 & = integral_(-oo)^(+oo) integral_(-oo)^(+oo) p(x, y) dd(x), dd(y) \
    & = A integral_(0)^(+oo) integral_(0)^(+oo) e^(-(2x + 3y)) dd(x), dd(y) \
    & = A integral_(0)^(+oo) [-1/3 e^(-(2x + 3y))]_0^(+oo) dd(x) = A/3 integral_(0)^(+oo) e^(-2x) dd(x) \
    & = A/3 [-1/2 e^(-2x)]_0^(+oo) =A / 6
$

综上 $ A = 6 $


=== (2)

$
  P(-1 <= X <= 1, -2 <= Y <= 2) & = integral_(0)^(+1) integral_(0)^(+2) p(x, y) dd(x), dd(y) \
                                & = 6 integral_(0)^(+1) e^(-2x) dd(x) integral_(0)^(+2) e^(-3y) dd(y) \
                                & = (1 - e^(-2))(1 - e^(-6))
$

=== (3)

$
  F(x, y) & = integral_(-oo)^(x) integral_(-oo)^(y) p(u, v) dd(v) dd(u) \
          & = cases(6 integral_(0)^(x) integral_(0)^(y) e^(-(2u + 3v)) dd(v) dd(u) & ", " 0 < x "," y, 0 & ", 其他") \
          & = cases((1-e^(-2x))(1-e^(-3y)) & ", " 0 < x "," y, 0 & ", 其他")
$

== 4

#image("img/week 09/image-5.png")
#image("img/week 09/image-6.png")

$p(x, y) >= 0$ 显然。

$
  integral_(-oo)^(+oo) integral_(-oo)^(+oo) p(x, y) dd(y) dd(x)
    &= integral_(0)^(+oo) integral_(0)^(+oo) (2g(sqrt(x^2 + y^2)))/(pi sqrt(x^2 + y^2)) dd(y) dd(x)\
    &= 2 / pi integral_(0)^(pi/2) dd(theta) integral_(0)^(+oo) g(rho) dd(rho) = integral_(0)^(+oo) g(rho) dd(rho) = 1
$

综上，可以。

== 5

#image("img/week 09/image-7.png")

$
  p_X(x) = integral_(-oo)^(+oo) p(x, y) dd(y) = cases(integral_(-x)^(x) 3/2 x dd(y) = 3 x^2 ", " 0 < x < 1, 0, "其他")
$

$
  p_Y(x) = = integral_(-oo)^(+oo) p(x, y) dd(x) = cases(3/4 (1 - y^2) ", " -1 < y < 1, 0, "其他")
$

== 6

#image("img/week 09/image-8.png")

=== （1）

$
  P(X + Y <= 1) & = integral_(-oo)^(+oo) integral_(-oo)^(1 - y) p(x, y) dd(x) dd(y) \
                & = integral_(0)^(1/2) integral_(0)^(y) e^(-y) dd(x) dd(y) + integral_(1/2)^(1) integral_(0)^(1 - y) e^(-y) dd(x) dd(y)\
                &= integral_(0)^(1/2) y e^(-y) dd(y) + integral_(1/2)^(1) (1-y)e^(-y) dd(y)\
                &= 1 - 3/(2sqrt(e)) + 1/e - 1/(2sqrt(e)) = 1 + 1/e -2/sqrt(e)
$

=== （2）

$
  P(X = Y) & = 0
$


=== （3）

$
  p_X (x) = integral_(-oo)^(+oo) p(x, y) dd(y) = cases(integral_(x)^(+oo) e^(-y) dd(y) ", " 0 < x, 0 ", 其他") = cases(e^(-x) ", " 0 < x, 0 ", 其他")
$

$
  p_Y (y) = integral_(-oo)^(+oo) p(x, y) dd(x) = cases(integral_(0)^(y) e^(-y) dd(x) ", " 0 < y, 0 ", 其他") = cases(y e^(-y) ", " y < 0, 0 ", 其他")
$

=== （4）

$
  P(X > 2 | Y < 4) & = P(X > 2, Y < 4) / P(Y < 4)
$

其中

$
  P(Y < 4) = integral_(0)^(4) integral_(0)^(y) e^(-y) dd(x) dd(y) = integral_(0)^(4) y e^(-y) dd(y) = [-(1+y)e^(-y)]_0^4 = 1-5e^(-4)
$

$
  P(X > 2, Y < 4) = integral_(2)^(4) integral_(2)^(y) e^(-y) dd(x) dd(y) = integral_(2)^(4) (y-2)e^(-y) dd(y) = [-(y - 1)e^(-y)]_2^4 = e^(-2)-3e^(-4)
$

所以

$
  P(X > 2 | Y < 4) = (e^2 - 3) / (e^4 - 5)
$

= 习题 3-2

== 1

#image("img/week 09/image-9.png")

$
  P(X = Y) = 1/2 times 1/2 + 1/2 times 1/2 = 1/2
$

== 3

#image("img/week 09/image-10.png")

=== (1)

$
  1 = F(+oo, +oo) = A(B + pi/2)(C+pi/2)\
  0 = F(-oo, y) = A(B - pi/2)(C - arctan y/3)\
  0 = F(-oo, y) = A(B - arctan x/2)(C - pi/2)\
$

所以

$
  cases(A = 1/pi^2, B = pi/2, C = pi/2)
$

=== (2)

$
  p(x, y) = pdv(F(x, y), x, y) = 6/(pi^2(4+x^2)(9+y^2))
$

=== （3）

$
  p_X (x) = pdv(P(x, y), x) = 2/(pi (4+x^2))\
  p_Y (y) = pdv(P(x, y), y) = 3/(pi (9+y^2))
$

=== (4)

不难发现 $ p(x, y) = p(x) p(y) $

所以 X 和 Y 独立。

== 4

#image("img/week 09/image-11.png")

=== （1）

$
  1 & = integral_(-oo)^(+oo) integral_(-oo)^(+oo) p(x, y) dd(y) dd(x) \
    & =C integral_(-oo)^(+oo) 1/(1+x^2) dd(x) integral_(-oo)^(+oo) 1/(1+y^2) dd(y) \
    & = C [arctan x]_(-oo)^(+oo) [arctan y]_(-oo)^(+oo) = C pi^2
$

所以 $ C = 1/pi^2 $

=== (2)

$
  P(0<X<1,0<Y<1) & = integral_(0)^(1) integral_(0)^(1) p(x, y) dd(y) dd(x) \
                 & = 1/pi^2 ([arctan x]_0^1)^2 = 1/16
$

=== (3)

$
  p_X (x) = integral_(-oo)^(+oo) p(x, y) dd(y) = 1/(pi(1+x^2))\
  p_Y (y) = integral_(-oo)^(+oo) p(x, y) dd(x) = 1/(pi(1+y^2))\
$

=== (4)

有

$
  p(x, y) = p_X (x) p_Y (y)
$

所以独立。

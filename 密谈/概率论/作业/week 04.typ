#import "./homework.typ": config

#show: config.with("概率论与数理统计", "第四次作业", "", "匿名", "20XXXXXXXX")

= 总复习题一

== 1

$
  P(A) & = A_N^k / N^k \
  P(B) & = (N-r)^k / N^k \
  P(C) & = (C_k^m A_(N-1)^(k-m)) / N^k \
  P(D) & = M^k / N^k \
  P(E) & = C_N^k / N^k
$

== 3

$
  P = 1 - (C_5^4 2^4) / C_10^4 = 13 / 21
$

== 5

设边长为 $x$，则

$
  P = (x - 1)^2 / x^2 < 1%
$

解得 $ x < 10/9 $

所以，当方格边长小于 $10/9$ 就可以保证不相交概率小于 1%。

== 6

$ P = k^n / N^n $

== 7

记事件 $A$ 表示“都是黑球”，事件 $B$ 表示“都是同色球”。

根据题意，我们知道如下概率：

$
  P(A B) & = C_(2n)^n / C_(4n-1)^n \
  P(B)   & = (C_(2n)^n + C_(2n-1)^n) / C_(4n-1)^n \
$

所以，

$
  P(A|B) = P(A B) / P(B) = C_(2n)^n / (C_(2n)^n + C_(2n-1)^n) = 2/3
$


== 9

=== $A union B$

$
  P[(A union B) C] & = P(A C union B C) \
                   & = P(A C) union P(B C) - P(A B C) \
                   & = P(A) P(C) union P(B) P(C) - P(A) P(B) P(C) \
                   & = [P(A) union P(B) - P(A) P(B)] P(C) \
                   & = [P(A) union P(B) - P(A B)] P(C) \
                   & = P(A union B) P(C) \
$

=== $A B$

$
  P[(A B) C] & = P(A B C) \
             & = P(A) P(B) P(C) \
             & = P(A B) P(C)
$

=== $A - B$

$
  P[(A - B) C] & = P[(A overline(B))C] \
               & =P(A overline(B) C) \
               & = P(A) P(overline(B)) P(C) \
               & = P(A overline(B)) P(C) \
               & = P(A - B) P(C)
$

== 10

$
  P = C_n^k p^k (1-p)^(n-k)
$

== 12

记事件 $A$ 表示“从甲袋中取一白球放入乙袋中”，事件 $B$ 表示“从乙袋中取出白球”。

根据题意，我们知道如下概率：

$
  P(A)               & = a / (a + b) \
  P(overline(A))     & = b / (a + b) \
  P(B|A)             & = (alpha + 1) / (alpha + beta + 1) \
  P(B|overline((A))) & = alpha / (alpha + beta + 1)
$

根据全概率公式，得到

$
  P(B) = P(A) P(B|A) + P(overline(A)) P(B|overline(A)) = (a + (a + b) dot alpha)/((a + b) dot (alpha + beta + 1))
$

== 13

记事件 $A_m$ 表示“袋中有白球 $m$ 个”，事件 $B_k$ 表示“取 $k$ 次，每次取出的都是白球”。

根据题意，我们知道如下概率：

$
  P(A_m)     & = 1 / (n + 1) \
  P(B_k|A_m) & = (m / n)^k \
$

根据全概率公式，得到

$
  P(B_k) = sum_(m=0)^n P(A_m) dot P(B_k | A_m) = (sum_(m=0)^n m^k) / ((n+1) n^k)
$

所以，

$
  P(A_n | B_k) = (P(A_n) dot P(B_k | A_n)) / P(B_k) = n^k / (sum_(m=0)^n m^k)
$

= 习题 2-1

== 1

=== 1

不可以作为某一随机变量的分布函数，因为函数 $F$ 在 $(0, +oo)$ 上递减。

=== 2

不可以作为某一随机变量的分布函数，因为函数 $F$ 在 $(0, +oo)$ 上递减。

=== 3

取函数 $ G(x) = cases(F(x)& ", " x < 0, 1& ", " 0 <= x) $

可以作为某一变量的分布函数，因为函数 $G$ 非递减、右连续，且 $lim_(x->-oo) G(x) = 0$、$lim_(x->+oo) G(x) = 1$。

== 2

因为分布函数右连续，所以 $ a + b = 0 $

因为分布函数非递减，所以 $ b < 0 $

因为$lim_(x->oo) F(x) = 1$，所以 $ a = 1 $

综上，$ cases(a = 1, b = -1) $

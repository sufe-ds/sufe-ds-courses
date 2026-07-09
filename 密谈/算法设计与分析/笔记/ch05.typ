#import "util.typ": *

= 第五章 分治

== 5.1 首个递推：归并排序算法（A First Recurrence: The Mergesort Algorithm）

=== 归并排序回顾

*归并排序（mergesort）* 是分治策略的经典例子。其核心思想：将长度为 $n$ 的数组分成两半，递归地对每半排序，然后将两个有序半合并为一个有序数组。

*Python 实现：*

```python
def merge_sort(A):
    """归并排序"""
    n = len(A)
    if n <= 1:
        return A
    m = n // 2
    B = merge_sort(A[:m])
    C = merge_sort(A[m:])
    D = merge(B, C)  # 合并两个有序数组
    return D
```

合并过程 `Merge(B, C)` 使用两个指针分别扫描 $B$ 和 $C$，每次取较小者输出，总时间 $O(n)$。

=== 递推关系的建立

记 $T(n)$ 为归并排序在最坏情况下的比较次数。当 $n$ 为 2 的幂时，算法将规模为 $n$ 的问题分解为两个规模为 $n/2$ 的子问题，合并开销为 $n$，故有：

$
T(n) = cases(
  1 "n = 2",
  2 T(n/2) + n "n > 2, 且 n 为 2 的幂"
)
$

更一般地，单向不等式 $T(n) <= 2 T(n/2) + n$ 对任意 $n$ 成立，但为简化分析，通常假设 $n$ 为 2 的幂。

=== 求解方法一：递归树法（Recursion Tree）

递归树法将递推式逐层展开，然后对所有层的代价求和。

将 $T(n) <= 2 T(n/2) + n$ 展开：

- 第 0 层（根）：1 个问题，规模 $n$，代价 $n$。
- 第 1 层：2 个问题，规模 $n/2$，每个代价 $n/2$，总计 $2 times (n/2) = n$。
- 第 2 层：4 个问题，规模 $n/4$，每个代价 $n/4$，总计 $4 times (n/4) = n$。
- $...$
- 第 $i$ 层：$2^i$ 个问题，每个规模 $n / 2^i$，每个代价 $n / 2^i$，总计 $2^i times (n / 2^i) = n$。

共有 $log_2 n$ 层（因为树高为 $log_2 n$）。每层代价均为 $n$，故总代价：

$ T(n) = n dot log_2 n = O(n log n) $

=== 求解方法二：代入替换法（Substitution / Telescoping）

此法通过反复代入递推式来获得一个级数公式。

$
T(n) <= 2 T(n/2) + n \
= 2 ( 2 T(n/4) + n/2 ) + n \
= 4 T(n/4) + n + n \
= 8 T(n/8) + n + n + n \
= ... \
= 2^k T(n / 2^k) + k n
$

令 $k = log_2 n$ 使 $n / 2^k = 1$，得 $T(1) = 1$，于是：

$ T(n) <= n dot T(1) + n log_2 n = n + n log_2 n = O(n log n) $

=== 求解方法三：数学归纳法（Induction）

*猜想。* $T(n) <= c n log_2 n$ 对某常数 $c > 0$ 和所有 $n >= 2$ 成立。

*归纳基础。* $n = 2$ 时，$T(2) <= 2 T(1) + 2 = 4$，而 $c dot 2 log_2 2 = 2c$，取 $c >= 2$ 即成立。

*归纳步骤。* 设对 $n/2$ 成立，即 $T(n/2) <= c (n/2) log_2 (n/2)$。代入递推：

$
T(n) <= 2 T(n/2) + n \
<= 2 ( c (n/2) log_2 (n/2) ) + n \
= c n (log_2 n - 1) + n \
= c n log_2 n - c n + n \
<= c n log_2 n quad ("取 " c >= 1)
$

故 $T(n) = O(n log n)$。

三种方法给出相同结论：

#box(stroke: 1pt + black, inset: 6pt, $T(n) = O(n log n)$)

=== 一般化：形如 $T(n) <= a T(n/b) + f(n)$ 的递推

归并排序的递推 $T(n) <= 2 T(n/2) + n$ 可推广为更一般的形式：

$ T(n) <= a T(n/b) + f(n) $

其中 $a >= 1$ 表示子问题个数，$b > 1$ 表示每次划分后问题规模的缩减因子，$f(n)$ 表示分解与合并的代价。此类递推统称为*分治递推（divide-and-conquer recurrence）*，其常用求解工具为*主定理（Master Theorem）*。本章后续各节的算法均可纳入此框架。

== 5.3 逆序对计数（Counting Inversions）

=== 问题定义

给定长度为 $n$ 的数组 $A$，其中元素互异。若 $i < j$ 且 $A[i] > A[j]$，则称 $(i, j)$ 为一个*逆序对（inversion）*。要求计算数组中的逆序对总数。

*应用背景。* 逆序对的数量可用于度量两个排列的*相似度（similarity）*。例如，两个用户对同一组商品的偏好排名，其逆序对数量刻画了意见分歧的程度。若逆序对数为 0，则排名完全一致；逆序对数越大，分歧越大。

=== 分治算法设计

朴素算法逐一检查所有 $(i, j)$ 对，需 $O(n^2)$ 时间。利用分治可降至 $O(n log n)$。

算法结构与归并排序高度一致：

1. *分解。* 将数组 $A$ 平分为左半 $L$ 和右半 $R$。
2. *递归。* 分别计算 $L$ 和 $R$ 内部的逆序对数。
3. *合并。* 计算跨两半的逆序对数（即 $i in L$、$j in R$ 且 $A[i] > A[j]$），并与递归结果相加。

关键点在于合并阶段如何高效统计跨两半的逆序对。

=== 合并阶段：Merge-and-Count

在归并排序的合并过程中，当从左半取出一个元素 $L[i]$ 时，它不产生跨逆序对（因为 $i < j$ 且左半索引更小）。当从右半取出一个元素 $R[j]$ 时，左半中*尚未取出的所有元素*均大于 $R[j]$，因此每取一个右半元素，就产生 $("左半剩余元素数")$ 个跨逆序对。

*算法：Merge-and-Count(L, R)*

```python
def merge_and_count(L, R):
    """合并两个有序数组并统计逆序对"""
    i = j = 0
    count = 0
    merged = []
    # 双指针扫描
    while i < len(L) and j < len(R):
        if L[i] <= R[j]:
            merged.append(L[i])
            i += 1
        else:
            merged.append(R[j])
            j += 1
            # L[i:] 中所有元素均大于 R[j]
            count += len(L) - i
    # 收尾：将剩余元素全部加入 merged
    merged.extend(L[i:])
    merged.extend(R[j:])
    return merged, count
```

====== 完整代码

*算法：CountInversions(A)*

```python
def count_inversions(A):
    """统计数组 A 中的逆序对总数"""
    if len(A) <= 1:
        return A, 0
    m = len(A) // 2
    L, invL = count_inversions(A[:m])
    R, invR = count_inversions(A[m:])
    merged, invCross = merge_and_count(L, R)
    return merged, invL + invR + invCross
```

=== 复杂度分析

设 $T(n)$ 为对 $n$ 个元素的数组运行 `CountInversions` 的时间。分解为两个规模 $n/2$ 的子问题，`Merge-and-Count` 的时间与归并排序的合并相同，为 $O(n)$。故：

$ T(n) = 2 T(n/2) + O(n) $

与归并排序完全相同，解得 $T(n) = O(n log n)$。

== 5.4 最近点对（Finding the Closest Pair of Points）

=== 问题定义

给定平面上 $n$ 个点 $P = {p_1, ..., p_n}$，其中点 $p_i = (x_i, y_i)$。要求找出欧氏距离最近的一对点（即 $min_(i != j) norm(p_i - p_j)$）。

朴素算法逐一检查所有 $binom(n,2)$ 个点对，需 $O(n^2)$ 时间。本节给出 $O(n log n)$ 的分治算法。

=== 分治算法设计

*预处理。* 将点按 $x$ 坐标排序，得到数组 $P_x$；按 $y$ 坐标排序，得到数组 $P_y$。预处理排序 $O(n log n)$，后续算法对 $P_x$ 和 $P_y$ 操作。

1. *分解。* 取 $P_x$ 的中线 $L$（按 $x$ 坐标的中位数），将点分为左半 $Q$ 和右半 $R$，各约 $n/2$ 个点。
2. *递归。* 对 $Q$ 和 $R$ 分别调用算法，得到左右两半内部的最小距离 $delta_Q$ 和 $delta_R$，令 $delta = min(delta_Q, delta_R)$。
3. *合并。* 检查跨越中线 $L$ 的点对是否存在距离小于 $delta$ 者。

=== 合并阶段：$delta$-Strip 与关键引理

跨越中线的检查不能直接对 $n^2/4$ 个点对枚举，需借助以下观察：

*定义。* 设 $S$ 为 $P_x$ 中 $x$ 坐标与中线 $L$ 之距小于 $delta$ 的所有点构成的子集，即 $S = {p in P : |x(p) - x(L)| < delta}$。这一带状区域称为 *$delta$-strip*（$delta$ 带）。

显然，任何距离小于 $delta$ 的跨线点对都必须位于 $delta$-strip 内（否则其 $x$ 向距离已 $>= delta$，总距离不可能小于 $delta$）。

*关键引理。* 对 $delta$-strip 中的任意一点 $p$，最多只需检查 $S$ 中按 $y$ 坐标顺序紧随其后的 *7 个* 点（或更精确地，常数 $C = 15$ 个点），就足以找出所有距离小于 $delta$ 的点对。

*证明思路。* 将 $delta$-strip 划分为边长为 $delta/2$ 的正方形网格。每个方格内最多包含一个点（否则该方格内两点距离 $<= sqrt(2) dot delta/2 < delta$，与 $delta$ 定义矛盾）。$p$ 之后可能产生距离 $< delta$ 的点只能落在邻近的常数个方格内，故只需检查常数个后续点。

基于此引理，合并步骤的 Python 实现为：

```python
def dist(p1, p2):
    """计算两点间欧氏距离"""
    return ((p1[0] - p2[0])**2 + (p1[1] - p2[1])**2)**0.5


def brute_force_closest(points):
    """暴力计算最近点对（n <= 3 时使用）"""
    min_dist = float('inf')
    best = (None, None)
    for i in range(len(points)):
        for j in range(i + 1, len(points)):
            d = dist(points[i], points[j])
            if d < min_dist:
                min_dist = d
                best = (points[i], points[j])
    return best[0], best[1], min_dist


def closest_pair(P_x, P_y):
    """分治求最近点对，返回 (p1, p2, min_dist)"""
    n = len(P_x)
    if n <= 3:
        return brute_force_closest(P_x)

    # 分解：取 P_x 的中位数 x 坐标，划分左右
    mid = n // 2
    x_mid = P_x[mid][0]
    Q_x = P_x[:mid]
    R_x = P_x[mid:]
    # 按 y 序将点分入左右两半
    Q_y = [p for p in P_y if p[0] <= x_mid]
    R_y = [p for p in P_y if p[0] > x_mid]

    # 递归
    q0, q1, delta_Q = closest_pair(Q_x, Q_y)
    r0, r1, delta_R = closest_pair(R_x, R_y)
    if delta_Q < delta_R:
        delta = delta_Q
        best_pair = (q0, q1)
    else:
        delta = delta_R
        best_pair = (r0, r1)

    # 合并：构建 delta-strip（保持 y 序）
    S_y = [p for p in P_y if abs(p[0] - x_mid) < delta]

    # 在 S_y 中检查每个点与其后最多 7 个点
    for i in range(len(S_y)):
        for j in range(1, min(8, len(S_y) - i)):
            d = dist(S_y[i], S_y[i + j])
            if d < delta:
                delta = d
                best_pair = (S_y[i], S_y[i + j])

    return best_pair[0], best_pair[1], delta
```

=== 复杂度分析

递归部分：$T(n) = 2 T(n/2) + O(n)$。合并阶段中，$S_y$ 的构造可在 $O(n)$ 时间内完成（利用 $P_y$ 的序），每个点最多检查 7 个后续点。故合并时间为 $O(n)$。

解得 $T(n) = O(n log n)$。加上预排序的 $O(n log n)$，总时间 $O(n log n)$。

== 5.5 整数乘法（Integer Multiplication）

=== 问题定义

给定两个 $n$ 位的二进制整数 $x$ 和 $y$，计算它们的乘积 $x dot y$。

=== 小学乘法（Grade-School Multiplication）

传统竖式乘法将每一位与另一数的所有位相乘并对齐相加，需 $O(n^2)$ 次位操作。这是 $O(n^2)$ 的算法。

=== 朴素分治整数乘法

将每个 $n$ 位整数按高位和低位各 $n/2$ 位拆分。设 $n$ 为 2 的幂（否则可补前导零）：

$ x = x_1 dot 2^(n/2) + x_0,quad y = y_1 dot 2^(n/2) + y_0 $

其中 $x_1$、$x_0$、$y_1$、$y_0$ 均为 $n/2$ 位数。

于是：

$ x y = (x_1 dot 2^(n/2) + x_0)(y_1 dot 2^(n/2) + y_0) = x_1 y_1 dot 2^n + (x_1 y_0 + x_0 y_1) dot 2^(n/2) + x_0 y_0 $

直接计算需 4 次 $n/2$ 位的子乘法（$x_1 y_1$、$x_1 y_0$、$x_0 y_1$、$x_0 y_0$），每次子乘法递归，加上 $O(n)$ 的加法和移位操作。递推式为：

$ T(n) = 4 T(n/2) + O(n) $

用递归树展开：第 $i$ 层有 $4^i$ 个问题，每个规模 $n/2^i$，层数 $log_2 n$，总代价：

$ T(n) = sum_(i=0)^(log_2 n - 1) 4^i dot O(n / 2^i) = n sum_(i=0)^(log_2 n - 1) 2^i = O(n^2) $

与小学乘法相比没有改进。

=== Karatsuba 算法

*Karatsuba 算法（Karatsuba algorithm）* 通过减少子乘法次数来突破 $O(n^2)$ 瓶颈。其核心思想如下。

仍然拆分 $x = x_1 2^(n/2) + x_0$、$y = y_1 2^(n/2) + y_0$，但仅需计算以下 3 次 $n/2$ 位乘法：

1. $p_1 = x_1 y_1$
2. $p_2 = x_0 y_0$
3. $p_3 = (x_1 + x_0)(y_1 + y_0)$

然后：

$ x y = p_1 dot 2^n + (p_3 - p_1 - p_2) dot 2^(n/2) + p_2 $

验证：$p_3 - p_1 - p_2 = (x_1 + x_0)(y_1 + y_0) - x_1 y_1 - x_0 y_0 = x_1 y_0 + x_0 y_1$，恰好为中间交叉项。

*算法 Python 实现：*

```python
def karatsuba(x, y, n):
    """Karatsuba 快速整数乘法"""
    if n == 1:
        return x * y
    m = (n + 1) // 2  # ceil(n/2)
    # 拆分高低位
    x1 = x >> m       # 高 m 位
    x0 = x & ((1 << m) - 1)  # 低 m 位
    y1 = y >> m
    y0 = y & ((1 << m) - 1)
    # 3 次递归乘法
    p1 = karatsuba(x1, y1, m)
    p2 = karatsuba(x0, y0, m)
    p3 = karatsuba(x1 + x0, y1 + y0, m)
    # 组合结果
    return (p1 << (2 * m)) + ((p3 - p1 - p2) << m) + p2
```

=== 递推分析与复杂度

子问题规模为 $n/2$（或向上取整），共 3 个子问题，分解与组合含常数次 $O(n)$ 运算（加法、移位）。故：

$ T(n) <= 3 T(n/2) + O(n) $

==== 递归树求解

展开递归树：

- 第 0 层：1 个问题，代价 $c n$。
- 第 1 层：3 个问题，每个代价 $c dot n/2$，总计 $3 dot c dot n/2 = c n dot (3/2)$。
- 第 2 层：9 个问题，每个代价 $c dot n/4$，总计 $c n dot (3/2)^2$。
- $...$
- 第 $i$ 层：$3^i$ 个问题，每个代价 $c dot n / 2^i$，总计 $c n dot (3/2)^i$。

树高 $h = log_2 n$，最后一层 $3^(log_2 n) = n^(log_2 3)$ 个叶节点，每个代价 $O(1)$。

求各层总和：

$ T(n) = c n sum_(i=0)^(log_2 n - 1) (3/2)^i + O(n^(log_2 3)) $

等比级数求和：

$ sum_(i=0)^(k-1) (3/2)^i = ((3/2)^k - 1) / (3/2 - 1) = 2 ((3/2)^k - 1) $

代入 $k = log_2 n$，$(3/2)^(log_2 n) = n^(log_2 (3/2)) = n^(log_2 3 - 1)$，故：

$ T(n) = O(n dot n^(log_2 3 - 1)) = O(n^(log_2 3)) $

==== 替换法验证

*猜想。* $T(n) <= c n^(log_2 3)$。代入递推：

$
T(n) <= 3 c (n/2)^(log_2 3) + O(n) \
= 3 c dot n^(log_2 3) / 2^(log_2 3) + O(n) \
= 3 c dot n^(log_2 3) / 3 + O(n) \
= c n^(log_2 3) + O(n)
$

对充分大的 $n$，$O(n)$ 项可被 $c n^(log_2 3)$ 吸收，故归纳成立。

=== 结论

#box(stroke: 1pt + black, inset: 6pt, $T(n) = O(n^(log_2 3)) approx O(n^(1.585))$)

Karatsuba 算法通过将 4 次子乘法减少为 3 次，实现了优于 $O(n^2)$ 的整数乘法。这一思想是分治优化的经典范例，也是更高效的乘法算法（如 Toom-Cook、FFT 乘法）的基础。

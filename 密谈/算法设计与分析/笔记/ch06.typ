#import "util.typ": *

= 第六章 动态规划

本章介绍*动态规划（dynamic programming, DP）*，一种通过将问题拆分为重叠子问题并递推求解的算法设计范式。核心思想是：定义子问题、写出递推关系、确定计算顺序（自顶向下记忆化或自底向上迭代）、重构最优解。递推关系的建立是本章核心。

== 6.1 加权区间调度（Weighted Interval Scheduling）

=== 问题定义

*加权区间调度（weighted interval scheduling）*：给定 $n$ 个区间，每个区间 $i$ 有起始时间 $s_i$、结束时间 $f_i$、*权重（weight）* $w_i > 0$。区间 $i$ 和 $j$ 如果 $(s_i, f_i)$ 与 $(s_j, f_j)$ 没有重叠（即 $f_i <= s_j$ 或 $f_j <= s_i$），则称它们*兼容（compatible）*。目标：选择一个两两兼容的区间子集，最大化所选区间的权重之和。

=== 预处理

先将所有区间按结束时间排序，使 $f_1 <= f_2 <= ... <= f_n$。定义 $p(j)$ 为小于 $j$ 且与区间 $j$ 兼容的最大区间下标：

$ p(j) = max { i | i < j, f_i <= s_j } $

若不存在这样的 $i$，则 $p(j) = 0$。

=== 子问题定义

$"OPT"(j)$ = 前 $j$ 个区间（即区间 $1, 2, ..., j$）中加权区间调度的最优解。

=== 递推关系

考虑区间 $j$：要么选择它，要么不选。

- 若选 $j$，则必须舍弃所有与 $j$ 不兼容的区间（即下标大于 $p(j)$ 的区间），最优值为 $w_j + "OPT"(p(j))$；
- 若不选 $j$，则最优值为 $"OPT"(j-1)$。

因此：

$ "OPT"(j) = cases(
  0 & "if " j = 0,
  max(w_j + "OPT"(p(j)), "OPT"(j-1)) & "if " j > 0
) $

=== 自顶向下：递归 + 记忆化（Memoization）

*记忆化（memoization）*：将递归计算结果存入数组，避免重复计算同一子问题。

```python
def weighted_interval_sched_rec(j, M, w, p):
    """递归 + 记忆化：求解前 j 个区间的最优权重"""
    if j == 0:
        return 0
    if M[j] is not None:            # 已计算，直接返回
        return M[j]
    # 选择区间 j 或不选，取较大值
    M[j] = max(w[j] + weighted_interval_sched_rec(p[j], M, w, p),
               weighted_interval_sched_rec(j - 1, M, w, p))
    return M[j]
```

主程序：创建 $M[0..n]$ 并初始化为 `nil`，调用 `WeightedIntervalSched-Rec(n)`。

=== 自底向上：迭代（6.2 内容融入）

递归 + 记忆化与自底向上迭代在本质上等价——都保证了每个子问题只求解一次。区别在于计算方向：递归由大到小触发（`OPT(n)` 需要 `OPT(p(n))` 和 `OPT(n-1)`），迭代则按 $j$ 从小到大顺序填充数组。

```python
def weighted_interval_sched_iter(n, w, p):
    """自底向上迭代：按 j 从小到大填充 DP 数组"""
    M = [0] * (n + 1)
    for j in range(1, n + 1):
        M[j] = max(w[j] + M[p[j]], M[j - 1])
    return M[n]
```

*计算顺序*：按 $j = 1, 2, ..., n$ 递增填充。

=== 解的重构（Solution Reconstruction）

数组 $M$ 仅记录最优值。要重构最优解对应的区间集合，可回溯递推过程：

```python
def find_solution(j, M, w, p):
    """回溯重构：输出被选中的区间"""
    if j == 0:
        return
    if w[j] + M[p[j]] >= M[j - 1]:
        print(f"选取区间 {j}")      # 输出区间 j
        find_solution(p[j], M, w, p)
    else:
        find_solution(j - 1, M, w, p)
```

当 $w_j + M[p(j)] >= M[j-1]$ 时区间 $j$ 被选中，递归至 $p(j)$；否则跳过 $j$，递归至 $j-1$。

=== 复杂度分析

- 排序：$O(n log n)$
- 计算 $p(j)$：对每个 $j$ 二分查找，$O(n log n)$；或利用有序性质双指针线性完成，$O(n)$
- DP 主循环：$O(n)$
- 解重构：$O(n)$
- 总计：$O(n log n)$

== 6.3 分段最小二乘法：多路选择（Segmented Least Squares）

=== 问题定义

给定平面上的 $n$ 个点 $(x_1, y_1), (x_2, y_2), ..., (x_n, y_n)$（按 $x$ 坐标递增排列）。*最小二乘法（least squares）*：找一条直线 $y = a x + b$ 最小化平方误差：

$ "Error"(L) = sum_{i=1}^n (y_i - a x_i - b)^2 $

给定一组点，最优直线的参数可由公式直接计算，误差记为 $e$。

若单个直线无法很好地拟合所有点，可引入*分段线性拟合（segmented linear fitting）*：将点序列划分为若干*段（segment）*，每段分别用一条直线拟合。目标是最小化总误差与段数惩罚的加权和：

$ "最小化 " sum_{k=1}^K ("本段拟合误差") + c dot K $

其中 $c > 0$ 是每增加一段的惩罚系数（由用户设定）。

=== 子问题定义

设点按 $x$ 坐标编号 $1, ..., n$。令 $e_{i,j}$ 表示点 $i, i+1, ..., j$ 用最优直线拟合的平方误差。

$"OPT"(j)$ = 前 $j$ 个点（点 $1..j$）的最优分段方案的代价（误差 + 惩罚）。

=== 递推关系

考虑最后一段 $[i, j]$（即点 $i$ 到 $j$），则前 $i-1$ 个点的最优代价为 $"OPT"(i-1)$。于是：

$ "OPT"(j) = min_{1 <= i <= j} ( e_{i,j} + c + "OPT"(i-1) ) $

其中 $"OPT"(0) = 0$。

这是一个*多路选择（multi-way choice）*问题——每一步需要在 $n$ 种可能的"最后一段起点"中选择最优。

=== 算法伪代码

```python
def segmented_least_squares(n, c, points):
    """分段最小二乘法：多路选择 DP"""
    # 预处理：计算所有 e[i][j]（点 i..j 的最优直线拟合误差）
    e = [[0.0] * (n + 1) for _ in range(n + 1)]
    for j in range(1, n + 1):
        for i in range(1, j + 1):
            # 用点 i..j 拟合最优直线，计算误差
            e[i][j] = compute_error(points, i, j)

    M = [0] * (n + 1)
    for j in range(1, n + 1):
        M[j] = min(e[i][j] + c + M[i - 1] for i in range(1, j + 1))

    return M[n]
```

*解重构*：记录每个 $M[j]$ 取得最小值时的 $i$（分割点），回溯即可得到分段方案。

=== 复杂度分析

- 计算 $e_{i,j}$：对每对 $(i,j)$ 计算拟合误差需要 $O(j-i+1)$，总时间 $O(n^3)$。
- *优化*：可通过递推增量式更新分子分母，将 $e_{i,j}$ 的计算均摊为 $O(1)$，从而将预处理降为 $O(n^2)$，DP 主循环 $O(n^2)$。总复杂度 $O(n^2)$。
- 空间：$O(n^2)$ 存储 $e_{i,j}$，或 $O(n)$ 在线计算。

== 6.4 子集和与背包：添加一个变量（Subset Sums and Knapsacks）

=== 问题定义

*0-1 背包（0-1 knapsack）*问题：有 $n$ 个物品，物品 $i$ 有*重量（weight）* $w_i$ 和*价值（value）* $v_i$。给定容量 $W$ 的背包，选择物品子集，使得总重量不超过 $W$，且总价值最大。每个物品最多选一次（0-1 性质）。

=== 关键观察

贪心（按单位重量价值）不一定最优。需要引入*容量*作为一个额外维度——*添加一个变量*是动态规划力量的关键体现。

=== 子问题定义

$"OPT"(i, w)$ = 考虑前 $i$ 个物品（$1, 2, ..., i$），在容量 $w$ 下的最大总价值。

=== 递推关系

对物品 $i$，要么不选，要么选（前提是容量允许）：

$ "OPT"(i, w) = cases(
  0 & "if " i = 0 " or " w = 0,
  "OPT"(i-1, w) & "if " w_i > w,
  max("OPT"(i-1, w), v_i + "OPT"(i-1, w - w_i)) & "otherwise"
) $

=== 算法伪代码

```python
def knapsack_01(n, W, w, v):
    """0-1 背包：二维 DP 表"""
    # M[i][weight] 表示前 i 个物品在容量 weight 下的最大价值
    M = [[0] * (W + 1) for _ in range(n + 1)]
    for i in range(1, n + 1):
        for weight in range(1, W + 1):
            if w[i] > weight:
                M[i][weight] = M[i - 1][weight]
            else:
                M[i][weight] = max(M[i - 1][weight],
                                   v[i] + M[i - 1][weight - w[i]])
    return M[n][W]
```

*计算顺序*：按 $i$ 从 1 到 $n$，对每个 $i$ 按 $w$ 从 0 到 $W$ 递增填充。

*解重构*：从 $M[n, W]$ 回溯——若 $M[i, w] != M[i-1, w]$，说明物品 $i$ 被选中，左移重量 $w_i$ 后继续。

=== 复杂度分析

- 时间：$Theta(n W)$
- 空间：$Theta(n W)$；可优化至 $Theta(W)$（只保留上一行）
- *伪多项式（pseudo-polynomial）*：时间复杂度包含输入数值 $W$（而非输入位数），故是指数值在输入长度上的真正规模

=== 应用：子集和

*子集和（subset sum）*是背包的特殊形式：$v_i = w_i$，仅问是否能恰好达到某个总重量 $T$。递推式简化为布尔形式。

== 6.5 RNA 二级结构：区间上的动态规划（RNA Secondary Structure）

=== 问题背景

RNA 是由 $A、U、G、C$ 四种碱基（base）组成的单链核苷酸序列。碱基间可形成氢键配对：$A$ 与 $U$ 配对，$C$ 与 $G$ 配对（Watson-Crick 配对）。RNA 分子在空间中折叠形成*二级结构（secondary structure）*，即一组配对 $(i, j)$ 的集合。

=== 配对约束

一个合法的二级结构 $S$ 必须满足：

1. *Watson-Crick 配对*：$(i, j)$ 只能是 $(A,U)$、$(U,A)$、$(C,G)$、$(G,C)$ 之一。
2. *无交叉（non-crossing）*：若 $(i, j)$ 和 $(k, l)$ 均在 $S$ 中，则不可能出现 $i < k < j < l$（即配对间不相交，称为*平面性（planarity）*）。
3. *无尖锐弯折*：$|j - i| >= 4$（至少隔 4 个碱基才能配对，以允许形成空间环）。
4. 每个碱基最多参与一个配对。

目标：在合法结构中找到*最大配对数（maximum number of base pairs）*。

=== 子问题定义

$"OPT"(i, j)$ = 子序列 $b_i b_{i+1} ... b_j$ 中能形成的最大配对数（合法且无交叉）。

=== 递推关系

考虑最后一个碱基 $b_j$，要么不参与配对，要么与某个 $t$（$i <= t < j$）配对：

$ "OPT"(i, j) = max( "OPT"(i, j-1), max_{t: i <= t < j-4, " (b_t, b_j) 配对合法 " } ( 1 + "OPT"(i, t-1) + "OPT"(t+1, j-1) ) ) $

- $"OPT"(i, j-1)$：$b_j$ 不配对；
- 若 $b_j$ 与 $b_t$ 配对，则子问题分裂为两个独立子区间 $b_i..b_{t-1}$ 和 $b_{t+1}..b_{j-1}$（因为无交叉约束要求 $t$ 与 $j$ 配对后，两侧的区域不可相交）。

边界条件：若 $j - i < 4$，则 $"OPT"(i, j) = 0$。

=== 计算顺序

因子问题 $"OPT"(i, j)$ 依赖长度更短的子区间（$j-1-i$ 更小），应*按区间长度递增*计算：

```python
def rna_secondary_structure(n, b):
    """RNA 二级结构：区间 DP"""
    # OPT[i][j] 表示子序列 b[i..j] 的最大配对数（1-indexed）
    OPT = [[0] * (n + 1) for _ in range(n + 1)]

    # 长度 < 5 的区间无法配对（初始化边界条件）
    for i in range(1, n + 1):
        for j in range(i, min(i + 4, n) + 1):
            OPT[i][j] = 0

    # 按区间长度递增计算
    for k in range(5, n):                 # k = 区间长度
        for i in range(1, n - k + 1):
            j = i + k
            OPT[i][j] = OPT[i][j - 1]      # b[j] 不配对
            for t in range(i, j - 3):      # t <= j-4
                if can_pair(b[t], b[j]):   # (b[t], b[j]) 可配对
                    OPT[i][j] = max(OPT[i][j],
                                    1 + OPT[i][t - 1] + OPT[t + 1][j - 1])
    return OPT[1][n]
```

=== 复杂度分析

- 三层循环：区间长度 $O(n)$，区间起点 $O(n)$，尝试配对点 $O(n)$
- 时间：$O(n^3)$
- 空间：$O(n^2)$

== 6.6 序列比对（Sequence Alignment）

=== 问题定义

给定两个字符串（或序列）$X = x_1 x_2 ... x_m$ 和 $Y = y_1 y_2 ... y_n$。*序列比对（sequence alignment / edit distance）*是将两个序列通过插入*间隔（gap）*的方式写为两行等长字符串，以对齐相似字符。

*代价*：
- 若 $x_i$ 与 $y_j$ 对齐，代价为 $alpha_{x_i, y_j}$（通常匹配低、错配高）；
- 若某字符与间隔对齐，代价为 $delta$（间隔惩罚）。

目的：找到总代价最小的比对方案。

=== 子问题定义

$"OPT"(i, j)$ = 前缀 $x_1 x_2 ... x_i$ 和 $y_1 y_2 ... y_j$ 的最优比对代价。

=== 递推关系

考虑 $x_i$ 和 $y_j$ 的对应关系，有三种可能：

1. $x_i$ 与 $y_j$ 匹配：代价 $alpha_{x_i, y_j} + "OPT"(i-1, j-1)$；
2. $x_i$ 与间隔对齐：代价 $delta + "OPT"(i-1, j)$（$y_j$ 留出）；
3. $y_j$ 与间隔对齐：代价 $delta + "OPT"(i, j-1)$（$x_i$ 留出）。

$ "OPT"(i, j) = min cases(
  alpha(x_i, y_j) + "OPT"(i-1, j-1) & "匹配",
  delta + "OPT"(i-1, j) & "x_i 对间隔",
  delta + "OPT"(i, j-1) & "y_j 对间隔"
) $

边界条件：
- $"OPT"(0, 0) = 0$
- $"OPT"(i, 0) = i dot delta$（$i$ 个间隔）
- $"OPT"(0, j) = j dot delta$（$j$ 个间隔）

=== 算法伪代码

```python
def sequence_alignment(m, n, X, Y, alpha, delta):
    """序列比对（编辑距离）：二维 DP"""
    # M[i][j] 表示 X[1..i] 和 Y[1..j] 的最优比对代价
    M = [[0] * (n + 1) for _ in range(m + 1)]

    for i in range(m + 1):
        M[i][0] = i * delta
    for j in range(n + 1):
        M[0][j] = j * delta

    for i in range(1, m + 1):
        for j in range(1, n + 1):
            M[i][j] = min(alpha(X[i], Y[j]) + M[i - 1][j - 1],
                          delta + M[i - 1][j],
                          delta + M[i][j - 1])
    return M[m][n]
```

*计算顺序*：按 $i$ 从 1 到 $m$、$j$ 从 1 到 $n$ 双重循环。

*解重构*：从 $M[m,n]$ 回溯，根据 $M[i,j]$ 的来源决定对应关系。若回溯时 $i=0$ 或 $j=0$，则剩余字符依次对齐间隔。

=== 复杂度分析

- 时间：$Theta(m n)$
- 空间：$Theta(m n)$

=== 特殊形式：编辑距离

当 $alpha_{x,y} = 0$（字符相同），$alpha_{x,y} = 1$（字符不同），且 $delta = 1$ 时，序列比对退化为经典的*编辑距离（edit distance / Levenshtein distance）*。

== 6.7 线性空间的序列比对：分治法（Linear-Space Sequence Alignment）

=== 空间优化的动机

6.6 节算法需要 $Theta(m n)$ 空间。当 $m, n$ 很大时（如基因组比对，$m,n ~ 10^5$ 甚至更大），$O(m n)$ 空间不可行。本节介绍的*Hirschberg 算法*将空间降为 $O(m + n)$，同时保持时间 $O(m n)$。

=== 核心思想

*分治 + DP*：将问题沿 $X$ 的中间列拆分，通过前向和后向 DP 找到最优分割点 $q$，然后递归处理两个子问题。

=== 前向与后向 DP

定义两个与 $Y$ 前缀相关的 DP 数组：

- $f(i, j)$ = $"OPT"(i, j)$（即前 $i$ 个 $X$ 字符和前 $j$ 个 $Y$ 字符的最优比对代价），按 $i$ 递增计算
- $g(i, j)$ = 后缀 $x_{i+1}..x_m$ 和 $y_{j+1}..y_n$ 的最优比对代价，按 $i$ 递减计算

递推公式与序列比对完全相同，但方向相反。

*空间优化*：计算 $f$ 时只需保留上一行（$O(n)$ 空间）；计算 $g$ 时同理。

=== 算法框架

设 $X[1..m]$，$Y[1..n]$，$mid = floor(m/2)$。

1. 计算 $f(mid, j)$：对 $j = 0..n$，从前 $mid$ 个 $X$ 字符出发，用 $O(n)$ 空间计算第 $mid$ 行。
2. 计算 $g(mid, j)$：对 $j = 0..n$，从后 $m-mid$ 个 $X$ 字符出发（等价于在反向序列上做 DP），用 $O(n)$ 空间计算第 $mid$ 行。
3. 寻找分割点 $q$：选择使 $f(mid, q) + g(mid, q)$ 最小的 $q$（$0 <= q <= n$）。此 $q$ 对应最优比对中 $X_{mid}$ 两侧在 $Y$ 中的分割位置。
4. 递归求解：
   - 对 $X[1..mid]$ 和 $Y[1..q]$ 递归调用
   - 对 $X[mid+1..m]$ 和 $Y[q+1..n]$ 递归调用
5. 递归基：当 $m = 1$ 或 $n = 1$ 时直接按常规 DP 得到比对结果。

=== 伪代码

```python
def forward_dp_row(X, Y, delta, alpha):
    """前向 DP：返回 X[1..m] 与 Y[1..n] 对齐的最后一行（O(n) 空间）"""
    n = len(Y) - 1
    f = [j * delta for j in range(n + 1)]          # f(0, j)
    for i in range(1, len(X)):
        prev = f[0]                                 # 缓存 f(i-1, j-1)
        f[0] = i * delta                            # f(i, 0)
        for j in range(1, n + 1):
            temp = f[j]                             # 旧值 f(i-1, j)
            f[j] = min(alpha(X[i], Y[j]) + prev,
                       delta + f[j],                # f(i-1, j)
                       delta + f[j - 1])            # f(i, j-1)
            prev = temp
    return f


def backward_dp_row(X, Y, delta, alpha):
    """后向 DP：返回 X[1..m] 与 Y[1..n] 后缀对齐的最后一行（O(n) 空间）"""
    m, n = len(X) - 1, len(Y) - 1
    g = [(n - j) * delta for j in range(n + 1)]    # g(m, j): X 后缀已空
    for i in range(m - 1, -1, -1):
        prev = g[n]                                 # 缓存 g(i+1, j+1)
        g[n] = (m - i) * delta                      # g(i, n): Y 后缀已空
        for j in range(n - 1, -1, -1):
            temp = g[j]                             # 旧值 g(i+1, j)
            g[j] = min(alpha(X[i + 1], Y[j + 1]) + prev,
                       delta + g[j],                # g(i+1, j)
                       delta + g[j + 1])            # g(i, j+1)
            prev = temp
    return g


def hirschberg(X, Y, delta, alpha):
    """Hirschberg 算法：线性空间的序列比对（分治 + DP）"""
    m, n = len(X) - 1, len(Y) - 1                   # 1-indexed 长度

    # 递归基
    if m == 0:
        return [None] * n                            # n 个间隔
    if n == 0:
        return [None] * m                            # m 个间隔
    if m == 1 or n == 1:
        return direct_align(X, Y, delta, alpha)      # 直接计算

    mid = m // 2

    # 前向 DP：计算 X[1..mid] 与 Y 的前缀 DP 第 mid 行
    X_left = X[:mid + 1]               # [None, X[1], ..., X[mid]]
    f_row = forward_dp_row(X_left, Y, delta, alpha)

    # 后向 DP：计算 X[mid+1..m] 与 Y 的后缀 DP 第 mid 行
    X_right = [None] + X[mid + 1:]     # [None, X[mid+1], ..., X[m]]
    g_row = backward_dp_row(X_right, Y, delta, alpha)

    # 找分割点 q：使 f_row[q] + g_row[q] 最小
    q = min(range(n + 1), key=lambda j: f_row[j] + g_row[j])

    # 递归求解左右子问题
    left = hirschberg(X_left, Y[:q + 1], delta, alpha)
    right = hirschberg(X_right, [None] + Y[q + 1:], delta, alpha)
    return left + right
```

=== 正确性直觉

最优比对必然在 $X$ 中 $x_{mid}$ 处将比对分成左右两部分，且 $Y$ 被某个 $y_q$ 分隔（$q$ 可为 $0$ 或 $n$）。$f(mid, j)$ 是左半部分最优代价，$g(mid, j)$ 是右半部分最优代价，两者之和的最小值对应全局最优分割。

=== 复杂度分析

- 每层递归需计算 $f$ 和 $g$，各 $O(m n)$ 时间，但每层子问题规模减半
- 总时间：$T(m,n) = O(m n) + T(m/2, q) + T(m/2, n-q) => T(m,n) = O(m n)$
- 空间：每层递归使用 $O(n)$ 空间，递归深度 $O(log m)$，由函数栈帧复用后实际需求为 $O(m + n)$（两行数组）

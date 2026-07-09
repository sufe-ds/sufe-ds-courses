#import "util.typ": *

// ---- 数学运算符（用于伪代码变量）----
#let dist = math.op("dist")
#let setminus = math.op("\\")
#let cup = math.op("∪")
#let subset = math.op("⊂")
#let alpha = math.op("α")

// ============================================================
// 第四章 贪心算法
// ============================================================

= 第四章 贪心算法

贪心算法（greedy algorithm）在每一步决策时都选择当前看来最优的选择，不回溯。本章通过若干经典问题展示贪心策略的设计方法，并重点介绍两种核心正确性证明技巧——*贪心领先（stays ahead）*和*交换论证（exchange argument）*，以及基于*图结构性质（structural property）*的证明方法。

== 4.1 区间调度：贪心领先（Interval Scheduling: The Greedy Algorithm Stays Ahead）

=== 问题定义

设有 $n$ 个区间（interval），每个区间 $i$ 用起始时间 $s_i$ 和结束时间 $f_i$ 表示，满足 $s_i < f_i$。如果两个区间在时间上不重叠（即一个区间的结束时间不大于另一个的开始时间），则称它们是*兼容（compatible）*的。*区间调度问题（Interval Scheduling Problem）*的目标是选取尽可能多的两两兼容的区间。

=== 贪心策略与算法

*贪心策略：* 按结束时间递增的顺序处理区间，每次选取与已选区间兼容且结束时间最早的那个。

```python
def interval_scheduling(intervals):
    """区间调度：选取最大兼容子集"""
    # 输入: intervals = [(s1, f1), (s2, f2), ...]
    # 输出: 最大兼容子集 A

    # 1. 将所有区间按结束时间非递减排序
    intervals.sort(key=lambda x: x[1])

    # 2. 贪心选择
    selected = []         # 已选区间集合 A
    current_finish = 0    # 当前最后结束时间

    for s, f in intervals:
        if s >= current_finish:
            selected.append((s, f))
            current_finish = f

    return selected
```

*复杂度：* 排序 $O(n log n)$，单次扫描 $O(n)$，总计 $O(n log n)$。

=== 正确性证明：贪心领先（Stays Ahead）

正确性证明是本章的核心。此处使用的技巧是*贪心领先*：证明贪心算法选择的第 $r$ 个区间的结束时间不晚于任何最优解中第 $r$ 个区间的结束时间。从这一领先关系可导出贪心解不会比最优解差。

#theorem[
  区间调度贪心算法产生的解为最大兼容子集。
]

#proof[
  设贪心算法选择的区间依次为 $i_1, i_2, ..., i_k$，按结束时间非递减排序。设某最优解 $O = {j_1, j_2, ..., j_m}$，也按结束时间排序。

  用数学归纳法证明：对所有 $r <= k$，成立 $f(i_r) <= f(j_r)$。

  *归纳基础.* 由于贪心算法在所有区间中选取结束时间最早者，故 $f(i_1) <= f(j_1)$。

  *归纳步骤.* 假设 $f(i_{r-1}) <= f(j_{r-1})$。由于 $j_r$ 与 $j_{r-1}$ 兼容，有 $s(j_r) >= f(j_{r-1}) >= f(i_{r-1})$，故 $j_r$ 与 $i_1, ..., i_{r-1}$ 兼容。贪心算法在第 $r$ 步从所有与 $i_{r-1}$ 兼容的区间中选取结束时间最早者，因此 $f(i_r) <= f(j_r)$。

  由 $f(i_k) <= f(j_k)$ 可得 $k >= m$。假设 $m > k$，则 $j_{k+1}$ 存在，且 $s(j_{k+1}) >= f(j_k) >= f(i_k)$，故 $j_{k+1}$ 与 $i_k$ 兼容，与贪心算法终止条件矛盾。因此 $m <= k$，结合 $k >= m$ 得 $k = m$，贪心解是最优的。
]

注意：这一证明技巧的要点在于建立一个"领先"的归纳不变量，然后将该不变量转化为最优性结论。

== 4.2 最小化最大延迟调度：交换论证（Scheduling to Minimize Lateness: An Exchange Argument）

=== 问题定义

有一台单机（single machine）需处理 $n$ 个任务。每个任务 $i$ 有：
- *处理时间（processing time）* $t_i > 0$，
- *截止时间（deadline）* $d_i$。

一个*调度（schedule）*为每个任务指定一个起始时间 $S(i)$。设任务 $i$ 的*完成时间（completion time）*为 $C_i = S(i) + t_i$，其*延迟（lateness）*定义为 $L_i = max(0, C_i - d_i)$。目标是最小化*最大延迟（maximum lateness）* $L_max = max_i L_i$。

=== 贪心策略：最早截止时间优先（EDD）

*贪心策略（Earliest Deadline First, EDD）：* 按截止时间非递减顺序调度任务，即截止时间越早的任务越先执行。

```python
def minimize_lateness(tasks):
    """最小化最大延迟调度（EDD - Earliest Deadline First）"""
    # 输入: tasks = [(t_i, d_i), ...]  处理时间, 截止时间
    # 输出: 调度顺序（任务排列）

    # 1. 按截止时间非递减排序
    tasks.sort(key=lambda x: x[1])

    # 2. 按此顺序依次调度（无空闲时间）
    schedule = []
    current_time = 0
    max_lateness = 0

    for t, d in tasks:
        schedule.append((t, d))
        current_time += t
        lateness = max(0, current_time - d)
        max_lateness = max(max_lateness, lateness)

    return schedule, max_lateness
```

*复杂度：* 排序 $O(n log n)$。

=== 正确性证明：交换论证（Exchange Argument）

本节使用*交换论证*技术：从任意最优解出发，通过一系列不破坏最优性的"交换"操作，将其逐步转化为贪心解，从而证明贪心解也是最优的。

#lemma(name: "无空闲时间最优调度")[
  存在一个无空闲时间（no idle time）的最优调度。
]

#proof[
  若最优调度中有空闲时间，可将空闲之后的所有任务前移以填补空闲，各任务的完成时间均不增，因此最大延迟不增。重复该操作即得无空闲的最优调度。
]

#lemma(name: "逆序交换")[
  若一个调度中存在相邻的*逆序（inversion）*（即任务 $i$ 排在 $j$ 之前但 $d_i > d_j$），交换 $i$ 和 $j$ 的位置不会增加最大延迟。
]

#proof[
  设 $i$ 和 $j$ 是相邻的逆序对（即 $i$ 紧接在 $j$ 之前，且 $d_i > d_j$）。考虑交换 $i$ 和 $j$ 的位置。

  交换前，设 $i$ 的起始时间为 $S$，则 $C_i = S + t_i$，$C_j = S + t_i + t_j$。交换后，$j$ 先执行：$C_j' = S + t_j$，$i$ 随后：$C_i' = S + t_j + t_i$。

  比较交换前后的延迟变化：
  - 对 $j$：$C_j' < C_j$，完成时间提前，故延迟 $L_j' <= L_j$（不增）。
  - 对 $i$：完成时间延后，但 $d_i > d_j$，故
    $L_i' = max(0, C_i + t_j - d_i) <= max(0, C_j - d_j) = L_j$。
  因此交换后最大延迟未增加。
]

#theorem(name: "EDD 最优性")[
  EDD 调度（按截止时间排序）最小化最大延迟。
]

#proof[
  由引理 4.1 和引理 4.2 可得。从任意最优调度出发：① 消除所有空闲时间；② 反复交换相邻逆序对，每次交换不增加最大延迟。每次交换减少一个逆序对，经有限步后得到无空闲、无逆序的调度——这正是 EDD 调度。因此 EDD 调度的最大延迟不超过最优值，故 EDD 是最优的。
]

== 4.3 最优缓存：更复杂的交换论证（Optimal Caching: A More Complex Exchange Argument）

=== 问题定义

*缓存（cache）* 容量为 $k$，内存中有一系列数据项请求序列 $r_1, r_2, ..., r_n$。若请求时数据已在缓存中，则称为*命中（hit）*；否则为*缺失（miss）*，必须将该项调入缓存，若缓存已满则需*驱逐（evict）*一个现有项。目标是最小化缺失次数。

=== 贪心策略：最远未来（Farthest-in-Future）

*贪心策略（Farthest-in-Future, FF）：* 当需要驱逐时，选择缓存中其下一次请求发生最远的那个项（或永不再次请求的项）。

```python
def farthest_in_future(requests, k):
    """最远未来缓存策略（Farthest-in-Future）"""
    # 输入: requests = [r1, r2, ..., rn]  请求序列
    #       k = 缓存容量
    # 输出: 每次缺失时的驱逐决策

    cache = set()           # 当前缓存内容
    misses = []             # 记录缺失和驱逐

    for t, r in enumerate(requests):
        if r in cache:
            continue        # 命中
        # 缺失
        if len(cache) < k:
            cache.add(r)    # 缓存未满，直接加入
            misses.append(('miss', r, None))
        else:
            # 选择缓存中下一次请求最远的项
            def next_pos(e):
                try:
                    return requests.index(e, t + 1)
                except ValueError:
                    return float('inf')
            evict = max(cache, key=next_pos)
            cache.remove(evict)
            cache.add(r)
            misses.append(('miss', r, evict))

    return misses
```

=== 正确性证明思路

*归约调度（reduced schedule）* 是指仅在发生缺失且缓存已满时才执行驱逐操作的调度。任何调度都可以转化为一个"不早于原调度驱逐"的归约调度而不增加缺失次数。

*交换论证核心思路：* 设 $FF$ 为最远未来算法在某步所做的驱逐选择（驱逐 $f$），而 $O$ 为某个不同选择的最优归约调度（驱逐 $o$ 而非 $f$）。通过修改 $O$ 使其后续行为与 $FF$ 保持一致（即也驱逐 $f$），可以证明修改后的调度 $O'$ 的缺失次数不超过 $O$。对时间步骤归纳，可证明 $FF$ 是最优的。

核心观察：若 $O$ 在本次驱逐了 $o$ 而非 $f$，则在 $f$ 的下次请求（早于 $o$ 的下次请求）之前，$O$ 的缓存中同时含有 $o$ 和 $f$。令 $O'$ 在此步改为驱逐 $f$（与 $FF$ 一致），并保持 $o$ 在缓存中。除非 $o$ 在 $f$ 下次请求之前被再次驱逐，否则 $O'$ 的缺失数不会多于 $O$。经过恰当的调整，可证 $FF$ 的最优性。

== 4.4 图中最短路径（Shortest Paths in a Graph）

=== 问题定义

给定有向图 $G = (V, E)$，每条边 $e = (u, v)$ 有权重 $w_e >= 0$（非负权重）。源点 $s$ in $V$。目标：计算从 $s$ 到所有其他顶点的最短路径距离。

=== Dijkstra 算法

Dijkstra 算法维护一个*已确定最短距离*的顶点集合 $S$，以及每个顶点 $v$ 的*当前估计距离* $dist[v]$，初始 $dist[s] = 0$，其余为 $infinity$。每次从 $S$ 外选取 $dist$ 值最小的顶点 $u$，将其加入 $S$，然后对 $u$ 的所有出边 $(u, v)$ 执行*松弛（relaxation）*：若 $dist[u] + w(u, v) < dist[v]$，则更新 $dist[v]$。

```python
import heapq

def dijkstra(G, s):
    """Dijkstra 最短路径算法（非负权图）"""
    # 输入: G = 邻接表 {v: [(u, w), ...]}, w >= 0
    #       s = 源点
    # 输出: dist[v]  — s 到 v 的最短距离

    # 1. 初始化距离和优先队列
    dist = {v: float('inf') for v in G}
    dist[s] = 0
    visited = set()                 # 已确定最短距离的集合 S
    pq = [(0, s)]                   # 优先队列 (dist, vertex)

    # 2. 主循环
    while pq:
        d, u = heapq.heappop(pq)    # Extract-Min
        if u in visited:
            continue                # 过期条目，跳过
        visited.add(u)              # S ← S ∪ {u}

        # 3. 松弛 u 的所有出边
        for v, w in G[u]:
            if dist[u] + w < dist[v]:
                dist[v] = dist[u] + w
                heapq.heappush(pq, (dist[v], v))  # 相当于 Decrease-Key

    return dist
```

=== 正确性证明

#theorem(name: "Dijkstra 正确性")[
  对 Dijkstra 算法，当顶点 $u$ 从优先队列取出并加入 $S$ 时，$dist[u]$ 即为从 $s$ 到 $u$ 的最短路径距离。
]

#proof[
  用数学归纳法证明。设 $S$ 为已确定最短距离的顶点集合。

  *基础：* $S = {s}$ 时，$dist[s] = 0$ 正确。

  *归纳步骤：* 假设对 $S$ 中所有顶点，$dist$ 值均为真正的最短距离。考虑下一个被加入 $S$ 的顶点 $u$（即 $Q$ 中 $dist$ 最小的顶点）。

  由算法设计，$s$ 到 $u$ 的最短路径长度 $d(s, u) <= dist[u]$。现证 $dist[u] <= d(s, u)$。

  设 $P$ 为任意从 $s$ 到 $u$ 的最短路径。令 $(x, y)$ 为 $P$ 上第一条离开 $S$ 的边（即 $x$ in $S$，$y$ not in $S$，可能 $x = s$，$y = u$）。由归纳假设，$dist[x] = d(s, x)$。算法在处理 $x$ 时已对边 $(x, y)$ 执行松弛，故 $dist[y] <= dist[x] + w(x, y) = d(s, x) + w(x, y)$。因 $P$ 上 $s$ 到 $u$ 的距离为 $d(s, x) + w(x, y) + d(y, u)$ 且 $w >= 0$（路径后半段非负），故 $d(s, u) >= d(s, x) + w(x, y) >= dist[y]$。

  由于 $u$ 是 $S$ 外 $dist$ 最小的顶点，$dist[u] <= dist[y] <= d(s, u)$。又 $dist[u] >= d(s, u)$ 始终成立，故 $dist[u] = d(s, u)$。
]

=== 复杂度分析

使用二叉堆（binary heap）实现优先队列：
- `Extract-Min` 每次 $O(log n)$，共 $n$ 次：$O(n log n)$。
- `Decrease-Key` 每次 $O(log n)$，每条边最坏情况执行一次：$O(m log n)$。
- 总复杂度 $O((m + n) log n) = O(m log n)$（当 $m >= n$）。

若使用 Fibonacci 堆，可降至 $O(m + n log n)$，但实践中二叉堆通常已足够。

== 4.5 最小生成树问题（The Minimum Spanning Tree Problem）

=== 问题定义

给定无向连通图 $G = (V, E)$，每条边 $e$ 有权重 $w_e$。*生成树（spanning tree）* $T$ 是 $G$ 的一个包含全部顶点的无环连通子图。*最小生成树（Minimum Spanning Tree, MST）* 是在所有生成树中总权重 $sum_{e in T} w_e$ 最小的那棵。

=== 两个核心性质

正确性证明基于两个关键结构性质。

=== 割性质（Cut Property）

#theorem(name: "割性质")[
  对任意割 $(S, V setminus S)$（其中 $S subset V$ 非空且 $S != V$），若边 $e = (u, v)$ 是横跨该割的权重最小的边，则 $e$ 属于某棵最小生成树。
]

#proof[
  设 $T$ 是某棵 MST，假设 $e$ not in $T$。由于 $T$ 连通，将 $e$ 加入 $T$ 会形成环 $C$。环 $C$ 必包含另一条横跨同一割 $(S, V setminus S)$ 的边 $e'$（因为 $e$ 连接 $S$ 和 $V setminus S$，$C$ 需要返回原侧）。由 $e$ 的最小性，$w_e <= w_{e'}$。构造 $T' = T setminus {e'} cup {e}$，则 $T'$ 仍为生成树且总权重 $w(T') <= w(T)$。由于 $T$ 是最小生成树，$w(T') = w(T)$，故 $T'$ 也是 MST，且 $e$ in $T'$。
]

=== 环性质（Cycle Property）

#theorem(name: "环性质")[
  对任意环 $C$，若边 $e$ 是 $C$ 上权重最大的边，则 $e$ 不属于任何最小生成树。
]

#proof[
  假设 $T$ 是某棵 MST 且 $e$ in $T$。从 $T$ 中删除 $e$ 会将 $T$ 分成两个连通分量，构成一个割。环 $C$ 中除 $e$ 外至少还有一条边 $e'$ 横跨该割（因 $C$ 包含 $e$ 且 $C$ 是环）。由 $e$ 的最大性，$w_{e'} <= w_e$。构造 $T' = T setminus {e} cup {e'}$，则 $T'$ 仍为生成树且 $w(T') <= w(T)$。但 $T$ 是 MST，故 $w(T') = w(T)$，即 $w_{e'} = w_e$，$T'$ 也是 MST 且不含 $e$。无论如何，存在不含 $e$ 的 MST。
]

=== 三种经典算法

以下三种算法分别基于上述性质。

==== Kruskal 算法

*策略：* 以递增顺序遍历所有边，若当前边连接两个不同连通分量则加入，否则丢弃。基于*割性质*：每次加入的边是连接两个分量之间权重最小的边。

```python
def kruskal(vertices, edges):
    """Kruskal 最小生成树算法"""
    # 输入: vertices = [v1, v2, ...]  顶点列表
    #       edges   = [(u, v, w), ...]  边及其权重
    # 输出: MST 边集

    # 1. 将所有边按权重非递减排序
    edges = sorted(edges, key=lambda e: e[2])

    # 2. 初始化并查集
    parent = {v: v for v in vertices}
    rank   = {v: 0 for v in vertices}

    def find(x):
        """路径压缩查找"""
        if parent[x] != x:
            parent[x] = find(parent[x])
        return parent[x]

    def union(x, y):
        """按秩合并"""
        rx, ry = find(x), find(y)
        if rx == ry:
            return
        if rank[rx] < rank[ry]:
            parent[rx] = ry
        elif rank[rx] > rank[ry]:
            parent[ry] = rx
        else:
            parent[ry] = rx
            rank[rx] += 1

    # 3. 贪心选择边
    mst = []
    for u, v, w in edges:
        if find(u) != find(v):        # u 和 v 在不同分量中
            mst.append((u, v, w))     # T ← T ∪ {(u, v)}
            union(u, v)               # 合并两个分量

    return mst
```

*复杂度：* 排序 $O(m log m)$，并查集操作 $O(m alpha(n))$，总 $O(m log m)$。

==== Prim 算法

*策略：* 从单个顶点开始，不断加入连接当前树（$S$）与树外顶点（$V setminus S$）的最小权重边。基于*割性质*：每次加入的边是横跨割 $(S, V setminus S)$ 的最小边。

```python
import heapq

def prim(G, start=None):
    """Prim 最小生成树算法"""
    # 输入: G = 邻接表 {v: [(u, w), ...]}  无向图
    # 输出: MST 边集 {(v, parent[v])}

    # 1. 初始化
    if start is None:
        start = next(iter(G))         # 任选起点
    dist   = {v: float('inf') for v in G}   # v 到当前树的最小边权
    parent = {v: None for v in G}
    dist[start] = 0
    visited = set()                   # 已在树中的顶点 S
    pq = [(0, start)]                 # 优先队列 (dist, vertex)

    # 2. 主循环
    while pq:
        d, u = heapq.heappop(pq)      # Extract-Min
        if u in visited:
            continue
        visited.add(u)                # 将 u 加入树

        # 3. 更新邻居
        for v, w in G[u]:
            if v not in visited and w < dist[v]:
                dist[v] = w
                parent[v] = u
                heapq.heappush(pq, (w, v))  # Decrease-Key

    # 返回 MST 边集
    return {(v, parent[v]) for v in G if parent[v] is not None}
```

*复杂度：* 与 Dijkstra 类似，使用二叉堆 $O(m log n)$。

==== Reverse-Delete 算法

*策略：* 从包含所有边的图开始，按权重递减顺序遍历边，若当前边的删除不破坏连通性则删除，否则保留。基于*环性质*：每条被删除的边都是某环上的最大权边。

```python
def reverse_delete(vertices, edges):
    """Reverse-Delete 最小生成树算法"""
    # 输入: vertices = [v1, v2, ...]  顶点列表
    #       edges   = [(u, v, w), ...]  边及其权重
    # 输出: MST 边集

    # 1. 初始包含所有边，按权重非递增排序
    mst = set(edges)
    sorted_edges = sorted(edges, key=lambda e: e[2], reverse=True)

    def is_connected(edge_set):
        """判断 edge_set 是否连通所有顶点"""
        adj = {v: [] for v in vertices}
        for u, v, w in edge_set:
            adj[u].append(v)
            adj[v].append(u)
        # BFS / DFS
        visited = set()
        stack = [vertices[0]]
        while stack:
            u = stack.pop()
            if u in visited:
                continue
            visited.add(u)
            for v in adj[u]:
                if v not in visited:
                    stack.append(v)
        return len(visited) == len(vertices)

    # 2. 尝试删除权重最大的边（若不破坏连通性）
    for e in sorted_edges:
        mst.discard(e)               # T ← T \ {e}
        if not is_connected(mst):
            mst.add(e)               # 删除后不连通，保留

    return list(mst)
```

*复杂度：* 排序 $O(m log m)$，每次删除后连通性判定 $O(m + n)$（使用 BFS/DFS），总 $O(m log m + m(m + n)) = O(m^2)$，不如前两者高效。

=== 三个算法的统一视角

#table(
  columns: 4,
  align: (left, left, left, left),
  table.header([算法], [处理顺序], [决策], [依据性质]),
  [Kruskal], [权重递增], [添加], [割性质],
  [Prim], [树向外扩张], [添加], [割性质],
  [Reverse-Delete], [权重递减], [删除], [环性质],
)

== 4.6 实现 Kruskal 算法：并查集（Implementing Kruskal's Algorithm: The Union-Find Data Structure）

=== 问题背景

Kruskal 算法需要高效地维护图的连通分量集合，支持以下三种操作：
- `MakeSet(x)`：创建一个只包含 $x$ 的新集合。
- `Find(x)`：返回 $x$ 所在集合的*代表元素（representative）*。
- `Union(x, y)`：合并 $x$ 和 $y$ 所属的两个集合。

这三种操作组成了*并查集（Union-Find）*或称*不交并集（disjoint set）*数据结构。

=== 基本实现与优化

==== 朴素链表实现

每个集合用链表表示，`Find` 需 $O(n)$，`Union` 需 $O(n)$（需合并链表），效率低。

==== 树形表示（Tree Representation）

每个集合用一棵有根树表示，根节点为代表元素。`Find` 从给定节点沿父指针上行至根。

*按秩合并（Union by Rank）：* 合并时，将*秩（rank）*较小的树挂在秩较大的树的根下。秩是树高的上界。这样能保证树高为 $O(log n)$。

```python
class UnionFind:
    """并查集（按秩合并 + 路径压缩）"""

    def __init__(self, n):
        """MakeSet: 创建 n 个独立集合"""
        self.parent = list(range(n))   # parent[x] ← x
        self.rank   = [0] * n          # rank[x] ← 0

    def find(self, x):
        """Find: 返回 x 所在集合的代表元素（路径压缩）"""
        if self.parent[x] != x:        # if x != parent[x]
            self.parent[x] = self.find(self.parent[x])  # 路径压缩
        return self.parent[x]

    def union(self, x, y):
        """Union: 合并 x 和 y 所在集合（按秩合并）"""
        rx, ry = self.find(x), self.find(y)
        if rx == ry:
            return
        if self.rank[rx] < self.rank[ry]:
            self.parent[rx] = ry
        elif self.rank[rx] > self.rank[ry]:
            self.parent[ry] = rx
        else:
            self.parent[ry] = rx
            self.rank[rx] += 1
```

*路径压缩（Path Compression）：* 在执行 `Find` 时，将路径上每个节点的父指针直接指向根节点，使得后续 `Find` 几乎为常数时间。

=== 复杂度分析

同时使用按秩合并和路径压缩时，对任意 $m$ 次操作（包括 `MakeSet`），总运行时间为 $O(m alpha(m, n))$，其中 $alpha$ 是*反阿克曼函数（inverse Ackermann function）*，增长极慢（对任何实际输入规模，$alpha <= 4$），因此可视为*近乎常数（essentially constant）*。

#theorem(name: "Union-Find 复杂度")[
  在包含按秩合并和路径压缩优化的并查集中，任意 $m$ 次 `MakeSet`、`Find`、`Union` 操作的总时间复杂度为 $O(m alpha(m, n))$，其中 $n$ 为元素个数。
]

=== Kruskal 算法总复杂度

Kruskal 算法包含 $m$ 次边排序（$O(m log m)$）和 $O(m)$ 次并查集操作（$O(m alpha(m, n))$）。排序是支配项，总复杂度 $O(m log m)$。若边权范围较小可用计数排序，则可降至 $O(m alpha(m, n))$。

== 4.7 聚类（Clustering）

=== 问题定义

给定 $n$ 个对象及它们之间的*距离（distance）* $d(p, q)$（满足对称性和三角不等式，但三角不等式并非必需）。目标是将对象划分为 $k$ 个*簇（cluster）*，使得簇间的*间距（spacing）*最大化。簇 $C$ 与 $C'$ 之间的距离定义为 $d(C, C') = min_{p in C, q in C'} d(p, q)$。*最大间距聚类（maximum spacing clustering）*的目标是最大化所有不同簇间距离的最小值，即最大化 $min_{i != j} d(C_i, C_j)$。

=== 贪心解法

*贪心策略：* 将每个点初始化为独立的簇，然后反复合并距离最近的两个簇，直到剩下 $k$ 个簇。这正是 Kruskal 算法在聚类问题上的应用——运行 Kruskal 生成树算法，在第 $m - k + 1$ 条边加入后停止（即剩余 $k$ 个连通分量）。

```python
def max_spacing_clustering(points, k):
    """最大间距聚类（基于 Kruskal 算法）"""
    # 输入: points = [p1, p2, ..., pn]  点列表
    #       k = 目标簇数
    # 输出: k 个簇的划分

    n = len(points)

    # 1. 计算所有点对的距离，按非递减排序
    distances = []
    for i in range(n):
        for j in range(i + 1, n):
            d = abs(points[i] - points[j])  # 示例：欧氏距离
            distances.append((d, i, j))
    distances.sort(key=lambda x: x[0])

    # 2. 初始化并查集（每个点自成一簇）
    parent = list(range(n))
    rank   = [0] * n

    def find(x):
        if parent[x] != x:
            parent[x] = find(parent[x])
        return parent[x]

    def union(x, y):
        nonlocal cluster_count
        rx, ry = find(x), find(y)
        if rx == ry:
            return False
        if rank[rx] < rank[ry]:
            parent[rx] = ry
        elif rank[rx] > rank[ry]:
            parent[ry] = rx
        else:
            parent[ry] = rx
            rank[rx] += 1
        cluster_count -= 1
        return True

    cluster_count = n
    max_spacing = 0                     # 最终间距

    # 3. 贪心合并
    for d, i, j in distances:
        if cluster_count == k:          # 已得到 k 个簇
            break
        union(i, j)                     # 合并——簇数减 1
        max_spacing = d                 # 最后合并的边权即为间距

    # 4. 返回簇划分
    clusters = {}
    for i in range(n):
        root = find(i)
        clusters.setdefault(root, []).append(i)
    return list(clusters.values()), max_spacing
```

=== 正确性证明

#theorem(name: "最大间距聚类最优性")[
  上述贪心算法得到的 $k$-聚类具有最大可能的间距。
]

#proof[
  令贪心算法得到的 $k$ 个簇为 $C_1, C_2, ..., C_k$，其间距为 $d^*$（即算法恰好在还有 $k$ 个分量时停止时正在处理的边权）。设 $C^* = {C_1^*, ..., C_k^*}$ 为任意 $k$-聚类，其间距为 $d^{**}$。

  欲证 $d^{**} <= d^*$。假设 $d^{**} > d^*$，构造矛盾。

  贪心算法停止时，所有权重 $<= d^*$ 的边都已被处理，此时有 $k$ 个连通分量 $C_1, ..., C_k$。故在权重 $<= d^*$ 的边集 $E_{<= d^*}$ 上，$C_1, ..., C_k$ 正是连通分量，且不同 $C_i$ 和 $C_j$ 之间所有边的权重 $> d^*$。

  现考虑最优 $k$-聚类 $C^*$。若 $d^{**} > d^*$，则不同最优簇之间没有权重 $<= d^*$ 的边相连（否则间距会被 $d^*$ 限制）。因此在 $E_{<= d^*}$ 上，每个最优簇是若干 $C_i$ 的并集（即 $E_{<= d^*}$ 不能跨越最优簇边界）。但 $E_{<= d^*}$ 只有 $k$ 个连通分量，而最优簇也有 $k$ 个，由鸽巢原理，每个最优簇必须恰好等于一个 $C_i$。于是 $d^{**} = d^*$，与假设矛盾。

  故 $d^{**} <= d^*$，贪心解达到最大间距。
]

=== 算法实现

直接使用 Kruskal 算法的并查集实现，在第 $k$ 个连通分量形成时停止。具体地：
- 初始化：每个点自成一簇，共 $n$ 个。
- 按距离从小到大处理所有边。
- 每次 `Union` 操作将簇数减 1。
- 当簇数降至 $k$ 时停止，返回当前簇划分。此时最后的合并边权即最大间距 $d^*$。

*复杂度：* 与 Kruskal 相同，$O(m log m)$，其中 $m = binom(n, 2)$ 为所有点对距离数。

== 章节总结

本章通过七个经典问题展示了贪心算法的设计范式与证明方法：

#table(
  columns: 4,
  align: (left, left, left, left),
  table.header([问题], [贪心策略], [证明技巧], [复杂度]),
  [区间调度], [最早结束时间], [贪心领先（stays ahead）], [$O(n log n)$],
  [最小化最大延迟], [最早截止时间（EDD）], [交换论证（exchange argument）], [$O(n log n)$],
  [最优缓存], [最远未来（FF）], [交换论证], [在线最优],
  [最短路径], [Dijkstra], [归纳领先（dist 不变量）], [$O(m log n)$],
  [最小生成树], [Kruskal / Prim], [割性质 / 环性质], [$O(m log n)$],
  [并查集], [按秩合并 + 路径压缩], [平摊分析], [近 $O(1)$ 每次],
  [最大间距聚类], [Kruskal 停于 $k$ 簇], [鸽巢原理 + 间距比较], [$O(m log m)$],
)

贪心算法的核心设计思想是：寻找一个局部的、简单的决策准则，并借助合适的证明技巧（领先、交换、结构性质）证明该局部最优能导出全局最优。

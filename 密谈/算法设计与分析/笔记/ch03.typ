#import "util.typ": *

= 第三章 图

// 数学运算符（伪代码变量）
#let dist = math.op("dist")
#let visited = math.op("visited")
#let color = math.op("color")

== 3.1 基本定义与应用

=== 形式化定义

*图（graph）* 是一个二元组 $G = (V, E)$，其中 $V$ 是非空的*顶点（vertex）*集合，$E$ 是*边（edge）*的集合。图分为两类：

- *无向图（undirected graph）*：边是顶点对 $\{u, v\}$（无序），记作 $u v$ 或 $(u, v)$。
- *有向图（directed graph / digraph）*：边是*有向边（directed edge）* $(u, v)$，方向从 $u$ 指向 $v$。

=== 图的表示

设 $n = |V|$，$m = |E|$。

- *邻接矩阵（adjacency matrix）*：$n times n$ 的布尔矩阵 $A$，$A_{i j} = 1$ 当且仅当 $(i, j) in E$。无向图的邻接矩阵对称。空间复杂度 $Theta(n^2)$，适用于稠密图。
- *邻接表（adjacency list）*：为每个顶点 $v$ 维护一个链表或列表，存储其所有邻接点。无向图每条边存储两次。空间复杂度 $Theta(m + n)$，适用于稀疏图。

=== 基本概念

- *路径（path）*：顶点序列 $v_0, v_1, ..., v_k$ 满足 $(v_{i-1}, v_i) in E$。若各顶点互异，则称为*简单路径（simple path）*。
- *环（cycle）*：长度 $k >= 3$ 的路径 $v_0, v_1, ..., v_k$ 满足 $v_0 = v_k$ 且内部顶点互异。无环图称为*无环图（acyclic graph）*。
- *连通性（connectivity）*：无向图中 $u$ 与 $v$ 连通当且仅当存在 $u$-$v$ 路径。*连通分量（connected component）*是极大连通子图。
- *树（tree）*：连通无环的无向图。$n$ 个顶点的树恰有 $n - 1$ 条边，任意两顶点间存在唯一简单路径。
- *生成树（spanning tree）*：连通图 $G$ 的生成树是 $G$ 的一个包含全部顶点的无环连通子图。
- *根树（rooted tree）*：指定一个根节点（root）的树。可用父指针数组或孩子列表表示。

=== 应用概述

- *社交网络*：顶点代表人，边代表好友关系。
- *交通网络*：顶点代表城市或路口，边代表道路，权重可表示距离或通行时间。
- *依赖关系*：有向边表示任务间的依赖，如课程先修关系、软件包依赖。

== 3.2 图的连通性与图遍历

=== 广度优先搜索（BFS）

BFS 从源点 $s$ 出发，按距 $s$ 的边数由近及远逐层访问顶点。

*算法：BFS*

```python
from collections import deque

def bfs(G, s):
    # 初始化
    visited = {v: False for v in G}
    dist = {v: float('inf') for v in G}
    visited[s] = True
    dist[s] = 0
    Q = deque([s])
    while Q:
        u = Q.popleft()
        for v in G[u]:
            if not visited[v]:
                visited[v] = True
                dist[v] = dist[u] + 1
                Q.append(v)
```

*BFS 的层结构。* 将顶点按 $dist[v]$ 分层，第 $d$ 层（layer $d$）包含所有距 $s$ 恰好为 $d$ 的顶点。BFS 树中，第 $d$ 层的顶点只与第 $d-1$、$d$ 或 $d+1$ 层的顶点相邻。这一性质是 BFS 的核心。

*应用。*

- *$s$-$t$ 连通性判定*：检查 $visited[t]$。
- *最短路径（无权图）*：$dist[v]$ 即为 $s$ 到 $v$ 的最少边数（BFS 的正确性易由归纳法证明：BFS 按距离递增顺序发现顶点）。
- *连通分量*：反复从未访问顶点启动 BFS 即可求出所有连通分量。

*复杂度。* 每个顶点入队一次、出队一次，每条边在无向图中被检查两次（有向图中一次），因此总时间为 $O(m + n)$。

=== 深度优先搜索（DFS）

DFS 递归或显式栈实现：从当前顶点出发，沿着一条未访问过的边继续深入，回溯后再探索其他分支。

*算法：DFS*

```python
def dfs(G, s, visited):
    visited[s] = True
    for v in G[s]:
        if not visited[v]:
            dfs(G, v, visited)
```

DFS 同样以 $O(m + n)$ 时间遍历全图。与 BFS 不同，DFS 产生的探索树形状偏"深"而非"广"。

*应用：flood fill。* 在图像处理中，从种子像素出发，通过 DFS 或 BFS 递归填充相邻的同色区域。

== 3.4 二部性判定：广度优先搜索的应用

=== 二部图的定义

*二部图（bipartite graph）* 是指顶点集 $V$ 可划分为两个互不相交的子集 $X$ 和 $Y$，使得所有边的一个端点在 $X$ 中，另一端在 $Y$ 中。等价地，$G$ 是二部图当且仅当其顶点可进行*2-着色（2-coloring）*：用两种颜色给顶点染色，每条边连接不同颜色的顶点。

=== 基于 BFS 的判定算法

在 BFS 遍历过程中对顶点分层染色：将源点 $s$ 染为白色，第 1 层染为黑色，第 2 层染为白色，依此类推（即 $dist[v]$ 为偶数的染同色，奇数的染另一种）。遍历过程中，若发现某条边两端颜色相同，则图不是二部图；否则是二部图。

*算法：Bipartite(G)*

```python
from collections import deque

def bipartite(G):
    """返回 True 当且仅当 G 是二部图"""
    s = next(iter(G))          # 任选起点
    color = {v: -1 for v in G}
    color[s] = 0               # 染为颜色 0
    Q = deque([s])
    while Q:
        u = Q.popleft()
        for v in G[u]:
            if color[v] == -1:          # 未染色
                color[v] = 1 - color[u] # 染为相反色
                Q.append(v)
            elif color[v] == color[u]:  # 相邻同色 → 非二部图
                return False
    return True
```

*复杂度。* $O(m + n)$。

=== 核心定理

*定理。* 图 $G$ 是二部图当且仅当 $G$ 不含奇环（odd cycle，即长度为奇数的环）。

*证明。* （$=>$）若 $G$ 是二部图，任意环 $C$ 在 $X$ 和 $Y$ 之间交替穿行，因此 $|C|$ 必为偶数。（$<=$）若 $G$ 不含奇环，在上述 BFS 着色过程中，假设某条边 $(u, v)$ 的颜色冲突（$color[u] = color[v]$）。设 $u$、$v$ 的最近公共祖先为 $w$。由 BFS 树的性质，$dist[u] = dist[w] + a$，$dist[v] = dist[w] + b$，且 $color$ 冲突意味着 $a$ 与 $b$ 同奇偶。于是树中从 $w$ 到 $u$、$w$ 到 $v$ 的路径加上边 $(u, v)$ 构成一个长度 $a + b + 1$ 为奇数的环，矛盾。

== 3.5 有向图的连通性

=== 可达性

在有向图 $G = (V, E)$ 中，若存在一条有向路径从 $u$ 到 $v$，则称 $v$ 从 $u$*可达（reachable）*。BFS 或 DFS 在有向图上同样可判定可达性（沿边的方向遍历），复杂度仍为 $O(m + n)$。

=== 强连通

*强连通（strong connectivity）*：有向图 $G$ 是强连通的，若任意两顶点间互相可达。

判定强连通只需 $O(m + n)$ 时间：

1. 从任意顶点 $s$ 出发做 BFS（或DFS），检查 $s$ 能否到达所有顶点。
2. 构造*反向图* $G^"rev"$（将 $G$ 中每条有向边反向得到）。
3. 在 $G^"rev"$ 中从 $s$ 出发做 BFS，检查 $s$ 能否到达所有顶点（即原图中所有顶点能否到达 $s$）。
4. 若两步均成功，则 $G$ 强连通。

=== 强连通分量

*强连通分量（strongly connected component, SCC）* 是顶点集的极大子集，其中任意两顶点互相可达。每个有向图可唯一分解为若干 SCC；将每个 SCC 缩为一点得到的有向图必定是无环的（称为*凝聚图（condensation）*）。求所有 SCC 的经典算法有 Kosaraju 算法和 Tarjan 算法。

== 3.6 有向无环图与拓扑排序

=== 定义

*有向无环图（directed acyclic graph, DAG）* 即不含任一有向环的有向图。

*拓扑序（topological ordering）* 是顶点的一个线性排序 $v_1, v_2, ..., v_n$，使得对所有有向边 $(v_i, v_j)$，都有 $i < j$（即边从前指向后）。

=== 核心定理

*定理。* 有向图 $G$ 存在拓扑序当且仅当 $G$ 是 DAG（无环）。

*证明思路。*

（$=>$）若 $G$ 有拓扑序，则环中顶点 $v_{i_1} -> v_{i_2} -> ... -> v_{i_k} -> v_{i_1}$ 意味着 $i_1 < i_2 < ... < i_k < i_1$，矛盾。故 $G$ 必无环。

（$<=$）设 $G$ 无环。*关键引理*：每个 DAG 至少存在一个入度为 0 的顶点（否则从任意顶点出发反向追溯会无限延续，由有限性必出现环）。因此可重复执行：选取一个入度为 0 的顶点输出，并将其从图中删除（同时删除其所有出边）。此过程不会引入环，剩余图仍为 DAG。重复 $n$ 次即得到拓扑序。

=== 拓扑排序算法

*算法：TopologicalOrdering(G)*

```python
from collections import deque

def topological_ordering(G):
    """返回拓扑序列表；若存在环则打印警告"""
    # 计算每个顶点的入度
    indeg = {v: 0 for v in G}
    for u in G:
        for v in G[u]:
            indeg[v] += 1
    # 将所有入度为 0 的顶点入队
    Q = deque([v for v in G if indeg[v] == 0])
    count = 0
    result = []
    while Q:
        u = Q.popleft()
        result.append(u)
        count += 1
        for v in G[u]:
            indeg[v] -= 1
            if indeg[v] == 0:
                Q.append(v)
    if count < len(G):
        print("图中有环")
    return result
```

*复杂度。* 初始化 $O(m + n)$，每个顶点入队一次、出队一次，每条边被处理一次（减入度），总计 $O(m + n)$。

*正确性。* 上述定理的证明直接给出了算法的正确性基础：DAG 总存在入度为 0 的顶点，且删除它及其出边后仍为 DAG；反之，若图中存在环，则环内顶点的入度永不为 0，算法终止时将有顶点未被输出。


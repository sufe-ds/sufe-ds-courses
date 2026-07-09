# 数值计算方法

# 线性方程组-Gauss消去法

信息管理与工程学院

冯银波

# 下三角形线性方程组的解法

- 考虑下三角形线性方程组：

$$
\left( \begin{array}{c c c c} l _ {1 1} & & & \\ l _ {2 1} & l _ {2 2} & & \\ \vdots & \vdots & \ddots & \\ l _ {n 1} & l _ {n 2} & \dots & l _ {n n} \end{array} \right) \left( \begin{array}{c} y _ {1} \\ y _ {2} \\ \vdots \\ y _ {n} \end{array} \right) = \left( \begin{array}{c} b _ {1} \\ b _ {2} \\ \vdots \\ b _ {n} \end{array} \right)
$$

- 简记为  $Ly = b$ .  $L$  是非奇异矩阵, 且  $l_{ii} \neq 0, i = 1, \ldots, n$ .  
- 可依次求出  $y_{1}, y_{2}, \dots, y_{n}$ .

$$
l _ {1 1} y _ {1} = b _ {1} \Rightarrow y _ {1} = \frac {b _ {1}}{l _ {1 1}}
$$

$$
l _ {2 1} y _ {1} + l _ {2 2} y _ {2} = b _ {2} \Rightarrow y _ {2} = \frac {b _ {2} - l _ {2 1} y _ {1}}{l _ {2 2}}
$$

以此类推，如果已知  $y_{1}, \ldots, y_{i - 1}$  就可求出  $y_{i}$ ，

$$
y _ {i} = (b _ {i} - \sum_ {j = 1} ^ {i - 1} l _ {i j} y _ {j}) / l _ {i i}
$$

这种解法称为前代法。

# 前代法：算法

解下三角形方程组：前代法

算法:

$$
\mathrm {f o r} j = 1: n - 1
$$

用b储存y，节约内存

$$
\begin{array}{l} b (j) = b (j) / L (j, j); \\ b (j + 1: n) = b (j + 1: n) - b (j) * L (j + 1: n, j); \\ \end{array}
$$

end

$$
b (n) = b (n) / L (n, n);
$$

该算法所需要的加减乘除运算的次数为

$$
\sum_ {i = 1} ^ {n} (2 i - 1) = 2 \times \frac {n (n + 1)}{2} - n = n ^ {2},
$$

即该算法的运算量为  $n^{2}$ .

# 上三角形线性方程组的解法

- 考虑上三角形方程组  $U x = y$ , 其中,  $U$  非奇异且对角元素均不为 0 .  
- 可依次求出  $x_{n}, x_{n - 1}, \dots, x_{1}$ .

$$
x _ {n} = \frac {y _ {n}}{u _ {n n}}
$$

如果已知  $x_{n}, \ldots, x_{i + 1}$ , 就可求出  $x_{i}$ :

$$
x _ {i} = (y _ {i} - \sum_ {j = i + 1} ^ {n} u _ {i j} x _ {j}) / u _ {i i}.
$$

这种解法称为回代法

# 回代法：算法

解上三角形方程组：回代法

算法:

$$
\begin{array}{l} \mathrm {f o r} j = n: - 1: 2 \\ y (j) = y (j) / U (j, j); \\ y (1: j - 1) = y (1: j - 1) - y (j) * U (1: j - 1, j); \\ \end{array}
$$

end

$$
y (1) = y (1) / U (1, 1);
$$

该算法的运算量亦为  $n^{2}$ .

# 启发：对于一般线性方程组

对于一般的线性方程组  $A x = b$ , 如果我们能够将  $A$  分解为  $A = L U$ , 那么原方程的解便可由两步得到:

(1) 用前代法解  $Ly = b$  得  $y$  
(2) 用回代法解  $U x = y$  得  $x$

问题的关键在于如何将  $A$  分解为一个下三角矩阵  $L$  与一个上三角矩阵  $U$  的乘积

# 分解思路

- 通过一系列初等变换，将  $A$  化为上三角阵，并且保证这些初等变换的乘积是一个下三角阵  
- 回忆：什么是初等变换？

(1) 交换矩阵的两行 (列);  
(2) 以一个非零数k乘矩阵的某一行（列）所有元素 (3) 把矩阵的某一行所有元素乘以一个数k后加到另一行（列）对应的元素

<table><tr><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td></tr><tr><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td></tr><tr><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td></tr><tr><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td></tr><tr><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td></tr></table>

<table><tr><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td></tr><tr><td>0</td><td>3</td><td>0</td><td>0</td><td>0</td></tr><tr><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td></tr><tr><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td></tr><tr><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td></tr></table>

<table><tr><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td></tr><tr><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td></tr><tr><td>5</td><td>0</td><td>1</td><td>0</td><td>0</td></tr><tr><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td></tr><tr><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td></tr></table>

# Gauss 变换

考虑如下形式的下三角阵

$$
L _ {k} = I - l _ {k} e _ {k} ^ {T},
$$

其中,

$$
l _ {k} = \left(0, \dots , 0, l _ {k + 1, k}, \dots , l _ {n k}\right) ^ {T},
$$

$e_{k}$  为第  $k$  个分量为1的单位列向量，

$L_{k}$  称作Guass变换，形式如下：

$$
L _ {k} = \left[ \begin{array}{c c c c c c} 1 & & & & & \\ & \ddots & & & & \\ & & & & & \\ & & 1 & & & \\ & & - l _ {k + 1, k} & 1 & & \\ & & \vdots & & \ddots & \\ & & - l _ {n k} & & & 1 \end{array} \right]
$$

# Gauss变换

如果Gauss变换  $L_{k}$  作用于一个列向量  $x = (x_{1},x_{2},\ldots ,x_{n})^{T}$  ，有

$$
L _ {k} x = (x _ {1}, \ldots , x _ {k}, x _ {k + 1} - x _ {k} l _ {k + 1, k}, \ldots , x _ {n} - x _ {k} l _ {n k}) ^ {T}.
$$

如果选取

$$
l _ {i k} = \frac {x _ {i}}{x _ {k}}, \mathrm {给 定} x _ {k} \neq 0,
$$

于是:

$$
L _ {k} x = (x _ {1}, \ldots , x _ {k}, 0, \ldots , 0) ^ {T}.
$$

可见，通过多个Gauss变换可以将矩阵上三角化。

# 三角分解:  $A = L U$

- 三角分解是指将一个方阵  $A$  分解为一个下三角矩阵  $L$  与一个上三角矩阵  $U$  的乘积. 有时简称为  $LU$  分解。

举例：对以下矩阵进行三角分解：

$$
A = \left[ \begin{array}{l l l} 1 & 4 & 7 \\ 2 & 5 & 8 \\ 3 & 6 & 1 0 \end{array} \right]
$$

第一步，现将第一列的后面两个元素化为0. 取

$$
L _ {1} = \left[ \begin{array}{l l l} 1 & 0 & 0 \\ - 2 & 1 & 0 \\ - 3 & 0 & 1 \end{array} \right],
$$

于是,

$$
L _ {1} A = \left[ \begin{array}{c c c} 1 & 4 & 7 \\ 0 & - 3 & - 6 \\ 0 & - 6 & - 1 1 \end{array} \right]
$$

# 三角分解:  $A = L U$

第二步，现将第二列的最后面一个元素化为0. 取

$$
L _ {2} = \left[ \begin{array}{c c c} 1 & 0 & 0 \\ 0 & 1 & 0 \\ 0 & - 2 & 1 \end{array} \right]
$$

于是,

$$
L _ {2} L _ {1} A = \left[ \begin{array}{r r r} {{1}} & {{4}} & {{7}} \\ {{0}} & {{- 3}} & {{- 6}} \\ {{0}} & {{0}} & {{1}} \end{array} \right] = U, \text {即 为 上 三 角 矩 阵}
$$

同时， $L_{2} L_{1}$  为下三角矩阵。定义  $L = (L_{2} L_{1})^{-1}$ ，则有  $A = LU$ .

$$
L = (L _ {2} L _ {1}) ^ {- 1} = \left[ \begin{array}{l l l} {{1}} & {{0}} & {{0}} \\ {{2}} & {{1}} & {{0}} \\ {{3}} & {{2}} & {{1}} \end{array} \right], \text {即 为 上 三 角 矩 阵}
$$

则有  $A = L U$ .

# Gauss消去法

对于一般的  $n$  阶矩阵，可用同样的方法进行三角分解。

记  $A^{(k)}$  为对原矩阵作  $k$  步Gauss变换后所得到的矩阵, 即

$$
A ^ {(k)} = L _ {k} \dots L _ {1} A, \qquad k = 1, 2, \ldots , n - 1
$$

$$
A ^ {(0)} = A.
$$

假设已求出  $k - 1$  个Gauss变换  $L_{1}, \dots, L_{k - 1}$ ,

$$
A ^ {(k - 1)} = L _ {k - 1} \dots L _ {1} A = \left[ \begin{array}{c c} A _ {1 1} ^ {(k - 1)} & A _ {1 2} ^ {(k - 1)} \\ 0 & A _ {2 2} ^ {(k - 1)} \end{array} \right],
$$

其中  $A_{11}^{(k - 1)}$  是一个  $k - 1$  阶上三角阵, 接下来就是要把  $A_{22}^{(k - 1)}$  的第一列中除第一个元素外的其它元素化为 0

# Gauss消去法

$$
A _ {2 2} ^ {(k - 1)} = \left[ \begin{array}{c c c} a _ {k k} ^ {(k - 1)} & \dots & a _ {k n} ^ {(k - 1)} \\ \vdots & \ddots & \vdots \\ a _ {n k} ^ {(k - 1)} & \dots & a _ {n n} ^ {(k - 1)} \end{array} \right]
$$

如果  $a_{kk}^{(k - 1)} \neq 0$ , 则可确定第  $k$  个Gauss变换:

$$
L _ {k} = I - l _ {k} e _ {k} ^ {T},
$$

$$
\begin{array}{l} l _ {k} = \left(0, \dots , 0, l _ {k + 1, k}, \dots , l _ {n k}\right) ^ {\mathrm {T}} \\ = \left(0, \ldots , 0, \frac {a _ {k + 1 , k} ^ {(k - 1)}}{a _ {k , k} ^ {(k - 1)}}, \ldots , \frac {a _ {n , k} ^ {(k - 1)}}{a _ {k , k} ^ {(k - 1)}}\right) ^ {T}, \\ \end{array}
$$

$e_{k}$  为第  $k$  个分量为1的单位列向量.

所以进行第  $k$  步变换的前提是  $a_{kk}^{(k - 1)} \neq 0$ . 称  $a_{kk}^{(k - 1)}$  为主元.

# Gauss消去法

当  $a_{kk}^{(k - 1)} \neq 0$  时，第  $k$  步Gauss变换写成具体的矩阵形式：

$$
L _ {k} = \left[ \begin{array}{c c c c c} {{1}} & {} & {} & {} & {} \\ {} & {{\ddots}} & {} & {} & {} \\ {} & {} & {{1}} & {} & {} \\ {} & {} & {{- \frac {a _ {k + 1 , k} ^ {(k - 1)}}{a _ {k , k} ^ {(k - 1)}}}} & {{1}} & {} \\ {} & {} & {{\vdots}} & {} & {{\ddots}} \\ {} & {} & {{- \frac {a _ {n , k} ^ {(k - 1)}}{a _ {k , k} ^ {(k - 1)}}}} & {} & {{1}} \end{array} \right] \quad \text {第} k + 1 \text {行}
$$

# 第  $k$  列

注意：每一步的Gauss变换如果存在，则是唯一确定的

# Gauss消去法

经第  $k$  步Gauss变换后：

$$
A ^ {(k)} = L _ {k} A ^ {(k - 1)} = \left[ \begin{array}{c c} A _ {1 1} ^ {(k)} & A _ {1 2} ^ {(k)} \\ 0 & A _ {2 2} ^ {(k)} \end{array} \right].
$$

这里的  $A_{11}^{(k)}$  比  $A_{11}^{(k-1)}$  多了一阶， $A_{22}^{(k)}$  比  $A_{22}^{(k-1)}$  少了一阶。

重复下去…

最后可以得到三角分解  $A = L U$ , 其中

$$
U = A ^ {(n - 1)}
$$

$$
L = (L _ {n - 1} * \dots * L _ {1}) ^ {- 1}
$$

$U$  是上三角阵,  $L$  是下三角阵.

# Gauss消去法

Gauss变换的逆变换:

$$
L _ {k} = I - l _ {k} e _ {k} ^ {T}, \qquad L _ {k} ^ {- 1} = I + l _ {k} e _ {k} ^ {T}.
$$

注意  $e_k^T l_k = 0$

同样有:  $e_k^T l_{k+1} = \cdots = e_k^T l_{n-1} = 0$ .

$$
L _ {k - 1} ^ {- 1} L _ {k} ^ {- 1} = \left[ \begin{array}{l l l l l} 1 & \ddots & & & \\ & & 1 & & \\ & & l _ {k, k - 1} & 1 & \\ & & \vdots & & 1 \\ & & l _ {n, k - 1} & & \end{array} \right] \left[ \begin{array}{l l l l l} 1 & \ddots & & & \\ & \ddots & 1 & & \\ & & 1 & & \\ & & l _ {k + 1, k} & 1 & \\ & & \vdots & & \ddots \\ & & l _ {n, k} & & 1 \end{array} \right] = \left[ \begin{array}{l l l l l l} 1 & \ddots & & & \\ & \ddots & 1 & & \\ & & l _ {k, k - 1} & 1 & \\ & & l _ {k + 1, k - 1} & l _ {k + 1, k} & 1 \\ & & \vdots & \vdots & \ddots \\ & & l _ {n, k - 1} & l _ {n, k} & \end{array} \right]
$$

# Gauss消去法

不需要通过将  $n - 1$  个Gauss变换乘起来再求逆去得到  $L$

$$
\begin{array}{l} L = L _ {1} ^ {- 1} * \dots * L _ {n - 1} ^ {- 1} \\ = (I + l _ {1} e _ {1} ^ {T}) * (I + l _ {2} e _ {2} ^ {T}) * \dots * (I + l _ {n - 1} e _ {n - 1} ^ {T}) \\ = I + l _ {1} e _ {1} ^ {T} + \dots + l _ {n - 1} e _ {n - 1} ^ {T} \\ \end{array}
$$

$L$  的形式如下:

$$
L = I + [ l _ {1}, l _ {2}, \dots , l _ {n - 1}, 0 ] = \left[ \begin{array}{l l l l l} 1 & & & & \\ l _ {2 1} & 1 & & & \\ l _ {3 1} & l _ {3 2} & 1 & & \\ \vdots & \vdots & \vdots & \ddots & \\ l _ {n 1} & l _ {n 2} & l _ {n 3} & \dots & 1 \end{array} \right]
$$

$L$  是主对角元素全为 1 的下三角矩阵

这种计算三角分解的方法称作Gauss消去法

# Gauss消去法

现在我们知道了  $A = L U$  分解过程以及  $L, U$  各自的计算方法。  
- 关于计算过程的存储问题:  
-  $A^{(n - 1)}$  矩阵中, 上三角部分用于存储  $U$ , 下三角部分全为 0 , 所以可以将  $L$  的下三角部分存储在  $A^{(n - 1)}$  的下三角部分。

# 算法：（Gauss消去法）

$$
\begin{array}{l} \mathrm {f o r} k = 1: n - 1 \\ A (k + 1: n, k) = A (k + 1: n, k) / A (k, k); \\ A (k + 1: n, k + 1: n) = A (k + 1: n, k + 1: n) - \\ A (k + 1: n, k) * A (k, k + 1: n); \\ \end{array}
$$

end

# Gauss消去法

该算法需要的加减乘除运算次数为

$$
\sum_ {k = 1} ^ {n - 1} ((n - k) + 2 (n - k) ^ {2}) = \frac {n (n - 1)}{2} + \frac {n (n - 1) (2 n - 1)}{3} = \frac {2}{3} n ^ {3} + O (n ^ {2}).
$$

思考：Gauss消去法每一次变换时都要求主元不为0，那么，在什么情况下可以保证整个消去过程所碰到的主元都不为0？

# 主元不为0的判别条件

定理：主元  $a_{kk}^{(i - 1)}(\mathrm{i} = 1,\dots ,k)$  均不为0的充要条件是A的i阶顺序主子阵 $A_{i}(i = 1,\ldots ,k)$  都是非奇异的。

证明: 对  $k$  用数学归纳法。当  $k = 1$  时, 定理显然成立。假设定理对  $1, \ldots, k - 1$  都成立, 下面只需证 “若  $A_{1}, \ldots, A_{k - 1}$  非奇异, 则  $A_{k}$  非奇异的充要条件是  $a_{kk} ^{(k - 1)} \neq 0$ . 经  $k - 1$  次 Gauss 变化之后,

$$
A ^ {(k - 1)} = L _ {k - 1} \dots L _ {1} A = \left[ \begin{array}{c c} A _ {1 1} ^ {(k - 1)} & A _ {1 2} ^ {(k - 1)} \\ 0 & A _ {2 2} ^ {(k - 1)} \end{array} \right],
$$

其中

$$
A _ {1 1} ^ {(k - 1)} = \left[ \begin{array}{c c c c} a _ {1 1} ^ {(0)} & a _ {1 2} ^ {(0)} & \dots & a _ {1, k - 1} ^ {(0)} \\ & a _ {2 2} ^ {(1)} & \dots & a _ {2, k - 1} ^ {(1)} \\ & & \ddots & \vdots \\ & & & a _ {k - 1, k - 1} ^ {(k - 2)} \end{array} \right].
$$

# 主元不为0的判别条件

# 证明继续:

所以， $A^{(k-1)}$  的  $k$  阶顺序主子阵  $A_k$  的行列式为

$$
\det A _ {k} ^ {(k - 1)} = a _ {k k} ^ {(k - 1)} * \det A _ {1 1} ^ {(k - 1)}.
$$

注意，Gauss变换矩阵的任意顺序主子式的值均为1，所以经  $k - 1$  次变换之后，原矩阵  $A$  的  $k$  阶顺序主子式的值与  $A^{(k - 1)}$  的  $k$  阶顺序主子式的值相同。

所以，我们有

$$
\det A _ {k} = a _ {k k} ^ {(k - 1)} * \det A _ {1 1} ^ {(k - 1)}.
$$

因此， $A_{k}$  非奇异的充要条件是  $a_{kk}^{(k - 1)} \neq 0$ 。证毕。

# 三角分解的存在性与唯一性

定理: 若  $A \in \mathbf{R}^{n \times n}$  的顺序主子阵  $A_{k} \in \mathbf{R}^{k \times k} (k = 1, \dots, n - 1)$  均非奇异, 则存在唯一的单位下三角阵  $L \in \mathbf{R}^{n \times n}$  和上三角阵  $U \in \mathbf{R}^{n \times n}$ , 使得  $A = LU$ .

证明思路：由以上分析易证“存在性”。“唯一性”可通过反证法证明。

# 例题

例：用直接三角分解法解

$$
\left( \begin{array}{l l l} 1 & 2 & 3 \\ 2 & 5 & 2 \\ 3 & 1 & 5 \end{array} \right) \left( \begin{array}{l} x _ {1} \\ x _ {2} \\ x _ {3} \end{array} \right) = \left( \begin{array}{l} 1 4 \\ 1 8 \\ 2 0 \end{array} \right)
$$

解：（1）对于  $r = 1$

$$
u _ {1 1} = 1 \quad u _ {1 2} = 2 \quad u _ {1 3} = 3
$$

$$
l _ {2 1} = 2 \quad l _ {3 1} = 3
$$

（2）对于  $r = 2$

$$
u _ {2 2} = a _ {2 2} - l _ {2 1} u _ {1 2} = 5 - 2 \times 2 = 1
$$

$$
u _ {2 3} = a _ {2 3} - l _ {2 1} u _ {1 3} = 2 - 2 \times 3 = - 4
$$

$$
l _ {3 2} = \frac {\left(a _ {3 2} - l _ {3 1} u _ {1 2}\right)}{u _ {2 2}} = \frac {(1 - 3 \times 2)}{1} = - 5
$$

# 例题

(3)  $r = 3$

$$
u _ {3 3} = a _ {3 3} - \left(l _ {3 1} u _ {1 3} + l _ {3 2} u _ {2 3}\right) = 5 - (3 \times 3 + (- 5) \cdot (- 4)) = - 2 4
$$

于是

$$
A = \left( \begin{array}{c c c} 1 & & \\ 2 & 1 & \\ 3 & - 5 & 1 \end{array} \right) \left( \begin{array}{c c c} 1 & 2 & 3 \\ & 1 & - 4 \\ & & - 2 4 \end{array} \right) = L U
$$

（4）求解：

$Ly = b$  得到

$$
y _ {1} = 1 4
$$

$$
y _ {2} = b _ {2} - l _ {2 1} y _ {1} = 1 8 - 2 \times 1 4 = - 1 0
$$

$$
y _ {3} = b _ {3} - \left(l _ {3 1} y _ {1} + l _ {3 2} y _ {2}\right) = 2 0 - (3 \times 1 4 + (- 5) (- 1 0)) = - 7 2
$$

从而  $y = (14, - 10, - 72)^T$

# 例题

由  $Ux = y$  得到

$$
x _ {3} = \frac {y _ {3}}{u _ {3 3}} = \frac {- 7 2}{- 2 4} = 3
$$

$$
x _ {2} = \frac {\left(y _ {2} - u _ {2 3} x _ {3}\right)}{u _ {2 2}} = \frac {- 1 0 - (- 4 \times 3)}{1} = 2
$$

$$
x _ {1} = \frac {y _ {1} - \left(u _ {1 2} x _ {2} + u _ {1 3} x _ {3}\right)}{u _ {1 1}} = \frac {1 4 - (2 \times 2 + 3 \times 3)}{1} = 1
$$

$$
x = (1, 2, 3) ^ {T}
$$

# Gauss消去法的缺陷

(1) Gauss消去法要求每一步变换时都有  $a_{kk}^{(k-1)} \neq 0$ , 即主元不为0.  
(2) 即使主元不为 0 , 但是主元很小时也容易产生较大误差。

例

$$
\left\{ \begin{array}{l} 0. 0 0 0 1 x _ {1} + 1. 0 0 x _ {2} = 1. 0 0 \\ 1. 0 0 x _ {1} + 1. 0 0 x _ {2} = 2. 0 0 \end{array} \right.
$$

它的精确解为：

$$
\begin{array}{l} x _ {1} = \frac {1 0 0 0 0}{9 9 9 9} \approx 1. 0 0 0 1 0 \\ x _ {2} = \frac {9 9 9 8}{9 9 9 9} \approx 0. 9 9 9 9 0 \\ \end{array}
$$

用顺序消去法，第一步以0.0001为主元，从第二个方程中消  $x_{1}$  后可得：

$$
- 1 0 0 0 0 x _ {2} = - 1 0 0 0 0 \quad x _ {2} = 1. 0 0
$$

假设采用3位10进制浮点数

回代可得  $x_{1} = 0.00$

显然，这不是解。

# Gauss消去法的数值不稳定性

$$
A = \left[ \begin{array}{c c} 0. 0 0 0 1 & 1 \\ 1 & 1 \end{array} \right]
$$

$$
L _ {1} = \left[ \begin{array}{c c} 1 & 0 \\ - 1 0 0 0 0 & 1 \end{array} \right]
$$

$$
L _ {1} A = \left[ \begin{array}{c c} 0. 0 0 0 1 & 1 \\ 0 & - 1 0 0 0 0 \end{array} \right] = U
$$

$$
L = L _ {1} ^ {- 1} = \left[ \begin{array}{l l} 1 & 0 \\ 1 0 0 0 0 & 1 \end{array} \right]
$$

假设采用3位10

进制浮点数

$$
L y = b \Rightarrow \left[ \begin{array}{c c} 1 & 0 \\ 1 0 0 0 0 & 1 \end{array} \right] \left[ \begin{array}{c} y _ {1} \\ y _ {2} \end{array} \right] = \left[ \begin{array}{c} 1 \\ 2 \end{array} \right] \Rightarrow \left[ \begin{array}{c} y _ {1} \\ y _ {2} \end{array} \right] = \left[ \begin{array}{c} 1 \\ - 1 0 0 0 0 \end{array} \right]
$$

$$
U x = y \xrightarrow {} {\left[ \begin{array}{c c} 0. 0 0 0 1 & 1 \\ 0 & - 1 0 0 0 0 \end{array} \right]} {\left[ \begin{array}{c} x _ {1} \\ x _ {2} \end{array} \right]} = {\left[ \begin{array}{c} 1 \\ - 1 0 0 0 0 \end{array} \right]} \xrightarrow {} {\left[ \begin{array}{c} x _ {1} \\ x _ {2} \end{array} \right]} = {\left[ \begin{array}{c} 0 \\ 1 \end{array} \right]}
$$

# Gauss消去法的缺陷

小数做分母产生误差的原因:

溢出、大数吃小数、敏感方程（误差放大）

- 如果交换两个方程的位置，用  $x_{1}$  的系数1作为主元，可以得到

$$
x _ {1} = 1. 0 0, x _ {2} = 1. 0 0,
$$

比之前精确了很多！

- 在消元过程中适当选取主元素是十分必要的。误差分析的理论和计算实践均表明：顺序消元法在系数矩阵A为对称正定时，可以保证此过程对舍入误差的数值稳定性，对一般的矩阵则必须引入选取主元素的技巧，方能得到满意的结果。

# Gauss消去法的改进

交换两行顺序后：

$$
A = \left[ \begin{array}{l l} 1 & 1 \\ 0. 0 0 0 1 & 1 \end{array} \right]
$$

$$
L _ {1} = \left[ \begin{array}{l l} 1 & 0 \\ - 0. 0 0 0 1 & 1 \end{array} \right]
$$

$$
L _ {1} A = \left[ \begin{array}{l l} 1 & 1 \\ 0 & 1 \end{array} \right] = U
$$

$$
L = L _ {1} ^ {- 1} = \left[ \begin{array}{l l} 1 & 0 \\ 0. 0 0 0 1 & 1 \end{array} \right]
$$

$$
L y = b \Rightarrow \left[ \begin{array}{c c} 1 & 0 \\ 0. 0 0 0 1 & 1 \end{array} \right] \left[ \begin{array}{c} y _ {1} \\ y _ {2} \end{array} \right] = \left[ \begin{array}{c} 2 \\ 1 \end{array} \right] \quad \Rightarrow \quad \left[ \begin{array}{c} y _ {1} \\ y _ {2} \end{array} \right] = \left[ \begin{array}{c} 2 \\ 1 \end{array} \right]
$$

$$
U x = y \Rightarrow \left[ \begin{array}{c c} 1 & 1 \\ 0 & 1 \end{array} \right] \left[ \begin{array}{c} x _ {1} \\ x _ {2} \end{array} \right] = \left[ \begin{array}{c} 2 \\ 1 \end{array} \right] \quad \Rightarrow \quad \left[ \begin{array}{c} x _ {1} \\ x _ {2} \end{array} \right] = \left[ \begin{array}{c} 1 \\ 1 \end{array} \right]
$$

假设采用3位10

进制浮点数

# 全主元Gauss消去法

在Gauss消去过程中, 如果  $a_{kk}^{(k - 1)}$  太小, 则从  $k + 1$  行  $\sim n$  行、  $k + 1$  列  $\sim n$  列的子矩阵中寻找最大的元素, 通过行列互换将其放到  $(k, k)$  的位置作为主元进行下一次Gauss变换, 这种方法就是全主元Gauss消去法。

# 具体做法:

引入置换矩阵  $I_{pq} = \left[e_1,\dots ,e_{p - 1},e_q,e_{p + 1},\dots ,e_{q - 1},e_p,e_{q + 1},\dots ,e_n\right].I_{pq}$  左乘矩阵A，便是将A的第p行与第q行做了互换

假设消去法已经进行到了第  $k - 1$  步, 即已确定了  $k - 1$  个Gauss变换  $L_{1}, \ldots, L_{k - 1}$  和  $2(k - 1)$  个初等置换矩阵:

$$
P _ {1}, \ldots , P _ {k - 1} \text {和} Q _ {1}, \ldots , Q _ {k - 1}
$$

使得:

$$
A ^ {(k - 1)} = L _ {k - 1} P _ {k - 1} \dots L _ {1} P _ {1} A Q _ {1} \dots Q _ {k - 1} = \left[ \begin{array}{c c} A _ {1 1} ^ {(k - 1)} & A _ {1 2} ^ {(k - 1)} \\ 0 & A _ {2 2} ^ {(k - 1)} \end{array} \right].
$$

# 全主元Gauss消去法

下一步变换之前，需要先从  $A_{22}^{(k - 1)}$  中寻找绝对值尽可能大的主元，

$$
a _ {p q} ^ {(k - 1)} = \max \{\left| a _ {i j} ^ {(k - 1)} \right|: k \leq i, j \leq n \}.
$$

如果  $a_{pq}^{(k - 1)} = 0$ , 则说明  $A_{22}^{(k - 1)}$  全为 0 , 消去过程结束; 否则交换  $A^{(k - 1)}$  的第  $p$  行与第  $k$  行、第  $q$  列与第  $k$  列。交换之后, 记

$$
\tilde {A} _ {2 2} ^ {(k - 1)} = \left( \begin{array}{c c c} \tilde {a} _ {k k} ^ {(k - 1)} & \dots & \tilde {a} _ {k n} ^ {(k - 1)} \\ \vdots & & \vdots \\ \tilde {a} _ {n k} ^ {(k - 1)} & \dots & \tilde {a} _ {n n} ^ {(k - 1)} \end{array} \right).
$$

然后做Gauss变换，和之前的Gauss变换一样。

$$
\begin{array}{l} L _ {k} = I - l _ {k} e _ {k} ^ {T}, \qquad l _ {k} = \left(0, \dots , 0, \tilde {l} _ {k + 1, k}, \dots , \tilde {l} _ {n k}\right) ^ {\mathrm {T}} \\ = \left(0, \ldots , 0, \frac {\widetilde {a} _ {k + 1 , k} ^ {(k - 1)}}{\widetilde {a} _ {k , k} ^ {(k - 1)}}, \ldots , \frac {\widetilde {a} _ {n , k} ^ {(k - 1)}}{\widetilde {a} _ {k , k} ^ {(k - 1)}}\right) ^ {T}, \\ \end{array}
$$

# 全主元Gauss消去法

经第  $k$  次变换之后,

$$
A ^ {(k)} = L _ {k} P _ {k} A ^ {(k - 1)} Q _ {k} = \left[ \begin{array}{c c} A _ {1 1} ^ {(k)} & A _ {1 2} ^ {(k)} \\ 0 & A _ {2 2} ^ {(k)} \end{array} \right],
$$

其中， $P_{k} = I_{kp}, Q_{k} = I_{kq}, A_{11}^{(k)}$  为  $k$  阶上三角阵。

如此进行下去，假设在第  $r$  次之后算法终止，则

$$
A ^ {(r)} = L _ {r} P _ {r} \dots L _ {1} P _ {1} A Q _ {1} \dots Q _ {r} = U \mathrm {为 上 三 角 阵} _ {\circ}
$$

令

$$
Q = Q _ {1} \dots Q _ {r},
$$

$$
P = P _ {r} \dots P _ {1},
$$

$$
L = P (L _ {r} P _ {r} \dots L _ {1} P _ {1}) ^ {- 1},
$$

则有

$P A Q = L U$  问题:  $L$  是下三角吗?

# 全主元Gauss消去法

现在分析  $L = P(L_{r}P_{r}\dots L_{1}P_{1})^{-1} = P_{r}\dots P_{2}L_{1}^{-1}P_{2}L_{2}^{-1}\dots P_{r}L_{r}^{-1}$

定义  $L^{(1)} = L_1^{-1}$  ，  $L^{(k)} = P_kL^{(k - 1)}P_kL_k^{-1},k = 2,\ldots ,r,$

则  $L^{(k)}$  必然具有以下形式（下面给出证明）

$$
L ^ {(k)} = \left[ \begin{array}{c c} L _ {1 1} ^ {(k)} & 0 \\ L _ {2 1} ^ {(k)} & I _ {n - k} \end{array} \right],
$$

其中  $L_{11}^{(k)}$  为主对角元全为 1 , 其它元素绝对值均小于等于 1 的下三角矩阵。  $L_{21}^{(k)}$  的所有元素绝对值均小于等于 1 。

由归纳法, 假设  $L ^{(k - 1)}$  具有以上形式, 下证  $L ^{(k)}$  具有以上形式。注意观察  $L ^{(k)}$  与  $L ^{(k - 1)}$  之间的差别:

$$
L ^ {(k - 1)} = \left[ \begin{array}{c c} L _ {1 1} ^ {(k - 1)} & 0 \\ L _ {2 1} ^ {(k - 1)} & I _ {n - k + 1} \end{array} \right], \qquad L ^ {(k)} = P _ {k} L ^ {(k - 1)} P _ {k} L _ {k} ^ {- 1}.
$$

注意思考, 两个  $P_{k}$  是如何作用于  $L ^{(k - 1)}$  的

# 全主元Gauss消去法

$$
L ^ {(k - 1)} = \left[ \begin{array}{c c} L _ {1 1} ^ {(k - 1)} & 0 \\ L _ {2 1} ^ {(k - 1)} & I _ {n - k + 1} \end{array} \right], \qquad \qquad P _ {k} L ^ {(k - 1)} P _ {k} = \left[ \begin{array}{c c} L _ {1 1} ^ {(k - 1)} & 0 \\ \tilde {L} _ {2 1} ^ {(k - 1)} & I _ {n - k + 1} \end{array} \right]
$$

假设第  $k$  次变换时的主元位于第  $p$  行  $q$  列。  $\tilde{L}_{21}^{(k - 1)}$  是由  $L_{21}^{(k - 1)}$  交换了第1行与第  $p - k + 1$  行（相当于  $L^{(k - 1)}$  的第  $k$  行与第  $p$  行）而得到的。

$$
L ^ {(k)} = P _ {k} L ^ {(k - 1)} P _ {k} L _ {k} ^ {- 1} = \left[ \begin{array}{c c} L _ {1 1} ^ {(k - 1)} & 0 \\ \widetilde {L} _ {2 1} ^ {(k - 1)} & \widetilde {L} _ {k} ^ {- 1} \end{array} \right],
$$

其中,  $\tilde{L}_{k}^{-1}$  为  $L_{k}^{-1}$  的右下角部分

$$
\begin{array}{r} \tilde {L} _ {k} ^ {- 1} = \left[ \begin{array}{l l l l l} 1 & & & & \\ \tilde {l} _ {k + 1, k} & 1 & & & \\ \tilde {l} _ {k + 2, k} & 0 & 1 & & \\ \vdots & \vdots & \vdots & \ddots & \\ \tilde {l} _ {n, k} & 0 & 0 & \dots & 1 \end{array} \right], \qquad \tilde {l} _ {i, k} = \frac {\tilde {a} _ {i , k} ^ {(k - 1)}}{\tilde {a} _ {k , k} ^ {(k - 1)}} \leq 1 \end{array}
$$

# 全主元Gauss消去法

所以， $L^{(k)}$  也具有以下形式

$$
L ^ {(k)} = \left[ \begin{array}{c c} L _ {1 1} ^ {(k)} & 0 \\ L _ {2 1} ^ {(k)} & I _ {n - k} \end{array} \right].
$$

由归纳法知,  $L = L^{(r)}$  具有同样形式, 即为主对角元全为 1 , 其它元素绝对值均小于等于 1 的下三角矩阵。

最后我们得到了  $PAQ = LU$ .

定理: 若  $A \in \mathbf{R}^{n \times n}$ , 则存在排列矩阵  $P, Q \in \mathbf{R}^{n \times n}$ , 以及单位下三角阵  $L \in \mathbf{R}^{n \times n}$  和上三角阵  $U \in \mathbf{R}^{n \times n}$ , 使得  $PAQ = LU$ , 而且  $L$  的所有元素均满足  $\left|l_{ij}\right| \leq 1$ ,  $U$  的非零对角元的个数恰好等于矩阵  $\mathsf{A}$  的秩。

注意，该矩阵分解不要求  $A$  非奇异。 $A$  非奇异可以保证原方程组问题有唯一解。

思考：该定理中为什么没指出唯一性？

# 全主元三角分解

# 算法：（全主元三角分解）

$$
\mathrm {f o r} k = 1: n - 1
$$

确定  $p, q (k \leq p, q \leq n)$ , 使得

$$
A (p, q) = \max  \{| A (i, j) |: k \leq i, j \leq n \}
$$

$A([k, p], 1: n) = A([p, k], 1: n)$ ; (交换第  $k$  行与第  $p$  行)

$A(1:n,[k,q]) = A(1:n,[q,k])$ ; (交换第  $k$  列与第  $q$  列)

$u(k) = p; v(k) = q$ ; (记录置换矩阵  $P_{k}, Q_{k}$ )

if  $A(k,k) \neq 0$

将  $L$  的下三角部分存储在  $A$  的下三角部分

$$
\begin{array}{l} A (k + 1 \colon n, k) = A (k + 1 \colon n, k) / A (k, k); \\ A (k + 1: n, k + 1: n) = A (k + 1: n, k + 1: n) - \\ A (k + 1: n, k) * A (k, k + 1: n); \\ \end{array}
$$

else

Stop(矩阵奇异)

end

end

# 全主元Gauss消去法

思考：假设得到了  $PAQ = LU$ ，如果  $\mathsf{A}$  满秩，接下来如何求解  $Ax = b$ ?

令  $x = Qx'$

$$
\begin{array}{l} L U x ^ {\prime} = P A x = P b \\ L y = P b \\ U x ^ {\prime} = y \\ x = Q x ^ {\prime} \\ \end{array}
$$

如果A不满秩，如何验证  $Ax = b$  是否有解

- 关键在于求解  $Ux^{\prime} = y$  那一步

结合全主元三角分解的算法思考：如果我们像上帝一样提前知道所有主元出现的位置，提前对A做好行列变换，再做普通的LU分解，得到的结果是一样的。

# 全主元Gauss消去法的优缺点

思考：全主元Gauss消去法，与Gauss消去法相比有什么优点？

- 全主元Gauss消去法不需要假定所有的顺序主子阵非奇异  
- 由于主元的选择，可以更好的减小误差

思考：全主元Gauss消去法，与Gauss消去法相比有什么缺点？

- 每一步都要挑选主元，花费了大量的运算。在A非奇异的情况下，需要进行n-1次全主元Gauss消去，花费在挑选主元上的运算量为：

包括和0比较大小

$$
\sum_ {k = 1} ^ {n - 1} (n - k + 1) ^ {2} = \frac {1}{3} n ^ {3} + O (n ^ {2})
$$

次两两元素之间的比较和相应的逻辑判断

# 列主元Gauss消去法

列主元Gauss消去法与全主元Gauss消去法的区别仅在于：每次选主元时，只在  $A_{22}^{(k - 1)}$  的第一列中寻找绝对值最大的元素，即

$$
\left| a _ {p k} ^ {(k - 1)} \right| = \max \left\{\left| a _ {p k} ^ {(k - 1)} \right|: k \leq i \leq n \right\}.
$$

这样，花费在挑选主元的运算量降为  $O(n^{2})$ 。每次选好主元后，只需做行交换，不需做列交换。

因此，按照列主元消去法，最终可以得到：

$$
P A = L U,
$$

其中，  $U = A^{(n - 1)},\qquad P = P_{n - 1}\dots P_1,\qquad L = P(L_{n - 1}P_{n - 1}\dots L_1P_1)^{-1}.$

# 列主元三角分解

# 算法：（列主元三角分解）

$$
\mathrm {f o r} k = 1: n - 1
$$

确定  $p(k \leq p \leq n)$ , 使得

$$
A (p, k) = \max \{| A (i, k) |: k \leq i \leq n \};
$$

$A([k,p],1:n) = A([p,k],1:n)$ ; (交换第  $k$  行与第  $p$  行)

$u(k) = p$ ; (记录置换矩阵  $P_{k}$ )

if  $A(k,k) \neq 0$

将  $L$  的下三角部分存储在  $A$  的下三角部分

$$
\begin{array}{l} A (k + 1: n, k) = A (k + 1: n, k) / A (k, k); \\ A (k + 1: n, k + 1: n) = A (k + 1: n, k + 1: n) - \\ A (k + 1: n, k) * A (k, k + 1: n); \\ \end{array}
$$

else

Stop(矩阵奇异);→ 或 continue;

end

end

# 列主元Gauss消去法

思考：假设得到了  $PA = LU$ ，如果A满秩，接下来如何求解  $Ax = b$ ？如果A不满秩呢？

# Matlab三角分解的相关指令

•  $x = A \backslash b$ ; 求  $Ax = b$  的解  
•  $x = A \hat{} (-1) * b$ ; 求  $Ax = b$  的解  
•  $x = \operatorname{inv}(A) * b$ ; 求  $Ax = b$  的解  
• x=lnsolve(A, b); 求Ax=b的解  
• [L, U, P] = lu(A); A的列主元分解  
•  $[L, U] = I u(A)$ ; A的LU分解, 其中L是经过置换的, 即  $L U = P A$

# 利用LU分解求逆矩阵

$$
A X = I, \qquad X = (X _ {1}, \ldots , X _ {n}) = A ^ {- 1}
$$

已知  $PA = LU$  ，如何计算  $X?$

按照  $i = 1, \ldots, n$  的顺序依次求解线性方程组：

$$
L U X _ {i} = e _ {i}
$$

便可得到  $X$  。

有一些细节需要注意，比如，求解  $Ly = e_{i}$  时， $y$  的前  $i - 1$  个分量必为 0，不需要计算，于是只需要求解一个  $n - i + 1$  阶的下三角方程组即可。

一般矩阵求逆的运算量为  $O(2n^{3})$

# 作业

1. 对下列线性方程组的系数矩阵进行LU分解（不选主元），并求解该线性方程组：

$$
\left( \begin{array}{l l l} 2 & 3 & 4 \\ 3 & 5 & 2 \\ 4 & 3 & 3 0 \end{array} \right) \left( \begin{array}{l} x _ {1} \\ x _ {2} \\ x _ {3} \end{array} \right) = \left( \begin{array}{l} 6 \\ 5 \\ 3 2 \end{array} \right)
$$

2 / 教材第一章课后习题4、7、8、10。  
3 / 教材第一章上机习题1（只考虑Gauss列主元消去法）。
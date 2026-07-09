#import "../homework.typ": config

#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *

#show: config.with("数值计算方法", "第十一周作业", "", "匿名", "20XXXXXXXX")

#show: codly-init.with()

= 教材第五章习题 5

#align(center, image("/assets/image-7.png"))



假设存在实数 $c_1 , c_2 , dots.h , c_k$ 使得 $ c_1 p_1 + c_2 p_2 + dots.h.c + c_k p_k = 0 $

对每个固定的 $i$（$1 lt.eq i lt.eq k$），用 $p_i^top A$ 左乘上式：

$ p_i^top A(c_1 p_1 + c_2 p_2 + dots.h.c + c_k p_k)= 0 $

展开得：

$ c_1 p_i^top A p_1 + c_2 p_i^top A p_2 + dots.h.c + c_k p_i^top A p_k = 0 $

由条件 $p_i^top A p_j = 0$（$i eq.not j$），上式化为：

$ c_i p_i^top A p_i = 0 $

因为 $A$ 对称正定且 $p_i eq.not 0$，有 $p_i^top A p_i > 0$，从而 $c_i = 0$。

这对每个 $i$ 均成立，故 $c_1 = c_2 = dots.h.c = c_k = 0$。

因此，$p_1 , p_2 , dots.h , p_k$ 线性无关。

#text(fill: red)[注：若某个 $p_i = 0$，则向量组线性相关，结论不成立。故假设所有 $p_i$ 非零。]

= 教材第五章习题 6

#align(center, image("/assets/image-8.png"))

对于固定的 $i$，计算：

$
  f(t) & = phi(y_(i - 1) + t e_i) \
       & = 1/2(y_(i - 1) + t e_i )^top A(y_(i - 1) + t e_i)- b^top (y_(i - 1) + t e_i) \
       & = 1/2 y_(i - 1)^top A y_(i - 1) + t e_i^top A y_(i - 1) + 1/2 t^2 e_i^top A e_i - b^top y_(i - 1) - t b_i .
$
由于 $A$ 对称正定，$e_i^top A e_i = a_(i i) > 0$，故 $f(t)$ 是开口向上的二次函数。

其最小化条件为 $f'(t)= 0$，即：

$ e_i^top A y_(i - 1) + t a_(i i) - b_i = 0 $

解得最优步长：

$ t = frac(b_i - e_i^top A y_(i - 1), a_(i i)) $

注意到： $ e_i^top A y_(i - 1) = sum_(j = 1)^n a_(i j) y_(i - 1, j) $

于是更新公式为：

$
  y_i = y_(i - 1) + (b_i - sum_(j = 1)^n a_(i j) y_(i - 1 , j))/a_(i i) e_i
$
即：
$
  y_(i, i) = y_(i - 1 , i) + (b_i - sum_(j = 1)^n a_(i j) y_(i - 1 , j))/( a_(i i)), y_(i , j) = y_(i - 1 , j) (j != i).
$
更新第 $i$ 个分量时，$y_(i - 1)$ 的前 $i - 1$ 个分量已经通过之前的步骤更新，而第
$i$ 到第 $n$ 个分量仍保持为 $x_k$ 的相应分量。

$
  y_(i - 1) = (y_(1, 1), y_(2, 2), dots.h, y_(i - 1, i - 1), x_i^((k)), x_(i + 1)^((k)), dots.h, x_n^((k)))^T
$

因此，

$
  sum_(j = 1)^n a_(i j) y_(i - 1 , j) = sum_(j = 1)^(i - 1) a_(i j) y_(j , j) + sum_(j = i)^n a_(i j) x_j^(( k )) .
$
代入更新公式得：

$
  y_(i , i) &= x_i^(( k )) + (b_i - sum_(j = 1)^(i - 1) a_(i j) y_(j , j) - sum_(j = i)^n a_(i j) x_j^(( k )))/( a_(i i))\
  &= frac(b_i - sum_(j = 1)^(i - 1) a_(i j) y_(j , j) - sum_(j = i + 1)^n a_(i j) x_j^(( k )), a_(i i))
$

注意到 $y_(j , j)$ 正是更新后的第 $j$ 个分量，即 $x_j^(( k + 1 ))$，故上式即为 Gauss-Seidel 迭代的分量形式：

$
  x_i^(( k + 1 )) = frac(b_i - sum_(j = 1)^(i - 1) a_(i j) x_j^(( k + 1 )) - sum_(j = i + 1)^n a_(i j) x_j^(( k )), a_(i i)) , quad i = 1 , 2 , dots.h , n .
$

因此，所述算法等价于 Gauss-Seidel 迭代法。


= 共轭梯度法（手模）

#align(center, image("/assets/image-9.png"))

$
  &r_0 = b - A x_0 = mat(1; 2), & &p_0 = r_0 = mat(1; 2), &alpha_0 = (r_0^top r_0)/(p_0^top A p_0) = 5/9\
  x_1 = x_0 + alpha_0 p_0 = 5/9 mat(1; 2), &r_1 =b - A x_1 = 2/9 mat(2; -1), &beta_0 = (r_1^top r_1) / (r_0^top r_0) = 4/81, &p_1 = r_1 + beta_0 p_0 = 10/81 mat(4; -1), &alpha_1 = (r_1^top r_1)/(p_1^top A p_1) = 9/10\
  x_2 = x_1 + alpha_1 p_1 = mat(1; 1), &r_2 = b - A x_2 = mat(0; 0)
$

综上 $ x^* = mat(1; 1) $

= 共轭梯度法（上机）

#align(center, image("/assets/image-10.png"))

```py
import time

import numpy as np


def solve_conj_grad(
    A: np.ndarray,
    b: np.ndarray,
    x0: np.ndarray,
    tol: float = 1e-10,
) -> tuple[np.ndarray, int]:
    x = x0.copy()
    r = b - A @ x
    rho = r.T @ r
    b_norm = np.linalg.norm(b)

    k = 1
    p = r
    w = A @ p
    alpha = rho / (p.T @ w)
    x = x + alpha * p
    r = r - alpha * w
    rho_ = rho
    rho = r.T @ r

    while np.sqrt(rho) > tol * b_norm:
        k = k + 1
        beta = rho / rho_
        p = r + beta * p
        w = A @ p
        alpha = rho / (p.T @ w)
        x = x + alpha * p
        r = r - alpha * w
        rho_ = rho
        rho = r.T @ r
    return x, k


def main():
    n = 1000
    A = (
        np.diag(np.arange(1, n + 1))
        - np.diag(np.ones(n - 1), k=-1)
        - np.diag(np.ones(n - 1), k=1)
    )
    b = np.array([0] + list(range(0, n - 3 + 1)) + [n - 1])
    x0 = np.zeros(n)
    st = time.perf_counter()
    x, iters = solve_conj_grad(A, b, x0)
    ed = time.perf_counter()
    print(f"Finish in {ed - st:.6f} seconds with {iters} iterations.")
    print("Solution x:")
    print(x)


if __name__ == "__main__":
    main()
```

```
Finish in 0.026532 seconds with 193 iterations.
Solution x:
[1.         1.         1.         1.         1.         1.00000001
 0.99999999 1.00000002 0.99999998 1.00000001 1.         0.99999999
 1.00000001 1.00000001 0.99999999 1.         1.00000001 1.
 0.99999999 1.         1.00000001 1.         1.         1.
 1.         1.         1.         1.         1.         1.
 1.         1.         1.         1.         1.         1.
 1.         1.         1.         1.         1.         1.
 1.         1.         1.         1.         1.         1.
 1.         1.         1.         1.         1.         1.
                  ...(全为1，省略)...
 1.         1.         1.         1.         1.         1.
 1.         1.         1.         1.        ]
```

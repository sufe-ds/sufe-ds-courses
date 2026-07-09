#import "../homework.typ": config

#show: config.with("数值计算方法", "第九周作业", "", "匿名", "20XXXXXXXX")

= 教材第四章习题3

#image("image-3.png")

== （1）

$
  det mat(1) = 1 > 0\
  det mat(1, 0; 0, 1) = 1 > 0\
  det mat(1, 0, a; 0, 1, 0; a, 0, 1) = 1 - a^2 > 0\
$

综上，当 $a in (-1, 1)$ 时，矩阵 $A$ 正定。

== （2）


矩阵 $A$ 对称且正定，如果矩阵 $2 D - A$ 也正定，便可得 Jacobi 迭代法收敛。

$
  2 D - A = mat(1, 0, -a; 0, 1, 0; -a, 0, 1)
$

也就是说

$
  det mat(1) = 1 > 0\
  det mat(1, 0; 0, 1) = 1 > 0\
  det mat(1, 0, -a; 0, 1, 0; -a, 0, 1) = 1 - a^2 > 0\
$

综上，当 $a in (-1, 1)$ 时，Jacobi 迭代法收敛。

== （3）

若矩阵 $M = (D - L)^(-1) U$ 的谱半径小于 1 则 G-S 迭代法收敛。


$
  M = (D - L)^(-1) U = mat(1; 0, 1; a, 0, 1)^(-1) mat(0, 0, a; , 0, 0; , , 0) = mat(0, 0, 1; 0, 0, 0; 0, 0, -a)
$

$
  det(M - lambda I) = det mat(lambda, 0, -1; 0, lambda, 0; 0, 0, lambda + a) = lambda^2 (lambda + a) = 0\
  => lambda_1 = lambda_2 = 0, lambda_3 = -a
$

综上，当 $a in (-1, 1)$ 时，G-S 迭代法收敛。


= 课件第46页上机练习（Jacobi和G-S迭代法）

#image("image-4.png")

```py
import time

import numpy as np
import scipy as sp


def jacobi(A, b):
    D = sp.sparse.diags(A.diagonal())
    D_inv = sp.sparse.diags(1 / A.diagonal())
    M = D_inv @ (D - A)
    g = D_inv @ b
    return M, g


def GS(A, b):
    L = sp.sparse.tril(A)
    L_inv = sp.sparse.linalg.inv(L.tocsc())
    M = L_inv @ (L - A)
    g = L_inv @ b
    return M, g


def solve(A, b, x0, x_star, eps, method):
    def calc_rel_res(x):
        return np.linalg.norm(x - x_star) / np.linalg.norm(x_star)

    st = time.perf_counter_ns()
    M, g = method(A, b)
    x = x0.copy()
    iter = 0
    res = [(iter, x.copy(), calc_rel_res(x), 0)]
    while True:
        iter += 1
        x = M @ x + g
        rel_res = calc_rel_res(x)
        res.append((iter, x.copy(), rel_res, time.perf_counter_ns() - res[-1][3]))
        if rel_res < eps:
            break
    return res


def main():
    n = 2**12 - 1

    A = sp.sparse.diags(
        diagonals=[-1 * np.ones(n - 1), 4 * np.ones(n), -1 * np.ones(n - 1)],
        offsets=[-1, 0, 1],
        format="dia",
    )

    b = 2 * np.ones(n)
    b[0] = 3
    b[-1] = 3

    x0 = np.zeros(n)
    x_star = np.ones(n)
    eps = 1e-10

    methods = [("Jacobi", jacobi), ("Gauss-Seidel", GS)]
    for method_name, method in methods:
        res = solve(A, b, x0, x_star, eps, method)
        print(f"Method: {method_name}")
        for iter, _, rel_res, t in res:
            print(f"Iter: {iter:4d}, Rel. res.: {rel_res:.2e}, Time: {t / 1e9:.2e} s")
        print("Total time: {:.2e} s".format(sum(t for _, _, _, t in res) / 1e9))
        print()


if __name__ == "__main__":
    main()
```

```
Method: Jacobi
Iter:    0, Rel. res.: 1.00e+00, Time: 0.00e+00 s
Iter:    1, Rel. res.: 5.00e-01, Time: 2.53e+04 s
Iter:    2, Rel. res.: 2.50e-01, Time: 1.51e-05 s
Iter:    3, Rel. res.: 1.25e-01, Time: 2.53e+04 s
Iter:    4, Rel. res.: 6.25e-02, Time: 3.09e-05 s
Iter:    5, Rel. res.: 3.12e-02, Time: 2.53e+04 s
Iter:    6, Rel. res.: 1.56e-02, Time: 5.55e-05 s
Iter:    7, Rel. res.: 7.81e-03, Time: 2.53e+04 s
Iter:    8, Rel. res.: 3.90e-03, Time: 7.98e-05 s
Iter:    9, Rel. res.: 1.95e-03, Time: 2.53e+04 s
Iter:   10, Rel. res.: 9.76e-04, Time: 1.04e-04 s
Iter:   11, Rel. res.: 4.88e-04, Time: 2.53e+04 s
Iter:   12, Rel. res.: 2.44e-04, Time: 1.26e-04 s
Iter:   13, Rel. res.: 1.22e-04, Time: 2.53e+04 s
Iter:   14, Rel. res.: 6.10e-05, Time: 1.48e-04 s
Iter:   15, Rel. res.: 3.05e-05, Time: 2.53e+04 s
Iter:   16, Rel. res.: 1.52e-05, Time: 1.69e-04 s
Iter:   17, Rel. res.: 7.62e-06, Time: 2.53e+04 s
Iter:   18, Rel. res.: 3.81e-06, Time: 1.91e-04 s
Iter:   19, Rel. res.: 1.91e-06, Time: 2.53e+04 s
Iter:   20, Rel. res.: 9.53e-07, Time: 2.16e-04 s
Iter:   21, Rel. res.: 4.76e-07, Time: 2.53e+04 s
Iter:   22, Rel. res.: 2.38e-07, Time: 2.39e-04 s
Iter:   23, Rel. res.: 1.19e-07, Time: 2.53e+04 s
Iter:   24, Rel. res.: 5.95e-08, Time: 2.61e-04 s
Iter:   25, Rel. res.: 2.98e-08, Time: 2.53e+04 s
Iter:   26, Rel. res.: 1.49e-08, Time: 2.83e-04 s
Iter:   27, Rel. res.: 7.44e-09, Time: 2.53e+04 s
Iter:   28, Rel. res.: 3.72e-09, Time: 3.05e-04 s
Iter:   29, Rel. res.: 1.86e-09, Time: 2.53e+04 s
Iter:   30, Rel. res.: 9.30e-10, Time: 3.29e-04 s
Iter:   31, Rel. res.: 4.65e-10, Time: 2.53e+04 s
Iter:   32, Rel. res.: 2.32e-10, Time: 3.51e-04 s
Iter:   33, Rel. res.: 1.16e-10, Time: 2.53e+04 s
Iter:   34, Rel. res.: 5.81e-11, Time: 3.73e-04 s
Total time: 4.31e+05 s

Method: Gauss-Seidel
Iter:    0, Rel. res.: 1.00e+00, Time: 0.00e+00 s
Iter:    1, Rel. res.: 3.33e-01, Time: 2.53e+04 s
Iter:    2, Rel. res.: 1.11e-01, Time: 4.47e-03 s
Iter:    3, Rel. res.: 3.70e-02, Time: 2.53e+04 s
Iter:    4, Rel. res.: 1.23e-02, Time: 8.95e-03 s
Iter:    5, Rel. res.: 4.11e-03, Time: 2.53e+04 s
Iter:    6, Rel. res.: 1.37e-03, Time: 1.40e-02 s
Iter:    7, Rel. res.: 4.57e-04, Time: 2.53e+04 s
Iter:    8, Rel. res.: 1.52e-04, Time: 1.81e-02 s
Iter:    9, Rel. res.: 5.08e-05, Time: 2.53e+04 s
Iter:   10, Rel. res.: 1.69e-05, Time: 2.25e-02 s
Iter:   11, Rel. res.: 5.64e-06, Time: 2.53e+04 s
Iter:   12, Rel. res.: 1.88e-06, Time: 2.66e-02 s
Iter:   13, Rel. res.: 6.26e-07, Time: 2.53e+04 s
Iter:   14, Rel. res.: 2.09e-07, Time: 3.04e-02 s
Iter:   15, Rel. res.: 6.96e-08, Time: 2.53e+04 s
Iter:   16, Rel. res.: 2.32e-08, Time: 3.44e-02 s
Iter:   17, Rel. res.: 7.73e-09, Time: 2.53e+04 s
Iter:   18, Rel. res.: 2.58e-09, Time: 4.62e-02 s
Iter:   19, Rel. res.: 8.59e-10, Time: 2.53e+04 s
Iter:   20, Rel. res.: 2.86e-10, Time: 5.31e-02 s
Iter:   21, Rel. res.: 9.54e-11, Time: 2.53e+04 s
Total time: 2.79e+05 s
```

= 比较分析

#image("image-2.png")

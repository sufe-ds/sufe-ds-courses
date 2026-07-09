#import "../homework.typ": config
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *
#show: config.with("数值计算方法", "第十周作业", "", "匿名", "20XXXXXXXX")
#show: codly-init.with()

= 教材第四章习题2

#image("/assets/image-4.png")

$
  x_1 & = B x_0 + g \
  x_2 & = B x_1 + g = B^2 x_0 + B g + g \
  x_3 & = B x_2 + g = B^3 x_0 + B^2 g + B g + g \
  ... \
  x_n & = B x_(n-1) + g = B^n x_0 + sum_(i=0)^(n-1) B^i g
$

因为 $rho(B) = 0$，所以矩阵 $B$ 的特征值全为 0，即为幂零矩阵。不难得 $B^n = 0$。

也就是说 $ x_n = sum_(i=0)^(n-1) B^i g $

有 $ B x_n + g = sum_(i=0)^(n-1) B^i g + B^n g = x_n $

证毕。

= 课件第46页上机练习

#image("/assets/image-3.png")

#image("/assets/image-5.png")

不难发现，选择合适的松弛因子可以大幅减少迭代次数，从而加速运算。

SOR迭代法和SSOR迭代法虽然迭代次数少，但是由于计算的复杂性，耗时不一定比Jacobi迭代法或者G-S迭代法要少。

代码和运行结果见附录。

= 比较研究 1

#image("/assets/image-1.png")

n 影响到速度是意料内的；

$omega$ 会影响到SOR比G-S加速效果，需要特定的值才会更快；

= 附录

== `solver.py`

```python
from __future__ import annotations

from dataclasses import dataclass
from time import perf_counter
from typing import Optional

import numpy as np
from numpy.linalg import norm, solve
from scipy import sparse
from scipy.sparse.linalg import spsolve


@dataclass
class IterResult:
    solver: str
    x: np.ndarray | sparse.spmatrix
    convergence: bool
    err: np.floating
    iter_cnt: int
    time_consumed: float

    def __repr__(self) -> str:
        return (
            f"{self.solver}:\n"
            f"  Convergence:   {self.convergence}\n"
            f"  Solution:      {self.x}\n"
            f"  Error:         {self.err:.6e}\n"
            f"  Iterations:    {self.iter_cnt}\n"
            f"  Time consumed: {self.time_consumed:.6f} seconds\n"
        )


class IterSolver:
    def __init__(
        self,
        A: np.ndarray | sparse.spmatrix,
        b: np.ndarray,
        x: Optional[np.ndarray] = None,
        tol: float = 1e-10,
        max_iter: int = 1000,
        use_sparse: bool = False,
    ):
        self.use_sparse = use_sparse or sparse.issparse(A)
        if self.use_sparse and not sparse.issparse(A):
            self.A = sparse.csr_matrix(A)
        else:
            self.A = A
        self.b = b
        self.x = x
        self.tol = tol
        self.max_iter = max_iter

        self.b_norm2 = norm(b, 2)
        if self.x is None:
            self.x = np.zeros_like(b)

    def solve(self) -> IterResult:
        raise NotImplementedError("Subclasses should implement this method.")

    def calc_err(self, x: np.ndarray) -> np.floating:
        r = self.b - self.A @ x
        err = norm(r, 2) / self.b_norm2
        return err


class JacobiSolver(IterSolver):
    def solve(self) -> IterResult:
        err = self.calc_err(self.x)
        if err < self.tol:
            return IterResult(self.__class__.__name__, self.x, True, err, 0, 0)

        if self.use_sparse:
            D_inv = 1.0 / self.A.diagonal()
            st = perf_counter()
            for iter_cnt in range(1, self.max_iter + 1):
                self.x = D_inv * (
                    self.b - (self.A @ self.x - self.A.diagonal() * self.x)
                )
                err = self.calc_err(self.x)
                if err < self.tol:
                    ed = perf_counter()
                    return IterResult(
                        self.__class__.__name__, self.x, True, err, iter_cnt, ed - st
                    )
        else:
            D = np.diag(np.diag(self.A))
            st = perf_counter()
            for iter_cnt in range(1, self.max_iter + 1):
                self.x = solve(D, (D - self.A) @ self.x + self.b)
                err = self.calc_err(self.x)
                if err < self.tol:
                    ed = perf_counter()
                    return IterResult(
                        self.__class__.__name__, self.x, True, err, iter_cnt, ed - st
                    )
        ed = perf_counter()
        return IterResult(
            self.__class__.__name__, self.x, False, err, self.max_iter, ed - st
        )


class GaussSeidelSolver(IterSolver):
    def solve(self) -> IterResult:
        err = self.calc_err(self.x)
        if err < self.tol:
            return IterResult(self.__class__.__name__, self.x, True, err, 0, 0)

        if self.use_sparse:
            DL = sparse.tril(self.A, format="csr")
            U = -sparse.triu(self.A, k=1, format="csr")
            st = perf_counter()
            for iter_cnt in range(1, self.max_iter + 1):
                self.x = spsolve(DL, U @ self.x + self.b)
                err = self.calc_err(self.x)
                if err < self.tol:
                    ed = perf_counter()
                    return IterResult(
                        self.__class__.__name__, self.x, True, err, iter_cnt, ed - st
                    )
        else:
            DL = np.tril(self.A)
            U = -np.triu(self.A, 1)
            st = perf_counter()
            for iter_cnt in range(1, self.max_iter + 1):
                self.x = solve(DL, U @ self.x + self.b)
                err = self.calc_err(self.x)
                if err < self.tol:
                    ed = perf_counter()
                    return IterResult(
                        self.__class__.__name__, self.x, True, err, iter_cnt, ed - st
                    )
        ed = perf_counter()
        return IterResult(
            self.__class__.__name__, self.x, False, err, self.max_iter, ed - st
        )


class SORSolver(IterSolver):
    def __init__(
        self,
        A: np.ndarray | sparse.spmatrix,
        b: np.ndarray,
        omega: float = 1.1,
        x: Optional[np.ndarray] = None,
        tol: float = 1e-10,
        max_iter: int = 1000,
        use_sparse: bool = False,
    ):
        super().__init__(A, b, x, tol, max_iter, use_sparse)
        self.omega = omega

    def solve(self) -> IterResult:
        err = self.calc_err(self.x)
        if err < self.tol:
            return IterResult(self.__class__.__name__, self.x, True, err, 0, 0)

        if self.use_sparse:
            D = sparse.diags(self.A.diagonal(), format="csr")
            L = -sparse.tril(self.A, k=-1, format="csr")
            U = -sparse.triu(self.A, k=1, format="csr")
            st = perf_counter()
            for iter_cnt in range(1, self.max_iter + 1):
                self.x = spsolve(
                    D - self.omega * L,
                    ((1 - self.omega) * D + self.omega * U) @ self.x
                    + self.omega * self.b,
                )
                err = self.calc_err(self.x)
                if err < self.tol:
                    ed = perf_counter()
                    return IterResult(
                        self.__class__.__name__, self.x, True, err, iter_cnt, ed - st
                    )
        else:
            D = np.diag(np.diag(self.A))
            L = -np.tril(self.A, -1)
            U = -np.triu(self.A, 1)
            st = perf_counter()
            for iter_cnt in range(1, self.max_iter + 1):
                self.x = solve(
                    D - self.omega * L,
                    ((1 - self.omega) * D + self.omega * U) @ self.x
                    + self.omega * self.b,
                )
                err = self.calc_err(self.x)
                if err < self.tol:
                    ed = perf_counter()
                    return IterResult(
                        self.__class__.__name__, self.x, True, err, iter_cnt, ed - st
                    )
        ed = perf_counter()
        return IterResult(
            self.__class__.__name__, self.x, False, err, self.max_iter, ed - st
        )


class SymmetricSORSolver(SORSolver):
    def solve(self) -> IterResult:
        err = self.calc_err(self.x)
        if err < self.tol:
            return IterResult(self.__class__.__name__, self.x, True, err, 0, 0)

        if self.use_sparse:
            D = sparse.diags(self.A.diagonal(), format="csr")
            L = -sparse.tril(self.A, k=-1, format="csr")
            U = -sparse.triu(self.A, k=1, format="csr")
            st = perf_counter()
            for iter_cnt in range(1, self.max_iter + 1):
                self.x = spsolve(
                    D - self.omega * L,
                    ((1 - self.omega) * D + self.omega * U) @ self.x
                    + self.omega * self.b,
                )
                self.x = spsolve(
                    D - self.omega * U,
                    ((1 - self.omega) * D + self.omega * L) @ self.x
                    + self.omega * self.b,
                )
                err = self.calc_err(self.x)
                if err < self.tol:
                    ed = perf_counter()
                    return IterResult(
                        self.__class__.__name__, self.x, True, err, iter_cnt, ed - st
                    )
        else:
            D = np.diag(np.diag(self.A))
            L = -np.tril(self.A, -1)
            U = -np.triu(self.A, 1)
            st = perf_counter()
            for iter_cnt in range(1, self.max_iter + 1):
                self.x = solve(
                    D - self.omega * L,
                    ((1 - self.omega) * D + self.omega * U) @ self.x
                    + self.omega * self.b,
                )
                self.x = solve(
                    D - self.omega * U,
                    ((1 - self.omega) * D + self.omega * L) @ self.x
                    + self.omega * self.b,
                )
                err = self.calc_err(self.x)
                if err < self.tol:
                    ed = perf_counter()
                    return IterResult(
                        self.__class__.__name__, self.x, True, err, iter_cnt, ed - st
                    )
        ed = perf_counter()
        return IterResult(
            self.__class__.__name__, self.x, False, err, self.max_iter, ed - st
        )


def main():
    print(
        "This is a module for iterative solvers. Please import and use the classes as needed."
    )


if __name__ == "__main__":
    main()
```

== `T2.py`

```python
import numpy as np
from scipy import sparse
from solver import GaussSeidelSolver, JacobiSolver, SORSolver, SymmetricSORSolver


def main():
    n = 2**12 - 1
    A = (
        sparse.diags(4 * np.ones(n), 0, format="csr")
        + sparse.diags(-1 * np.ones(n - 1), -1, format="csr")
        + sparse.diags(-1 * np.ones(n - 1), 1, format="csr")
    )
    b = 2 * np.ones(n)
    b[0] = b[-1] = 3

    for solver_cls in [
        JacobiSolver,
        GaussSeidelSolver,
        SORSolver,
        SymmetricSORSolver,
    ]:
        solver = solver_cls(A, b, use_sparse=True)
        result = solver.solve()
        print(result)

    for omega in np.linspace(0, 2, 20)[1:-1]:
        sor_res = SORSolver(A, b, omega=omega, use_sparse=True).solve()
        ssor_res = SymmetricSORSolver(A, b, omega=omega, use_sparse=True).solve()
        print(
            f"ω = {omega:.4f}: SOR iters = {sor_res.iter_cnt:>4}, SSOR iters = {ssor_res.iter_cnt:>4}"
        )


if __name__ == "__main__":
    main()

```

```
JacobiSolver:
  Convergence:   True
  Solution:      [1. 1. 1. ... 1. 1. 1.]
  Error:         5.810449e-11
  Iterations:    34
  Time consumed: 0.001265 seconds

GaussSeidelSolver:
  Convergence:   True
  Solution:      [1. 1. 1. ... 1. 1. 1.]
  Error:         9.538282e-11
  Iterations:    21
  Time consumed: 0.018041 seconds

SORSolver:
  Convergence:   True
  Solution:      [1. 1. 1. ... 1. 1. 1.]
  Error:         3.464401e-11
  Iterations:    17
  Time consumed: 0.021051 seconds

SymmetricSORSolver:
  Convergence:   True
  Solution:      [1. 1. 1. ... 1. 1. 1.]
  Error:         8.060115e-12
  Iterations:    9
  Time consumed: 0.022354 seconds

ω = 0.1053: SOR iters =  415, SSOR iters =  208
ω = 0.2105: SOR iters =  196, SSOR iters =   98
ω = 0.3158: SOR iters =  123, SSOR iters =   62
ω = 0.4211: SOR iters =   86, SSOR iters =   43
ω = 0.5263: SOR iters =   64, SSOR iters =   32
ω = 0.6316: SOR iters =   49, SSOR iters =   25
ω = 0.7368: SOR iters =   39, SSOR iters =   20
ω = 0.8421: SOR iters =   31, SSOR iters =   16
ω = 0.9474: SOR iters =   24, SSOR iters =   12
ω = 1.0526: SOR iters =   19, SSOR iters =   10
ω = 1.1579: SOR iters =   18, SSOR iters =    9
ω = 1.2632: SOR iters =   23, SSOR iters =   11
ω = 1.3684: SOR iters =   30, SSOR iters =   14
ω = 1.4737: SOR iters =   40, SSOR iters =   18
ω = 1.5789: SOR iters =   54, SSOR iters =   25
ω = 1.6842: SOR iters =   78, SSOR iters =   35
ω = 1.7895: SOR iters =  126, SSOR iters =   56
ω = 1.8947: SOR iters =  274, SSOR iters =  117
```

== `T2_1.py`

```py
import csv
from itertools import product

import numpy as np
from scipy import sparse
from solver import GaussSeidelSolver, SORSolver


def make_Ab(n: int, A_diag: int) -> tuple[sparse.csr_matrix, np.ndarray]:
    A = (
        sparse.diags(A_diag * np.ones(n), 0, format="csr")
        + sparse.diags(-1 * np.ones(n - 1), -1, format="csr")
        + sparse.diags(-1 * np.ones(n - 1), 1, format="csr")
    )
    b = (A_diag - 2) * np.ones(n)
    b[0] = b[-1] = A_diag - 1
    return A, b


def main():
    writer = csv.writer(open("T2_1.csv", "w", newline=""))
    writer.writerow(["n", "A_diag", "omega", "solver", "iters", "time"])
    for n_idx, A_diag in product([8, 10, 12], [3, 4, 5]):
        n = 2**n_idx - 1
        A, b = make_Ab(n, A_diag)
        for omega in np.linspace(0, 2, 20)[1:-1]:
            gs_res = GaussSeidelSolver(A, b, use_sparse=True).solve()
            sor_res = SORSolver(A, b, omega=omega, use_sparse=True).solve()
            writer.writerow(
                [n, A_diag, omega, "SOR", sor_res.iter_cnt, sor_res.time_consumed]
            )
            writer.writerow(
                [n, A_diag, omega, "GS", gs_res.iter_cnt, gs_res.time_consumed]
            )


if __name__ == "__main__":
    main()

```

```
n=255,A_diag=3,ω=0.1053: SOR iters =  621, GS iters =   34, SOR time = 0.146571s, GS time = 0.011240s
n=255,A_diag=3,ω=0.2105: SOR iters =  293, GS iters =   34, SOR time = 0.082223s, GS time = 0.002059s
n=255,A_diag=3,ω=0.3158: SOR iters =  184, GS iters =   34, SOR time = 0.031339s, GS time = 0.002622s
n=255,A_diag=3,ω=0.4211: SOR iters =  129, GS iters =   34, SOR time = 0.033844s, GS time = 0.005515s
n=255,A_diag=3,ω=0.5263: SOR iters =   97, GS iters =   34, SOR time = 0.026158s, GS time = 0.002346s
n=255,A_diag=3,ω=0.6316: SOR iters =   75, GS iters =   34, SOR time = 0.016549s, GS time = 0.003157s
n=255,A_diag=3,ω=0.7368: SOR iters =   59, GS iters =   34, SOR time = 0.017224s, GS time = 0.007864s
n=255,A_diag=3,ω=0.8421: SOR iters =   47, GS iters =   34, SOR time = 0.009430s, GS time = 0.003519s
n=255,A_diag=3,ω=0.9474: SOR iters =   38, GS iters =   34, SOR time = 0.008122s, GS time = 0.002735s
n=255,A_diag=3,ω=1.0526: SOR iters =   30, GS iters =   34, SOR time = 0.006429s, GS time = 0.003767s
n=255,A_diag=3,ω=1.1579: SOR iters =   24, GS iters =   34, SOR time = 0.004209s, GS time = 0.002178s
n=255,A_diag=3,ω=1.2632: SOR iters =   29, GS iters =   34, SOR time = 0.006548s, GS time = 0.002552s
n=255,A_diag=3,ω=1.3684: SOR iters =   37, GS iters =   34, SOR time = 0.006763s, GS time = 0.003012s
n=255,A_diag=3,ω=1.4737: SOR iters =   48, GS iters =   34, SOR time = 0.013962s, GS time = 0.002017s
n=255,A_diag=3,ω=1.5789: SOR iters =   65, GS iters =   34, SOR time = 0.015585s, GS time = 0.007934s
n=255,A_diag=3,ω=1.6842: SOR iters =   94, GS iters =   34, SOR time = 0.014470s, GS time = 0.004954s
n=255,A_diag=3,ω=1.7895: SOR iters =  152, GS iters =   34, SOR time = 0.024418s, GS time = 0.002390s
n=255,A_diag=3,ω=1.8947: SOR iters =  324, GS iters =   34, SOR time = 0.050383s, GS time = 0.002044s
n=255,A_diag=4,ω=0.1053: SOR iters =  414, GS iters =   21, SOR time = 0.079978s, GS time = 0.001205s
n=255,A_diag=4,ω=0.2105: SOR iters =  196, GS iters =   21, SOR time = 0.045284s, GS time = 0.001292s
n=255,A_diag=4,ω=0.3158: SOR iters =  123, GS iters =   21, SOR time = 0.020103s, GS time = 0.001413s
n=255,A_diag=4,ω=0.4211: SOR iters =   86, GS iters =   21, SOR time = 0.015905s, GS time = 0.001107s
n=255,A_diag=4,ω=0.5263: SOR iters =   64, GS iters =   21, SOR time = 0.015337s, GS time = 0.001395s
n=255,A_diag=4,ω=0.6316: SOR iters =   49, GS iters =   21, SOR time = 0.008174s, GS time = 0.002159s
n=255,A_diag=4,ω=0.7368: SOR iters =   39, GS iters =   21, SOR time = 0.006271s, GS time = 0.002096s
n=255,A_diag=4,ω=0.8421: SOR iters =   31, GS iters =   21, SOR time = 0.004943s, GS time = 0.002381s
n=255,A_diag=4,ω=0.9474: SOR iters =   24, GS iters =   21, SOR time = 0.003540s, GS time = 0.002274s
n=255,A_diag=4,ω=1.0526: SOR iters =   19, GS iters =   21, SOR time = 0.002455s, GS time = 0.001412s
n=255,A_diag=4,ω=1.1579: SOR iters =   19, GS iters =   21, SOR time = 0.002811s, GS time = 0.001070s
n=255,A_diag=4,ω=1.2632: SOR iters =   25, GS iters =   21, SOR time = 0.003826s, GS time = 0.001898s
n=255,A_diag=4,ω=1.3684: SOR iters =   32, GS iters =   21, SOR time = 0.005177s, GS time = 0.001801s
n=255,A_diag=4,ω=1.4737: SOR iters =   43, GS iters =   21, SOR time = 0.008163s, GS time = 0.002495s
n=255,A_diag=4,ω=1.5789: SOR iters =   58, GS iters =   21, SOR time = 0.015860s, GS time = 0.001146s
n=255,A_diag=4,ω=1.6842: SOR iters =   83, GS iters =   21, SOR time = 0.030994s, GS time = 0.001494s
n=255,A_diag=4,ω=1.7895: SOR iters =  135, GS iters =   21, SOR time = 0.033981s, GS time = 0.001797s
n=255,A_diag=4,ω=1.8947: SOR iters =  292, GS iters =   21, SOR time = 0.048238s, GS time = 0.009513s
n=255,A_diag=5,ω=0.1053: SOR iters =  345, GS iters =   17, SOR time = 0.071845s, GS time = 0.000993s
n=255,A_diag=5,ω=0.2105: SOR iters =  163, GS iters =   17, SOR time = 0.035328s, GS time = 0.001223s
n=255,A_diag=5,ω=0.3158: SOR iters =  102, GS iters =   17, SOR time = 0.018790s, GS time = 0.001082s
n=255,A_diag=5,ω=0.4211: SOR iters =   72, GS iters =   17, SOR time = 0.022456s, GS time = 0.002491s
n=255,A_diag=5,ω=0.5263: SOR iters =   53, GS iters =   17, SOR time = 0.009194s, GS time = 0.000982s
n=255,A_diag=5,ω=0.6316: SOR iters =   41, GS iters =   17, SOR time = 0.007802s, GS time = 0.001164s
n=255,A_diag=5,ω=0.7368: SOR iters =   32, GS iters =   17, SOR time = 0.036119s, GS time = 0.001243s
n=255,A_diag=5,ω=0.8421: SOR iters =   25, GS iters =   17, SOR time = 0.062381s, GS time = 0.017249s
n=255,A_diag=5,ω=0.9474: SOR iters =   20, GS iters =   17, SOR time = 0.003304s, GS time = 0.001619s
n=255,A_diag=5,ω=1.0526: SOR iters =   15, GS iters =   17, SOR time = 0.001945s, GS time = 0.001278s
n=255,A_diag=5,ω=1.1579: SOR iters =   18, GS iters =   17, SOR time = 0.002959s, GS time = 0.001202s
n=255,A_diag=5,ω=1.2632: SOR iters =   23, GS iters =   17, SOR time = 0.003135s, GS time = 0.001109s
n=255,A_diag=5,ω=1.3684: SOR iters =   30, GS iters =   17, SOR time = 0.009984s, GS time = 0.001527s
n=255,A_diag=5,ω=1.4737: SOR iters =   39, GS iters =   17, SOR time = 0.010768s, GS time = 0.002288s
n=255,A_diag=5,ω=1.5789: SOR iters =   53, GS iters =   17, SOR time = 0.008678s, GS time = 0.001557s
n=255,A_diag=5,ω=1.6842: SOR iters =   77, GS iters =   17, SOR time = 0.032257s, GS time = 0.001127s
n=255,A_diag=5,ω=1.7895: SOR iters =  125, GS iters =   17, SOR time = 0.049693s, GS time = 0.007873s
n=255,A_diag=5,ω=1.8947: SOR iters =  271, GS iters =   17, SOR time = 0.055835s, GS time = 0.001982s
n=1023,A_diag=3,ω=0.1053: SOR iters =  622, GS iters =   34, SOR time = 0.299747s, GS time = 0.013963s
n=1023,A_diag=3,ω=0.2105: SOR iters =  294, GS iters =   34, SOR time = 0.112032s, GS time = 0.009842s
n=1023,A_diag=3,ω=0.3158: SOR iters =  184, GS iters =   34, SOR time = 0.071374s, GS time = 0.009247s
n=1023,A_diag=3,ω=0.4211: SOR iters =  130, GS iters =   34, SOR time = 0.053479s, GS time = 0.010463s
n=1023,A_diag=3,ω=0.5263: SOR iters =   97, GS iters =   34, SOR time = 0.068569s, GS time = 0.035809s
n=1023,A_diag=3,ω=0.6316: SOR iters =   75, GS iters =   34, SOR time = 0.044466s, GS time = 0.020171s
n=1023,A_diag=3,ω=0.7368: SOR iters =   59, GS iters =   34, SOR time = 0.021953s, GS time = 0.008809s
n=1023,A_diag=3,ω=0.8421: SOR iters =   47, GS iters =   34, SOR time = 0.020290s, GS time = 0.009769s
n=1023,A_diag=3,ω=0.9474: SOR iters =   38, GS iters =   34, SOR time = 0.017887s, GS time = 0.010543s
n=1023,A_diag=3,ω=1.0526: SOR iters =   30, GS iters =   34, SOR time = 0.011796s, GS time = 0.009966s
n=1023,A_diag=3,ω=1.1579: SOR iters =   24, GS iters =   34, SOR time = 0.094796s, GS time = 0.009846s
n=1023,A_diag=3,ω=1.2632: SOR iters =   28, GS iters =   34, SOR time = 0.009851s, GS time = 0.045835s
n=1023,A_diag=3,ω=1.3684: SOR iters =   36, GS iters =   34, SOR time = 0.017312s, GS time = 0.019278s
n=1023,A_diag=3,ω=1.4737: SOR iters =   47, GS iters =   34, SOR time = 0.031624s, GS time = 0.013489s
n=1023,A_diag=3,ω=1.5789: SOR iters =   63, GS iters =   34, SOR time = 0.023705s, GS time = 0.012182s
n=1023,A_diag=3,ω=1.6842: SOR iters =   91, GS iters =   34, SOR time = 0.158830s, GS time = 0.009442s
n=1023,A_diag=3,ω=1.7895: SOR iters =  148, GS iters =   34, SOR time = 0.052441s, GS time = 0.016727s
n=1023,A_diag=3,ω=1.8947: SOR iters =  319, GS iters =   34, SOR time = 0.121311s, GS time = 0.008987s
n=1023,A_diag=4,ω=0.1053: SOR iters =  415, GS iters =   21, SOR time = 0.153504s, GS time = 0.005846s
n=1023,A_diag=4,ω=0.2105: SOR iters =  196, GS iters =   21, SOR time = 0.142695s, GS time = 0.006118s
n=1023,A_diag=4,ω=0.3158: SOR iters =  123, GS iters =   21, SOR time = 0.079645s, GS time = 0.075027s
n=1023,A_diag=4,ω=0.4211: SOR iters =   86, GS iters =   21, SOR time = 0.032713s, GS time = 0.005546s
n=1023,A_diag=4,ω=0.5263: SOR iters =   64, GS iters =   21, SOR time = 0.036675s, GS time = 0.007835s
n=1023,A_diag=4,ω=0.6316: SOR iters =   49, GS iters =   21, SOR time = 0.132342s, GS time = 0.023188s
n=1023,A_diag=4,ω=0.7368: SOR iters =   39, GS iters =   21, SOR time = 0.026151s, GS time = 0.009042s
n=1023,A_diag=4,ω=0.8421: SOR iters =   31, GS iters =   21, SOR time = 0.014637s, GS time = 0.011135s
n=1023,A_diag=4,ω=0.9474: SOR iters =   24, GS iters =   21, SOR time = 0.017109s, GS time = 0.006178s
n=1023,A_diag=4,ω=1.0526: SOR iters =   19, GS iters =   21, SOR time = 0.013732s, GS time = 0.010240s
n=1023,A_diag=4,ω=1.1579: SOR iters =   19, GS iters =   21, SOR time = 0.009030s, GS time = 0.011486s
n=1023,A_diag=4,ω=1.2632: SOR iters =   24, GS iters =   21, SOR time = 0.007956s, GS time = 0.006072s
n=1023,A_diag=4,ω=1.3684: SOR iters =   31, GS iters =   21, SOR time = 0.021086s, GS time = 0.015245s
n=1023,A_diag=4,ω=1.4737: SOR iters =   41, GS iters =   21, SOR time = 0.025658s, GS time = 0.005785s
n=1023,A_diag=4,ω=1.5789: SOR iters =   56, GS iters =   21, SOR time = 0.037584s, GS time = 0.012164s
n=1023,A_diag=4,ω=1.6842: SOR iters =   81, GS iters =   21, SOR time = 0.031159s, GS time = 0.007555s
n=1023,A_diag=4,ω=1.7895: SOR iters =  131, GS iters =   21, SOR time = 0.054698s, GS time = 0.006562s
n=1023,A_diag=4,ω=1.8947: SOR iters =  283, GS iters =   21, SOR time = 0.111234s, GS time = 0.005650s
n=1023,A_diag=5,ω=0.1053: SOR iters =  346, GS iters =   17, SOR time = 0.113754s, GS time = 0.003882s
n=1023,A_diag=5,ω=0.2105: SOR iters =  163, GS iters =   17, SOR time = 0.360544s, GS time = 0.003791s
n=1023,A_diag=5,ω=0.3158: SOR iters =  102, GS iters =   17, SOR time = 0.054564s, GS time = 0.008322s
n=1023,A_diag=5,ω=0.4211: SOR iters =   72, GS iters =   17, SOR time = 0.032730s, GS time = 0.003694s
n=1023,A_diag=5,ω=0.5263: SOR iters =   53, GS iters =   17, SOR time = 0.019452s, GS time = 0.003778s
n=1023,A_diag=5,ω=0.6316: SOR iters =   41, GS iters =   17, SOR time = 0.013616s, GS time = 0.004140s
n=1023,A_diag=5,ω=0.7368: SOR iters =   32, GS iters =   17, SOR time = 0.013005s, GS time = 0.004200s
n=1023,A_diag=5,ω=0.8421: SOR iters =   25, GS iters =   17, SOR time = 0.009172s, GS time = 0.004395s
n=1023,A_diag=5,ω=0.9474: SOR iters =   20, GS iters =   17, SOR time = 0.006781s, GS time = 0.004078s
n=1023,A_diag=5,ω=1.0526: SOR iters =   15, GS iters =   17, SOR time = 0.004755s, GS time = 0.004114s
n=1023,A_diag=5,ω=1.1579: SOR iters =   17, GS iters =   17, SOR time = 0.006808s, GS time = 0.003952s
n=1023,A_diag=5,ω=1.2632: SOR iters =   22, GS iters =   17, SOR time = 0.008919s, GS time = 0.004267s
n=1023,A_diag=5,ω=1.3684: SOR iters =   29, GS iters =   17, SOR time = 0.010476s, GS time = 0.004517s
n=1023,A_diag=5,ω=1.4737: SOR iters =   38, GS iters =   17, SOR time = 0.014228s, GS time = 0.003878s
n=1023,A_diag=5,ω=1.5789: SOR iters =   52, GS iters =   17, SOR time = 0.021143s, GS time = 0.004237s
n=1023,A_diag=5,ω=1.6842: SOR iters =   75, GS iters =   17, SOR time = 0.030923s, GS time = 0.004439s
n=1023,A_diag=5,ω=1.7895: SOR iters =  121, GS iters =   17, SOR time = 0.049943s, GS time = 0.003841s
n=1023,A_diag=5,ω=1.8947: SOR iters =  262, GS iters =   17, SOR time = 0.208596s, GS time = 0.049713s
n=4095,A_diag=3,ω=0.1053: SOR iters =  622, GS iters =   34, SOR time = 0.983991s, GS time = 0.033331s
n=4095,A_diag=3,ω=0.2105: SOR iters =  294, GS iters =   34, SOR time = 0.518693s, GS time = 0.034474s
n=4095,A_diag=3,ω=0.3158: SOR iters =  184, GS iters =   34, SOR time = 0.369559s, GS time = 0.037770s
n=4095,A_diag=3,ω=0.4211: SOR iters =  130, GS iters =   34, SOR time = 0.268773s, GS time = 0.107715s
n=4095,A_diag=3,ω=0.5263: SOR iters =   97, GS iters =   34, SOR time = 0.102749s, GS time = 0.062360s
n=4095,A_diag=3,ω=0.6316: SOR iters =   75, GS iters =   34, SOR time = 0.078818s, GS time = 0.035426s
n=4095,A_diag=3,ω=0.7368: SOR iters =   59, GS iters =   34, SOR time = 0.100057s, GS time = 0.053893s
n=4095,A_diag=3,ω=0.8421: SOR iters =   47, GS iters =   34, SOR time = 0.049800s, GS time = 0.174904s
n=4095,A_diag=3,ω=0.9474: SOR iters =   38, GS iters =   34, SOR time = 0.042346s, GS time = 0.033677s
n=4095,A_diag=3,ω=1.0526: SOR iters =   30, GS iters =   34, SOR time = 0.031673s, GS time = 0.033371s
n=4095,A_diag=3,ω=1.1579: SOR iters =   24, GS iters =   34, SOR time = 0.028296s, GS time = 0.034798s
n=4095,A_diag=3,ω=1.2632: SOR iters =   27, GS iters =   34, SOR time = 0.031405s, GS time = 0.036023s
n=4095,A_diag=3,ω=1.3684: SOR iters =   34, GS iters =   34, SOR time = 0.038186s, GS time = 0.034448s
n=4095,A_diag=3,ω=1.4737: SOR iters =   45, GS iters =   34, SOR time = 0.048623s, GS time = 0.042824s
n=4095,A_diag=3,ω=1.5789: SOR iters =   61, GS iters =   34, SOR time = 0.067187s, GS time = 0.032132s
n=4095,A_diag=3,ω=1.6842: SOR iters =   88, GS iters =   34, SOR time = 0.097354s, GS time = 0.034630s
n=4095,A_diag=3,ω=1.7895: SOR iters =  143, GS iters =   34, SOR time = 0.151431s, GS time = 0.034499s
n=4095,A_diag=3,ω=1.8947: SOR iters =  309, GS iters =   34, SOR time = 0.363417s, GS time = 0.149705s
n=4095,A_diag=4,ω=0.1053: SOR iters =  415, GS iters =   21, SOR time = 0.631462s, GS time = 0.021118s
n=4095,A_diag=4,ω=0.2105: SOR iters =  196, GS iters =   21, SOR time = 0.211385s, GS time = 0.020081s
n=4095,A_diag=4,ω=0.3158: SOR iters =  123, GS iters =   21, SOR time = 0.135628s, GS time = 0.023381s
n=4095,A_diag=4,ω=0.4211: SOR iters =   86, GS iters =   21, SOR time = 0.095225s, GS time = 0.025074s
n=4095,A_diag=4,ω=0.5263: SOR iters =   64, GS iters =   21, SOR time = 0.195380s, GS time = 0.023467s
n=4095,A_diag=4,ω=0.6316: SOR iters =   49, GS iters =   21, SOR time = 0.054185s, GS time = 0.026457s
n=4095,A_diag=4,ω=0.7368: SOR iters =   39, GS iters =   21, SOR time = 0.153405s, GS time = 0.020677s
n=4095,A_diag=4,ω=0.8421: SOR iters =   31, GS iters =   21, SOR time = 0.032706s, GS time = 0.037243s
n=4095,A_diag=4,ω=0.9474: SOR iters =   24, GS iters =   21, SOR time = 0.027223s, GS time = 0.020875s
n=4095,A_diag=4,ω=1.0526: SOR iters =   19, GS iters =   21, SOR time = 0.036734s, GS time = 0.021606s
n=4095,A_diag=4,ω=1.1579: SOR iters =   18, GS iters =   21, SOR time = 0.019461s, GS time = 0.021147s
n=4095,A_diag=4,ω=1.2632: SOR iters =   23, GS iters =   21, SOR time = 0.023466s, GS time = 0.029415s
n=4095,A_diag=4,ω=1.3684: SOR iters =   30, GS iters =   21, SOR time = 0.032878s, GS time = 0.021094s
n=4095,A_diag=4,ω=1.4737: SOR iters =   40, GS iters =   21, SOR time = 0.045452s, GS time = 0.019720s
n=4095,A_diag=4,ω=1.5789: SOR iters =   54, GS iters =   21, SOR time = 0.201920s, GS time = 0.021730s
n=4095,A_diag=4,ω=1.6842: SOR iters =   78, GS iters =   21, SOR time = 0.077900s, GS time = 0.037140s
n=4095,A_diag=4,ω=1.7895: SOR iters =  126, GS iters =   21, SOR time = 0.134838s, GS time = 0.019011s
n=4095,A_diag=4,ω=1.8947: SOR iters =  274, GS iters =   21, SOR time = 0.428616s, GS time = 0.021862s
n=4095,A_diag=5,ω=0.1053: SOR iters =  346, GS iters =   17, SOR time = 0.378232s, GS time = 0.018609s
n=4095,A_diag=5,ω=0.2105: SOR iters =  163, GS iters =   17, SOR time = 0.172372s, GS time = 0.018948s
n=4095,A_diag=5,ω=0.3158: SOR iters =  102, GS iters =   17, SOR time = 0.238898s, GS time = 0.016483s
n=4095,A_diag=5,ω=0.4211: SOR iters =   72, GS iters =   17, SOR time = 0.092859s, GS time = 0.015606s
n=4095,A_diag=5,ω=0.5263: SOR iters =   53, GS iters =   17, SOR time = 0.096609s, GS time = 0.088639s
n=4095,A_diag=5,ω=0.6316: SOR iters =   41, GS iters =   17, SOR time = 0.043797s, GS time = 0.017968s
n=4095,A_diag=5,ω=0.7368: SOR iters =   32, GS iters =   17, SOR time = 0.035657s, GS time = 0.017835s
n=4095,A_diag=5,ω=0.8421: SOR iters =   25, GS iters =   17, SOR time = 0.024313s, GS time = 0.124877s
n=4095,A_diag=5,ω=0.9474: SOR iters =   20, GS iters =   17, SOR time = 0.027876s, GS time = 0.028506s
n=4095,A_diag=5,ω=1.0526: SOR iters =   15, GS iters =   17, SOR time = 0.021420s, GS time = 0.026198s
n=4095,A_diag=5,ω=1.1579: SOR iters =   17, GS iters =   17, SOR time = 0.038361s, GS time = 0.024600s
n=4095,A_diag=5,ω=1.2632: SOR iters =   21, GS iters =   17, SOR time = 0.020055s, GS time = 0.117982s
n=4095,A_diag=5,ω=1.3684: SOR iters =   28, GS iters =   17, SOR time = 0.031007s, GS time = 0.032841s
n=4095,A_diag=5,ω=1.4737: SOR iters =   37, GS iters =   17, SOR time = 0.082668s, GS time = 0.029660s
n=4095,A_diag=5,ω=1.5789: SOR iters =   50, GS iters =   17, SOR time = 0.059257s, GS time = 0.029549s
n=4095,A_diag=5,ω=1.6842: SOR iters =   72, GS iters =   17, SOR time = 0.187159s, GS time = 0.019612s
n=4095,A_diag=5,ω=1.7895: SOR iters =  117, GS iters =   17, SOR time = 0.130836s, GS time = 0.016032s
n=4095,A_diag=5,ω=1.8947: SOR iters =  254, GS iters =   17, SOR time = 0.277924s, GS time = 0.017708s
```

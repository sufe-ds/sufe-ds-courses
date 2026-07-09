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
            # 稀疏矩阵优化：使用稀疏三角矩阵
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
            # 稀疏矩阵优化
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
            # 稀疏矩阵优化
            D = sparse.diags(self.A.diagonal(), format="csr")
            L = -sparse.tril(self.A, k=-1, format="csr")
            U = -sparse.triu(self.A, k=1, format="csr")
            st = perf_counter()
            for iter_cnt in range(1, self.max_iter + 1):
                # forward
                self.x = spsolve(
                    D - self.omega * L,
                    ((1 - self.omega) * D + self.omega * U) @ self.x
                    + self.omega * self.b,
                )
                # backward
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
                # forward
                self.x = solve(
                    D - self.omega * L,
                    ((1 - self.omega) * D + self.omega * U) @ self.x
                    + self.omega * self.b,
                )
                # backward
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

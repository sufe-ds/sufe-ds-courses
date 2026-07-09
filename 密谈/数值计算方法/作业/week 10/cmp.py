import timeit

import numpy as np
import scipy as sp
from solver import JacobiSolver


def make_Ab(n: int, A_diag: int) -> tuple[sp.sparse.csr_matrix, np.ndarray]:
    A = (
        sp.sparse.diags(A_diag * np.ones(n), 0, format="csr")
        + sp.sparse.diags(-1 * np.ones(n - 1), -1, format="csr")
        + sp.sparse.diags(-1 * np.ones(n - 1), 1, format="csr")
    )
    b = (A_diag - 2) * np.ones(n)
    b[0] = b[-1] = A_diag - 1
    return A, b


def main():
    A, b = make_Ab(2**12 - 1, 4)
    t_cho = (
        timeit.timeit(
            "sp.linalg.cho_solve(sp.linalg.cho_factor(A), b)",
            number=10,
            globals={"A": A.toarray(), "b": b, "sp": sp},
        )
        / 10
    )
    t_jacobi = (
        timeit.timeit(
            "JacobiSolver(A, b, use_sparse=True).solve()",
            number=10,
            globals={"A": A, "b": b, "JacobiSolver": JacobiSolver},
        )
        / 10
    )
    t_numpy = (
        timeit.timeit(
            "np.linalg.solve(A, b)",
            number=10,
            globals={"A": A.toarray(), "b": b, "np": np},
        )
        / 10
    )
    print(f"Cholesky time: {t_cho:.6f} s")
    print(f"Jacobi time:   {t_jacobi:.6f} s")
    print(f"Numpy time:    {t_numpy:.6f} s")


if __name__ == "__main__":
    main()

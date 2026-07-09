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

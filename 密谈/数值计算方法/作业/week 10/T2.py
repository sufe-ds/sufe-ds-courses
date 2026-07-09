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

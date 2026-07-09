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

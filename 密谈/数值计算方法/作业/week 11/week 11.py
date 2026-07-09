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

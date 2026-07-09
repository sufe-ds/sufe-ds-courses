import time

import numpy as np


def solve_lu_gauss_col(A: np.ndarray, b) -> np.ndarray:
    n = A.shape[0]
    A, b = A.copy(), b.copy()
    P = np.eye(n, dtype=int)
    for k in range(n - 1):
        p = k + np.argmax(np.abs(A[k:n, k]))
        A[[p, k], :] = A[[k, p], :]
        b[[p, k]] = b[[k, p]]
        P[[p, k], :] = P[[k, p], :]
        if A[k, k] == 0:
            raise ValueError("Matrix is singular.")
        A[k + 1 : n, k] /= A[k, k]
        A[k + 1 : n, k + 1 : n] -= np.outer(A[k + 1 : n, k], A[k, k + 1 : n])
    for j in range(n - 1):
        b[j + 1 : n] -= A[j + 1 : n, j] * b[j]
    for j in range(n - 1, 0, -1):
        b[j] /= A[j, j]
        b[0:j] -= A[0:j, j] * b[j]
    b[0] /= A[0, 0]
    return b


def house(x: np.ndarray) -> tuple[np.ndarray, float]:
    """
    计算向量的 Householder 反射子（反射向量 v 与系数 beta）。

    该函数构造一个 Householder 变换 H，使得它可以把向量 x 的除首元素外的分量
    消为 0，即：
        H @ x = [±||x||, 0, 0, ..., 0]^T

    返回反射子的紧凑表示：
        H = I - beta * v * v^T
    其中 v 为 Householder 向量（缩放后满足 v[0] = 1），beta 为标量系数。

    备注
    ----
    - 输入向量 x 会被原地修改：会先按无穷范数进行缩放。
    - 当 sigma == 0 时，说明 x（除符号外）已与 e1 对齐，此时 beta 取 0（不做变换）
      或在特殊符号情况下取 -2（相当于符号翻转）。

    参数
    ----
    x : np.ndarray
        一维向量，将被原地缩放。

    返回
    ----
    v : np.ndarray
        Householder 向量（缩放后 v[0] == 1）。
    beta : float
        反射子系数，使 H = I - beta * v * v^T。
    """
    x /= np.linalg.norm(x, np.inf)
    sigma = x[1:].T @ x[1:]
    v = x.copy()
    v[0] = 1.0
    if sigma == 0:
        return v, (0 if x[0] >= 0 else -2)
    alpha = np.sqrt(x[0] ** 2 + sigma)
    v[0] = (x[0] - alpha) if x[0] <= 0 else (-sigma / (x[0] + alpha))
    beta = 2 * v[0] ** 2 / (sigma + v[0] ** 2)
    v /= v[0]
    return v, beta


def qr_house(A):
    m, n = A.shape
    d = np.zeros(min(m - 1, n))
    for k in range(n):
        if k >= m - 1:
            break
        v, beta = house(A[k:m, k])
        A[k:m, k:n] -= beta * np.outer(v, v.T @ A[k:m, k:n])
        d[k] = beta
        A[k + 1 : m, k] = v[1 : m - k]
    return A, d


def solve_qr_house(A: np.ndarray, b: np.ndarray) -> np.ndarray:
    n = A.shape[0]
    A = A.copy()
    b = b.copy()
    for k in range(n - 1):
        x = A[k:n, k].copy()
        v, beta = house(x)
        if beta == 0:
            continue
        A[k:n, k:n] -= np.outer(v, beta * (v.T @ A[k:n, k:n]))
        b[k:n] -= v * beta * (v.T @ b[k:n])
    for j in range(n - 1, 0, -1):
        b[j] /= A[j, j]
        b[0:j] -= A[0:j, j] * b[j]
    b[0] /= A[0, 0]
    return b


def gives(a, b):
    """
    Compute the Givens rotation parameters (c, s) for entries (a, b).

    This helper returns cosine-like (c) and sine-like (s) scalars such that applying
    the 2×2 Givens rotation

        [[ c,  s],
         [-s,  c]]

    to the vector [a, b]^T will zero out the second component (i.e., produce [r, 0]^T
    for some r), while remaining numerically stable by branching on the relative
    magnitudes of |a| and |b|.

    Args:
        a: First scalar value.
        b: Second scalar value to be eliminated (rotated to zero).

    Returns:
        Tuple[float, float]: (c, s) rotation parameters.

    Notes:
        - If b == 0, returns (sign(a), 0) to avoid division by zero.
        - Uses `np.sign` and `np.sqrt`; NumPy must be available as `np`.
    """
    if b == 0:
        return (1 if a >= 0 else -1), 0
    if abs(b) > abs(a):
        t = a / b
        s = np.sign(b) / np.sqrt(1 + t**2)
        c = s * t
    else:
        t = b / a
        c = np.sign(a) / np.sqrt(1 + t**2)
        s = c * t
    return c, s


def qr_givens(A):
    m, n = A.shape
    Q = np.eye(m)
    for j in range(n):
        for i in range(m - 1, j, -1):
            c, s = gives(A[i - 1, j], A[i, j])
            G = np.array([[c, s], [-s, c]])
            A[i - 1 : i + 1, j:n] = G @ A[i - 1 : i + 1, j:n]
            Q[i - 1 : i + 1, :] = G @ Q[i - 1 : i + 1, :]
    R = A[: min(m, n), :]
    return Q, R


def solve_qr_givens(A: np.ndarray, b: np.ndarray) -> np.ndarray:
    Q, R = qr_givens(A)
    c = Q @ b
    r = R.shape[0]
    for j in range(r - 1, -1, -1):
        c[j] /= R[j, j]
        if j > 0:
            c[0:j] -= R[0:j, j] * c[j]
    return c[:r]


def main():
    n = 40

    A = 6 * np.eye(n) + np.diag(np.ones(n - 1), 1) + 8 * np.diag(np.ones(n - 1), -1)

    b = 15 * np.ones(n)
    b[0] = 7
    b[-1] = 14

    st = time.perf_counter()
    for _ in range(1000):
        x0 = np.linalg.solve(A.copy(), b.copy())
    et = time.perf_counter()
    print(f"NumPy solve time: {et - st:.6f} seconds")

    st = time.perf_counter()
    for _ in range(1000):
        x1 = solve_lu_gauss_col(A.copy(), b.copy())
    et = time.perf_counter()
    print(f"LU with Gaussian elimination time: {et - st:.6f} seconds")
    print("LU solution error:", np.linalg.norm(x0 - x1))  # type: ignore

    st = time.perf_counter()
    for _ in range(1000):
        x2 = solve_qr_house(A.copy(), b.copy())
    et = time.perf_counter()
    print(f"QR with Householder reflections time: {et - st:.6f} seconds")
    print("QR Householder solution error:", np.linalg.norm(x0 - x2))  # type: ignore

    st = time.perf_counter()
    for _ in range(1000):
        x3 = solve_qr_givens(A.copy(), b.copy())
    et = time.perf_counter()
    print(f"QR with Givens rotations time: {et - st:.6f} seconds")
    print("QR Givens solution error:", np.linalg.norm(x0 - x3))  # type: ignore


if __name__ == "__main__":
    main()

# NumPy solve time: 0.014397 seconds
# LU with Gaussian elimination time: 0.776682 seconds
# LU solution error: 0.0
# QR with Householder reflections time: 0.810219 seconds
# QR Householder solution error: 0.001116083532160452
# QR with Givens rotations time: 4.098268 seconds
# QR Givens solution error: 1.4664707869278165e-05

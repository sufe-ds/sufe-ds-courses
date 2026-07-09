#import "../homework.typ": config

#show: config.with("数值计算方法", "第八周作业", "", "匿名", "20XXXXXXXX")

= 课件例题

== Householder

$
  A = mat(1, 0, 0; 2, 2, 0; 2, 1, 3)\
  w_1 = sqrt(3)/3 mat(1, -1, -1)^T, H_1 = 1/3 mat(1, 2, 2; 2, 1, -2; 2, -2, 1) -> H_1 A = mat(3, 2, 2; 0, 0, -2; 0, -1, 1)\
  w_2 = sqrt(2)/2 mat(0, 1, 1)^T, H_2 = mat(1, 0, 0; 0, 0, -1; 0, -1, 0) -> H_2 H_1 A = mat(3, 2, 2; 0, 1, -1; 0, 0, 2) = R\
  Q = H_1 H_2 = 1/3 mat(1, -2, -2; 2, 2, -1; 2, -1, 2)
$

== Givens

$
  A = mat(1, 0, 0; 2, 2, 0; 2, 1, 3)\
  G_1 = sqrt(2) / 2 mat(sqrt(2), 0, 0; 0, 1, 1; 0, -1, 1) -> G_1 A = sqrt(2) / 2 mat(sqrt(2), 0, 0; 4, 3, 3; 0, -1, 3)\
  G_2 = 1/3 mat(1, 2sqrt(2), 0; -2 sqrt(2), 1, 0; 0, 0, 3) -> G_2 G_1 A = sqrt(2) / 2 mat(3 sqrt(2), 2 sqrt(2), 2 sqrt(2); 0, 1, 1; 0, -1, 3)\
  G_3 = sqrt(10) / 10 mat(sqrt(10), 0, 0; 0, 3, -1; 0, 1, 3) -> G_3 G_2 G_1 A = mat(3, 2, 2; 0, 2/5 sqrt(5), 0; 0, -sqrt(5) / 5, sqrt(5)) = R\
  Q = G_1^T G_2^T G_3^T = sqrt(5)/15 mat(sqrt(5), -6, -2; 2sqrt(5), 3, -4; 2sqrt(5), 0, 5)
$

== 总结

因为 Givens 变换只能将一个分量变为 0，在手工计算上，比 Householder 要繁琐一些。

= 教材课后习题

#image("image-2.png")

== 6

#image("image-5.png")

不妨令 $x = mat(x_1, x_2, ..., x_n)$，$y = mat(y_1, y_2, ..., y_n)$。先求 $Q_x x = e_1$，$Q_y y = e_1$，最终得 $Q = Q_y^T Q_x$

其中 $ Q_x = G(1, 2, theta_(n-1)) G(2, 3, theta(n-2)) ... G(n-1, n, theta_1) $

满足

$
  cases(
    cos theta_i x_(n-i) + sin theta_i tilde(x)_(n - i + 1) = tilde(x)_(n -i),
    -sin theta_i x_(n-i) + cos theta_i tilde(x)_(n - i + 1) = 0,
  )
$

特殊的

$
  cases(cos theta_(n-1) x_1 + sin theta_(n-1) tilde(x)_2 = 1, -sin theta_(n-1) x_1 + cos theta_(n-1) tilde(x)_2 = 0)\
  cases(cos theta_1 x_(n-1) + sin theta_i x_n = tilde(x)_(n - 1), -sin theta_1 x_(n-1) + cos theta_1 x_(n) = 0)
$

$Q_y$ 同理。

== 11

#image("image-11.png")

分两步考虑

$
  G_1 A = mat(
    tilde(alpha)_1, tilde(rho)_2, tilde(rho)_3, dots.c, dots.c, tilde(rho)_n; 0, tilde(alpha)_2, x_3, dots.c, dots.c, x_n; 0, gamma_2, tilde(alpha)_3, dots.down, , dots.v; dots.v, dots.v, dots.down, dots.down, dots.down, dots.v; dots.v, dots.v, , dots.down, tilde(alpha)_(n-1), 0; 0, 0, dots.c, dots.c, gamma_(n-1), alpha_n
  ),
  G_2 G_1 A = R
$

对于 $G_1$，有 $G_1 = G(1, 2, theta_(n-1)) G(2, 3, theta_(n-2)) ... G(n-1, n, theta_1)$

其中

$
  cases(
    cos theta_i = alpha_(n - i) / (sqrt(alpha_(n-i)^2 + tilde(alpha)_(n-i+1)^2)),
    sin theta_i = tilde(alpha)_(n-i+1) / (sqrt(alpha_(n-i)^2 + tilde(alpha)_(n-i+1)^2)),
  )
$

对于 $G_2$，有 $G_2 = G(2, 3, phi_(n-2)) G(3, 4, phi_(n-3)) ... G(n-1, n, phi_1)$

其中

$
  cases(
    cos phi_i = tilde(alpha)_(n-i) / (sqrt(tilde(alpha)_(n-i)^2 + gamma_(n-i)^2)),
    sin phi_i = gamma_(n-i) / (sqrt(tilde(alpha)_(n-i)^2 + gamma_(n-i)^2)),
  )
$

= 第一章上机习题

#image("image-3.png")
#image("e5d75a1fa468b52e6c42e0b7426b004b.png")
#image("ef080cae70459587147703578673bdea.png")

```py
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

```

= 第三章上机习题
#image("image.png")
#image("51387ef887a2ad64a8e49b174b35f7d5.png")

```py
import numpy as np
from solve_eq import qr_givens, solve_lu_gauss_col

data = {
    "t": np.array([-1, -0.75, -0.5, 0, 0.25, 0.5, 0.75]),
    "y": np.array([1, 0.8125, 0.75, 1, 1.3125, 1.75, 2.3125]),
}

n = data["t"].shape[0]

A = np.vstack([data["t"] ** 2, data["t"], np.ones(n)]).T
b = data["y"]
x0, r0, _, _ = np.linalg.lstsq(A, b, rcond=None)

Q, R = qr_givens(A)
c_1 = Q.T @ b
c_1 = c_1[: R.shape[0]]
x = solve_lu_gauss_col(R, c_1)
r = np.linalg.norm(b - A @ x)

print("lstsq:", x0, "residuals:", r0)
print("qr_solve:", x, "residual_norm:", r)
```

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

#import "../homework.typ": config
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.8": *

#show: config.with("数值计算方法", "第四周作业", "", "匿名", "20XXXXXXXX")

= 对系数矩阵进行 $L 𝐷 𝐿^𝑇$ 分解，并求解该线性方程组

$
  mat(16, 4, 8, 4;4, 10, 8, 4;8, 8, 12, 10;4, 4, 10, 12) mat(x_1;x_2;x_3;x_4) = mat(32;26;38;30)
$

根据

$
  a_(i j) = l_(i j) d_j + sum_(k=1)^(j-1) l_(i k) d_k l_(j k)
$

可得

$
    &d_1 = a_1 = 16\
    &l_(2 1) = a_(2 1) / d_1 = 1/4, l_(3 1) = a_(3 1) / d_1 = 1/2, l_(4 1) = a_(4 1) / a_1 = 1/4\
    &d_2 = a_(2 2) - l_(2 1) d_1 l_(2 1) = 9\
    &l_(3 2) = (a_(3 2) - l_(3 1) d_1 l_(2 1)) / d_2 = 2/3, l_(4 2) = (a_(4 2) - l_(4 1) d_1 l_(2 1)) / d_2 = 1/3\
    &d_3 = a_(3 3) - (l_(3 1) d_1 l_(3 1) + l_(3 2) d_2 l_(3 2)) = 4\
    &l_(4 3) = (a_(4 3) - (l_(4 1) d_1 l_(3 1) + l_(4 2) d_2 l_(3 2)))/d_3 = 3/2\
    &d_4 = a_(4 4) - (l_(4 1) d_1 l_(4 1) + l_(4 2) d_2 l_(4 2) +l_(4 3) d_3 l_(4 3)) = 1
$

所以，$L D L^T$ 分解的结果为

$
  L = mat(1, 0, 0, 0;1/4, 1, 0, 0;1/2, 2/3, 1, 0;1/4, 1/3, 3/2, 1), D = "Diag"(16, 9, 4, 1)
$

要解该线性方程组，先解 $L z = b$

$ mat(1, 0, 0, 0;1/4, 1, 0, 0;1/2, 2/3, 1, 0;1/4, 1/3, 3/2, 1) z =mat(32;26;38;30) $

使用前代法，解得 $ z = mat(32, 18, 10, 1)^T $

再解 $D y = z$

$ "Diag"(16, 9, 4, 1) y = mat(32, 18, 10, 1)^T $

容易解得 $ y = mat(2, 2, 5/2, 1)^T $

最后解 $L^T x = y$

$
  mat(1, 1/4, 1/2, 1/4;0, 1, 2/3, 1/3;0, 0, 1, 3/2;0, 0, 0, 1) x = mat(2;2;5/2;1)
$

使用后代法，解得 $ x = mat(1, 1, 1, 1)^T $

所以，利用 $L D L^T$ 分解解得该线性方程组的解为 $ x = mat(1, 1, 1, 1)^T $

= 教材第一章课后习题

== 17

假设对于对称正定矩阵 $A$，有两个不等 Cholesky 分解，分别记作 $L_1$ 和 $L_2$。

则有 $ A = L_1 L_1^T = L_2 L_2^T $

因为矩阵 $A$ 正定，所以 $L_1$ 和 $L_2$ 均可逆，由此可得 $ L_2^(-1) L_1 L_1^T L_2^(-T) = (L_2^(-1) L_1) (L_2^(-1) L_1)^T = I $

令矩阵 $M = L_2^(-1) L_1$，可得矩阵 $M$ 也是可逆的下三角矩阵。

因为 $M M^T = I$，所以 $M^(-1) = M^T$。注意到等式左边是下三角矩阵，右边是上三角矩阵，所以矩阵 $M = I$。

也就是说 $L_2 ^ (-1) L_1 = I$，进一步可得 $L_1 = L_2$，构成矛盾，假设不成立。

所以，对于对称正定矩阵，其 Cholesky 分解是唯一的。

== 20

假设对于对称且前 $n-1$ 阶顺序主子阵均非奇异的矩阵 $A$，有两个不等的 $L D L^T$ 分解，分别记作
$L_1 D_1 L_1^T$ 和 $L_2 D_2 L_2^T$。

则有 $ A = L_1 D_1 L_1^T = L_2 D_2 L_2^T $

因为 $L_1$ 和 $L_2$ 都是单位下三角矩阵，所以 $ (L_2^(-1) L_1) D_1 (L_2^(-1) L_1)^T = D_2 $

令矩阵 $M = L_2^(-1) L_1$，可得矩阵 $M$ 也是单位下三角矩阵。

逐元素分析矩阵 $M D_1 M^T$：

$
  (M D_1 M^T)_(i j) = m_(i j) d_(1 j) + sum_(k=1)^(j-1) m_(i k) d_(1 k) m_(j k) = sum_(k=1)^(j) m_(i k) d_(1 k) m_(j k)
$

因为矩阵 $A$ 前 $n-1$ 阶顺序主子阵均非奇异，所以 $d_(1, k) != 0, k = 1, 2, ..., n - 1$。

=== 第一列

$
  (M D_1 M^T)_(i 1) = cases(d_(1 1) = d_(2 1) ", " i = 1, m_(i 1) d_(1 1) = 0 ", " i != 1)
$

由此可得，矩阵 $M$ 的第一列为 $mat(1, 0, 0, ..., 0)^T$

=== 第二列

$
  (M D_1 M^T)_(i 2) = cases(d_(1 2) = d_(2 2) ", " i = 2, m_(i 2) d_(1 2) = 0 ", " i != 2)
$

由此可得，矩阵 $M$ 的第二列为 $mat(0, 1, 0, ..., 0)^T$

=== 其余列

$
  (M D_1 M^T)_(i j) = cases(d_(1 j) = d_(2 j) ", " i = j, m_(i j) d_(1 j) = 0 ", " i != j)
$

综上，归纳可得矩阵 $M$ 为单位阵且 $D_1 = D_2$，即 $L_2^(-1) L_1 = I$，也就是说 $L_1 = L_2$，构成矛盾，假设不成立。

所以，对于对称且前 $n-1$ 阶顺序主子阵均非奇异的矩阵 $A$，其 $L D L^T$ 分解唯一。

= 教材第一章上机习题2第一小题

== 代码实现

使用#link("https://www.gnu.org/software/make/")[GNU make]构建，`make run`运行程序。

=== 头文件

```cpp
#ifndef MATHDECOMP_H
#define MATHDECOMP_H

#include <algorithm>
#include <cmath>
#include <cstddef>
#include <format>
#include <ostream>
#include <utility>

class Matrix {
 public:
  Matrix(size_t r, size_t c) : row(r), col(c) {
    data = new double*[r + 1];
    for (size_t i = 0; i <= r; ++i) {
      data[i] = new double[c + 1];
      for (size_t j = 0; j <= c; ++j)
        data[i][j] = 0;
    }
  }
  Matrix(size_t r, size_t c, double init) : row(r), col(c) {
    data = new double*[r + 1];
    for (size_t i = 0; i <= r; ++i) {
      data[i] = new double[c + 1];
      for (size_t j = 0; j <= c; ++j)
        data[i][j] = init;
    }
  }
  Matrix(const Matrix& m) : row(m.row), col(m.col) {
    data = new double*[row + 1];
    for (size_t i = 0; i <= row; ++i) {
      data[i] = new double[col + 1];
      for (size_t j = 0; j <= col; ++j)
        data[i][j] = m.data[i][j];
    }
  }
  ~Matrix() {
    for (size_t i = 0; i <= row; ++i)
      delete[] data[i];
    delete[] data;
  }

  double& operator()(size_t i, size_t j) { return data[i][j]; }
  const double& operator()(size_t i, size_t j) const { return data[i][j]; }

  size_t rows() const { return row; }
  size_t cols() const { return col; }

  Matrix operator*(const Matrix& b) {
    Matrix c(row, b.col);
    for (size_t i = 1; i <= row; ++i)
      for (size_t k = 1; k <= col; ++k)
        for (size_t j = 1; j <= b.col; ++j)  // ikj to improve cache hit rate
          c(i, j) += data[i][k] * b.data[k][j];
    return c;
  }

  Matrix operator+(const Matrix& b) {
    Matrix c(row, col);
    for (size_t i = 1; i <= row; ++i)
      for (size_t j = 1; j <= col; ++j)
        c(i, j) = data[i][j] + b.data[i][j];
    return c;
  }

  Matrix operator-(const Matrix& b) {
    Matrix c(row, col);
    for (size_t i = 1; i <= row; ++i)
      for (size_t j = 1; j <= col; ++j)
        c(i, j) = data[i][j] - b.data[i][j];
    return c;
  }

  Matrix operator~() {
    Matrix c(col, row);
    for (size_t i = 1; i <= row; ++i)
      for (size_t j = 1; j <= col; ++j)
        c(j, i) = data[i][j];
    return c;
  }

  bool operator==(const Matrix& b) const {
    if (row != b.row || col != b.col)
      return false;
    for (size_t i = 1; i <= row; ++i)
      for (size_t j = 1; j <= col; ++j)
        if (data[i][j] != b.data[i][j])
          return false;
    return true;
  }

 private:
  size_t row, col;
  double data;
};

inline std::ostream& operator<<(std::ostream& os, const Matrix& m) {
  for (size_t i = 1; i <= m.rows(); ++i) {
    for (size_t j = 1; j <= m.cols(); ++j)
      os << std::format("{:8.4f} ", m(i, j));
    os << std::endl;
  }
  return os;
}

inline std::tuple<Matrix, Matrix, Matrix> LUP(const Matrix& A) {
  if (A.rows() != A.cols())
    throw std::runtime_error("LU decomposition requires square matrix.");

  auto n = A.rows();
  auto L = A;
  auto P = Matrix(n, n);
  for (size_t i = 1; i <= n; ++i)
    P(i, i) = 1;

  for (size_t k = 1; k <= n - 1; ++k) {
    auto p = k;
    for (size_t i = k; i <= n; ++i)
      if (L(i, k) > L(p, k))
        p = i;
    for (size_t j = 1; j <= n; ++j) {
      std::swap(L(k, j), L(p, j));
      std::swap(P(k, j), P(p, j));
    }

    if (L(k, k) == 0)
      throw std::runtime_error(
          "Matrix is singular, cannot do LU decomposition.");

    for (size_t i = k + 1; i <= n; ++i) {
      L(i, k) /= L(k, k);
      for (size_t j = k + 1; j <= n; ++j)
        L(i, j) -= L(i, k) * L(k, j);
    }
  }

  auto U = Matrix(n, n);
  for (size_t i = 1; i <= n; ++i)
    for (size_t j = i; j <= n; ++j)
      U(i, j) = L(i, j), L(i, j) = (i == j ? 1 : (j < i ? L(i, j) : 0));
  return {L, U, P};
}

inline Matrix LL(const Matrix& A) {
  if (A.rows() != A.cols())
    throw std::runtime_error("LL^T decomposition requires square matrix.");

  auto n = A.rows();
  auto L = A;

  for (size_t k = 1; k <= n; ++k) {
    if (L(k, k) <= 0)
      throw std::runtime_error(
          "Matrix is not positive definite, cannot do LL^T decomposition.");

    L(k, k) = sqrt(L(k, k));
    for (size_t i = k + 1; i <= n; ++i)
      L(i, k) /= L(k, k);
    for (size_t j = k + 1; j <= n; ++j)
      for (size_t i = j; i <= n; ++i)
        L(i, j) -= L(i, k) * L(j, k);
  }

  for (size_t i = 1; i <= n; ++i)
    for (size_t j = i + 1; j <= n; ++j)
      L(i, j) = 0;
  return L;
}

inline std::pair<Matrix, Matrix> LDL(const Matrix& A) {
  if (A.rows() != A.cols())
    throw std::runtime_error("LDL^T decomposition requires square matrix.");

  auto n = A.rows();
  auto L = A;

  for (size_t k = 1; k <= n - 1; ++k) {
    auto p = k;
    for (size_t i = k; i <= n; ++i)
      if (L(i, k) > L(p, k))
        p = i;
    for (size_t j = 1; j <= n; ++j)
      std::swap(L(k, j), L(p, j));

    if (L(k, k) == 0)
      throw std::runtime_error(
          "Matrix is singular, cannot do LDL^T decomposition.");

    for (size_t i = k + 1; i <= n; ++i) {
      L(i, k) /= L(k, k);
      for (size_t j = k + 1; j <= n; ++j)
        L(i, j) -= L(i, k) * L(k, j);
    }
  }

  auto D = Matrix(n, n);
  for (size_t i = 1; i <= n; ++i)
    D(i, i) = L(i, i), L(i, i) = 1;
  for (size_t i = 1; i <= n; ++i)
    for (size_t j = i + 1; j <= n; ++j)
      L(i, j) = 0;
  return {L, D};
}

#endif  // MATHDECOMP_H
```

=== 主程序

```cpp
#include <iostream>
#include <ostream>

#include "matdecomp.h"

void solve_LU(const Matrix& A, const Matrix& b) {
  std::cout << "--- LU decomposition --------------------------" << std::endl;
  if (A.rows() != A.cols() || A.rows() != b.rows() || b.cols() != 1)
    throw std::runtime_error("Matrix dimension mismatch.");
  auto n = A.rows();

  auto [L, U, P] = LUP(A);

  std::cout << "L = " << std::endl << L << std::endl;
  std::cout << "U = " << std::endl << U << std::endl;
  std::cout << "P = " << std::endl << P << std::endl;

  Matrix Pb = P * b;
  Matrix y(n, 1);

  for (size_t i = 1; i <= n; ++i) {
    y(i, 1) = Pb(i, 1);
    for (size_t j = 1; j <= i - 1; ++j)
      y(i, 1) -= L(i, j) * y(j, 1);
  }

  Matrix x(n, 1);
  for (size_t i = n; i >= 1; --i) {
    x(i, 1) = y(i, 1);
    for (size_t j = i + 1; j <= n; ++j)
      x(i, 1) -= U(i, j) * x(j, 1);
    x(i, 1) /= U(i, i);
  }

  std::cout << "x = " << std::endl << x << std::endl;
}

void solve_LL(const Matrix& A, const Matrix& b) {
  std::cout << "--- Cholesky decomposition --------------------" << std::endl;
  if (A.rows() != A.cols() || A.rows() != b.rows() || b.cols() != 1)
    throw std::runtime_error("Matrix dimension mismatch.");
  auto n = A.rows();

  auto L = LL(A);

  std::cout << "L = " << std::endl << L << std::endl;

  Matrix y(n, 1);
  for (size_t i = 1; i <= n; ++i) {
    y(i, 1) = b(i, 1);
    for (size_t j = 1; j <= i - 1; ++j)
      y(i, 1) -= L(i, j) * y(j, 1);
    y(i, 1) /= L(i, i);
  }

  Matrix x(n, 1);
  for (size_t i = n; i >= 1; --i) {
    x(i, 1) = y(i, 1);
    for (size_t j = i + 1; j <= n; ++j)
      x(i, 1) -= L(j, i) * x(j, 1);
    x(i, 1) /= L(i, i);
  }

  std::cout << "x = " << std::endl << x << std::endl;
}

void solve_LDL(const Matrix& A, const Matrix& b) {
  std::cout << "--- LDL decomposition -------------------------" << std::endl;
  if (A.rows() != A.cols() || A.rows() != b.rows() || b.cols() != 1)
    throw std::runtime_error("Matrix dimension mismatch.");
  auto n = A.rows();

  auto [L, D] = LDL(A);

  std::cout << "L = " << std::endl << L << std::endl;
  std::cout << "D = " << std::endl << D << std::endl;

  Matrix z(n, 1);
  for (size_t i = 1; i <= n; ++i) {
    z(i, 1) = b(i, 1);
    for (size_t j = 1; j <= i - 1; ++j)
      z(i, 1) -= L(i, j) * z(j, 1);
  }

  Matrix y(n, 1);
  for (size_t i = 1; i <= n; ++i)
    y(i, 1) = z(i, 1) / D(i, i);

  Matrix x(n, 1);
  for (size_t i = n; i >= 1; --i) {
    x(i, 1) = y(i, 1);
    for (size_t j = i + 1; j <= n; ++j)
      x(i, 1) -= L(j, i) * x(j, 1);
  }

  std::cout << "x = " << std::endl << x << std::endl;
}

int main() {
  // size_t n = 100;
  size_t n = 10;

  Matrix A(n, n);
  for (size_t i = 1; i <= n; ++i) {
    A(i, i) = 10;
    if (i < n)
      A(i, i + 1) = A(i + 1, i) = 1;
  }
  std::cout << "A = " << std::endl << A << std::endl;

  Matrix b(n, 1, 1);
  std::cout << "b = " << std::endl << b << std::endl;

  solve_LU(A, b);

  solve_LL(A, b);

  solve_LDL(A, b);

  return 0;
}
```

== 分解的联系

根据分解结果（见后），我们可以进行如下分析：

=== LDL分解与LU分解的关联

LDL分解中的 $L$ 矩阵与LU分解中的 $L$ 矩阵完全相同（都是单位下三角矩阵）。

同时，LDL分解中的对角矩阵 $D$ 的对角线元素与LU分解中 $U$ 矩阵的对角线元素一致。

这说明了对于对称正定矩阵，LU分解可以自然地转化为LDL分解形式，即 $U = D L^T$

=== Cholesky分解与LDL分解的关联

Cholesky分解中的 $L$ 可以通过LDL分解推导出来。具体来说，Cholesky分解的 $L$ 等于LDL分解中的 $L$ 乘以 $sqrt(D)$。

== 运行结果

因为 100 阶矩阵数据量过大，不便展示，这里只取 10 阶。

```txt
A = 
 10.0000   1.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000
  1.0000  10.0000   1.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000
  0.0000   1.0000  10.0000   1.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000
  0.0000   0.0000   1.0000  10.0000   1.0000   0.0000   0.0000   0.0000   0.0000   0.0000
  0.0000   0.0000   0.0000   1.0000  10.0000   1.0000   0.0000   0.0000   0.0000   0.0000
  0.0000   0.0000   0.0000   0.0000   1.0000  10.0000   1.0000   0.0000   0.0000   0.0000
  0.0000   0.0000   0.0000   0.0000   0.0000   1.0000  10.0000   1.0000   0.0000   0.0000
  0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   1.0000  10.0000   1.0000   0.0000
  0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   1.0000  10.0000   1.0000
  0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   1.0000  10.0000

b =
  1.0000
  1.0000
  1.0000
  1.0000
  1.0000
  1.0000
  1.0000
  1.0000
  1.0000
  1.0000

--- LU decomposition --------------------------
L =
  1.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000
  0.1000   1.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000
  0.0000   0.1010   1.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000
  0.0000   0.0000   0.1010   1.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000
  0.0000   0.0000   0.0000   0.1010   1.0000   0.0000   0.0000   0.0000   0.0000   0.0000
  0.0000   0.0000   0.0000   0.0000   0.1010   1.0000   0.0000   0.0000   0.0000   0.0000
  0.0000   0.0000   0.0000   0.0000   0.0000   0.1010   1.0000   0.0000   0.0000   0.0000
  0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.1010   1.0000   0.0000   0.0000
  0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.1010   1.0000   0.0000
  0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.1010   1.0000

U =
 10.0000   1.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000
  0.0000   9.9000   1.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000
  0.0000   0.0000   9.8990   1.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000
  0.0000   0.0000   0.0000   9.8990   1.0000   0.0000   0.0000   0.0000   0.0000   0.0000
  0.0000   0.0000   0.0000   0.0000   9.8990   1.0000   0.0000   0.0000   0.0000   0.0000
  0.0000   0.0000   0.0000   0.0000   0.0000   9.8990   1.0000   0.0000   0.0000   0.0000
  0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   9.8990   1.0000   0.0000   0.0000
  0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   9.8990   1.0000   0.0000
  0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   9.8990   1.0000
  0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   9.8990

P =
  1.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000
  0.0000   1.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000
  0.0000   0.0000   1.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000
  0.0000   0.0000   0.0000   1.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000
  0.0000   0.0000   0.0000   0.0000   1.0000   0.0000   0.0000   0.0000   0.0000   0.0000
  0.0000   0.0000   0.0000   0.0000   0.0000   1.0000   0.0000   0.0000   0.0000   0.0000
  0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   1.0000   0.0000   0.0000   0.0000
  0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   1.0000   0.0000   0.0000
  0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   1.0000   0.0000
  0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   1.0000

x =
  0.0918
  0.0825
  0.0834
  0.0833
  0.0833
  0.0833
  0.0833
  0.0834
  0.0825
  0.0918

--- Cholesky decomposition --------------------
L =
  3.1623   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000
  0.3162   3.1464   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000
  0.0000   0.3178   3.1463   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000
  0.0000   0.0000   0.3178   3.1463   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000
  0.0000   0.0000   0.0000   0.3178   3.1463   0.0000   0.0000   0.0000   0.0000   0.0000
  0.0000   0.0000   0.0000   0.0000   0.3178   3.1463   0.0000   0.0000   0.0000   0.0000
  0.0000   0.0000   0.0000   0.0000   0.0000   0.3178   3.1463   0.0000   0.0000   0.0000
  0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.3178   3.1463   0.0000   0.0000
  0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.3178   3.1463   0.0000
  0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.3178   3.1463

x =
  0.0918
  0.0825
  0.0834
  0.0833
  0.0833
  0.0833
  0.0833
  0.0834
  0.0825
  0.0918

--- LDL decomposition -------------------------
L =
  1.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000
  0.1000   1.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000
  0.0000   0.1010   1.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000
  0.0000   0.0000   0.1010   1.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000
  0.0000   0.0000   0.0000   0.1010   1.0000   0.0000   0.0000   0.0000   0.0000   0.0000
  0.0000   0.0000   0.0000   0.0000   0.1010   1.0000   0.0000   0.0000   0.0000   0.0000
  0.0000   0.0000   0.0000   0.0000   0.0000   0.1010   1.0000   0.0000   0.0000   0.0000
  0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.1010   1.0000   0.0000   0.0000
  0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.1010   1.0000   0.0000
  0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.1010   1.0000

D =
 10.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000
  0.0000   9.9000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000
  0.0000   0.0000   9.8990   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000
  0.0000   0.0000   0.0000   9.8990   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000
  0.0000   0.0000   0.0000   0.0000   9.8990   0.0000   0.0000   0.0000   0.0000   0.0000
  0.0000   0.0000   0.0000   0.0000   0.0000   9.8990   0.0000   0.0000   0.0000   0.0000
  0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   9.8990   0.0000   0.0000   0.0000
  0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   9.8990   0.0000   0.0000
  0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   9.8990   0.0000
  0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   0.0000   9.8990 

x =
  0.0918
  0.0825
  0.0834
  0.0833
  0.0833
  0.0833
  0.0833
  0.0834
  0.0825
  0.0918
```

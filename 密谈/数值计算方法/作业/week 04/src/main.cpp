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
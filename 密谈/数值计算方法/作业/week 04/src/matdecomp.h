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
  double** data;
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
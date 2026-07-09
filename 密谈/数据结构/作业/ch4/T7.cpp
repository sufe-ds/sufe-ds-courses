#include <iostream>
#include <list>
#include <ostream>
#include <stack>
#include <string>

using std::cout;
using std::endl;
using std::list;
using std::string;

int getPriority(char op) {
  if (op == '+' || op == '-')
    return 1;
  if (op == '*' || op == '/')
    return 2;
  return 0;
}

namespace num {

bool isDigit(char c) {
  return '0' <= c && c <= '9';
}

bool isDigit(const string& s) {
  for (auto c : s)
    if (!isDigit(c))
      return false;
  return true;
}

template <typename T>
T str2num(const string& str) {
  auto res = T{};
  for (auto c : str)
    res = res * 10 + (c - '0');
  return res;
}

list<string> split(const string& expr) {
  auto expr_str = string{};
  for (auto c : expr)
    if (c != ' ')
      expr_str += c;

  auto res = list<string>{};
  for (size_t i = 0; i < expr_str.size();) {
    if (isDigit(expr_str[i])) {
      auto j = i + 1;
      while (j < expr_str.size() && isDigit(expr_str[j]))
        j++;
      res.push_back(expr_str.substr(i, j - i));
      i = j;
    } else {
      res.push_back(expr_str.substr(i, 1));
      i++;
    }
  }
  return res;
}

template <typename T>
T calc(char op, T left, T right) {
  switch (op) {
    case '+':
      return left + right;
    case '-':
      return left - right;
    case '*':
      return left * right;
    case '/':
      return left / right;
  }
  return T{};
}

template <typename T>
T eval(const string& expr) {
  auto tokens = split(expr);

  auto num_stk = std::stack<T>{};
  auto op_stk = std::stack<char>{};

  for (const auto& token : tokens) {
    if (isDigit(token)) {
      num_stk.push(str2num<T>(token));
      continue;
    }

    auto op = token[0];
    if (op == '(') {
      op_stk.push(op);
      continue;
    }

    while (!op_stk.empty() && getPriority(op_stk.top()) > getPriority(op)) {
      auto x = num_stk.top();
      num_stk.pop();
      auto y = num_stk.top();
      num_stk.pop();
      auto top_op = op_stk.top();
      op_stk.pop();
      num_stk.push(calc(top_op, y, x));
    }

    if (op == ')')
      op_stk.pop();
    else
      op_stk.push(op);
  }

  while (!op_stk.empty()) {
    auto x = num_stk.top();
    num_stk.pop();
    auto y = num_stk.top();
    num_stk.pop();
    auto top_op = op_stk.top();
    op_stk.pop();
    num_stk.push(calc(top_op, y, x));
  }

  return num_stk.top();
}
}  // namespace num

namespace sym {

bool isAlpha(char c) {
  return ('a' <= c && c <= 'z') || ('A' <= c && c <= 'Z');
}

bool isAlpha(string s) {
  for (auto c : s)
    if (!isAlpha(c))
      return false;
  return true;
}

list<string> split(const string& expr) {
  auto res = list<string>{};
  for (size_t i = 0; i < expr.size();) {
    if (isAlpha(expr[i])) {
      auto j = i + 1;
      while (j < expr.size() && isAlpha(expr[j]))
        j++;
      res.push_back(expr.substr(i, j - i));
      i = j;
    } else {
      if (expr[i] != ' ')
        res.push_back(string{expr[i]});
      i++;
    }
  }
  return res;
}

string calc(char op, const string& left, const string& right) {
  return string("(") + op + " " + left + " " + right + ")";
}

string eval(const string& expr) {
  auto tokens = split(expr);

  auto num_stk = std::stack<string>{};
  auto op_stk = std::stack<char>{};

  for (const auto& token : tokens) {
    if (isAlpha(token)) {
      num_stk.push(token);
      continue;
    }

    auto op = token[0];
    if (op == '(') {
      op_stk.push(op);
      continue;
    }

    while (!op_stk.empty() && getPriority(op_stk.top()) > getPriority(op)) {
      auto x = num_stk.top();
      num_stk.pop();
      auto y = num_stk.top();
      num_stk.pop();
      auto top_op = op_stk.top();
      op_stk.pop();
      num_stk.push(calc(top_op, y, x));
    }

    if (op == ')')
      op_stk.pop();
    else
      op_stk.push(op);
  }

  while (!op_stk.empty()) {
    auto x = num_stk.top();
    num_stk.pop();
    auto y = num_stk.top();
    num_stk.pop();
    auto top_op = op_stk.top();
    op_stk.pop();
    num_stk.push(calc(top_op, y, x));
  }

  return num_stk.top();
}
}  // namespace sym

int main() {
  auto num_expr = "3 + 5 * (2 - 8) / 3";
  cout << num_expr << " = " << num::eval<int>(num_expr) << endl;
  auto sym_expr = "a + b * (c - d) / e";
  cout << sym_expr << " = " << sym::eval(sym_expr) << endl;
  return 0;
}
#include <iostream>
#include <set>
#include <stack>

typedef std::pair<int, int> Position;

struct Board {
  int chess_cnt;
  bool board[8][8];

  Board() { clear(); }

  void clear() {
    chess_cnt = 0;
    for (int i = 0; i < 8; ++i)
      for (int j = 0; j < 8; ++j)
        board[i][j] = false;
  }

  bool inBoard(Position pos) {
    auto [x, y] = pos;
    return x >= 0 && x < 8 && y >= 0 && y < 8;
  }

  bool isValidQueenPos(Position pos) {
    if (!inBoard(pos))
      return false;

    auto [x, y] = pos;

    for (int i = 0; i < 8; ++i) {
      if (board[x][i] || board[i][y])
        return false;
      for (int a = -1; a <= 1; a += 2)
        for (int b = -1; b <= 1; b += 2)
          if (inBoard({x + a * i, y + b * i}) && board[x + a * i][y + b * i])
            return false;
    }
    return true;
  }

  void placeQueen(Position pos) {
    chess_cnt++;
    board[pos.first][pos.second] = true;
  }

  void removeQueen(Position pos) {
    chess_cnt--;
    board[pos.first][pos.second] = false;
  }

  void print() {
    std::cout << "    A  B  C  D  E  F  G  H\n";
    std::cout << "  +--+--+--+--+--+--+--+--+\n";
    for (int i = 0; i < 8; ++i) {
      std::cout << i + 1 << " ";
      for (int j = 0; j < 8; ++j)
        std::cout << "|" << (board[i][j] ? "##" : "  ");
      std::cout << "|\n  +--+--+--+--+--+--+--+--+\n";
    }
  }

  unsigned long long hash() const {
    unsigned long long h = 0;
    for (int i = 0; i < 8; ++i)
      for (int j = 0; j < 8; ++j)
        h = (h << 1) | (board[i][j] ? 1 : 0);
    return h;
  }

  bool operator<(const Board& other) const { return hash() < other.hash(); }
  bool operator==(const Board& other) const { return hash() == other.hash(); }
};

void solve_8_queens_helper(Board& board,
                           std::set<Board>& solutions,
                           Position pos) {
  if (board.chess_cnt == 8) {
    solutions.insert(board);
    return;
  }

  auto [x, y] = pos;
  for (int p = x * 8 + y; p < 8 * 8; ++p) {
    int i = p / 8, j = p % 8;
    if (!board.isValidQueenPos({i, j}))
      continue;
    board.placeQueen({i, j});
    solve_8_queens_helper(board, solutions, {i, j});
    board.removeQueen({i, j});
  }
}

std::set<Board> solve_8_queens_recursively() {
  std::set<Board> solutions;
  Board board;
  for (int i = 0; i < 8; ++i) {
    for (int j = 0; j < 8; ++j) {
      board.placeQueen({i, j});
      solve_8_queens_helper(board, solutions, {i, j});
      board.removeQueen({i, j});
    }
  }
  return solutions;
}

std::set<Board> solve_8_queens_iteratively() {
  std::set<Board> solutions;
  std::set<Board> visited;
  Board board;
  std::stack<Board> stk;
  stk.push(board);

  while (!stk.empty()) {
    auto board = stk.top();
    visited.insert(board);
    stk.pop();

    if (board.chess_cnt == 8) {
      solutions.insert(board);
      continue;
    }

    for (int i = 0; i < 8; ++i) {
      for (int j = 0; j < 8; ++j) {
        if (board.isValidQueenPos({i, j})) {
          board.placeQueen({i, j});
          if (visited.find(board) == visited.end())
            stk.push(board);
          board.removeQueen({i, j});
        }
      }
    }
  }
  return solutions;
}

int main() {
  auto solutions_recursive = solve_8_queens_recursively();
  auto solutions_iterative = solve_8_queens_iteratively();
  std::cout << "Recursive: " << solutions_recursive.size()
            << " solutions found.\n";
  std::cout << "Iterative: " << solutions_iterative.size()
            << " solutions found.\n";
  std::cout << "They are"
            << (solutions_recursive == solutions_iterative ? " " : " not ")
            << "the same.\n";
  return 0;
}
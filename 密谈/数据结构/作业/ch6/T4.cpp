#include <iostream>
#include <stack>
#include <vector>

template <typename T> struct BinTreeNode {
  T val;
  BinTreeNode *left;
  BinTreeNode *right;

  BinTreeNode(T value) : val(value), left(nullptr), right(nullptr) {}
  ~BinTreeNode() {
    delete left;
    delete right;
  }
};

template <typename T> class BinTree {
private:
  T emptyVal;
  BinTreeNode<T> *root;
  void buildTree(BinTreeNode<T> *&node, std::vector<T> const &vec, int index) {
    if (index >= vec.size()) {
      node = nullptr;
      return;
    }
    if (vec[index] == emptyVal) {
      node = nullptr;
      return;
    }
    node = new BinTreeNode<T>(vec[index]);
    buildTree(node->left, vec, 2 * index + 1);
    buildTree(node->right, vec, 2 * index + 2);
  }
  void printBinTreeHelper(BinTreeNode<T> *node) {
    if (node == nullptr)
      return;

    printBinTreeHelper(node->left);
    printBinTreeHelper(node->right);
    std::cout << node->val << " ";
  }

public:
  BinTree() : root(nullptr) {}
  BinTree(T ev, std::vector<T> const &vec) : emptyVal(ev) {
    buildTree(root, vec, 0);
  }
  ~BinTree() { delete root; }

  void printBinTreeRecursive() {
    printBinTreeHelper(root);
    std::cout << std::endl;
  }

  void printBinTreeStack() {
    std::stack<BinTreeNode<T> *> stk;
    std::stack<T> output;
    stk.push(root);
    while (!stk.empty()) {
      BinTreeNode<T> *node = stk.top();
      stk.pop();
      if (node != nullptr) {
        output.push(node->val);
        if (node->left)
          stk.push(node->left);
        if (node->right)
          stk.push(node->right);
      }
    }
    while (!output.empty()) {
      std::cout << output.top() << " ";
      output.pop();
    }
    std::cout << std::endl;
  }
};

int main() {
  auto tree = BinTree<char>(' ', {'A', 'B', 'C', ' ',  'D', 'E', 'F'});
  std::cout << "Recursively: ";
  tree.printBinTreeRecursive();
  std::cout << "With stack:  ";
  tree.printBinTreeStack();
  return 0;
}

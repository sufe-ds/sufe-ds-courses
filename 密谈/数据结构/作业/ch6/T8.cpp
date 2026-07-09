#include <bits/c++config.h>
#include <iostream>
#include <stack>
#include <vector>

template <typename T> struct BinTreeNode {
  T val;
  bool ltag = false; // true if left pointer is a thread
  bool rtag = false; // true if right pointer is a thread
  BinTreeNode *left;
  BinTreeNode *right;

  BinTreeNode(T value)
      : val(value), ltag(true), rtag(true), left(nullptr), right(nullptr) {}
  ~BinTreeNode() {
    if (!ltag)
      delete left;
    if (!rtag)
      delete right;
  }
};

template <typename T> class BinTree {
private:
  T emptyVal;
  BinTreeNode<T> *root;

  void buildTree(BinTreeNode<T> *&node, std::vector<T> const &vec, int index) {
    node = new BinTreeNode<T>(vec[index]);
    if (2 * index + 1 < vec.size() && vec[2 * index + 1] != emptyVal) {
      node->ltag = false;
      buildTree(node->left, vec, 2 * index + 1);
    }
    if (2 * index + 2 < vec.size() && vec[2 * index + 2] != emptyVal) {
      node->rtag = false;
      buildTree(node->right, vec, 2 * index + 2);
    }
  }

  void buildThreads(BinTreeNode<T> *node, BinTreeNode<T> *&pre) {
    if (node == nullptr)
      return;

    buildThreads(node->left, pre);
    if (!node->left)
      node->left = pre;
    if (pre && !pre->right)
      pre->right = node;
    pre = node;
    buildThreads(node->right, pre);
  }

  void printTreeRecursiveHelper(BinTreeNode<T> *node) {
    std::cout << node->val << " ";
    if (!node->ltag)
      printTreeRecursiveHelper(node->left);
    if (!node->rtag)
      printTreeRecursiveHelper(node->right);
  }

  BinTreeNode<T> *printTreeHelper(BinTreeNode<T> *node) {
    if (!node->ltag)
      return node->left;
    if (!node->rtag)
      return node->right;
    auto p = node;
    while (p && p->rtag)
      p = p->right;
    return (p && !p->rtag ? p->right : nullptr);
  }

public:
  BinTree() : root(nullptr) {}
  BinTree(T ev, std::vector<T> const &vec) : emptyVal(ev) {
    if (vec.empty()) {
      root = nullptr;
      return;
    }
    buildTree(root, vec, 0);
    BinTreeNode<T> *pre = nullptr;
    buildThreads(root, pre);
  }
  ~BinTree() { delete root; }

  void printTreeRecursive() {
    printTreeRecursiveHelper(root);
    std::cout << std::endl;
  }

  void printTree() {
    auto node = root;
    while (node) {
      std::cout << node->val << " ";
      node = printTreeHelper(node);
    }
    std::cout << std::endl;
  }
};

int main() {
  auto tree = BinTree<int>(-1, {1, 2, 3, -1, 4, 5, 6});
  tree.printTreeRecursive();
  tree.printTree();
  return 0;
}

#include <iostream>

template <typename T>
struct TreeNode {
  T val;
  TreeNode* left;
  TreeNode* right;
  TreeNode(T x) : val(x), left(nullptr), right(nullptr) {}
};

template <typename T>
class BinaryTree {
 public:
  BinaryTree() : root(nullptr) {}

  void insert(T val) { root = insertHelper(root, val); }
  void printInorder() {
    printInorderHelper(root);
    std::cout << "\n";
  }
  void printAncestors(T val) { printAncestorsHelper(root, val); }
  bool contains(TreeNode<T>* node, T val) {
    if (!node)
      return false;
    if (node->val == val)
      return true;
    return contains(node->left, val) || contains(node->right, val);
  }

 private:
  TreeNode<T>* root;

  TreeNode<T>* insertHelper(TreeNode<T>* node, T val) {
    if (!node)
      return new TreeNode<T>(val);

    if (val < node->val) {
      node->left = insertHelper(node->left, val);
    } else {
      node->right = insertHelper(node->right, val);
    }
    return node;
  }

  void printInorderHelper(TreeNode<T>* node) {
    if (!node)
      return;
    printInorderHelper(node->left);
    std::cout << node->val << " ";
    printInorderHelper(node->right);
  }

  void printAncestorsHelper(TreeNode<T>* node, T val) {
    if (!node)
      return;

    if (node->val == val) {
      std::cout << node->val << "\n";
      return;
    }

    if ((node->left && contains(node->left, val)) ||
        (node->right && contains(node->right, val))) {
      std::cout << node->val << " -> ";
      printAncestorsHelper(node->left, val);
      printAncestorsHelper(node->right, val);
    }
  }
};

int main() {
  BinaryTree<int> tree;
  tree.insert(10);
  tree.insert(5);
  tree.insert(15);
  tree.insert(3);
  tree.insert(7);
  tree.insert(12);
  tree.insert(18);

  std::cout << "Inorder Traversal: ";
  tree.printInorder();

  int valueToFind = 7;
  std::cout << "Ancestors of " << valueToFind << ": ";
  tree.printAncestors(valueToFind);
  std::cout << "\n";

  return 0;
}
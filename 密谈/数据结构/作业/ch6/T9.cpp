#include <iostream>
#include <vector>

template <typename T> struct TreeNode {
  T value;
  int weight;
  bool isLeaf;
  TreeNode *left;
  TreeNode *right;

  TreeNode(T w): value(T()), weight(w), isLeaf(false), left(nullptr), right(nullptr) {}
  TreeNode(T val, int w)
      : value(val), weight(w), isLeaf(true), left(nullptr), right(nullptr) {}
  ~TreeNode() {
    if (left)
      delete left;
    if (right)
      delete right;
  }
};

template<typename T>
void printTreeFront(TreeNode<T> *node) {
  if (node == nullptr)
    return;
  std::cout << "(";
  printTreeFront(node->left);
  if (node->isLeaf)
    std::cout << node->value << ":" << node->weight;
  else
    std::cout << node->weight;
  printTreeFront(node->right);
  std::cout << ")";
}

template<typename T>
void printTreeIn(TreeNode<T> *node) {
  if (node == nullptr)
    return;
  if (node->isLeaf)
    std::cout << node->value << ":" << node->weight;
  else
    std::cout << node->weight;
  std::cout << "(";
  printTreeIn(node->left);
  printTreeIn(node->right);
  std::cout << ")";
}

int main() {
  std::vector<int> weights = {5, 6, 7, 3, 4};
  std::vector<TreeNode<int> *> forest;
  for (int w : weights) {
    forest.push_back(new TreeNode<int>(w));
  }
  while (forest.size() > 1) {
    int min1 = -1, min2 = -1;
    for (int i = 0; i < forest.size(); ++i) {
      if (min1 == -1 || forest[i]->weight < forest[min1]->weight) {
        min2 = min1;
        min1 = i;
      } else if (min2 == -1 || forest[i]->weight < forest[min2]->weight) {
        min2 = i;
      }
    }
    TreeNode<int> *newNode =
        new TreeNode<int>(forest[min1]->weight + forest[min2]->weight);
    newNode->left = forest[min1];
    newNode->right = forest[min2];
    if (min1 > min2)
      std::swap(min1, min2);
    forest.erase(forest.begin() + min2);
    forest.erase(forest.begin() + min1);
    forest.push_back(newNode);
  }
  auto root = forest[0];

  printTreeFront(root);
  std::cout << std::endl;
  printTreeIn(root);
  std::cout << std::endl;
}

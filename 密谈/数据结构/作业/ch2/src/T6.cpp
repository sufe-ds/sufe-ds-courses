#include <cstddef>
#include <iostream>

template <typename T>
T input(const char* prompt) {
  T value;
  // std::cout << prompt;
  std::cin >> value;
  return value;
}

template <typename T>
struct ListNode {
  T data;
  ListNode* next;

  ListNode(T d) : data(d), next(nullptr) {}
  ListNode(T d, ListNode* n) : data(d), next(n) {}
};

int main() {
  auto n = input<size_t>("Enter n: ");
  auto i = input<size_t>("Enter i: ");
  auto k = input<size_t>("Enter k: ") - 1;

  ListNode<size_t>* ptr = new ListNode<size_t>(1);
  ptr->next = ptr;
  for (size_t d = 2; d <= n; ++d) {
    ptr->next = new ListNode<size_t>(d, ptr->next);
    ptr = ptr->next;
  }
  auto prev = ptr;
  auto curr = ptr->next;
  while (curr->data != i) {
    prev = curr;
    curr = curr->next;
  }

  std::cout << "Output seq: ";
  while (prev != curr) {
    for (size_t j = 0; j < k; ++j) {
      prev = curr;
      curr = curr->next;
    }
    std::cout << curr->data << " ";
    prev->next = curr->next;
    delete curr;
    curr = prev->next;
  }
  std::cout << curr->data << std::endl;

  delete curr;
  return 0;
}
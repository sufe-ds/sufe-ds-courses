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

template <typename T>
class List {
 public:
  List() : head(nullptr), tail(nullptr) {}
  List(const List& other) : head(nullptr), tail(nullptr) {
    for (auto ptr = other.head; ptr != nullptr; ptr = ptr->next)
      append(ptr->data);
  }
  ~List() {
    if (!head)
      return;
    auto curr = head->next;
    head->next = nullptr;
    while (curr) {
      auto next = curr->next;
      delete curr;
      curr = next;
    }
    delete head;
  }

  ListNode<T>* get_head() { return head; }

  bool empty() const { return head == nullptr; }

  List& append(T value) {
    if (empty()) {
      head = new ListNode<T>(value);
      tail = head;
      return *this;
    }

    tail->next = new ListNode<T>(value);
    tail = tail->next;
    return *this;
  }
  void operator+=(T value) { append(value); }

  List& merge(List<T> other) {
    if (other.empty())
      return *this;

    if (empty()) {
      for (auto ptr = other.head; ptr != nullptr; ptr = ptr->next)
        append(ptr->data);
      return *this;
    }
    auto i = get_head(), j = other.get_head();
    for (; i != nullptr && j != nullptr; i = i->next->next, j = j->next)
      i->next = new ListNode<T>(j->data, i->next);

    for (; j != nullptr; j = j->next)
      append(j->data);
    return *this;
  }

 private:
  ListNode<T>* head;
  ListNode<T>* tail;
};

template <typename T>
List<T> merge(const List<T>& a, const List<T>& b) {
  List<T> result = a;
  result.merge(b);
  return result;
}

int main() {
  auto n = input<size_t>("Enter number of elements for X: ");
  List<int> a;
  // std::cout << "Enter elements for X: ";
  for (size_t i = 0; i < n; ++i)
    a += input<int>("");

  n = input<size_t>("Enter number of elements for Y: ");
  List<int> b;
  // std::cout << "Enter elements for Y: ";
  for (size_t i = 0; i < n; ++i)
    b += input<int>("");

  auto c = merge(a, b);
  std::cout << "Merged list: ";
  for (auto ptr = c.get_head(); ptr != nullptr; ptr = ptr->next)
    std::cout << ptr->data << " ";
  std::cout << std::endl;

  return 0;
}
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

  ListNode<T>* find_(T v) {
    if (empty())
      return nullptr;

    auto curr = get_head();
    while (curr != nullptr) {
      if (curr->data == v)
        return curr;
      curr = curr->next;
    }
    return nullptr;
  }

  List& insert_before_(T a, T b) {
    auto b_ptr = find_(b);
    if (b_ptr == nullptr)
      return append(a);
    if (b_ptr == head) {
      head = new ListNode<T>(a, head);
      return *this;
    }

    auto b_prev = head;
    while (b_prev->next != b_ptr)
      b_prev = b_prev->next;
    b_prev->next = new ListNode<T>(a, b_ptr);
    return *this;
  }

 private:
  ListNode<T>* head;
  ListNode<T>* tail;
};

int main() {
  auto n = input<size_t>("Enter number of elements: ");
  List<int> list;
  // std::cout << "Enter elements: ";
  for (size_t i = 0; i < n; ++i)
    list += input<int>("");

  auto a = input<int>("Enter a: ");
  auto b = input<int>("Enter b: ");
  list.insert_before_(a, b);

  std::cout << "Final list: ";
  for (auto ptr = list.get_head(); ptr != nullptr; ptr = ptr->next)
    std::cout << ptr->data << " ";
  std::cout << std::endl;
  return 0;
}
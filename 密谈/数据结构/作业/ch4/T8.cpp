#include <iostream>
#include <ostream>

using std::cout;
using std::endl;

template <typename T>
struct ListNode {
  T val;
  ListNode* next;
  ListNode(T x) : val(x), next(nullptr) {}
  ListNode(T x, ListNode* ptr) : val(x), next(ptr) {}
};

template <typename T>
class Stack {
 private:
  ListNode<T>* top_ptr;

 public:
  Stack() { top_ptr = nullptr; }
  ~Stack() {
    while (top_ptr != nullptr) {
      auto ptr = top_ptr;
      top_ptr = top_ptr->next;
      delete ptr;
    }
  }

  T top() const { return top_ptr->val; }
  Stack& push(const T& val) {
    auto ptr = new ListNode<T>{val, top_ptr};
    top_ptr = ptr;
    return *this;
  }
  Stack& pop() {
    if (top_ptr == nullptr)
      return *this;
    auto ptr = top_ptr;
    top_ptr = top_ptr->next;
    delete ptr;
    return *this;
  }

  std::ostream& operator<<(std::ostream& os) const {
    auto ptr = top_ptr;
    os << "Stack[";
    while (ptr != nullptr) {
      os << ptr->val;
      ptr = ptr->next;
      if (ptr != nullptr)
        os << ", ";
    }
    os << "]";
    return os;
  }
};

int main() {
  auto stk = Stack<int>{};
  stk.push(1).push(2);
  cout << stk.top() << endl;
  stk.pop();
  cout << stk.top() << endl;
  stk.pop();
  return 0;
}
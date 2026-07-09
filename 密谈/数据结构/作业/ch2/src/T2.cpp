#include <iostream>

template <typename T>
class SeqList {
 public:
  SeqList(size_t n) : size(n) { data = new T[n]; }
  ~SeqList() { delete[] data; }

  T& operator[](size_t index) { return data[index]; }
  const T& operator[](size_t index) const { return data[index]; }

  size_t length() const { return size; }

  void reverse() {
    T tmp{};
    for (size_t i = 0; 2 * i < size; ++i) {
      tmp = data[i];
      data[i] = data[size - 1 - i];
      data[size - 1 - i] = tmp;
    }
  }

 private:
  T* data;
  size_t size;
};

int main() {
  size_t n;
  std::cin >> n;

  SeqList<int> list(n);
  for (size_t i = 0; i < n; ++i)
    std::cin >> list[i];

  list.reverse();

  std::cout << "Reversed elements: ";
  for (size_t i = 0; i < n; ++i)
    std::cout << list[i] << " ";
  std::cout << std::endl;

  return 0;
}
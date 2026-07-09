#include <iostream>
#include <vector>

template <typename T>
size_t myBinarySearchHelper(std::vector<T> const& vec,
                            T const& value,
                            size_t left,
                            size_t right) {
  if (right < left)
    return vec.size();

  auto mid = (left + right) / 2;

  if (vec[mid] == value) {
    return mid;
  } else if (vec[mid] < value) {
    return myBinarySearchHelper(vec, value, mid + 1, right);
  } else {
    return myBinarySearchHelper(vec, value, left, mid - 1);
  }
}

template <typename T>
size_t myBinarySearch(std::vector<T> const& vec, T const& value) {
  return myBinarySearchHelper(vec, value, 0, vec.size() - 1);
}

int main() {
  std::vector<int> vec = {1, 3, 5, 7, 9, 11, 13, 15};
  int valueToFind = 7;
  size_t index = myBinarySearch(vec, valueToFind);
  std::cout << "Vector contents: ";
  for (const auto& v : vec) {
    std::cout << v << " ";
  }
  std::cout << "\n";
  if (index != vec.size()) {
    std::cout << "Value " << valueToFind << " found at index " << index
              << ".\n";
  } else {
    std::cout << "Value " << valueToFind << " not found in the vector.\n";
  }
}
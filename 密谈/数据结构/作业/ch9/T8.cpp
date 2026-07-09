#include <iostream>
#include <memory>
#include <ostream>

struct StudentRecord {
  int id;
  int grade;
};

std::ostream& operator<<(std::ostream& os, const StudentRecord& record) {
  os << "ID: " << record.id << ", Grade: " << record.grade;
  return os;
}

template <typename T>
void choiceSort(T arr[],
                size_t length,
                bool (*lessCmp)(const T&, const T&),
                bool ascending = true) {
  for (size_t i = 0; i < length - 1; ++i) {
    size_t selectedIndex = i;

    for (size_t j = i + 1; j < length; ++j)
      if (lessCmp(arr[j], arr[selectedIndex]) == ascending)
        selectedIndex = j;

    if (selectedIndex != i)
      std::swap(arr[i], arr[selectedIndex]);
  }
}

int main() {
  size_t studentCount;
  std::cout << "Enter number of students: ";
  std::cin >> studentCount;

  auto records = std::make_unique<StudentRecord[]>(studentCount);
  for (size_t i = 0; i < studentCount; ++i) {
    std::cout << "Enter ID and grade for student " << (i + 1) << ": ";
    std::cin >> records[i].id >> records[i].grade;
  }

  choiceSort<StudentRecord>(
      records.get(), studentCount,
      [](auto a, auto b) { return a.grade < b.grade; }, false);

  std::cout << std::endl;
  std::cout << "Sorted student records by grade (descending):" << std::endl;
  for (size_t i = 0; i < studentCount; ++i)
    std::cout << records[i] << std::endl;
  return 0;
}
#include <iostream>
#include <string>

using std::cout;
using std::endl;
using std::string;

string removePunctuation(const string& str) {
  string res{}, punctuations{"!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~"};
  for (char c : str)
    if (punctuations.find(c) == string::npos)
      res += c;
  return res;
}

int main() {
  string str{"Look! A quick fox, which is brown, jumps over the... lazy dog?"};
  cout << "Original:            " << str << endl;
  cout << "Without punctuation: " << removePunctuation(str) << endl;
  return 0;
}
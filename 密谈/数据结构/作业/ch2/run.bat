@echo off

if not exist "bin" mkdir "bin"

g++ src\\T2.cpp -o bin\\T2 -std=c++20 -O2 -Wall -Wshadow
echo --- T2 ---
bin\\T2 < input\\T2.txt

g++ src\\T6.cpp -o bin\\T6 -std=c++20 -O2 -Wall -Wshadow
echo --- T6 ---
bin\\T6 < input\\T6.txt

g++ src\\T14.cpp -o bin\\T14 -std=c++20 -O2 -Wall -Wshadow
echo --- T14 ---
bin\\T14 < input\\T14.txt

g++ src\\T16.cpp -o bin\\T16 -std=c++20 -O2 -Wall -Wshadow
echo --- T16 ---
bin\\T16 < input\\T16.txt

rd /s /q bin
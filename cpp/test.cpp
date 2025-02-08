#include <iostream>
#include <vector>
#include <cstdint>

int main() {
    std::vector<uint64_t> aligned_comp_shift;
    aligned_comp_shift.push_back(10);
    aligned_comp_shift.push_back(20);
    std::cout << aligned_comp_shift.size() << std::endl; // 输出 2
    return 0;
}
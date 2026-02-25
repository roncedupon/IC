#include "verilated.h"
#include "Vceiling_division.h"
#include <iostream>

int main(int argc, char** argv) {
    Verilated::commandArgs(argc, argv);
    
    // 实例化模块
    Vceiling_division* top = new Vceiling_division;
    
    // 运行仿真 (initial 块会在构造时执行)
    // Verilator 对于纯 initial 块的仿真需要在构造时触发
    
    // 结束
    delete top;
    
    std::cout << "Simulation completed" << std::endl;
    return 0;
}

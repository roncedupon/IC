#include <stdint.h>
#include <stddef.h> // 包含 size_t
#include <stdbool.h> // 包含 bool 类型

// ----------------------------------------------------
// 1. 定义地址区间结构体
// ----------------------------------------------------
typedef struct {
    uint32_t start_addr; // 区间的起始地址 (包含)
    uint32_t end_addr;   // 区间的结束地址 (包含)
} AddrRange_t;


/**
 * @brief 检查一个地址是否位于任何一个特殊地址区间内。
 * * @param addr 要检查的地址。
 * @param ranges 地址区间数组。
 * @param num_ranges 数组中的区间数量。
 * @return true 如果地址在任何一个特殊区间内。
 * @return false 如果地址不在任何特殊区间内。
 */
bool is_special_range(uint32_t addr, const AddrRange_t ranges[], size_t num_ranges) {
    for (size_t i = 0; i < num_ranges; ++i) {
        // 检查 addr 是否在 [start_addr, end_addr] 闭区间内
        if (addr >= ranges[i].start_addr && addr <= ranges[i].end_addr) {
            return true; // 命中特殊区间，返回 true
        }
    }
    return false; // 不在任何特殊区间内
}


/**
 * @brief 寄存器复位/读写操作。对于特殊地址区间不执行任何操作。
 * @param addr 要操作的寄存器地址。
 */
void fd_reg_rst(uint32_t addr) {
    // ----------------------------------------------------
    // 2. 定义特殊地址区间列表
    // ----------------------------------------------------
    const AddrRange_t special_ranges[] = {
        // 示例区间 1：从 0x02000000 到 0x02000FFF
        { .start_addr = 0x02000000, .end_addr = 0x02000FFF }, 
        
        // 示例区间 2：只包含一个地址 0x03001000（也可以用区间表示）
        { .start_addr = 0x03001000, .end_addr = 0x03001000 },
        
        // ... 在这里添加所有需要跳过的地址区间 ...
    };
    
    // 计算特殊地址区间的数量
    const size_t num_special_ranges = sizeof(special_ranges) / sizeof(special_ranges[0]);

    // ----------------------------------------------------
    // 3. 检查并排除逻辑
    // ----------------------------------------------------
    if (is_special_range(addr, special_ranges, num_special_ranges)) {
        // 命中特殊区间，跳过操作
        return; 
    }
    
    // ----------------------------------------------------
    // 4. 简单读写操作 (默认访问逻辑)
    // ----------------------------------------------------
    
    // 将地址转换为 volatile uint32_t* 指针
    volatile uint32_t *reg_ptr = (volatile uint32_t *)addr;
    uint32_t temp;

    // 读操作
    temp = *reg_ptr; 
    
    // 写操作（写入 0 进行复位）
    *reg_ptr = 0x00000000; 
}
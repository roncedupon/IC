#include <stdio.h>
#include <stddef.h>

// 模拟FDMA0_TypeDef结构体定义（基于常见的寄存器布局）
typedef struct {
    volatile unsigned int cim_read_inst_en;                // 1
    volatile unsigned int cim_read_inst_base_addr;          // 2
    volatile unsigned int RESERVED0[1];                     // 3 (1个元素)
    volatile unsigned int cim_read_inst_jump;               // 4
    volatile unsigned int cim_read_inst_num;                // 5
    volatile unsigned int cim_read_data_en;                 // 6
    volatile unsigned int cim_read_data_base_addr;          // 7
    volatile unsigned int RESERVED1[1];                     // 8 (1个元素)
    volatile unsigned int cim_read_data_loop_num[2];        // 10 (2个元素)
    volatile unsigned int RESERVED2[6];                     // 16 (6个元素)
    volatile unsigned int cim_read_data_loop_jump[2];       // 18 (2个元素)
    volatile unsigned int RESERVED3[8];                     // 19 (1个元素)
    volatile unsigned int cim_read_data_tag_mask;           // 20
    volatile unsigned int RESERVED4[37];                    // 57 (37个元素)
    volatile unsigned int cim_write_data_base_addr;         // 58
    volatile unsigned int RESERVED5[1];                     // 59 (1个元素)
    volatile unsigned int cim_write_data_loop_num[2];       // 61 (2个元素)
    volatile unsigned int RESERVED6[6];                     // 62 (1个元素)
    volatile unsigned int cim_write_data_loop_jump[2];      // 64 (2个元素)
    volatile unsigned int RESERVED7[20];                    // 84 (20个元素)
    volatile unsigned int cim_task_trigger;                 // 85
    volatile unsigned int cim_trigger;                      // 86
    volatile unsigned int drop_header_dis;                  // 87
    volatile unsigned int RESERVED8[29];                    // 116 (29个元素)
    volatile unsigned int fdma_interrupt_control0;          // 117
    volatile unsigned int fdma_interrupt_control1;          // 118
    volatile unsigned int fdma_interrupt_control2;          // 119
} FDMA0_TypeDef;

int main() {
    // 计算结构体大小
    size_t struct_size = sizeof(FDMA0_TypeDef);
    
    // 计算成员总数（用于验证）
    size_t member_count = 
        1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 2 + 6 + 2 + 8 + 1 + 37 +
        1 + 1 + 2 + 6 + 2 + 20 + 1 + 1 + 1 + 29 + 1 + 1 + 1;
    
    // 打印结果
    printf("FDMA0_TypeDef 结构体信息：\n");
    printf("成员总数: %zu 个\n", member_count);
    printf("每个成员大小: %zu 字节 (unsigned int)\n", sizeof(unsigned int));
    printf("结构体总大小: %zu 字节\n", struct_size);
    printf("理论计算大小: %zu 字节\n", member_count * sizeof(unsigned int));
    
    // 检查是否有内存对齐导致的差异
    if (struct_size == member_count * sizeof(unsigned int)) {
        printf("结果：结构体大小与理论计算一致（无额外对齐字节）\n");
    } else {
        printf("结果：存在内存对齐差异，差值为 %zu 字节\n", 
               struct_size - (member_count * sizeof(unsigned int)));
    }
    
    return 0;
}

#include <stdint.h>
#include <stdio.h>
// void write_bits(int addr, uint32_t value, int msb, int lsb) {
//     uint32_t clear_mask = ~(((1UL << (msb - lsb + 1)) - 1) << lsb); //0000_0001<<3--> 0000_1000-1-->0000_0111-->0111_0000-->1000_1111

//     uint32_t old_value = *(volatile uint32_t*) (addr); //get original value

//     uint32_t value_mask = ((1UL << (msb - lsb + 1)) - 1) << lsb; //make sure width of value to write not excess (msb-lsb+1)
//     uint32_t new_value = (old_value & clear_mask) | (value_mask & (value << lsb));

//     *(volatile uint32_t*) (addr) = new_value;
// }

void write_bits(uint32_t old_value, uint32_t value, int msb, int lsb) {
    uint32_t clear_mask = ~(((1UL << (msb - lsb + 1)) - 1) << lsb); //0000_0001<<3--> 0000_1000-1-->0000_0111-->0111_0000-->1000_1111

    // uint32_t old_value = *(volatile uint32_t*) (addr); //get original value

    uint32_t value_mask = ((1UL << (msb - lsb + 1)) - 1) << lsb; //make sure width of value to write not excess (msb-lsb+1)
    uint32_t new_value = (old_value & clear_mask) | (value_mask & (value << lsb));

    return new_value;
}

int main() {
    uint32_t original_number = 0xFFFFFFFF; // 初始值为所有位都是 1
    uint32_t data_to_insert = 0b101;     // 要写入的数据 (十进制 5)
    int lsb_position = 4;              // 最低有效位位置
    int msb_position = 6;              // 最高有效位位置

    uint32_t updated_number = write_bits_lsb_msb(original_number, data_to_insert, lsb_position, msb_position);

    printf("原始数值 (十六进制): 0x%X\n", original_number);
    printf("要写入的数据 (二进制): %d (0b%d)\n", data_to_insert, data_to_insert);
    printf("最低有效位 (LSB): %d\n", lsb_position);
    printf("最高有效位 (MSB): %d\n", msb_position);
    printf("修改后的数值 (十六进制): 0x%X\n", updated_number);

    return 0;
}
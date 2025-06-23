#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <time.h>

#define PAGE_SIZE 4096

// 随机生成一个地址，它跨越4KB边界
uint32_t random_cross_4k(uint32_t access_len) {
    uint32_t addr;
    do {
        addr = (rand() & 0xFFFFF000); // 随机页对齐起始地址
        addr += (rand() % PAGE_SIZE); // 加入页内偏移
    } while ((addr & 0xFFF) <= (PAGE_SIZE - access_len));
    return addr;
}


uint32_t get_nearest_4k_boundary(uint32_t addr){
    return (addr&0xfff)==0?addr:((addr>>12)+1)<<12;
}

int main() {
    // srand(time(NULL));

    // uint32_t access_len = 128; // 假设你要访问128字节
    // uint32_t addr = random_cross_4k(access_len);

    // printf("随机地址: 0x%08X\n", addr);
    // printf("该地址页内偏移: 0x%X\n", addr & 0xFFF);
    // printf("跨越4KB页: %s\n", ((addr & 0xFFF) + access_len > PAGE_SIZE) ? "是" : "否");
    int*a=(0x942fe0+32);
    a=get_nearest_4k_boundary(a);

    printf("a is %x\n",a);
    return 0;
}

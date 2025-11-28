#include <stdint.h>
#include <stddef.h> // 包含 size_t
#include <stdbool.h> // 包含 bool 类型
typedef struct {
    uint32_t start_addr; //
    uint32_t end_addr;   //
} AddrRange_t;
int is_special_range(uint32_t addr, const AddrRange_t ranges[]) {
    const size_t num_ranges = sizeof(ranges) / sizeof(ranges[0]);    
    printf("num_ranges is %d , in addr is %x\n",num_ranges,addr);     
    for (size_t i = 0; i < num_ranges; ++i) {
        if (addr >= ranges[i].start_addr && addr <= ranges[i].end_addr-4) {
            return 1;
        }
    }
    return 0;
}            

int main(){
    int BASE_ADDR=0;
    const AddrRange_t bufdie_addr[]={
        { .start_addr = BASE_ADDR,.end_addr = BASE_ADDR+0xD00+256 },
        { .start_addr = BASE_ADDR,.end_addr = BASE_ADDR+0xD00+256 },
        { .start_addr = BASE_ADDR,.end_addr = BASE_ADDR+0xD00+256 }
    };

    printf("output is %x",is_special_range(0x10,bufdie_addr));
    return 0;
}
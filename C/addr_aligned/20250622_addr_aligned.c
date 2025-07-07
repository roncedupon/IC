typedef struct __attribute__((packed)) {
    uint16_t addr;
    uint16_t data_l;
    uint16_t data_h;
} s_data_t;

s_data_t* p = (s_data_t*)data_addr;
p[i].addr   = REG_TO_TEST[i] & 0xffff;
p[i].data_l = (i + j * 0x10) & 0xffff;
p[i].data_h = (i + j * 0x10) & 0xffff;

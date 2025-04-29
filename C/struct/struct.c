#include <stdint.h>
#include <stdio.h>

typedef struct
{
    uint64_t:64;
    uint64_t:64;
    uint64_t:64;
    uint64_t:64;
    uint64_t:64;
    uint64_t:64;
    uint64_t tia_end_id:12;
    uint64_t tia_start_id:12;
    uint64_t end_id:8;
    uint64_t start_id:8;
    uint64_t proc_id:1;
    uint64_t tia_en:1;
    uint64_t frez_en:1;
    uint64_t procid_disable:1;
    uint64_t rsv:4;
}dscctrl;
int GETBIT(int data,int bit_pos){
    return (data>>bit_pos)&0x1;
}
void main(){
    dscctrl dscctrl_str;
    memset(&dscctrl_str,0,sizeof(dscctrl_str));
    dscctrl_str.tia_end_id=12;
    dscctrl_str.tia_start_id=12;
    dscctrl_str.end_id=12;
    dscctrl_str.start_id=12;
    dscctrl_str.proc_id=12;
    dscctrl_str.tia_en=12;
    dscctrl_str.frez_en=12;
    dscctrl_str.procid_disable=12;
    dscctrl_str.rsv=12;
    printf("sizeof(dscctrl_str) is %d\n",sizeof(dscctrl_str));
    dscctrl*dscctrl_ptr=&dscctrl_str;
    
    //引用失效？
    for(int i=0;i<7;i++){
        // printf("%x\n",*((uint64_t*)(dscctrl_ptr)));
        for (int j=0;j<sizeof(dscctrl_str)/sizeof(uint8_t);j++){
            printf("%x\n",*((uint8_t*)(&dscctrl_str)));
        }

    }
    printf("========================\n");
    int a=0;
    int *a_ptr=&a;
    *a_ptr=123;
    printf("a is %x",*(&a));

    uint16_t A=123;
    for (int i=0;i<16;i++){
        printf("%x",GETBIT(A,i));
    }
}
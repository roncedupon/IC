#include "stdio.h"

int mtd_tsv_id_cfg(int cfg_die_num,char*tsv_sel,char tsv_id){
    __uint32_t new_tsv_sel=0;
    for(int i=0;i<cfg_die_num;i++){
        new_tsv_sel&=~(0xf<<(i*4));
        new_tsv_sel|=tsv_sel[i]<<(i*4);
        printf("new_tsv_sel is %x\n",new_tsv_sel);
    }
    return new_tsv_sel;
}

void main(){
    char tsv_sel[]={8,15};
    printf("%x",mtd_tsv_id_cfg(sizeof(tsv_sel)/sizeof(char),tsv_sel,0));
}
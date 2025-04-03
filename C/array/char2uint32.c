#include <stdint.h>
#include <stdio.h>
void main1(){
    char data_char[]={
        0x12345678,
        0x87654321
    };
    for(int i=0;i<8;i++){
        printf("%2x\n",data_char[i]);
    }
}


void main2(){
    uint32_t data_int[] = {
        0x12345678,
        0x87654321
    };
    uint8_t *data_byte = (char *)data_int;
    for(int i=0; i < sizeof(data_int); i++){
        printf("%02x\n", data_byte[i]);
    }
    printf("line_number is %d\n",sizeof(data_int)/sizeof(uint32_t));
    printf("line_number is %d\n",sizeof(data_int)/sizeof(uint32_t));
    printf("line_number is %d\n",sizeof(data_int)/sizeof(uint32_t));
}
void test1(){
    int payload_len=0;
    int data_line=26;
    if (data_line%32==0){
        payload_len=data_line/32;
    }else{
        payload_len=data_line/32+1;
    }
    printf("%d\n",26/32);
    printf("%d\n",26/32);
    printf("%d\n",26/32);
    printf("%d\n",26/32);
}
void main(){
    // main2();
    test1();
}
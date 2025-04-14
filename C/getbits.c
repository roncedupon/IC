#include <stdint.h>
#include <stdio.h>
void main(){
    int A=0xf2345678;
    int B=(A>>24)&0x1f;
    printf("%0x",B);
}
#include <stdint.h>
#include <stdio.h>
int main(){
    printf("hhh %d \n",0b110u);
    printf("hhh %d \n",0b110lu);
    printf("hhh %llu \n",0b110lu);
    printf("hhh %llu \n",0b110llu);

    struct {
        int data;
    }test;
    test.data=123;
    printf("test data is %d\n",test.data);
    printf("test data is %d\n",test.data);
    int a=123+
    4+5+6
    +7;

    int b=257;
    printf("mod %x\n",(b>>7)+((b&0x7f)!=0));
    return 0;
}

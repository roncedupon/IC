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
    return 0;
}

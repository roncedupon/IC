#include <stdint.h>
#include <stdio.h>
int main(){
    int*AAA;//这样是不行的，因为AAA指向的是一个未知地址
    *AAA=123;
    printf("AAA is %x",*AAA);//这里并没有打印输出
    return 0;
}

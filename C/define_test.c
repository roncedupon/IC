#include <stdint.h>
#include <stdio.h>
#define AAA 1
void test(){
    if (AAA){
        printf("11111");
    }    
#define AAA 0
    if (AAA){
        printf("22222");
    }
// #define AAA 
}
void test1(){
    if (AAA){
        printf("33333");
    }    
}
void main(){
    test();
    test1();
}
//输出：11111，也就是说define是有局部作用域的，但是作用域与函数作用域无关，而是从当前define往下全部
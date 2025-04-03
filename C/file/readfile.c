#include "stdio.h"
#include <stdint.h>
#include <string.h>
void fgets_test(const char* filename){
    // C 库函数 char *fgets(char *str, int n, FILE *stream) 从指定的流 stream 读取一行，并把它存储在 str 所指向的字符串内。
    // 当读取 (n-1) 个字符时，或者读取到换行符时，或者到达文件末尾时，它会停止，具体视情况而定。
    FILE*file=fopen(filename,"r");
    char data_buffer[16];
    char flag;
    if (file == NULL){
        printf("ERROR:Cannot open file:%s",filename);
    }else{
        while(fgets(data_buffer,4,file)){
            printf("line: %s",data_buffer);
        }
    }
}


void strncpy_test1(){
    //<string.h>
    char src[40] = "Hello, this is a test string";
    char dest[40];
    
    strncpy(dest, src, sizeof(dest));
    printf("Copied string: %s\n", dest);
    
}
void strncpy_test2(){//限制复制长度
    char src[] = "This is too long";
    char dest[10];

    strncpy(dest, src, sizeof(dest)-1);  // 留一个位置给null终止符
    dest[sizeof(dest)-1] = '\0';         // 手动添加终止符
    printf("Copied string: %s\n", dest);
}
void main(){
    // fgets_test("/mnt/disk_0/IC/C/file/all_buffers.txt");
    strncpy_test2();
}
#include <stdio.h>
 
int main(int argc, char **argv)
{
        printf("File    Fame: %s\n", __FILE__);      //文件名
        printf("Present Line: %d\n", __LINE__);      //所在行
        printf("Present Function: %s\n", __func__);  //函数名
 
        return 0;
} /* ----- End of main()  ----- */


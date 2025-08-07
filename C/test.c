/************************************************************************/
//@Author:猿说编程
//@Blog(个人博客地址): www.codersrc.com
//@File:C语言 函数缺省参数
//@Time:2021/06/23 08:00
//@Motto:不积跬步无以至千里，不积小流无以成江海，程序人生的精彩需要坚持不懈地积累！
/************************************************************************/

#include <stdio.h>
//x,y为函数的形参，如果函数被调用时，没有设置y值，y值默认为5

int sub(int x,int y)
{
    return (x-y);
}

void layer_id_test(){
    int layer_start=0;
    int layer_end =3;//3;    
    for(int layer_id=layer_start;layer_id<=layer_end;layer_id++){
        printf("runing %x\n",layer_id);
        if(layer_id<=layer_end-1)
            printf("switching %x \n",layer_id+1);
    }
}
int main(void)
{
    layer_id_test();
    return 0;
}
/*
输出：
sub函数计算结果 = 10
sub函数计算结果 = 15
*/

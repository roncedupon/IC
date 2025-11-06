//又是一个大坑，运算符的优先级
#include <stdint.h>
#include <stdio.h>
void main(){
    uint32_t act=0x11;//0x12又是不同的结果！！！
    uint32_t rdata=act;
    uint32_t rdata_tmp_l=act;
    if(rdata&0xffff != rdata_tmp_l){
        printf("aaaa");
    }else{
        printf("bbb");
    }
}


// 你遇到的问题不是值的问题，而是 C 运算符优先级 引起的逻辑错误。

// ✅ 原表达式
// if(rdata & 0xffff != rdata_tmp_l)


// 你本意是：

// 判断 rdata 的低 16 位是否等于 rdata_tmp_l

// 但实际解析方式是：

// rdata & (0xffff != rdata_tmp_l)


// 因为：

// 运算符	优先级
// !=	高
// &（位与）	低
// ✅ 实际执行逻辑

// 对 act = 0x12 时：

// 0xffff != 0x12  → true (1)
// rdata & 1 = 0x12 & 1 = 0x0 (false)
// => 走 else → "bbb"


// 对 act = 0x11 时：

// 0xffff != 0x11 → true (1)
// rdata & 1 = 0x11 & 1 = 0x1 (true)
// => 打印 "aaaa"


// 所以你看到不同结果。

// ✅ 正确写法（加括号！）
// if ((rdata & 0xffff) != rdata_tmp_l) {
//     printf("aaaa");
// } else {
//     printf("bbb");
// }

// ✅ 推荐更安全的方式

// 如果你只是想比较低 16 bit：

// if ((uint16_t)rdata != (uint16_t)rdata_tmp_l)


// 或者：

// if ((rdata ^ rdata_tmp_l) & 0xffff)

// ✅ 小总结
// 写法	结果	原因
// rdata & 0xffff != rdata_tmp_l	错误判断	优先级问题
// (rdata & 0xffff) != rdata_tmp_l	✅ 正确	先截断再比较
//一些宏定义相关操作
// `define AAAA 123  ///特别注意这里定义的AAAA也会在后面被展开
`define AAAA0_SUBFIX 456
`define AAAA1_SUBFIX 789
`define GET_AAAA(idx) `AAAA``idx``_SUBFIX

module top;
    initial begin
        int i=0;
        // $display("%x",`AAA``i);//这种写法错误，需要再定义一个宏级拼接
        // $display("%x",`GET_AAAA(i));//这样也是错的，因为i是运行时变量，宏展开无法预知
        $display("%d\n",`GET_AAAA(0));
        $display("%d\n",`GET_AAAA(1));
    end
endmodule
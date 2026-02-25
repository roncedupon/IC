//------------------------------------------------------------
// 用户功能宏
//------------------------------------------------------------
`define A(i) \
    task automatic task_``i(); \
        $display("task_%0d executing", i); \
    endtask

//------------------------------------------------------------
// // 展开控制宏（最多支持10次，可扩展）
// //------------------------------------------------------------
// `define REPEAT_1(m)  `m(0)
// `define REPEAT_2(m)  `REPEAT_1(m)  `m(1)
// `define REPEAT_3(m)  `REPEAT_2(m)  `m(2)
// `define REPEAT_4(m)  `REPEAT_3(m)  `m(3)
// `define REPEAT_5(m)  `REPEAT_4(m)  `m(4)
// `define REPEAT_6(m)  `REPEAT_5(m)  `m(5)
// `define REPEAT_7(m)  `REPEAT_6(m)  `m(6)
// `define REPEAT_8(m)  `REPEAT_7(m)  `m(7)
// `define REPEAT_9(m)  `REPEAT_8(m)  `m(8)
// `define REPEAT_10(m) `REPEAT_9(m)  `m(9)

// //------------------------------------------------------------
// // 主入口宏：B(n, 宏名)
// //------------------------------------------------------------
// `define B(n, m) `REPEAT_``n(m)


module test;
    // 生成10个task
    `B(10, A)

    generate
        genvar i;
        for(i=0;i<10;i=i+1)
        `A(i)
        
    endgenerate

    initial begin
        task_0();
        task_5();
        task_9();
    end
endmodule

//一些宏定义相关操作
`define AAAA 123
`define AAAA0 456
`define AAAA1 789
`define GET_AAAA(idx) `AAAA``idx
// task test_genvar();
//     genvar j;
//     for(int i=0;i<10;i++)begin
//         generate
//             for(j=0;j<10;j++)begin
//                 $display("hh");
//             end
//         endgenerate
//     end
// endtask 
module top;
    logic [31:0]AAAA_array[3]={`GET_AAAA(0),`GET_AAAA(1),`GET_AAAA(1)};
    initial begin
        foreach(AAAA_array[i])begin
            $display(AAAA_array[i]);
        end
    end
endmodule
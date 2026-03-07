`timescale 1ns/1ps

module nsu_dat_buf #(/*autoarg*/)
(
    // Inputs
    input wire [N-1:0]  I,
    // Outputs
    output wire [N-1:0] Z
);

// 参数定义：缓冲位宽，默认4位
parameter N = 4;

// 内部信号与变量声明
/*autodef*/
genvar i; // 生成循环专用变量

// Generate 块：批量例化单比特缓冲单元
generate
    for(i = 0; i < N; i = i + 1) begin : gen_dbuf
        // 例化底层单比特缓冲单元 WITMEM_DBUF
        WITMEM_DBUF u_WITEM_DBUF (
            .I(I[i]),  // 单比特输入
            .Z(Z[i])   // 单比特输出
        );
    end
endgenerate

endmodule
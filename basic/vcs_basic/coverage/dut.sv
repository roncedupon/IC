// 顶层模块：top
module top(
    input  logic        clk,
    input  logic        rst_n,
    input  logic [7:0]  din,
    output logic [7:0]  dout
);

    // 子模块实例化
    sub_module u_sub_module(
        .clk    (clk),
        .rst_n  (rst_n),
        .din    (din),
        .dout   (dout)
    );

endmodule

// 子模块：sub_module
module sub_module(
    input  logic        clk,
    input  logic        rst_n,
    input  logic [7:0]  din,
    output logic [7:0]  dout
);
    logic [7:0] dout1; // 子子模块1输出

    // 子子模块1：宏控Dummy化
`ifdef DUMMY_SUB_SUB_MODULE1
    sub_sub_module1_dummy u_sub_sub_module1(
        .clk    (clk),
        .rst_n  (rst_n),
        .din    (din),
        .dout   (dout1)
    );
`else
    sub_sub_module1 u_sub_sub_module1(
        .clk    (clk),
        .rst_n  (rst_n),
        .din    (din),
        .dout   (dout1)
    );
`endif

    // 子子模块2：宏控Dummy化
`ifdef DUMMY_SUB_SUB_MODULE2
    sub_sub_module2_dummy u_sub_sub_module2(
        .clk    (clk),
        .rst_n  (rst_n),
        .din    (dout1),
        .dout   (dout)
    );
`else
    sub_sub_module2 u_sub_sub_module2(
        .clk    (clk),
        .rst_n  (rst_n),
        .din    (dout1),
        .dout   (dout)
    );
`endif

endmodule

// 子子模块1：正常版本
module sub_sub_module1(
    input  logic        clk,
    input  logic        rst_n,
    input  logic [7:0]  din,
    output logic [7:0]  dout
);
    // 功能逻辑：复位0，正常din+1
    always_ff @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            dout <= 8'h00;
        end else begin
            dout <= din + 1'b1;
        end
    end
endmodule

// 子子模块1：Dummy版本（输出tie 0）
module sub_sub_module1_dummy(
    input  logic        clk,
    input  logic        rst_n,
    input  logic [7:0]  din,
    output logic [7:0]  dout
);
    assign dout = 8'h00; // 固定tie 0
endmodule

// 子子模块2：正常版本
module sub_sub_module2(
    input  logic        clk,
    input  logic        rst_n,
    input  logic [7:0]  din,
    output logic [7:0]  dout
);
    // 功能逻辑：复位0，正常din*2
    always_ff @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            dout <= 8'h00;
        end else begin
            dout <= din * 2;
        end
    end
endmodule

// 子子模块2：Dummy版本（输出tie 0）
module sub_sub_module2_dummy(
    input  logic        clk,
    input  logic        rst_n,
    input  logic [7:0]  din,
    output logic [7:0]  dout
);
    assign dout = 8'h00; // 固定tie 0
endmodule
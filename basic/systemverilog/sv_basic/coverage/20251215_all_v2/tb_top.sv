// 纯净版TB：仅包含核心验证逻辑，无任何覆盖率代码
module tb_top;

// -------------------------- 1. 信号定义 --------------------------
logic        clk;        // 时钟信号
logic        rst_n;      // 异步复位（低有效）
logic        din;        // DUT串行输入
logic [7:0]  dout;       // DUT并行输出
logic        valid;      // DUT输出有效标志
logic        err;        // DUT错误标志

// -------------------------- 2. DUT例化 --------------------------
packet_checker u_dut (
    .clk    (clk),
    .rst_n  (rst_n),
    .din    (din),
    .dout   (dout),
    .valid  (valid),
    .err    (err)
);

// -------------------------- 3. 时钟生成 --------------------------
initial begin
    clk = 1'b0;
    forever #5 clk = ~clk;  // 100MHz时钟（周期10ns）
end

// -------------------------- 4. 激励任务定义 --------------------------
// 任务1：发送完整数据包（起始位+8bit数据+奇校验位+停止位）
// 参数：data=有效数据，parity_err=是否注入校验位错误，stop_err=是否注入停止位错误
task send_packet(input logic [7:0] data, input logic parity_err, input logic stop_err);
    logic parity_bit;
    // 计算奇校验位（所有位异或后取反）
    parity_bit = ~^data;
    if (parity_err) parity_bit = ~parity_bit;  // 注入校验位错误

    @(posedge clk); din = 1'b0;  // 起始位（固定为0）
    repeat (8) begin             // 接收8bit数据（低位先送）
        @(posedge clk); din = data[0]; 
        data = {1'b0, data[7:1]};
    end
    @(posedge clk); din = parity_bit;  // 校验位
    @(posedge clk); din = stop_err ? 1'b0 : 1'b1;  // 停止位（正常为1）
    @(posedge clk); din = 1'b1;  // 回到空闲态
endtask

// 任务2：发送起始位错误的数据包（起始位应为0，强制送1）
task send_start_err_packet;
    @(posedge clk); din = 1'b1;  // 起始位错误（非法值1）
    repeat (10) @(posedge clk);  // 后续无效数据
    @(posedge clk); din = 1'b1;  // 回到空闲态
endtask

// -------------------------- 5. 核心测试流程 --------------------------
initial begin
    // 初始化：复位+空闲态
    rst_n = 1'b0;  // 复位拉低
    din   = 1'b1;  // 输入默认高电平（空闲态）
    #15;           // 复位持续1.5个时钟周期（15ns）
    rst_n = 1'b1;  // 释放复位
    #10;           // 复位释放后等待1个时钟周期

    // 场景1：发送正确数据包（无任何错误）
    $display("[%0t] 发送正确数据包：8'h55", $time);
    send_packet(8'h55, 1'b0, 1'b0);
    #20;  // 间隔2个时钟周期

    // 场景2：发送起始位错误的数据包
    $display("[%0t] 发送起始位错误数据包", $time);
    send_start_err_packet;
    #20;

    // 场景3：发送校验位错误的数据包
    $display("[%0t] 发送校验位错误数据包：8'hAA", $time);
    send_packet(8'hAA, 1'b1, 1'b0);
    #20;

    // 场景4：发送停止位错误的数据包
    $display("[%0t] 发送停止位错误数据包：8'h33", $time);
    send_packet(8'h33, 1'b0, 1'b1);
    #20;

    // 场景5：发送多组数据验证输出稳定性
    $display("[%0t] 发送多组测试数据：8'h00/8'hFF/8'hF0", $time);
    send_packet(8'h00, 1'b0, 1'b0);
    #10;
    send_packet(8'hFF, 1'b0, 1'b0);
    #10;
    send_packet(8'hF0, 1'b0, 1'b0);
    #50;  // 空闲态等待

    // 结束仿真
    $display("[%0t] 所有测试场景执行完成，结束仿真", $time);
    #100;
    $finish;
end

// -------------------------- 6. 波形dump（可选，便于调试） --------------------------
initial begin
    $fsdbDumpfile("tb_packet_checker.fsdb");  // 波形文件名
    $fsdbDumpvars(0, tb_top);                 // dump所有层级信号
    $fsdbDumpMDA();                           // dump多维数组（若有）
end

endmodule
// 1. 定义接口：包含 clocking block，模拟你的 monitor_cb
interface addr_interface(input clk, input rst_n);
  // 定义与你场景一致的信号
  logic nsu_online_vld;   // 单周期有效标志
  logic nsu_online_rdy;   // 握手响应
  logic [7:0] nsu_online_addr; // 待采样的地址

  // 定义 monitor 时钟块（重点：默认 input skew 为 ##1）
  clocking monitor_cb @(posedge clk);
    // input ##1：时钟上升沿后采样（默认行为，可省略不写）
    input nsu_online_vld;
    input nsu_online_rdy;
    input nsu_online_addr;
  endclocking

  // modport 供TB使用
  modport monitor(clocking monitor_cb, input clk, rst_n);
  modport dut(input clk, rst_n, nsu_online_rdy, output nsu_online_vld, nsu_online_addr);
endinterface

// 2. 简单DUT：模拟单周期vld + 非0 addr输出
module simple_dut(addr_interface.dut vif);
  always @(posedge vif.clk or negedge vif.rst_n) begin
    if(!vif.rst_n) begin
      vif.nsu_online_vld <= 1'b0;
      vif.nsu_online_addr <= 8'h00;
    end else begin
      // 模拟：第5个时钟周期产生单周期vld，同时驱动addr为8'hFF
      if($time == 50) begin
        vif.nsu_online_vld <= 1'b1;
        vif.nsu_online_addr <= 8'hFF;
      end else begin
        vif.nsu_online_vld <= 1'b0;
        vif.nsu_online_addr <= 8'h00; // 其他周期addr回归0
      end
    end
  end
endmodule

// 3. Testbench：核心验证逻辑（对比两种采样方式）
module tb;
  reg clk, rst_n;
  // 实例化接口
  addr_interface intf(clk, rst_n);
  // 实例化DUT
  simple_dut dut(intf);

  // 生成时钟（10ns周期）
  initial begin
    clk = 1'b0;
    forever #5 clk = ~clk;
  end

  // 复位逻辑
  initial begin
    rst_n = 1'b0;
    #10 rst_n = 1'b1;
  end

  // 核心验证：对比 vif.addr 和 vif.monitor_cb.addr
  initial begin
    // 等待复位完成
    @(posedge rst_n);
    $display("=== 开始验证：对比直接访问 vs clocking block 访问 ===");

    // 模拟你的采样逻辑：等待vld&rdy（这里rdy直接置1，模拟握手成功）
    intf.nsu_online_rdy = 1'b1; // 固定rdy为1，确保握手成功
    while(~(intf.monitor_cb.nsu_online_vld & intf.monitor_cb.nsu_online_rdy)) begin
      @(intf.monitor_cb);
    end

    // 关键：同一时刻打印两种方式的addr
    $display("At time %0t:", $time);
    $display("  直接访问 vif.nsu_online_addr = 0x%02X", intf.nsu_online_addr);
    $display("  通过monitor_cb访问 = 0x%02X", intf.monitor_cb.nsu_online_addr);

    #100;
    $finish;
  end
endmodule
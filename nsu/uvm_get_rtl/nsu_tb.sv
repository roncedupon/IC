// 导入UVM包
`include "uvm_macros.svh"
`include "uvm_pkg.sv"
import uvm_pkg::*;

// 导入DUT
`include "uvm_get_rtl.sv"

// 导入接口和UVM组件
`include "nsu_if.sv"
`include "nsu_seq_item.sv"
`include "nsu_sequencer.sv"
`include "nsu_driver.sv"
`include "nsu_agent.sv"
`include "nsu_env.sv"
`include "nsu_sequence.sv"
`include "nsu_test.sv"

// 顶层测试平台
module nsu_tb;
  // 时钟和复位信号
  reg clk;
  reg rst_n;

  // 实例化接口
  nsu_if vif(clk, rst_n);

  // 实例化DUT
  nsu_dut dut(
    .clk(clk),
    .rst_n(rst_n),
    .offline_wbf_cur_state(vif.offline_wbf_cur_state),
    .rd_cmd_hw_cur_state(vif.rd_cmd_hw_cur_state),
    .nand_rd_cmd_cur_state(vif.nand_rd_cmd_cur_state)
  );

  // 时钟生成
  initial begin
    clk = 0;
    forever #10ns clk = ~clk;
  end

  // 复位生成
  initial begin
    rst_n = 0;
    #20ns;
    rst_n = 1;
  end

  // UVM测试启动
  initial begin
    // 设置接口到UVM配置数据库
    uvm_config_db#(virtual nsu_if)::set(null, "uvm_test_top.env.agent.*", "vif", vif);
    // 运行UVM测试
    run_test("nsu_test");
  end

endmodule

`include "uvm_macros.svh"
`include "uvm_pkg.sv"
import uvm_pkg::*;

// 优化后的对齐版宏（核心：固定宽度+对齐符，解决排版混乱）
`define UVM_INFO_EXT(var_name) \
  `uvm_info("UVM_INFO_EXT", \
    $sformatf("[%-15s][%2d:0] = %-5p (hex: 0x%0h)", \
      `"var_name`",   \     
      $bits(var_name)-1,   \  
      var_name,         \   
      var_name),\          
    UVM_LOW)

// 测试用例类（UVM环境）
class test_ext_macro extends uvm_test;
  `uvm_component_utils(test_ext_macro)

  // 定义不同类型/位宽/数值的变量（模拟实际验证场景）
  logic [5:0]   fsm_state_6bit     = 6'd10;    // 6位小数值
  logic [31:0]  cfg_reg_32bit      = 32'h12345678; // 32位十六进制值
  logic [2:0]   ctrl_sig_3bit      = 3'd7;     // 3位最大值
  logic [15:0]  empty_reg_16bit    = 16'd0;    // 16位零值
  // 模拟RTL长路径变量名（你的实际场景）
  logic [7:0]   tb_top_u_dut_u0_nsu_top_wrapper_u_nsu_top_u0_nsu_tsu_rd_ctrl_cur_state = 8'h5a;

  function new(string name = "test_ext_macro", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);

    `uvm_info("TEST_START", "===== 开始测试UVM_INFO_EXT宏（对齐版） =====", UVM_LOW)
    
    // 测试不同变量，验证对齐效果
    `UVM_INFO_EXT(fsm_state_6bit);
    `UVM_INFO_EXT(cfg_reg_32bit);
    `UVM_INFO_EXT(ctrl_sig_3bit);
    `UVM_INFO_EXT(empty_reg_16bit);
    `UVM_INFO_EXT(tb_top_u_dut_u0_nsu_top_wrapper_u_nsu_top_u0_nsu_tsu_rd_ctrl_cur_state);

    `uvm_info("TEST_END", "===== 测试结束 =====", UVM_LOW)
    phase.drop_objection(this);
  endtask

endclass

// 仿真顶层
module tb_top;
  initial begin
    // 启动UVM测试
    run_test("test_ext_macro");
  end
endmodule
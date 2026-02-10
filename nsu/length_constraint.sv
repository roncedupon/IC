`timescale 1ns/1ps
`include "uvm_macros.svh"
`include "uvm_pkg.sv"
import uvm_pkg::*;
`timescale 1ns/1ps

// 1. 定义事务类（包含变量+兼容约束）
class rcmd_trans extends uvm_object;
  rand logic [15:0] rcmd_mask_h; // mask高16位
  rand logic [15:0] rcmd_mask_l; // mask低16位
  rand int rcmd_vld_num;         // mask中1的数量
  rand int rcmd_length;          // 最高位1的下标*4

  `uvm_object_utils(rcmd_trans)

  function new(string name = "rcmd_trans");
    super.new(name);
  endfunction

  // 辅助函数：手动计算32位mask最高位1的下标（兼容所有仿真器）
  function int get_highest_bit_idx(logic [31:0] mask);
    if(mask == '0) return 0; // mask全0时返回0
    for(int i=31;i>0;i--) begin
      if(mask[i]) begin
        return i+1;
      end
    end
  endfunction

  // 核心约束：替换$findoneh，兼容所有仿真器
  constraint c_mask_vld_length {
    // 约束1：vld_num = mask中1的数量（$countones是所有仿真器都支持的）
    rcmd_vld_num == $countones({rcmd_mask_h, rcmd_mask_l});

    // 约束2：length = 最高位1的下标 *4（调用辅助函数）
    {rcmd_mask_h, rcmd_mask_l} != '0; // 避免mask全0
    rcmd_length == get_highest_bit_idx({rcmd_mask_h, rcmd_mask_l}) * 4;
  }
endclass

module tb;
 logic [31:0] full_mask_test='h4;


// 2. 测试逻辑：多次随机化验证约束
initial begin
   
  rcmd_trans tr = rcmd_trans::type_id::create("tr");
  
  // 循环5次随机化，打印结果验证
  for(int i=0; i<5; i++) begin
    if(tr.randomize()with{
        tr.rcmd_mask_l==full_mask_test[15:0];
        tr.rcmd_mask_h==full_mask_test[31:16];
    })begin
      logic [31:0] full_mask;//如果在这里直接：logic [31:0] full_mask = {tr.rcmd_mask_h, tr.rcmd_mask_l};,最后出来的full_mask会是x
    //   int highest_idx = tr.get_highest_bit_idx(full_mask);
      full_mask = {tr.rcmd_mask_h, tr.rcmd_mask_l};
      $display("====================================");
      $display("第%0d次随机化结果：", i+1);
      $display("rcmd_mask_h = 0x%04h, rcmd_mask_l = 0x%04h", tr.rcmd_mask_h, tr.rcmd_mask_l);
      $display("完整mask = 0x%08h", full_mask);
    //   $display("最高位1的下标 = %0d", highest_idx);
      $display("vld_num = %0d (mask中1的数量)", tr.rcmd_vld_num);
      $display("length = %0d (最高位下标(%0d)*4)", tr.rcmd_length,$clog2(full_mask));
    end else begin
      $display("随机化失败！");
    end
  end
  $finish;
end

endmodule
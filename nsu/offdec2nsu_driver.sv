`ifndef SIMPLE_DEMO_SV
`define SIMPLE_DEMO_SV

`include "uvm_pkg.sv"
`include "uvm_macros.svh"
import uvm_pkg::*;
// 2. 定义事务类：offdec2nsu_transaction（output参数的类型）
class offdec2nsu_transaction extends uvm_object;
  `uvm_object_utils(offdec2nsu_transaction) // UVM宏注册（必须）

  // 简单字段：用于验证赋值结果
  int cmd; 

  function new(string name = "offdec2nsu_transaction");
    super.new(name);
  endfunction

  // 打印方法：方便查看结果
  function string to_string();
    return $sformatf("cmd = 0x%0h", cmd);
  endfunction
endclass

// 3. 定义包含 extern virtual task 声明的类
class test_seq extends uvm_object;
  `uvm_object_utils(test_seq)

  // 核心：声明 extern virtual task（仅声明，实现写在外部）
  extern virtual task get_nsu2offdec_cmd(int num,output offdec2nsu_transaction rsp);

  function new(string name = "test_seq");
    super.new(name);
  endfunction
endclass

// 4. 外部实现这个 virtual task（核心逻辑）
task test_seq::get_nsu2offdec_cmd(int num,output offdec2nsu_transaction rsp);
  // 给output参数赋值：演示num默认参数的作用
  rsp.cmd = 'h1000 + num; // cmd = 基础值 + num（num不传则用0，传则用传入值）
  
  `uvm_info("TASK_IMPL", 
    $sformatf("task内部：num = %0d, rsp = %s", num, rsp.to_string()), 
    UVM_LOW)
endtask

// 5. 测试入口：TB模块（直接运行验证）
module demo_tb;
  initial begin
    // 声明变量
    test_seq seq;
    offdec2nsu_transaction tr1, tr2;

    // 实例化（output参数必须先实例化，否则报错）
    seq = test_seq::type_id::create("seq");
    tr1 = offdec2nsu_transaction::type_id::create("tr1"); // 测试默认参数
    tr2 = offdec2nsu_transaction::type_id::create("tr2"); // 测试显式传参

    `uvm_info("DEMO", "===== 场景1：不传num，使用默认值0 =====", UVM_LOW)
    // 调用task：仅传output参数，num用默认值0
    seq.get_nsu2offdec_cmd(.rsp(tr1),.num(10));
    `uvm_info("DEMO", $sformatf("场景1结果：tr1 = %s", tr1.to_string()), UVM_LOW)

    `uvm_info("DEMO", "===== 场景2：显式传num=5 =====", UVM_LOW)
    // 调用task：显式传num=5，覆盖默认值
    seq.get_nsu2offdec_cmd(.rsp(tr2), .num(5));
    `uvm_info("DEMO", $sformatf("场景2结果：tr2 = %s", tr2.to_string()), UVM_LOW)
  end
endmodule

`endif
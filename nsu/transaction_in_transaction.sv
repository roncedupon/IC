`include "uvm_macros.svh"
`include "uvm_pkg.sv"
import uvm_pkg::*;

// 1. 基础事务类（对应你的ondecznsu_transaction）
class simple_transaction extends uvm_sequence_item;
  `uvm_object_utils(simple_transaction)

  rand bit [7:0]  addr;    // 地址字段
  rand bit [15:0] data;    // 数据字段（独立随机）
  rand bit [3:0]  id;      // ID字段（分组约束）

  function new(string name = "simple_transaction");
    super.new(name);
  endfunction

  // 打印事务内容（验证用）
  virtual function void do_print(uvm_printer printer);
    super.do_print(printer);
    printer.print_field("addr", addr, 8, UVM_HEX);
    printer.print_field("data", data, 16, UVM_HEX);
    printer.print_field("id", id, 4, UVM_DEC);
  endfunction
endclass

// 2. 组事务类（对应你的ondecznsu_group_transaction）
class group_transaction extends uvm_sequence_item;
  `uvm_object_utils(group_transaction)

  // 嵌套事务数组（4个元素，简化你的8个）
  rand simple_transaction tr[4];

  // 构造函数：初始化数组内的每个事务
  function new(string name = "group_transaction");
    super.new(name);
    foreach(tr[i]) begin
      tr[i] = simple_transaction::type_id::create($sformatf("tr[%0d]", i));
    end
  endfunction

  // 约束1：数组长度固定为4
  constraint c_array_size {
    tr.size() == 4;
  }

  // 约束2：嵌套事务的字段约束（模拟你的场景）
  constraint c_nested_fields {
    // ---------- 全局一致：所有tr的addr与tr[0]一致 ----------
    foreach(tr[i]) {
      if(i > 0) tr[i].addr == tr[0].addr;
    }

    // ---------- 分组一致：前2个tr的id与tr[0]一致，后2个与tr[2]一致 ----------
    foreach(tr[i]) {
      if(i > 0 && i < 2) tr[i].id == tr[0].id;   // 前2个一致
      if(i >= 2 && i != 2) tr[i].id == tr[2].id; // 后2个一致
    }

    // ---------- 独立随机：data字段每个元素独立随机（无约束） ----------
  }

  // 打印组事务内容（验证用）
  virtual function void do_print(uvm_printer printer);
    super.do_print(printer);
    foreach(tr[i]) begin
      printer.print_object($sformatf("tr[%0d]", i), tr[i]);
    end
  endfunction
endclass

// 3. 测试入口：实例化+随机化+验证
module tb;
  initial begin
    // 实例化组事务
    group_transaction group_tr;
    group_tr = group_transaction::type_id::create("group_tr");

    // 随机化（自动应用所有约束）
    if(group_tr.randomize()) begin
      `uvm_info("SUCCESS", "组事务随机化成功！约束生效结果如下：", UVM_LOW);
      group_tr.print(); // 打印所有字段，验证约束效果
    end else begin
      `uvm_error("FAILED", "组事务随机化失败！");
    end
  end
endmodule
`include "uvm_macros.svh"
`include "uvm_pkg.sv"
import uvm_pkg::*;

// 模拟你的tsu2nsu_transaction类
class tsu2nsu_transaction extends uvm_object;
  rand int ost_id;
  rand bit [31:0] addr;
  `uvm_object_utils(tsu2nsu_transaction)
  
  function new(string name = "tsu2nsu_transaction");
    super.new(name);
  endfunction
  
  function void print();
    $display("ost_id=%0d, addr=0x%0h", ost_id, addr);
  endfunction
endclass

// 包含delete_queue_items的类
class queue_mgr extends uvm_component;
  `uvm_component_utils(queue_mgr)
  
  function new(string name = "queue_mgr", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  // 你的函数声明
  extern virtual function void delete_queue_items(ref tsu2nsu_transaction src_que[$], const ref tsu2nsu_transaction del_que[$]);
endclass

// 函数实现
function void queue_mgr::delete_queue_items(ref tsu2nsu_transaction src_que[$], const ref tsu2nsu_transaction del_que[$]);
  int i, j;
  foreach(del_que[j]) begin
    for(i = src_que.size() - 1; i >= 0; i--) begin
      if(src_que[i].ost_id == del_que[j].ost_id && src_que[i].addr == del_que[j].addr) begin
        `uvm_info("DELETE_QUEUE", $sformatf("删除元素: ost_id=%0d, addr=0x%0h", 
                 src_que[i].ost_id, src_que[i].addr), UVM_MEDIUM);
        src_que.delete(i);
        break; // 只删第一个匹配项
      end
    end
  end
endfunction

class hhh_test;
    int f_queue[$];
    int var0;
    function new();
        f_queue = '{1, 2, 3, 4, 5};
    endfunction
    function void print_queue();
        $display("hhh_test.f_queue: %p", f_queue);
        $display("var0 is : %0x", var0);
    endfunction
endclass
// 测试模块
module tb;
   hhh_test hhh_test_inst;
   int hh_test_queue[$];
   int var0;
   initial begin
    hhh_test_inst = new();
    var0=10;
    $display("hhh_test_inst.f_queue: %p", hhh_test_inst.f_queue);
  end
  initial begin
;
    hh_test_queue='{4,5,6,7,8};
    hhh_test_inst.f_queue = hh_test_queue;
    hhh_test_inst.var0=var0;
    var0=20;
    hh_test_queue.delete(); // 删除第一个元素
    hhh_test_inst.print_queue();
    // 初始化源队列
   
  end
endmodule
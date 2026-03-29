`ifndef MAILBOX_SEQ_DEMO_SV
`define MAILBOX_SEQ_DEMO_SV
`include "uvm_macros.svh"
`include "uvm_pkg.sv"
import uvm_pkg::*;


// 定义数据类型
typedef struct {
  int id;
  int value;
} data_item;

// 定义seq类
class my_seq extends uvm_sequence;
  `uvm_object_utils(my_seq)
  
  // 配置参数
  int expected_data_count = 10; // 预设的数据量
  int data_count = 0;            // 已获取的数据量
  
  // Mailbox
  mailbox #(data_item) mbx;
  
  // 构造函数
  function new(string name = "my_seq");
    super.new(name);
    // 在new函数中创建mailbox
    mbx = new();
  endfunction
  
  // 主任务
  virtual task body();
    `uvm_info(get_type_name(), $sformatf("Starting sequence with expected data count: %0d", expected_data_count), UVM_LOW)
    
    // 启动两个独立进程
    fork
      // 进程1：向mailbox中put数据
      put_data();
      // 进程2：从mailbox中get数据
      get_data();
      begin 
        #1000;
      end
    join_any
    disable fork;
    
    `uvm_info(get_type_name(), $sformatf("Sequence completed, received %0d data items", data_count), UVM_LOW)
  endtask
  
  // 进程1：向mailbox中put数据
  task put_data();
    data_item item;
    int i=0;
    forever begin
      // 创建数据项
      item.id = i;
      item.value = $urandom_range(0, 100);
      
      // 向mailbox中put数据
      mbx.put(item);
      `uvm_info(get_type_name(), $sformatf("Put data: id=%0d, value=%0d", item.id, item.value), UVM_LOW)
      
      // 随机延迟
      #($urandom_range(1, 5));
      i+=1;
    end
    
    `uvm_info(get_type_name(), "Put data completed", UVM_LOW)
  endtask
  
  // 进程2：从mailbox中get数据
  task get_data();
    data_item item;
    
    forever begin
      // 从mailbox中get数据
      mbx.get(item);
      data_count++;
      
      `uvm_info(get_type_name(), $sformatf("Get data: id=%0d, value=%0d, count=%0d/%0d", 
        item.id, item.value, data_count, expected_data_count), UVM_LOW)
      
      // 随机延迟
      // #($urandom_range(1, 3));
    end
    
    `uvm_info(get_type_name(), "Get data completed", UVM_LOW)
  endtask
endclass

// 测试模块
module test_mailbox_seq;
  my_seq seq;
  uvm_sequencer #(uvm_sequence_item) sequencer;
  
  initial begin
    // 创建sequencer
    sequencer = new("sequencer");
    
    `uvm_info("test", "=== Test started ===", UVM_LOW)
    
    // 第一次创建并运行seq
    `uvm_info("test", "Step 1: Running sequence with default expected data count", UVM_LOW)
    seq = new();
    seq.start(sequencer);
    
    // 第二次创建并运行seq（修改期望数据量）
    `uvm_info("test", "Step 2: Running sequence with 5 expected data count", UVM_LOW)
    seq = new();
    seq.expected_data_count = 5;
    seq.start(sequencer);
    
    // 第三次创建并运行seq（修改期望数据量）
    `uvm_info("test", "Step 3: Running sequence with 8 expected data count", UVM_LOW)
    seq = new();
    seq.expected_data_count = 8;
    seq.start(sequencer);
    
    `uvm_info("test", "=== Test completed ===", UVM_LOW)
  end
endmodule

`endif // MAILBOX_SEQ_DEMO_SV

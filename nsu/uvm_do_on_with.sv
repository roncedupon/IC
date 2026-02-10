`include "uvm_macros.svh"
`include "uvm_pkg.sv"
import uvm_pkg::*;

// 1. Transaction 定义（无修改）
class crc_transaction extends uvm_sequence_item;

  rand bit[31:0] crc_flag; 
  rand bit[31:0] local_test; 

  function new(string name = "crc_transaction");
    super.new(name);
  endfunction
  `uvm_object_utils_begin(crc_transaction)
    `uvm_field_int(crc_flag, UVM_ALL_ON)
    `uvm_field_int(local_test, UVM_ALL_ON)
   `uvm_object_utils_end
endclass

// 2. Sequencer 定义（无修改）
class crc_sequencer extends uvm_sequencer #(crc_transaction);
  `uvm_component_utils(crc_sequencer)
  function new(string name = "crc_sequencer", uvm_component parent);
    super.new(name, parent);
  endfunction
endclass

// 3. Driver 定义（无修改）
class crc_driver extends uvm_driver #(crc_transaction);
  `uvm_component_utils(crc_driver)
  function new(string name = "crc_driver", uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual task run_phase(uvm_phase phase);
    crc_transaction req;
    forever begin
      seq_item_port.get_next_item(req);
      `uvm_info("DRIVER", $sformatf("收到 item 的 crc_flag 值：%0b", req.crc_flag), UVM_LOW);
      req.print();
      seq_item_port.item_done();
    end
  endtask
endclass

// 4. Env 定义（无修改）
class crc_env extends uvm_env;
  `uvm_component_utils(crc_env)
  crc_sequencer sqr;
  crc_driver drv;

  function new(string name = "crc_env", uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    sqr = crc_sequencer::type_id::create("sqr", this);
    drv = crc_driver::type_id::create("drv", this);
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    drv.seq_item_port.connect(sqr.seq_item_export);
  endfunction
endclass

// 5. Sequence 定义（✅ 核心修改：添加 p_sequencer 声明）
class crc_test_sequence extends uvm_sequence #(crc_transaction);
  `uvm_object_utils(crc_test_sequence)

  // 声明 p_sequencer，指定对应的 Sequencer 类型
  `uvm_declare_p_sequencer(crc_sequencer)

  bit [31:0]crc_flag; // sequence 局部变量

  function new(string name = "crc_test_sequence");
    super.new(name);
  endfunction

  task test_no_local();
    crc_transaction req;
    crc_flag = 'h123;
    `uvm_info("SEQ", $sformatf("测试【无local::】：sequence局部crc_flag=%0b", crc_flag), UVM_LOW);
    `uvm_do_on_with(req, p_sequencer, { local_test == crc_flag; });
  endtask

  task test_with_local();
    crc_transaction req;
    crc_flag = 'h456;
    `uvm_info("SEQ", $sformatf("测试【带local::】：sequence局部crc_flag=%0b", crc_flag), UVM_LOW);
    `uvm_do_on_with(req, p_sequencer, { local_test == local::crc_flag; });
  endtask

  virtual task body();
    test_no_local();
    #10;
    test_with_local();
  endtask
endclass

// 6. Test 定义（无修改）
class crc_base_test extends uvm_test;
  `uvm_component_utils(crc_base_test)
  crc_env env;

  function new(string name = "crc_base_test", uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = crc_env::type_id::create("env", this);
  endfunction

  virtual task run_phase(uvm_phase phase);
    crc_test_sequence seq;
    phase.raise_objection(this);
    seq = crc_test_sequence::type_id::create("seq");
    seq.start(env.sqr); // 启动时关联正确的 sequencer
    #100;
    phase.drop_objection(this);
  endtask
endclass

// 7. 仿真入口（无修改）
module tb;
  bit [7:0] last_ptr=2;  
  bit [31:0] a_bit;      
  bit [31:0] a_int;    
  int aaa_array[];
  initial begin
    // run_test("crc_base_test");
    aaa_array=new[0];
    foreach(aaa_array[i]) begin
      aaa_array[i]=123;
      $display("i=%0d",aaa_array[i]);
    end
    $display("%d",last_ptr*28*4);
    a_bit = 32'hffffffff;
    a_int = last_ptr;
    $display("a_int=%0d",a_int);
  end
endmodule
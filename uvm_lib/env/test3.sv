`include "uvm_pkg.sv"
`include "uvm_macros.svh"
import uvm_pkg::*;
typedef my_env; 
// 极简事务类：用int类型代替复杂trans，方便看数据
class my_trans extends uvm_sequence_item;
  rand int data;
  `uvm_object_utils(my_trans)
  function new(string name="my_trans");super.new(name);endfunction
endclass

// ========== 写端：Monitor 连续向analysis_fifo写入数据 1/2/3 ==========
class my_monitor extends uvm_monitor;
  `uvm_component_utils(my_monitor)
  uvm_analysis_port #(my_trans) ap;
  my_trans tr;
my_env env_h;
  function new(string name, uvm_component parent);super.new(name,parent);endfunction
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    ap = new("ap", this);
    tr = my_trans::type_id::create("tr", this);
  endfunction

  // 核心：Monitor在run_phase中【连续写入3笔数据】，模拟硬件采集的时序
virtual task run_phase(uvm_phase phase);
    my_trans tr;
    int cnt;    
    super.run_phase(phase);
    #10;
    // ✅ 每笔数据都new一个独立的句柄+内存块，互不干扰
    tr = my_trans::type_id::create("tr", this); tr.data=1; ap.write(tr); 
    `uvm_info("MON_WR", "写入FIFO → 第1笔数据 data=1", UVM_LOW);
    tr = my_trans::type_id::create("tr", this); tr.data=2; ap.write(tr); 
    `uvm_info("MON_WR", "写入FIFO → 第2笔数据 data=2", UVM_LOW);
    tr = my_trans::type_id::create("tr", this); tr.data=3; ap.write(tr); 
    `uvm_info("MON_WR", "写入FIFO → 第3笔数据 data=3", UVM_LOW);
    `uvm_info("SBD_RD", "Scoreboard开始等待读取FIFO数据...", UVM_LOW);
     $cast(env_h, this.get_parent());
    forever begin
      env_h.sbd.afifo.get(tr); // ❗ 就是这个get方法，复现你的问题
      cnt++;
      `uvm_info("SBD_RD", $sformatf("第%d次get → 读到的数据 = %0d", cnt, tr.data), UVM_LOW);
    end
endtask
endclass

// ========== 读端：Scoreboard 用get()读analysis_fifo，复现你的问题 ==========
class my_scoreboard extends uvm_scoreboard;

  uvm_tlm_analysis_fifo #(my_trans) afifo;
  my_trans tr;
  int cnt;
  `uvm_component_utils(my_scoreboard)
  function new(string name, uvm_component parent);super.new(name,parent);endfunction
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    afifo = new("afifo", this); // 无设置容量，默认无限大
    tr = my_trans::type_id::create("tr", this);
    cnt = 0;
  endfunction

  // 核心：Scoreboard用你问题中的【afifo.get()阻塞读取】
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    `uvm_info("SBD_RD", "Scoreboard开始等待读取FIFO数据...", UVM_LOW);
    // forever begin
    //   afifo.get(tr); // ❗ 就是这个get方法，复现你的问题
    //   cnt++;
    //   `uvm_info("SBD_RD", $sformatf("第%d次get → 读到的数据 = %0d", cnt, tr.data), UVM_LOW);
    // end
  endtask
endclass

// ========== 环境：连接Monitor的ap和Scoreboard的afifo ==========
class my_env extends uvm_env;
  `uvm_component_utils(my_env)
  my_monitor mon;
  my_scoreboard sbd;

  function new(string name, uvm_component parent);super.new(name,parent);endfunction
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    mon = my_monitor::type_id::create("mon", this);
    sbd = my_scoreboard::type_id::create("sbd", this);
  endfunction
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    mon.ap.connect(sbd.afifo.analysis_export); // 标准连接方式
  endfunction
endclass

// ========== 测试用例 + 顶层 ==========
class my_test extends uvm_test;
  `uvm_component_utils(my_test)
  my_env env;
  function new(string name, uvm_component parent);super.new(name,parent);endfunction
  virtual function void build_phase(uvm_phase phase);super.build_phase(phase);env = new("env", this);endfunction
  virtual task run_phase(uvm_phase phase);phase.raise_objection(this); #100; phase.drop_objection(this);endtask
endclass

module tb;
  initial begin run_test("my_test"); end
endmodule
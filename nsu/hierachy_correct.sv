`ifndef AP_TRANSFER_DEMO_V2_SV
`define AP_TRANSFER_DEMO_V2_SV

/*关键修改点解释
env 的 connect_phase 修复：
原代码：agtA.ap = agtB.ap;（直接赋值，覆盖连接）
修复后：agtB.ap.connect(agtA.ap);（建立 port 之间的连接，数据会从 agentB.ap 流向 agentA.ap）
原理：uvm_analysis_port 的 connect 方法会把接收端的 analysis_export/analysis_port 加入发送端的订阅列表，数据调用 write 时会遍历列表并转发。
数据流向验证：修复后的数据流向：agentB.ap.write() → agentA.ap → a_checker.afifo → a_checker.get_port.get()
预期输出：运行代码后会看到以下日志（验证数据成功传递）：
plaintext
UVM_INFO: agentA 的 analysis_port 已成功创建
UVM_INFO: agentA 完成 ap → checker.afifo 的连接
UVM_INFO: env 完成 agentB.ap → agentA.ap 的连接
UVM_INFO: agentB 发送数据：pkt_id=200, data=0x87654321
UVM_INFO: Checker从FIFO取数：pkt_id=200, data=0x87654321
总结
核心错误：直接赋值 uvm_analysis_port 对象会覆盖原有连接，这是对 UVM 通信机制的误用。
正确做法：使用 connect 方法建立 analysis_port 之间的连接，发送端（agentB）的 ap 连接到接收端（agentA）的 ap。
数据流向：agentB 发送的数据通过 ap 连接流向 agentA 的 ap，再进入 checker 的 afifo，最终被 checker 成功取出验证。
这个修复遵循了 UVM 分析端口的标准使用规范，确保了数据能正确传递到目标组件
*/

`include "uvm_macros.svh"
`include "uvm_pkg.sv"
import uvm_pkg::*;

// 1. 基础事务类
class pkt_trans extends uvm_sequence_item;
  rand int pkt_id;
  rand bit [31:0] data;
  `uvm_object_utils(pkt_trans)
  
  function new(string name = "pkt_trans");
    super.new(name);
  endfunction
endclass

// 2. agentA 内部的 Checker（内含 analysis_fifo）
class a_checker extends uvm_component;
  uvm_tlm_analysis_fifo#(pkt_trans) afifo; // 核心FIFO
  uvm_get_port#(pkt_trans) get_port;   // 取数端口

  `uvm_component_utils(a_checker)
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
    afifo = new("afifo", this);
    get_port = new("get_port", this);
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    get_port.connect(afifo.get_export); // 绑定FIFO取数端口
  endfunction

  // 循环从FIFO取数，验证接收成功
  virtual task run_phase(uvm_phase phase);
    pkt_trans tr;
    super.run_phase(phase);
    forever begin
      get_port.get(tr); // 阻塞等待取数
      `uvm_info("CHECKER_FIFO", $sformatf("Checker从FIFO取数：pkt_id=%0d, data=0x%08x", tr.pkt_id, tr.data), UVM_LOW)
    end
  endtask
endclass

// 3. agentA（用 analysis_port，而非 export）
class agentA extends uvm_agent;
  // 关键：agentA 用 analysis_port 承接数据
  uvm_analysis_port#(pkt_trans) ap;
  // 内部组件：checker
  a_checker chk;

  `uvm_component_utils(agentA)
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
    ap = new("ap", this); // 初始化 analysis_port
  endfunction

  // build_phase：创建checker
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    chk = a_checker::type_id::create("chk", this);
  endfunction

  // connect_phase：agentA 内部连接自身ap到checker的fifo
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    if(ap!=null) begin
      `uvm_info("AGENTA_AP", "agentA 的 analysis_port 已成功创建", UVM_LOW)
      ap.connect(chk.afifo.analysis_export); // 核心：自身ap连到fifo
    end else begin
      `uvm_fatal("AGENTA_AP", "agentA 的 analysis_port 创建失败")
    end
    
    `uvm_info("AGENTA_CONNECT", "agentA 完成 ap → checker.afifo 的连接", UVM_LOW)
  endfunction
endclass

// 4. agentB（数据发送端，analysis_port）
class agentB extends uvm_agent;
  uvm_analysis_port#(pkt_trans) ap; // 发送端ap

  `uvm_component_utils(agentB)
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
    ap = new("ap", this);
  endfunction

  // 发送测试数据
  task send_pkt();
    pkt_trans tr = new();
    tr.randomize() with {pkt_id == 200; data == 32'h87654321;};
    `uvm_info("AGENTB_SEND", $sformatf("agentB 发送数据：pkt_id=%0d, data=0x%08x", tr.pkt_id, tr.data), UVM_LOW)
    ap.write(tr); // 从agentB的ap发送数据
  endtask
endclass

// 5. 顶层env（核心：用connect连接 agentB.ap 到 agentA.ap）
class top_env extends uvm_env;
  agentA agtA;
  agentB agtB;

  `uvm_component_utils(top_env)
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  // build_phase：创建两个agent
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agtA = agentA::type_id::create("agtA", this);
    agtB = agentB::type_id::create("agtB", this);
  endfunction

  // connect_phase：用connect方法建立连接（替代直接赋值）
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    agtB.ap.connect(agtA.ap); // 核心修复：发送端ap连接到接收端ap
    `uvm_info("ENV_CONNECT", "env 完成 agentB.ap → agentA.ap 的连接", UVM_LOW)
  endfunction
endclass

// 6. 测试用例
class ap_assign_test extends uvm_test;
  top_env env;

  `uvm_component_utils(ap_assign_test)
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = top_env::type_id::create("env", this);
  endfunction

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);
    env.agtB.send_pkt(); // 触发agentB发送数据
    #10ns; // 等待数据流入FIFO
    phase.drop_objection(this);
  endtask
endclass

// 7. 测试入口
module tb;
  initial begin
    run_test("ap_assign_test");
  end
endmodule
`endif
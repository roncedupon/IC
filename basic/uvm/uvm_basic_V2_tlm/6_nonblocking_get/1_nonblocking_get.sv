`include "uvm_pkg.sv"
`include "uvm_macros.svh"
import uvm_pkg::*;
//1. 定义数据类
class Packet extends uvm_object;
  rand bit [7:0] addr;
  rand bit [7:0] data;

  `uvm_object_utils_begin(Packet)
    `uvm_field_int(addr, UVM_ALL_ON)
    `uvm_field_int(data, UVM_ALL_ON)
  `uvm_object_utils_end

  function new(string name = "Packet");
    super.new(name);
  endfunction
endclass

//2. 创建接收器组件
class ComponentB extends uvm_monitor;
  `uvm_component_utils(ComponentB)
  
  uvm_nonblocking_get_port#(Packet) m_get_port;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    m_get_port = new("m_get_port", this);
  endfunction

  virtual task run_phase(uvm_phase phase);
    Packet pkt;
    phase.raise_objection(this);
    
    if (m_get_port.try_get(pkt)) begin
      `uvm_info("COMPB", "Received packet", UVM_LOW)
      pkt.print(uvm_default_line_printer);
    end else begin
      `uvm_info("COMPB", "No packet received", UVM_LOW)
    end

    phase.drop_objection(this);
  endtask
endclass

//3. 创建发送器组件
class ComponentA extends uvm_component;
  `uvm_component_utils(ComponentA)

  uvm_nonblocking_get_imp#(Packet, ComponentA) m_get_imp;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunctio

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    m_get_imp = new("m_get_imp", this);
  endfunction

  virtual function bit try_get(output Packet pkt);
    pkt = new();
    assert(pkt.randomize());
    return 1; // 表示获取成功
  endfunction

    virtual function bit can_get();
        return 1; // 表示获取成功
    endfunction
endclass

// 4. 连接端口与实现
class MyTest extends uvm_test;
  `uvm_component_utils(MyTest)

  ComponentA compA;
  ComponentB compB;

  function new(string name = "MyTest", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    compA = ComponentA::type_id::create("compA", this);
    compB = ComponentB::type_id::create("compB", this);
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    compB.m_get_port.connect(compA.m_get_imp);
  endfunction
endclass


module top;
    reg clk;
    reg rstn;

    initial begin
        run_test("MyTest");
    end
    initial begin

        $display("start run dut test");
        $fsdbDumpfile("waves.fsdb");
        $fsdbDumpvars(0,top,"+mda");
   
        $dumpfile ("waves.vcd");//生成vcd文件，映射回windows远程文件夹，目前存放在上级目录中的waves中
        $dumpvars(0,top);
    end
    initial begin
        clk=0;
        rstn=0;
        #1000
        rstn=1;
        #5000
        $display("finish sim");
        $finish;
    end
    always#5 clk=~clk;

endmodule
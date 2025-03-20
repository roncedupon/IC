`include "uvm_pkg.sv"
`include "uvm_macros.svh"
`include "dut_driver.sv"
`include "dut_monitor.sv"
import uvm_pkg::*;
class dut_agent extends uvm_agent;
    //step1:注册component
    `uvm_component_utils(dut_agent)
    //step2：实现new函数
    function new(string name="dut_agent",uvm_component parent);
        super.new(name,parent);
    endfunction
    //step3：声明各种所需的component组件
    dut_driver dut_driver_inst;
    dut_monitor dut_monitor_inst;
    // uvm_sequencer#(dut_transaction)s0;//sequencer handle

    //step4：实现build_phase,并实例化所有组件
    virtual function void build_phase(uvm_phase phase);
        $display("dut_agent build_phase start");
        super.build_phase(phase);
        // s0=uvm_sequencer#(dut_transaction)::type_id::create("s0",this);
        dut_driver_inst=dut_driver::type_id::create("dut_driver_inst",this);
        dut_monitor_inst=dut_monitor::type_id::create("dut_monitor_inst",this);
        $display("dut_agent build_phase end");

    endfunction
    //step5：实现connect phase
    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        //将sequencer连接到driver上
        // dut_driver_inst.seq_item_port.connect(s0.seq_item_export);
        $display("dut_driver_inst port connected");
        
    endfunction

endclass


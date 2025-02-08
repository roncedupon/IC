`include "uvm_pkg.sv"
`include "uvm_macros.svh"
`include "dut_driver.sv"
`include "dut_monitor.sv"
import uvm_pkg::*;
class dut_env extends uvm_env;
    dut_driver drv;
    dut_monitor mon;
    `uvm_component_utils(dut_env);
    function new(string name="dut_env",uvm_component parent);
        super.new(name,parent);
    endfunction
    
    virtual function void build_phase(uvm_phase phase);
        $display("starting env build_phase");   
        super.build_phase(phase);
        drv=dut_driver::type_id::create("drv",this);
        mon=dut_monitor::type_id::create("mon",this);
        $display("env build_phase end");
    endfunction



endclass

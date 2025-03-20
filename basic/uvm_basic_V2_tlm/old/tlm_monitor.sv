`ifndef TLM_MONITOR
`define TLM_MONITOR

`include "uvm_pkg.sv"
`include "uvm_macros.svh"
`include "tlm_tr.sv"
import uvm_pkg::*;
class tlm_monitor extends uvm_monitor;
    `uvm_component_utils(tlm_monitor)
    function new(string name="tlm_monitor",uvm_component parent);
        super.new(name,parent);
    endfunction
    uvm_analysis_port#(tlm_tr)mon_analysis_port;
    virtual dut_vif vif;
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual dut_vif)::get(this,"","vif",vif))
            `uvm_fatal("Monitot","Could not get vif");
        mon_analysis_port=new("mon_analysis_port",this);
    endfunction

    extern virtual task run_phase(uvm_phase phase);
endclass
task tlm_monitor::run_phase(uvm_phase phase);
    super.run_phase(phase);
    forever begin
        tlm_tr tr=new();
        @(posedge vif.clk);
        tr.a=vif.a;
        tr.b=vif.b;
        tr.c=vif.c;
        mon_analysis_port.write(tr);
    end
endtask
`endif 
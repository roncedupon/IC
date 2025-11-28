`ifndef TLM_ENV
`define TLM_ENV
`include "uvm_pkg.sv"
`include "uvm_macros.svh"
`include "tlm_driver.sv"
`include "tlm_seqr.sv"
`include "tlm_monitor.sv"
`include "tlm_scb.sv"
import uvm_pkg::*;
class tlm_env extends uvm_env;
    `uvm_component_utils(tlm_env)
    function new(string name="tlm_env",uvm_component parent);
        super.new(name,parent);
    endfunction
    tlm_driver  drv;
    tlm_monitor mon;
    tlm_scb     scb;
    tlm_seqr    sqr;
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        drv=tlm_driver::type_id::create("drv",this);
        mon=tlm_monitor::type_id::create("mon",this);
        scb=tlm_scb::type_id::create("scb",this);
        sqr=tlm_seqr::type_id::create("sqr",this);

        uvm_config_db#(uvm_object_wrapper)::set(this,"sqr.main_phase","default_sequence",tlm_seq::type_id::get());

    endfunction
    extern virtual function void connect_phase(uvm_phase phase);
endclass
function void tlm_env::connect_phase(uvm_phase phase);
    $display("env connect_phase start");
    
    super.connect_phase(phase);
    mon.mon_analysis_port.connect(scb.m_analysis_imp);
    drv.seq_item_port.connect(sqr.seq_item_export);
    $display("env connect_phase end");
endfunction
`endif
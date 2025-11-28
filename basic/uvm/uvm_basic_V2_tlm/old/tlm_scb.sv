`ifndef TLM_SCB
`define TLM_SCB
`include "uvm_pkg.sv"
`include "uvm_macros.svh"
`include "tlm_tr.sv"
import uvm_pkg::*;
class tlm_scb extends uvm_scoreboard;
    `uvm_component_utils(tlm_scb)
    function new(string name="tlm_scb",uvm_component parent);
        super.new(name,parent);
    endfunction
    uvm_analysis_imp#(tlm_tr,tlm_scb)m_analysis_imp;
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        m_analysis_imp=new("m_analysis_imp",this);
    endfunction
    virtual function write(tlm_tr item);
        $display("socreboard detect--a[%d]--b[%d]--c[%d]--expect[%d]",item.a,item.b,item.c,item.a+item.b);
    endfunction
endclass
`endif 
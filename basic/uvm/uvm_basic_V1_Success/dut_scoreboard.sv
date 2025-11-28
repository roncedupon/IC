`include "uvm_pkg.sv"
`include "uvm_macros.svh"
`include "dut_transaction.sv"
import uvm_pkg::*;
class dut_scoreboard extends uvm_scoreboard;
    integer cnt=0;
    `uvm_component_utils(dut_scoreboard)
    function new(string name,uvm_component parent=null);
        super.new(name,parent);
    endfunction
    dut_transaction tr_array[100];
    uvm_analysis_imp#(dut_transaction,dut_scoreboard)m_analysis_imp;
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        m_analysis_imp=new("m_analysis_imp",this);
    endfunction
    virtual function write(dut_transaction item);
        // $display("socreboard detect[%d]--en_o[%d]--data_o[%d]",cnt,item.en_i,item.data_in);
        cnt=cnt+1;
    endfunction
endclass

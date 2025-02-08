`include "uvm_pkg.sv"
`include "uvm_macros.svh"
import uvm_pkg::*;
`include "ahb_master_directed_sequence.sv"
`include "cust_svt_ahb_system_configuration.sv"
`include "simpleSeq.sv"
`include "ahb_slave_mem_response_sequence.sv"

class myref_mdl extends uvm_component;
    `uvm_component_utils(myref_mdl);
    
endclass

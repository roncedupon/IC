`ifndef APB_TR
`define APB_TR
`include "uvm_pkg.sv"
`include "uvm_macros.svh"
import uvm_pkg::*;
//  Class: apb_transaction
//
class apb_transaction extends uvm_sequence_item;
    string tr_name="apb_transaction";
    int tr_nums=1024;
    `uvm_object_utils(apb_transaction);
    function new(string name = "apb_transaction");
        super.new(name);
    endfunction: new
endclass: apb_transaction

`endif



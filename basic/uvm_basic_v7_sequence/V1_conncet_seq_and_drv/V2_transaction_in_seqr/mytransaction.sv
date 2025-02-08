`ifndef MYTRIANSACTION
`define MYTRIANSACTION
`include "uvm_pkg.sv"
`include "uvm_macros.svh"
import uvm_pkg::*;
//  Class: mytransaction
//
class mytransaction extends uvm_sequence_item;

    //  Group: Variables
    rand bit [7:0]data;
    rand bit valid;
    rand bit [7:0]delay_times;
    `uvm_object_utils_begin(mytransaction);
    `uvm_field_int(data, UVM_ALL_ON)
    `uvm_field_int(valid, UVM_ALL_ON)
    `uvm_field_int(delay_times, UVM_ALL_ON)
    `uvm_object_utils_end



    //  Group: Constraints


    //  Group: Functions

    //  Constructor: new
    function new(string name = "mytransaction");
        super.new(name);
    endfunction: new

    //  Function: do_copy
    // extern function void do_copy(uvm_object rhs);
    //  Function: do_compare
    // extern function bit do_compare(uvm_object rhs, uvm_comparer comparer);
    //  Function: convert2string
    // extern function string convert2string();
    //  Function: do_print
    // extern function void do_print(uvm_printer printer);
    //  Function: do_record
    // extern function void do_record(uvm_recorder recorder);
    //  Function: do_pack
    // extern function void do_pack();
    //  Function: do_unpack
    // extern function void do_unpack();
    
endclass: mytransaction

`endif
/*----------------------------------------------------------------------------*/
/*  Constraints                                                               */
/*----------------------------------------------------------------------------*/




/*----------------------------------------------------------------------------*/
/*  Functions                                                                 */
/*----------------------------------------------------------------------------*/


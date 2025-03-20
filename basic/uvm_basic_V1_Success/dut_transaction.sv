`ifndef  DUT_TRANSACTION
`define DUT_TRANSACTION
`include "uvm_pkg.sv"
`include "uvm_macros.svh"
import uvm_pkg::*;
class dut_transaction extends uvm_sequence_item;
    rand bit data_in;
    rand bit en_i;
    
    function new(string name="dut_transaction");
        super.new(name);
    endfunction
    `uvm_object_utils_begin(dut_transaction)
    `uvm_field_int(data_in,UVM_ALL_ON)
    `uvm_field_int(en_i,UVM_ALL_ON)
    // `uvm_field_int(out,UVM_ALL_ON)
    `uvm_object_utils_end
endclass




//如果增加transaction的参数，只需要继承一下前面的dut_transaction即可
class dut_transaction_new extends dut_transaction;
    rand bit[1:0] inc;
    function new(string name="dut_transaction_new");
        super.new(name);
    endfunction
    `uvm_object_utils_begin(dut_transaction_new)
    `uvm_field_int(inc, UVM_ALL_ON)//这里也只需要额外注册一下inc即可
    `uvm_object_utils_end
endclass
`endif

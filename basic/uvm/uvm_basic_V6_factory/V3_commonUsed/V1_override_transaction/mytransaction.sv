`ifndef MYTRIANSACTION
`define MYTRIANSACTION
`include "uvm_pkg.sv"
`include "uvm_macros.svh"
import uvm_pkg::*;

class mytransaction extends uvm_sequence_item;

    string tr_name="transaction1";
    rand bit [7:0]data;
    rand bit valid;
    rand bit [7:0]delay_times;
    `uvm_object_utils_begin(mytransaction);
    `uvm_field_int(data, UVM_ALL_ON)
    `uvm_field_int(valid, UVM_ALL_ON)
    `uvm_field_int(delay_times, UVM_ALL_ON)
    `uvm_object_utils_end

    function new(string name = "mytransaction");
        super.new(name);

    endfunction: new
    
endclass: mytransaction

class mytransaction2 extends mytransaction;

    
    rand bit [7:0]data;
    rand bit valid;
    rand bit [7:0]delay_times;
    `uvm_object_utils_begin(mytransaction2);
    `uvm_field_int(data, UVM_ALL_ON)
    `uvm_field_int(valid, UVM_ALL_ON)
    `uvm_field_int(delay_times, UVM_ALL_ON)
    `uvm_object_utils_end

    function new(string name = "mytransaction2");
        super.new(name);
        tr_name="transaction2";//这个name一定要注意，不要用他的保留字name，前面就是把这个tr_name换成了name，就不对
    endfunction: new
    
endclass

`endif


`ifndef SPI_TR
`define SPI_TR
`include "uvm_pkg.sv"
`include "uvm_macros.svh"
import uvm_pkg::*;
//  Class: spi_transaction
//
class spi_transaction extends uvm_sequence_item;

    //  Group: Variables
    rand bit [7:0]data;
    rand bit valid;
    rand bit [7:0]delay_times;
    `uvm_object_utils_begin(spi_transaction);
    `uvm_field_int(data, UVM_ALL_ON)
    `uvm_field_int(valid, UVM_ALL_ON)
    `uvm_field_int(delay_times, UVM_ALL_ON)
    `uvm_object_utils_end
    string tr_name="spi_transaction";
    int tr_nums=1024;
    function new(string name = "spi_transaction");
        super.new(name);
    endfunction: new

    
endclass: spi_transaction

`endif



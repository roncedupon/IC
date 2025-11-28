`ifndef SPI_SEQ
`define SPI_SEQ
`include "uvm_pkg.sv"
`include "uvm_macros.svh"

`include "spi_transaction.sv"
import uvm_pkg::*;
//  Class: spi_seq
//
// event send_over;//全局事件
class spi_seq extends uvm_sequence;
    spi_transaction tr;
    int nums=5;
    string tr_name="spi_default_name";
    `uvm_object_utils(spi_seq);

    function new(string name = "spi_seq");
        super.new(name);
    endfunction: new

    virtual task body();
        super.body();

        if(starting_phase!=null)begin
            `uvm_info("spi_seq body","starting_phase!=null,starting_phase.raise_objection(this);",UVM_ALL_ON)
            starting_phase.raise_objection(this);
        end
    
        repeat(nums)begin
            // $display("spi_seq");
            `uvm_do(tr);
        end
        #1000
        if(starting_phase!=null)begin
            `uvm_info("spi_seq body","starting_phase!=null,starting_phase.drop_objection(this);",UVM_ALL_ON)
            starting_phase.drop_objection(this);
        end

    endtask

    
endclass: spi_seq

`endif
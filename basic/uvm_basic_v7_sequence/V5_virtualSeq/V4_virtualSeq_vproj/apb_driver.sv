`ifndef APB_DRIVER
`define APB_DRIVER
`include "uvm_pkg.sv"
`include "uvm_macros.svh"
`include "apb_transaction.sv"
import uvm_pkg::*;
//  Class: apb_driver
//
class apb_driver extends uvm_driver#(apb_transaction);
    virtual delay_interface vif;
    `uvm_component_utils(apb_driver)
    function new(string name="apb_driver",uvm_component parennt);    
        super.new(name,parennt);
    endfunction //new()


    //  Function: build_phase
    extern function void build_phase(uvm_phase phase);
    //  Function: run_phase
    extern task run_phase(uvm_phase phase);
    extern task drive_one_pkg(apb_transaction tr);
endclass 

function void apb_driver::build_phase(uvm_phase phase);
    /*  note: Do not call super.build_phase() from any class that is extended from an UVM base class!  */
    /*  For more information see UVM Cookbook v1800.2 p.503  */
    //super.build_phase(phase);
    if(!uvm_config_db#(virtual delay_interface)::get(this,"","vif",vif))
        `uvm_fatal(get_type_name(),"didn't get handle to virtual interface vif!!")
    
endfunction: build_phase
task apb_driver::run_phase(uvm_phase phase);
    vif.data=0;
    vif.valid=0;
    vif.delay_times=0;
    `uvm_info(get_name(), "<run_phase> started, objection raised.", UVM_NONE)
    @(posedge vif.clk);

    while(~vif.rst_n)begin
        $display("[%0d]  ready[%0d] Waiting rst_n--%0d",$time,vif.ready,vif.rst_n);
        @(posedge vif.clk);
        $display("Waiting rst_n");
    end//等复位好
    while(1)begin
        
        seq_item_port.get_next_item(req);//这些代码应该都是固定的
        // req.print();
        drive_one_pkg(req);
        seq_item_port.item_done();
    end
    
endtask: run_phase

task apb_driver::drive_one_pkg(apb_transaction tr);
        $display("[apb driver]%s",tr.tr_name);
endtask
`endif 
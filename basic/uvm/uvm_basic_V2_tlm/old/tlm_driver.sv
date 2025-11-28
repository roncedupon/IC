`ifndef TLM_DRIVER
`define TLM_DRIVER
`include "uvm_pkg.sv"
`include "uvm_macros.svh"
`include "tlm_tr.sv"
import uvm_pkg::*;
class tlm_driver extends uvm_driver#(tlm_tr);
    `uvm_component_utils(tlm_driver)
    function new(string name="tlm_driver",uvm_component parent);
        super.new(name,parent);
    endfunction

    //添加vif虚拟接口  (固定步骤)
    virtual dut_vif vif;
    //实现build phase (固定步骤)
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual dut_vif)::get(this,"","vif",vif))
            `uvm_fatal(get_type_name(),"didn't get handle to virtual interface vif!!")
    endfunction
    //实现main_phase
    extern virtual task main_phase(uvm_phase phase);
    extern virtual task drive_one_pkg(tlm_tr tr);
endclass

task tlm_driver::main_phase(uvm_phase phase);
    super.main_phase(phase);
    vif.a<=0;
    vif.b<=0;
    @(posedge vif.clk);
    while(~vif.rstn)begin
        $display("Waiting rstn");
        @(posedge vif.clk);
        $display("Waiting rstn");
    end//等复位好
    //之后便从sequencer中获取tr并驱动
    while(1) begin
        `uvm_info(get_type_name(),$sformatf("waiting for data from sequencer"),UVM_MEDIUM)
        $display("rstn is %d",vif.rstn);
        seq_item_port.get_next_item(req);//这些代码应该都是固定的
        if (req==null)begin
            @(posedge vif.clk);
            $display("null req");
        end
        else begin
            drive_one_pkg(req);
            $display("req drivered");
            seq_item_port.item_done();
        end
    end
endtask

task tlm_driver::drive_one_pkg(tlm_tr tr);
    `uvm_info("drive_one_pkg","strat drive one pkg",UVM_ALL_ON)
    @(posedge vif.clk)
    vif.a<=tr.a;
    vif.b<=tr.b;
endtask
`endif 
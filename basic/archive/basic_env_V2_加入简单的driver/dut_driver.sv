`ifndef DUT_DRIVER
`define DUT_DRIVER
`include "uvm_macros.svh"
`include "uvm_pkg.sv"
`include "dut_vif.sv"
`include "dut_transaction.sv"
import uvm_pkg::*;
//第三步开始实现driver
class dut_driver extends uvm_driver#(dut_transaction);
    //step1:先注册成component  (固定步骤)
    `uvm_component_utils(dut_driver);
    //step2:实现new函数  (固定步骤)
    function new (string name="dut_driver",uvm_component parent=null);
        super.new(name,parent);
    endfunction
    //step3:添加vif虚拟接口  (固定步骤)
    virtual dut_vif vif;
    //step4:实现build phase (固定步骤)
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual dut_vif)::get(this,"","vif",vif))
            `uvm_fatal(get_type_name(),"didn't get handle to virtual interface vif!!")
    endfunction
    //step5:实现run phase (固定步骤)
        //在run phase中主要完成以下工作:
        //一、从sequencer中获取新的transaction
        //二、解析transaction，并将数据打到DUT接口里
        //三、完成对transaction的驱动
    virtual task main_phase(uvm_phase phase);  
        // super.main_phase(phase);
        phase.raise_objection(this);
        vif.data_in<=0;
        vif.en_i<=0;
        $display("[%d ]vif.rstn is %d,vif.clk is %d ",$time,vif.rstn,vif.clk);
        $display("[%d ]vif.rstn is %d,vif.clk is %d ",$time,vif.rstn,vif.clk);
        $display("[%d ]vif.rstn is %d,vif.clk is %d ",$time,vif.rstn,vif.clk);
        $display("[%d ]vif.rstn is %d,vif.clk is %d ",$time,vif.rstn,vif.clk);
        $display("[%d ]vif.rstn is %d,vif.clk is %d ",$time,vif.rstn,vif.clk);
        $display("[%d ]vif.rstn is %d,vif.clk is %d ",$time,vif.rstn,vif.clk);
        $display("[%d ]vif.rstn is %d,vif.clk is %d ",$time,vif.rstn,vif.clk);
        @(posedge vif.clk);
        while(~vif.rstn)begin
            $display("Waiting rstn");
            #1
            @(posedge vif.clk);
            $display("Waiting rstn");
        end//等复位好
        for(int i=0;i<2048;i=i+1) begin
            `uvm_info(get_type_name(),$sformatf("waiting for data from sequencer"),UVM_MEDIUM)
            $display("rstn is %d",vif.rstn);
            // seq_item_port.get_next_item(req);//这些代码应该都是固定的
            // if (req==null)begin
            //     @(posedge vif.clk);
            //     $display("null req");
            // end
            // else begin
            //     drive_one_pkg(req);
            //     $display("req drivered");
            //     seq_item_port.item_done();
            // end
            @(posedge vif.clk)
            vif.data_in<=$urandom_range(0, 1);//tr.data_in;
            vif.en_i<=$urandom_range(0, 1);//tr.en_i;
            
        end
        phase.drop_objection(this);
    endtask
    extern virtual task drive_one_pkg(dut_transaction tr);

endclass

task dut_driver::drive_one_pkg(dut_transaction tr);
    `uvm_info("drive_one_pkg","strat drive one pkg",UVM_ALL_ON)
    @(posedge vif.clk)
    vif.data_in<=$urandom_range(0, 1);//tr.data_in;
    vif.en_i<=$urandom_range(0, 1);//tr.en_i;
    
endtask
`endif 

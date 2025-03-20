`include "uvm_pkg.sv"
`include "uvm_macros.svh"
`include "dut_transaction.sv"
import uvm_pkg::*;
//第四步：实现monitor，用于监视interface上的活动
class dut_monitor extends uvm_monitor;
    //step1：注册componet
    `uvm_component_utils(dut_monitor)
    //step2：实现new函数
    function new(string name="dut_monitor",uvm_component parent);
        super.new(name,parent);
    endfunction
    //step3：插入一个uvm_analysis_port
    uvm_analysis_port#(dut_transaction)mon_analysis_port;
    //step4:添加vif虚拟接口
    virtual dut_vif vif;
    //step5:实现build_phase
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual dut_vif)::get(this,"","vif",vif))
            `uvm_fatal("Monitot","Could not get vif");
        mon_analysis_port=new("mon_analysis_port",this);
    endfunction

    //step6:实现run phase
    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        @(posedge vif.clk);
        forever begin
            dut_transaction tr=new();
            tr.data_in=vif.data_out;
            tr.en_i=vif.en_o;//这里命名有点问题，因为这里读写的transaction用的是一个
            mon_analysis_port.write(tr);//最后记得将封装好的transaction发出去
        end 
    endtask
endclass


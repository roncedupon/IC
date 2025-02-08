
`ifndef SoftMax_Agent
`define SoftMax_Agent
`include "uvm_macros.svh"
`include "uvm_pkg.sv"
`include "driver.sv"
`include "SoftMax_Monitor.sv"
`include "SoftMax_Transaction_Out.sv"
//由于driver和monitor处理的是同一套协议，所以有着高度的相似性，即在同一套既定规则下做不同的事情
    //所以基于二者的相似性，UVM中经常将二者封装在一起，成为一个agent，即不同的agent代表了不同的协议
class SoftMax_Agent extends uvm_agent;
    driver SoftMax_Driver_Inst;
    SoftMax_Monitor SoftMax_Monitor_Inst;
    uvm_analysis_port#(SoftMax_Transaction_Out)ap;
    function new(string name,uvm_component parent);
        super.new(name,parent);
    endfunction

    extern virtual function void build_phase(uvm_phase phase);
    extern virtual function void connect_phase(uvm_phase phase);

    `uvm_component_utils(SoftMax_Agent);//
endclass


function void SoftMax_Agent::build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(is_active==UVM_ACTIVE)begin//is_active 是uvm_agent的一个成员变量，为枚举类型---UVM_PASSIVE和UVM_ACTIVE
                                    //is_active 默认为UVM_ACTIVE
        SoftMax_Driver_Inst=driver::type_id::create("SoftMax_Driver_Inst",this);
    end
    SoftMax_Monitor_Inst=SoftMax_Monitor::type_id::create("SoftMax_Monitor_Inst",this);
endfunction

function void SoftMax_Agent::connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    ap=SoftMax_Monitor_Inst.ap;
endfunction

`endif 

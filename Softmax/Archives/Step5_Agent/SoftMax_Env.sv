`include "uvm_macros.svh"
`include "uvm_pkg.sv"
`include "driver.sv"
`include "SoftMax_Monitor.sv"
`include "SoftMax_Agent.sv"
class SoftMax_Env extends uvm_env;//component组件都需要有parent
    // driver SoftMax_Driver;
    // SoftMax_Monitor SoftMax_Monitor_Inst;
    SoftMax_Agent Stage1_FindMax_Agent;//Stage1  agent


    function new(string name="SoftMax_Env",uvm_component parent);
        super.new(name,parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);//build phase的执行顺序从树根到树叶
        `uvm_info("SoftMax_Env","main_phase is called",UVM_LOW);
        Stage1_FindMax_Agent=SoftMax_Agent::type_id::create("Stage1_FindMax_Agent",this);//factory 机制
        Stage1_FindMax_Agent.is_active=UVM_ACTIVE;//需要对输入和输出接口进行监视
            //只有使用factory机制注册过的类才可以使用这种方式进行实例化
            //主要是用factory机制中强大的重载功能
        // SoftMax_Monitor_Inst=SoftMax_Monitor::type_id::create("SoftMax_Monitor_Inst",this);

    endfunction
    
    `uvm_component_utils(SoftMax_Env);
endclass

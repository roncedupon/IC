`include "uvm_macros.svh"
`include "uvm_pkg.sv"
`include "driver.sv"
`include "SoftMax_Monitor.sv"
`include "SoftMax_Agent.sv"
`include "SoftMax_Ref.sv"
`include "SoftMax_ScoreBoard.sv"
class SoftMax_Env extends uvm_env;//component组件都需要有parent
    // driver SoftMax_Driver;
    // SoftMax_Monitor SoftMax_Monitor_Inst;
    SoftMax_Agent Stage1_FindMax_iAgent;//Stage1  agent
    SoftMax_Agent Stage1_FindMax_oAgent;//Stage1  agent
    uvm_tlm_analysis_fifo#(SoftMax_Transaction_Out)agt_mdl_fifo;//agent----ref model
    uvm_tlm_analysis_fifo#(SoftMax_Transaction_Out)agt_scb_fifo;//agent----score board
    uvm_tlm_analysis_fifo#(SoftMax_Transaction_Out)mdl_scb_fifo;//ref model---score board
    SoftMax_Ref SoftMax_Ref_Inst;
    SoftMax_ScoreBoard Stage1_FIndMax_SocreBoard;

    function new(string name="SoftMax_Env",uvm_component parent);
        super.new(name,parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);//build phase的执行顺序从树根到树叶
        `uvm_info("SoftMax_Env","main_phase is called",UVM_LOW);
        Stage1_FindMax_iAgent=SoftMax_Agent::type_id::create("Stage1_FindMax_iAgent",this);//factory 机制
        Stage1_FindMax_iAgent.is_active=UVM_ACTIVE;//需要对输入和输出接口进行监视
            //只有使用factory机制注册过的类才可以使用这种方式进行实例化
            //主要是用factory机制中强大的重载功能

        Stage1_FindMax_oAgent=SoftMax_Agent::type_id::create("Stage1_FindMax_oAgent",this);//factory 机制
        Stage1_FindMax_oAgent.is_active=UVM_PASSIVE;//只需要对输出接口进行监视

        SoftMax_Ref_Inst=SoftMax_Ref::type_id::create("SoftMax_Ref",this);
        Stage1_FIndMax_SocreBoard=SoftMax_ScoreBoard::type_id::create("Stage1_FIndMax_SocreBoard",this);
        agt_mdl_fifo=new("agt_mdl_fifo",this);
        agt_scb_fifo=new("agt_scb_fifo",this);
        mdl_scb_fifo=new("mdl_scb_fifo",this);

        // Stage1_FindMax_oAgent.SoftMax_Monitor_Inst.
    endfunction
    extern virtual function void connect_phase(uvm_phase phase);
    `uvm_component_utils(SoftMax_Env);
endclass

function void SoftMax_Env::connect_phase(uvm_phase phase);//connect phase在build phase执行完后马上执行,顺序从树叶到树根
                                                        //先执行driver monitor的connect phase,在是agent,最后是env
    super.connect_phase(phase);
    Stage1_FindMax_iAgent.ap.connect(agt_mdl_fifo.analysis_export);
    SoftMax_Ref_Inst.port.connect(agt_mdl_fifo.blocking_get_export);

    Stage1_FIndMax_SocreBoard.act_port.connect(agt_scb_fifo.blocking_get_export);
    Stage1_FindMax_oAgent.ap.connect(agt_scb_fifo.analysis_export);

    Stage1_FIndMax_SocreBoard.exp_port.connect(mdl_scb_fifo.blocking_get_export);
    SoftMax_Ref_Inst.ap.connect(mdl_scb_fifo.analysis_export);


endfunction

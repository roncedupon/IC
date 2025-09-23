class base_env extends uvm_env;

    /** interface */
    virtual tb_if tb_vif;

    /** virtual sequencer */
    base_vsequencer vsqr;    
    /** field automation */
    `uvm_component_utils(base_env)

    /** uvm phase */
    extern function new(string name="base_env", uvm_component parent=null);
    extern function void build_phase(uvm_phase phase);
    extern function void connect_phase(uvm_p    
    extern function void end_of_elaboration_phase(uvm_phase phase);
    extern function void start_of_simulation_phase(uvm_phase phase);
    extern task configure_phase(uvm_phase phase);
    extern task main_phase(uvm_phase phase);
    extern task shutdown
    extern function void check_phase(uvm_phase phase);
    extern function void report_phase(uvm_phase phase);
    extern function void final_phase(uvm_phase phase);

endclass

function void base_env::build_phase(uvm_phase phase);
    super.build_phase(phase);
    /** virtual sequencer */
    vsqr = base_vsequencer::type_id::create("vsqr",this);

    `ifndef FPGA
    /** interface */
    uvm_config_db #(virtual tb_if)::get(this,"","tb_vif",tb_vif);
    /** Common sys */
endfunction
`include "cust_svt_axi_system_configuration.sv"
class basic_env extends uvm_env;
    svt_axi_master_agent    axi_master_agent;
    svt_axi_slave_agent     axi_slave_agent;
    cust_svt_axi_system_configuration axi_cfg;
    `uvm_component_utils(basic_env)
    function new(string name="basic_env",uvm_component parent);
        super.new(name,parent);
        axi_cfg=cust_svt_axi_system_configuration::type_id::create("axi_cfg",this);
    endfunction
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        uvm_config_db#(svt_axi_port_configuration)::set(this,"axi_master_agent","cfg",axi_cfg.master_cfg[0]);
        uvm_config_db#(svt_axi_port_configuration)::set(this,"axi_slave_agent","cfg",axi_cfg.slave_cfg[0]);
    endfunction
endclass
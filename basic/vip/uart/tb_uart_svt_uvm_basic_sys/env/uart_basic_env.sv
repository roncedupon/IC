
`ifndef GUARD_UART_BASIC_ENV_SV
`define GUARD_UART_BASIC_ENV_SV 
`define SVT_UART_GLOBAL_TIMEOUT 100ms
`define UART_GLOBAL_DRAINTIME 10us

`include "uart_virtual_sequencer.sv"

/**
 * Abstract: 
 * class 'uart_basic_env' is extended from uvm_env base class.  It implements 
 * the build phase to construct the structural elements of this environment. 
 * 
 * uart_basic_env is the testbench environment, which constructs UART DTE 
 * and DCE agents in the build_phase method using the UVM factory service.  
 *
 * uart_basic env also constructs the virtual sequencer. This virtual sequencer 
 * in the testbench environment obtains a handle to the reset interface using 
 * the config db.  This allows reset sequences to be written for this virtual 
 * sequencer.
 * 
 * In the connect_phase it connects DTE and DCE agent’s sequencer handle to 
 * virtual sequencer handle.
 */
class uart_basic_env extends uvm_env ;
   
  /** Declare customized system configuration for dte_agent */
  cust_svt_uart_agent_configuration dte_cfg;
  /** Declare customized system configuration for dce_agent */
  cust_svt_uart_agent_configuration dce_cfg;
  
  /** Declare DTE agent */
  svt_uart_agent dte_agent;
  /** Declare DCE agent */
  svt_uart_agent dce_agent;
  
  /** Declare SV Interface for DTE */
  svt_uart_vif        dte_vif;
  /** Declare SV Interface for DCE */
  svt_uart_vif        dce_vif;
  
  /** Declare the handle of the Virtual Sequencer */
  uart_virtual_sequencer sequencer;
  
  /** UVM object utility macro */
  `uvm_component_utils(uart_basic_env)
    
  /** Class constructor */
  function new( string  name = "uart_basic_env", uvm_component parent = null);
    super.new(name, parent);
  endfunction : new 
   
  /** Build Phase for the environment.  */
  virtual function void build_phase(uvm_phase phase) ;
    int build_ok = 1;
    
    `uvm_info("build_phase", "uart_basic_env BUILD-FLOW: Starting...",UVM_LOW)
	
    super.build_phase(phase);
   
    /** Get the DTE configuration using config_db */
    if (!uvm_config_db#(cust_svt_uart_agent_configuration)::get(this,"","dte_cfg",this.dte_cfg) || (this.dte_cfg == null)) begin
      `uvm_fatal("build_phase", "'dte_cfg' is null. A cust_svt_uart_agent_configuration object must be set using the UVM configuration infrastructure.");
    end
    else begin
      `uvm_info("build_phase",$sformatf("***************Agent Configuration**************\n%0s",
					this.dte_cfg.sprint()), UVM_LOW);
      /** Get the DTE BFM Port Interface to factory */
      if (uvm_config_db#(svt_uart_vif)::get(this, "", "dte_vif", dte_vif)) begin
        if(dte_vif == null) begin
          `uvm_fatal("build_phase", "'dte_vif' is null. A svt_uart_if interface must be set using the UVM configuration infrastructure.");
        end else begin
          `uvm_info("build_phase", "Applying the DTE virtual interface received through the config db to the configuration.", UVM_HIGH);
          dte_cfg.set_uart_if(dte_vif);
        end
      end else begin 
        if (dte_cfg.uart_if == null) begin
          `uvm_fatal("build_phase", "A DTE virtual interface was not received either through the config db, or through the configuration object for the master.");
          build_ok = 0;
        end
      end // else: !if(uvm_config_db#(svt_uart_vif)::get(this, "", "dte_vif", dte_vif))
    end // else: !if(!uvm_config_db#(cust_svt_uart_agent_configuration)::get(this, "", "dte_cfg", this.dte_cfg) ||...
   
    /** Get the DCE configuration using config_db */
    if (!uvm_config_db#(cust_svt_uart_agent_configuration)::get(this,"","dce_cfg",this.dce_cfg) || (this.dce_cfg == null)) begin
      `uvm_fatal("build_phase", "'dce_cfg' is null. A cust_svt_uart_agent_configuration object must be set using the UVM configuration infrastructure.");
    end
    else begin
      `uvm_info("build_phase",$sformatf("***************Agent Configuration**************\n%0s",
					this.dce_cfg.sprint()), UVM_LOW);
      /** Get the DCE BFM Port Interface to factory */
      if (uvm_config_db#(svt_uart_vif)::get(this, "", "dce_vif", dce_vif)) begin
        if(dce_vif == null) begin
        `uvm_fatal("build_phase", "'dce_vif' is null. A svt_uart_if interface must be set using the UVM configuration infrastructure.");
        end else begin
          `uvm_info("build_phase", "Applying the DCE virtual interface received through the config db to the configuration.", UVM_HIGH);
          dce_cfg.set_uart_if(dce_vif);
        end
      end else begin 
        if (dce_cfg.uart_if == null) begin
          `uvm_fatal("build_phase", "A DCE virtual interface was not received either through the config db, or through the configuration object for the master.");
          build_ok = 0;
        end
      end // else: !if(uvm_config_db#(svt_uart_vif)::get(this, "", "dce_vif", dce_vif))
    end // else: !if(!uvm_config_db#(cust_svt_uart_agent_configuration)::get(this, "", "dce_cfg", this.dce_cfg) ||...
    
    if (build_ok) begin
      /** Apply the configuration to the agents */
      uvm_config_db#(svt_uart_agent_configuration)::set(this, "dte_agent", "cfg", dte_cfg);
      uvm_config_db#(svt_uart_agent_configuration)::set(this, "dce_agent", "cfg", dce_cfg);
      
      /** Construct the agents */
      dte_agent = svt_uart_agent::type_id::create("dte_agent",this);
      dce_agent = svt_uart_agent::type_id::create("dce_agent",this);
      
      /** Construct the virtual sequencer */
      sequencer = uart_virtual_sequencer::type_id::create("sequencer", this);
      
      uvm_config_db#(time)::set(null,"global_timer.*","timeout",`SVT_UART_GLOBAL_TIMEOUT);
    end // if (build_ok)
    `uvm_info("build_phase", "uart_basic_env BUILD-FLOW: Finishing...",UVM_LOW)
  endfunction: build_phase
  
  /** 
   * Connect phase connects the DTE and DCE agent's sequencer handle to the virtual
   * sequencer's handle
   */ 
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    
    /** Connect the agent's sequencer handle to the virtual sequencer's handle */
    sequencer.dce_sequencer = dce_agent.sequencer ;
    sequencer.dte_sequencer = dte_agent.sequencer ;
  endfunction : connect_phase
   
endclass : uart_basic_env
`endif //  `ifndef GUARD_UART_BASIC_ENV_SV


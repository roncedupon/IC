//-----------------------------------------------------------------------

`ifndef GUARD_SPI_BASIC_ENV_SV
`define GUARD_SPI_BASIC_ENV_SV 
`define SVT_SPI_GLOBAL_TIMEOUT 100ms
`define SPI_GLOBAL_DRAINTIME 10us

`include "spi_virtual_sequencer.sv"
`include "spi_monitor_scoreboard.sv"
/**
 * Abstract: 
 * class 'spi_basic_env' is extended from uvm_env base class.  It implements 
 * the build phase to construct the structural elements of this environment. 
 * 
 * spi_basic_env is the testbench environment, which constructs SPI MASTER 
 * and SLAVE agents in the build_phase method using the UVM factory service.  
 *
 * spi_basic env also constructs the virtual sequencer. This virtual sequencer 
 * in the testbench environment obtains a handle to the reset interface using 
 * the config db.  This allows reset sequences to be written for this virtual 
 * sequencer.
 * 
 * In the connect_phase it connects MASTER and SLAVE agent’s sequencer handle to 
 * virtual sequencer handle.
 */
class spi_basic_env extends uvm_env ;
   
  /** Declare customized system configuration for active master agent */
  cust_svt_spi_agent_configuration master_cfg;

  /** Declare customized system configuration for active slave agent */
  cust_svt_spi_agent_configuration slave_cfg;

  /** Declare customized system configuration for master monitor agent */
  cust_svt_spi_agent_configuration master_mon_cfg;

  /** Declare customized system configuration for slave monitor agent */
  cust_svt_spi_agent_configuration slave_mon_cfg;
  
  /** Declare Active MASTER agent */
  svt_spi_agent master_agent;

  /** Declare MASTER Monitor agent */
  svt_spi_agent master_mon;

  /** Declare Active SLAVE agent */
  svt_spi_agent slave_agent;

  /** Declare Slave Monitor agent */
  svt_spi_agent slave_mon;
  
  /** Declare SV Interface for MASTER */
  svt_spi_vif        master_vif;
  /** Declare SV Interface for SLAVE */
  svt_spi_vif        slave_vif;
  
  /** Declare the handle of the Virtual Sequencer */
  spi_virtual_sequencer sequencer;
  
  /** Declare the handle of the Scoreboard */
  spi_monitor_scoreboard spi_scbd;

  /** Handle for doing back-door access to master memory*/  
  svt_mem_backdoor master_mem_backdoor;

  /** Handle for doing back-door access to slave memory*/  
  svt_mem_backdoor slave_mem_backdoor;

  /** UVM object utility macro */
  `uvm_component_utils(spi_basic_env)
    
  /** Class constructor */
  function new( string  name = "spi_basic_env", uvm_component parent = null);
    super.new(name, parent);
  endfunction : new 
   
  /** Build Phase for the environment.  */
  virtual function void build_phase(uvm_phase phase) ;
    int build_ok = 1;
    
    `uvm_info("build_phase", "spi_basic_env BUILD-FLOW: Starting...",UVM_LOW)
	
    super.build_phase(phase);

    /** Get the MASTER configuration using config_db */
    if (!uvm_config_db#(cust_svt_spi_agent_configuration)::get(this,"","master_cfg",this.master_cfg) || (this.master_cfg == null)) begin
      `uvm_fatal("build_phase", "'master_cfg' is null. A cust_svt_spi_agent_configuration object must be set using the UVM configuration infrastructure.");
    end
    else begin
      /** Get the MASTER BFM Port Interface */
      if (uvm_config_db#(svt_spi_vif)::get(this, "", "master_vif", master_vif)) begin
        if(master_vif == null) begin
          `uvm_fatal("build_phase", "'master_vif' is null. A svt_spi_if interface must be set using the UVM configuration infrastructure.");
        end else begin
          `uvm_info("build_phase", "Applying the MASTER virtual interface received through the config db to the configuration.", UVM_HIGH);
          master_cfg.spi_if = master_vif;
        end
      end else begin 
        if (master_cfg.spi_if == null) begin
          `uvm_fatal("build_phase", "A MASTER virtual interface was not received either through the config db, or through the configuration object for the master.");
          build_ok = 0;
        end
      end // else: !if(uvm_config_db#(svt_spi_vif)::get(this, "", "master_vif", master_vif))
    end // else: !if(!uvm_config_db#(cust_svt_spi_agent_configuration)::get(this, "", "master_cfg", this.master_cfg) ||...
   
    /** Get the SLAVE configuration using config_db */
    if (!uvm_config_db#(cust_svt_spi_agent_configuration)::get(this,"","slave_cfg",this.slave_cfg) || (this.slave_cfg == null)) begin
      `uvm_fatal("build_phase", "'slave_cfg' is null. A cust_svt_spi_agent_configuration object must be set using the UVM configuration infrastructure.");
    end
    else begin
      /** Get the SLAVE BFM Port Interface */
      if (uvm_config_db#(svt_spi_vif)::get(this, "", "slave_vif", slave_vif)) begin
        if(slave_vif == null) begin
        `uvm_fatal("build_phase", "'slave_vif' is null. A svt_spi_if interface must be set using the UVM configuration infrastructure.");
        end else begin
          `uvm_info("build_phase", "Applying the SLAVE virtual interface received through the config db to the configuration.", UVM_HIGH);
          slave_cfg.spi_if  = slave_vif;
        end
      end else begin 
        if (slave_cfg.spi_if == null) begin
          `uvm_fatal("build_phase", "A SLAVE virtual interface was not received either through the config db, or through the configuration object for the master.");
          build_ok = 0;
        end
      end // else: !if(uvm_config_db#(svt_spi_vif)::get(this, "", "slave_vif", slave_vif))
    end // else: !if(!uvm_config_db#(cust_svt_spi_agent_configuration)::get(this, "", "slave_cfg", this.slave_cfg) ||...

`ifdef SVT_SPI_ENABLE_PASSIVE_MONITOR
    /** Get the MASTER Passive Monitor configuration using config_db */
    if (!uvm_config_db#(cust_svt_spi_agent_configuration)::get(this,"","master_mon_cfg",this.master_mon_cfg) || (this.master_mon_cfg == null)) begin
      `uvm_fatal("build_phase", "'master_mon_cfg' is null. A cust_svt_spi_agent_configuration object must be set using the UVM configuration infrastructure.");
    end
    else begin
      /** Get the MASTER BFM Port Interface */
      if (uvm_config_db#(svt_spi_vif)::get(this, "", "master_vif", master_vif)) begin
        if(master_vif == null) begin
          `uvm_fatal("build_phase", "'master_vif' is null. A svt_spi_if interface must be set using the UVM configuration infrastructure.");
        end else begin
          `uvm_info("build_phase", "Applying the MASTER virtual interface received through the config db to the configuration.", UVM_HIGH);
          master_mon_cfg.spi_if = master_vif;
        end
      end else begin 
        if (master_mon_cfg.spi_if == null) begin
          `uvm_fatal("build_phase", "A MASTER virtual interface was not received either through the config db, or through the configuration object for the master.");
          build_ok = 0;
        end
      end // else: !if(uvm_config_db#(svt_spi_vif)::get(this, "", "master_vif", master_vif))
    end // else: !if(!uvm_config_db#(cust_svt_spi_agent_configuration)::get(this, "", "master_mon_cfg", this.master_mon_cfg) ||...
   
    /** Get the SLAVE Passive Monitor configuration using config_db */
    if (!uvm_config_db#(cust_svt_spi_agent_configuration)::get(this,"","slave_mon_cfg",this.slave_mon_cfg) || (this.slave_mon_cfg == null)) begin
      `uvm_fatal("build_phase", "'slave_mon_cfg' is null. A cust_svt_spi_agent_configuration object must be set using the UVM configuration infrastructure.");
    end
    else begin
      /** Get the SLAVE BFM Port Interface */
      if (uvm_config_db#(svt_spi_vif)::get(this, "", "slave_vif", slave_vif)) begin
        if(slave_vif == null) begin
        `uvm_fatal("build_phase", "'slave_vif' is null. A svt_spi_if interface must be set using the UVM configuration infrastructure.");
        end else begin
          `uvm_info("build_phase", "Applying the SLAVE virtual interface received through the config db to the configuration.", UVM_HIGH);
          slave_mon_cfg.spi_if  = slave_vif;
        end
      end else begin 
        if (slave_mon_cfg.spi_if == null) begin
          `uvm_fatal("build_phase", "A SLAVE virtual interface was not received either through the config db, or through the configuration object for the master.");
          build_ok = 0;
        end
      end // else: !if(uvm_config_db#(svt_spi_vif)::get(this, "", "slave_vif", slave_vif))
    end // else: !if(!uvm_config_db#(cust_svt_spi_agent_configuration)::get(this, "", "slave_mon_cfg", this.slave_mon_cfg) ||...
`endif

    if (build_ok) begin
      /** Apply the configuration to the agents */
      uvm_config_db#(svt_spi_agent_configuration)::set(this, "master_agent", "cfg", master_cfg);
      uvm_config_db#(svt_spi_agent_configuration)::set(this, "slave_agent", "cfg", slave_cfg);

      /** Apply the configuration to the scoreboard.*/
      uvm_config_db#(svt_spi_agent_configuration)::set(this, "spi_scbd", "master_cfg", master_cfg);
      uvm_config_db#(svt_spi_agent_configuration)::set(this, "spi_scbd", "slave_cfg", slave_cfg);

`ifdef SVT_SPI_ENABLE_PASSIVE_MONITOR
      uvm_config_db#(svt_spi_agent_configuration)::set(this, "master_mon", "cfg", master_mon_cfg);
      uvm_config_db#(svt_spi_agent_configuration)::set(this, "slave_mon",  "cfg", slave_mon_cfg);
`endif
      
      /** Construct the agents */
      master_agent = svt_spi_agent::type_id::create("master_agent",this);
      slave_agent  = svt_spi_agent::type_id::create("slave_agent",this);

`ifdef SVT_SPI_ENABLE_PASSIVE_MONITOR
      master_mon = svt_spi_agent::type_id::create("master_mon",this);
      slave_mon = svt_spi_agent::type_id::create("slave_mon",this);
`endif

      /** Construct the virtual sequencer */
      sequencer = spi_virtual_sequencer::type_id::create("sequencer", this);
      
      uvm_config_db#(svt_spi_agent_configuration)::set(this, "sequencer", "cfg", master_cfg);

      /** Construct & enable the Scoreboard*/
      if (this.master_cfg.enable_monitor && this.slave_cfg.enable_monitor) begin
        spi_scbd = spi_monitor_scoreboard::type_id::create("spi_scbd", this);
        spi_scbd.set_scbd_enable(1'b1);
      end 

      uvm_config_db#(time)::set(null,"global_timer.*","timeout",`SVT_SPI_GLOBAL_TIMEOUT);
    end // if (build_ok)
    `uvm_info("build_phase", "spi_basic_env BUILD-FLOW: Finishing...",UVM_LOW)
  endfunction: build_phase
  
  /** 
   * Connect phase connects the MASTER and SLAVE agent's sequencer handle to the virtual
   * sequencer's handle
   */ 
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    if (master_cfg.enable_mem_core && slave_cfg.enable_mem_core) begin 
      /** Connect the scoreboard master/slave mem_backdoor handle to respective mem_cores.*/ 
      spi_scbd.master_mem_backdoor = master_agent.mem_sequencer.get_backdoor(); 
      spi_scbd.slave_mem_backdoor  = slave_agent.mem_sequencer.get_backdoor();
    end  

    /** Connect the agent's sequencer handle to the virtual sequencer's handle */
    sequencer.slave_sequencer  = slave_agent.transaction_seqr  ;
    sequencer.master_sequencer = master_agent.transaction_seqr ;
    if (this.master_cfg.enable_monitor && this.slave_cfg.enable_monitor) begin
`ifdef SVT_SPI_ENABLE_PASSIVE_MONITOR
      master_mon.txrx_mon.tx_xact_observed_port.connect(spi_scbd.item_collected_master_tx);
      slave_mon.txrx_mon.rx_xact_observed_port.connect(spi_scbd.item_collected_slave_rx);
      master_mon.txrx_mon.rx_xact_observed_port.connect(spi_scbd.item_collected_master_rx);
      slave_mon.txrx_mon.tx_xact_observed_port.connect(spi_scbd.item_collected_slave_tx);
`else      
      master_agent.txrx_mon.tx_xact_observed_port.connect(spi_scbd.item_collected_master_tx);
      slave_agent.txrx_mon.rx_xact_observed_port.connect(spi_scbd.item_collected_slave_rx);
      master_agent.txrx_mon.rx_xact_observed_port.connect(spi_scbd.item_collected_master_rx);
      slave_agent.txrx_mon.tx_xact_observed_port.connect(spi_scbd.item_collected_slave_tx);
`endif      
    end  
  endfunction : connect_phase
   
endclass : spi_basic_env
`endif //  `ifndef GUARD_SPI_BASIC_ENV_SV


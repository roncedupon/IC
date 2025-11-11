
`ifndef GUARD_I2C_BASIC_ENV_SV
`define GUARD_I2C_BASIC_ENV_SV 
`define SVT_I2C_GLOBAL_TIMEOUT   100ms
`define SVT_I2C_GLOBAL_DRAINTIME 10us

`include "i2c_virtual_sequencer.sv"
`include "i2c_scoreboard.sv"

/**
 * Abstract: 
 * class 'i2c_basic_env' is extended from uvm_env base class. It implements
 * the build phase to construct the structural elements of this environment.
 *
 * This example is using 1 Master X 1 Slave configuration.
 *
 * i2c_basic_env is the testbench environment, which constructs the I2C System
 * ENV in the build method using the UVM config db.  The I2C System
 * ENV is the top level component provided by the I2C VIP. The I2C System ENV
 * in turn, instantiates constructs the I2C Master and Slave agents. 
 *
 * i2c_basic env also constructs the virtual sequencer. This virtual sequencer
 * in the testbench environment obtains a handle to the reset interface using
 * the config db.  This allows reset sequences to be written for this virtual
 * sequencer.
 */
class i2c_basic_env extends uvm_env ;

  /** I2C System ENV */
  svt_i2c_system_env i2c_system_env;

  /** I2C System Configuration for i2c_system_env */
  cust_svt_i2c_system_configuration i2c_system_cfg;

  /** Virtual Sequencer */
  i2c_virtual_sequencer sequencer;

  /** SV Interfaces for i2c_system_env */
  svt_i2c_vif vif ;

  /** I2C sample scoreboard */
  i2c_scoreboard sb;

  /** UVM Component Utility macro */
  `uvm_component_utils(i2c_basic_env)
  
  /** Class constructor */
  function new(string name = "i2c_basic_env", uvm_component parent = null);
    super.new(name, parent);
  endfunction : new   

  /** Build Phase for the environment */
  virtual function void build_phase(uvm_phase phase);
    int build_ok = 1;
   
    `uvm_info("build_phase", "i2c_basic_env BUILD-FLOW: Starting...",UVM_LOW)
  
    super.build_phase(phase);
     
    /** Create the testbench object for scoreboard */
    sb = i2c_scoreboard::type_id::create("sb", this);
  
    /** Get the Master configuration using config_db */
    if (!uvm_config_db#(cust_svt_i2c_system_configuration)::get(this,"","i2c_system_cfg",i2c_system_cfg) || (i2c_system_cfg == null)) begin
      `uvm_fatal("build_phase", "'i2c_system_cfg' is null. A cust_svt_i2c_system_configuration object must be set using the UVM configuration infrastructure.");
    end
    else begin
      `uvm_info("build_phase",$sformatf("***************System Configuration**************\n%0s", i2c_system_cfg.sprint()), UVM_LOW);

      /** Get the Master Interface from factory */
      if (uvm_config_db#(svt_i2c_vif)::get(this, "", "vif", vif)) begin
        `uvm_info("build_phase", "Applying the Master virtual interface received through the config db to the configuration.", UVM_HIGH);
        i2c_system_cfg.set_if(vif);
      end 
      else begin 
        if (i2c_system_cfg.i2c_if == null) begin
          `uvm_fatal("build_phase", "Virtual interface was not received either through the config db, or through the configuration object for the master.");
          build_ok = 0;
        end
      end // else: !if(uvm_config_db#(svt_i2c_vif)::get(this, "", "vif", vif))
    end // else: !if(!uvm_config_db#(cust_svt_i2c_system_configuration)::get(this,"","i2c_system_cfg", i2c_system_cfg) ||...
  
    if (build_ok) begin
      /** Apply the configuration to the agents */
      uvm_config_db#(svt_i2c_system_configuration)::set(this, "i2c_system_env", "cfg", i2c_system_cfg);
     
      /** Construct the agents */
      i2c_system_env = svt_i2c_system_env::type_id::create("i2c_system_env", this);
 
      /** Construct the virtual sequencer */
      sequencer = i2c_virtual_sequencer::type_id::create("sequencer", this);

      sb.set_i2c_config(i2c_system_cfg.master_cfg[0]);

      uvm_config_db#(time)::set(null,"global_timer.*","timeout",`SVT_I2C_GLOBAL_TIMEOUT);
    end // if (build_ok)
  
    `uvm_info("build_phase", "i2c_basic_env BUILD-FLOW: Finishing...",UVM_LOW)
  endfunction : build_phase
   
  /** Connect Phase for the environment */
  function void connect_phase(uvm_phase phase);
    `uvm_info("connect_phase", "i2c_basic_env CONNECT-FLOW: Starting...",UVM_LOW)

    super.connect_phase(phase);

    sequencer.master_sequencer = i2c_system_env.sequencer.master_sequencer[0];
    sequencer.slave_sequencer  = i2c_system_env.sequencer.slave_sequencer[0];

    i2c_system_env.master[0].monitor.xact_observed_port.connect(sb.item_collected_master);
    i2c_system_env.slave[0].monitor.xact_observed_port.connect(sb.item_collected_slave);

    i2c_system_env.master[0].driver.pre_observed_port.connect(sb.item_collected_master_pre);
    i2c_system_env.slave[0].driver.pre_observed_port.connect(sb.item_collected_slave_pre);

    i2c_system_env.master[0].monitor.data_observed_port.connect(sb.item_collected_master_data);
    i2c_system_env.slave[0].monitor.data_observed_port.connect(sb.item_collected_slave_data);
     
    `uvm_info("connect_phase", "i2c_basic_env CONNECT-FLOW: Finishing...",UVM_LOW)
  endfunction : connect_phase

endclass : i2c_basic_env
`endif //  `ifndef GUARD_I2C_BASIC_ENV_SV

//------------------------------------------------------------------------
//-----------------------END OF FILE--------------------------------------
//------------------------------------------------------------------------


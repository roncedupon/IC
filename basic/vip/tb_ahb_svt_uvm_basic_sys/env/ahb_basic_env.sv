
/**
 * Abstract: 
 * class 'ahb_basic_env' is extended from uvm_env base class.  It implements
 * the build phase to construct the structural elements of this environment.
 *
 * ahb_basic_env is the testbench environment, which constructs the AHB System
 * ENV in the build_phase method using the UVM factory service.  The AHB System
 * ENV  is the top level component provided by the AHB VIP. The AHB System ENV
 * in turn, instantiates constructs the AHB Master and Slave agents. 
 *
 * ahb_basic env also constructs the virtual sequencer. This virtual sequencer
 * in the testbench environment obtains a handle to the reset interface using
 * the config db.  This allows reset sequences to be written for this virtual
 * sequencer.
 *
 * The simulation ends after all the objections are dropped.  This is done by
 * using objections provided by phase arguments.
 */
`ifndef GUARD_AHB_BASIC_ENV_SV
`define GUARD_AHB_BASIC_ENV_SV

`include "amba_pv_master.sv"
`include "ahb_virtual_sequencer.sv"
`include "cust_svt_ahb_system_configuration.sv"

class ahb_basic_env extends uvm_env;

  /** AHB System ENV */
  svt_ahb_system_env   ahb_system_env;

  /** Virtual Sequencer */
  ahb_virtual_sequencer sequencer;

  /** AMBA-PV master(s) */
  amba_pv_master pv_master[];

  /** AHB System Configuration */
  cust_svt_ahb_system_configuration cfg;

  /** UVM Component Utility macro */
  `uvm_component_utils(ahb_basic_env)

  /** Class Constructor */
  function new (string name="ahb_basic_env", uvm_component parent=null);
    super.new (name, parent);
  endfunction

  /** Build the AHB System ENV */
  virtual function void build_phase(uvm_phase phase);
    `uvm_info("build_phase", "Entered...",UVM_LOW)

    super.build_phase(phase);

    /**
     * Check if the configuration is passed to the environment.
     * If not then create the configuration and pass it to the agent.
     */
    if (!uvm_config_db#(cust_svt_ahb_system_configuration)::get(this, "", "cfg", cfg)) begin
      cfg = cust_svt_ahb_system_configuration::type_id::create("cfg");
    end

    /** Apply the configuration to the System ENV */
    uvm_config_db#(svt_ahb_system_configuration)::set(this, "ahb_system_env", "cfg", cfg);

    /** Construct the system agent */
    ahb_system_env = svt_ahb_system_env::type_id::create("ahb_system_env", this);

    /** Construct the virtual sequencer */
    sequencer = ahb_virtual_sequencer::type_id::create("sequencer", this);

    /** Construct the needed AMBA-PV masters */
    pv_master = new [cfg.master_cfg.size()];
    foreach (cfg.master_cfg[i]) begin
      if (cfg.master_cfg[i].use_pv_socket)
        pv_master[i] = amba_pv_master::type_id::create($sformatf("amba_pv[%0d]", i), this);
    end

    `uvm_info("build_phase", "Exiting...", UVM_LOW)
  endfunction

  /** Connect additional components to the AHB System ENV */
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    foreach (pv_master[i]) begin
      if (pv_master[i] != null) begin
        pv_master[i].b_fwd.connect(ahb_system_env.master[i].b_fwd);
      end
    end
  endfunction
endclass

`endif // GUARD_AHB_BASIC_ENV_SV

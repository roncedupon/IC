
`include "uart_base_test.sv"
`include "uart_reconfig_sequence.sv"

/**
 * Abstract:
 * This file creates the 'reconfig_test', which is extended from uart_base_test
 * A simple directed test showcases the use of the reconfig sequence.
 * 
 * In the build phase of the test set the necessary test related information:
 * 
 * - Disable the virtual sequencer of TB ENV by assigning the null sequence
 * - Configure the uart_reconfig_sequence as the default sequence for  
 *   the main phase of the DTE/DCE agent Sequencer
 */

class reconfig_test extends uart_base_test;

  uart_reconfig_sequence dte_seq, dce_seq;
  uart_reconfig_sequence dte_seq_r, dce_seq_r;
  
  svt_configuration cfg1, cfg2;
  svt_uart_configuration cfg_dte, cfg_dce;

  /** UVM component utility macro */
  `uvm_component_utils(reconfig_test)

  /** Class constructor */
  function new(string name = "reconfig_test", uvm_component parent=null);
    super.new(name,parent);
  endfunction : new

  /** build() - Method to build various component */
  virtual function void build_phase(uvm_phase phase);
    `uvm_info("build_phase", "Entered ...", UVM_LOW)

    super.build_phase(phase);
  
    /** Set the configuration values of baud rat divisor for DTE */
    dte_cfg.baud_divisor = 1;

    /** Set the configuration values of baud rat divisor for DCE */
    dce_cfg.baud_divisor = 1;

    /** Set the configuration values of number of stop bits inside packets from DTE */
    dte_cfg.stop_bit = svt_uart_agent_configuration::ONE_BIT;

    /** Set the configuration values of number of stop bits inside packets from DCE */
    dce_cfg.stop_bit = svt_uart_agent_configuration::ONE_BIT;
    dte_cfg.parity_type = svt_uart_agent_configuration::NO_PARITY;
    dce_cfg.parity_type = svt_uart_agent_configuration::NO_PARITY;
    dte_cfg.receiver_buffer_size=4;
    dce_cfg.receiver_buffer_size=4;

    /** Disable the virtual default sequence on the the virtual sequencer started in the uart_base_test */
    uvm_config_db#(uvm_object_wrapper)::set(this, "env.sequencer.main_phase", "default_sequence", uart_null_virtual_sequence::type_id::get());

    `uvm_info("build_phase", "Exited ...", UVM_LOW)
  endfunction : build_phase

  /** The drain time is set up for the main phase, as 
    * the stimulus is set for the main_phase. 
    * The value of drain time is set such as to ensure that all the  
    * transmitted packets are successfully received at the Receiver.
    * The timeunit must be ensured to be in units of 
    * nanoseconds(ns).
    */
  task main_phase(uvm_phase phase);
    uvm_objection phase_over;
    `uvm_info("main_phase", "Entered ...",UVM_LOW)

    /** seq object creation */
    dte_seq = uart_reconfig_sequence::type_id::create("dte_seq");
    dce_seq = uart_reconfig_sequence::type_id::create("dce_seq");
    dte_seq_r = uart_reconfig_sequence::type_id::create("dte_seq_r");
    dce_seq_r = uart_reconfig_sequence::type_id::create("dce_seq_r");
    
    /** Raise Objection */
    phase.raise_objection(this);
    
    /** Sequence start() call */
    dte_seq.start(env.dte_agent.sequencer);
    dce_seq.start(env.dce_agent.sequencer);

    #20000;
    env.dte_agent.sequencer.get_cfg(cfg1);
    env.dte_agent.sequencer.get_cfg(cfg2);

    /** Cast the SVT configuration handle on the I2C configuration handle */
    if (!$cast(cfg_dte, cfg1)) begin
      `svt_xvm_fatal("body", "Unable to cast the configuration to a svt_i2c_configuration class");
    end

    if (!$cast(cfg_dce, cfg2)) begin
      `svt_xvm_fatal("body", "Unable to cast the configuration to a svt_i2c_configuration class");
    end

    /** reconfigure the configuration values of baud rate divisor for DTE */
    cfg_dte.baud_divisor = 2;

    /** reconfigure the configuration values of baud rate divisor for DCE */
    cfg_dce.baud_divisor = 2;

    /** reconfigure the value of enable baudout pin for DTE */
    cfg_dte.enable_drive_baudout_pin= 1;

    /** reconfigure the value of enable baudout pin for DCE */
    cfg_dce.enable_drive_baudout_pin= 1;

    /** Set the configuration values of number of stop bits inside packets from DTE */
    cfg_dte.stop_bit = svt_uart_agent_configuration::ONE_FIVE_BIT;

    /** Set the configuration values of number of stop bits inside packets from DCE */
    cfg_dce.stop_bit = svt_uart_agent_configuration::ONE_FIVE_BIT;
    cfg_dce.parity_type = svt_uart_agent_configuration::STICK_HIGH_PARITY;
    cfg_dte.parity_type = svt_uart_agent_configuration::STICK_HIGH_PARITY;

    cfg_dce.data_width = svt_uart_agent_configuration::TWELVE_BIT;
    cfg_dte.data_width = svt_uart_agent_configuration::TWELVE_BIT;
 
    /** Call to reconfigure_via _task() to reconfigure DTE and DCE agents */
    env.dte_agent.reconfigure_via_task(cfg_dte);  
    env.dce_agent.reconfigure_via_task(cfg_dce);  

    /** Sequence start() call */
    dte_seq_r.start(env.dte_agent.sequencer);
    dce_seq_r.start(env.dce_agent.sequencer);

    #20000;
    env.dte_agent.sequencer.get_cfg(cfg1);
    env.dte_agent.sequencer.get_cfg(cfg2);

    /** Cast the SVT configuration handle on the I2C configuration handle */
    if (!$cast(cfg_dte, cfg1)) begin
      `svt_xvm_fatal("body", "Unable to cast the configuration to a svt_i2c_configuration class");
    end

    if (!$cast(cfg_dce, cfg2)) begin
      `svt_xvm_fatal("body", "Unable to cast the configuration to a svt_i2c_configuration class");
    end

    /** reconfigure the configuration values of baud rate divisor for DTE */
    cfg_dte.baud_divisor = 3;

    /** reconfigure the configuration values of baud rate divisor for DCE */
    cfg_dce.baud_divisor = 3;

    /** reconfigure the value of enable baudout pin for DTE */
    cfg_dte.enable_drive_baudout_pin= 1;

    /** reconfigure the value of enable baudout pin for DCE */
    cfg_dce.enable_drive_baudout_pin= 1;

    /** Set the configuration values of number of stop bits inside packets from DTE */
    cfg_dte.stop_bit = svt_uart_agent_configuration::TWO_BIT;

    /** Set the configuration values of number of stop bits inside packets from DCE */
    cfg_dce.stop_bit = svt_uart_agent_configuration::TWO_BIT;
    cfg_dce.parity_type = svt_uart_agent_configuration::EVEN_PARITY;
    cfg_dte.parity_type = svt_uart_agent_configuration::EVEN_PARITY;
 
    cfg_dce.data_width = svt_uart_agent_configuration::SIX_BIT;
    cfg_dte.data_width = svt_uart_agent_configuration::SIX_BIT;
 
    /** Call to reconfigure_via _task() to reconfigure DTE and DCE agents */
    env.dte_agent.reconfigure_via_task(cfg_dte);  
    env.dce_agent.reconfigure_via_task(cfg_dce);  

    /** Sequence start() call */
    dte_seq_r.start(env.dte_agent.sequencer);
    dce_seq_r.start(env.dce_agent.sequencer);

    /** Drop Objection */
    phase.drop_objection(this);

    `uvm_info("main_phase", $sformatf("Setting the drain time in the main_phase of the base test to 600000"), UVM_NONE) 
    phase_over = phase.get_objection();
    phase_over.set_drain_time(this, (6000000));
    `uvm_info("main_phase", "Exited ...",UVM_LOW)
  endtask

endclass : reconfig_test

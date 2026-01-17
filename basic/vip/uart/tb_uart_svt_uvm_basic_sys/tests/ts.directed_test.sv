`include "uart_base_test.sv"
`include "uart_directed_sequence.sv"

/**
 * Abstract:
 * This file creates the 'directed_test', which is extended from uart_base_test
 * A simple directed test showcases the use of the directed sequence.
 * 
 * In the build phase of the test set the necessary test related information:
 * 
 * - Disable the virtual sequencer of TB ENV by assigning the null sequence
 * - Configure the uart_directed_sequence as the default sequence for  
 *   the main phase of the DTE/DCE agent Sequencer
 */

class directed_test extends uart_base_test;
  svt_uart_configuration    uart2_cfg;
  /** UVM component utility macro */
  `uvm_component_utils(directed_test)

  /** Class constructor */
  function new(string name = "directed_test", uvm_component parent=null);
    super.new(name,parent);
  endfunction : new

  /** build() - Method to build various component */
  virtual function void build_phase(uvm_phase phase);
    `uvm_info("build_phase", "Entered ...", UVM_LOW)

    super.build_phase(phase);
    uart2_cfg= svt_uart_configuration::type_id::create("uart2_cfg");
    uart2_cfg.parity_type = svt_uart_configuration::NO_PARITY;       //ODND_PARITY check
    uart2_cfg.baud_divisor =  156;//9600
    uart2_cfg.handshake_type =  svt_uart_configuration::SOFTWARE;          
    uart2_cfg.stop_bit =  svt_uart_configuration::ONE_BIT;
    uart2_cfg.enable_dtr_dsr_handshake = 1'b0;    
    uart2_cfg.enable_rts_cts_handshake = 1'b0;
    uart2_cfg.enable_tx_rx_handshake = 1'b1;
    uart2_cfg.data_pattern_xon = 'h48;    
    uart2_cfg.data_width =  svt_uart_configuration::EIGHT_BIT;    
    uart2_cfg.reasonable_receiver_buffer_size.constraint_mode(0);    
    uart2_cfg.receiver_buffer_size = 1024;    
    uvm_config_db#(svt_uart_configuration)::set(this,"env", "cfg",uart2_cfg);
    /** Disable the virtual default sequence on the the virtual sequencer started in the uart_base_test */
    uvm_config_db#(uvm_object_wrapper)::set(this, "env.sequencer.main_phase", "default_sequence", uart_null_virtual_sequence::type_id::get());

    /** Apply the directed uart sequence to the uart txrx sequencer */
    uvm_config_db#(uvm_object_wrapper)::set(this, "env.dte_agent.sequencer.main_phase", "default_sequence", uart_directed_sequence::type_id::get());

    /** Apply the directed uart sequence to the uart txrx sequencer */
    uvm_config_db#(uvm_object_wrapper)::set(this, "env.dce_agent.sequencer.main_phase", "default_sequence", uart_directed_sequence::type_id::get());

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
	  `uvm_info("main_phase", $sformatf("Setting the drain time in the main_phase of the base test to 600000"), UVM_NONE) 
    phase_over = phase.get_objection();
    phase_over.set_drain_time(this, (6000000));
    `uvm_info("main_phase", "Exited ...",UVM_LOW)
  endtask


endclass : directed_test

//----------------------------------------------------------------------------
//--------------------------END OF FILE---------------------------------------
//----------------------------------------------------------------------------
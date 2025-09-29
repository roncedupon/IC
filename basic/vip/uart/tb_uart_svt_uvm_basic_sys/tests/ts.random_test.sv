
`include "uart_base_test.sv"
`include "uart_random_sequence.sv"

/**
 * Abstract:
 * This file creates test 'random_test', which is extended from the
 * base test class.
 *
 * In the build_phase phase of the test we will set the necessary test related 
 * information:
 *  - Disable the virtual sequence by assigning the null sequence
 *  - Configure the uart_random_sequence as the default sequence for
 *    the main phase of the DTE and DCE agent Sequencer
 *  - Configure the Sequence length to 10
 */

class random_test extends uart_base_test;

  /** UVM component utility macro */
  `uvm_component_utils(random_test)

  /** Class constructor */
  function new(string name = "random_test", uvm_component parent=null);
    super.new(name,parent);
  endfunction : new

  /** build() - Method to build various component */
  virtual function void build_phase(uvm_phase phase);
    `uvm_info("build_phase", "Entered ...", UVM_LOW)

    super.build_phase(phase);
 
    /** Apply Null sequence to the system ENV virtual squencer */
    uvm_config_db#(uvm_object_wrapper)::set(this, "env.sequencer.main_phase", "default_sequence", uart_null_virtual_sequence::type_id::get());

    /** Apply the random uart sequence to the uart DTE agent sequencer */
    uvm_config_db#(uvm_object_wrapper)::set(this, "env.dte_agent.sequencer.main_phase", "default_sequence", uart_random_sequence::type_id::get());

    /** Apply the random uart sequence to the uart DCE agent sequencer */
    uvm_config_db#(uvm_object_wrapper)::set(this, "env.dce_agent.sequencer.main_phase", "default_sequence", uart_random_sequence::type_id::get());

    /** Set the sequence 'length' to generate 10 transactions with random constraints    */
    uvm_config_db#(int unsigned)::set(this, "env.dte_agent.sequencer.uart_random_sequence", "sequence_length", 10);

    /** Set the sequence 'length' to generate 10 transactions with random constraints    */
    uvm_config_db#(int unsigned)::set(this, "env.dce_agent.sequencer.uart_random_sequence", "sequence_length", 10);

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
    `uvm_info("main_phase", $sformatf("Setting the drain time in the main_phase of the base test to 6000000"), UVM_NONE) 
    phase_over = phase.get_objection();
    phase_over.set_drain_time(this, (6000000));
    `uvm_info("main_phase", "Exited ...",UVM_LOW)
  endtask


endclass

//----------------------------------------------------------------------------
//--------------------------END OF FILE---------------------------------------
//----------------------------------------------------------------------------

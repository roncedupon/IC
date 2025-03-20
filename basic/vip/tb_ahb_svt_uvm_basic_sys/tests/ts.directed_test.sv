
`include "ahb_base_test.sv"
`include "ahb_null_virtual_sequence.sv"
`include "ahb_master_directed_sequence.sv"

/**
 * Abstract:
 * This file creates test 'directed_test', which is extended from the
 * base test class.
 * 
 * In the build phase of the test we will set the necessary test related
 * information:
 *  - Disable the virtual sequence by assigning the null sequence
 *  - Configure the ahb_master_directed_sequence as the default sequence for
 *    the main phase of the Master Sequencer
 *  .
 */
class directed_test extends ahb_base_test;

  // Need to declare this property because some third-party simulators can't seem to
  // find enums defined in a class scope unless that class is declared somewhere in
  // that file or an included file.
  svt_ahb_transaction base_xact;  

  /** UVM Component Utility macro */
  `uvm_component_utils (directed_test)

  /** Class Constructor */
  function new (string name="directed_test", uvm_component parent=null);
    super.new (name, parent);
  endfunction: new

  virtual function void build_phase(uvm_phase phase);
    `uvm_info ("build_phase", "Entered...",UVM_LOW)

    super.build_phase(phase);

    /**
     * Apply the null sequence to the System ENV virtual sequencer to override the
     * default sequence.
     */
    uvm_config_db#(uvm_object_wrapper)::set(this, "env.ahb_system_env.sequencer.main_phase", "default_sequence", ahb_null_virtual_sequence::type_id::get());

    /** Apply the directed master sequence to the master sequencer */
    uvm_config_db#(uvm_object_wrapper)::set(this, "env.ahb_system_env.master*.sequencer.main_phase", "default_sequence", ahb_master_directed_sequence::type_id::get());

    /** Set the sequence 'length' to generate 50 directed transactions */
    uvm_config_db#(int unsigned)::set(this, "env.ahb_system_env.master*.sequencer.ahb_master_directed_sequence", "sequence_length", 50);

    `uvm_info ("build_phase", "Exiting...",UVM_LOW)
  endfunction: build_phase
  
endclass

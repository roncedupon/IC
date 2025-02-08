
/**
 * Abstract:
 * class ahb_master_random_discrete_sequence defines a sequence that generates a
 * random discrete master transaction.  This sequence is used by the
 * ahb_master_random_discrete_virtual_sequence which is set up as the default
 * sequence for this environment.
 *
 * Execution phase: main_phase
 * Sequencer: Virtual sequencer in AHB System ENV
 */

`ifndef GUARD_AHB_MASTER_RANDOM_DISCRETE_SEQUENCE_SV
`define GUARD_AHB_MASTER_RANDOM_DISCRETE_SEQUENCE_SV

//------------------------------------------------------------------------------
//
// CLASS: ahb_master_random_discrete_sequence 
//
//------------------------------------------------------------------------------

class ahb_master_random_discrete_sequence extends svt_ahb_master_transaction_base_sequence;

   /** Parameter that controls the number of transactions that will be generated */
   rand int unsigned sequence_length = 10;

  /** UVM Object Utility macro */
  `uvm_object_utils(ahb_master_random_discrete_sequence)

  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length <= 100;
  }

  /** Class Constructor */
  function new (string name = "ahb_master_random_discrete_sequence");
     super.new(name);
  endfunction : new

  virtual task body();
    bit status;

    `uvm_info("body", "Entered ...", UVM_LOW)

    status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "sequence_length", sequence_length);
    `uvm_info("body", $sformatf("sequence_length is %0d as a result of %0s.", sequence_length, status ? "config DB" : "randomization"), UVM_LOW);

    for(int i = 0; i < sequence_length; i++) begin
      `uvm_info("body", $sformatf("Calling `uvm_do, iteration=%0d", i), UVM_LOW)
      `uvm_do(req)
    end

    `uvm_info("body", "Exiting...", UVM_LOW)
  endtask: body
  
endclass: ahb_master_random_discrete_sequence

`endif // GUARD_AHB_MASTER_RANDOM_DISCRETE_SEQUENCE_SV

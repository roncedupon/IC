//=======================================================================
// COPYRIGHT (C) 2010, 2011, 2012, 2013 SYNOPSYS INC.
// This software and the associated documentation are confidential and
// proprietary to Synopsys, Inc. Your use or disclosure of this software
// is subject to the terms and conditions of a written license agreement
// between you, or your company, and Synopsys, Inc. In the event of
// publications, the following notice is applicable:
//
// ALL RIGHTS RESERVED
//
// The entire notice above must be reproduced on all authorized copies.
//-----------------------------------------------------------------------

/**
 * Abstract:
 * axi_master_zero_delay_sequence is used by test to provide initiator scenario
 * information to the Master agent present in the System agent.  This class
 * defines a sequence in which a random AX4 STREAM 
 * sequence is generated using `uvm_do_with macros. tvalid is asserted continuously 
 * through out the stream burst. 
 *
 * Execution phase: main_phase
 * Sequencer: Master agent sequencer
 */

`ifndef GUARD_AXI_MASTER_ZERO_DELAY_SEQUENCE_SV
`define GUARD_AXI_MASTER_ZERO_DELAY_SEQUENCE_SV

class axi_master_zero_delay_sequence extends svt_axi_master_base_sequence;

  /** Parameter that controls the number of transactions that will be generated */
  rand int unsigned sequence_length = 10;

  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length <= 100;
  }

  /** UVM Object Utility macro */
  `uvm_object_utils(axi_master_zero_delay_sequence)

  /** Class Constructor */
  function new(string name="axi_master_zero_delay_sequence");
    super.new(name);
  endfunction
  
  virtual task body();
    bit status;
    `uvm_info("body", "Entered ...", UVM_LOW)

    super.body();

    status = uvm_config_db #(int unsigned)::get(null, get_full_name(), "sequence_length", sequence_length);
    `uvm_info("body", $sformatf("sequence_length is %0d as a result of %0s.", sequence_length, status ? "config DB" : "randomization"), UVM_LOW);

    fork
    forever begin
      get_response(rsp);
    end
    join_none
    
    repeat (sequence_length) begin
      `uvm_do_with(req, 
        { 
          xact_type == svt_axi_transaction::DATA_STREAM; 
          foreach (tvalid_delay[i]) 
           tvalid_delay[i]==0; 
        })

    end

    `uvm_info("body", "Exiting...", UVM_LOW)
  endtask: body

endclass: axi_master_zero_delay_sequence

`endif // GUARD_AXI_MASTER_ZERO_DELAY_SEQUENCE_SV

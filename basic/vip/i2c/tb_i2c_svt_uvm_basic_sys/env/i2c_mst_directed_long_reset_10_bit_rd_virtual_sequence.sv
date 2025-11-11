
/**
 * Abstract:
 * The file contains the class extended from uvm_sequence. It is a virtual sequence 
 * that encapsulate the default sequence and tie it to the virtual sequencer. 
 */

`ifndef GUARD_I2C_MST_DIRECTED_LONG_RESET_10_BIT_RD_VIRTUAL_SEQUENCE_SV
`define GUARD_I2C_MST_DIRECTED_LONG_RESET_10_BIT_RD_VIRTUAL_SEQUENCE_SV
class i2c_mst_directed_long_reset_10_bit_rd_virtual_sequence extends uvm_sequence;

  /** Sequence Length in Virtual Sequence, to set to the actual default sequence */
  int unsigned sequence_length = 10;

  /** UVM object utility macro */
  `uvm_object_utils(i2c_mst_directed_long_reset_10_bit_rd_virtual_sequence)

  /** This macro is used to declare a variable p_sequencer whose type is i2c_virtual_sequencer */
    `uvm_declare_p_sequencer(i2c_virtual_sequencer)
//  `uvm_declare_p_sequencer(svt_i2c_system_sequencer)

  /** Class constructor */
  function new (string name = "i2c_mst_directed_long_reset_10_bit_rd_virtual_sequence");
    super.new(name);
  endfunction : new

  /** Raise an objection if this is the parent sequence */
  virtual task pre_body();
    uvm_phase phase;
    super.pre_body();
`ifdef SVT_UVM_12_OR_HIGHER
    phase = get_starting_phase();
`else
    phase = starting_phase;
`endif
    if (phase!=null) begin
      phase.raise_objection(this);
    end
  endtask: pre_body
  
  /** Drop an objection if this is the parent sequence */
  virtual task post_body();
    uvm_phase phase;
    super.post_body();
`ifdef SVT_UVM_12_OR_HIGHER
    phase = get_starting_phase();
`else
    phase = starting_phase;
`endif
    if (phase!=null) begin
      phase.drop_objection(this);
    end
  endtask: post_body
  
  /** Define task body() */
  virtual task body();
    bit status;
    int local_sequence_length = 0;

    /** Instance of default sequence, to be started on the virtual sequencer. */
    i2c_mst_directed_reset_in_ten_bit_rd_sequence mst_seq;

    `uvm_info("body", "Entering...", UVM_DEBUG)

    status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "sequence_length", sequence_length);
    `uvm_info("body", $sformatf("sequence_length is %0d as a result of %0s.", sequence_length, status ? "config DB" : "randomization"), UVM_LOW);

    /**
     * Since the contained sequence and this one have the same property name, the
     * inline constraint was not able to resolve to the correct scope.  Therefore the
     * sequence length of the virtual sequencer is assigned to a local property which
     * is used in the constraint.
     */
    local_sequence_length = 0;//sequence_length;

    fork
       begin
`ifdef SVT_UVM_1800_2_2017_OR_HIGHER
      `uvm_do(mst_seq, p_sequencer.master_sequencer, -1,{mst_seq.sequence_length == local_sequence_length;})
`else
      `uvm_do_on_with(mst_seq, p_sequencer.master_sequencer, {mst_seq.sequence_length == local_sequence_length;})
`endif
       end
       //Block below has been added to toggle the RESET after a specific time
       begin
        #1800000;
        p_sequencer.reset_mp.reset = 1'b1;
        #4300000;
        p_sequencer.reset_mp.reset = 1'b0;
       end
    join

    `uvm_info("body", "Exiting ...", UVM_DEBUG)
  endtask : body

endclass : i2c_mst_directed_long_reset_10_bit_rd_virtual_sequence 

`endif // GUARD_I2C_MST_DIRECTED_LONG_RESET_10_BIT_RD_VIRTUAL_SEQUENCE_SV

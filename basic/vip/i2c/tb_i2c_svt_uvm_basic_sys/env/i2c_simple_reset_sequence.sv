
/**
 * Abstract:
 * class i2c_simple_reset_sequence defines a virtual sequence.
 * 
 * The i2c_simple_reset_sequence drives the reset pin through one
 * activation cycle.
 *
 * The i2c_simple_reset_sequence is configured as the default sequence for the
 * reset_phase of the testbench environment virtual sequencer, in the i2c_base_test.
 *
 * The reset sequence obtains the handle to the reset interface through the
 * virtual sequencer. The reset interface is set in the virtual sequencer using
 * configuration database, in file top.sv.
 *
 */

`ifndef GUARD_I2C_SIMPLE_RESET_SEQUENCE_SV
`define GUARD_I2C_SIMPLE_RESET_SEQUENCE_SV

class i2c_simple_reset_sequence extends uvm_sequence;

  /** UVM Object Utility macro */
  `uvm_object_utils(i2c_simple_reset_sequence)

  /** Declare a typed sequencer object that the sequence can access */
  `uvm_declare_p_sequencer(i2c_virtual_sequencer)

  /** Class Constructor */
  function new (string name = "i2c_simple_reset_sequence");
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
    `uvm_info("body", "Entering...", UVM_LOW)

    p_sequencer.reset_mp.reset <= 1'b0;

    @(posedge p_sequencer.reset_mp.clk);
    p_sequencer.reset_mp.reset <= 1'b1;

    @(posedge p_sequencer.reset_mp.clk);
    p_sequencer.reset_mp.reset <= 1'b0;

    `uvm_info("body", "Exiting...", UVM_LOW)
  endtask: body

endclass: i2c_simple_reset_sequence

`endif // GUARD_I2C_SIMPLE_RESET_SEQUENCE_SV

//------------------------------------------------------------------------
//-----------------------END OF FILE--------------------------------------
//------------------------------------------------------------------------


`ifndef GUARD_SPI_SIMPLE_RESET_SEQUENCE_SV
`define GUARD_SPI_SIMPLE_RESET_SEQUENCE_SV

/**
 * Abstract:
 * class spi_simple_reset_sequence defines a virtual sequence.
 * 
 * The spi_simple_reset_sequence drives the reset pin through one
 * activation cycle.
 *
 * The spi_simple_reset_sequence is configured as the default sequence for the
 * reset_phase of the testbench environment virtual sequencer, in the spi_base_test.
 *
 * The reset sequence obtains the handle to the reset interface through the
 * virtual sequencer. The reset interface is set in the virtual sequencer using
 * configuration database, in file top.sv.
 *
 * Execution phase: run phase 
 * Sequencer: spi_virtual_sequencer in testbench environment
 */
`ifdef SVT_UVM_TECHNOLOGY
  class spi_simple_reset_sequence extends uvm_sequence #(uvm_sequence_item,uvm_sequence_item);
`elsif SVT_OVM_TECHNOLOGY
  class spi_simple_reset_sequence extends ovm_sequence #(ovm_sequence_item,ovm_sequence_item);
`endif  

  /** Object Utility macro */
`ifdef SVT_UVM_TECHNOLOGY
  `uvm_object_utils(spi_simple_reset_sequence)
`elsif SVT_OVM_TECHNOLOGY
  `ovm_object_utils(spi_simple_reset_sequence)
`endif  

  /** Declare a typed sequencer object that the sequence can access */
`ifdef SVT_UVM_TECHNOLOGY
  `uvm_declare_p_sequencer(spi_virtual_sequencer)
`elsif SVT_OVM_TECHNOLOGY
  `ovm_declare_p_sequencer(spi_virtual_sequencer)
`endif  

  /** Class Constructor */
  function new (string name = "spi_simple_reset_sequence");
    super.new(name);
  endfunction : new

`ifdef SVT_UVM_TECHNOLOGY
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
      phase.raise_objection(this,"SPI Reset sequence started");
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
      phase.drop_objection(this,"SPI Reset Sequence finished");
    end  
  endtask: post_body

`elsif SVT_OVM_TECHNOLOGY
  /** Raise an objection.*/
  virtual task pre_body();
    `ovm_info("pre_body","Entered...", OVM_LOW)
    super.pre_body();
    ovm_test_done.raise_objection(this);
    `ovm_info("pre_body","Exiting...", OVM_LOW)
  endtask

  /** Drop an objection.*/
  virtual task post_body();
    `ovm_info("post_body","Entered...", OVM_LOW)
    super.post_body();
    ovm_test_done.drop_objection(this);
    `ovm_info("post_body","Exiting...", OVM_LOW)
  endtask
`endif  
   
  /** Body of Sequence */
  virtual task body();
`ifdef SVT_UVM_TECHNOLOGY
    `uvm_info("body", "Entered...", UVM_LOW)
`elsif SVT_OVM_TECHNOLOGY
    `ovm_info("body", "Entered...", OVM_LOW)
`endif  
   if (p_sequencer.cfg.reset_polarity == svt_spi_types::ACTIVE_LOW) begin
     p_sequencer.reset_mp.reset <= 1'b1;

     @(posedge p_sequencer.reset_mp.clk);
     p_sequencer.reset_mp.reset <= 1'b0;

     @(posedge p_sequencer.reset_mp.clk);
     p_sequencer.reset_mp.reset <= 1'b1;
     repeat (10) @(posedge p_sequencer.reset_mp.clk);
   end 
   else begin
     p_sequencer.reset_mp.reset <= 1'b0;

     @(posedge p_sequencer.reset_mp.clk);
     p_sequencer.reset_mp.reset <= 1'b1;

     @(posedge p_sequencer.reset_mp.clk);
     p_sequencer.reset_mp.reset <= 1'b0;
     repeat (10) @(posedge p_sequencer.reset_mp.clk);
   end
`ifdef SVT_UVM_TECHNOLOGY
    `uvm_info("body", "Exiting...", UVM_LOW)
`elsif SVT_OVM_TECHNOLOGY
    `ovm_info("body", "Exiting...", OVM_LOW)
`endif  
  endtask: body

endclass: spi_simple_reset_sequence

`endif // GUARD_SPI_SIMPLE_RESET_SEQUENCE_SV


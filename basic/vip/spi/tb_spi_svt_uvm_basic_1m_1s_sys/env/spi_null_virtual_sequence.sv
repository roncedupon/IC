
`ifndef GUARD_SPI_NULL_VIRTUAL_SEQUENCE_SV
`define GUARD_SPI_NULL_VIRTUAL_SEQUENCE_SV

/**
 * Abstract:
 * class spi_null_virtual_sequence defines a virtual sequence spi_null_virtual_sequence.
 * spi_null_virtual_sequence is a no-operation sequence since the body() method
 * has empty implementation.
 *
 * spi_null_virtual_sequence is used by directed_test and random_test.
 * These tests load this null sequence into the virtual sequencer in testbench
 * ENV, as these tests use the sequencer defined in the DTE/DCE agent.
 *
 * Execution phase: run phase 
 * Sequencer: Can be used with any sequencer in
 * which default sequence needs to be overridden with a null sequence. In this
 * example, this sequence has been used with virtual sequencer in the testbench
 * environment.
 */
`ifdef SVT_UVM_TECHNOLOGY
  class spi_null_virtual_sequence extends uvm_sequence #(uvm_sequence_item,uvm_sequence_item);
`elsif SVT_OVM_TECHNOLOGY
  class spi_null_virtual_sequence extends ovm_sequence #(ovm_sequence_item,ovm_sequence_item);
`endif  
  
    /** object utility macro */
`ifdef SVT_UVM_TECHNOLOGY
    `uvm_object_utils(spi_null_virtual_sequence)
`elsif SVT_OVM_TECHNOLOGY
    `ovm_object_utils(spi_null_virtual_sequence)
`endif  
  
    /** Class constructor */
    function new (string name = "spi_null_virtual_sequence");
      super.new(name);
    endfunction : new
  
    /** Need an empty body function to override the warning from the ovm base class */
    virtual task body();
    endtask : body
  
  endclass : spi_null_virtual_sequence 

`endif // GUARD_SPI_NULL_VIRTUAL_SEQUENCE_SV


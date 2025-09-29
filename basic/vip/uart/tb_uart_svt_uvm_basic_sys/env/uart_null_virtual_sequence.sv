
`ifndef GUARD_UART_NULL_VIRTUAL_SEQUENCE_SV
`define GUARD_UART_NULL_VIRTUAL_SEQUENCE_SV

/**
 * Abstract:
 * class uart_null_virtual_sequence defines a virtual sequence uart_null_virtual_sequence.
 * uart_null_virtual_sequence is a no-operation sequence since the body() method
 * has empty implementation.
 *
 * uart_null_virtual_sequence is used by directed_test and random_test.
 * These tests load this null sequence into the virtual sequencer in testbench
 * ENV, as these tests use the sequencer defined in the DTE/DCE agent.
 *
 * Execution phase: main_phase 
 * Sequencer: Can be used with any sequencer in
 * which default sequence needs to be overridden with a null sequence. In this
 * example, this sequence has been used with virtual sequencer in the testbench
 * environment.
 */
class uart_null_virtual_sequence extends uvm_sequence;

  /** UVM object utility macro */
  `uvm_object_utils(uart_null_virtual_sequence)

  /** Class constructor */
  function new (string name = "uart_null_virtual_sequence");
    super.new(name);
  endfunction : new

  /** Need an empty body function to override the warning from the UVM base class */
  virtual task body();
  endtask : body

endclass : uart_null_virtual_sequence 

`endif // GUARD_UART_NULL_VIRTUAL_SEQUENCE_SV


`include "ahb_base_test.sv"
/**
 * Abstract:
 * This file test runs the default base test without modification
 */

class base_test extends ahb_base_test;

  /** UVM Component Utility macro */
  `uvm_component_utils(base_test)

  /** Class Constructor */
  function new(string name = "base_test", uvm_component parent=null);
    super.new(name,parent);
  endfunction: new

endclass

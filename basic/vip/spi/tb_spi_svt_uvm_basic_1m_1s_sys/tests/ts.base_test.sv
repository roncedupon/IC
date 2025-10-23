
/**
 * Abstract:
 * This file test runs the default base test without modification
 */

class base_test extends spi_base_test;

  /** UVM component utility macro */
  `uvm_component_utils(base_test)

  /** Class constructor */
  function new(string name = "base_test", uvm_component parent=null);
    super.new(name,parent);
  endfunction : new

endclass

//----------------------------------------------------------------------------
//--------------------------END OF FILE---------------------------------------
//----------------------------------------------------------------------------

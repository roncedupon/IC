
/**
 * Abstract:
 * The file contains the class extended from uvm_sequence. It is a no-operation sequence. 
 * It has an empty virtual function body overriden as empty function.
 */

`ifndef GUARD_I2C_NULL_VIRTUAL_SEQUENCE_SV
`define GUARD_I2C_NULL_VIRTUAL_SEQUENCE_SV

class i2c_null_virtual_sequence extends uvm_sequence;

  /** UVM object utility macro */
  `uvm_object_utils(i2c_null_virtual_sequence)

  /** Class constructor */
  function new (string name = "i2c_null_virtual_sequence");
    super.new(name);
  endfunction : new

  /** Need an empty body function to override the warning from the UVM base class */
  virtual task body();
  endtask : body

endclass : i2c_null_virtual_sequence 

`endif // GUARD_I2C_NULL_VIRTUAL_SEQUENCE_UVM_SV


//------------------------------------------------------------------------
//-----------------------END OF FILE--------------------------------------
//------------------------------------------------------------------------

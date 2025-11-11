
/**
 * Abstract:
 * This file defines a class that represents a customized transaction class
 * which is extended from svt_i2c_slave_transaction class. This extended class
 * adds constraint on slave_nack_addr field. The default transaction
 * instance of the generator is replaced by an instance of this class in random test cases.
 */

`ifndef GUARD_CUST_SVT_I2C_SLAVE_TRANSACTION_SV
`define GUARD_CUST_SVT_I2C_SLAVE_TRANSACTION_SV 

class cust_svt_i2c_slave_transaction extends svt_i2c_slave_transaction ;

  /** UVM object utility macro */
  `uvm_object_utils_begin(cust_svt_i2c_slave_transaction)
  `uvm_object_utils_end
  
  constraint slv_nack_addr {
     nack_addr == 0;
  }

  /** Class constructor */
  function new(string name ="cust_svt_i2c_slave_transaction" );
    super.new(name);
  endfunction

endclass
`endif // GUARD_CUST_SVT_I2C_TRANSACTION_SV
 

//------------------------------------------------------------------------
//-----------------------END OF FILE--------------------------------------
//------------------------------------------------------------------------

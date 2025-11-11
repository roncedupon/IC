
/** 
 * Abstract:
 * This file defines a class that represents a customized transaction class 
 * which is extended from svt_i2c_master_transaction class. This extended class
 * adds constraints on cmd and cmd_address fields. The default transaction
 * instance of the generator is replaced by an instance of this class in random test cases.
 */

`ifndef GUARD_CUST_SVT_I2C_MASTER_TRANSACTION_SV
`define GUARD_CUST_SVT_I2C_MASTER_TRANSACTION_SV 

class cust_svt_i2c_master_transaction extends svt_i2c_master_transaction ;
  
  /** UVM object utility macro */
  `uvm_object_utils_begin(cust_svt_i2c_master_transaction)
  `uvm_object_utils_end
  
  constraint cmd_type {
  }

constraint reasonable_addr
{
}

  /** Class constructor */
  function new(string name ="cust_svt_i2c_master_transaction" );
    super.new(name);
  endfunction

endclass
`endif // GUARD_CUST_SVT_I2C_TRANSACTION_SV
 

//------------------------------------------------------------------------
//-----------------------END OF FILE--------------------------------------
//------------------------------------------------------------------------


`ifndef GUARD_I2C_MASTER_MISS_REP_START_AFTER_MASTER_CODE_CALLBACK_SV
`define GUARD_I2C_MASTER_MISS_REP_START_AFTER_MASTER_CODE_CALLBACK_SV

/**
 * Abstract: 
 * class 'i2c_master_miss_rep_start_after_master_code_callback' is extended from svt_i2c_master_callback class. 
 * It implements the post_seq_item_get method to set error exception from master.
 * It is used to send illegal Stop right after sending master code in HS mode.
 */

class i2c_master_miss_rep_start_after_master_code_callback extends svt_i2c_master_callback;

  //Class Constructor
  function new(string name);
    super.new(name);
  endfunction: new
  
  //Callback method
  virtual function void post_seq_item_get(svt_i2c_master driver, svt_i2c_master_transaction xact, ref bit drop);

    //create a local handle of exception class and exception list
    svt_i2c_master_transaction_exception_list cust_exception_list;
    svt_i2c_master_transaction_exception exception;

    //create the exception class
    exception = new("cust_exception");

    //create the exception list
    cust_exception_list = new("cust_exception_list",exception);

    //assign the type of error to be inserted in exception class
    exception.error_kind = svt_i2c_master_transaction_exception::I2C_MASTER_MISS_SR_AFTER_MASTER_CODE;

    //Add the exception class to the exception list
    cust_exception_list.add_exception(exception);

    //write the handle of the exception list on the trans class handle
    xact.exception_list = cust_exception_list;

  endfunction: post_seq_item_get
endclass: i2c_master_miss_rep_start_after_master_code_callback
`endif //GUARD_I2C_MASTER_MISS_REP_START_AFTER_MASTER_CODE_CALLBACK_SV

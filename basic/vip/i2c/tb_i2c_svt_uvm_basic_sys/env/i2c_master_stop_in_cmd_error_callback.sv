
`ifndef GUARD_I2C_MASTER_STOP_IN_CMD_ERROR_CALLBACK_SV
`define GUARD_I2C_MASTER_STOP_IN_CMD_ERROR_CALLBACK_SV 

/**
 * Abstract: 
 * class 'i2c_master_stop_in_cmd_error_callback' is extended from svt_i2c_master_callback class. 
 * It implements the post_seq_item_get method to set error exception from master.
 * This EI is used to insert Stop in either 1st phase or 2nd phase of CMD word in 10-bit addressing.
 */

class i2c_master_stop_in_cmd_error_callback extends svt_i2c_master_callback;

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
    exception.error_kind = svt_i2c_master_transaction_exception::STOP_IN_BYTE;
    exception.p_at_cmd_data = 0;
    exception.p_at_1st_or_2nd_cmd= 1; //insert stop in either 1st or 2nd phase of cmd
    exception.byte_bit_pos = 5;
    exception.retry_txn = 1;

    //Add the exception class to the exception list
    cust_exception_list.add_exception(exception);

    //write the handle of the exception list on the trans class handle
    xact.exception_list = cust_exception_list;

  endfunction: post_seq_item_get
endclass: i2c_master_stop_in_cmd_error_callback
`endif //GUARD_I2C_MASTER_STOP_IN_CMD_ERROR_CALLBACK_SV

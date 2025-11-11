`ifndef GUARD_I2C_MASTER_INSERT_REPEATED_START_AFTER_8BIT_OF_READ_DATA_BYTE_CALLBACK_SV
`define GUARD_I2C_MASTER_INSERT_REPEATED_START_AFTER_8BIT_OF_READ_DATA_BYTE_CALLBACK_SV

/**
 * Abstract: 
 * class 'i2c_master_insert_REPEATED_START_after_8bit_of_read_data_byte_callback' is extended from svt_i2c_master_callback class. 
 * It implements the post_seq_item_get method to set error exception from master.
 * It is used to send illegal REPEATED START inspite of ACK bit after 8th bit of the first read data byte.
 */

class i2c_master_insert_repeated_start_after_8bit_of_read_data_byte_callback extends svt_i2c_master_callback;

  /**
   * This variable is used to tell the master after how many bytes it should send illegal repeated start.
   * Possible values
   * 1: After first data byte (default value).
   * N: After Nth data byte.
   * NOTE: Value 0 is not allowed.
   */
  int num_data_byte=1;


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
    exception.error_kind = svt_i2c_master_transaction_exception::I2C_INSERT_REPEATED_START_AFTER_8_BIT_RD_DATA;
    if(num_data_byte == 0)
      exception.mst_corrupted_num_of_bytes = 1;
    else
      exception.mst_corrupted_num_of_bytes = num_data_byte;
 

    //Add the exception class to the exception list
    cust_exception_list.add_exception(exception);

    //write the handle of the exception list on the trans class handle
    xact.exception_list = cust_exception_list;

  endfunction: post_seq_item_get
endclass: i2c_master_insert_repeated_start_after_8bit_of_read_data_byte_callback
`endif //GUARD_I2C_MASTER_INSERT_REPEATED_START_AFTER_8BIT_OF_READ_DATA_BYTE_CALLBACK_SV


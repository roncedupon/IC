

/**
 * Abstract: 
 * class 'i2c_slave_ack_for_reserved_address_callback' is extended from svt_i2c_slave_callback class. 
 * It implements the post_seq_item_get method to set error exception from slave.
 * This callback is used to inject ERROR [SEND_ACK_FOR_RESERVED_ADDR_ERROR].
 * "SEND_ACK_FOR_RESERVED_ADDR_ERROR": Deliberately insert ACK for Reserved address in I2C.
 */

class i2c_slave_ack_for_reserved_address_callback extends svt_i2c_slave_callback;

  //Class Constructor
  function new(string name);
    super.new(name);
  endfunction: new
  
  //Callback method
  virtual function void post_seq_item_get(svt_i2c_slave driver, svt_i2c_slave_transaction xact, ref bit drop);

    //create a local handle of exception class and exception list
    svt_i2c_slave_transaction_exception_list cust_exception_list;
    svt_i2c_slave_transaction_exception exception;

    //create the exception class
    exception = new("cust_exception");

    //create the exception list
    cust_exception_list = new("cust_exception_list",exception);

    //assign the type of error to be inserted in exception class
    exception.error_kind = svt_i2c_slave_transaction_exception::SEND_ACK_FOR_RESERVED_ADDR_ERROR;

    //Add the exception class to the exception list
    cust_exception_list.add_exception(exception);

    //write the handle of the exception list on the trans class handle
    xact.exception_list = cust_exception_list;

  endfunction: post_seq_item_get
endclass: i2c_slave_ack_for_reserved_address_callback


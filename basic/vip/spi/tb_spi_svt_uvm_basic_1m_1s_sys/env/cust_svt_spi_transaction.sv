
`ifndef GUARD_CUST_SVT_SPI_TRANSACTION_SV
`define GUARD_CUST_SVT_SPI_TRANSACTION_SV 

/** 
 * Abstract:
 * This file defines a class that represents a customized transaction class 
 * which is extended from svt_spi_transaction class. This extended class
 * adds pre-defined fields which are used as distribution weights to constrain 
 * frame type field in the transactions, and adds constraints on  frame type and 
 * address fields. The default transaction instance of the generator is 
 * replaced by an instance of this class in random test cases.
 */
class cust_svt_spi_transaction extends svt_spi_transaction ;

  int slave_id = 0;
  
  /** 
   * UVM object utility macro which implements the create() and get_type_name() methods. 
   * Field macros registeration provides default implementation of utility functions, 
   * print() & copy().
   */
  `uvm_object_utils_begin(cust_svt_spi_transaction)
    `uvm_field_int(slave_id, UVM_PRINT | UVM_COPY)
  `uvm_object_utils_end

  constraint cmd_type {
     slave_id == 0;
  }

  /** Class constructor */
  function new(string name ="cust_svt_spi_transaction" );
    super.new(name);
  endfunction
   
endclass
`endif // GUARD_CUST_SVT_SPI_TRANSACTION_SV
 

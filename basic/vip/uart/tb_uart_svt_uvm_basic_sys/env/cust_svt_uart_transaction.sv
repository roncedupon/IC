
`ifndef GUARD_CUST_SVT_UART_TRANSACTION_SV
`define GUARD_CUST_SVT_UART_TRANSACTION_SV 

/** 
 * Abstract:
 * This file defines a class that represents a customized transaction class 
 * which is extended from svt_uart_transaction class. This extended class
 * adds pre-defined fields which are used as distribution weights to constrain 
 * frame type field in the transactions, and adds constraints on  frame type and 
 * address fields. The default transaction instance of the generator is 
 * replaced by an instance of this class in random test cases.
 */
class cust_svt_uart_transaction extends svt_uart_transaction ;

  /* Value to control the number of packets to be transferred */
  int uart_pkt_count = 50; 
  
  /** 
   * UVM object utility macro which implements the create() and get_type_name() methods. 
   * Field macros registeration provides default implementation of utility functions, 
   * print() & copy().
   */
  `uvm_object_utils_begin(cust_svt_uart_transaction)
    `uvm_field_int(uart_pkt_count, UVM_PRINT | UVM_COPY)
  `uvm_object_utils_end

  constraint cmd_type {
    packet_count == uart_pkt_count;
    inter_cycle_delay == 100;
  }

  /** Class constructor */
  function new(string name ="cust_svt_uart_transaction" );
    super.new(name);
    this.reasonable_packet_count.constraint_mode(0);
  endfunction
   
endclass
`endif // GUARD_CUST_SVT_UART_TRANSACTION_SV
 

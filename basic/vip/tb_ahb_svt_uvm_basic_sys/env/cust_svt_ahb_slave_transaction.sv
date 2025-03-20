
/**
 * Abstract:
 * This file defines a class that represents a customized AHB Master 
 * transaction.  This class extends the AHB VIP's svt_ahb_slave_transaction
 * class.  It adds pre-defined distribution constraints for transaction 
 * weighting, and adds constraints on burst type.
 * It implements the necessary virtual functions like copy(), compare(), etc...
 * by using `uvm_object_utils macro.
 *
 * The transaction instance replaces the default slave sequencer's transaction
 * object, which is shown in tests/ts.basic_random_test.sv
 */

`ifndef GUARD_CUST_SVT_AHB_SLAVE_TRANSACTION_SV
`define GUARD_CUST_SVT_AHB_SLAVE_TRANSACTION_SV

class cust_svt_ahb_slave_transaction extends svt_ahb_slave_transaction;

  int response_type_okay_wt   = 1000;
  int response_type_error_wt  = 1;
  
  int num_wait_cycles_zero_wt = 50;
  int num_wait_cycles_non_zero_wt = 1;

  // Declare user-defined constraints
  constraint slave_constraints {

    response_type dist {svt_ahb_transaction::OKAY:=response_type_okay_wt,
                        svt_ahb_transaction::ERROR:=response_type_error_wt};
  
    num_wait_cycles dist { 0 := num_wait_cycles_zero_wt,
                          [1:16] := num_wait_cycles_non_zero_wt };

  }

  /** UVM Object Utility macro */
  `uvm_object_utils_begin(cust_svt_ahb_slave_transaction)
     `uvm_field_int(response_type_okay_wt,UVM_ALL_ON)
     `uvm_field_int(response_type_error_wt ,UVM_ALL_ON)
  `uvm_object_utils_end

  /** Class Constructor */
  function new (string name = "cust_svt_ahb_slave_transaction");
    super.new(name);
  endfunction: new

endclass: cust_svt_ahb_slave_transaction

`endif // GUARD_CUST_SVT_AHB_SLAVE_TRANSACTION_SV

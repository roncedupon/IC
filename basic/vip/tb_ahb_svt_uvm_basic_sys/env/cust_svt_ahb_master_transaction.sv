
/**
 * Abstract:
 * This file defines a class that represents a customized AHB Master 
 * transaction.  This class extends the AHB VIP's svt_ahb_master_transaction
 * class.  It adds pre-defined distribution constraints for transaction 
 * weighting, and adds constraints on burst type.
 * It implements the necessary virtual functions like copy(), compare(), etc...
 * by using `uvm_object_utils macro.
 *
 * The transaction instance replaces the default master sequencer's transaction
 * object, which is shown in tests/ts.basic_random_test.sv
 */

`ifndef GUARD_CUST_SVT_AHB_MASTER_TRANSACTION_SV
`define GUARD_CUST_SVT_AHB_MASTER_TRANSACTION_SV

class cust_svt_ahb_master_transaction extends svt_ahb_master_transaction;

  int burst_type_single_wt = 1;
  int burst_type_incr4_wt  = 2;
  int burst_type_incr_wt   = 3;

  int num_busy_cycles_zero_wt = 500;
  int num_busy_cycles_non_zero_wt = 1;
  
  // Declare user-defined constraints
  constraint master_constraints {
    burst_type dist { svt_ahb_transaction::SINGLE := burst_type_single_wt,
                      svt_ahb_transaction::INCR   := burst_type_incr_wt,
                      svt_ahb_transaction::INCR4  := burst_type_incr4_wt }; 
  
    foreach (num_busy_cycles[i]) {
      num_busy_cycles[i] dist { 0 := num_busy_cycles_zero_wt, 
                                [1:16] := num_busy_cycles_non_zero_wt};  
    }

    (addr >=0 && addr <= 'h500);
  }

  /** UVM Object Utility macro */
  `uvm_object_utils_begin(cust_svt_ahb_master_transaction)
     `uvm_field_int(burst_type_single_wt,UVM_ALL_ON)
     `uvm_field_int(burst_type_incr_wt ,UVM_ALL_ON)
     `uvm_field_int(burst_type_incr4_wt ,UVM_ALL_ON)
  `uvm_object_utils_end

  /** Class Constructor */
  function new (string name = "cust_svt_ahb_master_transaction");
    super.new(name);
  endfunction: new

endclass: cust_svt_ahb_master_transaction

`endif // GUARD_CUST_SVT_AHB_MASTER_TRANSACTION_SV

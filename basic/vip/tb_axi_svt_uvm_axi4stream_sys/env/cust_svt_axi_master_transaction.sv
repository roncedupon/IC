//=======================================================================
// COPYRIGHT (C) 2010, 2011, 2012, 2013 SYNOPSYS INC.
// This software and the associated documentation are confidential and
// proprietary to Synopsys, Inc. Your use or disclosure of this software
// is subject to the terms and conditions of a written license agreement
// between you, or your company, and Synopsys, Inc. In the event of
// publications, the following notice is applicable:
//
// ALL RIGHTS RESERVED
//
// The entire notice above must be reproduced on all authorized copies.
//-----------------------------------------------------------------------

/**
 * Abstract:
 * This file defines a class that represents a customized AXI Master 
 * transaction.  This class extends the AXI VIP's svt_axi_master_transaction
 * class.  It adds pre-defined distribution constraints for transaction 
 * weighting, and adds constraints on burst type.
 * It implements the necessary virtual functions like copy(), compare(), etc...
 * by using `uvm_object_utils macro.
 *
 * The transaction instance replaces the default master sequencer's transaction
 * object, which is shown in tests/ts.basic_random_test.sv
 */

`ifndef GUARD_CUST_SVT_AXI_MASTER_TRANSACTION_SV
`define GUARD_CUST_SVT_AXI_MASTER_TRANSACTION_SV

class cust_svt_axi_master_transaction extends svt_axi_master_transaction;

  // Declare user-defined constraints
  constraint master_constraints {

    addr >=0 ;
  }

  /** UVM Object Utility macro */
  `uvm_object_utils(cust_svt_axi_master_transaction)

  /** Class Constructor */
  function new (string name = "cust_svt_axi_master_transaction");
    super.new(name);
  endfunction: new

endclass: cust_svt_axi_master_transaction

`endif // GUARD_CUST_SVT_AXI_MASTER_TRANSACTION_SV

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
//=======================================================================

`include "axi_base_test.sv"
/**
 * Abstract:
 * This file test runs the default base test without modification
 */

class base_test extends axi_base_test;

  /** UVM Component Utility macro */
  `uvm_component_utils(base_test)

  /** Class Constructor */
  function new(string name = "base_test", uvm_component parent=null);
    super.new(name,parent);
  endfunction: new

endclass

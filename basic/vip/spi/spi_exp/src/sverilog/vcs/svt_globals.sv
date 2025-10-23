//=======================================================================
//
// COPYRIGHT (C) 2012-2014 SYNOPSYS INC.
// This software and the associated documentation are confidential and
// proprietary to Synopsys, Inc. Your use or disclosure of this software
// is subject to the terms and conditions of a written license agreement
// between you, or your company, and Synopsys, Inc. In the event of
// publications, the following notice is applicable:
//
// ALL RIGHTS RESERVED
//
// The entire notice above must be reproduced on all authorized copies.
//
//-----------------------------------------------------------------------

`ifndef GUARD_SVT_GLOBALS_SV
`define GUARD_SVT_GLOBALS_SV

`ifndef SVT_VMM_TECHNOLOGY

/**
 * The use of variables on the left-hand side in non-blocking assignments
 * can be problematic for global methods unless they are included in packages
 * or modules. For example if the 'svt_wait_for_nba_region' method is simply
 * loaded in the top level testbench, outside a module or package, VCS will
 * generate the following error:
 *
 *   Error-[DTNBA] Dynamic type in non-blocking assignment..."nba"...Dynamic
 *   type (Automatic variable in this case) cannot be used on the left-hand
 *   side of non blocking assignment.
 *
 * As some SVT VIPs have committed to support the use of their VMM versions
 * outside of a package, and since the 'svt_wait_for_nba_region' is not
 * currently required to provide VMM support for any of the SVT VIPs, this
 * method has been excluded in the VMM version of SVT.
 *
 * Since this feature has been identified as a necessity in UVM/OVM, and
 * since we require that the VIP be loaded via package in these domains,
 * this feature is fully supported in UVM/OVM.
 */

`ifndef SVT_POUND_ZERO_COUNT
 `define SVT_POUND_ZERO_COUNT 1
`endif

// ---------------------------------------------------------------------------
/**
 * Callers of this task will not return until the NBA region, thus allowing
 * other processes any number of delta cycles (#0) to settle out before
 * continuing.
 */
task svt_wait_for_nba_region;

`ifdef SVT_UVM_TECHNOLOGY
  uvm_wait_for_nba_region();

`else
  string s;

  int nba;
  int next_nba;

  //If `included directly in a program block, can't use a non-blocking assign,
  //but it isn't needed since program blocks are in a seperate region.
`ifndef SVT_NO_WAIT_FOR_NBA
  next_nba++;
  nba <= next_nba;
  @(nba);
`else
  repeat(`SVT_POUND_ZERO_COUNT) #0;
`endif

`endif

endtask

`endif

// ---------------------------------------------------------------------------
/**
 * Method which can be used to do a fuzzy compare between two real values.
 *
 * @param lhs The field value for the object doing the compare.
 * @param rhs The field value for the object being compared.
 * @param precision The precision to be applied to the compare.
 * @return Indicates whether the compare was a match (1) or a mismatch (0).
 */
function automatic bit svt_fuzzy_real_compare(real lhs, real rhs, real precision = `SVT_DEFAULT_FUZZY_COMPARE_PRECISION);
  // Do the comparison
  svt_fuzzy_real_compare = (
    (lhs > rhs) ?
      ((lhs - rhs) < precision) :
      ((rhs - lhs) < precision)
  );
endfunction

`endif

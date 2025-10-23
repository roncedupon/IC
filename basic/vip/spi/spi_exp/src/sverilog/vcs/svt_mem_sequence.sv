//=======================================================================
// COPYRIGHT (C) 2012-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_MEM_SEQUENCE_SV
`define GUARD_SVT_MEM_SEQUENCE_SV

`ifndef SVT_VMM_TECHNOLOGY

typedef class svt_mem_sequence;

// =============================================================================
/**
 * Base class for all SVT mem sequences. Because of the mem nature of the
 * protocol, the direction of requests (REQ) and responses (RSP) is reversed from the
 * usual sequencer/driver flow.
 */
virtual class svt_mem_sequence extends svt_reactive_sequence#(svt_mem_transaction);

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************
   
   
  /** CONSTRUCTOR: Create a new SVT sequence object */
  extern function new (string name = "svt_mem_sequence", string suite_spec = "");

  // =============================================================================

endclass


//svt_vcs_lic_vip_protect
`protected
aC>V]8(810&&c3XDePLK9#[@U?#/BMP2/2OULF^96_-C=cYC9/V01(E+&e-NWGc@
E>@M<X8@T?(cU?OI5S<EeWaMS0C40X63DNTPIc7I<E+H:#A#1<.f]a\L&6K2FXg-
X,T[=ZC_AGY7X5=]-0^L\P-5d^O[Q>O_&[R4\CWc)]OHT_P(W=8\UUOKC&Pf87MY
XO7C<^d#5B\b1QLD93BBT6W86a&c\\Q9G;[JHJ^0>^WIf.HM^K\ZL?4,Ub3=2_#@
Y[\M3V(R8eNS?.gH.GM^0V0CK22\G1BRW1MdQQR3X?_fbUA9d]2-=HeMEQ-1-PNZ
F1b;\92/c#Q-EGT@_4,(U58N(B:S9,\N.&Ee^1gUXBb6U^EV=/FOT_UQXWdSMe5[
#8)=3IAJ0T]Z]TFR]c4\N>g-]4,:TE>B?$
`endprotected


`endif // !SVT_VMM_TECHNOLOGY

`endif // GUARD_SVT_MEM_SEQUENCE_SV

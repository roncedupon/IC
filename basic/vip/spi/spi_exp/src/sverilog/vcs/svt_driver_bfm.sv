//=======================================================================
// COPYRIGHT (C) 2010-2016 SYNOPSYS INC.
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

`ifndef GUARD_SVT_DRIVER_BFM_SV
`define GUARD_SVT_DRIVER_BFM_SV

`include "VmtDefines.inc"

`include `SVT_SOURCE_MAP_LIB_INCLUDE_SVI(R-2020.12,svt_xactor_bfm_if_util)
`include `SVT_SOURCE_MAP_LIB_SRC_SVI(R-2020.12,svt_bfm_util)

// Kind used for byte_size, byte_pack, byte_unpack, and compare
`define DW_VIP_VMT_LOGICAL  9        

// is_valid return value which indicates "ok" or "valid"
`define DW_VIP_XACT_OK 0

`protected
dT(d4PIcL10A0SLDSF(]UdR42?ZP=G6GB0CVd-+A(?XK:fC_3UXP0)A2b)^2O_[[
+C,aBIVO/,F11L9,HQ9#OMBg_8XF.SgNPXDaY;2>[2H@EYI]4@B^9ceY9_dO6c26
8c)O/CXG)\0T\W=d\>d[.DDPUDAYY#IEU_=+eb#aCMZ#-[4a@d2X@aN\FAA0HC16
L&CW6;QTM_^T*$
`endprotected


// =============================================================================
/**
 * Class that provides the basic infrastructure common to all SVT agents.
 */
class svt_driver_bfm#(type REQ=`SVT_XVM(sequence_item),
                      type RSP=REQ) extends `SVT_XVM(driver)#(REQ,RSP);

  // Declare all of the properties and methods for this driver
  `SVT_BFM_UTIL_DECL(svt_driver_bfm)

  // Declare all of the virtual methods which allow access to the base VMT commands
  `SVT_XACTOR_BFM_VMT_CMD_METHODS_DECL

endclass

`protected
P0Y?_E?]<T\6/]\9A53Rc@3#cL@NC2eff:f]ZC]Oe7<bBHZUd,)02)Dc_/Q.OY&8
D)&:C=4>WG@-JE^;5<S6^A,JRAdTH]W#bOc>cO&)GL:\._F&O2<,]K^Ua_8[Z5df
#B=S]A=8I:6>0Qb_c?C3Ref6EF:D7=GE;-5Y+<R39+W)L@,;cZLR@T?T)8]7PIDZ
><X78LSSee_>,$
`endprotected


`SVT_BFM_UTIL_REPORT_CATCHER_PARAM_DECL(svt_driver_bfm)

`protected
\4H.F?C).T<K[+E@\RS75CGVOY/=[#eY1\,B8a^D82a(_f/.GCL)0)g4a9Q^?G+=
5F8Pf617eMUKT>Tb@AMg@c&Sb+3Q#VLa]D)g:^Ve:WI6,>D6.>U+2/MIE8d,R?E0
6-C5cCQeQY5K0$
`endprotected


// For backwards compatibility
`ifdef SVT_UVM_TECHNOLOGY
class svt_uvm_driver_bfm#(type REQ=uvm_sequence_item,
                          type RSP=REQ) extends svt_driver_bfm#(REQ,RSP);
  `uvm_component_utils(svt_uvm_driver_bfm)

  function new(string name = "", uvm_component parent = null, string suite_name = "");
     super.new(name, parent, suite_name);
  endfunction
endclass
`endif

`endif // GUARD_SVT_DRIVER_BFM_SV

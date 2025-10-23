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

`ifndef GUARD_SVT_MONITOR_BFM_SV
`define GUARD_SVT_MONITOR_BFM_SV

`include "VmtDefines.inc"

`include `SVT_SOURCE_MAP_LIB_SRC_SVI(R-2020.12,svt_xactor_bfm_if_util)
`include `SVT_SOURCE_MAP_LIB_SRC_SVI(R-2020.12,svt_bfm_util)

// Kind used for byte_size, byte_pack, byte_unpack, and compare
`define DW_VIP_VMT_LOGICAL  9        

// is_valid return value which indicates "ok" or "valid"
`define DW_VIP_XACT_OK 0

`protected
b\>f&OS?VJ(+DD)NJKF_NfgH9\_,YQB.P?,EF=W)5LRV[M8Q.g><4)Kd1_.AEU,@
DUDaMEVV6BD/+?NWF[BT,BDT2BRT9B)<AK]@=S,I9]49Zc_6gIA1C?AeTF-[AX/K
V\WH07T/P1W=ZW8RA^AEXM9JRBX9_2)>TcLZ3J_>;O==[1Y&4__/:E<]bG=1e8.3
+#E7=<?VH^X=+$
`endprotected


// =============================================================================
/**
 * Class that provides the basic infrastructure common to all SVT agents.
 */
class svt_monitor_bfm extends `SVT_XVM(monitor);

  // Declare all of the properties and methods for this monitor
  `SVT_BFM_UTIL_DECL(svt_monitor_bfm)

  // Declare all of the virtual methods which allow access to the base VMT commands
  `SVT_XACTOR_BFM_VMT_CMD_METHODS_DECL

endclass

`protected
e&,edOEaXbIS&Y6BJYYN79QcF1#+9,2OAggU#@SYNXI7:5AWI7B0-)59LRe&C86S
T@Ub(AUdg55U@@,//>7(+Yd?2EIgD/XS=R4g^gK51O75dH.<^cUKJ;cea+6(@19#
,#2f1A]?Z^3eU)/6PI>HbG<>T0\\_R&_T4H6[YTL_79W+L.00;D@,DA,N+P4C=-M
;O:a_(04B>Pe.$
`endprotected


`SVT_BFM_UTIL_REPORT_CATCHER_NO_PARAM_DECL(svt_monitor_bfm)

`protected
ZV^TN>aK0PgRWJX<B;H3LcF;d.+V72:a]Ad_fB4-d.I605?.eW78))eeH97FWD1b
@2]\IJ=c[<>J6OQIG,.C__Q32=4+\Y<.-IAEX^Q:Ad5R;]+^FW:T@_D;MR2WDc-&
N-5UE,K18Yb9.V3TZ_Ja/RQ34$
`endprotected


// For backwards compatibility
`ifdef SVT_UVM_TECHNOLOGY
class svt_uvm_monitor_bfm extends svt_monitor_bfm;
  `uvm_component_utils(svt_uvm_monitor_bfm)

  function new(string name = "", uvm_component parent = null, string suite_name = "");
     super.new(name, parent, suite_name);
  endfunction
endclass
`endif

`endif // GUARD_SVT_MONITOR_BFM_SV

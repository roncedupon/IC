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

`ifndef GUARD_SVT_COMPONENT_BFM_SV
`define GUARD_SVT_COMPONENT_BFM_SV

`include "VmtDefines.inc"

`include `SVT_SOURCE_MAP_LIB_INCLUDE_SVI(R-2020.12,svt_xactor_bfm_if_util)
`include `SVT_SOURCE_MAP_LIB_SRC_SVI(R-2020.12,svt_bfm_util)

// Kind used for byte_size, byte_pack, byte_unpack, and compare
`define DW_VIP_VMT_LOGICAL  9        

// is_valid return value which indicates "ok" or "valid"
`define DW_VIP_XACT_OK 0

`protected
,Sc[5D0OB.1@5YOP)VT\d)9F320VT<^JEbVU>ZOeSV[X7W;X&#CI5)3^D?aIY2cZ
b)WSY>0>_J/[MIZ98OM[H31WZCeW(J7a#7>GbGO8FMPQDb+R;G=PE:E34?_W1O.a
NUD3Ad)<S6G@+FNJ@^W^Z.W@KIRI&0eb^f,Z=YCWZVCd&9AIWE]Z/5\L]-A^HVY<
eE&QgA>L+dH@-$
`endprotected


// =============================================================================
/**
 * Class that provides the basic infrastructure common to all SVT agents.
 */
class svt_component_bfm extends `SVT_XVM(component);

  // Declare all of the properties and methods for this component
  `SVT_BFM_UTIL_DECL(svt_component_bfm)

  // Declare all of the virtual methods which allow access to the base VMT commands
  `SVT_XACTOR_BFM_VMT_CMD_METHODS_DECL

endclass

`protected
OdAY:P<1QO-E]K,,UHZLg3&[B<A6aI0Bg>F:#_P5=Q(cQ?=BCOPI0)fe>ZGW9=RZ
0#a)aW&Oe\&S.6>D)O+Z_48KdU0fbB=aFJ#U[)^T0:,5CM_+IVeFgGQQR84f(6^F
:b9LGe0FE-Z0Z?0C9?585Bb^3[f,R_beG>RPe-Rdc;;#/[[@D@]_,G#E9>WgEV]e
Qd9[+(3U?A/S+5GLbd8FeRb^2$
`endprotected


`SVT_BFM_UTIL_REPORT_CATCHER_NO_PARAM_DECL(svt_component_bfm)

`protected
4NIQ\fXg][/Y0&SAR6;O>G]4U./O\g]N4eN,XScVBF:cC01\:HQ/))3N++AaMR_W
\FX.;]dcd)8Q)OfLVX^.C8WOF3>J)-1]Nbd.=/:EB+8.I3WWU8T?>Z)60F^O290N
MAZ->B[5&DL.5F(4(<A/C_WO6$
`endprotected


// For backwards compatibility
`ifdef SVT_UVM_TECHNOLOGY
class svt_uvm_component_bfm extends svt_component_bfm;
  `uvm_component_utils(svt_uvm_component_bfm)

  function new(string name = "", uvm_component parent = null, string suite_name = "");
    super.new(name, parent, suite_name);
  endfunction
endclass
`endif

`endif // GUARD_SVT_COMPONENT_BFM_SV

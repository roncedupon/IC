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
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
YzupD4HhxNDuh1oZ5mEqEBSERYgogEWZJFX6YgMnn7c2UPzrZVsMm5WgF9i3w8nC
bRYQSeun7JISvJKxBilBVau7aa+WJgjfgmVPEtLjnKcqKGq9K1hxw2nfrnuJSMz0
azT30ONQ0kT2XknXCYwZEMSqLT/BgR7WJN0DPoAAcNI=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 345       )
oS+FYsKtYKtWt58WKOGJs7OqgcLWNd5nd5yRXfml4KcZkA228UDbEnDhSNMYACM4
FxKz9mpzHdWOZZJHu3ks2AnERBuQmSPhmX4h80ZmgTduK9TGt5u4RpeWzrZcx0VT
8neVCyeEzzh+4je28iaq5RW/2+E20Dlb8DcxIjEi811dCbsVz2VGXCZ4SjvtoP0x
YzO1j0X+mb5e4hzRW4yAaJaDKHcW/3KBnJsHOmxoapyroMJpxshd6f0dvJEQggGw
wGqmCh9V5FYnHK9HWDyJRcO74wPqyeaa0Z22+0JRa/w/awYxw77EdE0sn0FC8ug8
M1hcdjTJJUzPksIUEMaPVffHJv8Tk/OO+qZeSOPH+AVKDyd8le6fM70B5VXzs0I4
+2bCqFwSZE4jHrBbDxZL2Pj1asqxUvkLafGB8s6GvV7fPSLVe4Ucaf5gw96Ix3+i
rMYU3Nn4UAFlwLAl/WsLGA==
`pragma protect end_protected

`endif // !SVT_VMM_TECHNOLOGY

`endif // GUARD_SVT_MEM_SEQUENCE_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
aKdJGMlyKe/ASGC3vGVuoy1vlsUKKKdkBpVWU1Uua+ocY7Y++QlNFv2+JGtf/Yeg
g0O8WVOWZ3PXO4OIRNoCiesGoteYqDP/mJTwe/GaHKZRm1ghyc4c6vkuegFMeLB+
XFUhtFZ7zkRjHwCbxden4sPsGy8ImrRdVlRqezsDvhY=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 428       )
ba0ohsr6CT9Rj36EHk7ny2RZ7JO3rkvoMnHu+BMecyCmXFYyZnGYmjDfwUoh1pHg
0iYaPzxlDHuh16R0/3Ch768Br9pddgVaYrcPF1/H8fQplDFNsM7IxjpGngoT1/MY
`pragma protect end_protected

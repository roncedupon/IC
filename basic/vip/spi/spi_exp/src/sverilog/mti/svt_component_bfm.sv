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

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
oQfLuQdjEChWQS8z3xSrIJOMcVc7pK6W3JDaStHIyFgWCUR04lRv1SKv9PQutrAg
RCSBtWlr4ZBiO0+O0XSvH3MSbx2P4XAokd0mEoC33cbdhn/RhjOjrIB8Bl0Gu71C
kn8pYBq8RfwSdpPO0IebM8JOB+UIqsPkxvjKx332BVI=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 216       )
Wq3ERJCfDPqzr6g+2M3x7O3aF2GF+URNqA6tpdH57buCDjX2wIcgPEVhFZCfso7Q
oFMFrskmahSi/YveQJvJACZzGjNT3JH7ZvyipDFHy/vV2Vm0ex/B8FNyTaQdRS7Z
E0NmBAEQhRLIeZmB8RDy13jLoOaXpzLOzlG81X50NbC06pqvYLXmZTLLgFQM4+ub
/6POhrzhGyQaOsPFCrKAzkT9suiwl2YcQRus+chEAYbYvo61eh0KBZU9Hw7eGZrQ
pVTyYB5QtGTLK/y1Iamd5VqplY9i+0h+84YTVP1LzuE=
`pragma protect end_protected

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

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
KrBaHtdsotAGDyckZPi772sKXixEgNOcv2yhFxJehtZVwE8CylNuqmQoeMML1Q+N
RP/Vlyx9QvhcmDxcuRhPHBsI0RHnXbm/jsmOeONe3m4DTHz6DcalFU+oc4FQTlvr
TN/JN+EtXzz/LYSOA9FSiWt1yp9nHGKsb2V+gk/hijk=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 537       )
0OkPczHYuN6/FGd/pUE7nEbKWqcgThsk5w8t81jlMKE2Ac4A2hQB2dwWMdGumec9
xlnXHBgOVWBQKBt8zEx4cClo6aOihfXaPDZ08EWMgOk72nnyd5fV+v+gF5gJ4qJj
YxPGLVvMgx29UTLUc+3M/C4CuomVqdsVTmRgk3ViAgyDkHi96DcwjUwSWqy376Hc
aRBsTSZ5UWjQuhY7nD57A0pFm/Z08tuwWrKIMoWYhTREAv0C3TLy+x35EoZ8IrDv
rJHhY3tirx+KxM3ssVrm0CcDzlCmWBDimUtHS7BP9+ksOMtNAcnuWo+Gt38jAVsC
qlNoJQMvt31d0ixzgX9/ZtvY55n0q9nXASmUfBP6VXxErqdDrFC2o3x4x/OoMOmx
RvCeNU4Qhbo5vnbG+Jp85jrh8YgLPXPxYZ6xwfF37OjZwHAmAPkuxrxX4lWI/vTW
`pragma protect end_protected

`SVT_BFM_UTIL_REPORT_CATCHER_NO_PARAM_DECL(svt_component_bfm)

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
nnMhIxv+LjpqX52IN1upvmjsWMYu5oumZJEVHUMx1L3OF/0A8s8y1hRpKQg0/9dV
W4wtqCyMTO7vVBvjV2s2oXAgeDiuaaL/bwiRrRq63kcClIfbNB/96IgINr8HbCzD
pDt1H3jmctpErzJhvCexi7pvrfxbR5bWcbaN5ii4Yp8=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 681       )
ddWBSOKdmh6dZ4VjhxGYVKrok9TCqA2/Ro9CbRK9ElXg8RVhZqBNZwOVShQB9wwj
L3U29AshM8NeG3F1TFbuZ/lqlRM/+PKBtjKZV84MObcEhxKUUN+YOpODGFJri1VW
S+96jm6Gld11y2AjM0dtP5O5sIEW9TZa7f2jThMLbPNFSSWX83MBuu8n5wQCekfJ
iM0P9vzj52V7/N0MNgKZFA==
`pragma protect end_protected

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
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
A6l/HItLisgvvmCsrPLKh5eahkxiz67sY87Msrdlh7iggu9314I2m7qrcy1lUr5I
Y/D74L30E60KRPoxlM7kfqmKN78EkOXzxj5/IxDfnJgMlcU7hK/VnQh9uD3xdlp3
8cvg6QuSXjJzs8N6mULxX/gnSZLL+vTxUYiv7vrJ9LQ=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 764       )
L/Q48MFxNEJR69MTxyTfU+CXH5yMZzAEdFQPlTGFSWPyfG1Bo865g1r/df7XbfmY
vSMp74e1HLJOXyy/HRwkc/QsRvkML8ULiw24keQvcocepCAkeWgkeEnYzN+VgiZA
`pragma protect end_protected

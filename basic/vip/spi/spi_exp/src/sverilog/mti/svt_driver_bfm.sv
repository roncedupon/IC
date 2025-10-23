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

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
R6BkFj+k8+blPFZ1dXm7Oo0zQrgmEr112Wz7aROkXO2G3NXnf1DJPAYIoLY6BvWz
HwEK45kgEANMdqVpQiy/nGrLbXLigKUhZYiQ9l2qmA49T64m0Tam4zgoWbxn7mjD
56YHduF1T1De/H1QPvvThkm4YOI6j9PR3DRoJhmNo8w=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 213       )
pjF20v4Oc0grAFb1qTHaKw4MfoyKTanQRwmf86slntaM4wb3BpcEgdoUo+9i1sv4
L7Y0DZx6eN1LL+1VhlquNi0CbuJx+mz2gYjjvj+SVCc07jIwm+JeIPWA+iEIedpn
ubVL2I6pb8PdpmE9GjLtIHt3SU81/Te6UBrj6HZxPA/UO7VumURauPTp+CTG7bZg
xgKg/x8abByfmAtloabSkda64nZhOCHsAd83b07PBYt0zN9RFBDDfr0/vASDiCtp
XyE95tdY/OwYKJmwov8LL+cLAulZHffYxluKYJ7AjHE=
`pragma protect end_protected

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

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
QJL9BoN/oBJpWJhlnndfTQ7hxILNslCZvaqB8U/2ZUKd9eGjRAc10mxmJl9EDCsP
CaOPdMdRowdukacTEf5a4/LrVpwyfMvKLmpS0l0H7p6VkrhU4M8jb81ruE9ER1ni
VOBJdZ30phzjGsjO/5vdWaNok3OKEfpGl7fp1Wrjtnw=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 525       )
iErgjRtYB3jwK3d/FuQKi0d1xO3c1wJdnhFTnUZBy++oIlyfEEDbkiSWbFT3wvZG
oMxupe1IXKpa497VIDsDD2WUBpcRyENBJhvHgfsCGW6EYuKzToa4zjeUXV+I4MVE
xEDum4CL1oL8PcULzjBjoZX9forLiae+LQR9Fla/R2Hq8ErKihmFVLv150syRk04
iZTsktlqtL3TnXH3dK8fcmSpfUroAur6RCxyieYcv9rZJrnqvWTHzmAnxX057HI8
SkI7ah8p7SW+/u56gjibdBa0GrEuWXnd2V/dANVkaosETyNLKe8cwlwKZ5oAcV0G
eBoYi4lHDv1iKkzLBAoOsrBfMusa/KQyHj1PL8b7LY/+hpFhgIlF6ix+1+NqsbQH
ShCnphhM2BDkRx81Zer9Ib3Ovd/kQHhQ8qjwKE4FgSo=
`pragma protect end_protected

`SVT_BFM_UTIL_REPORT_CATCHER_PARAM_DECL(svt_driver_bfm)

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Gqe8Sh6BbBzhWCU5nBn+jmrCiiflhOoqI+QfWMkpR/03Nl+hmZ7Li1jrxRLBSUMQ
Ur/62T7Vh688U3VS8o8VE9nQXbqSUgXEtDSY/qcCTBwa4D/qMQ47wpO3gQc3NNOe
y4KOAUoB5yzpu7i70dwvjOih3AmrpuCawfb3aaBtlqU=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 663       )
M6PaUAC6BsUSAdTxkCrvGQ9AG47rK4iDdjDOP1qbAZwP/Q6zO4dIrpwG0i3sZhAC
32vBgNjqLo4kjFJK2SWMd6zwkQlaGFfeZe7btwpFWzPz09bqIjoX6IcAfpNOuYQr
dYOTMC0HOr/eWpFHDcrGCCegq94iIwkOWPhcMJ/1UUrjCqlOXYK8mX1kgSAG8zLi
`pragma protect end_protected

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
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
d3AW7HaxRc/4PlJMT5YYmbesK7wHVhSlKLx+jv5tE5UU130V8TgGua2F1yW8Ymsb
g6Ehy7CQs+ERWOayrj1VpCpS9/VP+hzxoAWUVIPEWu2vdajc3CGX23FzYp3pfoz9
7pmjwg5CDMRPqceuXTAODLmErMLl64AITj+u82gCkUI=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 746       )
a+gQ+01Jb32lf3SfMlF3+D6qcxUd+TaEYFR/OrUAmLBJV2fJWPUdQhV4SE3YxL9o
J+lSwIoYRHYXjETt2w7TBI1I2s+fCmbEPndlOhfj8QjrZ+KpunvRuK4i+vdg+IK2
`pragma protect end_protected

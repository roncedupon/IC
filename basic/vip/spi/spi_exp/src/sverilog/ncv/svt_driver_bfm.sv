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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
Ezrqk6zGE9C8io+WK5KKL4VLk/N73cWUwUH/9ePtiwHZJA3pDmyTQQnZcLrTE4Mb
Hlfe+AFa7O+t7O1vV35mlIE42Lv9rbkhFqkyis8U0fGh2fXMtaF1Td4xjoj3kHhF
UU7E8BYLb/BIzKvJRYZjfyyTRYB621/fJzbADhx5Z650PhDc0B40dw==
//pragma protect end_key_block
//pragma protect digest_block
NhgVY1WO1DvPc9eTdrrghU1FgHI=
//pragma protect end_digest_block
//pragma protect data_block
gVbLcO6U7JCmDzno8JSNdgl62x5rcYRwG61foMa5RNL8kb4243vx6p5FIGQi7/HG
5stUghWriGrpKUe5JSwu4N/I7kdFhfQJbl9QNK3uAo7l87c0LdHF2mq2Jq6n8GCQ
krV/XEsiLYe4KNDcxN8I0II65k/GT6dawCiB8gG+Zn/8A00TZMUVa02UVHsCVCxV
Tldv9DhxbDN4hZHIWOSEmMqETsGOiyH6rOvv7lCe04jQhPcwLOXhnkcfIjy+NoQZ
7rVtAhgafEZX7mE+JBhxP4O3y0aaGhsy2EqzAoxf0bjnEsW6wrQOKnwssjxo6vsC
+75KskditLf2q8gBMrCUMVKBIPA7AAdxGYQLCYS1mXKkbDi9+6Ik0cySgJXyIz6y
8UiMXSvrVwagc0r0l6WxpZCXPdsbS/b5FiEeuIFzUt/XXIAgCueQ4mcoTWAJySam
oYLdluhWY5WaYzgYura9NOO3v8UME8LU3RVHS1vAE4/kuY4AUzV17OU4StdiEdsW

//pragma protect end_data_block
//pragma protect digest_block
qyHlpjUwu56fTjFgWUplfHbw8y8=
//pragma protect end_digest_block
//pragma protect end_protected

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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
9aXb/qsWJpGo4Uwe/9CpHCxPPYhJ/jQE/miii0VRPEMU2gnZFv+IJqSCIFGoBJb9
F3KSCq14KLn6br3TCKAr7tJ71tmX3lCHZFUf9lQqOYkEfJnTLLHLJ3scMj/TAt3c
EDn3p81pfwGKROzAW1aWbCl3L8IwtU+Cxiuhyvc/7BYlTCvuxQ8ZFA==
//pragma protect end_key_block
//pragma protect digest_block
dnEMaViUauSSHVBVdLQT3QVzsTw=
//pragma protect end_digest_block
//pragma protect data_block
MTZ4HIxmL4J4vnl89slvw4qVSe6BC6+toFPrMr92gDYHQv6WqT67y4VNZMQd//Bf
9V8f3P4pLVOXjcYbPRs4lX/lLuitjcGVbSc3eFT14d+wncwaAiOWGlO1dCT3CYIz
oL0vuAqpRTjaMGAaiAfXT0oPqOXJ5dNXiDDpxRwW2qBVnVkAiDlRMZTyuntiDlV+
5zt915LlMVfaBfU3WqZmiI+2Dsald9HR7qAvKvGUKgH50fDALOAxHmdeOJ0IvYf4
AXdspJYPNJbx3lBYP5W1VvwJeSbV8Tz1p7VvQnnGi+8jjM1hANqb05DRnx2R6PxK
h68hag6MufaBtG6bDdYf15c5TJnWiWIlkVUCoUegIrpMDkmRLEMP9yeJYDykw/gG
iFRU1/I1B/XoE7PvOWqmlikKb4lskvBIdD1jPtOCFXluFl3vql9H0jBBxFPsbK7O
aBco1O1zMNVQi662R3Tg6djsR6E+09jWBZWWd6OA8KLMyj2EzJmeG3UCoC0q4ut7
bdUObmQhj8+Dg4DZggxqRQaUWjusfPZ9AvQ3ciqid9Mftf26Eih8TvNN99uvTA9j
PHeQLPctRcl1bNCpUQ3hxJQQprsm73WnwAaUOeJuV4Y43AHwX7whw5Cs0qQ7tcKS

//pragma protect end_data_block
//pragma protect digest_block
PpmxTsNB/bKvBsVJS08z+sKojNw=
//pragma protect end_digest_block
//pragma protect end_protected

`SVT_BFM_UTIL_REPORT_CATCHER_PARAM_DECL(svt_driver_bfm)

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
lq5wNukYkLlB1/hBm4HFKiHJ7oRmLTtp1yW55F8k++gT8fFXI2CZhMnUT7D3T0js
XvaLe7/f8xUjlFgrYeI8kyMKgXw5jXaYoz1M0V8f2tcNJCX4q6M+JTet5C1ASr9+
V3A+rWHhnC7ypKFVkTZmXon2jFf7IIvT8u3NrH2rPEGukuqrFw4seA==
//pragma protect end_key_block
//pragma protect digest_block
x2bl5B1X3v8nAm4bTjf7875XfiA=
//pragma protect end_digest_block
//pragma protect data_block
snFJWMLKbrT1UswEY1xXquzPgWZqeAaJ9nppqVAovnl6CLsOJhHqwkT4Hk7navsu
I7nzNzkiOj/g1ZviutKi89c1rzswNTddpYyeOBXrnGT4IApoBhVlFeh2NXazEVy7
YoDHhPa/IoB9+Cb3YVvjUmqIlozwS7FVusJ385F7T8kPKAabHFK/ZWKtvv3LZXcy
kV9D8d2BGnpXzPM8HysUhWwGsJ/uwNCP+2YhaHqD0zd5rsGOfFGI83C0z6b/5M8D
IDUo5wN+tBWHAwL2oIqEju5AiZv6++h/HbPAt+WwI7cRiov8sPpg4fdLuNuVfv8R
GIkPnfDJh+EmJ2OZUG6FpWSF/0JKbskhHNOIgI2QKAI1Ws1CcnT+RS3TsCfxhbHu
dYVVe/RXIFieaRZzUslFLg==
//pragma protect end_data_block
//pragma protect digest_block
tHUxeJu0X3phCpsjHbF4ezuNNg4=
//pragma protect end_digest_block
//pragma protect end_protected

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

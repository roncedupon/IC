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

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
hugsTfBy22DbE78qWUa1ZKUFp73W5y9oXZeGu88+M/ztNUj4qlqg6Ay+2PSRd/bn
IMFSv/KVmUlnFq1IzPj75QVDQ9o/NoFgNK7o3AQOTmmCzQeYbyjFqo5AU9Yz8v1h
iX40dkEnjN87cQ6s0POyqpNVArSXj41GL/ocz5TCEiY=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 214       )
CNn1VkEo/+R+XnrN5mFWJ4CgQp3rxJKJzabhyLSY+88knJTzljmTNNUHM5xzyXUW
NKnDL6FMDKz06NmZs6F+NpLD9IMpxj4Tlb1ihlBRvHWoMxcSyKeCw7piE87wWkh8
IOzYnbT9EODuJqau53MPWM1WeHD2ve2nFN5dVkbTnWxGzN+DmP/OknLdj6UlYWKl
6nrCR0Ysfvti0N4O8rCgaq4qsf1bpwHe6VDQLMQb5sNNOINK8uWyrDFX3TbUGgE8
27qoBzgfIgcwz8q6uyJ6JfHNBAqQrM5N59/xExoe0Xg=
`pragma protect end_protected

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

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
lAqkiwAu4NDorZ4SG/++CiMHEuyhraSJAVeUBRPS1K7vv5QtD9de1oEY9qD3Npag
3zPtHtmfKl8cEutjyyT30kaV+/eYjIdBsl44kTiOc/jH+TEw47sGabryC1O0X1ed
jsdYdEuzUuvwA285Rkupl0qeuaspriuc7Xra2Vl3iIs=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 529       )
SHoqDPsGP7DxO0w36fBEcay/pRJ8BpNcvwOmxt5H6I7UjYwjeTZYZKO3xHd1OY5f
kAddRXm+wRtAsVQLhtntWMxU7pu29656j1FFCNVA0T5lgTk1QEvT/JgGMvYcweB+
NTUlLFBle3XlZRc4+MfJwWYnmLUwuVunbJGwbZwYxAHNyMqX9LwbcdWBQI+1oUpg
Ag2M78Wok7qpEfFRl4HPfmExR2+61p6JA7UJkwhTL5HrswDJ3b5o9eR3S8tf5/E+
2agJPsZKGUOsLNIGgEOfxfn+QPSgeW2uwgstciox1ioFd6YBTMarZvYnMTyQqxlZ
dksxFgNV7SO89nfvjyCiqxM0vXl89Az4iMYp/9ZQTLXHaS5dLrU0BCcrBsjx69eE
j+HNlK9Dk/zPIoaTKrOIe1gOLt2PzeeT877kwb06o4k=
`pragma protect end_protected

`SVT_BFM_UTIL_REPORT_CATCHER_NO_PARAM_DECL(svt_monitor_bfm)

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
YBzkjSULU9fqm5xuDffKHCzr/bTndwnhP8leinymprD8lBIHhXYQWbBrjxxl7PQj
p2OMGBBk+P6UnXgHFCIgy0IcTl1iSt0+HOJYdBjrMaTk7MXJPyO3Qf2liogTq5Ub
MWKDBGvPUgqJBGKynflCOnT5WhJgDzRQlEs+babP5Sg=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 671       )
8KT9yHxc5TM48PvWdLahSYhkprhtp3DTkE3jpzI3Dtf7TFk4QBSD6x5tTW/TEVKZ
412/55RuU7iH1woYAPlLLAKsmpt5WmfUGKGtLhQ7CqnabAmARdyoGBgIy/ZnKEOU
HeSn9YVZxf/x43M+EE7lZrzZ+WHsYUbGrASJOo1fXXWYcFT5tI2XtHVymFtKYtZi
`pragma protect end_protected

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
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
cuE3c2V2Rc+IIjqs3LJoElEhODIa0MAQvY2nwx3tExYtlFlABdk+E7io7PO/NxLh
5pdUnsJR54sCJ9QoAG5FiFTDiO7bfvoHKQkx9r0+6E1S3toGKUrOYx5L2fRxNaSE
riYYz2veum8EpkwvtqAAtvMTgNANH0XdFQVIgKSHbcA=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 754       )
faf5IVBVhSLLhIxktoZUIEhMIeoTPFggwszV9E3aDY2onMw8npk9pvrU3S8lhLIa
ARc+NUfBbrFs5hv59+wBOyfQHKChFt2N/IuFrcG7GXlbVwzi8BkW3WblPUH5G6tf
`pragma protect end_protected

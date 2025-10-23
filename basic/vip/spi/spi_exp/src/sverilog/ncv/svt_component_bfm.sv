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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
smMSk9RFwkFGg36gNKQxhjO6IC/a5nJJSRIVkfv7XXt2gm6lHcr1oRSGmhpojbpT
k2uRjwXWDjRzZys0y5Bw8BN7naAGqIiRLo6n6EkR5/jgL7FZ6QGc81DDwml7mzY4
Roye5jWFmXNxkU7hjxxujBhyEmADRwoXiB7JM4Ew2z709BMyxy9gog==
//pragma protect end_key_block
//pragma protect digest_block
xMO6DCZOxwuU5kyewMU3zZ5dUWs=
//pragma protect end_digest_block
//pragma protect data_block
U6y7tZkYL51/xhs/oxPnLubSjYjtnxwOg0Jmkr/Jmsg8JKDjSayjvCfKWZeUWbBa
THF2dXko7JTFe63/qc+3k3OgIaqWDyN7nf7Nkv5TbEr6xTDKlHp58GhbThQ963e6
u8haIbVr5t+rzrgONxMhUh/+3zhj/gu0WhdNDejTihYr+nOoDYRtyIH/CxsrNb1R
saRJObYIWVSOeVYtQCz45a+OliR0bQp0egc8x8XkZ0Z/dSzxQ3IV6elVUH61FfCj
CyWgWkvXAEwUta3+lnNv1E3S+9F5eDEmt1m8h06Ae9YtUgZAL+r1IpC5FlGk0peA
sgpOWGKFrz8JyIwTAJ4qlmY+w5FpBxi66GxKibSFZW8ZaceoK3x2c+5tb27gY7fZ
EP5IcQlh7wpH8rnh7dUDFqUU0i+4O1awje62NNknmL7ymYaQpz+8ikV01G8qBrPl
EHuRzmZaRLylfNggBSBOJ3AzumRlg3tD/4T+Lg0P7eo6Ic6fFLgCCZ+oDx0do5FP

//pragma protect end_data_block
//pragma protect digest_block
Keo69HPaYzntdpLleZI7nl0HLtY=
//pragma protect end_digest_block
//pragma protect end_protected

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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
eSv3XJj1e7/WJQmXO9g2q3xqK8z0AsYbTF3i6EY2dQxKlZOfSUjBW74vKsFS4ula
ovA9Fg88TLVVr6r7FdRXKzjbOlapD1/Sfl4TcOj+2+Ts+nVxNGSiCWIWLmy/riv3
W2MKOoGW4LBwHgMFQmH84M5YBe+OXpILm48ZxN6M3fMIh3/hzs9zZQ==
//pragma protect end_key_block
//pragma protect digest_block
PodF/SLDEFyFuShE6uxnImstdrU=
//pragma protect end_digest_block
//pragma protect data_block
LfOU/e14SkRgobjdHmTGTex3E0Xre8qEoZEyBHkB6oHMrX1KWIEGVeEjC3pK1Sif
vMviY7gw1p6vK1Auj3AvggnmiPHwdgW0cC8A6UHPjt8YN8//Qg2ZDcLIzErzz+MD
wsUWara7HYRdB1kinwBKurhf+TzshTtE5hUyStwR+ZVEwaKxmLl5v3F4HmKGWnZv
2sxMeXQl0xmL1eoNe1DkcJrRYKw3rl4UQgCfOFWJdin8ZS0g0NPz+riEUxeC+azL
hCWWzwhy6Ieo3lobs43xiflqHG6bbpnOtf6Ep70M9xS7Lli6KN8iXvu7L3/0/NXb
0VrTU1jQwGzOhPRQ39YhSGhGzYu66E0NjGa09317YjrQiEFrR/MtI9uqZkjwWv0S
RDp6KpowMcgSnGUDDc19RopEAHCGO77PtKgs6Tno2/rhygA8v3y8uAuFIap8Gffn
6OqLWlHuPeT83s1YXunWtGargw+nkYBCGSGrd5FfqWITbLyX41v4pfX5CReMfnc1
wsTQdHfRYmf5SuNFANZc6yH4G2UI/HdLGJloAsBhMGN84rCJvs9tUryuLhhsT3qx
+X7Od9D540GN+T5y/C6/+dQYZaavdyoJ5cs2IZHnNfDf3LMJRZxa32SaPK0xq57q
Y51SHBVVDAik5KajHSG2RA==
//pragma protect end_data_block
//pragma protect digest_block
wtE1krUUC10l8QLeiy16JcliFrY=
//pragma protect end_digest_block
//pragma protect end_protected

`SVT_BFM_UTIL_REPORT_CATCHER_NO_PARAM_DECL(svt_component_bfm)

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
OWFY7HGpx4k0wlcEVmvd6WWEHRVHg4csDeSXlkH8GMnWr91paPf7KqYSAS7/nWsS
7NvDW7ZWTDpmKWKbtL6lc8a5R/i6Y4kqG+ewWNt2+hP7p9kQPbCpF42hW1gVkFss
M2OPBB/7tE33bJbGBa9JUHsPirAr+Ud9REsMvF2oU294ms/rkWkEzQ==
//pragma protect end_key_block
//pragma protect digest_block
b5XAcjQ5iL0TWuy4sBEy0pW6fs8=
//pragma protect end_digest_block
//pragma protect data_block
/8MhXj4feVI5264jk3f6puGiUQ2uMsHaT6dDVl/uOuHOZzAimBRSY+nviNdgLfn/
lnQPNdrgiSFN972I3z/+fk95Wy7qZBgHdeOjD7PvAw4y7X8txGIJRZnw7CGmW5sa
chji6Yd6K6aVXfXehU9ZvxKxtjcm5u8o/ZdYmtXoF+24OAZ7A7PMqFo2p9bedsrd
Gk6nfxGVbU5nAB+/5X7jndX/gxQabS56R86NmwfZNKX3rZowIAtGLwUSk5mLedu3
8JM0sYDBsGS8MqeL3eGPwA7A0bOTOZ6M1Jd8VPJHImnyCmCxeC6lTVxq6Pk8eFqA
aocRfnFOwzQ6PSGCMffnM839zLgl6y02Gy6W/Xe22cCUltmrHhEPQ9IK4WtDyUob
jgHx8JdyK/9hwmdyAVaEAtrPMVi1deAbTihdVwaT3s8=
//pragma protect end_data_block
//pragma protect digest_block
IF8PPJOy6kz5joEnwqaDr8sD2A0=
//pragma protect end_digest_block
//pragma protect end_protected

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

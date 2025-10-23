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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
GF77Ee74lcsRGNcHiPDNNlxf68FfDjzHDkRNyOzVJplPWHovUnIg61wtdheWBzTl
4he9FHCYgdIwfEd7LBAIOp1rCApKf6LFSeVcWdO5PUd1VJfdQW8OUM5vQCznKOJ5
qSkS6/tWtJLk1PKKFEeXLiQp2nWlde9fseAGkoC9mFwi4ghhpZBVuA==
//pragma protect end_key_block
//pragma protect digest_block
Y8eMtFx/w/kfte12/p+4GgHdCqU=
//pragma protect end_digest_block
//pragma protect data_block
wTX1GP56/Oi7+G6qAagU6uTmCGU3Xd2mVj3Oov/vj0thKtlQKAGoyEDWBmrh0Lec
jbIh/Xnvs2zEpxUiFEvmJtQTxoAIAbsmMC+jXCrZChBNJsRA3Zz+v9PegLYdOyqw
2USltSqMqg2Fyoi+crH3Qf4HKLSlwGmTD1t3GjFp0Kn3+T2PZQyTEw/7boA2AZCB
FXAlZczAm94QyxxY/3j/hZwW5Z3MAHSg7m8/QrxZbfhFVd6KEPjfH3tj/bzgwOV4
FXthDj+mpt7EVR/7udEYR71Yo0vsFxsne8+c/nN0QTjLbaQkh/Hlg9qYIw6VXBqU
ZQztMiTw0X7UUkE3ZJQbF8ryzDePqE4ZLKwbOhGDeUjq+x4GKXL3xdSAmJ1eOweg
rMQe6veWlKvC/6dGup2selKddrKQLErF+bQktjbldfOtSA0IpnFCzQ4CsGHCMpji
k6We2bpEUxcj5gjFUW1Djv5KN/hOcLV4YGFzgDle0jEKMr9SNlooVKncoCpIQfBD

//pragma protect end_data_block
//pragma protect digest_block
az1cn2ZQluu4iYjbUQFS5RrVTew=
//pragma protect end_digest_block
//pragma protect end_protected

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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
I1oYef4TM7esLnhe8exq4qhDeauc1XnR6bpYRkanLLy7O2hFPJdHD7cmuHWF4/dC
/WZLZ688XdP+qRnNn15V0IFLmu4/4MHrEe1lslDe/syQKhrXvOBtomQnyFSAS8GQ
vOo3YcLUibkTjaD+LG9RXNDsZXjub85n9Hd8sQwplpUnyjC0b0DVKg==
//pragma protect end_key_block
//pragma protect digest_block
z27d3MCEWM2rNDXhgdohuOY7UmQ=
//pragma protect end_digest_block
//pragma protect data_block
NxKulokZWMMlYhfniZQkMOAKsR28EacyR3/dkdGFmeVEYBqaNTAyLnoTG+5FJkd/
zyPTZFSZUHcAfQJ/NwosMclA8VnqaxP7qIhjZh/fkHsnjs11svrfBXLb2I/wM/F+
JNQn2uKhueyuoZsOjLwmIHWh6/2JWmEj5At4jxaGxM65gtmm9jrEaDOgH3wGsaHW
Z/wxNFjxf6OJyMP6fe5tVsyMSNOd4HdjT77zQ3VKP9gUz2v79xRiXjObvLEfLdQL
8+c6U3rTJEZ3Aqu9Xn4EciCUylg34FMZjg4iHs7nku8S9Jbdvvn5BZ/C7/62wNwk
aY0Oe2hvUIDtiqexbW+Tb0SGko34LF4DkeQerS1rzC/wPqeJfY4z5/9sXe2cgDK5
iSD+60Zx80bKixR5Y2+cUgsNV3wur79PXTFX/sVgrbGVrKtG9JD8HuQHCrOM9HLY
OQxVGyqd+klMdfe2MW7zofQW450ue/V3e0g9xyQj9QGnTvT1wCIp8b6EVQnt744T
0z7Z1DeWjpBiYaEpstMM+ng+rIza/kGGx7TooTQhT1IfFj9biyvwi9NMCK99Z8W7
tA9/CnCPetTiZvRE8YTAjUbl5VmmGary8zLTebmAblsCZRpAAYz9kolnCPsC/10n

//pragma protect end_data_block
//pragma protect digest_block
MYdlf1+WCExdExu3KHFTKQkqsAc=
//pragma protect end_digest_block
//pragma protect end_protected

`SVT_BFM_UTIL_REPORT_CATCHER_NO_PARAM_DECL(svt_monitor_bfm)

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
pEOGDj3k79wEh2XUnVAHNiW/Am7Bi/uF+daQhd616bQE5lMQnBViCcNwn4Zbsvlg
d9zYFBEjxIG7soZAtM27jYSqfh1aWzCzNxWCuhE5xjMU0UPeCHGcMTyu8XmztCkY
ORbANqcEMgwwND+ZNPsNZExhSrY82Rj4kRY/+/NhQNIJSqjuuu17CA==
//pragma protect end_key_block
//pragma protect digest_block
YTzzq/hSXzaiM38pKSjQ84LNRME=
//pragma protect end_digest_block
//pragma protect data_block
3jMU3pfN7w93ZaH4JXJa12D6uRI3TKaZy4Igq+kCoAUcL7w8rMWgRcOktBsYybti
YexbCTPL+gdpYrBKrUglCa57zVS/P2wn16OhGwyL0Kccs84Dwt7Qy6NK8m5y8UsG
KAGHUPSnMGOBKfyUtod1zq43I3suuWcciMCOBhe3X66AFLYw14Qk6zZm7lpsGSiW
6jkraQ5qi+raAdS5mGXR+97EHQq1suzac/pgeNCpVh4HYDUClpzHYt3HQam9c72y
LoL9L6eOPwo8fQf4cZ1GYZgC7vtSOhytc4ozesSqhTBE9HRC2vWnJSHeViirFuj7
ehxRRdxZInP3S1qn6KU4G2N2rijGneZrKZL0n5DGXUziYRjU9nM8s0uL8ZdO4kjB
ulhTWkwjvYhItEr8qzSnYBYOtv4WUPmMQk+As/tCkYY=
//pragma protect end_data_block
//pragma protect digest_block
YiuVT+ay1Y+CTUPPHzzN1naewdw=
//pragma protect end_digest_block
//pragma protect end_protected

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

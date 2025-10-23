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

`ifndef GUARD_SVT_MEM_RAM_SEQUENCE_SV
`define GUARD_SVT_MEM_RAM_SEQUENCE_SV

`ifndef SVT_VMM_TECHNOLOGY

typedef class svt_mem_ram_sequence;

// =============================================================================
/**
 * Base class for all SVT mem ram sequences. 
 * It is extended from svt_mem_sequence which is a reactive sequence.
 */
class svt_mem_ram_sequence extends svt_mem_sequence;
  `svt_xvm_object_utils(svt_mem_ram_sequence)
  /** 
   * Parent Sequencer Declaration.
   */
  `svt_xvm_declare_p_sequencer(svt_mem_sequencer)

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
  extern function new (string name = "svt_mem_ram_sequence", string suite_spec = "");

  // =============================================================================
  /** body()
   *  Response to request from mem driver by performing read/write to memory core.
   */
  extern virtual task body ();

endclass

//svt_vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
E6gmPJ4HYoCXcp6V/pxHu6ScIeUfpsSNAQaT1uyVbvPgRrUDz349uJPJriv0pcs8
Vptad1ek7A4ClcvM18p7zdQQQO6bYDONbkOwsYIJOfucyO30s6anUdGSgkRNu/9e
sEAvHCvAkHFRosAmG/0q0jTXLiZfe9CzNt9DgfzvlEw=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1103      )
RKS1fOfKQL45EQzO2lOS5ng2hWmgVI2haw8sdlYkh5m31aNS8ZkmSkZbTN1iCuQV
hdv3Nbi9mgpgoiJgCcB1yM+xQnWAxULC1akDN23BBHHms71o+LHX8O9DVZkMcMSH
4kUpoT0XvLpdYs0gbRpzExJCqVAF/fePrNvWYw28DRA6ovH1Y30XyABpE0tYwM8C
cRz6mUXUkV1aCedfCHk93BE4b7VD2kFy1PYPMKoX047GHXmlSo5zj4ik/OQBB0mx
Ma4SenjybwtYmEazfltoOjpbQJLip4kDwX10oOERqr2I0dCQ3U0bUyvDnGU7DKPN
p6dB8dHzW3IiGQ1madL15QdiM9N4Mxcf0775FY2ciL0Gh+ep5yH6skWkWtx0RX3+
qyJESdxnbxOnqU8syaSA0wVMGxUaj84iAgiu8kpTJAQ3ygEi30hDn0o4DQMx4qWz
T5Pye0obBMBgWQNShnEPist0fEtZThirPsNXSrj4N1Xrz0UDiOxIpX1IUrhrO8VR
oWioG7cHQfNT7kPf9OzSOPNfr9kHDGiQV9YGAjqeSU3y/Ih7dxPgd8j3C85gOaCy
BPwg8o3DotqnciK8RQn2ny+n3YgudDSOrvUCDD8uhVGP/i+rSCjT2WJfRvoMrIR+
0gceX07pKR1kZcDs8SzaVXqvy9cWzDr0bBEGk6s7Chz9cLfI6CfZVs7u+OZ4F6x3
v8lZpr2ZNol6dnnqeJ8hlBHlBLaFtD50zd20G4g4Bv4qafB5m3m6DVm666ZiQvdN
GBY1nDAf3s1aJPADagGeno3YNQ10icD4hcSCm9TLQV14lVYuiCq0eA49imNbxtQA
lY4h2OVKFWBw2/MFuMzCsPcecNv/fRwDWT6eWqzh0yMxPN9a1ddB31xYZzXFmZvi
Ze2pmuHOoxTJRjlJzv1EvS4ZSTKracPaYZb8ybb3fJq2rD2E6o8itHOr6V6EN3ds
DI8iPsZQIUdT9AbIm/6xXGBxrptkf6PJ+RsvWWvoptOI+XuLRcTv5pzMuc52XBv4
gcpkZIC1lIqawLr7QAcdVtQp73ZgoX4ZRpGsLTt7zosaVfhML6qT5sikSFIOzDJT
NfI6C0bw2XDVzWj2vyb3khrZNllmcZ1JQbTxMA2d7UyTdG7BbvMtxpBcRIhna0mS
7KJeIUKLuxNfk9maR0tQbsHxNnbKQak+6pC+/yyJThmBpGxI9moBHfuY7HHwasYZ
nuy0bzPgTPIXULS2fXUcuuUiUDQyh9fN4UFSWiYyYalSjYF1b+X/TxEVzNK4ffjl
9IyvD7uiJND3tFGOZH2Br8Kxx4t89S2EymKi5RmecWFXLuxS5R8G9IK/OTF3RwfE
Bn9uoe9kxU0vC1kJqY8iGUim0ocJdNRXcQ8Ydxh6deFcOghS89AChyZM49IGIKR+
ub+0KSs7nQQaysDbP42+AuhON+uvMMxBUxZjtg6m/D25SRibRKt94cyqjorn2TjH
`pragma protect end_protected

`endif // !SVT_VMM_TECHNOLOGY
//    
`endif // GUARD_SVT_MEM_RAM_SEQUENCE_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
oIaFIibi3ciz2rIcelqvNWEiELK8LvqxbNNcHUdXj8gMaWGSNd3OHX9F3gUeiiYE
EDHUVEiF9E2OeBUbxTgLqOznAxPEJ77oPvf54jsw+nCKq8YGez6Gs5DtK2OlEXod
YXMEUW/93ED2JnNVnDtycDqtLYQpRclK2OyVJVIXUi0=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1186      )
N+Pzb4kjTXiXgUj4s02H+gkbz7EQMNhS2y4oei8d3zFkv9UOoREEZanII9RPQ55V
K3H06k4SKviJH2uiq7AkNrVBMcwUBDyUYTM+CJSCsWIm7uRlDXF912Ce9S6knPPM
`pragma protect end_protected

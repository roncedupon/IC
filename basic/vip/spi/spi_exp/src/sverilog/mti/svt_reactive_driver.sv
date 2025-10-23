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

`ifndef GUARD_SVT_REACTIVE_DRIVER_SV
`define GUARD_SVT_REACTIVE_DRIVER_SV

`include `SVT_SOURCE_MAP_LIB_INCLUDE_SVI(R-2020.12,svt_cmd_defines)

// =============================================================================
/**
 * Base class for all SVT reactive drivers. Because of the reactive nature of the
 * protocol, the direction of requests (REQ) and responses (RSP) is reversed from the
 * usual sequencer/driver flow.
 */
`ifdef SVT_VMM_TECHNOLOGY
virtual class svt_reactive_driver#(type REQ=svt_data,
                                   type RSP=REQ,
                                   type RSLT=RSP) extends svt_xactor;
`else
virtual class svt_reactive_driver#(type REQ=`SVT_XVM(sequence_item),
                                   type RSP=REQ,
                                   type RSLT=RSP) extends svt_driver#(RSP,RSLT);
`endif
   
  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  /** Request channel, transporting REQ-type instances. */
  vmm_channel_typed #(REQ) req_chan;
   
  /** Response channel, transporting RSP-type instances. */
  vmm_channel_typed #(RSP) rsp_chan;
`else
  typedef svt_reactive_driver #(REQ, RSP, RSLT) this_type_reactive_driver;

  /**
   * Blocking get port implementation, transporting REQ-type instances. It is named with
   * the _port suffix to match the seq_item_port inherited from the base class.
   */
  `SVT_DEBUG_OPTS_IMP_PORT(blocking_get,REQ,this_type_reactive_driver) req_item_port;
`endif   

/** @cond PRIVATE */
  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************
   
  // ****************************************************************************
  // Private Data Properties
  // ****************************************************************************
  /**
   * Mailbox used to hand request objects received from the item_req method to
   * the get method implementation.
   */
  local mailbox#(REQ) req_mbox;
/** @endcond */

  // ****************************************************************************
  // MCD logging properties
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new driver instance, passing the appropriate argument
   * values to the uvm_driver parent class.
   *
   * @param name Class name
   * 
   * @param inst Instance name
   *
   * @param cfg Configuration descriptor
   * 
   * @param suite_name Identifies the product suite to which the driver object belongs.
   */
  extern function new(string name, string inst, svt_configuration cfg, string suite_name);

`else

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new driver instance, passing the appropriate argument
   * values to the uvm_driver parent class.
   *
   * @param name Instance name
   * 
   * @param parent Handle to the hierarchical parent
   * 
   * @param suite_name Identifies the product suite to which the driver object belongs.
   */
  extern function new(string name, `SVT_XVM(component) parent, string suite_name);

`endif

  /** Send a request to the reactive sequencer */
  extern protected function void item_req(REQ req);

`ifndef SVT_VMM_TECHNOLOGY

  /** Impementation of get port of req_item_port. */
  extern task get(output REQ req);

`endif

endclass

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
CjnXSZ/GcDyp1uwe9IRq9DgX2ALUDsFtfU1vl5F/vMHYn7YpqCZMLSd3wDNopGu2
nvSp2p9ybaHzuvgJYeea3uwJiZB2QpORsiUU+REvp91TDm5dRTyb4QgVKckIHdNA
bEkvyG4mIBK1f1DuSBLWJ4FtFvY2KKFbWanAzHfKBQo=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 659       )
H014FtkjM/JhUFv/OtuqNz1xKzsoAq3gUzWQGXyaV81SaVWIfsO5HQht/AAV6eIO
0I+elW0LKwYm7qrw998iMqewWoY0XK8oSKu2gtn2aVtXNifZ7qHJAEBYPAkHqB4G
+9dwP7mFsJTdbBSts5y3S4PUkssBWKgPQixAFiLh56oJWANrK+lYNiztUkLUvW7S
ZMnR78uk7eMjpx8BCfk7e6bc4FSOTq679f5lWifyd7+JfrRDzbrlSbmb8ifPX+qE
IUV642SEvd4cpERBXLl9/o5YJmRsjrtTa55DFalo8SQg9RH7fGsZGjrCHX3kBegl
nhXUimXTK2ruaVIzO/6ZKNni2OHXdbHpgiEFXzzd1o/ZwKCgurxe5ieCXEqlnfyf
qMPbHYQVGFbaICU4shDgIq3gOPFT8OyCGIv64w6je6JUyfepn0lFbDIdmARM2PeL
CBnhgbLVM31VCyLoJ/Vgz9i8bObp7JdIV61uqrgoCU6epmxppPTYr6FmkHxtLaxE
DbxM1plyKLYhfvdpuJtO8J7SZFY6QhBWE5oXRhGD0IbbO7qNsNJt1xOJ6zwpi8Ov
GqaCGIvBHNERbllGsvJ7DAwzTt6WdnElapDibJSAISkWZp8k3AyuymVkh5ke+PdN
D3BfPn7q5Y18nMoAKKsC1K+89ZImmygWj1QgZbMQuwb8bUhuv/r+xOwpEVJLKOxc
Lhp5cjqACsWE8fzB+TMxw0+cQR8MGr3R0Q2E3V3saEZtH4SvaNdy6mDY2Z+NoM95
dKGX7RFHPtmZBz1vxd7X+Nsf9cdI4rGU0c7+Q2nbt8cyQ1677SoqI2ATzb6YbMWv
WxBFQencs4swyOcjMj5hO4ceUq4qXmMjye8wFlgLCy3H9FFjzyo47Ojf0m7l9Zll
`pragma protect end_protected

//svt_vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
j0upKbMi3pL9iyBqLu0s8RELpAK7bEBmWha6KsXxb3IRHRqtRTA33crHB90hKqca
4F6/pEkIl0wLxIKi+1j25TkUhDFGRXzsvu9fjUKEos0LXezemBWLoXGx5tG5w0l9
uuBH9NW2IIvc3USI2xofemWwvQ9Dw9Oy0yq4p5ZAJGQ=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1395      )
6aT2YRfGAjIfPBxvcr9fe4JGAMq+lBpwHs4NZNWheqAsF3yMEbnnBruHZ6dCUQW5
Hw05iuCVb863nFptT+8qk/gG6diFDqO07IYZr9bzdN2isG9P9U4W2f/foAsliCMi
ew8CyGCjS19ADLYJ4y18wG0YFeFO8B2aAhHuJdzeB3X7RdXjGo2KMaaWElC2wfvw
ehs+3cvm2P+GrvliYdP86CwLyRw6bM1ExgcUnrjk89BuvU3tmMUqphe5CrUMSLxZ
J/Y0U980ZGwFUFC7bj/hZx8L/ALjamol5mx2VcFJEk1VJ6f6kQhIcpz1ywZZ/9MA
WIe+LRaVDSJwvsORaTO6vPgBUHOBiSJsji/o7tbrY0UfQV3Tyf8Oi3YCJkKu4Hal
z3yKSEoskuEXabF7YbSIr3PfqvXmGOKFDyf1c6EQID9rMGOJsnflMiBZZJQGbZMU
kTDAAmnGWFASrmA/5ZSxxEStC67TZPy5gTaM8RqCoYYLAPZ+ruc6eaqOq/zwmEHk
G2AjY8dY4t1A4T+Gt4qnKP+/FpBPElSpQFBPNyYnuur9QztdeAHdVl/oqtTbbo8E
zhWC0tr0DTXMl2NjLrgRCsaCqnOgXFQLQhF0+PDQzsUoFpVfR9snubv9zeBZQ1F7
yCJcuveuLn9ELcxUw6SBpmDiLvvBMVinLdISPLvWCWSfSBT8yk44Dhb5wFp0liaR
RL8TYKBW9gW2FVk6zvq9CmJxqiOXLPGt8tDswjA4/+tsKGgCOnKCT5quAbNANJm/
RQij1u6cT7yc1TEe+otPgWUjMFn71c0jBPnYdZDUqMi88KIInL2/JISGDOz3ONzc
UY9pm5GNN7HrCqsHAnxj0u8VFNgeqotxYhXjBIn2cS9U4BvsJJb3ozI3wvzh+aqQ
aVQKzA/nmTN7NdROYcgvk40dx/BsqolIWKNl+7isIOgfbFJZk+ozo7Fcr12wlePd
9jtR20P/oqwSrRRslVjrpaPhAXIZEkj52JqzYfhcZTM=
`pragma protect end_protected

`endif // GUARD_SVT_REACTIVE_DRIVER_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
C79K5Zn5gVZroEIbl6Er/ky7T/XYFKu7Yv0Pb8nHKfvCWNY2zUmT2v15c+g8+I9I
IuLkFQ5xVUslM3yJvyOmeA2yIifYrrqSt8my2DbFF+20rzbQBDcwm49M/lEZmXhj
ZCMLmpI3ZzBBU6z6K9BkSNKiQD34937TzU/DGiij6BI=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1478      )
aPUHlAiH9x6kcSQcloAvZ27Fa8Vo2QvZwDqEaFYU00hbVEbtO3DjuFFJgoyTUpf0
ObL+80cP9fbzlY1oU+vTPCR0yajkGjgctza2WALaa+8V3VuYGQHnbpzPeOM0Bxcz
`pragma protect end_protected

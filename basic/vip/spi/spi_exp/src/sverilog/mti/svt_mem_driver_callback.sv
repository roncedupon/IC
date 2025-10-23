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

`ifndef GUARD_SVT_MEM_DRIVER_CALLBACK_SV
`define GUARD_SVT_MEM_DRIVER_CALLBACK_SV

/**
 * Generiic memory driver callback class.
 * Defines generic callback methods available in all memory drivers.
 * Protocol-specific drivers may offer additional callback methods
 * in a protocol-specific extension of this class.
 */
class svt_mem_driver_callback
`ifdef SVT_VMM_TECHNOLOGY
  extends svt_xactor_callback;
`else
  extends svt_callback;
`endif

  //----------------------------------------------------------------------------
  /** CONSTRUCTOR: Create a new callback instance */
`ifdef SVT_VMM_TECHNOLOGY
  extern function new(string suite_name = "", string name = "svt_mem_driver_callback");
`else
  extern function new(string name = "svt_mem_driver_callback", string suite_name = "");
`endif


  //----------------------------------------------------------------------------
  /**
   * Called before the memory driver sends a request to memory reactive sequencer.
   * Modifying the request descriptor will modify the request itself.
   *
   * @param driver A reference to the svt_mem_driver component that is 
   * issuing this callback.  The user's callback implementation can use this to
   * access the public data and/or methods of the component.
   * 
   * @param req A reference to the memory request descriptor object
   * 
   */
  virtual function void pre_request_put(svt_mem_driver driver, svt_mem_transaction req);
  endfunction


  // ---------------------------------------------------------------------------
  /** 
   * Called after getting a response from the memory reactive sequencer,
   * but before the post_responsed_get_cov callbacks are executed.
   * Modifying the response descriptor will modify the response itself.
   * 
   * @param driver A reference to the svt_mem_driver component that is 
   * issuing this callback.  The user's callback implementation can use this to
   * access the public data and/or methods of the component.
   * 
   * @param rsp A reference to the memory response descriptor
   * 
   */
  virtual function void post_response_get(svt_mem_driver driver,
                                          svt_mem_transaction rsp);
  endfunction

  // ---------------------------------------------------------------------------
  /** 
   * Called after the post_response_get callbacks have been executed,
   * but before the response is physically executed by the driver.
   * The request and response descriptors must not be modified.
   * In most cases, both the request and response descriptors are the same objects.
   * 
   * @param driver A reference to the svt_mem_driver component that is 
   * issuing this callback.  The user's callback implementation can use this to
   * access the public data and/or methods of the component.
   * 
   * @param req A reference to the memory request descriptor
   * 
   * @param rsp A reference to the memory response descriptor
   * 
   */
  virtual function void post_response_get_cov(svt_mem_driver driver,
                                              svt_mem_transaction req, svt_mem_transaction rsp);
  endfunction

  //----------------------------------------------------------------------------
  /**
   * Called when the driver starts executing the memory transaction response.
   * The memory request and response descriptors should not be modified.
   *
   * @param driver A reference to the svt_mem_driver component that is 
   * issuing this callback.  The user's callback implementation can use this to
   * access the public data and/or methods of the component.
   * 
   * @param req A reference to the memory request descriptor
   * 
   * @param rsp A reference to the memory response descriptor
   */
  virtual function void transaction_started(svt_mem_driver driver,
                                            svt_mem_transaction req, svt_mem_transaction rsp);
  endfunction

  //----------------------------------------------------------------------------
  /**
   * Called after the memory transaction has been completely executed.
   * The memory request and response descriptors must not be modified.
   * In most cases, both the request and response descriptors are the same objects.
   *
   * @param driver A reference to the svt_mem_driver component that is 
   * issuing this callback.  The user's callback implementation can use this to
   * access the public data and/or methods of the component.
   * 
   * @param req A reference to the memory request descriptor
   * 
   * @param rslt A reference to the completed memory transaction descriptor.
   */
  virtual function void transaction_ended(svt_mem_driver driver,
                                          svt_mem_transaction req, svt_mem_transaction rslt);
  endfunction

endclass: svt_mem_driver_callback
   

//svt_vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
TrWYILQaHzJz0XXeng6s/aV4I62cLNd+yTiw5ARWE/ej8CW3W4DEfPcDr8gy2z16
z/JtvHMixlXZXH7CUpJlp4dUaJJhiCBeGEbv+ZMmAkNy4ZOFa1KtTNqTflFrkaLM
0z2uJhnO54+i2S/07By2EJHpKBRETyHKIhOX1qSI5lI=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 528       )
fQjFlnrv/9BsDFeB/belpPAMeeNaJT60EsjPBKwrqgShzmL+XH4t69LD4re4u8ud
3FFg7TLjrK/lijLR91Ff3CXDES9EiiViIhTocoBMogo7CNk6zhhzkjiwQNFG36zf
q929bjT2T7BjDSZVNlY0Zk+9YLd+SLlbdxlDHDGIB1nbQEwhl5uUh8l0NnnaacXw
v5pd7jQNqgeMZJelUbirYiaqjimz5AKbulBCQzWpvjO9tLlWnRs1oMP4oB0aV9vF
pGxw/hDdTNVh2KzuL/vyPoOAU57E76m5YfhhnGoBXiGAE2NsjVTVI/FUuN6B8wnZ
N1pqcQAfN8dUA4mebGz2RTGPImQDFDa6iuTImCoQzuCOCVkSyoZWuFcn0c2SaE+n
V6+8JSkrxse7S9/gwGfVUWb8zrU+PAB+jFGgLY+oKCbgn/MDroSdNEziwcTXWrKR
M7V1pP2afVuSsnpzEMGJFfOCVMJzwYb2ecYFPdXt+qbiasisGyc8dXS+w9Bpkm4y
Mod+W71Dqoctpkcx5BoGBjvwlVeJ+XNCT1eEEcFevLPfA+WyGkrptmy74PHwQOSO
dVXSmVbNE9vbHxcFD6PHk82Xh0ZVWPiwH7OQxqdQgFKfWtP+1ZtSrIruzmfDXwKu
PpMK0J4pxH+XiwbjpCssCovpjKTj042gIGHnyD+tQka5yJaFayyAZp3iy17qiFxT
DstpAdF715nzfTmH7OWF0g==
`pragma protect end_protected

`endif // GUARD_SVT_MEM_DRIVER_CALLBACK_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Brxs/oAImu3qx0E4yj9agnlonMSxmDO21Fdt8eMlzH0jkYunuBXYk/nezbOnmC5Z
CujRbAyzaQm4QVTJuJTb29PY1Om/i+H/7WMk1JSf7IO/+007/hPUm71FscYuWN98
jYUCq+feoD+QR5K0qoJelV+ybQbPywQu2CbP/Cr7bE8=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 611       )
O1ykifFkGuutSjwlr1CPQUj8GtaMFtiQJ6RX0pAJwP7Z32xC4szauhk5d+n4xf2I
25oL2Q/govnURobszhSQxOBMhOEvMubyHbGNJZSSL5qoUzMHmXteYs/ZN/HOHDWt
`pragma protect end_protected

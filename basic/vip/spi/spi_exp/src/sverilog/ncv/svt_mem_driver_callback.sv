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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
/RWQMNopJtAaFvUYRK/yEcMtu9v1XvcD39F7yHUEKxFOQN2VPK2E1yblmui9Sksy
nRE6039lRkd6JS5mPoMGAbLd25hCzS/Q+Pd0kjwNg9RWQ/q+yP1/rXzVlY8uPLe2
HGGUNnU7J1tY+cqSWun9x1OjX6U7ELUVMGdwoZWyO34aaSP2bXP2lA==
//pragma protect end_key_block
//pragma protect digest_block
liccfR5yiYGDP/Ffnj+CjCs3ozM=
//pragma protect end_digest_block
//pragma protect data_block
Ky9BAne4SlepqeG0s9yKgsSoS3fdE5cfuA5EHh04Za1XufI4paRgkRRsAZXGo/y4
iJWBeOTkcQ5R+1iYXSs/ekdm6Gv6W+uXVX+iLIK8tynNFIq7qsC6g4thcFLpD+Ki
GamUv9nPt7lYJssVx8wPyWF+2T4l1uP8ISd7DfaYyvgDIVJNd45ChWjcNrxw/rWd
3bcPX4o4VseXyvpc1LoFg/Z2t5hbL7RC57AqPFfg3owOXUAFxMhdUh3/wpxAv+a5
WZytCW266rtRz42OfPKfgukpjRfb0UiJrZ1JPebF4bVNAgOfreovSC38yNLefJQi
HTvDy/tJ1CoKYyqkDQjX7aBxGpzsKJv+tafiPJl95H+rE73AN/2d71lsYPh3LTSJ
gDax3ihSzyB0W9prbF0JBxaZVEB8YvccxJC9g+Nd2rrTF9Y//LLMznUs19R9oPBP
s/tI0TKCeOrmp8y6gDOod/+Y0yxDXwGB91jpW93k2OcK9WXNa3JhAcqVrch10hTt
341NI/zS4EttiTocIgFg8s75vZEnLVele+fbOzgZrH6GTxnZTA4bJ4gSBp+JDMIX
y8tlrhZvwl8SUu4mVWR8tMZEO3XfFZbXSRsdUU+9cPCKw6WvHdvKVs838wwq9V+j
A05loqr04i//czJfB7jS5OjBhI8yrxaJV5EM96RU16UqjJap5VsubzHPdfig3Kc3
95Nzs9fVwXSJHcd7ELSCLCfD41vNEVBEsH+f8pKko+VcbGzNGnI4ebb/8UqIbMmL
xlZzpzUN1xYa0/lHNzVmdvybLw4+DpIP6mGrXpGG0cw4wZqjlE+4Cnyk+RmH9yb9
jzR9TmH6BHbZFMiZlbrqGb56ne3trZpWeDhXa2L2oNJ2U6igvr8olgQnXc+JPBn4
ROZvJ/xnCic6rYCHHcqhz+BnGjrMnKynuoirKybrNTM=
//pragma protect end_data_block
//pragma protect digest_block
fycFJrMkNKIneIopcIlvoZZk6TI=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_MEM_DRIVER_CALLBACK_SV

//--------------------------------------------------------------------------
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
//--------------------------------------------------------------------------

`ifndef GUARD_SVT_MEM_DRIVER_SV
`define GUARD_SVT_MEM_DRIVER_SV

typedef class svt_mem_driver_callback;

// =============================================================================
/**
 * This class is a memory driver class.  It extends the svt_reactive_driver base
 * class and adds the seq_item_port necessary to connect with an #svt_mem_sequencer.
 */
class svt_mem_driver extends svt_reactive_driver#(svt_mem_transaction);

`ifndef SVT_VMM_TECHNOLOGY
  `svt_xvm_register_cb(svt_mem_driver, svt_mem_driver_callback)
  `svt_xvm_component_utils(svt_mem_driver)
`endif

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************


  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************
  
/** @cond PRIVATE */

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new driver instance
   * 
   * @param name The name of this class.
   * 
   * @param cfg The configuration descriptor for this instance
   * 
   * @param suite_name The name of the VIP suite
   */
  extern function new (string name, svt_configuration cfg, string suite_name="");

`else

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new driver instance
   * 
   * @param name The name of this instance.  Used to construct the hierarchy.
   * 
   * @param parent The component that contains this intance.  Used to construct
   * the hierarchy.
   */
  extern function new (string name, `SVT_XVM(component) parent, string suite_name="");

`endif

  // ---------------------------------------------------------------------------
  /** Called when a new configuration is applied to the VIP */
  extern virtual function void reconfigure(svt_configuration cfg);

  // ---------------------------------------------------------------------------
/** @endcond */

  //----------------------------------------------------------------------------
  /** OOP CALLBACK METHODS available in this class. */
  //----------------------------------------------------------------------------
  // ---------------------------------------------------------------------------
  /** 
   * Called before sending a request to memory reactive sequencer.
   * Modifying the request descriptor will modify the request itself.
   * 
   * @param req A reference to the memory request descriptor
   * 
   */
  extern virtual protected function void pre_request_put(svt_mem_transaction req);

  // ---------------------------------------------------------------------------
  /** 
   * Called after getting a response from the memory reactive sequencer,
   * but before the post_responsed_get_cov callbacks are executed.
   * Modifying the response descriptor will modify the response itself.
   * 
   * @param rsp A reference to the memory response descriptor
   * 
   */
  extern virtual protected function void post_response_get(svt_mem_transaction rsp);

  // ---------------------------------------------------------------------------
  /** 
   * Called after the post_response_get callbacks have been executed,
   * but before the response is physically executed by the driver.
   * The request and response descriptors must not be modified.
   * In most cases, both the request and response descriptors are the same objects.
   * 
   * @param req A reference to the memory request descriptor
   * 
   * @param rsp A reference to the memory response descriptor
   * 
   */
  extern virtual protected function void post_response_get_cov(svt_mem_transaction req, svt_mem_transaction rsp);

  //----------------------------------------------------------------------------
  /**
   * Called when the driver starts executing the memory transaction response.
   * The memory request and response descriptors should not be modified.
   *
   * @param req A reference to the memory request descriptor
   * 
   * @param rsp A reference to the memory response descriptor
   */
   extern virtual protected function void transaction_started(svt_mem_transaction req, svt_mem_transaction rsp);

  //----------------------------------------------------------------------------
  /**
   * Called after the memory transaction has been completely executed.
   * The memory request and response descriptors must not be modified.
   * In most cases, both the request and response descriptors are the same objects.
   *
   * @param req A reference to the memory request descriptor
   * 
   * @param rslt A reference to the completed memory transaction descriptor.
   */
  extern virtual protected function void transaction_ended(svt_mem_transaction req, svt_mem_transaction rslt);


/** @cond PRIVATE */
  // ---------------------------------------------------------------------------
  /** INHERITED METHODS Implemented in this class. */
  // ---------------------------------------------------------------------------
  extern virtual protected function void change_static_cfg(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void change_dynamic_cfg(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void  get_static_cfg(ref svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void  get_dynamic_cfg(ref svt_configuration cfg);

  // ---------------------------------------------------------------------------
  extern virtual protected function svt_mem_configuration  get_mem_configuration();
  // ---------------------------------------------------------------------------
  extern virtual protected function svt_mem_configuration  get_mem_configuration_snapshot();

  //----------------------------------------------------------------------------
  /** PRIVATE METHODS */
  // ---------------------------------------------------------------------------

  // ---------------------------------------------------------------------------
  /**
   * Invoke the pre_request_put() method followed by all registered
   * svt_mem_driver_callback::pre_request_put() methods.
   * This method must be called immediately before calling svt_mem_driver::item_req().
   * 
   * When overriding this method in an extended classes, care must be taken to ensure
   * that the callbacks get executed correctly.
   *
   * @param req A reference to the memory request descriptor.
   * 
   * Note that, unlike the other *#_cb_exec() method, this one is a function.
   * This is because it is typically called from FSM callback functions.
   */
  extern virtual function void pre_request_put_cb_exec(svt_mem_transaction req);

  // ---------------------------------------------------------------------------
  /**
   * Invoke the post_response_get() method followed by all registered
   * svt_mem_driver_callback::post_response_get() methods.
   * This method must be called immediately after seq_item_port.#get_next_item() (UVM/OVM)
   * or rsp.#peek() (VMM) return.
   * 
   * When overriding this method in an extended classes, care must be taken to ensure
   * that the callbacks get executed correctly.
   *
   * @param rsp A reference to the memory response descriptor.
   */
  extern virtual task post_response_get_cb_exec(svt_mem_transaction rsp);

  // ---------------------------------------------------------------------------
  /**
   * Then invoke the post_response_get_cov() method followed by all registered
   * svt_mem_driver_callback::post_response_get_cov() methods.
   * This method must be called immediately after calling post_response_get_cb_exec().
   * 
   * When overriding this method in an extended classes, care must be taken to ensure
   * that the callbacks get executed correctly.
   *
   * @param req A reference to the memory request descriptor.
   * 
   * @param rsp A reference to the memory response descriptor.
   */
  extern virtual task post_response_get_cov_cb_exec(svt_mem_transaction req, svt_mem_transaction rsp);

  // ---------------------------------------------------------------------------
  /**
   * Then invoke the transaction_started() method followed by all registered
   * svt_mem_driver_callback::transaction_started() methods.
   * This method must be called immediately after calling post_response_get_cov_cb_exec().
   * 
   * When overriding this method in an extended classes, care must be taken to ensure
   * that the callbacks get executed correctly.
   *
   * @param req A reference to the memory request descriptor.
   * 
   * @param rsp A reference to the memory response descriptor.
   */
  extern virtual task transaction_started_cb_exec(svt_mem_transaction req, svt_mem_transaction rsp);

  // ---------------------------------------------------------------------------
  /**
   * Invoke the transaction_ended() method followed by all registered
   * svt_mem_driver_callback::transaction_ended() methods.
   * This method must be called immediately before calling seq_item_port.#finish_item() (UVM/OVM)
   * or rsp.#get() (VMM).
   * 
   * When overriding this method in an extended classes, care must be taken to ensure
   * that the callbacks get executed correctly.
   *
   * @param req A reference to the memory request descriptor.
   *
   * @param rslt A reference to the memory response descriptor.
   */
  extern virtual task transaction_ended_cb_exec(svt_mem_transaction req, svt_mem_transaction rslt);

/** @endcond */

endclass

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
APb4fIgFytK7IhdmZmAO55exUy1s1BcK7aE9mLN21fV/gWhD1oZmzsr3tvm/5A7C
gHOOlk2A15e9urZXGdnyXvkT6QsyPjyvkf8GMtD189Y+ht3leZHAFWYYz+cQJDA6
HjgMFyn/WYsFDiPSa8tIYRQBMXKLX6n66NYdcW8YlCw=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 527       )
pmgmk5dy3401kRmaQuc3bTCM51GjTKpnXMpWS9f5itJ2E7LIXo3sPPojmAlH9gPO
nibSHyxe0ze4A1D7KMEokFHi8FdcdC8O1ljCB1vCZO8IB4SoZcvEe99kUzaw7y23
ITtWcZT/p6WArp4hchdERziiRt/+bU58TaRRvx0XnwZ/abZ0XkXNBwftIlhJsk6Q
mvlgpuKsJF/Fao/i0E9Fw/i6QbrgCnWIp61mlN2o1t0NdLj2DmgUfh9N/znprbXT
oejms8bBkNlSLwXiy8wcCbHOTX5BZhtKB45wEcnzY10uoHsqSJjo7DxY97I5vjoO
VpZeMSU/s0VTC4fAe8wnohQ8SqTuQWrSomvNRaLzLq0eWjAIPOl8f8QgmEdghNTZ
2NiwKIwyyUq3SgFDFyy7uyQ5VuZ8ZD39zetAv3dYU7d1CCb5gCjL32xj6KW4JAhp
2Y5aRgidz3mdreIaZk5VsYxuF3xXNojlw0/qSnmY+DpOvMUwK98WQmMdJ3RGp4Kr
iHl4eJCVlv1XGKxm+PktXFSnrqHeIMxoN7892vrAaoaP/WduL91FvKZeyScrRJ5Y
Mt/gG7LUnLas4vp7mBo4CENIJrfugEek3Q/li2zsWATZtZiWxigvjYMnRz3GBu8o
fC3A1/EqIZYk8nCpelKcfCksIJtoXkQCZHhWJOR8C+BMF4Xujny/CqNOmSfdUbhx
`pragma protect end_protected

// -----------------------------------------------------------------------------
//svt_vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
NpVBbxnaeqWIeJy+dNRsvQL3OyZUBVOiR42g5qYc8yZyvbFkn0Ie1leXvDCurW1J
siqCmPecCtbChCNOjSqmvQWdC4JlIzyH/QfxK6LFnPbwgd5i7PSoMbCckpiMoyUu
YlfP00DzllUGHGix38BMGGiXBZKikufXNvlum2GrNLI=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 5591      )
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
`pragma protect end_protected

`endif // GUARD_SVT_MEM_DRIVER_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
DpBy3aIG01Q3mX/GNtCsZb4kQ80grQ+N+KEGQ+O7ag4/bwpcp1kmOUhQYDflUfyO
gUC0tRmRbLdkdUIMAJiunRTMqqJXl9vHfnXGmAiJpS9KifCXoEgty5/ZS6PyKcDa
Gk9PruFtO4qQRegdtAuezqJLx+fVEsQUS/j5Zew84fE=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 5674      )
LZQmGVx/RqVWyZocOZpglds5PAJnhjhcO1pviTtNB5cm9lFEvi0EGGyFwJ6CPfto
UTUlkQn7QzTkmEL0lKYcvyjt9SR1v6Spq8+dh9vIPI2TzO2qrPd5mRVNtmkXMY7k
`pragma protect end_protected

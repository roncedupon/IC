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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
/nT6WmG3GowbE1/v4OFDpDQg0I5hH3IDBSgOoc+ifo7APW3Ke8UBTGWC3rSyx0MT
M7kJ5ZHRW3eHOP1ogyVGVdq3xFImrzdDmFSDe4AFRGJgF14Q/sW903tvZ0noOJhJ
nS5Bm4Lhor+WC0xBJ2Ilo0r86aIpOhYewqRofw5v4V2urBHBpQ23CQ==
//pragma protect end_key_block
//pragma protect digest_block
iohDL1xMk3o3u5118O2navvyW4M=
//pragma protect end_digest_block
//pragma protect data_block
A593M1XMTpuKSD3G/1EW8sb1X9gNZya5yAItPsgEvbc9oklplsI95JLfGs9naL79
SGsYTXmh/T4Ls7t5g+rexe9NqFUOk2ppAZW1unlCHtgm0jWYqqax1bgJmNV2iH1u
zpBUh46OlP42qGQ2nUUz/SMvDj/tEkz5YRAeugoh3gwY3FEpzD3WHIvTz147U+7n
egWr+lmlZxgpxUC8MLjYcmVMEkCejyPtNPffsY8pXX47oc3JE5AfXb9wPIUxg3J9
QMZTCVbu/aQwt/uP/rGVl9f33H/FdK3BmUos327YHXrweNmAsBhEUQaHldlZSR/E
MiEAMg81WqOGTk33ovPNaBfno11XLuozTDuWlyUfrJVO09pRhPCftaJBP2Png4Nb
+VDlpRnICpu9gpD50W8lYMbVogbTjJzejb858HjVcjfBEk53Arxkd91HYn46+5pS
qzdtT1+AKso3erCPLeHPovRQWFKZCpTj16Nsa1L+2B924d2+1WRSaiYJ2A5jZsPx
FMRLS8nLKdMRT+TmO2f2LcpZZ6vKd5raqwJI1s1qSxfFp9ssa7hENvklaPgCtVZ0
mnbS5sdEZG98298vSsMo8T/w/XR4Zf4nr32X6df8HM/W8/ujiTQqkTgUYqfYmn0X
JtaZdgb3k5S2j2PxfCJgvmqtVIdruKy+OApLU61eq/482A5iyzbxCb7j8BeUBcmL
Fgm5LPvagS5jjgf/Ez6vJGg8WbYB/MZ7nr2bf5yZXecUtRLGvS0mmhNz4RkBh8Jf
kQa9m7KeE196Ow5yutlGSdTEDXDE8tseK23GVcLbWkDOH3KX4WsQcwdqdavTZXc9
mkKUjcid707G74D+I94RARNeOin69cTE/5m4nCkphI7oCeTpW3gWE95y3kNZ6cql
QcdQjpjqeVBafb6Q5GDgnfL3ptDXHkMxfeUY9BnpARY=
//pragma protect end_data_block
//pragma protect digest_block
vRQz7m2yz4s0JX+jjewCwoVtlDo=
//pragma protect end_digest_block
//pragma protect end_protected

// -----------------------------------------------------------------------------
//svt_vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
xRDpgakLKD0yDORYxdbD8qA8q6mx3Nf1cBFn1q+PfRKT64tECU0ufoCPlwCP2j+F
huhJG6ZuwgP+QtIeysCAUlsMxpJ8zI4NuSHTsYiwDGGicR9GVQQBNDn2pFViU56R
gVxfySlXuBOAHNNMIeebIzEGjCbCytZoxykd9DDJZYo0QMDvTpVu1w==
//pragma protect end_key_block
//pragma protect digest_block
ra9+p4IVwCroZXAZ6+AUJ96qHD4=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
oKRsLOWP5W4z5ahyIsjzqpt/ltI=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_MEM_DRIVER_SV

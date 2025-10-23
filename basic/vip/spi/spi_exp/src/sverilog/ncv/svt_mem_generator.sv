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

`ifndef GUARD_SVT_MEM_GENERATOR_SV
`define GUARD_SVT_MEM_GENERATOR_SV

typedef class svt_mem_generator;
typedef class svt_mem_backdoor;

/**
 * Callback methods for the generic memory generator.
 * Cannot be used directly. Use the protocol-specific extension.
 */
virtual class svt_mem_generator_callback extends svt_xactor_callback;

  extern function new(string suite_name, string name);

  /**
   * Called before the memory request is fulfilled using the default behavior.
   * 
   * @param xactor Reference to the generator instance calling this callback method.
   * 
   * @param req Memory transaction request that needs to be fulfilled.
   * 
   * @param rsp If not null, response that fulfills the request. If this reference
   * is not null once all of the registred callbacks have been called,
   * it is used as the actual response instead of the response that would have been
   * produced should it has remained null.
   * 
   * In most protocol, the response is the same object instance as the request.
   */
  virtual function void post_request_get(svt_mem_generator       xactor,
                                         svt_mem_transaction     req,
                                         ref svt_mem_transaction rsp);
  endfunction

  /**
   * Called before forwarding the response to the driver transactor.
   * 
   * @param xactor Reference to the generator instance calling this callback method.
   * 
   * @param req Memory transaction request that was fulfilled.
   * 
   * @param rsp Response that fulfills the request. If the response is modified,
   * the modified response will be sent to the driver.
   * 
   * In most protocol, the response is the same object instance as the request.
   */
  virtual function void pre_response_put(svt_mem_generator xactor,
                                         svt_mem_transaction req,
                                         ref svt_mem_transaction rsp);
  endfunction
endclass


/**
 * Generic reactive memory generator.
 * By default, behaves like a RAM
 */
class svt_mem_generator extends svt_reactive_sequencer#(svt_mem_transaction);

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

/** @cond PRIVATE */
  //Memory core
  local svt_mem_core mem_core;

  //Default Memory backdoor 
  local svt_mem_backdoor backdoor;

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

  //Generator Configuration 
  svt_mem_configuration cfg = null;

/** @endcond */

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new generator instance
   * 
   * @param name The name of the class.
   * 
   * @param inst The name of this instance.  Used to construct the hierarchy.
   * 
   * @param cfg A reference to the configuration descriptor for this instance
   */
  extern function new(string name,
                      string inst,
                      svt_mem_configuration cfg,
                      vmm_object parent,
                      string suite_name);

  // ---------------------------------------------------------------------------
  /** INHERITED METHODS Implemented in this class. */
  // ---------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  /**
   * Return a reference to a backdoor API for the memory core in this generator.
   */
  extern virtual function svt_mem_backdoor get_backdoor();

  //----------------------------------------------------------------------------
  /**
   * Return a reference point to svt_mem_core.
   */
  extern virtual function svt_mem_core m_get_core();


  //----------------------------------------------------------------------------
  /**
   * Returns a reference of the generator's configuration object.
   * NOTE:
   * This operation is different than the get_cfg() methods for svt_driver and
   * svt_uvm_monitor classes.  This method returns a reference to the configuration
   * rather than a copy.
   */
  extern virtual function void get_cfg(ref svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * perform svt_mem_core configuration.
   */
  extern virtual function void reconfigure(svt_configuration cfg);

/** @cond PRIVATE */
  //----------------------------------------------------------------------------
  /**
   * Fulfill the memory transaction request by executing it on the memory core.
   * The response is annotated in the original request descriptor and the
   * request descriptor is returned as the response descriptor.
   */
   extern virtual local task fulfill_request(input  svt_mem_transaction req,
                                             output svt_mem_transaction rsp);
/** @endcond */

  // ---------------------------------------------------------------------------
  /**
   * Cleanup Phase
   * Close out the XML file if it is enabled
   */
   extern task cleanup_ph();

endclass

//svt_vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
sLYaEfVkF3bwOWzRU3/S2CxmfErYASmHy/KDq61nm1CFI7icLGbqQvVBB2jpWVSx
VjzriXVZ3HWj+leIeB+m0XFk8uzrZK1FM67R5HJTT+bGnlUTwghPXhnaIN1oKapX
EUU6PHoYYW2dnJuEGRLhXMSnyOJlXmXrBP1aiFVIaOOe8Mj7tZJFSg==
//pragma protect end_key_block
//pragma protect digest_block
DGsCicgepPgZNWQ2JZhIRd7Ylbc=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
5Zrj7x9x4opPatrq88xQUAOsfeU=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_MEM_GENERATOR_SV


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
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
YsL2ViNqhCanN+n+vBQyAssoRcDcJLuvitEZf2xxxBBZhnq0qgZZ6SKEwmqD6utv
ApEAxAQLia15rDROqBSRZkUtH4RQXRJHTlNuyYBuVmnXUMTX+MEf0ADxM3lZ7bv7
dnuswwPhuC3EHkuY1iW+fDdydckApmhCj9Lssd2rw/o=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 3191      )
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
lxl9dfCPqzT/8NTbi3v8tCTqoCVblJYouEwW+ngn74gc8n71jdtYexPvH5ueKzqP
eOk12+nZP8YBzzw1+3em4MDuG9HW1kD4wPd6yCODXyuVK8TG12vjvRtAgc086IS4
lTClAtdngPo3nYs3REWjLByM8LRHK8FTi7caA1x3phJUNETFqqWFDig2wj5KWSO0
LTh5UKkz8kjTEB/rfch2VxrSi8xO0/0tKK6VIELFf5lQJqove/keRyk2F7OPbq97
ZqUTP6dPqd7/oguhMhx5e8qAC6ao1GXZ7OD8lh3vhHT3RNKsnz6IfGoIaGMKm7y5
6ONada7NgR2cIMnX8vXobl9DW7Hx+oBkZCBX2PfDSeQAcxSupCsE6P06jm9N94jH
RsQPHziot0gVQjJ6UdvH6aD/HRrCmk+WBQg+Ilas0xQzDWqlYUfGTeLd4gQtOrNE
sWa+duh4LMmhjujnlWaQyGN4JOpycz3MkR8lWEAQeO2HQ+hcjhS1GOKVjt6g4dEo
WW6hwJiQTqGgNgJgVzpXsMGu2Q8dpevR+rJBiKdGsOkntVfQGBqdy0UVPQESTPV6
pmClprIq8j5PwsYJ5ftE52ufx09QpUT0zstIevVO94U=
`pragma protect end_protected

`endif // GUARD_SVT_MEM_GENERATOR_SV

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
LXJ0A2EYIvgT060Cs6cAsg/WTzHxad32P4lN+uXuJr/oNlPZuvQv/vQODGXJWEWg
3It0sh9GRuOrVC99Ty7zZESWnkQnul6FJlaeNscDkj588gMPoCj3+nR88KeJA4lh
qTOPsJxXcP3iXKfpMqpGDG8Hmf4EhT5taEjjyx0FY8E=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 3274      )
Y+qkXiMh1fRrk+x/JbUYsO7bZPx7YjrUTqjj0d6IwsF/QquiRi8aRmWWBTlteMIu
OfU74uoQgPXR/qH5NaLUnbXdfRQA6/sw4sge/IFwSGzmA8WT4I3PR+nMrlZId7W6
`pragma protect end_protected

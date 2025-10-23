//=======================================================================
// COPYRIGHT (C) 2011-2015 SYNOPSYS INC.
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

`ifndef GUARD_SVT_ENV_BFM_SV
`define GUARD_SVT_ENV_BFM_SV

// =============================================================================
/**
 * Class that provides the basic infrastructure common to all SVT ENV components.
 */
class svt_env_bfm extends `SVT_XVM(env);

  /** SVT message macros route messages through this reference */
  `SVT_XVM(report_object) reporter = this;

  /** Flag to track when the model is running */
  local bit is_running = 0;

  /** Flag to detect when the model is configured */
  local bit is_configured = 0;

/** @cond PRIVATE */
  // ****************************************************************************
  // Private Data Properties
  // ****************************************************************************

  /** Identifies the product suite with which a derivative class is associated. */
  local string  suite_name;

  /** Identifies the product suite with which a derivative class is associated, including licensing. */
  local string  suite_spec;

  /** Special data instance used solely for licensing. */
  local svt_license_data license = null;

/** @endcond */

  // ****************************************************************************
  // Field Macros
  // ****************************************************************************
`ifdef SVT_UVM_TECHNOLOGY
  `uvm_component_utils(svt_env_bfm)
`else
  `ovm_component_utils(svt_env_bfm)
`endif

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new component instance, passing the appropriate argument
   * values to the component parent class.
   * 
   * @param name Name assigned to this agent.
   * 
   * @param parent Component which contains this agent
   *
   * @param suite_name Identifies the product suite to which the agent object belongs.
   */
  extern function new(string name = "", `SVT_XVM(component) parent = null, string suite_name = "");

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Q088/6WcTmxXXH9tCHsPbA4EdmlYGPhAq9Mr7br6PDgoVrHdCwDB5o9iOdh+Y242
bXFL87FTp+qskd8vzW3ehEuG/dJ3kOHeFh6d+cB5e4kyLUPJ6fG/SZHLPUQuSm8X
ZmHzjDJz5JM9dBnNXSouxE8mmKHnQj7b3ISJbi3RC1w=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 362       )
PDLhFSnOFfO6HEntS628XR4B5guqGLGxUlAqsIbhogOeO4GCcQWICO5qyDP9K1+G
6Ax9FbKROeZSDdmmdoZJf2nXHqwvjhxJqDYcSrJySJiL2MMB1pES6oEv8P7Re2Jg
iKXth6MUF/D4joqNroGzHzOWXRgy7eZfkOA3H/lwoVduq5fqVR8hEw6A+OuT7b+u
7jxUfgdtn74vvD4Pcd1vLhU0nzvkjHEZFJl8SKo7fsd/m+6P0BRDbSzeNnyrzwNm
azC6AryrG11iX8JehA4jhHA5T5L4v5MVrgoMEC/tdNHExOwf69fXM9K7KZ46Od2w
xtDS/QlmkMoaDGtpGcoWXzAUThch+VxBOz6IH1bCnDBzpT5Y4rncP1dTdo0YqCZN
zhWXbfVCgIVPR95UKU9LXy1Gw7eNTKgPpwUpf5Cc7ppWZL2MFBtcd5tZDy36hWKP
Qw26fQ4cC7xfFkhQaaSImJInGic8oxAcZtODXu/8ptQ=
`pragma protect end_protected

  /* --------------------------------------------------------------------------- */
  /** Returns the model suite name associated with an object. */
  extern virtual function string get_suite_name();

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
mY7qskVQdDz6kb+dI1+5hctDv3wR6FeV9SrNCPw65xDOnq46jQK6r23RUAOlitgQ
ibmylqo5w5TbsPGItxXA0i/mMJcDr5LxX1RGnM6sNjLkx/9r75URPEAc2a02qCOR
i1B58ieG0UDwIwVWtd7lMHD6o+zf1r0SrqIxkLti0Xk=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 686       )
U8dSXOZD1VzMC0e0IcSEELlVNOzB/iN9Uz0oubuVfl6DDpANcHgqxATJOBQzNJic
9z0nueix0MSL3tF4BBQjzH2/6xuUSHhPK/O8fW4FAeWvVCfTvWkDmqKihCwvr5Ca
hbMHyY15CEMwC5pbnSI4nyaZl0QHJY/j1PpU1x0i+4TliEPq4ztAlUNnWsAm3abZ
gWed2R8SeHqxT+Y/CL3ruQxlfXwoG29pz+md2nAFT8ZzA/WeqnTEMEYXxsNSzmjQ
Kz3WI8d/cZFlwPiR+s2dkdrGcsPQ8dnjF6Hcg8WLbVefCCNwInvDp+2CSXa1TCO4
imjvS5tzVsIcFgVkJgLS2Db252fTA7U4NJBfKlTt48AjMLe4s04ttt+bKn9VTxU/
S8PUfIKSNScPro0fGnCZDN1Urcmx/oVsucyyEIEUsRZi90ZB08j64WL50JJNeCeQ
`pragma protect end_protected
  
  /* --------------------------------------------------------------------------- */
`ifdef SVT_UVM_TECHNOLOGY
  /** UVM run phase */
  extern virtual task run_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  /** OVM run phase */
  extern virtual task run();
`endif

  // ---------------------------------------------------------------------------
  /** Displays the license features that were used to authorize this suite */
  extern function void display_checked_out_features();

  /* --------------------------------------------------------------------------- */
  /**
   * Returns the current setting of #is_running, indicating whether the component is
   * running.
   *
   * @return 1 indicates that the component is running, 0 indicates it is not.
   */
  extern virtual function bit get_is_running();

  // ****************************************************************************
  // User Interface for Configuration Management
  // ****************************************************************************

  /**
   * Updates the components configuration with data from the supplied object.
   * This method always results in a call to change_dynamic_cfg(). If the component
   * has not been started calling this method also results in a call to
   * change_static_cfg().
   *
   * @param cfg Configuration to be applied
   */
  extern virtual task set_cfg(svt_configuration cfg);

  /**
   * Returns a copy of the component's configuration object, including the
   * current configuration settings. If cfg is null, creates configuration object
   * of appropriate type.
   *
   * @param cfg Configuration returned
   */
  extern virtual task get_cfg(ref svt_configuration cfg);


  // ****************************************************************************
  // Utility methods which must be implemented by extended classes
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * Copies (deep) the <i>static</i> configuration properties from the argument
   * into the configuration object stored in the component. Used internally
   * by set_cfg; not to be called directly.
   *
   * @param cfg Configuration to be applied
   */
  extern virtual protected task change_static_cfg(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Copies (deep) the <i>dynamic</i> configuration properties from the argument
   * into the configuration object stored in the component. Used internally
   * by reconfigure; not to be called directly.
   *
   * @param cfg Configuration to be applied
   */
  extern virtual protected task change_dynamic_cfg(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**\
   * Copies (deep) the <i>static</i> configuration properties from the configuration
   * object stored in the component into the argument. If cfg is null, creates
   * config object of appropriate type. Used internally by get_cfg; not to be called
   * directly.
   *
   * @param cfg Configuration returned
   */
  extern virtual protected task get_static_cfg(ref svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Copies (deep) the <i>dynamic</i> configuration properties from the configuration
   * object stored in the component into the argument. If cfg is null, creates
   * config object of appropriate type. Used internally by get_cfg; not to be called
   * directly.
   *
   * @param cfg Configuration returned
   */
  extern virtual protected task get_dynamic_cfg(ref svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Expected to return a 1 if the supplied configuration object is of the correct
   * type for the component. Extended classes implementing specific components
   * will provide an extended version of this method and call it directly.
   * 
   * @param cfg Configuration class to test
   */
  extern virtual protected function bit is_valid_cfg_type(svt_configuration cfg);

endclass

// For backwards compatibility
`ifdef SVT_UVM_TECHNOLOGY
class svt_uvm_env_bfm extends svt_env_bfm;
  `uvm_component_utils(svt_uvm_env_bfm)

  function new(string name = "", uvm_component parent = null, string suite_name = "");
    super.new(name, parent, suite_name);
  endfunction
endclass
`endif

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
lwLndpQtgONCic91yfrHz9mRH4CnscvLBsVt1x2pHUUJC0XnoDkD8d0/uJhnCKGf
qYSYz4w647sER9dbdG5VKq/AJIRbShtbkMzITQqWYTJ9yje8EuuNF4OvX0kNtq4m
scR/jXkE1S1rEIvZT6rVuAexvBbcxDfLIpx//FDKnms=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 7322      )
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
/NZzOyG0dcHQQSOqOB9p1g==
`pragma protect end_protected

`endif // GUARD_SVT_ENV_BFM_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
C+8AZLFW8myQrJzi/BqQmPPskdioI/cTwunsHUSbUkMeKMCr8N3cCIEA6treWX9L
+aOPvWZ/ouZ6G0RBs9j2BfxWL/e5cXhVcOr8pIb9x4Bb/71bk+FBLBkqyAT9tVrD
fCJ1mkIjEGRGMAqDsrf7QypBm0/q+LVB6k5QmgWwrco=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 7405      )
/YQReBHwZMMyZ/fRnzpSKrhcscvX544FymJN63eWdvzjBss4lJTd26O351cjWs/I
a+HXpNdIRSuQLZUAJ6SWhx5b4IrFvzFle5uOSkhzbuW0oNH38F1RJF3jkpG6UUYn
`pragma protect end_protected

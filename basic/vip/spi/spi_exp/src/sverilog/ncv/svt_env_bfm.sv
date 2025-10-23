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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
fV9+nXWlJq9jrdbmYhgMQZ7mkmbMyu6zzOSDf4MKBNdm89M63mMfdPiDq25UorRy
9OTwDb57fa7t40GwGKnbgYb4PQap0C/ggkmnMpLEfLqSuBd2HWpogiAJEeoHdbeC
AnAlg4qWXIkFqrDubAxTHZ5Ka5lTbhuOZRgJ2oy8WLen3l/oSgvmcg==
//pragma protect end_key_block
//pragma protect digest_block
hMjoimjlzApUmTT/tXcYwGCaZGk=
//pragma protect end_digest_block
//pragma protect data_block
v2Vwe5k+bAQskJ0hxyv1jYvlAiSSggQrQvqSeKjswyrvJnraUiKknz/boiLpUx88
7LAJU16E0ikudRB0xrHKcqOKTRw1T5eouBcsl6Q+dvS+pC3v/jNU1GNbNxNhSJ4c
gRSyHhlCDWHAA6TOwUhvC7X6s05lRoV6q+eX9ot7IfVPCYYHOgGBIpYrkuu8Czky
fw5vg9yHyXD/2i2xnHOtcFC+VnSXS3Wog/fdJOamvUByPQ3KZKz9AsKKFI4FxnD0
rq826//j9AjkCUMLp/4aJ5f5tar0aEpNywOZ9a63G76fgpi9kcpFUJqyGCwXtUHy
jVC0I9ir+/5f+UWNc+pAlai0HV9AV7nKc3tG4cSPUtdEEwXLHu/bj7461XLg1jUA
ka0YZ2ufRvwJjlyFYuV0Z6v/7qzyFU/Z1wbu8OPOSweMjHx19MFnrbGFBqQ1sxX/
03QV7LtaBVc+VKu0Voq8u2G1XLZ0Bj+JVchtDrbkTGRhSobU0ZD8Q7NWgq1Vj23h
TsYnRcPsnvX2+RUdDCY86jftaBRlxchS9qhUYP4soXY/5Q/yPvfRz6AwNY0zXG5p
9vTFCZEjbcB3cUsJOkcRkZ+E4/LL9qMjoEi4U4LpaYOb4JSTGsIBnHRgjCMS/xYz
uJYYRc+Y5SgmSK0UtqQ3fSFfMi+JcbcU2FgJkCD+VPIttWJuLC9UnSmQiC50+MsL

//pragma protect end_data_block
//pragma protect digest_block
qjkXqouzBTu+0H8j9fK8rn6W6YY=
//pragma protect end_digest_block
//pragma protect end_protected

  /* --------------------------------------------------------------------------- */
  /** Returns the model suite name associated with an object. */
  extern virtual function string get_suite_name();

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
95l92YaLotb/s6JA+WMQbVGTKREactMo+ZHrfbxU9CudoS+Kln8nerbE1WoLd+23
wmJg7v9RPniwd9Ku2xbSjtn9B7L1iMH+NVGTIosXwgB9vi/1+8w9aHmXRZ94oWSc
sguPuXTXITHFReMLTn4NfrqX/qD8v990AlKzRJtoZ6yOIYt0qXFvpw==
//pragma protect end_key_block
//pragma protect digest_block
Dkc5+S4UHKJaFOyzVFEgXICyziA=
//pragma protect end_digest_block
//pragma protect data_block
INKRPx2xKP608vNDu/4eXi3MgfOjsA0pDVFrCzu3NmM/EtOkxIs+pOGvlIIyiPHx
Y6YEzJn7YIoL2AUMibvUmnlagT4Gc3sYkvoO9RBXaca7W+vvYTLZfvaW5GnzvF4/
Q8ETy2w8t2h2oZj6yOh8VbbSQQ85ld9wJXMoMmviXLgj1uGlaIqzLWSd57k9Y9Bx
SXi8LTjSg6T67uOlwovagZZ4e8L4AICJU03XQKe9m8vrS+E46BgVJ/ksYj5JY8Lb
sz8Xqh1oE5Kx+djbaErKtR69tpCKSdxuDG3zS4oN8UaBktBuUBTCXl1eik9uVxE9
3hvpASN7RGumfCOoQw3CZqp//64xTknBWwXv2QdwmiOkgfJEyLW6pvBSqmWx75E3
yc9f3M57q/YBUWsXPzIUB4/Uc1LERz2Gc54sJXH9KvC9BR5XOOBre2Fom+p5Nybu
NZ9+SEPdOtaRc3D1FaGCjy8ikxxPDnKle5AdOmNSRM0ik1STD29W6dcN4EHa4de2
/G36zsAmaQoKabOMLT+RoV0TRcLP2pJCeyLvD0ThiXi0e6o5GHbXdD8qkJxwQIJK
7kfb2j+0fspVuTnjovjJk0B8Q4i+XrUT+1VFvGycxqaJWFKW0ZB+v2/RNsEvRHTz
jV3nGAP+T8CiOgw6aS1D1g==
//pragma protect end_data_block
//pragma protect digest_block
R+yGVJuZ8XwlxeEBbQCsSiv3WyI=
//pragma protect end_digest_block
//pragma protect end_protected
  
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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
5LSULNAQwnt5qR9aVEb7jbWSHNfMqjhy8+WBR+Rl0m6fHDy1am68AyGo5nNzEbbA
OiqKuQND3E8J8BW2Plar6hrSN/twxInyUusnmarzQNVYxdux86krHR9rlxDJdnVb
hmV+fMwSUULgM1HT26ize6yiR6AxQdHJMdLj63KKSyzrhu3JTU8GtA==
//pragma protect end_key_block
//pragma protect digest_block
fZpBaLGvvr8rlMrkDFPuXbAju5I=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
GHXR3iKuuU0FGPiuA2aoaiuoOAk=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_ENV_BFM_SV

//=======================================================================
// COPYRIGHT (C) 2016-2017 SYNOPSYS INC.
// This software and the associated documentation are confidential and
// proprietary to Synopsys, Inc. Your use or disclosure of this software
// is subject to the terms and conditions of a written license agreement
// between you, or your company, and Synopsys, Inc. In the event of
// publications, the following notice is applicable:
//
// ALL RIGHTS RESERVED
// The entire notice above must be reproduced on all authorized copies.
//-----------------------------------------------------------------------

`ifndef GUARD_SVT_GPIO_DRIVER_SV
`define GUARD_SVT_GPIO_DRIVER_SV

`include `SVT_SOURCE_MAP_LIB_SRC_SVI(R-2020.12,svt_event_util)

// =============================================================================
/** Driver for a master component */
class svt_gpio_driver extends svt_driver#(svt_gpio_transaction);

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  /**
   * Event triggers when driver consumes the transaction object. 
   * At this point, transaction object is not necessarily processed or transmitted on the bus.
   */
  `SVT_XVM(event) EVENT_XACT_CONSUMED;
  
  /**
   * Event triggers when the driver has started a transaction.
   */
  `SVT_XVM(event) EVENT_XACT_STARTED;

  /**
   * Event triggers when the driver has completed a transaction.
   */
  `SVT_XVM(event) EVENT_XACT_ENDED;

/** @cond PRIVATE */
  /** Analysis port to report completed tranasction in the absence of a monitor */
  `SVT_XVM(analysis_port)#(svt_gpio_transaction) item_executed_port;
/** @endcond */
  
  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

//svt_vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
AH1qgyRN7IzKWOI3uhqnir9BySuZv/VTwHeFwxafJwTD1rRReo1amK7+EYnUnLp0
G1BJe4rgvJldYVTfny9hrkXziVg71QpNPdNVFbwURhuVGKbTybi8fgWBwpKXPNHi
KFsNyF8STm1wsT9S45ps2JL6svriCjGfgP94jSfnxA0=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 389       )
GZddnfwDlD7uteIlZnp/mbVPSPex4dCS31xHJ0I7HeJqxQ0DYPK+aZ14TUpQGcMg
RSsVcpjtiYHQ0NiDzQNDaqYII1eG/axrRG/iGy8WejTrtKDuxS0tJLpHMXiNsEAm
5vfx2/ulQH7ghM+lzxYx4hlSW/fnxbshH6HhVbRp8s5cvGpCLIAW/ACFqkSjhnex
AeeqKHpUnx/Zf+eSGbZWKxeQhlgu0DxCje8GoxNOsGNDQ+Dy1+cvwkT9M6LpOdwQ
kFH23Cezi+datDU2ZapUl4YUkMpV+wzYSPyk5Qzb6OQj91wSwOLyzksYv6ylHVT6
BuJlehc1J+NYeNvfBURbDWXyVVaFLv36v0f9VPwFVLAusxwmbJmT+JJhG6Hbx+TU
lytEKHcsJE5pwRrlt451piec4aWyebhOnSgvv/LpIf+47mTBp9MuN8wsvScQX/T1
EgFejCQ5Wrl3dNPSZ88nLyfkdrIUJkRxzrHmLCzsnFT0h2JhwQdtioCSZxhwWbMH
vrHeb6UsZ34vKwnF8Gtgjg==
`pragma protect end_protected

  // ****************************************************************************
  // Field Macros
  // ****************************************************************************
  `svt_xvm_component_utils(svt_gpio_driver)


  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new driver instance
   * 
   * @param name The name of this instance.  Used to construct the hierarchy.
   * 
   * @param parent The component that contains this intance.  Used to construct
   * the hierarchy.
   */
  extern function new (string name, `SVT_XVM(component) parent);

  // ---------------------------------------------------------------------------
  /** Called when a new configuration is applied to the VIP */
  extern virtual function void reconfigure(svt_configuration cfg);

  // ---------------------------------------------------------------------------
  /**
   * Build Phase
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual function void build_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern virtual function void build();
`endif

  // ---------------------------------------------------------------------------
  /**
   * Run phase
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual task run_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern virtual task run();
`endif
  
/** @cond PRIVATE */
  //----------------------------------------------------------------------------
  /** PRIVATE METHODS */
  // ---------------------------------------------------------------------------
//svt_vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
BgM3kveulGFBt2FNtW5nkYIXtPbW81/kd0oC9BH+aIhF+JvRtyvvpF3+nlbIJbUh
dyoDksq/B2cC1rciAeFjfYR2NXONlfGaV0kYd8EKqTWrvHq6tBKGsr6nlHYJXREr
hdqz0/Ylb65STCNcRk2ZbEih78id12VwHX+vRR/s7II=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 619       )
N0XX4YHBpkh3JbtVAp6wa1JQeuij+JKegjQQGd49d8P8tkRYujFBR1WT1wstCjG6
PNkirei04+Qp0dtKkAZ2f1xbllKH1BltZhRzQbVPjzQLcNCE0h7WCPEMTUkkiAUM
gevWYroDg0RF7ZxpOpjCixaVuTwRF7GX4SjBkzEBvMO3N4NGq0inUkrDnRd3ffNm
4MKCccRjYuXNX6HWu9lPgxdMH2bYpgV3TKdw4w71lJbq64iSU1m28YPn9+zddtEk
HfxU1LZcu04X9BX5DFTMNeCfjyPBS9tIK3ki5hYCB8WwZcQKG2Q95gD8qQLCCO1W
`pragma protect end_protected
  //----------------------------------------------------------------------------

  /** Method which manages seq_item_port */
  extern protected task consume_from_seq_item_port();

/** @endcond */

  //----------------------------------------------------------------------------
  /** OOP CALLBACK METHODS provided by this driver. */
  //----------------------------------------------------------------------------

  // ---------------------------------------------------------------------------
  /**
   * Called before a transaction begins.
   * 
   * @param xact A reference to the descriptor for the transaction that is about to start.
   *             Modifying the transaction descriptor will modify the transaction that will be executed.
   * 
   * @param drop If set, the transaction will not be executed.
   */
  virtual task post_input_in_get(svt_gpio_transaction xact,
                                 ref bit drop);
  endtask

  /** 
   * Callback method called after a transaction has completed or an interrupt has been detected
   * 
   * @param xact A reference to the descriptor for the observed transaction or interrupt
   *             The transaction must not be modified.
   */
  virtual function void pre_observed_out_put(svt_gpio_transaction xact);
  endfunction

  /** 
   * Coverage callback method called after a transaction has completed or an interrupt has been detected
   * 
   * @param xact A reference to the descriptor for the observed transaction or interrupt
   *             The transaction must not be modified.
   */
  virtual function void observed_out_cov(svt_gpio_transaction xact);
  endfunction

endclass

//svt_vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
B2rCIDdGyYAtlwo35QXSIg3mQ+62Tdz4VelbvtuYRcCOnxEFD0MMORxunl9UAsWE
m/vGG1YBY7V49r+V4D6JW87llphBk2rI3cafXAsZjRLjob2mVyhjNxX1oOS6k9Ob
/eY7ZgIpDyMhQbpx4AhG5afG2oCZBteAxpgW2eqQ/Yg=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 3167      )
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
1xKryO6iRvxOuceKSR1+9Q==
`pragma protect end_protected

`endif // GUARD_SVT_GPIO_DRIVER_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
QSTxAgjZova+0kCooyJi14WakKExha9fd0jGThfqGEWEIKtUvakOd/W6UDXk0UtC
zbrB9t4pHcCIhmxch+MxXmz1gM6F7haV5hOGpIOfrT5Fm5RnR/JNAlR8SO68egxe
DcZe3DE7oTNdKKhHGSCCmc5NRF8LFCclVIPX9lAudns=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 3250      )
rnfC/w0izW/GpmAjyttZUNvYe762lGFMsFb92TWEGQ5nzzdYV58KwFHWoNY0YP5D
+k0C7J6//tw082HNC8TRJsCTM6nnteK+zgpj3DQaCNKuiQ7lVdZyYmiYOgcGSt9S
`pragma protect end_protected

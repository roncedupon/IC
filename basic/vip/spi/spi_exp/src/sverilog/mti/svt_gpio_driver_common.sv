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

`ifndef GUARD_SVT_GPIO_DRIVER_COMMON_SV
`define GUARD_SVT_GPIO_DRIVER_COMMON_SV

/** @cond PRIVATE */
typedef class svt_gpio_driver;
typedef class svt_gpio_driver_callback;

class svt_gpio_driver_common;

  svt_gpio_driver driver;
  `SVT_XVM(report_object) reporter;
//svt_vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
aEnBEU1oxwyx2kB6Qq//mxndQhSaKuc8O1iqRj2Q+wDiYJVRsJXYdjoSE3eYqkGP
IWsMWH0AW4i1xJDXpWX+b2ldQghL7Og7xS73wzwkRlybqKzXneT2YVhoD2438rWe
3hDTvds7T2f5/ugylJaQWjjfycJ9LnzMZdY82js5syU=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 159       )
MfDzcSOn5FaO7ltcChQZpYi23LixSeESvYNFIjdnwD/sIeJj/Uq1JAlR3UkkVqGd
bed52P6AVchmV0fVrh++/DhX2MSWJ1hAvzXfEhnw80axof3poASh9o8p+Ub/KGtD
rW0D0goDa4QuUQvrS9Et8EasU3cqb8IDyAsYrDs7dFvHmosAn26vhMVS8yb+QRQq
ugba1a2KxTO2xaL9mRP2TA==
`pragma protect end_protected

  // ***************************************************************************
  // TYPE DEFINITIONS FOR THIS CLASS
  // ***************************************************************************

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************
  /** Agent configuration */
  protected svt_gpio_configuration m_cfg;
  
`ifdef GUARD_SVT_VIP_GPIO_IF_SVI
  /** VIP virtual interface */
  protected svt_gpio_vif m_vif;
`endif

  // ****************************************************************************
  // TIMERS
  // ****************************************************************************

  int unsigned n_iclk_since_dut_reset;
  int unsigned n_iclk_since_dut_unreset;
  int unsigned n_iclk_since_last_interrupt;

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  /**
   * CONSTRUCTOR: Create a new instance of this class
   * 
   * @param cfg Required argument used to set (copy data into) cfg.
   * @param xactor Transactor instance that encapsulates this common class
   */
  extern function new (svt_gpio_configuration cfg, svt_xactor xactor);
`else
  /**
   * CONSTRUCTOR: Create a new transactor instance
   * 
   * @param cfg Required argument used to set (copy data into) cfg.
   * @param driver that encapsulates this common class
   */
  extern function new (svt_gpio_configuration cfg, svt_gpio_driver driver);
`endif

  /** Called when a new configuration is applied to the VIP */
  extern virtual function void reconfigure(svt_configuration cfg);

  /** Main thread */
  extern virtual task main();

  /** Initialize driver */
  extern virtual task initialize();

  /** Drive the specified transaction on the interface */
  extern virtual task drive_xact(svt_gpio_transaction tr);

  //***************************************************************

endclass
/** @endcond */

// -----------------------------------------------------------------------------
//svt_vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Mpjat/o4H7f5dKj+3oFbzH7aFVs6/I8KWPo1P+GDA9ejHDn5jJ29S/OeFUhpCN78
onrKM0AHWeV76X/cV6+UShLxLct38PEOrjOBdmZaMvmshxHQ2ckEtTjQfTT24vt3
1koEaHBymQKY9rcKV+NNYPARccVbHKTqdN2n4sLDkKA=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 5218      )
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
`pragma protect end_protected

`endif // GUARD_SVT_GPIO_DRIVER_COMMON_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
TwvVRijWJJXGj1SwoZII+UxpqgxNr0d+kIYwVd15vfxy2fCcfxtbQKNimZWNY2Vh
F97DnXd6opSrZAyu/us7dsXxwmunobM+2lvH1qJwWmjNnDAnYNaJcNWUll2lgEDK
PWo9hP9AgCX05wn+txsUyCS0wZRDx8mO2LpuR0uNFZc=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 5301      )
0TE/53qj3Y7PM6+rghcKsuvCcqjjJDLpNm4fDlZlgOedGTgX7e6l8B9+fCwnP6on
iiUGIunZdmYILKunk0PGJQqZFfHfee71QQFAB/baZuZUdduGolvh+ZE02KzsgWAZ
`pragma protect end_protected

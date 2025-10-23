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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
oQuX65rOZS8+aDNxizsIBYtsMg3Zm96d+nYLaY1dV1pUwkBifzvsMZPh96VbqqSd
Hri2ESYD2s2gs+Ndt6gmMo+uGuxsg6LWvrlMuRYzUBKsii3Tn2UCXQkZalMml6Bf
LsKJ7V/OIY2vvM0oSXtHmkyqGh7KqAhsBLXOvOMOxWw+D3YbihsY+A==
//pragma protect end_key_block
//pragma protect digest_block
l9jsJjD96kJSFqoER3vsDR4dRB8=
//pragma protect end_digest_block
//pragma protect data_block
uNtJ0wEb3V0/l6Lox+hLWydSn0Zfj/3NOD1nIyPYhSrDx2G4TYRAXKP/0msAdnHk
DiIYGCttzm1FoAvLV3nzD1HuipHBGjMdshvOdiMQEyGSbKgw4jS1X8tlSlpIZ/2X
sr0hgpMv0Iph+otqeHtcaknuxVkm7zWDV/3EawUsA6p0S+mLRv+aSU/MFEXVWmPN
zobU3L5V3xtLT+GJG3UtGaCXa1lm1eopYuEXkkghz1vMANj8DVH4ark9tUZYFxB8
i6pS4U4324WOD4NJYoHkQEWIMwVJquIMV2/wRm05FNnB+8Hea5oaAxt0O+x6QEKR
L+ENn47Q4iK24SDjEtnzey1Vn+Ct6mgRJTP0SoLkR0rVu1czCNbaK0XyD2zI6C1n
WQrqu/joMyuJNmgPh/scdYYtq31imG89j1UHywOAPkF2b1WV2acO5piOh839+fPB

//pragma protect end_data_block
//pragma protect digest_block
bHNkVVu+hQLTKDUHaLrksdAOwcs=
//pragma protect end_digest_block
//pragma protect end_protected

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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
8dUSwowPagY3UxlkGKia2eW4b/BXqV8+iN6KhRWGwYWPiBtSU+W9bYg+84xfWuGm
yCv/ZNxSaPSZwGKkCTRHM6ftS2jicsm6rqMJLPWKq+3jlN92NhSNLvkDLJS0PASF
ke0lZc2qLU4odV1Ma/vqbhhIdHfxQnk3FQc+xw3+ro7BM4l6enkMqQ==
//pragma protect end_key_block
//pragma protect digest_block
yCVQ0ZKEJQKXeeWehBR8u+3yX4Q=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
AcJALcHShR9L4V1hfdOlphGjDAQ=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_GPIO_DRIVER_COMMON_SV

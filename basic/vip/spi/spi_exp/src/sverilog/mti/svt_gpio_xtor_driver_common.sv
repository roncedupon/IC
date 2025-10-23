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

`ifndef GUARD_SVT_GPIO_XTOR_DRIVER_COMMON_SV
`define GUARD_SVT_GPIO_XTOR_DRIVER_COMMON_SV

import "DPI-C" context function chandle svt_reset_gpio__get(string path);

import "DPI-C" context task svt_reset_gpio__configure(input chandle           api,
                                                      input byte    unsigned  min_iclk_dut_reset,
                                                      input byte    unsigned  min_iclk_reset_to_reset,
                                                      input longint unsigned  enable_GPi_interrupt_on_fall,
                                                      input longint unsigned  enable_GPi_interrupt_on_rise);
  
import "DPI-C" context task svt_reset_gpio__drive_xact(input chandle          api,
                                                       input byte    unsigned cmd,
                                                       inout longint unsigned data,
                                                       input longint unsigned enabled,
                                                       input int     unsigned delay);
  
class svt_gpio_xtor_driver_common extends svt_gpio_driver_common;

  // ***************************************************************************
  // TYPE DEFINITIONS FOR THIS CLASS
  // ***************************************************************************

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************
  /** Reference to the C API if using the synthesizable VIP */
  protected chandle m_C_api;

  /** 
   * Static associative array of references to instances of this driver 
   * class, where each reference is a back-reference from the associated C++ API 
   * instance for the corresponding synthesizable BFM module instance.
   */
  static svt_gpio_xtor_driver_common back_reference [chandle];

  // ****************************************************************************
  // TIMERS
  // ****************************************************************************

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

  /**
   * CONSTRUCTOR: Create a new transactor instance
   * 
   * @param cfg Required argument used to set (copy data into) cfg.
   *
   * @param reporter UVM report object used for messaging
   */
  extern function new (svt_gpio_configuration cfg, svt_gpio_driver driver);

  /** Called when a new configuration is applied to the VIP */
  extern virtual function void reconfigure(svt_configuration cfg);

  /** Main thread */
  extern virtual task run_phase();

  /** Initialize output signals */
  extern virtual task initialize();

  /** Drive the specified transaction on the interface */
  extern virtual task drive_xact(svt_gpio_transaction tr);

  /** Eventually called by the C API::interrupt() callback */
  extern static function void route_interrupt(chandle          Capi,
                                              longint unsigned data,
                                              longint unsigned enabled,
                                              int     unsigned delay);

  extern virtual function void interrupt(longint unsigned data,
                                         longint unsigned enabled,
                                         int     unsigned delay);


endclass
/** @endcond */

// -----------------------------------------------------------------------------
//svt_vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
jlNG9GcQchgViHWOtNUCTv5NfcP4vG4AF15G2gCy/I4g4DJXSVdrddXBNCepm2Qu
Ea04ikUtV8s8KWYlK7BxYCePn/GtB+w4FqMbN7Fh0Hq/EbmE2cEoNC2My9faL3AG
LlHAmaXy3t6xtGK5eSikB/O/+O4pc6AxTfrXtMGTg54=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 4496      )
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
`pragma protect end_protected

`endif
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
hqaNPZ1WgGmwDiR5BOy0jeUJV5qEKertVLAfkYLQBS5isFhyFPk96d2Zn2XetnA5
gQhf4cUuvUehSbNkdUS8eP9Hb+KfBw/XMxQFIPqbhTRtYeGnqxs1Ez/sHdlIRgmZ
u2IyhnCp9y4LkiHmUFgr44CTNHT2/Kof/KMwzpMXO6Q=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 4579      )
XhgKeJkOvfK0SwjYaAbv4kZ8dQ6VYRtZA5J3vEehm/Yf5arouaeDsmKBkN7+ZJ6c
jYon73ZUaMYD5aejrhgHI57GdqC7hP811UE+toPQM4ItQKp1wVnoDiCs235Z+fdK
`pragma protect end_protected

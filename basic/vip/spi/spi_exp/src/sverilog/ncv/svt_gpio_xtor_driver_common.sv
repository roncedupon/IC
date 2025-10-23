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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
GimLtTAadImOdnqCdDjj+qGMs3AXqAOZx8cfb9qcMTcernahkrWHMNrCPfvj+lEO
SjoFOTriSQWNzFSC4nQKVQ/eS6BMQjUYACxAIIhlljPu4KdJ2NHidRHc3PW5ahpK
7HfBpCT/DY2azs67hVtmaL6P3Bb7lVIryvRaHH/lVYediOIPxNe90Q==
//pragma protect end_key_block
//pragma protect digest_block
BIJrQ/3blekKDe5C/1ZSOhhFTys=
//pragma protect end_digest_block
//pragma protect data_block
+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
QWkZXJ8vmlLEqJOWXLnSFg==
//pragma protect end_data_block
//pragma protect digest_block
mupIyaveT/kIiTTlHD2GxsaPRrM=
//pragma protect end_digest_block
//pragma protect end_protected

`endif

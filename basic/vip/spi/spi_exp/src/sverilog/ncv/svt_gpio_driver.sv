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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
wC+fVdRcOGStENchn5L9vXCVBuXV56exFdOQU+SenzdEHJgAS2Zg4C5m2HBB4XAR
ugFnuif+u3odB270UJP5/oTGBobLaah7ZDwaE+idzPYcraTVItPWi0BSmPDRdnRm
stkRrfDC3/lS9/hyB2dUeubi5y224+xH1gygu7gLCUrDEizTVb/EjA==
//pragma protect end_key_block
//pragma protect digest_block
AxdoiQ1TeeJ5x9gATlDE3icY9do=
//pragma protect end_digest_block
//pragma protect data_block
AYtWevxBMNEmF5TAoisYt8VFsUNb+cxFHhI7VFuW834Sm6BhLnlaJLBPaPgL79pX
J2b+n8CiD34e5XunwtKJsQ+La17kVYx9JCWxJruprvVqJqOv7HZKlm+w2xPxksKK
jUOZQYOsZiCfxdJw9QugbA67Ntlpe3jjYntf3esSPdf4AyG2Qgb3aJHqTRCHi47N
DiVYrZBscj2agNLji34XVXc0elPLt07LNGtiv4BMCUS2bxAC2umFjkpJIV/gMrOA
o8yw2du5S9UJSZJjawL/PWHI05llBKrJEJWzWeeQ1bFG+W4bUqhrY/ZIBYyCeBfV
LbERqiiN7zPG+kphO95F1oXGLhRwIUAqoab8RMgG92lLUAFKY5A6RgcCGdKe3rlu
pG4tVfE2PtZUh+vmqEBteY3mgQ8TakCrlaMzn2MgVWagS3nZLSrZwIEqxshPeQQY
G+zdKEURzgk9Pa9ziFSvM0REs2BLNPTxmo3jEKfg3vFK4eO3aMAjWijnKaExC1ex
e1pnBxUqk1AQJy70up5uxaCo9TGoXchuE91jMnquCJUNBZ3T0Ofkoq9g5vMXTKVq
0kdIourgNvSZTH1P812rv/a37sV/x0OKPROTxxllsmsw2tIItqfLHZVCD0LTg0uj
BpVpMZJHabC1isTzLwwJJx2Hp4iEqyr0bKG0+7zUGHALFsOu2syozkdLFUEOK31s
KBjBAHFMlVzT0+DLndWOjoDlqww3h0XOj624FfqnMmA=
//pragma protect end_data_block
//pragma protect digest_block
cfgG+yaPsXW26hbj7MQu8JlhwKc=
//pragma protect end_digest_block
//pragma protect end_protected

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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
cgk7GhKUcHbok4iNT4UJual8AgQBpHIOcfO8pxb8oYoa2/RlkgzdfLVnZFHUCO84
nWNQ7rEX/+z50fu/61PQUrx1ahiwEWMZ66bIH1GtITkMwyC6Xlhv2Np2jlV60pxl
6kS+p4LGey30olHsvJ437s/s2WhmM32y1Uoi0ev6CF+C+Af14gUFUA==
//pragma protect end_key_block
//pragma protect digest_block
UREqv+6AmLwafP/Sdr6bO7+Gez4=
//pragma protect end_digest_block
//pragma protect data_block
pM6EjbitQ9uIAShWpNCyLC1WJDyEspsFpLyHNT8srnmX2wMkdVMGa92w8jMw4f1r
IG88nE3YUUhMFT7gu5Mtg1/PqRCvDJPtFez1p/C4xgC5nRxybF/m5Z+FcSyph26O
8PJpYmigscAmjpmt/QQphLUBm3jj2fTt64OmiSqIeBdj1mZyAS8jfgthx/t1emS8
Gf6eTFgojgZCSWPdqt5VrLhb/wsM85vBVs97oTUbc9Zd0e5K0dI92OWUZx/6r7WS
NxEBpZfNzpAS70qd0841p30yobrHhIDGYdD0Dt9AxK8lVKUytYVqWlurYdfqFGSQ
4jkeiY8YKGwFYmkth5Adi70AWrH/W+aShxzxmaCQ8GakmH5W/R3mGTsrXBG5py7u
I8m5toym1mcmWgPwW8B2Ne7Z8IaDejd1lwnG+wwIfPVLG6fweLAkmAnaYE9od/Dp
+x7kHSUw0ylHgm0RjhXKmSDSl33DpLPBQ8WVD//6sndkUsgidmpSnWpx1/wlDN1z
A9ntUlcjoa6VbbiS4qBxAA==
//pragma protect end_data_block
//pragma protect digest_block
L+s1mmaBmf6kiat5DJwhC0ziRZw=
//pragma protect end_digest_block
//pragma protect end_protected
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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
hmSNTCMWp4d1WGe0LfAWD8IqroX52vrBoXUJFWJgRgZnoP8c8gi+o8eoPNFu1UHc
1/3SFWDAxgh6Rn9CRr/svK9coSAvxnY6aHepHx2nb/gUrDJ3K+eAFv4f+OM9IHCz
urTvZnCIS8rX5liBQBYNWUTKeLDd2hrImaSC5kzPJLcdAFFTlhOW0g==
//pragma protect end_key_block
//pragma protect digest_block
34ttoMKUd3PXVdaERgwKECmcJR4=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
dWFvxr7L62hDPrvZQNXqYf7EHcQ=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_GPIO_DRIVER_SV

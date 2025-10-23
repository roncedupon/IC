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

`ifndef GUARD_SVT_GPIO_DRIVER_CALLBACK_SV
`define GUARD_SVT_GPIO_DRIVER_CALLBACK_SV

typedef class svt_gpio_driver;

/**
 *  Additional protocol-specific callbacks
 */
class svt_gpio_driver_callback extends svt_callback;

  //----------------------------------------------------------------------------
  /** CONSTUCTOR: Create a new callback instance */
`ifdef SVT_VMM_TECHNOLOGY
  extern function new();
`else
  extern function new(string name = "svt_gpio_driver_callback");
`endif

  /** 
   * Called after the traaction has been received from the sequencer, before its execution
   * begins.
   * 
   * @param driver A reference to the svt_gpio_driver component that is 
   * issuing this callback.  The user's callback implementation can use this to
   * access the public data and/or methods of the component.
   * 
   * @param xact A reference to the descriptor for the transaction that is about to start.
   *             Modifying the transaction descriptor will modify the transaction that will be executed.
   * 
   * @param drop If set, the transaction will not be executed.
   */
  virtual task post_input_in_get(svt_gpio_driver       driver,
                                 svt_gpio_transaction  xact,
                                 ref bit               drop);
  endtask

  //----------------------------------------------------------------------------
  /**
   * Callback issued by the component after completing a transaction or detecting an interrupt condition,
   * just prior to placing the transaction in the analysis port.
   *
   * @param driver A reference to the component object issuing this callback.
   * @param xact   A reference to the complete svt_gpio_transaction descriptor or interrupt
   *               The transaction must not be modified.
   */
  virtual function void pre_observed_out_put(svt_gpio_driver driver,
                                             svt_gpio_transaction xact);
  endfunction

  //----------------------------------------------------------------------------
  /** 
   * Coverage callback method called after a transaction has completed or interrupt condition detected.
   * 
   * @param driver A reference to the svt_gpio_driver component that is 
   * issuing this callback.  The user's callback implementation can use this to
   * access the public data and/or methods of the component.
   * 
   * @param xact A reference to the descriptor for the completed transaction or interrupt.
   *             The transaction must not be modified.
   */
  virtual function void observed_out_cov(svt_gpio_driver driver,
                                         svt_gpio_transaction xact);
  endfunction
endclass

//svt_vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
fobJhKCLgfRFzDPwn/lMXzP7CaJa9z6RZvuCKtTlgNvpA/2HMiulOjE72cPzeKIO
CxAtm5bOdk0MVznPQJfhJ6lKieyR1rVXn/NzsvUIr6LIN7+P4yBUCH8hWsnREtyM
1gqzalTfuWtIkiCi3BlB94k+mLdMFWHSdfMH2Gpz9FQ=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 430       )
OpG0GOkRlkoMytOGUMzT7hClDpp3rh2nd0102Jku2/EohVl/Xh/E3d2w8C7VVXNN
ym8E5zC5ii0g8oQnwlofUwFQJbZceJxzCUSZM5NUhCKxfKolJjsqM5NSjM8bq33Z
jld1AgsCQNvd+xEZlE1GS6rLZZmqyPN7g2pxP3N86QrucXBYvhEA+tHfiOFRGTXu
DEvUJ2vdV2TRkQWmEwPzRUivMJORDTP/AU8TQkGM6OZZBtEey5Cdsw/BNdTXTlmv
nE9m4OJReebw6t0cFxZ9FatchoR/zg7guFd3lPDfb9c99/MsFs778T0DAUf37FD2
IcEDKE3IN0e4vergx3kw+NqcROr1qovYptVGYPVPu5P1ncKJEpvMzvN2wCRaP+GG
aLoX+BSyvMBwBBe29v6zRhrAKH5WVPoz7rLprBewJFi9t/UPDJEUQyjZ7YR4ZMzO
Y2IEJfi3ar5VfkS02YPrshs8h0QLBm+l656bFJBImm+516DD2TaFF8lx5I1RWWnq
Yp4XHZqXSnzRDzWeLQknWmeeeZgx7ukvryUKCLZF869JGjOEkKgTjUt+rWPGuU4Q
`pragma protect end_protected

`endif // GUARD_SVT_GPIO_DRIVER_CALLBACK_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
cb0R8L7/OyUSDdzez2O63ZuiVaC+I+wenihoDUi+7G1ElsCJkYHTyJaAdvu4y2a+
IRcJ5hil+lAMAi49Unq2EaA983FJgbrIB4asKuqrX/79qxZ/TJ8xnuBwBppB9Pbw
mMSv5iOn557Zg9TiTIR/D3dNqUEtzQq42ukH21hRHQ8=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 513       )
1RtGPykzpchutUKcZ1k7IN2irhrEfPSYUZzEmDkC4Gjej4Tkmspb4hvRDNCY4M4m
dPpRACrzx+74HkDDdVTma608mHoTlrEgFqUi5Kfb07tvvmDsunB1gRNQ7u/BiLZW
`pragma protect end_protected

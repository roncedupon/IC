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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
irtpYHrJn+V4YtuhJtqd8D+AQC2E1DZq5lQYntjQTpq5fkO3nv7i9fV+BiY8UEHW
mnNwGUM/0WtXirUKL4XGE1leVjcIBxDYDLSm+5qtN1Vf1QRQ7ksfuXX2o9LJTdtH
a4toelZYVAVfrXVbVsT0UCUOjl9UKh+jEznTMoJVq8Vt96h4ruln/w==
//pragma protect end_key_block
//pragma protect digest_block
ft6K0zu2GswGH2gOZLWldgqyEMI=
//pragma protect end_digest_block
//pragma protect data_block
tIkGxxDwEfJovKzN0ZF3GRPcwQ/AMb99cc6QunAaUFxeeXidk41SLvCIICt45M0W
yBSCzf12JFhav5eGPguECK2JABURqQgNhSYH6radDuARqj+OGWV6WW8+PfPHTfxD
nhaNh2ToV6gh1sg4hnmYCnSj9Tq6gNHWR0qVpMswHltxrDC+N+VqTjusHAehK3dz
5InI2MlvET++xEN4zqDMSh88k/5LGsndIVr9HZKWsEC3m6VKwOgejjTvEvB2b1Q+
1lIFtmzZFONxCYVaSSBuL7Q01oYVoCyIvWrpmC3e2yeB+SIdXWI9ty4fqnoU2DsF
5f3fmkbUxm4TpsHCf5xaivH80eH9J3H+wwmHy2pTzi8gr5/IEipoXSVCSlXoF3Pc
JgpzKdELCjFO0MXrv3UBY3qWBJMQa0YvRdNIIRmsTYwuw/IgQZH7wVKMYSDOXWXr
fEy/7IFx6BkAkSFMpL/ciA8OJ0cFnBmrnjTYmKSXa3BhlIwF3Su9l4IWJmqOO0Pu
3rKNDlRLwYhDJCWd3QX2ZOdck9TyKir4wYj28tVHl9KELaUCf3YG6VqPSTi1v+Wa
G0HFm6nbiG3eCZXO+ptnLuBhX7ZT2OinxDOlYsDvUHyXgZYIoX5Y+mDY6TUwiEhA
ymRD63pDbvBAjAzmvc/fc+r2t0kV1A2pNXu7jERj1hY1ZuAu1f0rNi+tixH25z+w
U5JoPi1XeaR87tE36u+/flHFu4cvQnHsX1kP5ysyKL0X4jUoRlbY9mtwGWSIrQPc
N2Gy4TSWh+vVQNKE90H6W7DX3rPpkg0IU6IKUxcQzBo=
//pragma protect end_data_block
//pragma protect digest_block
iNDciZmJ2++2yVKPcq6QC2pJ4o0=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_GPIO_DRIVER_CALLBACK_SV

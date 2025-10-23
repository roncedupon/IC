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
`protected
CV?@OC<a7&AHXNB,?1O5NSbTK#5:W]Z,YW^0_7cCH^[FS(AV_?gN0(L87NU^Y[@X
@BCM:g[[<SNDV4\+JCW(W)H9UdT.2eZG(@NW3<HWdNV-2\D?6gNgC/;2EP0^QJW>
=I.WZH5ZS:;QHKR-=)b(UQN498JKWa-^CN^FO2B?0eCNSK3N;[115)FTUf,O]G2a
fR)Z5C@H2##,3Y5@TeTU[>21#D[9ad.8Q@ML1Md(WZ0[cH4OUQ0C1bVBV>._F:BI
/b2VfI].+\1cQ-59OeWR;#84?^fN5L&eYM/8\?2[BP<OT3S]2RY)gEBIUDgJ(Wa[
/YeI??[CA89]c/VDPOGS=7.2SgW\OOFEKd=A3N\Sd&IV3LX^[1=1G@IHD-@[J-7C
gG6=ccP^AKK_YfK4#)#3T&L4+&e;_T<5X8YF\KKPBBV@M.C^->3OUG/Z;7PGP_KB
Z#(,Q,@I^)Ff8f6ZW,/GIB>dfb8L^VZ7NW41B_-OYJ4_VY6bJFfHSI6:UVEad:MJ
]VSG_XJ/EQ>9:4f_;BO)I7>d4$
`endprotected


`endif // GUARD_SVT_GPIO_DRIVER_CALLBACK_SV

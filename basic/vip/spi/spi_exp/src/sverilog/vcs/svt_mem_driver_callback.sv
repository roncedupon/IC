//=======================================================================
// COPYRIGHT (C) 2012-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_MEM_DRIVER_CALLBACK_SV
`define GUARD_SVT_MEM_DRIVER_CALLBACK_SV

/**
 * Generiic memory driver callback class.
 * Defines generic callback methods available in all memory drivers.
 * Protocol-specific drivers may offer additional callback methods
 * in a protocol-specific extension of this class.
 */
class svt_mem_driver_callback
`ifdef SVT_VMM_TECHNOLOGY
  extends svt_xactor_callback;
`else
  extends svt_callback;
`endif

  //----------------------------------------------------------------------------
  /** CONSTRUCTOR: Create a new callback instance */
`ifdef SVT_VMM_TECHNOLOGY
  extern function new(string suite_name = "", string name = "svt_mem_driver_callback");
`else
  extern function new(string name = "svt_mem_driver_callback", string suite_name = "");
`endif


  //----------------------------------------------------------------------------
  /**
   * Called before the memory driver sends a request to memory reactive sequencer.
   * Modifying the request descriptor will modify the request itself.
   *
   * @param driver A reference to the svt_mem_driver component that is 
   * issuing this callback.  The user's callback implementation can use this to
   * access the public data and/or methods of the component.
   * 
   * @param req A reference to the memory request descriptor object
   * 
   */
  virtual function void pre_request_put(svt_mem_driver driver, svt_mem_transaction req);
  endfunction


  // ---------------------------------------------------------------------------
  /** 
   * Called after getting a response from the memory reactive sequencer,
   * but before the post_responsed_get_cov callbacks are executed.
   * Modifying the response descriptor will modify the response itself.
   * 
   * @param driver A reference to the svt_mem_driver component that is 
   * issuing this callback.  The user's callback implementation can use this to
   * access the public data and/or methods of the component.
   * 
   * @param rsp A reference to the memory response descriptor
   * 
   */
  virtual function void post_response_get(svt_mem_driver driver,
                                          svt_mem_transaction rsp);
  endfunction

  // ---------------------------------------------------------------------------
  /** 
   * Called after the post_response_get callbacks have been executed,
   * but before the response is physically executed by the driver.
   * The request and response descriptors must not be modified.
   * In most cases, both the request and response descriptors are the same objects.
   * 
   * @param driver A reference to the svt_mem_driver component that is 
   * issuing this callback.  The user's callback implementation can use this to
   * access the public data and/or methods of the component.
   * 
   * @param req A reference to the memory request descriptor
   * 
   * @param rsp A reference to the memory response descriptor
   * 
   */
  virtual function void post_response_get_cov(svt_mem_driver driver,
                                              svt_mem_transaction req, svt_mem_transaction rsp);
  endfunction

  //----------------------------------------------------------------------------
  /**
   * Called when the driver starts executing the memory transaction response.
   * The memory request and response descriptors should not be modified.
   *
   * @param driver A reference to the svt_mem_driver component that is 
   * issuing this callback.  The user's callback implementation can use this to
   * access the public data and/or methods of the component.
   * 
   * @param req A reference to the memory request descriptor
   * 
   * @param rsp A reference to the memory response descriptor
   */
  virtual function void transaction_started(svt_mem_driver driver,
                                            svt_mem_transaction req, svt_mem_transaction rsp);
  endfunction

  //----------------------------------------------------------------------------
  /**
   * Called after the memory transaction has been completely executed.
   * The memory request and response descriptors must not be modified.
   * In most cases, both the request and response descriptors are the same objects.
   *
   * @param driver A reference to the svt_mem_driver component that is 
   * issuing this callback.  The user's callback implementation can use this to
   * access the public data and/or methods of the component.
   * 
   * @param req A reference to the memory request descriptor
   * 
   * @param rslt A reference to the completed memory transaction descriptor.
   */
  virtual function void transaction_ended(svt_mem_driver driver,
                                          svt_mem_transaction req, svt_mem_transaction rslt);
  endfunction

endclass: svt_mem_driver_callback
   

//svt_vcs_lic_vip_protect
`protected
(BQ6f^A-&ZE;NZ@T)\CM)<GAH/VdYaMF?(5HAH4\6:<@.L-1-IV)7(7QB]&,8A=J
#Y&RIC=7&)0e39@BTHe2F]<JZ/ge^DNId)()cD4V]GDfR3&+VNH/@/Q,2_X+8[26
SBfK]U;O13]2HfL&?^>OM>U5E^JX?IdMI6FO-YZW:;ZS5_M[#cV=bP\#+6Fb2d/;
/H0.PV&,Fc?X@X_XC1:[[#QD1=X=CJ+4J/;+P-SW)MJL35W_cV\3g>,)IVfKfI8]
3(XO#\Lb;0)DI2FgW((ZUYd^8=YafbE47KBHO.bD/3S-KIF28)^:8;6cI#-[^df^
9NR<V^(N>G930aTV]=2^AA^P]#0;@MC+f-cKdZN@LFE@F^cKME+]EFZ3@U?&HXe.
f<;N4TG?F0?+8IG(d6B9/PF##7M-7OV_@RWcL&.CdEc/T9M(4d^Kc-RMc=K?P;[]
./Ddg0Jbf:1dI.#dDL-R+[;QC[,-X(RH02;]+S=K^>a&2TD3PI:;_04](J?7G@28
:PU-323;+AT8aR31BE37Fb,AC1U(8QTEVPWU\3[_;ZQ7)V4B#0?=KK0J/:D..\:d
b1g_KSQ]Z&<94=W#dSFf0(aVOHeBK2]NA<5e[HbKJ.S=.K^f-;dS5(ZRcXHML8Cf
1B:&2c(\)A>)?4GC9BI0PJaV6$
`endprotected


`endif // GUARD_SVT_MEM_DRIVER_CALLBACK_SV

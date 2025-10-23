//--------------------------------------------------------------------------
// COPYRIGHT (C) 2013 SYNOPSYS INC.
// This software and the associated documentation are confidential and
// proprietary to Synopsys, Inc. Your use or disclosure of this software
// is subject to the terms and conditions of a written license agreement
// between you, or your company, and Synopsys, Inc. In the event of
// publications, the following notice is applicable:
//
// ALL RIGHTS RESERVED
//
// The entire notice above must be reproduced on all authorized copies.
//--------------------------------------------------------------------------

`ifndef GUARD_SVT_DISPATCH_SV
`define GUARD_SVT_DISPATCH_SV 

// =============================================================================
/**
 * This class defines a methodology independent dispatch technology for sending
 * transactions to downstream components.
 */
class svt_dispatch#(type T=`SVT_TRANSACTION_TYPE);

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  /**
   * Shared vmm_log used for internal messaging.
   */
  vmm_log log;

  /** Channel used to dispatch the transaction to the downstream component. */ 
  vmm_channel chan;
`else
  /**
   * Shared `SVT_XVM(report_object) used for internal messaging.
   */
  `SVT_XVM(report_object) reporter;

  /** (Optional) Sequencer used to dispatch the transaction to the downstream component. */ 
  svt_sequencer#(T) seqr;

  /** (Optional) Analysis Port used to dispatch the transaction to the downstream component. */ 
  `SVT_XVM(analysis_port)#(T) analysis_port;

`endif

  //----------------------------------------------------------------------------
  // Protected Data Properties
  //----------------------------------------------------------------------------

`ifndef SVT_VMM_TECHNOLOGY
  /** Sequence used to dispatch the transaction to the downstream component via a downstream sequencer. */ 
  protected svt_dispatch_sequence#(T) dispatch_seq;
`endif

  /** Semaphore to make sure only one transaction displatch occurs at a time */
  protected semaphore dispatch_semaphore = new(1);

  //----------------------------------------------------------------------------
  // Methods
  //----------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  /**
   * CONSTRUCTOR: Create a new svt_dispatch instance.
   * 
   * @param log vmm_log instance used for messaging.
   */
  extern function new(vmm_log log);
`else
  /**
   * CONSTRUCTOR: Create a new svt_dispatch instance.
   * 
   * @param reporter `SVT_XVM(report_object) instance used for messaging.
   */
  extern function new(`SVT_XVM(report_object) reporter);
`endif

  //----------------------------------------------------------------------------
  /**
   * Dispatch the transaction downstream.
   *
   * @param xact Transaction to be sent.
   */
  extern virtual task send_xact(T xact);

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
ICf6SayaoKato9n9nuohhS2JfvtLpzr+ArJz43X7XWQQyRl8MxiI0L0iEdrsK7zc
sm6glFx6CN+XXKpOLX3kS2XX5+b7KO+QkzhAOrzat5c7BrQzfO7KXlRcBgh1vUQy
WkBgYyfHtDu9tiLLqVpQwbP7ZQHZ9CgrCsWVpKqI1LZK9VyN6YJ3Uw==
//pragma protect end_key_block
//pragma protect digest_block
xA4t7NXd+eReGN8j7OHu6roEZ0I=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
3/BRJ1lrdM3FTGh1/CVhyJgFQHw=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_DISPATCH_SV

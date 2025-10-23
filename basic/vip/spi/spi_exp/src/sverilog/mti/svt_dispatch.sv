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
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
SaGXZquVIVfQUmOppTlUviYASJLTcStm1XqqDL15vhhr2UYRIVEkWdw3y2e/iaoj
P6J0R5b5WwYa/82l7IR5RxC+jW6BNnkAGCNFOROQtDQ4mF48zy2SoCTEuUL5Zzaz
OtJ+qPWStYHNhEBJoMKEx7NHVZkhT4dKEVCA4h1ibLQ=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1827      )
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
BxsL3N0S9Xgm1TGZI8vVQA==
`pragma protect end_protected

`endif // GUARD_SVT_DISPATCH_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
PI6xH462PY86NJwI+K4KNk0caJZY/a8OCKSg0Cl1/XXSJU8z6k7YbFJVvRKrHD2V
DEuj3SfQv8eQEuy0zaYs+FxXTdSqogwyEWJdP96B3F1zl5XQ2Dy8dGjZHsI2FDRR
E9YwKSkvoJL6CodstfTUXiaxNUjwCeBLcqeqiCKd2Po=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1910      )
AKuARe72uLfWuVosfUsiFi/qc8FR7kSxC2HvLTuoYQWfoFXdCsQvgv8wX17IVRCW
8VEVAaGgBcJZMHVHE37js3zSJ3sbV7ahD5fgZ0d9Kg8aStBkMdEaOXpo58v2m038
`pragma protect end_protected

//--------------------------------------------------------------------------
// COPYRIGHT (C) 2012-2014 SYNOPSYS INC.
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

`ifndef GUARD_SVT_DATA_STREAM_SV
`define GUARD_SVT_DATA_STREAM_SV 

/** @cond PRIVATE */

// =============================================================================
/**
  * This class defines a generic Data Stream representation, for easily managing
  * the access to the transactions flowing through this data stream. The class
  * provides for basic 'passive' and 'active' dataflow, with basic accessor
  * methods for both of these flows.
  */
class svt_data_stream#(type T=`SVT_TRANSACTION_TYPE);

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Protected Data Properties
  //----------------------------------------------------------------------------

  /** Next active transaction recognized in the data stream. */ 
  protected T active_xact = null;

  /** Next passive transaction recognized in the data stream. */ 
  protected T passive_xact = null;

  //----------------------------------------------------------------------------
  // local Data Properties
  //----------------------------------------------------------------------------
   
  /** Semaphore to control simultaneous set_active_xact calls.  */ 
  local semaphore active_xact_semaphore;

  /** Semaphore to control simultaneous set_passive_xact calls.  */ 
  local semaphore passive_xact_semaphore;

  //----------------------------------------------------------------------------
  // Methods
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new data stream instance.
   */
  extern function new();

  //----------------------------------------------------------------------------
  /**
   * Method designed to make it easy to wait for the arrival of the 'next' active
   * transaction.
   *
   * @param xact Active transaction delivered upon arrival.
   */
  extern task get_active_xact(ref T xact);

  //----------------------------------------------------------------------------
  /**
   * Method used to set the active transaction.
   *
   * @param xact New active transaction to be associated with the stream.
   */
  extern task set_active_xact(T xact);

  //----------------------------------------------------------------------------
  /**
   * Method to make the active sets blocking. This should be used to avoid overrides on the set.
   */
  extern function void enable_blocking_set_active_xact();

  //----------------------------------------------------------------------------
  /**
   * Method designed to make it easy to wait for the arrival of the 'next' passive
   * transaction.
   *
   * @param xact Passive transaction delivered upon arrival.
   */
  extern task get_passive_xact(ref T xact);

  //----------------------------------------------------------------------------
  /**
   * Method used to set the passive transaction.
   *
   * @param xact New passive transaction to be associated with the stream.
   */
  extern task set_passive_xact(T xact);

  //----------------------------------------------------------------------------
  /**
   * Method to make the passive sets blocking. This should be used to avoid overrides on the set.
   */
  extern function void enable_blocking_set_passive_xact();

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
L1haoYeoOHPq+SgrabP7OEUQ6K5q/POWNxoajH53GmMK2e+ROgUQSObY3XLmuxPY
WbngAh79/N66ceF2Q3yFjZDk+uw5niH8VIBAoffoZCpqOfZutTHSXkcA8jaLLvIo
dBAghRrjNY0s07WGWbFbfzVUWnJaGbU/zL/+ryzu6Z4=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1825      )
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
k8R4aVi0S3m5Jwzc9IAfCg==
`pragma protect end_protected

// =============================================================================
/** @endcond */

`endif // GUARD_SVT_DATA_STREAM_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
TA7vS9GcFengmR3UBzP6mV33kQbgs8J4es9o8JBPplja+qQCpAZqS36BCs/5uB5X
SpIZUkFwlrf/1fxCZUcYUxRFlpNLO4hv7NswZRAqK1Njxk8Eb9t69EkKUDtkhdVy
eqBG3v8sYl6992e1AAMHnuyEnF3G4d1WJT/DmqrfzYo=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1908      )
Dkfj/a62uq+kZytL74V3ruXJnyJj15ZsvCF5/dVR5pqtAotVfVMvHCCan8XH/Ldi
m0vavIAKHIrDZLIWlRvU9u0fCF/b5oxtSkkHmvRksbDkl+REIWH6lgbup5ClFS1e
`pragma protect end_protected

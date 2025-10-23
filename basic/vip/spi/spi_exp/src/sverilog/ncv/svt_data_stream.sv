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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
UWAmd2C4xhn+IC9QJ5Er0sHvjEBlk1QeQFvqQ8XaWp2g47xn+wVZ/XLtM9qmygdG
KfO+Zn+pJBPkVImpJcrKcKGu3P2xhO9XP1tRcUAYvpWzaGFMszXt1X/C7soL0Rgt
oGwgOnRJfUqC5TOKMtpSRrDMEeDvRG4IxqCL5U+/pYkbQD/x6niD8w==
//pragma protect end_key_block
//pragma protect digest_block
9K1UuOZoRdyNJMi+naWcPz8XAO4=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
B6UNqjgxbDs/Cihpbn0AsCSYcKI=
//pragma protect end_digest_block
//pragma protect end_protected

// =============================================================================
/** @endcond */

`endif // GUARD_SVT_DATA_STREAM_SV

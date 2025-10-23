//--------------------------------------------------------------------------
// COPYRIGHT (C) 2014-2015 SYNOPSYS INC.
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

`ifndef GUARD_SVT_DOWNSTREAM_IMP_SV
`define GUARD_SVT_DOWNSTREAM_IMP_SV 

// =============================================================================
/**
 * This class defines a component which can be used to translate input
 * from a downstream 'put' or 'analysis' port. 
 */
class svt_downstream_imp#(type T =`SVT_TRANSACTION_TYPE) extends `SVT_XVM(component);

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Protected Data Properties
  //----------------------------------------------------------------------------

  /** Queue for next incoming transaction coming in from the downstream provider. */ 
  protected T next_xact_q[$];

  //----------------------------------------------------------------------------
  // Methods
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new downstream implementor instance.
   */
  extern function new(string name = "svt_downstream_imp", `SVT_XVM(component) parent = null);

  //----------------------------------------------------------------------------
  /**
   * Method designed to make it easy to wait for the arrival of the next incoming
   * transaction.
   */
  extern virtual task get_next_xact(ref T next_xact);

  //----------------------------------------------------------------------------
  /**
   * Analysis port 'write' method implementation.
   *
   * @param arg The transaction that is being submitted.
   */
  extern virtual function void write(input T arg); 

  //----------------------------------------------------------------------------
  /**
   * Put port 'put' method implementation. Note that any previous 'put'
   * transaction will not be lost if there has not been an intervening 'get'.
   *
   * @param t The transaction that is being submitted.
   */
  extern virtual task put(T t);

  //----------------------------------------------------------------------------
  /**
   * Put port 'try_put' method implementation.
   *
   * @param t The transaction that is being submitted.
   * @return Indicates whether the put was accomplished (1) or not (0).
   */
  extern virtual function bit try_put(input T t);

  //----------------------------------------------------------------------------
  /**
   * Put port 'can_put' method implementation.
   *
   * @return Indicates whether a put is safe (1) or will result in a loss of
   * previous values (0).
   */
  extern virtual function bit can_put();

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
GPetTeumN9l4JsSj478K9XIyTbB4vEDfhbTEIDLV2EJ739qKgwsVyc/XFxg+tZUj
RsYe9TpvruDZ9v7CEGn9lMDeOe2tyunw45YJd4qfjQ0i0A/XCbheAuFg9UBE25ea
Tw0pzjdzNVUZld/YKUgA4jOCeoK/a8oZCMFhHJd0vVOifGbZ9Up6zg==
//pragma protect end_key_block
//pragma protect digest_block
2j2nvnOaljqJ5vw/hqEizFvJ3fE=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
FO0x4tsfKTJLLi5z5rpL6CeISJA=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_DOWNSTREAM_IMP_SV

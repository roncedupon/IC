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

`ifndef GUARD_SVT_DISPATCH_SEQUENCE_SV
`define GUARD_SVT_DISPATCH_SEQUENCE_SV

// =============================================================================
/**
 * Sequence used to queue up and dispatch seqeunce items. This sequence supports
 * two basic use models, controlled by the #continuous_dispatch field.
 *
 * - continuous dispatch -- This basically loads the sequence into the provided
 *   sequencer, where it runs for the entire session. The client simply keeps a
 *   handle to the svt_dispatch_sequence, and calls dispatch() whenever they
 *   wish to send a transaction.
 * - non-continuous dispatch -- In this mode the sequence must be loaded and
 *   run on the sequencer with every use. This can be rather laborious, so
 *   the continuous dispatch is strongly recommended. 
 * .
 *
 * The client can initially create a 'non-continuous' svt_dispatch_sequence, but
 * once continuous_dispatch gets set to '1', the svt_dispatch_sequence will
 * continue to be a continuous sequence until it is deleted. It is not possible
 * move back and forth between continuous and non-continuous dispatch with an
 * individual svt_dispatch_sequence instance. 
 */
class svt_dispatch_sequence#(type REQ=`SVT_XVM(sequence_item),
                             type RSP=REQ) extends `SVT_XVM(sequence)#(REQ,RSP);

  /**
   * Factory Registration. 
   */
  `svt_xvm_object_param_utils(svt_dispatch_sequence#(REQ,RSP))

  // ---------------------------------------------------------------------------
  // Public Data
  // ---------------------------------------------------------------------------

  /** 
   * Parent Sequencer Declaration.
   */
  `svt_xvm_declare_p_sequencer(`SVT_XVM(sequencer)#(REQ))

  /** All messages originating from data objects are routed through `SVT_XVM(root) */
  static `SVT_XVM(report_object) reporter = `SVT_XVM(root)::get();

  // ---------------------------------------------------------------------------
  // Local Data
  // ---------------------------------------------------------------------------

  /** Sequencer the continuous dispatch uses to send requests. */
  local `SVT_XVM(sequencer)#(REQ) continuous_seqr = null;

  /** Next transaction to be dispatched. */
  local REQ req = null;
   
  /** Indicates whether the dispatch process is continuous. */
  local bit continuous_dispatch = 0;

  // ---------------------------------------------------------------------------
  // Methods
  // ---------------------------------------------------------------------------

  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_dispatch_sequence class.
   *
   * @param name The sequence name.
   */
  extern function new(string name = "svt_dispatch_sequence");

  // ---------------------------------------------------------------------------
  /**
   * Method used to dispatch the request on the sequencer. The dispatch sequence
   * can move from 'single' dispatch to 'continuous' dispatch between calls.
   * It can also move between sequencers between calls while using 'single'
   * dispatch, or when moving from 'single' dispatch to 'continuous' dispatch.
   * But once 'continuous' dispatch is established, attempting to move back to
   * 'single' dispatch, or changing the sequencer, will result in a fatal error.
   *
   * @param seqr Sequencer the request is to be dispatched on.
   * @param req Request that is to be dispatched.
   * @param continuous_dispatch Indicates whether the dispatch process should be continuous.
   */
  extern virtual task dispatch(`SVT_XVM(sequencer)#(REQ) seqr, REQ req, bit continuous_dispatch = 1);

  // ---------------------------------------------------------------------------
  //
  // NOTE: This sequence should not raise/drop objections. So pre/post not
  //       implemented "by design".
  //
  // ---------------------------------------------------------------------------

  // ---------------------------------------------------------------------------
  /**
   * Sequence body() implemeentation, basically sends 'req' on the sequencer.
   */
  extern virtual task body();

  // ---------------------------------------------------------------------------
  /**
   * Method used to create a forever loop to take care of the dispatch.
   */
  extern virtual task send_forever();

  // ---------------------------------------------------------------------------
  /**
   * Method used to do a single dispatch.
   */
  extern virtual task send_one();

  // ---------------------------------------------------------------------------
  /**
   * No-op which can be used to avoid clogging things up with responses and response messages.
   */
  extern virtual function void response_handler(`SVT_XVM(sequence_item) response);
  
  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//svt_vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
JSJobbNrWt7ggML5Um3Y+hXs4U5Em5Trk5oZKdW+/NC67hqzmydJJxwqyW4Y5qNJ
XQmsU0ECduzlxgmv7t8gXJaTjnUcuezEOzlQqL9uzkoZIIUmGZ2bOhEqVnYtgLyM
+K3dOi3ME7YJN/H+lsPrOd8OnOOSRlu1zxB3Nbi4C89nn6/wmQT1KA==
//pragma protect end_key_block
//pragma protect digest_block
7BRxST1Eoe2+rIBPcJuDCsECbnQ=
//pragma protect end_digest_block
//pragma protect data_block
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
egYXuAaffWKY2GCYvTXLDg==
//pragma protect end_data_block
//pragma protect digest_block
11IdKw+SQWImqdHOKvrJe2rE8/o=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_DISPATCH_SEQUENCE_SV

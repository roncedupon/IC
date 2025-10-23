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
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
YT16YZrPs1ZFUKWmjYWoSIBlUw3114/XlDEgYtEB3rvTUVyPaNEN7vpakr4bgkde
Csu3MdYadFqtEKE42j7jIoM8gcrm8DFKYvhflhgH8qaoONq/rkUhJvllheB0F9yV
DsJBSZx/+2V7IhK3Cybhb+O3qf4lLhmooFJNwIRD6XQ=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 3347      )
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
`pragma protect end_protected

`endif // GUARD_SVT_DISPATCH_SEQUENCE_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
HVjWomNH2rQ7EdU1f/oERhfDA+VSHoj3n8wgbiP8oiDoEY41aVKb2VzGMc7MPILo
Is8JQK3TpfR8Wlqn1PZ0vqTJ169UMwBqF0o+CpRvNdId0/o/avgqfwNd9GHniv1Z
RmlwpBfQbq6rn8kogfeajGSmWDV09TP+z7qDwGt66TY=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 3430      )
T7fwpRAgT0VTIt3cFQ8j68X0XxSzo0ARsZ6ugd6ApVNgjhBVFkxVAcpE0SM2e7a3
YFOxA07whrA/mFlw6aTKc8+9h+isjBXYtmiuWG+pYBE/0cBBlgsqoZ0fLITsX4QS
`pragma protect end_protected

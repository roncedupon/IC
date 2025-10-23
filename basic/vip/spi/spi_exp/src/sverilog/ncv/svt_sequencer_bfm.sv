//=======================================================================
// COPYRIGHT (C) 2010-2015 SYNOPSYS INC.
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

`ifndef GUARD_SVT_SEQUENCER_BFM_SV
`define GUARD_SVT_SEQUENCER_BFM_SV

virtual class svt_sequencer_bfm #(type REQ=`SVT_DATA_BASE_TYPE,
                                      type RSP=REQ) extends svt_sequencer#(REQ, RSP);

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  /** SVT message macros route messages through this reference */
  `SVT_XVM(report_object) reporter = this;

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

  /** 
   * Flag that indicates the driver has entered the run() phase.
   */
  protected bit is_running;

`ifdef SVT_OVM_TECHNOLOGY
  /**
   * Objection for the current SVT run-time phase
   */
   ovm_objection current_phase_objection;
`endif

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
SD4tCD303GuQQgVnECGE+j73C8+EUJI0OJ1oTiE6MqdUuaW3SO/LNWuxV41/bm4r
Av8iDMJhlpWQkBnGFJzODPDZwuZWTz0dqUGmyBHIbBQXA57PmEsXWiPdX/kvUIVu
7T0wN5k4ZbsNNjtf2DaU5dvXBC/DN/bu5o1RT9n6FKMoyG41Wb1eYA==
//pragma protect end_key_block
//pragma protect digest_block
WQTV2B+7fnyZAVC5tnaDi4tbYF0=
//pragma protect end_digest_block
//pragma protect data_block
Rf7Epv6cy3GuDwf1S25ysNBUOMr9aztA7k5tpfSADH5mU5TUBKWi9Ee8X3V7ACkz
qPk6bjJBY6777vy0iWc5FjgopmswRbCGB0VUtbLv7T5DwdaWRaijR44K/1T1qPLU
O2s9U1MFUGjPS+1WqTJa0ubRLFuIz2Vi58dXg7bjdwkciCdds8Apc+8SIjl75AM2
wpRfmDk9TcIyFyhKrBkUzE+gYk/Cunm0WhGUV9OsP5nL1s5SF98gQtGFSR8n9I25
O8dI4U9eAEtmirZ5zQMX9pOIbsINRy6gzYZhZ5vEEXD1jdtf+ea3hAyOF8+3Bvu6
KVK7v0KQdcyg5FjU1qvKmJ+GSJs8m5gUHgXL40+fg+bXYyHMn28qxUjVwG6jz6xE
ER6CtRyVoxaHOlkzJYjdM+BhCJlmGPwxpN9NORYWFG9VU668kydO9UTcrwMDT/0j
YSnkotC1TlC8KR5prM+gPEGy1W8xCnh1A8fMTxlhFZb1xmGu7z7M06HPLikjHKNE
GYLsBtHpzErb9R548V8JfGuODPdIajWNiof1gRFZ2mrFVvhlDkZ/gm8AW+lM9bj4
f0WoULcgufVLpGxsia9Bgr5u3Itag+vRoqU5Z05ayvobjVklnGrNSLwWiJtXYMXb
81nXTkwEiqash3xsVK4GepVYRVau6Yd9/e1pMnlJZ8R2E1hcirFFRV4CJI8t9OMk
TVM6wE/Nvxr+k1qbeG0s7mG7+O3ZbwWnlUQFvY1bKaQ=
//pragma protect end_data_block
//pragma protect digest_block
lnjm5/TsCqTGTNns2dMQnkWwUkA=
//pragma protect end_digest_block
//pragma protect end_protected

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new sequencer instance, passing the appropriate argument
   * values to the parent sequencer.
   *
   * @param name Instance name
   * 
   * @param parent Handle to the hierarchical parent
   * 
   * @param suite_name Identifies the product suite to which the sequencer object belongs.
   */
  extern function new(string name, `SVT_XVM(component) parent, string suite_name);

  //----------------------------------------------------------------------------
  /** Run phase */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual task run_phase(uvm_phase phase);
`else
  extern virtual task run();
`endif

`ifdef SVT_OVM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  extern task m_run_phase_sequence(string name, svt_phase phase, bit sync = 1);
`endif

  //----------------------------------------------------------------------------
  /**
   * Updates the sequencer's configuration with data from the supplied object.
   * This method always results in a call to change_dynamic_cfg(). If the sequencer
   * has not been started calling this method also results in a call to
   * change_static_cfg().
   */
  extern virtual function void set_cfg(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Returns a copy of the sequencer's configuration object, including the
   * current configuration settings. If cfg is null, creates configuration object
   * of appropriate type.
   */
  extern virtual function void get_cfg(ref svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Copies (deep) the <i>static</i> configuration properties from the argument
   * into the configuration object stored in the sequencer. Used internally
   * by set_cfg; not to be called directly.
   */
  extern virtual protected function void change_static_cfg(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Copies (deep) the <i>dynamic</i> configuration properties from the argument
   * into the configuration object stored in the sequencer. Used internally
   * by set_cfg; not to be called directly.
   */
  extern virtual protected function void change_dynamic_cfg(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Expected to return a 1 if the supplied configuration object is of the correct
   * type for the sequencer. Extended classes implementing specific sequencers
   * will provide an extended version of this method and call it directly.
   */
  extern virtual protected function bit is_valid_cfg_type(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Returns the current setting of #is_running, indicating whether the sequencer has
   * been entered the run() phase.
   *
   * @return 1 indicates that the sequencer has been started, 0 indicates it has not.
   */
  extern virtual function bit get_is_running();
endclass

// =============================================================================

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
hgO5TbvDtAEWmm/HFxb66iqxMDj8yfez/gIPLq6RQxfV/HI/vmeRzx32uaKz1dym
XcYxICn2CJBM99giaPYBieonSh/7dJI/9ljvxWQnzgN8spyQOcfB7p4SC/Z/7dFX
wFaD7vTvja4kitEQ5zmPSg0rrpQzGb3UWTBjf7xXanzmrG2OK9vMVw==
//pragma protect end_key_block
//pragma protect digest_block
fc5KbpZGFP00mZSDvejansw5TDM=
//pragma protect end_digest_block
//pragma protect data_block
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
ahbpp0TQKCs5vsyOYN1JeQ==
//pragma protect end_data_block
//pragma protect digest_block
u9tNrrLoZaMGfQLk1mQ0CeLmkR4=
//pragma protect end_digest_block
//pragma protect end_protected

// For backwards compatibility
`ifdef SVT_UVM_TECHNOLOGY
class svt_uvm_sequencer_bfm#(type REQ=uvm_sequence_item,
                          type RSP=REQ) extends svt_sequencer_bfm#(REQ,RSP);
  `uvm_component_utils(svt_uvm_sequencer_bfm)

  function new(string name = "", uvm_component parent = null, string suite_name = "");
     super.new(name, parent, suite_name);
  endfunction
endclass
`endif

`endif // GUARD_SVT_SEQUENCER_BFM_SV

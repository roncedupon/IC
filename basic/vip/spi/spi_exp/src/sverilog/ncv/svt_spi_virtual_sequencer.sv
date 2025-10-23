
`ifndef GUARD_SVT_SPI_VIRTUAL_SEQUENCER_SV
`define GUARD_SVT_SPI_VIRTUAL_SEQUENCER_SV

`ifndef SVT_VMM_TECHNOLOGY

// =============================================================================
/**
 * This class defines a virtual sequencer that can be connected easily to the svt_spi_agent.
 */
//class svt_spi_virtual_sequencer extends `SVT_XVM(sequencer);
class svt_spi_virtual_sequencer extends `SVT_XVM(sequencer)#(`SVT_XVM(sequence_item),`SVT_XVM(sequence_item));

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /** Sequencer which can supply transaction requests. */
  svt_spi_transaction_sequencer transaction_seqr;
  
  /** Sequencer which can supply service requests. */
  svt_spi_service_sequencer service_seqr;

  //----------------------------------------------------------------------------
  // Local Data Properties
  //----------------------------------------------------------------------------

  /** SVT message macros route messages through this reference */
  local `SVT_XVM(report_object) reporter = this;

  /** Configuration object for this sequencer. */
  local svt_spi_agent_configuration cfg;

  //----------------------------------------------------------------------------
  // Component Macros
  //----------------------------------------------------------------------------

  `svt_xvm_component_utils_begin(svt_spi_virtual_sequencer)

    `svt_xvm_field_object(transaction_seqr,    `SVT_XVM_ALL_ON|`SVT_XVM_REFERENCE)
    `svt_xvm_field_object(service_seqr,    `SVT_XVM_ALL_ON|`SVT_XVM_REFERENCE)

  `svt_xvm_component_utils_end

  //----------------------------------------------------------------------------
  // Methods
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new virtual sequencer instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name.
   * @param parent Establishes the parent-child relationship.
   */
   extern function new(string name = "svt_spi_virtual_sequencer", `SVT_XVM(component) parent = null);

  //----------------------------------------------------------------------------
  /**
   * Finds the first sequencer that has a `SVT_XVM(agent) for its parent.
   * If p_sequencer parent is a `SVT_XVM(agent), returns that `SVT_XVM(agent). Otherwise
   * continues looking up the sequence's parent sequence chain looking for a
   * p_sequencer which has a `SVT_XVM(agent) as its parent.
   *
   * @param seq The sequence that needs to find its agent.
   * @return The first agent found by looking through the parent sequence chain.
   */
  extern virtual function `SVT_XVM(agent) find_first_agent(`SVT_XVM(sequence_item) seq);

  //----------------------------------------------------------------------------
  /**
   * Gets the shared_status associated with the agent associated with the virtual sequencer.
   *
   * @param seq The sequence that needs to find its shared_status.
   * @return The shared_status for the associated agent.
   */
  extern virtual function svt_spi_status get_shared_status(`SVT_XVM(sequence_item) seq);

  //----------------------------------------------------------------------------
  /**
   * Updates the sequencer's configuration with the supplied object. Also updates
   * the configurations for the contained sequencers.
   */
  extern virtual function void reconfigure(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Returns a reference of the sequencer's configuration object.
   */
  extern virtual function void get_cfg(ref svt_configuration cfg);

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
hB9lexkti9ybgNsMUoXs0W3vEs4/WV7NIjRRydltSPSEylrsE/4Ex3we3Ms1l7YV
TPbNHG3Gg4Kwih0hGTbVZ5H3yx1IfSx0JsxC5oMtX4ZnALkTxDvVTnwzkS33KTPO
cuUNyEbdhYVtiUCvDm9LQ1ricQMMxBkv2zZA4OtX4jUOTnMX7WTUoA==
//pragma protect end_key_block
//pragma protect digest_block
5OKnGqcvS8NR5BFbzmrDiY6ys2A=
//pragma protect end_digest_block
//pragma protect data_block
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
W128vHC1iicJohGbljQJxQ==
//pragma protect end_data_block
//pragma protect digest_block
Pj1dmwtTnQzNQDzpET2PmOlMOnA=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // `ifndef SVT_VMM_TECHNOLOGY

`endif // GUARD_SVT_SPI_VIRTUAL_SEQUENCER_SV

//--------------------------------------------------------------------------
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
//--------------------------------------------------------------------------

`ifndef GUARD_SVT_MEM_SEQUENCER_SV
`define GUARD_SVT_MEM_SEQUENCER_SV

typedef class svt_mem_sequence;
typedef class svt_mem_ram_sequence;

typedef class svt_mem_backdoor;

// ============================================================================================
/**
 * This base class will drive the memory sequences in to driver.
 *
 * This object contains handles to memory backdoor and memory configuration, sequences can access
 * backdoor handle to do read/write operations and can access memory configuration from 'cfg' handle.
 */
class svt_mem_sequencer extends svt_reactive_sequencer#(svt_mem_transaction);

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  /**
   * Memory backdoor 
  */
  svt_mem_backdoor backdoor;

  /**
   * Memory configuration
  */  
  svt_mem_configuration cfg = null;

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

//svt_vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
DsruBt+Yvtt/dv3UGpb+CCpWI9XEW83gDA0pZ7fy10q/bA9tqqe9/Vn7ltMcauOi
qmBJDbf36TFSnhdasqgkcM2Qfe6/ZJTKee6pVpgSQkcBqPMAFeu5qCHLhF7zE/nr
rTqxaCCePyZksjPmikN8x6XWUKlRVMwTljQfRxb8PdexprXSlwdh3Q==
//pragma protect end_key_block
//pragma protect digest_block
4cACMReApOHQMqj48jqhOYC0hH0=
//pragma protect end_digest_block
//pragma protect data_block
y3oCspO1oxB+SFv1AuaqShkVgpoSVWADyb5Y/R/ta2IVlZuVWBRwxEeOsPdtftPo
7k5+nCj1Z51r91E+yJNkatBbg4cqYAumIGnW079xDvNYNQCwJOIzyIiF7Kb5YPUx
GMMbKFqVLeWFAIyw4TrcTlkkPSdoHdgxEepCmx/PNJYyKOuhNNrl4TjXbO0ojR4f
UUjnCdP4HUYIOysgxzgydqoLMusgQIHJBfwOo4RIUXbmRXi8j/njVu9/Z5hUx828
fosR17vmUg/jRurgqdnIU/IlVgMZIxxT4sqTVcGoGYo9ySLyrvFdgmoiOmtvZ6Bs
TztXkknqzLM/LB0V/Dbpi1YzXegHZ1NPjqjiPq/AipUizxZYnK2Jvthu6iB34+iA
sEnoa8l+Exzrz1vGgsV/gwiSg8CHr5+VnxsWgQgynRKDAXMLM8pmGYzAOYCTA/AN
Jzs2+PY+4gp9x/ijqPvEhk3JhRwaQ+6XN5uW356EvWKaZyKpoHA5H4c/VUJgnNQ8

//pragma protect end_data_block
//pragma protect digest_block
/I92AZth5n0UMXjroS/O8T7kB4o=
//pragma protect end_digest_block
//pragma protect end_protected

  // ****************************************************************************
  // Field Macros
  // ****************************************************************************
  `svt_xvm_component_utils_begin(svt_mem_sequencer)
    `svt_xvm_field_object(cfg, `SVT_XVM_ALL_ON|`SVT_XVM_REFERENCE)
  `svt_xvm_component_utils_end

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new sequencer instance
   * 
   * @param name The name of this instance.  Used to construct the hierarchy.
   * 
   * @param parent The component that contains this instance.  Used to construct
   * the hierarchy.
   */
  extern function new(string name = "svt_mem_sequencer",
                      `SVT_XVM(component) parent = null,
                      string suite_name = "");

  //----------------------------------------------------------------------------
  /** Build Phase to build and configure sub-components */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual function void build_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern virtual function void build();
`endif

  //----------------------------------------------------------------------------
  /** Extract Phase to close out the XML file if it is open */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual function void extract_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern virtual function void extract();
`endif

  // ---------------------------------------------------------------------------
  /** INHERITED METHODS Implemented in this class. */
  // ---------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  /**
   * Return a reference to a backdoor API for the memory core in this sequencer.
   */
  extern virtual function svt_mem_backdoor get_backdoor();

/** @cond PRIVATE */
  //----------------------------------------------------------------------------
  /**
   * Return a reference to svt_mem_core.
   * 
   * IMPORTANT: This class is intended for internal use and should not be used
   *            by VIP users.
   */
  extern virtual function svt_mem_core m_get_core();
/** @endcond */

  //----------------------------------------------------------------------------
  /**
   * Returns a reference of the sequencer's configuration object.
   * NOTE:
   * This operation is different than the get_cfg() methods for svt_driver and
   * svt_uvm_monitor classes.  This method returns a reference to the configuration
   * rather than a copy.
   */
  extern virtual function void get_cfg(ref svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Reconfigure sequencer's memory instance with the new memory configuration object.
   * @param cfg - configuration object
   */
  extern virtual function void reconfigure(svt_configuration cfg);

endclass

//svt_vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
6IYhyGqgT16Y+W8YJq6jUADkoSjYQL8+XWLlFrwwqyT0VwMzj6BpvQjKRyOFY6HN
fcrL7xNE8sEzfCr2Sipr1vQ9Lngw98hQUqeQpQW0rCY67tx0lAUGmnm8QTIbQXc1
a/6GQRu2kX0qPml7abBpLIeKLJnT1pVH2ZETamgz34PCM+oQ39L/IQ==
//pragma protect end_key_block
//pragma protect digest_block
qwD70wjKWjEppQlHwaPPIuoZcSE=
//pragma protect end_digest_block
//pragma protect data_block
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
fy9zfno2Wy9bzOtzRVyaTQ==
//pragma protect end_data_block
//pragma protect digest_block
LEVstJZBRAPVysoV8Mx2ZKGRSKA=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_MEM_SEQUENCER_SV


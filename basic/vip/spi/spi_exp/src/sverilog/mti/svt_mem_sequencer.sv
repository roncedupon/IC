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
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
eF/FkSJGwH4/YUgDfytHvVGC6xLN3E8MmOKVjxQdNrjmslcTL/VvMOX+9kXYtTIO
yJW1hvFufoMeULeLX1c854yUFEeCFgDot+5pBnqXKNVB9yXpywgpiTymTt7u2+u5
646XAa9bj8A/VcfPBaBGCWcqUyq3LXL+k9TtDfNLtZU=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 208       )
/3OFIrK0Hx79AD8ZO7wigg+chr7Eu0vftw/S1aeYIw3ZYDqRUhaYCjoFiY6vBlbI
0qJ1VzbX/b3FeGj3kU77BjLRNelqm7VGXV+w0fdjg38wv+d8lL7k9wBFJx6BDqq6
egRpvIdomdi5J5m6Xx7UNkSw+uTydTkOutayWmvykZxoJf5pQMnW0ZULjqA6MJEU
AqK3a/WweYDWkawsZAOWSHQAL1ePxXAWqS0vXOchwOVTyMpACIZfCJP9aNLRHfKL
ws9dOM4A2wUzLQ51pVmE4yMAI3X0u+rJB8at8bh7nds=
`pragma protect end_protected

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
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
EiqspqBbMrdHt2+DlMaCURa45oBuHQ0LhZZhxFvnfnggSF8P35KHHrMq7rWuAi0L
eRZFFtDOuEgIVwQeiW0tgKP3sENJ0Isme0g3TmhQr88JyhUHklAlKwi0QUcLPkBD
M8lxByKw7Wxks3d11vkjEGa2d65qJyskp9Fw9Xfkd9I=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 4270      )
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
`pragma protect end_protected

`endif // GUARD_SVT_MEM_SEQUENCER_SV

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
BL0IVnP+oS58g8cAroPaC+En/4MOIehY5zBbdPAEV/QPIuiQ10zeZyVi6M9n4cy0
WelluHfpFr1HIsqewGQd9tW13bl+jdofqdxRwkjMUv0UZypN6lo+3FyBLDpAlIQl
JleaGX5oEo7qG6PcauKK5uJzbcbQu9U2ROMoHELO1bQ=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 4353      )
2BFglzSm34qcipqvIa5EbxXhMzYlBl652gs3AAN/KkARh7oueiYcHUDBQh+ZDKYe
FuzU19l+9Mtx8BQrUm8/32EeQ6c/zvfMx8Tnu1l+oDf9b0zHPEXhiTsW4BWWpKPT
`pragma protect end_protected

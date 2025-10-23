
`ifndef GUARD_SVT_SPI_MEM_SEQUENCER_SV
`define GUARD_SVT_SPI_MEM_SEQUENCER_SV

// =============================================================================
/**
 * This class drives the memory sequences in to driver.
 * This is extended from svt_mem_sequencer
 */
class svt_spi_mem_sequencer extends svt_mem_sequencer;

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

/** @cond PRIVATE */
  
  
  
  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************


/** @endcond */

  // ****************************************************************************
  // Field Macros
  // ****************************************************************************
  `svt_xvm_component_utils(svt_spi_mem_sequencer)

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
  extern function new(string name = "svt_spi_mem_sequencer", `SVT_XVM(component) parent = null);
  
  //----------------------------------------------------------------------------
  /** Build Phase to build and configure sub-components */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual function void build_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern virtual function void build();
`endif

endclass

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
eLQaJqcwaaxp9cmSFiWTFryLiiS5FeXP+euS6eT8q6MNRJtyQF5aSEXNgfS9ADXq
PmWZuR+o3hynex4ezmovqGbpZkgmvpaLLcvKop+EKCoNKzvcvNVP9jG/dq/TSRJf
zTCwLAxqehmFhUrwjBKwZR6smk0R5ueUgCKnJWcga8o=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 363       )
FXJY/2nszBM2TEbHwcVAjopgNk0suYWx0hGg+9MTT36hBOwpZjAPZVMS0b8VKf6J
m0II/Uy0kge0VgO2PutpNuR3HwSfc5JH23rELa7TPmw1QWOpsX5E9CIZ3tmmj4qi
84avs+viifnAHy9VTeV6Vle7NKsqI5llO6FympmePzBR/v1WS8pwlQbtQaKtI0by
T0jXGn0X84Uw8soFcHRqUmkSSvSjmbbRJYUE0l6kPUTwcgNg/Vl4B6SZFurkb5A2
YgDKN9zhRc9P4JrmJI3qtfTOEB4Aj2v73ivFNn7lDGDhyLStRm0AB081I+dsori8
+/IrgVZmSyfmrX4XMwSvfLCwp+mNAhvK9nXgnDMGonKycQqCZy0swZg08cb1HFkB
8IPw97pIp5JW34JjFqoeoYLF1AxCeTbhsLJVYmummX8xpAAa4gX9Ds/SC94ljndT
UOldaW00PNl4EM3xtH9EM1yBOyN7MN2EOX7pUx1XJ3E=
`pragma protect end_protected

// -----------------------------------------------------------------------------
`ifdef SVT_UVM_TECHNOLOGY
function void svt_spi_mem_sequencer::build_phase(uvm_phase phase);
  super.build_phase(phase);
`elsif SVT_OVM_TECHNOLOGY
function void svt_spi_mem_sequencer::build();
  super.build();
`endif

endfunction

`endif // GUARD_SVT_SPI_MEM_SEQUENCER_SV

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
HnzzEbFXn6mYNApsMKd849Crv2mDxYAjWVWM4W/2QRijwtAJKUmAoUrSx6x3WRVE
0qWQVZrwmlxIe9XyTVv6Ab7daSizK6rdYsu81ZG+CKLsGbE1DI6rpp/Tz8TbU3Q0
LlzmUV1xvMj0imotSXKc26XxWTSYz418oPh5WQRtEvM=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 446       )
H55nxGzraZraUB0EK6qtVEJ7rI7Zqlqn/wxZ3pcvxgML0sLdgJreSUNCvS0uvpa0
DNIIaifNxEWUm7jRpCta3d7XqG+mRXhjwO/5d78poqGG8PGU2Y30T6GlGuMieJDs
`pragma protect end_protected

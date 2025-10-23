
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

`protected
@4D?5ZGL;?T=JGI=?VH.FcL4X_2F/.e?;Z4gcRg/&OG[GGY#0IRg))S4#(AS(.<7
RWOCT4gOacbRd7T=7Q^2XcTIK9I?>_aF\@2d5f^4MQ3aLVCeKBH5N9cg++dHf[3C
JCT-<X)W&Y#SMU+</&OH(FD\JE@_W,+CQ;8N0G;C[6[B_\O0gKH1L]4;_E>334P0
_9?^>FH[V&/dY/fe]4X=X6;&>XYJT9;&V)>^2CbG-[+;D:4.\g@,@CcG9G>RJ406
a<=ff:<<O?aVc/7c-2-)I^-f^VNZ20eAV4=&bMK34(\?SaTcG5QRW?0a;5S&[cL\
b00U48dIdTcR&g#IX]7g)c-f1$
`endprotected


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


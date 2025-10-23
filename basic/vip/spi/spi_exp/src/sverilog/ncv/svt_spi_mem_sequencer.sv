
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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
3AUbyT1L1wC3A2Yc+4xkX/YYZCwRYNMPERDTGPkQ9Y9VZEkUne9o1fGDkoFiBFXO
fY4aQ6JTqueGAV8P4bB/0SZrgAlGK0WIwiDIxPu5o8+7nztH6tfwxLV+JOouDAVR
GDkVdt9BPWYYu19SUMNks115jCMxKczbhghM4BOLQo+CNNPnJXDRpQ==
//pragma protect end_key_block
//pragma protect digest_block
730Q9sypBEOWR9fihG1KEEp4ZEc=
//pragma protect end_digest_block
//pragma protect data_block
SDdolZfPVg+yXp+JRoufRx38mN8GbB1d9fYXTdnoHwm83fNDSwFV7C9RaL69pvV1
O9LoL4wJiuE7XMq9Ljmb68chTFaucvxIDhilTf/pZWEMlM3inrXQ2J9Wf0kRH9MQ
BOTqYMZPdPcLnr7EIOvF3P7OdAFLAmL+pJdvHe1lk7Kg8Oh7HG/f6w8/cYSYHBCb
e7nlMhrOGlUrsKv0ChHYUYQhTEQUP1EU3U6DkvQo8mqW2O4CPSG5puP5qPToCRU0
PFPnFHiKH9twXEblMqHxDUHxZuSjeerm+RIz6nVdv8DO5ETKnGAuUJbwzoqHEJDB
SseilrHTe6NgP94s28aBUWt4h9Jsv5PJehqVZIVU9t+K8lEBLoo6u4Kp0OvUFs/a
aZsMzmumC0/EmkZxvtiaI7lgsEk7HqHWB8gYj+uDcXyai4TcrDciWSVyKMAq+Tya
Pm52kzjE79C/BJLpbQG6FvrKEbOERjIMTrNWFKvLf6gpvLDXjFJHA1c+7kFraJRw
wzjYup8wvD4fNxvdDRQtRX9kfCF1+wdzGz7hgZ5cCUfliwNFAP8rDS4/qLjfcpNC
Tn8DE7lOQREzGSPBoz3L3Fbvryhy61sDOMhArmw562T06oMVCVz+L9XU6RJX4C+n
wYIonrvJ+uEUvVQHjchieaqK31BL/abGTeL2OSnAikxaX+qC9BR2lO2eLPnHm8xX

//pragma protect end_data_block
//pragma protect digest_block
ZXv/WlCYTLSYOnJ3/+zLlxcPkeY=
//pragma protect end_digest_block
//pragma protect end_protected

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


//--------------------------------------------------------------------------
// COPYRIGHT (C) 2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_TRAFFIC_ARBITER_SV
`define GUARD_SVT_TRAFFIC_ARBITER_SV

/**
 * Traffic arbiter class that arbitrates between the traffic transactions 
 * that it retreives from the traffic profiles. This class calls the DPIs
 * that process the traffic profile xml files. The values returned by the DPIs
 * are used to populate svt_traffic_profile_transaction objects. When all
 * traffic profiles are retreived, the arbiter arbitrates between the traffic
 * transactions 
 */
class svt_traffic_arbiter extends svt_component;

  /** Event pool for all the input events across all traffic profiles */
  svt_event_pool input_event_pool;

  /** Event pool for all the output events across all traffic profiles */
  svt_event_pool output_event_pool;

`ifdef SVT_UVM_TECHNOLOGY
  /** Fifo into which traffic profile transactions are put */ 
  uvm_tlm_fifo#(svt_traffic_profile_transaction)  traffic_profile_fifo;
`elsif SVT_OVM_TECHNOLOGY
  tlm_fifo#(svt_traffic_profile_transaction) traffic_profile_fifo;
`else
   // Currently does not support VMM 
`endif

  /** Queue with profiles of current group */
  protected svt_traffic_profile_transaction curr_group_xact_q[$];

  /** Queue of write fifo rate control configs */
  protected svt_fifo_rate_control_configuration write_fifo_rate_control_configs[$];

  /** Queue of read fifo rate control configs */
  protected svt_fifo_rate_control_configuration read_fifo_rate_control_configs[$];

  /** Queue of traffic profile transactions from all components */
  protected svt_traffic_profile_transaction traffic_q[$];

  /** Wrapper for calls to DPI implementation of VCAP methods */
  local static svt_vcap vcap_dpi_wrapper;

  `svt_xvm_component_utils(svt_traffic_arbiter)

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new component instance, passing the appropriate argument
   * values to the uvm_component parent class.
   *
   * @param name Instance name
   * 
   * @param parent Handle to the hierarchical parent
   */
  extern function new(string name = "svt_traffic_arbiter", `SVT_XVM(component) parent = null);

  // ---------------------------------------------------------------------------
`ifdef SVT_UVM_TECHNOLOGY
  /** UVM build phase */
  extern virtual function void build_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  /** OVM build phase */
  extern virtual function void build();
`endif

  // ---------------------------------------------------------------------------
`ifdef SVT_UVM_TECHNOLOGY
  /** UVM run phase */
  extern virtual task run_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  /** OVM run phase */
  extern virtual task run();
`endif

  // ---------------------------------------------------------------------------
  /** Gets the handle to the VCAP DPI wrapper */
  extern function svt_vcap get_vcap_dpi_wrapper();

  // ---------------------------------------------------------------------------
  /** Gets traffic transactions through DPI 
   * The DPI gets the inputs as a byte stream from the traffic profile file
   * The byte stream is unpacked into traffic profile, synchronization and fifo control information
   */
  extern task get_traffic_transactions();

  // ---------------------------------------------------------------------------
  /** 
   * Adds synchronization data to the traffic profile transaction 
   * @param xact The traffic profile transaction to which synchronization data must be added
   * @param group_name The group to which this traffic profile transaction belongs
   * @param group_seq_number The group sequence number corresponding to the group to which this class belongs 
   */
  extern task add_synchronization_data(svt_traffic_profile_transaction xact,string group_name, int group_seq_number);

  // ---------------------------------------------------------------------------
  /** Starts traffic based on the received traffic profile transactions 
   * Send traffic profile objects to the layering sequence
   * Traffic transactions are sent in groups. One group is sent
   * after all xacts of the previous group is complete.
   * 1. Get traffic objects with the current group sequence number,
   * basically get all the objects within a group
   * 2. Send transactions and wait until all transactions of that group end
   * 3. Repeat the process for the next group
   */
  extern task svt_start_traffic();

  // ---------------------------------------------------------------------------
  /** 
   * Tracks the output event corresponding to ev_str 
   * Wait for an output event to be triggered on a transaction
   * When it triggers, get a list of transactions which has the same
   * event as an input event (ie, these transactions wait on the event before 
   * they get started)
   * @param ev_str The string corresponding to the output event on which this task must wait
   * @param xact The transaction on which tracking of output event must be done
   */
  extern task track_output_event(string ev_str, svt_traffic_profile_transaction xact);

  // ---------------------------------------------------------------------------
  /** 
   * Gets the xacts with the event corresponding to ev_str as an input event 
   * @param ev_str The string corresponding to the input event
   * @param input_xact_for_output_event_q The list of transactions which have ev_str as an input event
   */
  extern function void get_input_xacts_for_output_event(string ev_str, output svt_traffic_profile_transaction input_xact_for_output_event_q[$]);

  // ---------------------------------------------------------------------------
  /** 
   * Sends traffic transaction 
   * @param xact Handle to the transaction that must be sent
   * @param item_done Indicates that the transaction is put into the output FIFO
   */
  extern task send_traffic_transaction(svt_traffic_profile_transaction xact, ref bit item_done);

  // ---------------------------------------------------------------------------
  /** Waits for any of the input events in the transaction to be triggered */
  extern task wait_for_input_event(svt_traffic_profile_transaction xact);

  // ---------------------------------------------------------------------------
  /** 
   * Gets the WRITE FIFO rate control configuration with a given group_seq_number 
   * @param group_seq_number The group sequence number for which the WRITE FIFO rate control configurations must be retreived
   * @param rate_control_configs The list of WRITE FIFO rate control configurations corresponding to the group sequence number
   */
  extern function bit get_write_fifo_rate_control_configs(int group_seq_number, output svt_fifo_rate_control_configuration rate_control_configs[$]);

  // ---------------------------------------------------------------------------
  /** 
   * Gets the READ FIFO rate control configuration with a given group_seq_number 
   * @param group_seq_number The group sequence number for which the READ FIFO rate control configurations must be retreived
   * @param rate_control_configs The list of WRITE FIFO rate control configurations corresponding to the group sequence number
   */
  extern function bit get_read_fifo_rate_control_configs(int group_seq_number, output svt_fifo_rate_control_configuration rate_control_configs[$]);
  // ---------------------------------------------------------------------------

  /**
   * Gets the resource profiles corresponding to a sequencer and adds it to the internal data structure
   * @param group_seq_number The sequence number corresponding to the group of this sequencer
   * @param group_name The name of the group corresponding to the sequencer
   * @param sequencer_full_name The full name of the sequencer 
   * @param sequencer_name The name of the sequencer 
   */
  extern virtual task get_resource_profiles_of_sequencer(int group_seq_number, string group_name, string sequencer_full_name, string sequencer_name);

  // ---------------------------------------------------------------------------
  /**
   * Gets the traffic profiles corresponding to a sequencer and adds it to the interal data structure
   * @param group_seq_number The sequence number corresponding to the group of this sequencer
   * @param group_name The name of the group corresponding to the sequencer
   * @param sequencer_full_name The full name of the sequencer 
   * @param sequencer_name The name of the sequencer 
   */
  extern virtual task get_traffic_profiles_of_sequencer(int group_seq_number, string group_name, string sequencer_full_name, string sequencer_name);

  // ---------------------------------------------------------------------------
  /**
   * Gets the synchronisation profile corresponding to a group
   * @param group_seq_number The sequence number corresponding to the group of this sequencer
   * @param group_name The name of the group corresponding to the sequencer
   */
  extern virtual task get_group_synchronisation_spec(int group_seq_number, string group_name);

  //---------------------------------------------------------------------------------------
  /**
   * Gets the name of the current group
   * @param group_name Name of the current group
   * @output Returns 0 if there are no more groups to retreive, else returns 1
   */
  extern virtual function int get_group(output string group_name);
  
  // ---------------------------------------------------------------------------
  /**
   * Gets the name of the current sequencer 
   * @param inst_path Name of the instance to the current sequencer 
   * @param sequencer_name Name of the current sequencer
   * @output Returns 0 if there are no more sequencers to retreive, else returns 1
   */
  extern virtual function int get_sequencer(output string inst_path, output string sequencer_name);
  
  // ---------------------------------------------------------------------------
  /**
   * Gets the name of the current sequencer resource profile
   * @param path Name of the path to the current resource profile 
   * @output Returns 0 if there are no more sequencer profiles to retreive, else returns 1
   */
  extern virtual function int get_sequencer_resource_profile(output string path);
  
  // ---------------------------------------------------------------------------
  /**
   * Gets the total number of attributes to be retreived from the current
   * sequencer profile. 
   * @output Returns the number of attributes in the current sequencer profile 
   */
  extern virtual function int get_sequencer_resource_profile_attr_count();
  
  // ---------------------------------------------------------------------------
  /**
   * Gets the next name-value pair from the sequencer resource profile 
   * @param rate_cfg Handle to the resource profile configuration
   * @param name Name of the resource profile attribute
   * @param value The value retreived for the resource profile attribute
   * @output Returns 0 if there are no more values to be retreived, else returns 1. 
   */
  extern virtual function int get_sequencer_resource_profile_attr(svt_fifo_rate_control_configuration rate_cfg, output string name, output bit[1023:0] value);
  
  // ---------------------------------------------------------------------------
  /**
   * Gets the next traffic profile
   * @param path Path to the traffic profile
   * @param profile_name Name of the traffic profile
   * @param component The sequencer corresponding to the traffic profile
   * @param protocol The protocol corresponding to the profile
   */
  extern virtual function int get_traffic_profile(output string path, output string profile_name, output string component, output string protocol);
  
  // ---------------------------------------------------------------------------
  /**
   * Gets the total number of attributes to be retreived from the
   * current traffic profile.
   * @output Returns the number of attributes in the current traffic profile 
   */
  extern virtual function int get_traffic_profile_attr_count();
  
  // ---------------------------------------------------------------------------
  /**
   * Gets the next name-value pair from the traffic profile 
   * @output Returns 0 if there are no more values to be retreived, else returns 1. 
   */
  extern virtual function int get_traffic_profile_attr(svt_traffic_profile_transaction xact, output string name, output bit[1023:0] value);
  
  // ---------------------------------------------------------------------------
  /**
   * Gets the next traffic resource profile
   * @param path Path to the traffic resource profile
   * @output Returns 0 if there are no more profiles to be retreived, else returns 1. 
   */
  extern virtual function int get_traffic_resource_profile(output string path);
  
  // ---------------------------------------------------------------------------
  /**
   * Gets the total number of attributes to be retreived from the
   * current traffic resource profile.
   * @output Returns the number of attributes in the current traffic resource profile 
   */
  extern virtual function int get_traffic_resource_profile_attr_count();
  
  // ---------------------------------------------------------------------------
  /**
   * Gets the next name-value pair from the traffic resource profile 
   * @output Returns 0 if there are no more values to be retreived, else returns 1. 
   */
  extern virtual function int get_traffic_resource_profile_attr(svt_traffic_profile_transaction xact, output string name, output bit[1023:0] value);
  
  // ---------------------------------------------------------------------------
  /**
   * Gets the next synchronization spec 
   * @output Returns 0 if there are no more synchronization specs to be retreived, else returns 1. 
   */
  extern virtual function int get_synchronization_spec();
  
  // ---------------------------------------------------------------------------
  /**
   * Gets the synchronization spec input events
   * @param event_name Name of the event
   * @param sequencer_name Name of the sequencer corresponding to the event
   * @param traffic_profile_name Name of the traffic profile corresponding to the event
   */
  extern virtual function int get_synchronization_spec_input_event(output string event_name,
                                                                   output string sequencer_name,
                                                                   output string traffic_profile_name);
  
  // ---------------------------------------------------------------------------
  /**
   * Gets the synchronization spec output events
   * @param event_name Name of the event
   * @param sequencer_name Name of the sequencer corresponding to the event
   * @param traffic_profile_name Name of the traffic profile corresponding to the event
   * @param output_event_type Indicates type of the output event.
   */
  extern virtual function int get_synchronization_spec_output_event(output string event_name,
                                                                    output string sequencer_name,
                                                                    output string traffic_profile_name,
                                                                    output string output_event_type,
                                                                    output string frame_size,
                                                                    output string frame_time);
  //---------------------------------------------------------------------------------------
  /**
   * Creates the correct type of protocol transaction based on the
   * protocol field argument
   * @param protocol String indicating the protocol
   * @output New transaction handle of type corresponding to protocol
   */
  extern virtual function svt_traffic_profile_transaction create_traffic_profile_transaction(string protocol);

  //---------------------------------------------------------------------------------------
endclass

//==============================================================================

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
7i6vNyWJA1y74sh/N0QijHK2VDDmZpEYZ3AkW/7DrXRmmQ9MLRuhQaHIWa8Gn5HI
rHWCb3KdZ5s+AOkMnTRm0kIVxIECLKXLevw1QwuuOqpkQIBVAVla+BEnVjmRSzKT
sYDOYUasAH94J3NL5i6OXjW5vSGr+x03LCQferksLDYa7g4t2nFA7A==
//pragma protect end_key_block
//pragma protect digest_block
ZheDFJkxVDqbOkcNYUK8wede/TE=
//pragma protect end_digest_block
//pragma protect data_block
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
3hww+Nupq9Yr+Y0MnwfSGWGLUcZX3QeC/0Sx2nuGP/vDxm2bTvYZ91G/SN7eKqVt
X9x/yOQaJU+uUkXmywboYgGGQ9k40BI1+13v0v+ae14zNyXsxiTaUFcfsRd17tx4
sJbkfnWiU46EOonklDecaYe7iEdluR6ZhePI9kW8UDnkFcr4GuXATXtKHo3+9FHR
zLhFsjmROU2NTMul9AeovSPVc8jZBVnPhH9dhAEAJ9SkKG/S3H9uiylnMsFbjA9k
XHJugkTeXyLP5qyYqhpl4MbGafUKm38kbEcpapVMTKiXkjXhQfiDj/VendAjIPUc
kUY3bHEKxTOIkUeKUR6Yvp4WOPnXv3Uu51JFFdHF70snpueLie6hrnggODihhZJd
KRnQGLQCzXwJ6RSADHzLvI7ADdhl9JzTrDqNFmymargHwouoaFnIBf6sTIQFvov4
iwABNOHRVM9lhGWQBxZGfFX1fX/wdjtoswK0miiiXap1x26PIXHVexT/pAM7Sill
ZmNH7z95X+vR1+UaDLWLyyNefgznYCFy9+yEEshaWBpCrWRcWEhgP893UuLxcLRD
+H8vm6lBLGka1OC0S6O+d1kzaXynFYyetAWMQLlp8Sl156ogICYOqxRal0WJrWQm
PEabp90WPBZsJ8G6C6FhIY4YRu62Ig9L/mfuwJuqu4BqCpAEfvza39Zt6qxi38Gl
42MJjpfWEmKDDWGcHJn5vYGbxwmUnxDfn+B1mZhdBVCTEJjM1JpuXz4+uHZlMA97
Ag8WVk4U30H6AKZ7xZlK9mLU9YV5SlnqbT0HzlzImQjONY/5mUa5Lf9rWJzifRKt
9OYL0WKpng2jimgcvbCfPpRsDHJZXh342zxm/hx9jBlSF/hau2MesvNTnKXU34zn
m00N20b0dLoTorSrMZocDu8i0f/BhemvFuIGAWHtAJEeytpxy5DsdABXNq1EZ+mS
WYhtuv2f2G0kWR0Uq2Omy5fqesv8yBkmYuEDVxJdfPhI0nfIKt8lSYxluRvt2din
KmiuBuC003El/niw+xDtrxOwNjstRu7cUHlUmjucRog3vJrFNxTTH9beeJbp9rIf
dQ3guFM8zjijIxNaoatSY0YbgPBHXR/T71uzTQCpuOhdM28ZYN3Zorm4j5wm92nt
uifedrdI7X+7yDLCE85wY1qfeg08bJR8Jy6dzlS4chGeKT5IcjOs/IFzCHd3nq4g
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
//pragma protect end_data_block
//pragma protect digest_block
fKOZp7O8tO1HQWwNgHWQav5UG9E=
//pragma protect end_digest_block
//pragma protect end_protected
`endif


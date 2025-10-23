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

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
NDM2OsLEiltkKFtC9dYvO6gYdAg5iRX2AfwWtUMuWf0kNwWM1Cq/AKq/9pqTC0PO
dgtmhyUgN56CsQVXG8cQmZPeHXbDk6nxiqceFb1wYDlmAeDLy7ePBhUnNpWGnxR2
9oZLul2qawzaSjGxXMCslIhre6YtUIOXlCVUZYxm6cc=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 27124     )
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
M7QoxT+UXBHmOrUjqjqwcA==
`pragma protect end_protected
`endif

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
fNx3+dSI5KNL3dyb+ckLog1GEopNa1+31ZFJ5lJ5TR3maKcIrutiFIYwFs+ULMPv
FPtFaGH8+/p8ru8yHkXsoZ9IP6ojDg36k7LP5zLs2LJgN9kkIT8qxUwQqZM+/FKg
/t0R5QkU62cXAIs/3xNJUcGd0OuEl6MC6vlbf+Eqiro=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 27207     )
8HUW0/LC/iv5t4WbTkF7DO0KN1Y4AXRfDDBIKo47GMm1g5fMMsA9sVIYYCEIwK+q
t5qSeeJXsJq9nl1Rv91Uc6OU4CV74q+lqmYym92EhHywXPGszD7AFxDIs1PLsext
`pragma protect end_protected

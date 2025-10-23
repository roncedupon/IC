//=======================================================================
// COPYRIGHT (C) 2017 SYNOPSYS INC.
// This software and the associated documentation are confidential and
// proprietary to Synopsys, Inc. Your use or disclosure of this software
// is subject to the terms and conditions of a written license agreement
// between you, or your company, and Synopsys, Inc. In the event of
// publications, the following notice is applicable:
//
// ALL RIGHTS RESERVED
// The entire notice above must be reproduced on all authorized copies.
//-----------------------------------------------------------------------

`ifndef GUARD_SVT_VCAP_SV
`define GUARD_SVT_VCAP_SV

`ifndef SVT_EXCLUDE_VCAP

// ****************************************************************************
// Imported DPI function declarations
// ****************************************************************************

import "DPI-C" function int svt_vcap__analyze_test( input string test_profile_path );

import "DPI-C" function int svt_vcap__get_group_count();

import "DPI-C" function int svt_vcap__get_group();

import "DPI-C" function string svt_vcap__get_group_name();

import "DPI-C" function int svt_vcap__get_sequencer_count();

import "DPI-C" function int svt_vcap__get_sequencer();

import "DPI-C" function string svt_vcap__get_sequencer_inst_path();

import "DPI-C" function string svt_vcap__get_sequencer_sequencer_name();

import "DPI-C" function int svt_vcap__get_sequencer_resource_profile_count();

import "DPI-C" function int svt_vcap__get_sequencer_resource_profile();

import "DPI-C" function string svt_vcap__get_sequencer_resource_profile_path();

import "DPI-C" function int svt_vcap__get_sequencer_resource_profile_attr_count();

import "DPI-C" function int svt_vcap__get_sequencer_resource_profile_attr();

import "DPI-C" function string svt_vcap__get_sequencer_resource_profile_attr_name();

import "DPI-C" function string svt_vcap__get_sequencer_resource_profile_attr_value();

import "DPI-C" function int svt_vcap__get_traffic_profile_count();

import "DPI-C" function int svt_vcap__get_traffic_profile();

import "DPI-C" function string svt_vcap__get_traffic_profile_path();

import "DPI-C" function string svt_vcap__get_traffic_profile_profile_name();

import "DPI-C" function string svt_vcap__get_traffic_profile_component();

import "DPI-C" function string svt_vcap__get_traffic_profile_protocol();
                                  
import "DPI-C" function int svt_vcap__get_traffic_profile_attr_count();

import "DPI-C" function int svt_vcap__get_traffic_profile_attr();

import "DPI-C" function string svt_vcap__get_traffic_profile_attr_name();

import "DPI-C" function string svt_vcap__get_traffic_profile_attr_value();

import "DPI-C" function int svt_vcap__get_traffic_resource_profile_count();

import "DPI-C" function int svt_vcap__get_traffic_resource_profile();

import "DPI-C" function string svt_vcap__get_traffic_resource_profile_path();

import "DPI-C" function int svt_vcap__get_traffic_resource_profile_attr_count();

import "DPI-C" function int svt_vcap__get_traffic_resource_profile_attr();

import "DPI-C" function string svt_vcap__get_traffic_resource_profile_attr_name();

import "DPI-C" function string svt_vcap__get_traffic_resource_profile_attr_value();

import "DPI-C" function int svt_vcap__get_synchronization_spec();

import "DPI-C" function int svt_vcap__get_synchronization_spec_input_event_count();

import "DPI-C" function int svt_vcap__get_synchronization_spec_input_event();
                                                   
import "DPI-C" function string svt_vcap__get_synchronization_spec_input_event_event_name();

import "DPI-C" function string svt_vcap__get_synchronization_spec_input_event_sequencer_name();

import "DPI-C" function string svt_vcap__get_synchronization_spec_input_event_traffic_profile_name();
                                                   
import "DPI-C" function int svt_vcap__get_synchronization_spec_output_event_count();

import "DPI-C" function int svt_vcap__get_synchronization_spec_output_event();
                                                   
import "DPI-C" function string svt_vcap__get_synchronization_spec_output_event_event_name();

import "DPI-C" function string svt_vcap__get_synchronization_spec_output_event_sequencer_name();

import "DPI-C" function string svt_vcap__get_synchronization_spec_output_event_traffic_profile_name();

import "DPI-C" function string svt_vcap__get_synchronization_spec_output_event_output_event_type();

import "DPI-C" function string svt_vcap__get_synchronization_spec_output_event_frame_size();

import "DPI-C" function string svt_vcap__get_synchronization_spec_output_event_frame_time();

// -----------------------------------------------------------------------------
/** @cond PRIVATE */

// =============================================================================
/**
 * Class for interfacing with the DPI code that reads an external VC VCAP 
 * test profile and incrementally returns the data specified by the test profile.
 */
class svt_vcap;

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

  // ---------------------------------------------------------------------------
  /**
   * Attempts to check out a VC VCAP license and read an XML file that 
   * defines a test profile.
   *
   * @param test_profile_path
   *   The path to the test profile XML file.  
   *
   * @return The staus of the operation (1=success, 0=failure).
   */
  extern static function int analyze_test( input string test_profile_path );

  // ---------------------------------------------------------------------------
  /**
   * Returns the number of groups defined in the test profile.
   *
   * @return The staus of the operation (1=success, 0=failure).
   */
  extern static function int get_group_count();
  
  // ---------------------------------------------------------------------------
  /**
   * Moves the internal pointer to the next group definition and returns the 
   * name of that group.  If there are no more groups, the method returns 0.
   *
   * @param group_name
   *   The name of the group.
   *
   * @return The staus of the operation (1=success, 0=failure).
   */
  extern static function int get_group( output string group_name );

  // ---------------------------------------------------------------------------
  /**
   * Returns the number of sequencers specified for the current group.
   *
   * @return The number of sequencers.
   */
  extern static function int get_sequencer_count();
  
  // ---------------------------------------------------------------------------
  /**
   * Moves the internal pointer to the next sequencer definition for the current
   * group and returns the instance path specified for that sequencer.  If there
   * are no more sequencers, the method returns 0.
   *
   * @param inst_path
   *   The instance path of the sequencer.
   *
   * @param sequencer_name
   *   The name of the sequencer.
   *
   * @return The staus of the operation (1=success, 0=failure).
   */
  extern static function int get_sequencer( output string inst_path,
                                            output string sequencer_name );

  // ---------------------------------------------------------------------------
  /**
   * Returns the number of resource profiles specified for the current sequencer.
   * Note that one or more resource profiles can be associated with a sequencer
   * OR resource profiles can be associated with each of the traffic profiles 
   * for a sequencer.
   *
   * @return The number of resource profiles.
   */
  extern static function int get_sequencer_resource_profile_count();
  
  // ---------------------------------------------------------------------------
  /**
   * Moves the internal pointer to the next resource profile for the current
   * sequencer and returns the path specified for that resource profile.  If 
   * there are no more resource profiles (or the resource profiles are defined
   * for each traffic profile), the method returns 0.
   *
   * @param path
   *   The path to the resource profile XML file.  
   *
   * @return The staus of the operation (1=success, 0=failure).
   */
  extern static function int get_sequencer_resource_profile( output string path );
  
  // ---------------------------------------------------------------------------
  /**
   * Returns the number of attributes specified for the current resource profile
   * (for the current sequencer).
   *
   * @return The number of attributes.
   */
  extern static function int get_sequencer_resource_profile_attr_count();
  
  // ---------------------------------------------------------------------------
  /**
   * Moves the internal pointer to the next attribute for the current resource
   * profile (for the current sequencer) and returns the name and value of for
   * that attribute.  If there are no more attributes, the method returns 0.
   *
   * @param name
   *   The attribute name.
   *
   * @param value
   *   The attribute value.
   *
   * @return The staus of the operation (1=success, 0=failure).
   */
  extern static function int get_sequencer_resource_profile_attr( output string name,
                                                                  output string value );

  // ---------------------------------------------------------------------------
  /**
   * Returns the number of traffic profiles specified for the current group.
   *
   * @return The number of traffic profiles.
   */
  extern static function int get_traffic_profile_count();
  
  // ---------------------------------------------------------------------------
  /**
   * Moves the internal pointer to the next traffic profile for the current
   * sequencer and returns general information about that traffic profile.  If 
   * there are no more traffic profiles, the method returns 0.
   *
   * @param path
   *   The path to the traffic profile XML file.  
   *
   * @param profile_name
   *   The name of the traffic profile.
   *
   * @param component
   *   The component type of the traffic profile (e.g. master or slave).
   *
   * @param protocol
   *   The protocol for the traffic profile (e.g. axi, ahb, apb or ocp).
   *
   * @return The staus of the operation (1=success, 0=failure).
   */
  extern static function int get_traffic_profile( output string path,
                                                  output string profile_name,
                                                  output string component,
                                                  output string protocol );
                                  
  // ---------------------------------------------------------------------------
  /**
   * Returns the number of attributes specified for the current traffic profile
   * (for the current sequencer).
   *
   * @return The number of attributes.
   */
  extern static function int get_traffic_profile_attr_count();
  
  // ---------------------------------------------------------------------------
  /**
   * Moves the internal pointer to the next attribute for the current traffic
   * profile (for the current sequencer) and returns the name and value for
   * that attribute.  If there are no more attributes, the method returns 0.
   *
   * @param name
   *   The attribute name.
   *
   * @param value
   *   The attribute value.
   *
   * @return The staus of the operation (1=success, 0=failure).
   */
  extern static function int get_traffic_profile_attr( output string name,
                                                       output string value );

  // ---------------------------------------------------------------------------
  /**
   * Returns the number of resource profiles specified for the current traffic
   * profile.  Note that one or more resource profiles can be associated with a
   * sequencer OR resource profiles can be associated with each of the traffic 
   * profiles for a sequencer.
   *
   * @return The number of resource profiles.
   */
  extern static function int get_traffic_resource_profile_count();
  
  // ---------------------------------------------------------------------------
  /**
   * Moves the internal pointer to the next resource profile for the current
   * traffic profile and returns the path specified for that resource profile.
   * If there are no more resource profiles, the method returns 0.
   *
   * @param path
   *   The path to the resource profile XML file.  
   *
   * @return The staus of the operation (1=success, 0=failure).
   */
  extern static function int get_traffic_resource_profile( output string path );
  
  // ---------------------------------------------------------------------------
  /**
   * Returns the number of attributes specified for the current resource profile
   * (for the current traffic profile).
   *
   * @return The number of attributes.
   */
  extern static function int get_traffic_resource_profile_attr_count();
  
  // ---------------------------------------------------------------------------
  /**
   * Moves the internal pointer to the next attribute for the current resource
   * profile (for the current traffic profile) and returns the name and value 
   * for that attribute.  If there are no more attributes, the method returns 0.
   *
   * @param name
   *   The attribute name.
   *
   * @param value
   *   The attribute value.
   *
   * @return The staus of the operation (1=success, 0=failure).
   */
  extern static function int get_traffic_resource_profile_attr( output string name, 
                                                                output string value );

  // ---------------------------------------------------------------------------
  /**
   * Moves the internal point to the synchronization specification for the 
   * current group and indicates whether or not a synchronization specification
   * is defined for that group.  If a synchronization specification is defined
   * for the current group, the function returns 1; if no synchronization 
   * specification is defined, the function returns 0.
   *
   * @return The staus of the operation (1=success, 0=failure).
   */
  extern static function int get_synchronization_spec();
  
  // ---------------------------------------------------------------------------
  /**
   * Returns the number of input events specified for the current synchronization
   * specification (for the current group).
   *
   * @return The number of input events.
   */
  extern static function int get_synchronization_spec_input_event_count();
  
  // ---------------------------------------------------------------------------
  /**
   * Moves the internal pointer to the next input event for the current 
   * synchronization specification (for the current group) and returns info
   * for that input event.  If there are no more input events, the method 
   * returns 0.
   *
   * @param event_name
   *   The event name.
   *
   * @param sequencer_name
   *   The name of the sequencer with which the event is associated.
   *
   * @param traffic_profile_name
   *   The name of the traffic profile with which the event is associated.
   *
   * @return The staus of the operation (1=success, 0=failure).
   */
  extern static function int get_synchronization_spec_input_event( output string event_name,
                                                                   output string sequencer_name,
                                                                   output string traffic_profile_name );
                                                   
  // ---------------------------------------------------------------------------
  /**
   * Returns the number of output events specified for the current synchronization
   * specification (for the current group).
   *
   * @return The number of output events.
   */
  extern static function int get_synchronization_spec_output_event_count();
  
  // ---------------------------------------------------------------------------
  /**
   * Moves the internal pointer to the next output event for the current 
   * synchronization specification (for the current group) and returns info
   * for that output event.  If there are no more output events, the method 
   * returns 0.
   *
   * @param event_name
   *   The event name.
   *
   * @param sequencer_name
   *   The name of the sequencer with which the event is associated.
   *
   * @param traffic_profile_name
   *   The name of the traffic profile with which the event is associated.
   *
   * @param output_event_type
   *   The output event type (e.g. end_of_frame).
   *
   * @return The staus of the operation (1=success, 0=failure).
   */
  extern static function int get_synchronization_spec_output_event( output string event_name,
                                                                    output string sequencer_name,
                                                                    output string traffic_profile_name,
                                                                    output string output_event_type,
                                                                    output string frame_size,
                                                                    output string frame_time );

endclass

/** @endcond */

// -----------------------------------------------------------------------------
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
ADtoXaqQFyGYHrIpVt5PUXyDaX24Pcg4gRkuc1KVVNDac4DVvAmcQ3S1DAf8i1dc
0xtCpdvtTo3TqHht8FC7qUKACdwxkZQPqyTHlrF1bqwNwDqdzWk8Ta6773YyrM0I
g9t8OzPWnXtDJCvTWrKirA7vi5PFzbLslBTR/lMBmys=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 11158     )
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
`pragma protect end_protected
// -----------------------------------------------------------------------------

`endif // SVT_EXCLUDE_VCAP

`endif // GUARD_SVT_VCAP_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
ItyAGzVbBBfcWp1XUPFqRz+gaiUyV+lTzCunbPy/evu8MIfPQGv5crGjn/9Jdvrv
Cs0NexyZmwnMxkeY2joTYm3oqtm2nGKaENctsc3/d4vlcGMs4FmdARoK6sXwbgZb
xBb9K56XAToJrR0AbLGrLXc/BKt9/XNE2R5uBJGUkpc=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 11241     )
9XtSQ+G76VnlskiGTw5kvjx8h6F505GL6mrxglnqxNSXn9i3Vm0rilUzwT0e1uYd
7q8/u1FyOEU42UG9Yqpinm/zse27yqZfukhNDAh9gwZk7f9sV1Kvz9jGK8qPaUGT
`pragma protect end_protected

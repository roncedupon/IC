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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
OcjHFbOrtVI/Bl4DQMQOtb/Hq6HD66CnDDvuqv2OQNNR+Lb///2bLY/hHAnVcLsL
0ZZmAeFhpMpngfzOmhZmIyPTPrPZJYyZBcsY99GaCbxNh1OTOa/eOfr734WGivPT
hui8LjZwZTGOrZP6l6j1ITkGF0AIda7/KwXDtQL5sAvie8uvalFkqA==
//pragma protect end_key_block
//pragma protect digest_block
jLIlBywy/7Xj+iQgXO2D3rVaxbg=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
/2ed7zAwFtQJc8lrcj01kJd0ji8=
//pragma protect end_digest_block
//pragma protect end_protected
// -----------------------------------------------------------------------------

`endif // SVT_EXCLUDE_VCAP

`endif // GUARD_SVT_VCAP_SV

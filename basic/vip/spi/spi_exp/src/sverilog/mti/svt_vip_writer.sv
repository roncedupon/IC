//=======================================================================
// COPYRIGHT (C) 2014-2017 SYNOPSYS INC.
// This software and the associated documentation are confidential and
// proprietary to Synopsys, Inc. Your use or disclosure of this software
// is subject to the terms and conditions of a written license agreement
// between you, or your company, and Synopsys, Inc. In the event of
// publications, the following notice is applicable:
//
// ALL RIGHTS RESERVED
//
// The entire notice above must be reproduced on all authorized copies.
//
//-----------------------------------------------------------------------

`ifndef GUARD_SVT_VIP_WRITER_SV
`define GUARD_SVT_VIP_WRITER_SV

`ifndef SVT_VMM_TECHNOLOGY
typedef class svt_non_abstract_report_object;
`endif

// ****************************************************************************
// Defines
// ****************************************************************************

/** @cond PRIVATE */

// =============================================================================
/**
 * The svt_vip_writer_object class is a utility class whose primary purpose is to 
 * provide assistance for storing information about VIP "objects".  Each instance
 * of the class stores data for an object that is being captured by the VIP for
 * later display within Protocol Analyzer or Verdi.
 *
 * IMPORTANT: This class is intended for internal use.  VIP clients should never
 *            invoke any of the methods in the class nor modify the class data
 *            members in any manner.
 */
class svt_vip_writer_object;

  // ****************************************************************************
  // Data Members
  // ****************************************************************************

  /** 
   * The begin time for the object.
   */
  realtime begin_time = -1;

  /** 
   * The end time for the object.
   */
  realtime end_time = -1;

  /** 
   * The name of the object type.
   */
  string object_type = "";

  /** 
   * The uid of the object.
   */
  string object_uid = "";

  /** 
   * The uid of the parent object.  An empty string indicates that the object 
   * has no parent.
   */
  string parent_object_uid = "";

  /** 
   * The uid of the predecessor object.  An empty string indicates that the object 
   * has no predecessor.
   */
  string predecessor_object_uid = "";

  /**
   * Writer object which is required to retrive "svt_vip_writer_object" of predecessor.
   */
  svt_vip_writer predecessor_writer = null;

  /**
   * Writer object which is required to retrive "svt_vip_writer_object" of successor.
   */
  svt_vip_writer successor_writer = null;

  /** 
   * The name of the channel with which the object is associated. An empty string
   * indicates that the object is not associated with any specific channel, which 
   * is the default condition for an object.
   */
  string channel = "";

  /** 
   * The status of the object during the transaction. An empty string
   * indicates that the object is not having any status.
   */
  string status = "";

  /** 
   * The uids of the child objects.  An empty queue indicates that the object 
   * has no child objects.
   */
  string child_object_uids[ $ ];

  /** 
   * The uids of the successor objects.  An empty queue indicates that the object 
   * has no successor objects.
   */
  string successor_object_uids[ $ ];

  /**
   * An associative array used to store the specified field values for the object.
   * The values are stored in as strings that have been formatted appropriately
   * for PA, based on the specified type.
   */
  string field_values[ string ];

  /**
   * An associative array used to store the expected specified field values for
   * the object.  The values are stored in as strings that have been formatted
   * appropriately for PA, based on the specified type.
   */
  string field_expected_values[ string ];
  
  /** 
   * String holds the PA header XML structure to be written out to XML.
   * This is added to support backward compatibility.
   */
   string object_block_desc;   
  
  /** 
   * Bit indicates the object beging block already written to XML.
   * This is added to support backward compatibility.
   */
   bit begin_block_save;   
     
`ifdef SVT_VERDI_FSDB_LIBS_PRESENT
  /**
   * Transaction ID for FSDB dumping.
   */
  longint unsigned transaction_id;

`endif

endclass
// =============================================================================

/**
 * The svt_vip_pa_relation_object class is a utility class whose primary purpose is to 
 * store the relationship between the objects. This class is required because in verdi 
 * will not allow forward processing. This class will capture the relationship and helps 
 * in updating the relationship the relationship data will be displayed within
 * Protocol Analyzer or Verdi.
 *
 * IMPORTANT: This class is intended for internal use.  VIP clients should never
 *            invoke any of the methods in the class nor modify the class data
 *            members in any manner.
 */

class svt_vip_pa_relation_object;

 // ****************************************************************************
 // Data Members
 // ****************************************************************************

 /**
  * Queue to hold the all the related objects.
  */
  string relation_object_uids [ $ ];

endclass

/** @endcond */

// =============================================================================
/**
 * Utility class used to provide assistance writing information about objects
 * to be displayed with the Protocol Analyzer.
 */
class svt_vip_writer;

`ifdef SVT_VMM_TECHNOLOGY
  /** Built-in shared log instance that will be used by the XML writer instance. */
  vmm_log log;
`else
  /** Built-in shared reporter instance that will be used by the XML writer instance. */
  `SVT_XVM(report_object) reporter;
`endif

  // ****************************************************************************
  // Local Data Members
  // ****************************************************************************
  
  /** 
   * The name of the instance with which the data being written is associated. 
   */
  local string instance_name = "";
    
  /** 
   * The name of the protocol with which the data being written is associated.
   */
  local string protocol_name = "";
  
  /** 
   * The version of the protocol with which the data being written is associated.
   */
  local string protocol_version = "";
  
  /** 
   * The name of the suite with which the data being written is associated. 
   * Note that this attribute is only specified for suites that support PA-style
   * extension definitions with multiple sub-protocols. */
  local string suite_name = "";
                                
  /** 
   * The name of the file that is being written to.  Note that the name of the file
   * is constructed from the arguments specified when the writer is constructed.
   */
  local string file_name;

  /** 
   * The handle to the file that is being written to.  A value of 0 indicates that
   * the file has not yet been opened.  A value of -1 indicates that the file has
   * been previously opened and susequently closed.
   */
  local int file_handle = 0;

  /**
   * An associative array used to create unique object identifiers (uids) on a
   * "type-by-type" basis.  For example, the first object of type "x" will have
   * a uid of "x_1"; the second object of type "x" will have a uid of "x_2"; the
   * first object of type "y" will have a uid of "y_1", and so on.
   */
  local int current_object_type_uid[ string ];
 
  /**
   * An associative array used to keep track of unended objects.  Objects are 
   * added to this array when they are created and are removed when the objects 
   * are ended.  This enables the writer to be aware of which objects have not
   * been ended at the time the writer is closed and can write out those objects 
   * with an appropriate end times (-1) and an appropriate status value (NOT_ENDED).
   *
   * This array also acts as a "lookup table" to get a handle to a svt_vip_writer_object
   * based on a specified object uid.
   */
  local svt_vip_writer_object unended_objects[ string ];

  /** 
   * The uids of the child objects.  An empty queue indicates that the object 
   * has no child objects. This is added to support backward compatibility.
   */
  string pa_object_refs[ $ ];

`ifdef SVT_VERDI_FSDB_LIBS_PRESENT
  // ****************************************************************************
  // Local Data Members for FSDB dump
  // ****************************************************************************

  /**
   * An associative array used to keep track of ended objects.  Objects are 
   * added to this array when they are ended and are removed from unended_objects.
   * This enables the writer to find objects when build up relations after objects 
   * are ended.  
   *
   * This array also acts as a "lookup table" to get a handle to a svt_vip_writer_object
   * based on a specified object uid.
   */
  local svt_vip_writer_object ended_objects[ string ];

  /**
   * Relationship object instance, holds all the UIDs which posses the same relationship
   */
  local svt_vip_pa_relation_object pa_relation_object = null; 

  /** 
   * The type of the file to be dumped. 
   * fsdb and fsdb_perf_analysis mean dumping FSDB file only. xml means dumping XML file
   * only. 
   * both means dumping both XML and FSDB files.
   */
  local enum {
    fsdb = `SVT_WRITER_FORMAT_FSDB,
    fsdb_perf_analysis = `SVT_WRITER_FORMAT_FSDB_PERF_ANALYSIS,
    xml = `SVT_WRITER_FORMAT_XML,
    both = `SVT_WRITER_FORMAT_XML_N_FSDB
  } file_format;

  /**
   * The name of FSDB file that is being written to. This is specified by user.
   */
  local string fsdb_file = "";

  /**
   * Array to store the all the relationship object with uid
   */
  local svt_vip_pa_relation_object relation_uids [ string ]; 

  /**
   * The path of parent of streams. It is constructed by protocol_name, 
   * instance_name, protocol_version, and it is used to construct stream name.
   */
  local string fsdb_stream_parent = "";

  /**
   * The path of scope It is constructed using suite name and protocol name.
   */
  local string scope_full_path = "";

  /**
   * An associative array used to keep track of stream ids based on object type.
   * Objects with the same object type will be added as transactions into one 
   * stream in FSDB.
   */
  static longint unsigned stream_id_array[ string ];
 
  /**
   * An associative array to store the full protocol name.
   */
  int protocol_name_array[ string ];

  /**
   * Queue to hold the attribute names which need to be added for
   * the current written out stream.
   */
  string stream_attribute_names[$];
  
  /**
   * Queue to hold the attribute values which need to be added for
   * the current written out stream.
   */
  string stream_attribute_values[$];

  /**
   * The FSDB utility handle to make the FSDB calls
   */
  local svt_vip_writer_fsdb_util fsdb_util;
  
`endif

  /** Saved top level scope for this VIP instance */
  local string top_level_scope;

  // ****************************************************************************
  // Constructor
  // ****************************************************************************

  // ----------------------------------------------------------------------------
  /**
   * Constructs a new instance of the svt_vip_writer class.
   *
   * @param instance_name 
   *          The name of the instance with which the writer is associated.
   * @param protocol_name 
   *          The name of the protocol with which the objects being written
   *          are associated.
   * @param protocol_version 
   *          The version of the protocol.
   * @param suite_name 
   *          The name of the suite with which the protocol is associated.
   *          This is only required for suites that support PA-style extension
   *          definitions with multiple sub-protocols.
   * @param file_name 
   *          The name of the xml file, if the name is empty then the name will be
              constructed using 'instance_name' and 'protocol_name'.
   * @param format_type 
   *          The file format type in which the data to be written out. 
   */
  extern function new( string instance_name, 
                       string protocol_name, 
                       string protocol_version, 
                       string suite_name = "", 
                       string file_name = "",
                       int format_type = `SVT_WRITER_FORMAT_FSDB );

  // -------------------------------------------------------------------------------
  /**
   * Utility method to set up the VIP writer class to be used with the debug
   * opts infrastructure.  This is used to modify the top-level scope that transactions
   * are recorded in.
   * 
   * @param vip_path Hierarchical path to the VIP instance
   */
  extern function void enable_debug_opts(string vip_path);

  // -------------------------------------------------------------------------------
  /**
   * This method set the file format type enum to the format the data needs to be dumpped.
   * The format types: `SVT_WRITER_FORMAT_FSDB FSDB, `SVT_WRITER_FORMAT_XML XML, and
   * `SVT_WRITER_FORMAT_XML_N_FSDB for both FSDB and XML. 
   * @param format_type file format type in which the data to be written out.
   */
  extern function bit set_file_dump_format(int format_type); 

  // -------------------------------------------------------------------------------
  /**
   * Method to get the format type which has been established. 
   * The format types: `SVT_WRITER_FORMAT_FSDB FSDB, `SVT_WRITER_FORMAT_XML XML, and
   * `SVT_WRITER_FORMAT_XML_N_FSDB for both FSDB and XML.
   *
   * @return The format type associated with the writer.
   */
  extern function int get_format_type(); 

  // ****************************************************************************
  // Open / Close Writer Methods
  // ****************************************************************************

  // ----------------------------------------------------------------------------
  /**
   * Opens the file handle for a file in write mode.  This method must be called prior 
   * to creating any objects that are associated with the writer.
   *
   * @return The status of the operation; 1 = success, 0 = failure.
   */
  extern virtual function bit open_writer();

  // ----------------------------------------------------------------------------
  /**
   * Closes the file handle for the currently opened file.  Once the writer is closed,
   * no additional objects can be associated with the writer.
   *
   * @return The status of the operation; 1 = success, 0 = failure.
   */
  extern virtual function bit close_writer();

  // ----------------------------------------------------------------------------
  /**
   * Gets the opened / closed status of the writer.
   *
   * @return The current open / closed status.
   */
  extern function bit is_writer_open();

  // ****************************************************************************
  // Create, Begin and End Object Methods
  // ****************************************************************************

  // ----------------------------------------------------------------------------
  /**
   * Creates a new object and returns the uid for the newly-created object.  The 
   * start time for the object is set to the current simulation time.
   *
   * @param object_type 
   *          The type of object to be created.
   * @param object_uid 
   *          The uid for the object to be created.  If not specified, a uid is
   *          automatically created, based on the specified object type.
   * @param parent_object_uid
   *          The uid of the parent object, if applicable and known at the time
   *          the object is being created.  This value can be set up until the
   *          point at which the object is ended.
   * @param object_channel 
   *          The channel with which the object is associated, if applicable and
   *          known at the time the object is being created.  This value can be
   *          set up until the point at which the object is ended.
   * @param begin_time
   *          The start time of the object. If the start time is not passed, 
   *          the current time is set as start time. The start time will be used
   *          for XML to support backward compatibility and also in cases where the 
   *          start time of the object can't be determined during the start of the 
   *          object. If the object time is know during the start of the object don't
   *          pass strat time, leave it to the writer to add the current time.
   * @param end_time The end time of the object. The will be used only for XML to support
   *          backward compatibility. FSDB will not accept end time and expect the object
   *          end si called exactly when the object ends.  
   * @param status The status of the object.
   * @param time_unit Time unit used during the simulation.
   * @param label If specified, sets the label of the object; otherwise the name
   *          of the object type is used.
   * @param attr_name Queue of stream attribute names to add
   * @param attr_val Queue of stream attribute values to add
   *
   * @return The uid of the new object.  If the object uid was specified, the
   *         same string is returned.  An empty string indicates that an error
   *         occurred while attempting to create the new object.
   */
  extern virtual function string object_create( string object_type, 
                                                string object_uid = "", 
                                                string parent_object_uid = "", 
                                                string object_channel = "",
                                                realtime begin_time = -1,
                                                realtime end_time = -1,
                                                string status = "", 
                                                string time_unit = "",
                                                string label = "",
                                                string attr_name[$] = '{},
                                                string attr_val[$] = '{});

  // ----------------------------------------------------------------------------
  /**
   * Creates a new object XML data and save it to temp data structure.
   * This method is added for backward compatibility.
   * This method receives the complete begin block to be written.
   *
   * @param object_uid 
   *          The uid for the object to be created.  If not specified, a uid is
   *          automatically created, based on the specified object type.
   * @param object_block_desc 
   *          The object_desc which contains the XML block for PA object header.
   */
  extern virtual function bit save_object_begin_block( string object_uid , 
                                                       string object_block_desc = ""); 

  // ----------------------------------------------------------------------------
  /**
   * Begins an object.  When this method is called, the begin time of the object
   * is set to the current simulation time, if not already set.  If the begin time
   * of the object has already been set, the object has already been started and
   * this method will have no effect on the object; however, an error will be
   * reported and the method will return a failure status.
   *
   * @param object_uid
   *          The uid of the object to be ended.
   * @return The status of the operation; 1 = success, 0 = failure.
   */
  extern virtual function bit object_begin( string object_uid );

  // ----------------------------------------------------------------------------
  /**
   * Ends an object.  When this method is called, the end time of the object is
   * set to the current simulation time.  At this point, all information about
   * the object is considered to have been specified; thus, no further changes
   * can be made to the attributes associated with the object.
   *
   * It is important that all objects be ended at the appropriate time during
   * the simulation.  Objects that have not been ended at the conclusion of the 
   * simulation will have a status of NOT_ENDED, which is considered to be an
   * error condition.
   *
   * @param object_uid
   *          The uid of the object to be ended.
   * @return The status of the operation; 1 = success, 0 = failure.
   */
  extern virtual function bit object_end( string object_uid );

  // ****************************************************************************
  // General Object Methods
  // ****************************************************************************

  // ----------------------------------------------------------------------------
  /**
   * Specifies the channel with which the object with the specified uid is 
   * associated.  This method can be called up until the point at which the 
   * object is ended.
   *
   * @param channel
   *          The name of the channel with which the object is to be associated.
   *          If an empty string is specified, the object is not associated with
   *          any channel (which is the default condition for an object).
   * @return The status of the operation; 1 = success, 0 = failure.
   */
  extern virtual function bit set_object_channel( string object_uid,
                                                  string channel );

  // ----------------------------------------------------------------------------
  /**
   * Specifies the uid of the parent object for the object with the specified uid.
   * This method can be called up until the point at which the object is ended.
   *
   * At the time this method is called, no checks are performed to validate the 
   * uid that is specified for the parent object.  This allows a parent object to
   * be specified as (a) an object that has not yet been created (assuming that
   * object uids are being managed / constructed by the VIP and are not being 
   * automatically generated by the VIP writer); or (b) the parent object has been 
   * created (so that the uid of the object has been constructed), but that the
   * object has not yet begun.
   *
   * If at the time the simulation ends, no object with the uid specified for the
   * parent object has been created, PA will report this situation when the data
   * created by the VIP is being read into a protocol view in a project.
   *
   * @param object_uid
   *          The uid of the object whose parent object is to be specified.
   * @param parent_object_uid
   *          The uid of the parent object.
   * @return The status of the operation; 1 = success, 0 = failure.
   */
  extern virtual function bit set_object_parent( string object_uid,
                                                 string parent_object_uid );

  // ----------------------------------------------------------------------------
  /**
   * Adds a child object to the object with the specified uid.  An object can have
   * multiple child objects, as appropriate for the protocol.  This method can be 
   * called up until the point at which the object is ended.
   *
   * At the time this method is called, no checks are performed to validate the 
   * uid that is specified for the child object.  This allows a child object to
   * be specified as (a) an object that has not yet been created (assuming that
   * object uids are being managed / constructed by the VIP and are not being 
   * automatically generated by the VIP writer); or (b) the child object has been 
   * created (so that the uid of the object has been constructed), but that the
   * object has not yet begun.
   *
   * If at the time the simulation ends, no object with the uid specified for the
   * child object has been created, PA will report this situation when the data
   * created by the VIP is being read into a protocol view in a project.
   *
   * @param object_uid
   *          The uid of the object to which a child object is to be added.
   * @param child_object_uid
   *          The uid of the child object.
   * @return The status of the operation; 1 = success, 0 = failure.
   */
  extern virtual function bit add_object_child( string object_uid,
                                                string child_object_uid );

  // ----------------------------------------------------------------------------
  /**
   * Adds an array of child objects to the object with the specified uid.  This
   * method can be called up until the point at which the object is ended.
   *
   * At the time this method is called, no checks are performed to validate the 
   * uids that are specified for the child objects.  This allows any or all of
   * the child objects to be specified as (a) objects that have not yet been
   * created (assuming that object uids are being managed / constructed by the
   * VIP and are not being automatically generated by the VIP writer); or (b) the
   * child objects have been created (so that the uids of the objects have been
   * constructed), but that the object has not yet begun.
   *
   * If at the time the simulation ends, no object with the uid specified for any
   * of the child objects has been created, PA will report this situation when the
   * data created by the VIP is being read into a protocol view in a project.
   *
   * @param object_uid
   *          The uid of the object to which a child objects are to be added.
   * @param child_object_uids
   *          The uids of the child objects.
   * @return The status of the operation; 1 = success, 0 = failure.
   */
  extern virtual function bit add_object_children( string object_uid,
                                                   string child_object_uids[] );
  // ----------------------------------------------------------------------------
  /**
   * Adds an array of interface path into the FSDB scope with a predefined attribute name. 
   * The interface path is added to predefined attribute name "verdi_link_interface"
   * by which we can take advantage of verdi APIs to read the data from FSDB.
   * If the interface paths are multiple the attribute name will be incremented with numeric 
   * Eg:"verdi_link_interface_1","verdi_link_interface_2" etc.
   *
   * @param if_paths
   *          The interface paths for all the interfaces.
   */
  extern virtual function void add_if_paths( string if_paths[] );

  // ----------------------------------------------------------------------------
  /**
   * Adds an single object ref to XML file.  This method is added to support
   * backward compatibility.
   *
   * @param ref_object_uid
   *          The string formatted in XML contains the child object uid for the object.
   * @return The status of the operation; 1 = success, 0 = failure.
   */
  extern virtual function bit add_pa_reference( string ref_object_uid);
  
  // ----------------------------------------------------------------------------
  /**
   * Specifies the uid of the predecessor object for the object with the specified
   * uid.  This method can be called up until the point at which the object is 
   * ended.
   *
   * At the time this method is called, no checks are performed to validate the 
   * uid that is specified for the predecessor object.  This allows a predecessor
   * object to be specified as (a) an object that has not yet been created (assuming
   * that object uids are being managed / constructed by the VIP and are not being 
   * automatically generated by the VIP writer); or (b) the predecessor object has 
   * been created (so that the uid of the object has been constructed), but that
   * the object has not yet begun.
   *
   * If at the time the simulation ends, no object with the uid specified for the
   * predecessor object has been created, PA will report this situation when the
   * data created by the VIP is being read into a protocol view in a project.
   *
   * @param object_uid
   *          The uid of the object whose predecessor object is to be specified.
   * @param predecessor_object_uid
   *          The uid of the predecessor object.
   * @param predecessor_writer
   *          The "svt_vip_writer" instance with which the predecessor object is
   *          associated or null for the current writer.
   * @return The status of the operation; 1 = success, 0 = failure.
   */
  extern virtual function bit set_object_predecessor( string object_uid,
                                                      string predecessor_object_uid, 
                                                      svt_vip_writer predecessor_writer = null);

  // ----------------------------------------------------------------------------
  /**
   * Adds a successor object to the object with the specified uid.  An object can
   * have multiple successor objects, as appropriate for the protocol.  This method
   * can be called up until the point at which the object is ended.
   *
   * At the time this method is called, no checks are performed to validate the 
   * uid that is specified for the successor object.  This allows a successor object
   * to be specified as (a) an object that has not yet been created (assuming that
   * object uids are being managed / constructed by the VIP and are not being 
   * automatically generated by the VIP writer); or (b) the successor object has 
   * been created (so that the uid of the object has been constructed), but that the
   * object has not yet begun.
   *
   * If at the time the simulation ends, no object with the uid specified for the
   * successor object has been created, PA will report this situation when the data
   * created by the VIP is being read into a protocol view in a project.
   *
   * @param object_uid
   *          The uid of the object to which a successor object is to be added.
   * @param successor_object_uid
   *          The uid of the successor object.
   * @param successor_writer
   *          The "svt_vip_writer" writer with which the successor object is
   *          associated or null for the current writer.
   * @return The status of the operation; 1 = success, 0 = failure.
   */
  extern virtual function bit add_object_successor( string object_uid,
                                                    string successor_object_uid, 
                                                    svt_vip_writer successor_writer = null );

  // ----------------------------------------------------------------------------
  /**
   * Adds an array of successor objects to the object with the specified uid.
   * This method can be called up until the point at which the object is ended.
   *
   * At the time this method is called, no checks are performed to validate the 
   * uids that are specified for the successor objects.  This allows any or all
   * of the successor objects to be specified as (a) objects that have not yet
   * been created (assuming that object uids are being managed / constructed by
   * the VIP and are not being automatically generated by the VIP writer); or 
   * (b) the successor objects have been created (so that the uids of the objects
   * have been constructed), but that the object has not yet begun.
   *
   * If at the time the simulation ends, no object with the uid specified for any
   * of the successor objects has been created, PA will report this situation when
   * the data created by the VIP is being read into a protocol view in a project.
   *
   * @param object_uid
   *          The uid of the object to which a successor objects are to be added.
   * @param successor_object_uids
   *          The uids of the successor objects.
   * @param successor_writer
   *          The "svt_vip_writer" writer with which the successor object is
   *          associated or null for the current writer.
   * @return The status of the operation; 1 = success, 0 = failure.
   */
  extern virtual function bit add_object_successors( string object_uid,
                                                     string successor_object_uids[],
                                                     svt_vip_writer successor_writer = null);

  /** Get a handle to the file that is being written to. */
  extern function int get_file_handle();

  /**
   * Records various aspects of the VIP in the FSDB as scope attributes
   * 
   * NOTE: This method has been deprecated and should no longer be used.
   * 
   * @param vip_name Hierarchical name to the VIP instance
   * @param if_path Path to the interface instance
   */
  extern function void record_vip_info(string vip_name, string if_path);

  // ****************************************************************************
  // Object Field Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  // Bit Field Methods
  //----------------------------------------------------------------------------

  // ---------------------------------------------------------------------------
  /**
   * Specifies the value of a bit field for an object.  This method can be 
   * called up until the point at which the object is ended; however, only
   * the last value specified is associated with the field.
   *
   * @param object_uid 
   *          The uid of the object to be modified.
   * @param field_name 
   *          The name to be field whose value is being specified.
   * @param field_value 
   *          The field value.
   * @param expected_field_value 
   *          The expected field value.  If this value differs from the field_value,
   *          the object will be marked as having an error condition.
   * @param has_expected
   *          The flag to indicate if expected_field_value differs from the
   *          field_value.
   * @return The status of the operation; 1 = success, 0 = failure.
   */
  extern virtual function bit set_object_field_value_bit( string object_uid,
                                                          string field_name,
                                                          bit    field_value,
                                                          bit    expected_field_value = 0,
                                                          bit    has_expected = 0 );

  //----------------------------------------------------------------------------
  // Bit-vector Field Methods
  //----------------------------------------------------------------------------

  // ---------------------------------------------------------------------------
  /**
   * Specifies the value of a bit-vector field for an object.  This method can 
   * be called up until the point at which the object is ended; however, only
   * the last value specified is associated with the field.
   *
   * @param object_uid 
   *          The uid of the object to be modified.
   * @param field_name 
   *          The name to be field whose value is being specified.
   * @param field_value 
   *          The field value.
   * @param numbits
   *          The bits size of the value required for FSDB.
   * @param expected_field_value 
   *          The expected field value.  If this value differs from the field_value,
   *          the object will be marked as having an error condition.
   * @param has_expected
   *          The flag to indicate if expected_field_value differs from the
   *          field_value.
   * @return The status of the operation; 1 = success, 0 = failure.
   */
  extern virtual function bit set_object_field_value_bit_vector( string       object_uid,
                                                                 string       field_name,
                                                                 bit [1023:0] field_value,
                                                                 int          numbits = 4096,
                                                                 bit [1023:0] expected_field_value = 0,
                                                                 bit          has_expected = 0 );

  //----------------------------------------------------------------------------
  // Logic-vector Field Methods
  //----------------------------------------------------------------------------

  // ---------------------------------------------------------------------------
  /**
   * Specifies the value of a logic-vector field for an object.  This method can 
   * be called up until the point at which the object is ended; however, only
   * the last value specified is associated with the field.
   *
   * @param object_uid 
   *          The uid of the object to be modified.
   * @param field_name 
   *          The name to be field whose value is being specified.
   * @param field_value 
   *          The field value.
   * @param numbits
   *          The bits size of the value required for FSDB.
   * @param expected_field_value 
   *          The expected field value.  If this value differs from the field_value,
   *          the object will be marked as having an error condition.
   * @param has_expected
   *          The flag to indicate if expected_field_value differs from the
   *          field_value.
   * @return The status of the operation; 1 = success, 0 = failure.
   */
  extern virtual function bit set_object_field_value_logic_vector( string         object_uid,
                                                                   string         field_name,
                                                                   logic [1023:0] field_value,
                                                                   int            numbits = 4096,
                                                                   logic [1023:0] expected_field_value = 0,
                                                                   bit            has_expected = 0 );

  //----------------------------------------------------------------------------
  // Integer Field Methods
  //----------------------------------------------------------------------------

  // ---------------------------------------------------------------------------
  /**
   * Specifies the value of a integer field for an object.  This method  can
   * be called up until the point at which the object is ended; however, only
   * the last value specified is associated with the field.
   *
   * @param object_uid 
   *          The uid of the object to be modified.
   * @param field_name 
   *          The name to be field whose value is being specified.
   * @param field_value 
   *          The field value.
   * @param numbits
   *          The bits size of the value required for FSDB.
   * @param expected_field_value 
   *          The expected field value.  If this value differs from the field_value,
   *          the object will be marked as having an error condition.
   * @param has_expected
   *          The flag to indicate if expected_field_value differs from the
   *          field_value.
   *
   * @return The status of the operation; 1 = success, 0 = failure.
   */
  extern virtual function bit set_object_field_value_int( string  object_uid,
                                                          string  field_name,
                                                          longint field_value,
                                                          int     numbits = 32,
                                                          longint expected_field_value = 0,
                                                          bit     has_expected = 0 );

  //----------------------------------------------------------------------------
  // Real Field Methods
  //----------------------------------------------------------------------------

  // ---------------------------------------------------------------------------
  /**
   * Specifies the value of a real field for an object.  This method can be 
   * called up until the point at which the object is ended; however, only
   * the last value specified is associated with the field.
   *
   * @param object_uid 
   *          The uid of the object to be modified.
   * @param field_name 
   *          The name to be field whose value is being specified.
   * @param field_value 
   *          The field value.
   * @param expected_field_value 
   *          The expected field value.  If this value differs from the field_value,
   *          the object will be marked as having an error condition.
   * @param has_expected
   *          The flag to indicate if expected_field_value differs from the
   *          field_value.
   *
   * @return The status of the operation; 1 = success, 0 = failure.
   */
  extern virtual function bit set_object_field_value_real( string object_uid,
                                                           string field_name,
                                                           real   field_value,
                                                           real   expected_field_value = 0,
                                                           bit    has_expected = 0 );

  //----------------------------------------------------------------------------
  // Time Field Methods
  //----------------------------------------------------------------------------

  // ---------------------------------------------------------------------------
  /**
   * Specifies the value of a time field for an object.  This method can be 
   * called up until the point at which the object is ended; however, only
   * the last value specified is associated with the field.
   *
   * @param object_uid 
   *          The uid of the object to be modified.
   * @param field_name 
   *          The name to be field whose value is being specified.
   * @param field_value 
   *          The field value.
   * @param expected_field_value 
   *          The expected field value.  If this value differs from the field_value,
   *          the object will be marked as having an error condition.
   * @param has_expected
   *          The flag to indicate if expected_field_value differs from the
   *          field_value.
   * @return The status of the operation; 1 = success, 0 = failure.
   */
  extern virtual function bit set_object_field_value_time( string object_uid,
                                                           string field_name,
                                                           realtime   field_value,
                                                           realtime   expected_field_value = 0,
                                                           bit    has_expected = 0, 
                                                           string time_unit_val = "" );

  //----------------------------------------------------------------------------
  // String Field Methods
  //----------------------------------------------------------------------------

  // ---------------------------------------------------------------------------
  /**
   * Specifies the value of a string field for an object.  This method can be
   * called up until the point at which the object is ended; however, only the
   * last value specified is associated with the field.
   *
   * @param object_uid 
   *          The uid of the object to be modified.
   * @param field_name 
   *          The name to be field whose value is being specified.
   * @param field_value 
   *          The field value.
   * @param expected_field_value 
   *          The expected field value.  If this value differs from the field_value,
   *          the object will be marked as having an error condition.
   * @param has_expected
   *          The flag to indicate if expected_field_value differs from the
   *          field_value.
   * @return The status of the operation; 1 = success, 0 = failure.
   */
  extern virtual function bit set_object_field_value_string( string object_uid,
                                                             string field_name,
                                                             string field_value,
                                                             string expected_field_value = "",
                                                             bit    has_expected = 0 );

  //----------------------------------------------------------------------------
  // Tag Methods
  //----------------------------------------------------------------------------

  // ---------------------------------------------------------------------------
  /**
   * Adds a tag to an object.  This method can be called up until the point at
   * which the object is ended; however, only the last value specified is
   * associated with the object.
   *
   * @param object_uid 
   *          The uid of the object to be tagged.
   * @param tag_name 
   *          The name of the tag to be added.
   * @return The status of the operation; 1 = success, 0 = failure.
   */
  extern virtual function bit add_object_tag( string object_uid,
                                              string tag_name );

  // ****************************************************************************
  // Local Methods
  // ****************************************************************************

  // ---------------------------------------------------------------------------
  /**
   * Retrieves the instance of the svt_vip_writer_object class that is associated
   * with the specified object uid.  If no object can be located within the array 
   * of unended objects, the method will report and error and return null.
   *
   * @param object_uid 
   *          The uid of the object to be found.
   * @param check_begin_time 
   *          Indicates whether or not the object begin time should be checked.
   *          If this attribute is set to 1, and the object begin time is -1, 
   *          the method will report and error and return null.  Note that by
   *          default, the object begin time is checked.
   * @param find_all
   *          Indicates whether or not to only look for unended objects.  If this
   *          attribute is set to 1, the method will only look for unended objects.
   *          If this attribute is set to 0, the method will look for both ended
   *          and unended objects.
   * @return The instance of the svt_vip_writer_object class that is associated
   *         with the specified object uid, or null, if no such object was found.
   */
  extern function svt_vip_writer_object get_object_from_uid( string object_uid, 
                                                             bit    check_begin_time = 1,
                                                             bit    find_all = 0 );

  // ---------------------------------------------------------------------------
  /**
   * Creates a string that can be specified as an attribute value in an XML file
   * by replacing any characters that would otherwise lead to processing errors.
   *
   * @param original_string 
   *          The string to be processed.
   * @return The "XML-friendly" string (which may be the same as the original string).
   */
  extern local function string create_xml_attribute_string( string original_string );

  // ----------------------------------------------------------------------------
  /**
   * Ends an object.  When this method is called, the end time of the object is
   * set to the current simulation time or left unchanged (meaning the end time
   * is -1 and this method is being called to write out unended objects).  At this
   * point (under either scenario), all information about the object is considered
   * to have been specified; thus, no further changes can be made to the attributes
   * associated with the object.
   *
   * @param pa_object
   *          The object to be ended, if available; otherwise, this value should 
   *          be set to null and the value of object_uid will be utilized to find
   *          the object of interest.
   * @param object_uid
   *          The uid of the object to be ended.  This value is ignored if a
   *          non-null handle to a svt_vip_writer_object is provided.
   * @param set_end_time
   *          Indicates whether or not the end time of the object should be set
   *          to the current simulation time or left unchanged.
   * @return The status of the operation; 1 = success, 0 = failure.
   */
  extern local function bit local_object_end( svt_vip_writer_object pa_object,
                                              string object_uid,
                                              bit    set_end_time = 1 );

  // ----------------------------------------------------------------------------
  /**
   * Writes the data associated with an object.
   *
   * @param pa_object 
   *          The object to be written.
   * @return The status of the operation; 1 = success, 0 = failure.
   */
  extern local function bit write_object( svt_vip_writer_object pa_object );

  /**
   * Transform a string into legal name for FSDB dumping. FSDB treats "." as
   * delimiter for hierarchy.
   * 
   * @param name
   *        The string to be transformed.
   * @return
   *        The transformed string, which is a legal name for FSDB.
   */
  extern local function string get_legal_fsdb_name( string name );

  /**
   * Find stream id with given object type.
   * 
   * @param object_type
   *             The object type to look for
   * @param object_channel
   *             The channel for which object belongs
   * @param attr_name 
   *             Queue of stream attribute names to add
   * @param attr_val
   *             Queue of stream attribute values to add
   * @return
   *             The stream id if found, 0 if not found.
   */
  extern local function longint unsigned get_stream_id_by_type( string object_type, 
                                                                string object_channel, 
                                                                string attr_name[$] = '{}, 
                                                                string attr_val[$] = '{});

  // ----------------------------------------------------------------------------
  /**
   * Utility function used to add a scope attribute, incorporating 'fsdb_file' if present.
   * 
   * @param attr_name The name of the attribute to be added.
   * @param attr_value The value associated with the attribute
   * @param scope_name The name of the scope for which the attribute needs to be added.
   *                    If the scope name is empty then the scope attribute will be added to the 
   *                    'parent' scope. The default scope name will be empty.
   * @return The status of the operation; 1 = success, 0 = failure.
   */
  extern function bit add_scope_attribute(string attr_name, string attr_value, string scope_name = "");

  // ----------------------------------------------------------------------------
  /**
   * Utility function used to add a stream attribute.
   * 
   * @param attr_name The name of the attribute to be added.
   * @param attr_value The value associated with the attribute
   * @return The status of the operation; 1 = success, 0 = failure.
   */
  extern function bit add_stream_attribute( string attr_name, string attr_value );
  
  // ----------------------------------------------------------------------------
  /**
   * This function sets the custom transaction relation for the 'target_object_uid' to the  
   * 'source_object_uid' inside FSDB.
   *
   * @param source_object_uid
   *          The uid of the object whose custom relation object is to be specified.
   * @param target_object_uid
   *          The uid of the custom relation object.
   * @param relation_type
   *          The custom relation type which needs to associated, eg: if the two transactions
   *          are identical then the relation type value should 'identical'.
   * @param target_writer
   *          The "svt_vip_writer" instance with which the custom object is
   *          associated or null for the current writer.
   * @return The status of the operation; 1 = success, 0 = failure.
   */
  extern virtual function bit set_custom_relation( string source_object_uid,
                                                   string target_object_uid,
                                                   string relation_type,
                                                   svt_vip_writer target_writer = null );

 // ----------------------------------------------------------------------------
  /**
   * This function sets the custom transaction relation for all 'target_object_uids' to 
   * the 'source_object_uid' inside FSDB.
   *
   * This method calls the 'svt_vip_writer' method to write out the custom relation 
   * into indicated XML/FSDB. 
   *
   * @param source_object_uid
   *          The uid of the object whose custom object is to be specified.
   * @param target_object_uids
   *          Set of uids of the custom relation objects.
   * @param relation_type
   *          The custom relation type which needs to associated, eg: if the two transactions
   *          are identical then the relation type value should 'identical'.
   * @param target_writer
   *          The "svt_vip_writer" instance with which the custom relation object is
   *          associated or null for the current writer.
   * @return The status of the operation; 1 = success, 0 = failure.
   */
  extern virtual function bit set_custom_relations( string source_object_uid,
                                                    string target_object_uids[],
                                                    string relation_type, 
                                                    svt_vip_writer target_writer = null );

endclass

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
GrWd1E/pwD28KIUl2oSMOwQuP28ZgdvOWesByx2Yqt1pEr/234V7HGKkjaRNroNr
F54Nx02ZF8dUFVHtbm4WFOSUi86ZiSTTm5U0lgT1CnxO15Cvqp61y09JVvaSCGUr
Rzzar82kj3IAiyj+yrXNu4v/TZ3Cj8+/OwNiKSNR1YU=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 74132     )
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
ywaG1lJwx1L/tr69xeUrJXCj37fUBHMzvbV79MRFoGYNe+jXMYrjlu96q9W14eEA
S1bOwr8Vzp81ylo9y4k+bJlHk6py+Dtmq23N/vpoi6Po0NqnlF93aRMP1FsN3MQJ
LDxy2TkPBPCuCqBjtcSRbBXwoaZ59ExWZs9EoTTOB7SCMjiA3mhvxellflqXmEu1
lIDk0m5WHXpsn8/WVn0SMGEJwJ18t/dc2hBF+qcTWRNQbzks+TrOdofu6XEcyokG
CCwX7J4grZd47iHUjLhxdMjnKiVIF85Hq4QpkCXBk9hwSCQOL7qI5VnLkAqAUc2I
45biZHcTx49OQRfZm56IB/tFcYDOcIQs77yhWM/2JXn4wdJbLP8UwBcVgzZHBF5o
wu4WfOv8O3zM5ZhQrVW5dwKaauzaoqx3WMZJVRU3ngV9G9on1dAQ3FLETvLvQHyU
BwqQ3ab4jZxtWYy2kE1layxH5+/pQSDrAfnYd/H2zfN2k9jX2n9MOBMicXJTOleE
nnRfaBr4oXvV87sOgsElfZjQL1OkPY/q/7WLY2U4PHXbOK/HLtGA7kndN1d1ySCG
yFZik1cCAAL4TUUd8idzJXGzq+y5q2zPh4IvFMYeA7vApU4M0BehxWt96Tasci5L
tUVBfVpvEuOeaCJ0bBOm6SE/zQeKJ9KJhaSsebfd2OsxOeoDBy1mhIo9vbB5dL+r
baTgHc5xgzs9CK7VgqwiIwQegRV00VB+6YEtpeM0zT+ufELVKmYnghNg90TBvvHo
3LuP0GSbvV34DD1toLhvyMYxh1wA80Uw0wH85DBYt1jydhD8NofyOrKG9YJrEK16
bpX21Xxq3txc69tGUjHZ4KF9Hdt898fiuVXBlGt8qWkfdaCvB89xXRmiOvowKXxf
My8DJXO8cFdo98taUVvJg7/D8V436ejm4/LTyaouZuZREW7o34KoBOuIlvGCW+No
3bFZF0iy9XCMi1L++ez3iinOpEc9r0rc9gMQhYI2loLxSL6d8kJxwPw+9j6Gwbwq
rnqkz5lnLdPDSK27h1H7rhahDjqBM4cQreW8ua9C//ipn4Tu76J1wbqrQYjxmSrv
FS6vdxqM7M6mwzi3g7mFFSRZhhCThs+S7pgCd6LlxBusF+vcbDl/L10ljKI9WH/5
n+zCzUkKYPdAJM0SmVVu21u3ViEXzS85aDazLRb1+joAxlzAKq9wHUAXSUA6DRWb
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
`pragma protect end_protected

`endif // GUARD_SVT_VIP_WRITER_SV

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
GlTYvra/fZ6DIIIVK00/FdNC4Ov18ww6T1Sx4GkbU/TqjbReNY2lwpmKZlvs8kLY
iYdrOqOLIIqeFY7KZJ5jKXZWBSDHE9jd5Cy/KPR+Qvxd5wUhz4TtE4dZ8CdoMMJl
BtFQdEouN+a4LrfChlaXFPFR0x58DLU2x30OiOzG6F0=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 74215     )
kPDrHefYXlCt64iW5gPH5SJ4CH1HKyq2MgtK9+LXn12Lx6O0TBiLNrGKBjHRXmLV
NQovwyCQORapf8oSbMoxrMbmHR7N8GkRzuUgJ68B/ThjB3djziznItfWZMPTJlIa
`pragma protect end_protected

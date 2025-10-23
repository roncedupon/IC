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

`protected
3e):V6Z8DQe=K8])3=I2&-g.fFN:S?SSQc97M&\.bWF=ZI:RG9M66)WbAD+D0N/C
@HZ5K0-V8Cb-(IW2WS4<Y4Y.26?^5TGc+cLFGVRc33SOB=c0BJ-R\/2KIfS+g]55
UN2/^dRY(]eFVO5R6=[VYM=_6^FDZ<bL_aVHAaa2.Y_OU,L?\U^-\KSZg=P?5&TP
3-V3._bD#g;dVJF>,X7)42XL&S=WBb(?DA+H((\:fKc=Tg75[M.E<U10QI3L#I<<
9Ie:[HZ8\#c1^4&bG;9FF2EY<1XaV@N4088J?[0O,Q/E)[gPd\.R4U<;21#ZH4JP
,540Fb=XReC6_dg+LQRT1dA?[>SE=\QEJYR@TgWX)EH#?HY<X4B^YFILDZ+3_TBe
QcJ06cOZ?/FG#L\Q<#TCAf&]C4eR=1BRTFe^Yc-_>\@bIU7=8fDP@C+=)J^X&I1?
CT-RMQeV@CQAW9VLEWI0>&A8L\A(a@1RI&V;]XL3R]XN5J/42?+g.&(U,R(?CKaJ
#Ve>6U2WI=;^2NI0-eV@e8D7UFZ1T04T)UcEYeGHV>?PUNF&?A;(NX+AbBXf5NU6
KELPc_U)D/MZgEN\5d5BU2e0\@D26#DXL:WRAJ-6:N?R=6VESJT?bS98EaYPUU;G
<DHc.e8abe]aS3;c+CG5#.SGC1-]4#D,^d49g&]203Z&(-Mc_C?@##K3YBgaU#H0
UFYgQZ8A]5/9Hd2,K/Z52U&R3CV&EYgXIRIY,-EXLP4W>aQWDDS612/0H]eGD0bG
c[5QHPba4;dBL0U=J>FQ0HE&=_1ICA]@B.;@:f<^I7?[WSW+I@D>/@NC=;XR^=)2
]J##V6>CR:Q43@D#<O1L2_G#eJ,/[\MW:5FXS[\[OcQ6D[Eg&[8ORDRMF4H6;8RS
8?C&g:T69[#4a\,=&,GQV?OWA,R\2.9JG:F.6gQY4D9YeHPQP+8I&I.>.d(B6L,V
VVfK9Qa,1S_L)POO8B1D/5g@VUZU6KPeLW&F]Q():,1c8_-=5dfN.UBG7I[Y03DC
]A0B>9PaHT(e1GZ/?[>QU&R+?88a6d]K10<WF?IC,cM=6.Q,,Oe@]@D3[+=YYU8C
9_fS2N/+UbQAKSI-^P>=,__X)\7IY-gFcU1A)J.9CFN#4fU#?[gFG5UK^IS;c/8K
GU1Y2B)\2c/IA[V1YSX@dO>PQ/RJLQC/JNY<]F:&,ZX1f]<YU1S3QW-5OWF+;3TC
Ic3BC4[7QAQ4[WM[D4]/QfLG#1QFN74P/)(ONQP:<1#0/<_AS27b1?eY,HX(4I5S
GN4BB62Q^[bLXVE#Q+Z<BU16B?41Bc.AL(:bBXHDTKT8<HFCBS85.g3-NW3^HFdY
/RIOUSQFAA4NeI,FdY2ZJAIHbd:dA-Z>d0eCg=M7NGH-f,@M90Dbb-b1WV>g&3_b
<;O1DLSb2J[1BgE,L49PFJN@^S#;Z3/SF3,Z-H)3b<eg#b_(<..eCMDAKdd=P;..
5CE1@c22<ALG644PL-Y=_=dS@5bKZ_2J/JRWTb.W4?U8-N3^F1:[B=IFMT4Y0@Ob
I0@2U,87g[g?NW<=K/PCdRY=YRQ2+7@3FZ1WDb_4F4K)Q+Cb)T2J8VY]f653M(<-
C9^SGXXg#gT)N)aH4Q7d3SOCb?^OB)Q];bWH9>C/dbD?1LQP7N;+<]>O&Md>L.>1
dS_Y3AZLMTP\GFJDU6/GRK&CWV#,E>/df9dS+OBL3dE&NW:):S)T\@;FN6&KHL&2
MJ#U62OVZ\&eKJLb4a2#3>fY[1,aZ7FKJV]--R]GU_]-/&15FaOf57H<XNe\f/3F
^g)4-B[5O^g)1WJ9/C_0Jdg850IWWF7BPM=RCY<eT4^E#,WNY(MScBO+2aSG2@gZ
/WcLYU)@L5/5>IR9SJCQ0SSL_Q\NF:-CT@HXPY0a?>#KNFX9[EVI_[cAX_c_T,fV
I76BCV=J.0f@Q.HBfgd[31GMOOc7G8&Y[5OF-II@M519TALf2R+S>N)Tec^C8<bU
>5@J:P>Uc[F4OdP[,Oe?@L?@JgO=X2[E</-/J8UQH::O.-_[B](fM+2PV.0/Nb2-
W&#YDTTGCJ=,;3])<=IY<+.]68@8GWJfe36f)(O+OWLS=@PJH>[JHEd1>43Xb@_S
d)<4=0\,);N#WUZ7\f5Af,=VV>YC+e+JcA3e.Q,JV0gBMa@)C?9DNF8?.VVBT3:H
[O>W(DP>OWD[FP@cF-\(2S[_LM7,G83&b6VUTA5R@\^ede(FfeJ:Mf35YIZ>510f
_&]936AI(9JJN7>\7EcV1UE(X^515PTITHW<]fKYA;.._deKWJ39:GSdeXE2K:>F
T.(:(L7U1K-b1g:O[b;/=N^UPENMDaTQ@JY:;/&XMZ;ObE?CFRMBQ[C).RM@CJef
KSH4:8QCV&DG-a@2BdTB;#>4Z<<QX@MK=c2Jf:[FL6)A6;3>g7Y9CgG(IF.ZB1g2
5@cU,BL5eSQCJ@X5TfH[JPbZgeO4bCVG1a>K(3@XFeHL+WE035(1)D8R:&(0:>U:
PM3cBUf_a8T:Eg?@&&VYIIf<=db,e42DL0<JZ#c5OTA[b(f;1#S9KN^QJbQ9b0&@
)(_(6,Q;g)d,3++T:STS:Mf_^-V?Wc^@CXTCV[IXBN1@/WTJeT^AD>F?PFR_IDD?
S[6VF;B8f+;(DM2EX,<f(NINY^4.IQF3L2#:C39=QIP7G#<TR#CR?fJ#?79/RL-A
G-&+V@fD<7-;26]<Y);UdS[G?aU_9@c7PAPV?UX7f(?23cSA(J9Q2U=W<7RB67g^
B]W8+W&B-A@8.([Z;T@-+VM7[=A1^TJ:C;+9[.UVb@_fbcBXY8S&FCLPZZP^B7/I
@)Y^19Gf[3)gD7(3J_Ca(ZG<B03C70Z_A[HaA+][[(HH&cW&<;a&I6c.]AC-9A7M
eV@ZWcA;P,\KS3&VVBH0TD-Dg\OGT8CaUW4P5#88^&Y;.2AG9\G=7@GVLM6S[K<@
/9S1[D;C[<I>B^;+UARLZ/PH)KIed&GK(_H;+G->#QQK5G4:+,c73<.YM39NEDb3
Z5:+GbN.)=_,f&P+gd=IN:G3dE^FSU2Mg4+Y^0ZFe5-)fUK4fGPYFD,Y:A@^+3dO
a9Mg_L&Xfe/_=)JcT0M.G>fKCf#>CM/&g@X,d;FKZ9GZecNEN[GVAObCFa2gJK8G
+J/V>=-,0H)V>:Z=/(SY;c/+MD&XL&\49?@V_B=Z&I6)H5:?gRLOUGZBVe?7I7,4
,M>[H^.8HU4,[)eV_<C3bgKW#bgIR9PE;LC#H)[#B2)XUFVJ8)T7gO7c\-(M+\PJ
bOX:G&Y3JSW4^..c7#O6IEAW4QX2+b[/0c?GY/&@5:JAYJ5ONFUYU@ZUa0^5\&J7
fSFB=BDg=Td_U>,\891G;RP-(@gOb&)e7ME01UF/VV7K&?gC#KK2ZP>6^2A4S.6.
C@&6;d)@ZD34O#4eTM2)+Rb8Je\?DCX#([KAfZ9R19<6FF50SKDZ9.gV(GbVV3TU
-9<=^SODB?<Vc_?EPgd1,5R+W70R&>V7.7Ve/X.5X4CdcJPC3b0[(GW86OP@)@W,
+X9:UR5Jf<(EVXJ0;fGV(R[WI=Hf_@P38)H;8C>YO&--1cDR[3]8\WSd+E>c0.MT
V.2SZBLWEB?8GcINHf0^8EfaWK5f7Ab3MO;:@9,Z/_<=-fCJR_>:4J@ABV6De-BK
4425)>:1E=AMg#-^SN2Q^[@@V#C12a?MB,H))7RH6P@746&3(Ge>TB7B9EU2]&Cg
[V3)D#:\KA/[7DE?=\PTUEbLZ\0D@YPV2MQH,5XH#.I@Pd20B.[0#GKB<9]Q:?C6
8R5]aN4]6(X8\FK,0OW6[/7C6+N#K]O8?@3:-c-T5^UYbINOZ0JP4D&9^-:0PT9e
@@;S&3OIN2_a5/OJ+Ed5>\\;\EdDK3^_?4BPQ<;9Wg^2#T^c):SP-XI2R]KNLMa3
SPb+PbMJbWF[.D_92J35,J?)G2@M+@9Q9J0fHPF,+EREcV7.b<KS&J-I1C\G..<E
X=W6W2>?J8OaD4H?XZ3[OBKD:cV9FcB>8H\;]E52Wa2/eFC5c/D3/@SI1D_CC+K(
[cW#:.W>RMLOfF#5NMLV<+6KRVN@K09ZY1\8(RKI[K\7Z?2f>Vd\@K,Y3:IPDL)5
Sb#d8bCH<XWU=09:f561T_W@9@SM;)TFX?M)V#22&7-N);:BDISa1bNC<6=>H/Y0
&D#:(M(YT<8dB5T]8A&G]U\c:c_(2/-ZW-HWPZ&&4Q736CK:R\+B2M],&#c=;Ce,
P^[Q/PA(ITGQT,GdbL/K)A&fVCO1UYTSB_Tb/RR<CXF(#.c\LG=d2fFJ@@RNCXO(
3XJDS+F6K2IN#>1Pe>g[G.G1S1Te9;O^HOG8YIPSaZDbN(8Eb^If79E>VICY6;Ig
&UI9GBYT&B>NaX6Je@8,dJ:[B4/5[cMdfIf-,ddH0bOC9:##P<)990B.cSbY1,Jd
&cX-E]#/#XAJQHF<TR@:<;D-05@-OCR6VUC?Od([OC@S#cg,M2[FFcZ]CB(@=K\N
V<POcM1^CHb:HM;9T;3N;:KB#9/-&OB.eV5VH\eA:8R.,DQI=Q]W:cW:?+E5aR3E
.VRJGY-CV:Ja#7F)e<];b+/eb)NRbSGXKb\cVCdU#7>XG6F;NPQO-F659L,3XPN=
[)agW1=e9eXMETVe4MY7)XYScZPK@;+([S:W(@W]PR[S;.V:7X.YQcAe+PWZ^NG6
F0&eMI58\E.E-40#<_O?>Ub5V.aJ=9_HR<a@_8ZUI=K8TP[Qc^C,5U_\\6Ga#[H;
4+^>VG@/dT+QNGZ1WCL<[A\&bAQ61dPVKegETSM:#ddX1-.[8:?;1=Ygg7\bVMc8
OWMA56]5N.0fXf@61[>VO#JaF<Da=>HLeQcR[HQ?.9C5\N_^b6KG.=RK/Q^c2]g&
Q_.]O#?Be8g1fVcSf4Qd;f)gR8JS];[C3.)@d@V/(=B<O(AfL=]Q_Y;EV,FRd&4/
\IKd0,HZ-89Xb3[;HdOF1XX]#6RL:5M9XY+,-Eag#Y\4BfIYd[0>?(bN66R[gMB8
1AO0#IPT)56Mb1(-ANV5-a)SJ&gJfY&#KP\K3Vd#1Ued/O9IcEZL^O.ZPZG\c=)J
]2Id85G,R:^(W@,TK,<CFgU4DaC7#V\TFGMBAQZA&fCWaB@.?.V.I2);_?@9Y5O#
(N2aA[)0A[I/WeC,[3?A0Tg\?V@N2.VTUY&GX\U2f]]HJgU=_F7V2C>\POXJZ/DR
D@JLdN=>-VL,WJU&^^QJbS7GK;GLQSDM4BG:0M=@]P50,+Q8&;8Lgb?ZM,G\E&Q,
>S+8L=1L6gT66P&@HUBC4YD5b@d@Q6R;b=-V0JP1ELR)-=7+#_B,VGgeU;[_T1?D
b&4=-fJYdb)6T_adb(^<;f#/8;\aSD3_1DEBd4,\DC9_:)I#]1^(2FU(]6IU2fgU
US?U_08]:g0]M/885HD6N1?7bB2d]RF(ga82-43QH(R7J<R=]0?E-/Gd&d2661(1
^3:GT&eMZP=;AGZ^,/D[_Vg1agg\1R<a3<E?I?b_9+>R-1Sg67I+Z97fPK]H@cg1
D+XX3X,K/d@O8&VYf(TE<DaQMDJ3eA(fR6R-bHNCg7MMG]#e8)YTDbVcB5D6ZZJ[
IcBReg^,bTF/^F221Sa])CBX_3.;L0V;@=,HHINd\4]J,W?4d?OLAeNg#2(Tc:e]
b3Bc?ZBfdJQ4M8J#TE;NX--:ZaTf-e_<_5=U;fQ6Je+(>GD[<&a+Nc3NX@IS0W_3
N-FQR0CBUM[c5UMQCJbJ(eA<M)U9?d<deKVG)Q#72ESQQc]86.VU,OIHC;MXYg9B
g,N]L:T?T+WN><SAb/D-8SIO=,];DfbG3d,)/FV)f;,:P4+2^6V=.7XCSV5,.F1;
;fSgQBAJ]O1Q)FY2ND)]Wf&bf,U\RU3XRe/OgbO7_+22YQ)(=O8O\-a>8aNUME=M
NTb\aeGf:0f>PQ.ZIDCIPKK9.TTWI6Z[c:=8=HPY<I3\BQ;LS:K5J4K??Q3#?EKG
U+GA(cgWW:Id;F:=GM1PB+F->aK#,[F_.+NVQ^U>.VI/T04MM+SccV&ZIe6^bb(?
Y0+BC/.TVCfZdQf#db(:6/f:?M/WdYKO]TbZ-b<6MZ3dBKX<2FZN;&I)(2JEXYF:
Y&3?@I-^W-a^g[:fPC9JF^&#3Ta61;Dd#]0)+YN<<W;BQ:bGNb&Ob;]dAZ8[,8^B
[JLe:U>804cYK?_1U30=g=IG#I4?1-BT85FC:(FXB[AQMX+XTc>=^a_bWLP9)HOc
3-]MJBMVSX,b>Q^81SA]70F>KfY]a?T^2\aJG)L0d1eb2S,H?IHHEIWc&.G7F.^(
D8fV@=W+)_XEJ&X\AN80LW<+cAM;O.4:M)#NgF?N#6]/CK\f=WZ/R,(5]2Zc5TM6
d)/NZ@)U]SD36G?23T6LT]YM4N@Y.ZOJ#[][aJ/1-,)F#&YBc,4O]RM4(UTX#(b/
Ad>Y@1CH+GF5-Z[ABILMEgPad9:<B2(^>4c..GV0,[g3-ZJGSH2.bD]aX<<LQZ,L
\A0;JK2e)V.#-IVPCDCMUP@bfVTP5P7\;6FZBDb-)H6TXLJRL61<Lc=Vd7ASc(S.
\73,NE3^#(?@6O(d#EeTW65^]R4DN^7GD4gXH9[W/?bY#Ic3>B<S>A;#MY&\F/D0
H1119\8PA@E\U?J#dD@PTZ-QEM5ba_XMMI0?9#A@]S?4[8I:(LX/Mb7HIF2bZ=\L
]aB2A6OT21O&gY/^N51KM^e5YNd?&)_H;e#/?[2&\_4Y9]8(G&W<2]a9d<OdY4UG
b.X.+Z5M0e=ZYL/9IcK1J).efacf2TSE;8V9B[>JQV-.FBU;;J3TdA&DP2BX:aN3
,c2><S(-U3XI[83IS7Yb3[K.+)f]E1Q^;+@(12f1QB5SV14EZD567B/@5JUX>gY/
ISO<1KH)E9&W>Tc)P[U&56bDV;>LW-#?F+b^Q#/[gSO5&NP.??/OTB>]Q&7H_LMW
g9CZ:JJ8((SC(BD9GY)cO/.S/[A59PC8(93TLAcf@6C7eN9K;Y9NF6(eL.CH0J\&
(eS9WXJ7gHTWDYX>K(3\+I5(TGCCI2VU&1QQXL\QSENag()\)[L?H.VM):JgOZ;B
UFBO(7X?@Y:eYW=_e52:BTI;:dURP<;U(9fb>1=?1@++8U^N)B#2[OPWO,b@#WBX
K3)BHe-]<KWLMbCH9G=ba@afM,+=4PT@VZ6dWf8.cca[Z6N8ad3>HCLXa;/1F)&X
E)E,41VA;LJ0KR_IVK6M(C2D#5J9/0,/2+K==-?c=V&eL9,dT;,>-9P\55;AFaYP
OTE20#+U@G&M(U93c6dUQF:I::1LCFg)Q0fTdWS8[\<eS5]cLdL\Pb:#GZf0KDHd
T/LWP5&4C-f),;.2AWA6\Z)P8ZQGc89a28NL+O0B:d4]SJaT;(-J-[GZ@T[?KC75
+ScdKLb,e=2.XK,K#Te]B6Q@U4P_d-G_a)5O4W).^;=ca@P1_O3bADK=CJ42LSZJ
[8eBTRR_FHaR<Hg(Xgf,/UUPP+[4>J(3]FfVAfg+_->d=T^/Xf<L\Y\QRf7^^317
E?Q;P+/d&J&>Z7F4Z62VZ>KX4;gd>O>YZIH=/3F8ODR4S^>0bB?AQ^eFE@-/e#AM
)_41\<7e73g.K(;bIf.75@B<DcJ2bZfB/Pg5b(AC^<fTT[11OZNIa6NZWV)-O?/,
,^GPTf.O,&KM1UgeUd>@M1NPY]PM&0C^HD-++,^R3GE2[cBYd-86QZ?2>OA+HHbT
5S<G@E^1&#FKQE4&X?Y;72NRQB60,H7]\V-2daF:@H=619/=F6AS)U-;Y?8H(fbA
N)VHFKS[R:?7W^8-L+3gG:1(?_)5EZed\+:d)bNE]Nc?#.WXO6PU8D_1GOU?f7<d
<5X1MO_\@Kc_^1#QS#@/BMVb)[(.(=<7SV+,TF,@A>RRX/(AHL(Y)Z.f[efec>gE
(&aG#g@U87XE/UAG0,8NCeaFYbF/<09=KIaMA2#=N\dGZe1OE-0GO&??7YaO7]8&
K,J)ENK+=C4ER0d-@:<?[+g8,#7a7_TWO)g[5])^MGfKI=,SHIJRU.E^5>O+&=JY
STD[V:GZ[aN,?b)4<Zb+/(;NGbP//DD7W2TSO)/OUS9JB^[;GXA&1cNO><--@8-;
cWJEDZe/4<LH_3+Md^&JIJ),;7SM=&-+#1239AYE;/dCS<bXgJPbTCKT74U3A6<X
_UL6<RUBc20W5d;S6V7_=V/f.aPWOZXa7>7=YbCefS^]Ve21X@\8)K;70aDC\5Z/
<ZP#X<9+\.AC8\b2LUT=)GCC04\<OHQ>c\bEfVY)\Rg+C^140Z#T,eY0:UEd8:e]
CE^a83dH[4WAe/<ZS)a^BR9>-_PWPDH=(W^D=,A]8[D57RL_<KV-M,ZQVAgaT?8+
.?WeG^V18EMLZ71;PNK654\/M&dU?M2YWdN[=T=3DIF[\;HdcAf0214_E+)[0IR@
<WdH_GOgDc\_?=Y2MBGIeLDbT@=7I4eJ14[>3IR__8S^;6U4FUg</T&-bfGB:Rg/
LY_/[X5^?WLb:TWeLgEC8@O9\4,0UcaIGfN3.\YZQ2NY3MB/4C.(8;Q@-C.9P,dL
7\=J)c=E0LJ58VQd->YO5;;;/6ag@[VRadfA_Z6GGN-I.MV/a=+^5@8)IS61&#\8
X;VbOX;T4&9RE>-N(\(TZd1Y/4JHc.:JP?N43Ec-)1>Z?F>-<3I0J8>d.O1GCIe2
^ZaZL(5#>cH#__1U3#]-V-96>1eJUDI,L.e<PXU&0K52.P)L>B3XL,]8P.1bRd27
LPOPK\0L@9+LLR9@)HK19&WaB&EG85WM45</33,&TLIg;,(:cb,Gd:GW>Y&XbRF-
&>d,ETGX,Md&,1-eU\6^;#V\d8U(X5S=CCHUb0(BH=e/JL9a5I)49\@V;)Q23Ob0
&V(A\8edD[_e8>9(LXYOHPC,0<SJc\J8/>,@IS10PeS<ZM]\8^VP#O=F.KPU41FJ
gd\\0)#4RKE)cZ+5QSIGQ(QNeeGX<1Y>E:;#^TG;7cJM:0_OUY[ReP>ATQec1\.D
C;RGCN41GLI6HGLY0?PDUBVBK:^^?N^E7<=<?aO+UEOFAH4H3@AIO.O1J5PMM3Uc
RU19eM#5#]I.ZQMUPTA1>3eX+)B7#a7bNK)PN?fD0[07.WF,O.HTGfId6ZbVIN\\
4Z[?<Ib#@eA?V:UFD2g=UK3#aUOLL+8DT:b,0_L/@^UT&G.,S;)]WEa(&ZWA1ZR3
fHLgI4..FaES-JdbdC.Z3^DCH29MWfD8g6PL3bE9PAY69)BNKGg9@27]@(dEKAL[
P+<,FNV1,XZQ4_@fWZW@2?F7#M<Fc:#R_ce1Y4]B19QBEOdZS6K@fYI#B#\0\01[
Z9a&W_8QW[RBKL;);?,dTf1JE-Yaf+fN2E5,Z#H6KP3E<##Q8PBQ]e-eBA9&Qd)U
Gc[ZNHbLH@>41cTA;CZgQJa5BM65))Ed;[L><=@#=#G:X+3b/U17L(ZaDK^JIEfQ
bZd_LSQ1OPO693G(_<M=Kd,/e6/)[b=MD_^F;4R2^Q8UfIT7/TQ1O5@fG4g2KA:e
BR,6.]&O9I3N3Mg5-.B.6W08UJ79+/5LKOQL<I7?Lb^Ba>F/\^D8BGb_[7gNF)IM
+HTVI^8XD9g,B_H=7fAD7<6.9FV@J\_aM&9()V#\YcAVHT:KN;06:DE:.#TT7W#,
\WNB4ONEIOgHeR\0edAa7A[BH5Obe+/:26):+fRbF\\GMb&&LKBcSAIQZ&:g+@ge
dHW&)fUY<3]\0e5,;AJ&9]+?Bb&H@6TQ91RQD?XE\g&H9TR^0H:2C-1G1CF;GHQe
A>HXbHUg2[c4g8>HHG3D0;G7T&<9\:REWA#,J?3d+#QV_aaJGTJ=eY8(P1UC6P02
;1XHd.eU]Jb3g>4CB(D#Y0-F)<0Z5E3YCJ1I6dXWT9P:O=1c(gQ&FbdJbed.K^.L
a873cT/XVUE<)A[R_VI&I6#4eb&.9Q@O\^LP&eG&gJF/)W/NZa.7&H/[0#9Sc?\d
BW2g+?9)A]VSRFY_1CZ]RSLP5BVIK(0-N8_Db[RBTVE>NFeJ\VMR)3Xb^Q49P(2c
7RJTSF?T9PH<e<;U8^8ZSWH,P60QZY\@14^47+cJ>g8Ca:\Z^a-Ff#fe-MR&Q>&3
0<]N0LO?H<c9CY8UNC7[9OL>S9E8C6GeH.F6beT^U4ZSSFZ]fK=V^\]J\579:Q1c
LN(Yc.)abd2K4_Z73R[Q.gUY)18>dKS(Y6@CFJ8AL4V2C?D/Sd:<]NK8K5L5AL<f
S2P=FNf\N#&/5UW.8dcgFL4<[1@dY5K\DbO42->]\dcA1HWSX_)N7bU]&)Q.2,5B
)VJD-HFN4gRYHZQTScWT6(\6K=.8SODZ60a.(F\GNGd;D:24#8?M)dAQ&6URD7Ge
7;V;\A3)N?1V(_Rc8(b)W.65I_ZYdcU?g4_3aZ(a6\\c==cK;R<SPMLM4E_L2;Cg
bF(C#G@+Sb&,N8/EQ.9bHg>a)6M&>e7aVLQ>9d=)aII6:Y9Y>^.DM3A=9Ibf;T&=
#a+SNNO\:>b[/8g]gdF+VJLJ9A;]^??,VRETIO@<R1;[1H@[DOE9GcJOY(WH6EVI
E<E]+-E&C+UM4Z)?;)aTEM#9YDfPb/gaJgM>f4cU-CNcH=A\;C^/P56;dO#D[3NT
2QMMZGF<-]5SaWNS,eS16e&SRVV1+ZPDFfa4Z?G&P_-P,#Y>U\ILO,KB[O.A:BgC
B^7c+VLUKdW?P2-C6a_3#HbKBRD9@Q[dM]5GCP7SX9:-K7OP_2@DXacE92]?DG_3
NE<.[,]C;PZ7#52A5W8S]^aW@9SSJE,Cg;fQOf^6^eaD)0-e8XTV2ZR5Ye[W;2:f
ZCQYa[.ZP-\JeHDd=NZIT5@R&R3&L^]G75#+[UE6JIW_K?\N:#68VX9d:N_OgD\T
feID:3U9/^I;AL0F&Q/=C)Y\YGP,3Y7]W3H2JG+A1C\5g,gBfB.d_?_H2^_Gb?>F
B3G5Ic),5PD.HeeUI?1dPB9T#D&&M(+0=?H@?_]>aN5gfc[&CCYT>ZY_C4K4?MCL
(/<Q>[WHeTg2C:,I2G@<X(D=&gSJEM:LRE77=[HZ9cO6;(8,Y:E#_fg87DPJ=206
YcQP98V<6^2X8572B?H>/YF\gT-&.^+4>.3<9?JH(LFA__W,eG4&.ERPaC\QWJDb
SJFNA,S+1(SdR9/_UW]bYSNe9;a79Z]2=M:^;-1JCf]I1cD6QQc\S3W#;<a.f]R/
=^K,[:>8dc)e-?&RV,=g;PeA9c]MbG[/A3+4M<+OUT_^JK&Cc?O9[g2<SBT0Ua8/
e,3cTO,;3Ea986X_&0LO-X\K8#KVC1D1)O4ALb[:Q3M45ee#f&.6=_\R50F76OM-
&gKFg]N?#N>\.^Mb=fW=6_H;?+,-aL7>)^7/#;A4_GaT,ITYc6U@4]6/5]O+\&)c
\881bZ_/?BY+cCC^8\]IbdQH1eRd+#c74#M;_KZc7:H2g[(_3HWaTPWB>OZR^<BL
@a9DDFdG60USNb&J<&(d<3?</TRHN@gK+[V._<HFEU66f:O?AS.[013?[TA4^bN0
N+F=2V/d&?OZQg9]B]_7Aa;0+5+dd;9R<G\fGG^RO,-H]=AW^9]H6Hb_ZNY5_UIX
.2e)b^Tc1/,@#-&_0UZB.dT>O>6K.cINM6CGQcZH\12N2PTN]9/bQ[B)SDFMA1;I
KBIE_47-g6EYCHEKW&Ggb)-\HF6>a@:7.5J>WX&GT<c_PN0U_AZB,)Z8dFT?(7A4
5W>g&9gW5CGU/_3NESQdbHM@Sb4.a(^P3N]4AYN7CE>eWY)?B(5A0&PC22CL^<+c
T@3:S]]_.1X#=X6&7/86KU2S\S,<F7X5/=37KfQ?4A,K:.A6VJCYgT0N<:g+\L[>
gT<[QZPDR.)]QP4WMd1aP(c(8F4>dJ&R@\8DNSPbR?4_/I7EbRSEMNaNK8f[&Q^:
4M+5\=e#6LKTPE?_XC#6Ic@c?AUQPg8IO^I;;1Za-]SN?:[#XBD<Zc+?]9e\?S-g
[Kf/ZW/7M;Id/#QbX2T6O,gC1X54;[1UW]+\&&d0/CE_dZAHI33:a#K2a7G<GL(-
AO&X:[O&dTGE75GJ[>?AMM,b>2cA728VKHD9KLbR^^<+K9&DcS[e+N1Ze[/;RP=D
f>aD[(<b12ES@V[Z^<LARR[+T&ddRL6:F=4cOd3.NJT=;2D:(Z4b&97_[E;I=E+@
K04aT9L]&e.Hb[P;/QHZ0RTOMd#-_9D[U.]-de=^ZJJJf.:#^]QPQeFH?IG([(/P
W(O><;3=__2Na>EZM6P/<HJHFT3Ae#.X]AVd4\[5JNVZZJaMK[^T3_[+Ka;RF;bA
3KVWLZ+SQ0L=&=0])(,(G8U8CB\>f/&;aG3M(P0@2V/ZW,?UJ(G#97#U/A2CKVXV
(44\5M>Dce8Z/9?J?<AY;aUKF,OH]QT:W&6V@<ATP9;[#1B&R\@-^^_fHbHc/,Bg
\e?S3ab\ZGZ\9eDSg8B5];L^DZT\D,X:(GUG-AJ/be);2KNENbZQ08_D9FTFX3Q/
-F?4^=(.K?2M^,WTcg^?#==Qfa7M(#1T@7MUaN^dN@8d;M^=II^]^A7,:FN5VQaH
.Q\D4KZgL9-_Q(d#TNgBAPc-_4#99dV^7WT8_YQN]H3M6=27I66FDLXf\Y\@?DL-
4>MD3U[UIVHGNR-_XRHNQQ+6C;]H\L4@=B8<]80LeOPB9&TYf8Rg?fY0@(Y+:b(8
(F)W?Ee;N@^L4/Z8IBVG]ZO2RBZ_6:>F9Z(GVfUD]4M_\MLENfLR1(e>e+bG<dG8
R\X?Fa9cBZ2T@WP77)&T.bD[[PY]H2G0]H&@Hg^K#9.;_I/Lfc(#_\[J<FA7]?NY
W7FY9W=583?EP.N/[(Y2)@>M<8^c?Q0f&C&S<Q,V3Y27RW^b(R#QK1K8II6Z=;QB
a(VW:H.T+ZV5B0P(7\KeF.a6NQ7.b=]&+.c;FMd&NVQG5S3P-d2K(S/=d0^C,RM^
2Z.dI+JcbAH(Y/>0W,3C2K8cUE\[(42NeC]G;04TJDB>[a(T6=Y?Ad=JC>CWTe0P
NT>,[@A3#8@YD^=c8RMUM0>]@/4H(VXR#,/VY0T-6WTbD]3@gU,HARF]/;NGN&T]
(d=F_#4DTHdIJg:HUFL35RX;A+,IPf(cYAU.VFVJL]#]NXG1[./.W+YWc&3W#W73
6g\<,=0e;=Q)W_;W(PHcg2/Y&I1LAJcV9=E42^YN7I2R@WVO:XC(EOVDLBN2]eg/
SKXYg&e1LNd:R98.Rc>FPDeTJA6cF4LL(U&8&,N\L<KVXXKAV2P26?cAdZ^AfD(?
K,YR93N+?Y-W#?1C0a^(;T1-&5-+X;E1GLT00+d35M>B6<c?H,2Yc\c<@6aA-TFT
VaF)D:_-ES.<aJ<KK.5Y/)f1O[>)))#cOJE=PYP[EZNC41W?DK]dWHYGB.X+R?[,
ZgM?3/?)(&a]ONbUVIS<;_M2e01)Q6Z(((M:3R)P5&<I>^YP^6.M6b2_?FO3@_X6
X=:^gGX)=?8_;YUeY[OT1b64cAY_IJIQ<BQX)>]@TXT[MbN;RKPO^g50L+#a3TQ3
7LcW0X=ZWb3>8L7-.8N)WD^DZ7\^AXF-6-8e8+N8+S=R[X&AJ5C:U4LcZe2>BfHZ
9]8(.Wc5DF&WUDd9dYO1BKBP1QVHdg(A2,8@+X\&HVHf.YG0T>fQbH+DTVZHNO5g
^\?U+]1Z<GVDbN4:A&c&[]+Y\1+/f9cdKS<B.)ZKM2)=;N>,aA:,8SfA8=,?[)EX
Kc),</KHd1TFU\:HI\)QO#YU8IRa;9+N@3W&25E;,VQOCF:F7R1+R30#HKL=MJ#4
8O>8^=)I&PV?cI6+&B_N(Rc>fUOR:\YJ4cM;Y:.E?LN#Ta7BF2>FJ]Ne9F<EVc4V
COIPf)(BeTD@e:3&L:1ZHU\^Tc+N5VU6V^LQG#^6=.0ETNd2^MaGaU6?Qa833;Uf
\9ER2BU#XdF9<WUgOQ6G??TO_-f2H(cHd-O3._c)M+2B:8;E700MY6^T\Pcae[(:
T.b)<X+-5HN)NJ0UF&MAT=23W?>U4(HU;a([_-<[;KI(/X0Z/0L;[gW@#/b&N8MX
TOI\R&d]8P#_MN#7N)O?D4,P.^W2@_U^(=->Z7U740>IC(;d/?QI=H6]d6[7DE:R
feJ4a[/H_gCbSbaZ546@d)OE\&Z.?@6U6Q0@6GV^cBJ?(S<W+;N7_COe6JD^RdYf
8?:9FdM2^\6ObH,-@>LTC;?C5CI(@.TL5#M3BEe);2=,8YVF.L1=Q?\O(:IgXTCR
]67^f1>a+&HW\FG;Qf&Y/[0\P_gK9G7KN-93Cc00WMNK@4S7<P=LR:fBT&?V,1?g
Yd4XbfEWJL<N]9EA@/YPGgC/CFCWJ-IF+::I4\bJT_,E&Ze5-><LHG--3XP83NcO
K>R:?@P5+N7C,/027>-V^GZG0;P8DSGM=0=fFMH_W&Z6D&PODXGUfMQ<6]]]@9K]
HObEGB6@2\IZ=(Y,(.B7G,;B2dUYFRZc^>-M-JSG6Z^GK.a0?#R^948.WcB5aRX,
\YJ,b4#P4>bAP:Q5Q4IMMA+M50_X7Q8RQ-c?]fZX-d/-DM&HVbH+cKAa/V&@JISd
C.CQ]\;<J@B4V[4^g:]Z[9^)(?PPIafQeW_S8GaaZSYJA+]Z@S)(gTg@XS8a-P>#
8b9cJ6P.GbE8Y<.-;gd\FMG(P+Wd]dU^56,M/0_3\ZBG8S@64O7T[L9X.KJ54>H+
)cBe2WM]SP#[EV7,F(LY3]<1@F=6P)D4M?f+G.@:QddZMJ5=aH4-RM(=HaI&GF+5
XOMf63PV=;-a&J;GO?MY-cKg#\9X6+M7^S#L6SL)NH/6=f;S4^C(c_L8XZ&6B:0g
OPAJ2Q63H\U\LWTP/gN^gTbeM.3B[53E.FHF-73V=d^/8WK&5dS28LK_22,QKTQW
M&b-,a\=NKCUYI67HQT2L7_V9ZIZP2gDbH#@>_ES[+dT?0)+][&LN5DEZ6E4FO&=
,C;cDZ^<>dY/,Nc\daP;e1S/EZU2)8LP0(NO]Y=D/LZYN,ZT4;5Fa&f^6J(SM&\-
a1Y:=M)c2fPd)b8eH2&ZeN:4Y=?R51PWO5I-=0LGSb^V/4)J>OZNYB\JEf+]:>DK
Ed5eG=Y3C2;Z]6K2B]F)ba4R-##3]QF([eg3S0D)#7b+S;ac(g5N8TEg8,LXg[?J
\ZWU,SFTZ7[OHR-[T:G&S<fYPgBM^(B^dK96gC1I<bcQdAgRQJCT#SeL5BB0FW+)
c7X(RaY,ST0]K72b>3,<3Z.a[&RCL.K9]3V6SN?4,)[036e=f]dCg6.9F:_NfQg)
P:;X>YF[FccR&E]G[X/_)fEBFUZTZ1aOXR&S),OQg67_RVA7I9fE<,&Z/3I)]LSZ
,2#CX(a9509)03bP;IS=dH=XOZSB2A8F8L]RPA,0,]BY-:>F.+0bF-3d,(Rb=5+>
JR-U=T(-e&ZD>MZg6[V]FL7_a6,:(VWa_]11&3JVHFg?cV=L=6FRGX9^#cA6(K-U
N6TITV_8280ORS2LR8(C;c.Z7f(dUM:VQaEbQG5bgEEELeeIC2UQN^PA(_Y:V_:.
ffKOFLX;CE._N1XVM#S^3.S9Z,NFI7DM5(YXg.[GCS#b]JI:/_[:Q(9-1JB=-4WO
BI8+c_JYUJeVFZX-CWPN;S9BZI59cC<M@YC(CW.5RNUVV(aVA_X@FaFU.8MQW4::
gLB_<J3TP9><eU.)/.Mf,^>BbA_I2:OcFGDV..&QI__#./\dMX+)50-8)72?B1NP
-#Z[OSd2:.e17OW1>.4PPCUJA7O.H)I4V:EBKV1AFQce7P8]R7gM1UI<_O>Q;=;A
[^@[VZI>/FPKX;JRbdBS;-IGF5Y&1Q>5Oa6I&[gV,M,[DFFgaKE?;]@6=CUdI+8T
+Og07\7VWS,F,Z>:OTKHPeEY(8:c5SXb>7(3#Q?^I2bRb^6NT1:CLb\@G>?#VO]G
SdNVNN/^WD1cf:4AQN&e0+BXLX-4V(Ha61OC+4IITC_dbU.>(a+B?LG1b3aT.>S3
@O:5F(DF[097<A.HgT=\8.;4?1DHA#(?F:.)/-QS(,F5+3+]#J@2g)g00,)AC16J
L:TXUFDD4BAM(\PBEQ@0fFg)@:O.JOL[eX)(gPO=A.-JG/HFMHZ:_1Hf9?V_DL#e
Lcb2INQ//=.O?A]AVCgCSX33EXQg9CEWWF&RXLdOEO.3<-M7^J[T#XXU6;I/5EI0
&ccC3C\K^QC4<@]fM^aKO_M_&&7L:R>K1,,g6/GJMU]WUe#AF&0)GG#3N^6NBDD6
gX47E/LeJbU1AET6;]JQZ[Hg:<6QK2TZC^V?KZ5f83O:(4WMC5#Lc]OM(-12H;4/
X<>]62=R3Nf/DD2)DcEe6R?@>W?UN(..Ia)<4C^SO/IEc>Pce?^.O)CIf4<9^E2Z
GM=7U?\;HeGI;\DN+^Z#1\eY9Ua.;a=IdHRa_OB/Q\9Addb)WOP\RU#19.)Z+MWL
X]+^A8IJ^+\,YN7[EAJDNN4WF5aVP<&93;J,.NH?g#:JG]JG#[\&<aZV+KRKAA-J
[^A^-gEAGLfe2+H77+/;EB=7J)7/W/21Y9M4YLIc?^>GFU/gA[5/#fZ.dVKKR1H8
Q58_6bZfD(2d\YKOROQU+N]XY9SC)?E7FKbeLTc](LO09IHI1e23D]OZ6T&@?W(>
PR_e88A]_cWD&4[)/MDGIA\WX24V<)/MONU-&228UOMY#L;/Z2S;>\1WY5T>HcLC
B#C^CE3GcG@6QQ02S]\ZLYJHX-/X^T:Uf.Bg-99>EQK)(M6aU_,O-GGK;<-#C)dR
V-\J,PT(Pdc3QXeHEI=aH0Y>R<NZG1;?Y4,=3+7Zg&S>a+BcQL<]F64E@eNcP-Z(
;<Da[aLHaY+CL0Y,?B,DKFeacM_]<&_S>7IgT3.SOXB;OM7d0#U6/.9LfaF+9b(b
=@H2,ARK;TaeO3f;+f:X=@]UJ.Z_0g9KGdX6/:@:f42Z^+O)/21C5CNX.SHfB1IJ
FM#0@V]3YbgR@L-2Y1WGS5NJV(a-X>L9]Tc(S@\\baQGY@/.PY-@/(<MOHDJYa?N
L5L^:d@,,I8\;f3@=RORO^B8=<<[Ta(N(IS:(#XBV15QXPZ(;TO21,38FM&c#/J6
YCT0UW1bT6O]#7Y@cT.PFKH/&&:5H,RCf](\Q\>?PV^XAOX]7\5Df(]1&KH,AIEG
<OAERMS,0?5OR:QU?3;.<6OREZ_])0X<+c;b,,S;/\+YSSc4;fT&C\NC.g5)&^,Z
/_J&_c30>bZIJA&I+3aRO_D(#,WKOc#[AV9Y2\b3RWP-4IPJ4;@THE?Q?(F,4I&K
G,E6fNdV8Y#V]-C-T>YA6;7#)QcaNeKd8++WK90cc_CBK6F]2^#T_6L,^,VT8Z.g
3GCc<)-JUPOcNNKH1#VDVMeDcDX^+PWdeV^ggG/.;@EA^L]SQe&S)G3.-6\c/.]0
gAY]@C_:9YR4=RA03>IfD5eSf405GP\.QGQS.YA&:YX2:d7aeg-Z0:4b^A[Rbc+U
\8=@>.EII8OPb&6\C>QS7IH8)JG#TK:HLO9#M29);7PYE@^[#:8dP,4EdST-,Y+U
48cMM=QYKB\ZGdeIYW-_#L^OZFAQdV_N+)?JRY.LQ&CW87&_4Z0<N=d2QXD#./&+
[+0Fa@gL-;A6e@)#DN,_)56b@O2)^E7dgR/RC_4(aWL:g]^8dB^83df3U\eBDM]^
<fT\V=]aZ<C/bEP@E@QYUCPfPAbN5P,bgK&T^c^4)G+cQ+Abed)28,;5LFD(5Q::
:I=,I#>@Q+)g2E_F_9K0YYc5Qe-(7LC3U9G9MDaBP3MD_]EX@92d4a7^Q&0O;a2Q
PU8+4^,,(WXfB&>7>,O>J^F0M7\Y/XI+>O-XE)9N,V\WT\]C2GHM9HC>I,dGTHgJ
[T<<J@GHZ3I7<<&/GGL7SD_bI4.>,NO5PaX+G(?WGP1LD8KHJ06V(FYPL3:IMORH
<_H=^GXV+JPG=YYOP9;L0Q).RXWI<,A4dD:BJC[KNL0Q57RC79:RGTTL8F/__7IE
KEQ[Lc2^61^FO[:WBe:;]WQXCZd[HFZ#5e-eP+G]G[VRFg:FUU6,R^cGVb8N[E/^
Z3H4\?8HS.f&G5M.-f?Ic>D--)G3TYc21/Rg8<OGS@]=^;JWSRO\>I4;)YCa(X;1
bHaLSaZ-.?P?FV1=[[>fAOW01PMMIDOMM)G[a8?aO_Xe+W=-8cOMaBX&T:aRRPY9
EH6IE9F&]16:8GC-X-8)XC:/++Z4X\W(#dW5&#baLb2@<<bLegf>7Db#dH>eNQ-V
V=9M.RRbR-YF1^H5\P6c@KB--Y/3(3.IA=LV]Q1Z,/,GO(Ae1IWc]N<Bb)VKg(Df
NM,;_S?3/&).dYPASd3MPFFOA>S0&\]9,HLMNPc>[.RO?c@T4+<3K2O;g-AS[(?M
7SQA];EEcAf4CF,Y15c+W>GdMedD222I&DQ-9UTK3aCIfB4\R>.2H;(7LRT2(>[(
DD0_4VM6K62G4+)[#D_OUTK<OA,33?S\9M[Mb,9AaNJR.)fQPM_I)8bJL-DfBg]B
dDg_B@EXHedU6M18@JV0DAYb]\22LGEfMLZYR+>OU9@8A(WR:\,5ad1IQN=HPg&\
X)dP>@e42-0KF[dZ5&QBG\7PD#?FJbTC&25;3<f+6@9A&\ZF=>[8</ObL\(eU\C&
,4P1dWOV:\9AK8XTWG(7+12f;YC5(=9)V<:&CJg6#Q;<BTgFcZY^,5;N?;]14(dP
PV6WBdGc:bP>]0MPB18=?-XN</.<SeI+E9BHDE6--J8(\VE_16-PbO@gUHag((PD
.Q5W5Z1K5He#W06^5=a:62/JJf],2M8\R<Gg=Xf?/.X6=eJZD.+9(d&-5bgf]f87
+K+T=;@7+)VM.OAZ(MXgCR-04&T+^XfMfQNL/S;]B?eUb</CbRCFg&0U.IKF)9-J
[8@#MR42Lae@F_U..NS>3FK3Y7WV^=_ZC7T,.@+g-Q>X>M_VKf:T@]f4:_/?gFJ4
e6O[Gg?#/\eY/5TU8_bU>33/^E1:fZOC-WDE_:02(69.@NgLDM2LA@3,LbH&T38=
5^bF4fAUG1P\VVS2)?GMS4[\BYO1&K)(<T=:Hb0#\#^8;#5C\H8d[7>Ke3GVUEaD
BO97c:N0AK0W0]39IMHO8)VFJY#M3CaO3]A->&S<QQb],NAe)dc^Ga3]JI\#3a2B
=NI?S#<DCT^.HU)+6&g<ORU7U)W)W?]83\C<)W/gTF++)P1.<Ea&,IY)R+\(.AGF
C^M-TF5]O&3W^e)\(F7U_]I1F?,I[b1>J?QA;8P.QfH6dW0,WG-@\&^4R6_5gc8^
=aY1cX-Ze<=b1UZRT:AU50X3ZNNN<AP.MP;S)2Ca+=P_]_@:W7@R@AZHAd6U/YG?
gZZ\I/]&0>3I6\BY@G2VNaA]e+N082O^Gd>,ER^DJ/1/1Z=T-B607&EI<L@2_g)&
L0WQI?(-cO8I39c0HBgdUMW6^Sb-eA-dG5\:C<6eES[1/5BJ;X^(3>78(,K09A(;
7fVdEO83?8cN1dMeOE@X:=aE#c#RU-@)5U5I5IUC,V9S79<J&LS)]+YQ.XV_CW7U
X69?7(NaIM/K?<DE\AQE(52W1>a0:M&fbCTEN(5..UZ(c3[G-\#F<<:U3WOD=VNT
Ogd4@P=f+639I;(SU>5Y^C-LF4AMF:3O9VID+bC>D#L@:b3B7LC[f_68LC(FYXN9
WfP.N81&.)<?GNJbCXaa/.W/#>+6dE1QTAb:GdJ)0_Q5MS23TJ5=a9#)/abCU:+Q
Jf6AXg.AG>?c3NN^QeEgcB,16ZWA;/NMbHDE3=3Q0WR^WCH&c^#R8_&GMA&Na4ZD
X.5.+_QUHf3^G30@QU@8/g[\_3+gKX8FU1PV1D#6A=@C1gRV8(/b65R01c;+/g,C
,aH@=[L_A9/5A#bN#R[GbZ&2D@WJAg^JEP(5:K7=X<FbK4M+9>RI&KVYMO6-_XbR
R^CS^^=-Y-R.JJX=\&b3?D\[2[3E&Rc^=UZIM:37B+5+C?_Y.KdA1XULCI2f&.<_
Ze,J6EQc4/E#;>XVVXYHWd+_.30eME/CXg+1fBgP&^N3_UG9_<(3Uf/57N^,BO#?
+:56R_U<e?3J=774b^4Q7Y[HZ.cHH@R]\X;#W2\WYa9-HMad]UHe0bH^<].&JAQ3
Y1(BU7V\0F81Vf&eX[@&9C+f^[4S/Rbd9f_T9T00@C\##S?e^Z.(c^]DW#Gb.C=W
^]13<9YQ?ZPD;g3g:;=]fYF?-_/UYJIS:WE(-I;K+_[USC0T)EQ(dd(X/W=SNK/2
#\fYX&A@5-#dQ;EA5X-=HZB2AFI]gc.>_E>(FV4T2XHAW&N4+8gSP6;9R-FZ2<SA
@dgLZ[EeN@8V:9#L8,-KTfTLR/^R<D(W(Sg=bWCP7HPC7&=g_Cg+PdL7PY.U,I7K
/EX:O<,E,.a.B:1B+07f7T[ZeCSae7_CZPTZ5MG8HD1b0Wd(&#J_Lg#c0J@=6SK9
>IAU-aVLJS3VPSbU>95O=fI;X[c[/1>G?FH)5KP&,]OW4,4QOJO\IPQ2Y(/g_cc8
GLZ-U1A]>>c4_O?HXHJA9dM1P4E;3?(R2?N.a:,(=eB485c_KObg3I7<3Qe\+\dK
2gIM.RGV0b3]+1]KHHVQALC0ED-c0W\GG)@LB]=b-DICfY:4>GRE#F53Jc:KHK:I
^?N\I(bP9QcdT#;KfT2SW?,VaH2RZZ]/3+RR27FSOB^OJGVU?_T6bD2de,7GX##P
A&5;G3A15]WWdE(E#8bB2J3;::;&0[74Ce?U71.YKBa/_@=\:.YLg83[?]e1W#91
^SV7;J9ceVB,-+T>W;_#Ff&J[VT.@&1.HVGO)VeK?,5HH.#3B5O9W,CdeWFCIT:3
;9ZcD0E@2S,N0PC64XDUg)JVJRVHaDVMeVO)BKeG+Y6gYZ5RFXDdgZBE0R32/c)>
6c+>H+)W_KIJ3J+e^#.YcWU>.U)+PPfC+2L?SBAGb#NaY#\K7M3DAOV-?]b>T+\e
,g6WBS?gG\7+A;.H=H\]S0acSEAXgOQ.6G?LNWDEBC,CIff62_#0cCCGS-K9S.bJ
gXDXaR0@#a+OV4X+PDe?D^#c&N?:KB3OG[XcDP/fS?W2O6&I_fN&fd6e)Me^gT?9
J?5)O6R@T5V^8[LL:^UN=C+HK)8=C5=cL(HbK#Hb6@(N7(5D)&cc-bfGXXTa4a36
+,K759J.<K@,-B3HXg7?C<G98f?;:V7H11a?8/4Ya+cK2^:37=B/]b)=LNB?Z5:G
-L?&D4GEQ>P#(4<1>5;WQ^BUELIGe>dBJPW38@I2O2cC[IM83_NQGC+8_\W3/87C
A2TWa#@:3PL1C+NH&S:Nf5E[+N,Y0A@QQ+I@Z]Z2<D3A-+JPD47]_bE4O;=FV+W;
3SOd\A^A\0>G&^DM.D6Vb9A1d>EfK-O5g)=M/4S?CfF[IK_=JP8RF@KCPE+IDSEe
7V=E:,D>EX3-]H2X+(#0?,-]-N(9ec5GbB1cKbDeY?@N7O./F4:P7S6SF?0TdX&a
a@Z/I[N6SWCD[)BS_6]eA)G81GA4G(=ZM8:YS(ea.E=_\fB,)eY40-WATK@7:\Xd
:IBB@&7643\,->-(^XODGOTcL[=T\P&2P)DN<]8a<&J=_-Uf-b58@2+^4@7b+>C/
.P(\ROI/]1cKN\@g^@,NY;fa^68\F(QD<_ICWXSc0;Y9@;ENRdO7;c?g5/(2>c2X
O]+K2/S,Jg[-YH<(AgJCQ+0&DHU5&V/AfbeEMX&Hab;G?;2C.//T\+<K8>>#+ZCN
(a##P_PX-;D)7P=[@7gbFJZOFBg^^/&e:g<_[2aVWO]O-\KQMMO00PN\Q)V1T[)G
B^TZ_LZ>O9XSNNE\Q1Y?]Q_43CLSO[&1&]1fOG_2#FKdN/PEO)HZ@OTCBG3PJ&d2
E=]A(<VTcX5CU-=:d:B<#;<4S-@80C\G=,(];H-Q\Q6CD=P6UfX0Yb3e/#:^Q0[:
OQ3W2[&:d,BTZFAKLMYE3b>g]:#^,4CUJ^6@f1263FYS2-;.G3:;8(VKZ\8@),I\
;&QDK749>8^^_;Q(bA&B\R)H^XffgJ=?J0;M&@ddY)7gHAd.U^FUdFIK4[:2df1Z
-]CaF8=+P=D3#]d?URMd&DDbWRTbT+TDJ(J.TV:JET(9gFN-58a-K,\VD>+dKQB[
MVEHR.SYOK-P]B55?AVBW[T/>X8ZJR9=9?EZ5d<CH2#Z[37@Md>5O9UR3<C_J,J7
F08fdIJ1eYEL/R0?[#UE=X&FQ;Z>Q^-\VP\]?;]<#FRX&].7-<6TfL?A9eb0#Ce\
#U=/#gOSJ+H+A/7^[UK#c48E2OP&VeO[&&8^28Tg3]gaO,HeJ1?a\8+PQC/J>6+M
I,Zd0_NWN3CTBAR,_ENc2@0&UdI)Y5#NUaF)&PACZ),dF_:E.\Dc6,W[[D2f72,I
2d^FXgP7UW8E>(1EN=6\&bgI^X3=?cP1&LM,/8XM8&[ETW&McL\6I7Y/#,A7-_.6
A5/b_fX,&E<,4:7\#JER?(CA<@Q7SFWV?VOI/)4QbTI-5<N\5)NV+K_+\Z89c(>8
RRUJCW)W0.;0\=O<d^7OT]-=3:5b?J6UgK4G&\+eVGEM58&+<;Rg;>C9&=GDVGY_
0<Y0D&#B9X36,K-9\FZBVBIU/(LR:Iad+DMGd-ACSU#MSKAAH-,CC/U@IZbYJ=[C
8e)gHTIbETc-eF]e+T[5Z7QRA1R61@XaST2<]gHDD(LOGX;HHAT@.2gd3cTf^U92
Z^IF8X(89(>8<gI0Mbfg,M(N9EaYJ?TYFF6Tg(Y.3Y++J>R\#(AILSWbd:KVeJ[A
decCQ4GNN[Yag&@Y@X#fY,_Ta;VFF#=XQd&AC:Fg<85RgQ6\b9I(@a.O)S@Y(,Q]
=RUM4<&+S\7I.b)H4I<)C3L,1U[7S-8aW9.@ga0AN6<FT)Z4)(#-:5EEHHd<RSH]
WD<4Q_XST^0e\_\AR\C9[GO#,bJ#K)DU^)0Db:1gRVf\LDbW1=FNZ<Z3dd8[L/-,
0H,0LDd_?PTaU,YcV&:c&40F&UgPP=6+\<)DKYe(J2ZGPR44)_R;ee+.\R5N9T^N
=-gPI#eT/BIZ:O1eB@K=J>>US9;(&G5XN3Y3CF46Qd7HQCgS&/(CQ^e^CdfP<5DE
&<A.\FObP2T0YN6L8<SWG?^ER6aS^-H7PE>([NVW)H2D69/J-A?#+JNR_8>^EdBa
UbP#JG:X/S&.fF_&E(^JZ;gHI75TMA]R/F.[;_1K-aR0[geRJL2e6g[=EU0VS3W\
S^G5F.=RWDDP7G6QeT6+,g3AE:b3\Q<9&TT\G#U84ZH8P)cTVT-bU/H3_1]2gPT+
9g)Td/_0H1>a>3R1?6fVg+45b<@F/D3S>:>/S>A5aN+42(FU@0#=KWORfG6<B,=;
B[R&T4\4<1+888,b;UT5^MEFEQ_Ng4#g)ZON_F_SgE&)M996T>N&(D9>b4]4@Q_)
-R&8E_BJRc5;,T)=?B]JZ:\1W0f,gVa^HbC4]U1C#[\;dQJ5P.Z09UcES9f3&8Y/
5Bd(F_0:S<3O#@QNfbH(:cR)H_EbfJP0-DS#PLdFbRX;RL@#?.gFXKIg=U.IVNcK
J2bUCB4?VM#PES929Pc764YO&@@\S=UQ)#e3PHJaPaH(ODLEg14(#2?eEW5WYc#f
V&#G:V.<6ABgL^0\..Y50eD8gBSZ>AGc?HG.4AT2IZIZWe&7g43.B:&KTF[4Q>=B
3WP607AaQB:P9-fCP@PLAS]NTZgG08.06RHQ4GeCeV8>-\QD[J:4G=1^&d-T7cgS
)37&c::cICOfG018dPYb++E&#YG.7@>6Yb0[Kg)9::e][Xe\8?770:V]=f(D?@\7
&Cf+0,/Z?WG1CK]]GWUcW=E92/c2Rb,2e9K]D]CEITU?N@TOdBU_<=NNGGP;4KD3
[bXA3E^=4L.(I_5P7_RX2RMdO&F[aCRYG+aD:,\&M.Hb(W.P6K1K7-AV]NORBB7Q
@bGFc8P-E(+-65O/Q[5Re:)>13LFXV0a&+;/DAA:508e4^#6:+AfD4[VTK<4J)7V
g6P^I4H?L,;N;(HJ[ZU\Hb,W,@TLe^@9J,)Z;=21]3He7APALa/?=7c#cHb@6d68
.P@A&aP(CYKX>c[38dFbK4?B.V<2>[4B,ZY),\@0RN_G?O.;FZKU-ISdYHL-JEP.
2@&PSd/B2.5g6>.T8X+,5N#^^b7)NbRW;V\IIP)U+8<3T6>+-@[W[VO9.CA+a7_L
4e2D6)5a^Ma;8S117TU3H[@?3@=c8[?JC/:BBEQ[+2:^a.e)LC0EQfH_YQ?UNGW]
H<(M4)?b#.FHEI2Y^:f]<3S_&bdOU-=DUaTGHQ4LB@bPbMO?IdA[31P(I&X]SL^_
I&KO3a0X&bO.EIR,HCO@-eOCLeH8-_NS[&B;>J#+5I:=#17:]Ge<5CGH]H[&6E41
QHIM<4X=Ffa-SAfYVP4_FC)/V2-fR&4:ePDPSX&5F19Zf\2:XWHAO=:g,OF4RF5]
IS\e_K6()CUe(3N-GN[@_#a4\e7e[7;.9NGcA>D.aHWUGMI^(V>JW=bA7VE1_4I_
UdTQRJ(DE0_]L1[;..FW[]f-G<AbUDVF,_,UX4B\=7&PLIO[.NM9[fB4K>.JB_+8
;4FC8ZV9a352/,OU\EI58]/8WLP7:G3(><L.T4Z#a8CE5D,?T8BVdEG30(PZ4?=+
^,>8FOAET;.^\c7Q-6=5W,N:=;-X45@aNUKSXVFQE1>)+3(H-.F2H2XJ7C<KC&ZG
QNYD6C<I7HOX7/JedJdI,XE6BB0OeQ6UVM\)UHKfg3;<9[2;,6SR.R:1@#TGR4W[
?554-KEVg)[19-PgBU-T:PT6A@QK.VJeBd3PI=(YN6NSR34FZe]J)0LPKg-;,L;0
]e&1b_,EB7bECLdC6^1QJ6<Tg12/P?W=^5cSPK9X;XKb7<H=-527>&,<).@QS5N_
_A9fXd.-C8/=+Fg,1FRZB#8,<5X)@PCG#34AJ-,Z5B=Y#e;cf]7&-G4Y(@<U8cfU
c8_FK5K8?-C97?+?]U,N;>@Y<eb@5]X(1T<6B-B7;6Tg9GAI^CMQYO=YZ@HU[JB:
5a+O,+@+QU<,c-Tf#2dVYT2LJRJCN[D=<>S^cL#J-6b>U+RXV-Z?Q0SU3-eEM/2I
SgXa1&3Z[\U#Q9#UUQ;9<,Ud;2gNMWgcJW,VZa]AFQdP7_\N^Ge@:)D()[WDEE&F
EbOL-A]8Ve/1Q+[SH25ZY;\+A@fA22A)DRZC7(,Td]^Y9J+4Fb/\;e7FHM&SD8LU
N^fd2/HcN,_&+7?:)G\BBC87c@K,9\S^AIME.I#V#VKF99T04FYeX3XE\0&Q&?&X
;Q/=ReYA<T-ICf4681J?R:24<.e6/GRI&7#J&5NFNK=1=5:8+cVA0EA;H#=VN1TJ
E\_7LdeEa2;J:MZK;0aF7C;-?+Mf?c8Xg=NeaQ@NSH?Nd0[3P+VC3_IAC&PcHLW:
7YO;BF-6cV\ZJS7:Ce&,9L-?,0GY6GY+?9T_Iea5NTX1K/;4_eg-#-H4Ibd;VbMU
NY<2=C_c,IbO1=eO=W^KNZ]H?(XOb87ff10dJe>>3,a[5W\]JO<W&dL-71X@L1ZG
fG]CB0T\&SOI3;7T+1S2MgI/ggJ+GISD67b=(bL]C>A5U:dZ[L(.cPc?A00CYB2K
5-A5.F2K(K:H.Z@BP6A:c1:ag9O<d78UM<^OIH]F^SN]Z2RJW)+dSH(T5E3KBQRQ
L,L\XJ@J-b0N[:?JT\/)Vf4HMe7fDE//1LWZ.]0>()FX8UN/ZS>S^2KP8PV:d.^g
-YI/))gC[JDJ6]T_N:OVJ[7F.ONHaQ0-=,1+(#MIMNWb;9[QE<8V-D)+Sd6WE=Z&
1O#N/E]0fY4NIKMWY=dCd9Gc[K+@2Rc4)PA=)YbAVKEZ3/c/W9F1;F3F>L7;cPPb
aA[K)A/^eB+1HI^_)HQ.XRIN^?]]fbSdCBGR(g=b[#H\G6-^Zg6V+g.38QY\@@:c
ZD(geX12f/2]N@DZ8[9;=VJBX.>LDF)X2RAY:0dV\7.fF2^&=@I.??cbAMXg<GZ@
YeFF+g5)_.(^A.3D6Z3L0]H^C0WMEQ&aY8L/)4:,N/=I/f,IDY<fKBL7=(=4>/S/
.Od)]86I;C1a\NK#T+a/Qc#-Yb2+)O+=NTL1WbeIgIc:fX_W0R7B3Q?6.(cP?1GZ
6WI0-GO^+TdW:4PPR&?=?3MT&S(M)B,+Y):gH:ed]27YLbfEK)7>C+6K9KS(9[SS
QS\TI@VW(3V^Eg+8W8edD2H7YM<=f7=N>T/c;a02+L<OB]9TTGF_Q]6I4ZO^M.]T
F#<27EB_[UG/B/g]b)RUA3T]2^O6A7,_\ec=#G@Zc9X[)IVD>2J_@8CH\W^]7(+H
UJGGOJ&-C0Y;&45NKPZ88((6OHRc(U@IecQ9^Ra)5FK1Af9B-^B7TadYPRg^AEFe
KQg3GPE6NfJ_E:cdRO+(OZM)V.ZM#64X=/3:?1ZH@CKacZ@@HXE,0AT94UB49\>f
<bYbcS-GN=;cW^=OUVUZ6SB9+LHU=9_B&?GV.0Tc\6S[)2c1I6bLdQ&<e3.^@aPA
.aJ.]IDPdE4;;+;BNeD+[0a:@OL1-BM0E[?[9XIZ..=F>Ie8/]:^/?gHE9S<6CeF
P:HYe/T>LWXR<]Y\T]H;5U(^bY0O+#6XNP5[<=MXE=[(4c0DK]9V.\UU2E]YMb[C
><6>\K9255E#OWa4CB-edgJ132[C\.XaQ6?<L#;)Q_KU12X<U/09-N8aPf3]34X3
7C<Af2W]PQ=N+CB-S]d]:[JgK#T.U[88;?56?WGP=WN9HPH,9>J:@CE9,^e&ggRW
K&L3H@G?gME#CSYJMI?^cPNY7T0b(<>H?^Qc5FXUb,175K?F+ZZ6H,1(RgMd,):4
Bf>=HY3?W)&Hf1R:Z2P,^[^-Gb7P2E:21NcS/-BEJ=aA+efN.c?T.0+CJ#CV)a5U
?JAUK]Cg(LBd2#ED61+Ub&ZR;U+ZPD3S(/#D,4,JN521:J,a;9=T=SEZQ#VZeGB[
)VKg(Wc=Z(<,+W(g7<af.@dZG/6-A&=9Sc,CUP:e-]Q1KcQ3HJ_(4L-V<^cH&QRR
>/,0\HCG@83B#HKZPQ6/U.5gP68BM+gT#9G,e).Zb\5aeMb#Z5\aT/AeAHX-)b:E
gJ^S:S8)d@&^J@#(]V5&@=g7a@U\HfR[:8C2YC;7c+4AR^OJ#RO]]K[.>0W\a@9f
Q)VfcD2NLa/^dJCgS--4d5LaI3LeKDH4R,<-.QL3,b2FK\f<A^+,G<9d><,d(;[[
/HL#3,7f.)NE/EB>NC\FL0<De2)K@Kf)GAe-S_,Z.g-T6T/55UK)BKSa(T[[Wc5Q
^SMNW1CO:RFbfBP1PZW]3LM#1g4ZXV)bIX_92V7)g>)1)E&1S\9=X4IdK/SZdCd:
:EJ&UM&4fO/=+XYVYX+H-aOcN]=4Z+<=?3-1eeW7/;WM6F1ISEQNJ/X]66AHGg3X
cW1/3d;<L4A;@gXU6eD#[29M.91#H_gFTP@fXJe:0.(XI/7;V)&VBc.afE>PTJd:
<R<2cMVB@PV@aNLHL2@A(L9c4LgOfS;J@#NTL7_.]SAFJ\^5RMB=cg7>3[GV]=?R
X8@Z@W6dG+bEd-QMegC@c?\>/FY-@K3RN/Xb0.Z8#B(4\CO&)ERbJ4DSGc^,Y)S5
L5X>b#:P54JP)]ZKW0Rb6WIWb^K]E&[+EQ25Qa_)?&UZ-OLUUVe]]Hg>M=4O^.IY
/R/B(K0e=IX;5G>T];0;edQ(NF>gN,4cX9^c>:DO;G=A,JTb;K?E+K;7/eg0R/f)
[?@([]B@(RaZ2eXLdPg)\Sa-(ACMb2_J#P(fW6</EFUN=Y)F,SWVM+TTN(I1bf]4
,/L1g+GJg+]-5a@YPMcE(2JKYcEdQaV>NP=OB-9W/Oe1E?7XYX/&^[,Z63Ecc^E9
gY3QQ]5>@IBX0.HRH\NI?SE_UXg.;I#>GbLJWeJ);=0IK,LK^[=MFA-W\NLe8\&@
]1DNTf,]@^YbDYT_AO03[.UaK0cSPS+_Q@<CTRgOVf(:FIHKY;?WTAb).LWBFEO^
4Z-)3BS4=V7L,g=CA,WMAQe3HdLK1FY@<2KSKf]494=N2Y_TH>6dU)b9]UAF=.N^
4ZUTG=,3YI_4Ma_X:CTR+;c<>FTd&<PJe[>>QIJg4_c?@3EDQc.a8AP/PZ2F7D9O
(0>ccCC<:OV/eJ^O(_5[Z])0RXURgEE/&Z11g2M1HJ;8J^?>:cJ7SIT73[a(-U9.
gMFT0STMS/#Dg?U]DUK:dTb+#ST-T4Rf#]P#G8&8Zb2&LPeef779_O,1LG_X3KMJ
K9AT2)]Q0]_F4BaD6=<7]?8?cS&3?+7/Z8W]NdNXNEfg1#Q&TKgc:(g;N,P3O;7R
6<C99M-Y&K1.82:cP-cG<J.AfT\3&1I&T<6&2[cSKeM3P+E2e6GFdXZW,g/TL=&c
d^eefd[SNQ0#7&0Ed#38?@(HM3B5#RQ\g0DW0E8[U.,GNN+<0\L_?+2\.6dH+g37
+?fU9c1A(M&PbSVN4UN5McgKEI3BSSOCLdC_O1_+0]RRC/.f(>YVHbR8gC[U^YAd
Z>3cP>EO.5NZbc35TO6G210P-NQJ#<V&;T+-?1ZaU^DDH7A.>f3Sa:E;A6NU&DF4
]a<6Cf<]SL9/Tf\7Bd27]]\N:,K6A,N6F;)6<L#294,A+0;1GLA_7+CJ?SAU+G<G
>&W+5GI9E>O@-.\C9^V9A@DceZI()3-g7[6_+5gT.H&,?]G_F)X^P>O8?/4DIQ.O
c.b,U9(4:W8A\Ea2>J#)eT@]Q6XGS(9Q7CH/ZHBb39J7#6L5TJ6?@H^N>)QZF6;Z
3[;a87P+2.],=JGPV#0;;T(MUF(16IQ#ZC6GQ8K7c#L&M8AJcXc6bc-HPJ+)&Qa1
4M[]TC7M:QV]E.7&A1M55=FGC:D9L0^^0V@?6XA9;4D>5&(&fOQV/R;.Z6=QGOI#
VVK4LgEWE>KJIfN8U>0#2>/6<5L9SX@H8(1e/W-7FJI(>d/7P;6PPb8f8dJNQ@YF
IbLPf0H9\W4UJVb8J9a;S_=U710#E(K[8KcO^+3_C7&]b\,L<AD<N?_._H0KAN50
C?\P3YN1aZ#?,ENNdMBI;\E=VgAU)/FQ.EYMP,T:V1:-WSN//#KTP=d&10;?L7Z.
B_E7I)HTQS&@@NRX6[54#I0]1QOT=d<J3:9aI\22NgHG,WV/Oe&/XB>LDE]H,c3)
KCQ48@2[8-98?3ASMF?.6;RQ-.\gXV@W&M:@SUT?Weg<NdCcLO)]I@@]+g<N<-S:
_0</65=M5O:5Q,ZPCCc^fIN[@>MH_V1=@BO@P]H#MLPd[TFTC)8U_BTPVE-HSYP<
(\;OQ[f6f+]@U12EGHHOLYS_^Xe_()YDBKN3L?GcZ)-=4]L&0g5YKBbP<VGI;2M#
B5d;1C#&geLaWD,PE>)B9b6IGG244+;_gSOJ##8_Q3C]WLZG_G_;S?WX>YYKU06K
+>-9AT4X1LA[+-)L5f]V)WI&cA:3+Vd0KO8[+1KWc9_RVeHFed&D0HS=#Y&QH4g:
KA_,E]beY_HQ&X.>9D1&KC,,:7/F_DDL@3&GMJ7B0.[P(fg_:+[e3GF2V4L53.fY
1ANMMX6GXG.#/.W3+LCTMK48bG[FFBA1,T30>5\#PPZO>K#V>)>&S).,V.aA6@3d
(8J5/=5QISg#559:(;KJ^c&IL<?:?382C[\NI8TO:GU.:>4d&+gUYT:D0+e;N:0D
2a?</Bb.bdN=98E_<O<e#]R/+=2H>LEB:cT?&&Z&J-8\(][fI_.g@_@R40gF/6D5
I@(SD@NaTBJ0/R7HQ5XOP1XQ>b2F9c<H[L-G@e)DYR8U?>Kg13#L,BRB6aCX\BVY
[UB\?S?A)\d_e4YJ-2N#fY#-<-+;(@OK#e?I+:;&;_CD#ST839]JG^da42S(T3/V
Qe3;H/Xf-58d.)X4\]I2[4H?)-&(f_33cc)4@O1(_7X3Hb7WG=57HE^M+YgI>81-
Q?G7<^<<]4QJE]_,_L81?aO7\c[0J;_BA;J9?MAVVE-Z47&/Wdad1<gBTQg?0&@@
cR0I7(#8(MX(VIPJ_-,J=;7@WZbBI2)=8C[dD]6FTY]P-T4R1+K&f5J/[^,5;ROa
\4]N.0Z990=5HP9)@0U0S].&A]dE+J=)^/78g1<7\dfCK2?OB6YJ2ES&3=#g]IPP
1EWQ96>VK:&]JdIU\=D,&_C?@S.:B:V+#]X[:;)R-<TJb=?-Ie2,PIMQGaaWGA37
cX;cJbXMVb]^>60&>.6I(UO.D@(;.fJ..c0ADU@EE.;+d.FUYT/7;4g+6[>KXDa[
9(MN&(H:G?\?fF&9RO.BENZ_DEK]LG]F\BYX&4E9-]<TSd0,d#Q/SMgBacg<F/C4
KS7Z8,bFM1P[M^:YM733fX=@DMMe\3S7&eU3?P9L;6CT2P0.-=-AAKBZVK>/<e@7
=[X,/UHU[PD/.#<g]-KR-555+&ab/^U2g?(BB[U0CDL(7XSZAAL<:7e:aT)G2M?6
(]V#I8+.gPW)L0&Y)fXZ>N&;HRW,@/VR?d0DHR\U0@E.(FI&2.<O0ERc[SZ]dDcU
M+@PK.)<[>_Mf@B)2<[bU[eRB[fLFS)?96WIOVWH9e2,R57E<@b]X1,IEdJQdT=B
#TAX(Df(M5M]99\Vg#4)25e.,PY3DSd:[0g&51NV_Oe?>6Fe.\V?W]GE/P3Q:FB3
cX[NZFaHCG\He;YDI]7[9&32J8CY60<#S3;@<SN)/F297X(THPC,K-L6DH-P?eYY
,;QaWAZWGPSXcL]@SH:BIYZX;g&(^)>(d6WC7RU\4SfPgK_\\#\b9WNBI0#J@gR_
&2W>S^0^dFXdS-cJNW_W@9@:TYXNHR7KV3f(X<JPD?=_3FF.TXU9/BaV\LI<+f1b
&8KP/^Sb21U;VOP=4_+7_[3TP@[WR]/M6R1EW:LS6c(\9LZV@AJ^5=O6@J,e-HOH
183HA(98BT7(G@<277#</6V,;MR6[Ue=R)7(;T1beDTfU-,6a/W\c5-^d/G\KDPC
02D+9F18dV8A+gT&.6g&fCBFb##F4GC[cbWHM@HBZ/:+Z2TMF^U/Y-Dc#XJ^KK;^
FSF=_C?NE;88-\F2]b].M),^c,(HN_0bHY2)NGff.G-#H.G>[Oc2=W8IL^;9bN9D
N/=U;8A]S@^.3;K]X]8_]P&CCAT&0E;HK-Sc6M3O15<ZZC8>a-]82R739GBL=/A.
4]U97<#W8#gIJbba<)X)^-a;dTC;.6E<gJVd@g))64\@J5_@_D,4#98fNP#]Z1;S
4>&2>Q-bEc-XG?<eGGZOKJdf+NX?g>+2f6>R<WK5da.Re<V1G;?PRJ>=V?a0A[),
X-<O1T^d[F]U(ae5)/<@+UeG@\HDO8[V3QF/02H6H+9]^_G]fSQ8^/>D0K7BXUb-
b<4+P:eN3H;H;OCa#(D-+d@;2^GMP+OXL+BFMBeAUYHJCW2W3gC7,0S3-.eT6eMV
X>6.J.6-/J<&>^D)<FVJ)#PcTH=e[FVg25=2(G_.#_7?=,_>2:T-A\e[[6KC0_6M
9)If=H/XeG)=]EH5N?@g,:6cPY9g4Z,J5JTc(M7?7egH)IW<T9,4e;c@8IR_JB?Y
[5[CAT.>,YM&c8@-S0;^gJ6+O[0Y2:0GYVF<RCg]KWWbdbaM=)97UAc[bEO04(Y/
)fL+P@,F-PDM<,;9YfJM&&De6)U.R&#7<=>,K(Wc#&c<__D<gb/5ZOC,9/(d.M)f
V+2Ib]Hd5L-(K-S]c1SUEId)=YA6Gf&f,_a1+TTA_WNJZNDSS.Aa^:[/-b4aZYaW
#HY2<RN)+b51gN.8)EI(f,R^4ZYY&BE-SXXWT<7+XL?9UbDf;eRMYXJ+-dUQLUE4
JIIQFORUe&f<AEJU.BP.XK@A#&W^):EEQc6(,KRO?YVDRbG;#NG-&(:]\U5E^CG;
I[??><D#3<M+5##[A.DO-gF>Z9GdGZdKMXL=7[E3)8(F6bC\;H2(/8D[)a,CCV?7
ZZ;&b998A4PGMSOG?3?:DN\<>C##D8\2OB1:M&c,1<UAJ=9UQV5:20@V374<-(d?
eH9PceZSgR4>V10O=CbUDC=dDU]7TP_\QO92:2.EY3RVU4J++?#eP._0/Q;cfb:N
;e+W&/7];XS;=JVc>2O/7G#I7BIE)()1fLeY^f5Z?9?I^=eKO6-;Me,eHRP-4_R@
^YA9.P[a@=7C46>>C,A-Y=/cKWTg0Q9e>/J=eU)HbEf;P@^]#4^.CO,>-=D;0C7J
4e)F?),9dD(NJ[(X,gfZHJROJ54XFbe1DQKJHE;+?a]J3(LQVHG@K/&O:[fM(Z<S
&KL?gKd9SS19Y>&0V)JQ1Bd[=98AUa+M@AAXIIWAWcNf\#M7Y6Y0eXc^K<M+-/KJ
K@VX\AN8b5N&]0c;S62L_gCX0AKO:.I\W\\Gfe<aA^bcM37E(/.03=?0CWP-dQQ#
TQ0FO-7\]g+G/X6?NSeb-M4^&#1?Pe30@_c8:KA2=)<HSg8]aZ^+Y21I]2]W.#NE
K_:ILP82SM=GEV8ZD8a54?2+d471g)aL[7?1TR8P&SLY@>I<C@>N<4I&1J)9B<;=
WaT3aX(M5gCU<Q5;]e[RIL1KR?Q0TK(U].P,EFdc(W#WXA\,(@,10#3,[<:eDa)>
N:8@2+Q#\[_Mb@.\+-X99RTf_V>R1O5C8SXO6C0Q:Qg[O6@,MUd&HUJ0N4ed1Q[c
+,f4F)6T)TP<U39P=[&XKgY793^&X\-[#Pg+a/)@)e/f3A?LM(J(4cKd=_ND,F\_
DHK_>D7<_^f6YGR\28J^+0VF>DF^ELH^/8STBK60YfF-eE+#(dbZJ<BN_LW#B^g6
UL_a-:7d+JL)V-93JdOJZ[9f:ZeU]b=\:B._3UgMd]JRL/UI@FE)>T^OTYQ>]Q>Y
UX(^gL(HD-1.-d;(L(e.73X;Q,;-W6,MADZG3/Q/U&KN5A6]S2e#S[/Y[#e@^cQN
Q-51a8HOFZ8BCQGOKY[960)IZeX>acYK4WaVWW.;g6GSdI#;#G?6@L]\/R<gE;))
V/=O.2GI[:(7#dV4WZMeHB.4VE3;Dd:a-1+;B->Y]E7H>C(TLZ91SWLW/W<]DF9U
g3BR,F6G3L;DbN:=e5;2)<B:)41S]>[L:=.R8WcYE:AE^bBZ>ZFA;W58JG<NeAC)
[,3;6&bY@&1MO0]59dCHJDB#B?K/Bf0G(0Y)B+))HZ9=&/=&0)>]@]/><I.?S[)4
<cC#XT,:<(5M-M2d@Y@5&._aLSd#IN(>e]Z=29EL>dZ_2@LANL<LSSc6?[Ma4gST
;5+@E\(?YY2f\dd&^IU>UEAX:PF)Tad4aX3=FSNUXdYSZ,D>+;,U5)VNcE0T]?3f
N<GA8C0RT>#-E=+YJf5K#15Xe^Q<_Z.cbM7JSP1<QB-\H?a9U8eJOFLE&16\4b<]
d.VV+I^;W))BUCX<AeJCC;F,4\B#^>1eWd)0BE0&KSSN2NId<4&]9SCaL2VDCI=.
:/SOV3KZg\/VT-]Z/0_)?-=eZe,]:M.ETeBFa8L<cNH7Z(H[0&XC[#2(X+BUU1Dd
3M&93(HZe,B[;c]H#/VRXZ__)Y0eM+PI/.EJCY?)+-57RF^76,\F&6GNdV63Y?][
+f)bFYQe63DN?DSZ2G/^2YTfA(8Tb/aG+F5gEQ>B_68R\Q]I3=4Sc<_DZ:Q@a2Q8
5_,gX8C-].W9^/([&330<N_4^>eY.?O[LT+]BG,<e5D<)T:XfSLdYU5^H+b<V8],
cA@0KTZH)_H3^)7>DJ9:+DU2UC<XbNNPGA6gTY0)W2JDSE53P&L].Y6IGU/<8?@0
S?.IT-^^^X(:(09dG00O3\JQ7b6Z>.2V/0VDeJ@?4M=S,[/G5>cQ7a7:a@QWG[A=
TUOCFSK<&4RJHVEE@F2KDY)LOU00YL^C)Y+.Y[C<gGT1/AX^OVa^eIcB&E11XG6A
f+g6U)5ga4>5bI.>ca^8PRZ([=@DHNC<6D/B>aPDLc5&Q?_EWS3H=H;=g>S0f/D&
_BId6YcMP3cO_2DD>,T2X__:fIcKSEU),4)W,N-5M7Y5[D(#;8E97^bMLbT2_^.,
G.e0eM,PWe=^TK^@^E&X3X_M)e)@g<J+U::Ve4I86=OOF-]eEXT;^HIe\JG@Z=54
L4PJ)-EE>?5EBO/?_1;)O4PHYU]cbDF_101aL;V(P]J2DS]a&gRMJD98/2M0(L0V
0<0_D1V>NOF\-c<219VU=06=GF:Y[.&YX-=G^R\OXVU<8#GU</JNbA)e-<+\#_a[
Vc[FA3eFWaVRU;W3YU8H5R6AJ@=^R):d1W?eKe,AIaZM(f00+677-Q51&,AEK-eI
E[+fISQ=>=E;^]XV_&C=A+&57?d)PcGD^8VW^7.MEgBW9@beJ[7)]&^6.X9F-+5^
bSU?\Z1P6D@_L=4)S5dZ,.eC-AYCB^4;Oe?KHFS94Z]G?AH(:gP)\aQS:;g6cAN[
@4W8XTRZ1&SReVfJ8-K)a@@fZQB,-VOe455N^?V/?BD\O#V4=6#c\G;D8EWTY0;R
8GcO0AKBN,_KH1,L]A>C#]Q?QX;M>I)7ID7?-VfN+dU<(MKY6UaH8AYP4@XgT&)T
\(87M5N7fgRgfY0Qf]@0R&G-0V0fAIA4I/D,X](>;>T(gQ5AL.Xb+d@<<K1CJODP
MbJSgU-8e(>/OR+O9\U#1QV_&bW,FK506GPV5&WD##cBKVUBeB>O#@Q4d5^FQ(DK
3MLDcg1PA92,EPcGLc6D(&a1b:EQL4,H?N48<=9A6geM@;,dN+OPA7/ggAJ=1;7=
A]bI<7CKXagBBEfYQ\5.((]NAO4,(Q#fER@_/b9Ia?7_2;G>@P4C_>HgOYJM8ROV
Zg=4(F]89g[J&OL]&a]8E\RFN>MOB8A<5R1^fWK-IT@J)]BW4#OK-4#?Vg9K,I7:
1OE7gM@AA.gdL@A_f6.fAeVT-JYDBG+_CA>&][G:=8X(1<(2U^/Xa8^H\WM.#FR6
M0GEg4(0VE)YSOc8NTgE5E;OG-ND@F4LA^>HM6N-=_2_YM\T:\/(V;RcDQLe7fNM
TS=Y#28B?TdZ]GBC_d6XY+2<V?D:Y4U_9fD-_Z>,545W(OL.4^^d:M6AKXTNUc#B
G=8WG=H-H<KdUUU0/5O\>gNG:=0@-OfH5]BX@b443C:^GW2B/=eUg_P00e=Ya#E:
34.0dJ9Z+7BKgeQ8=-F3>]8=b=7;/9&8,GQA\XP7IP6b.,La6+5E+SEcFIO]I4ZQ
_41Y;M90Q3BANeS<30R(9c+]LF8/gUSF6-\c2>CKD1cJ[-O(WKONC)U[/^SNP<NV
N/+UHE&NEd9(d6[aNJY83ZDR^ZDb+ZX2FRS:-4K>#]#VK&Y+CEQOB9-R^Q3J#WR7
VN5=S_=.^/B)b)[/#+\/c3S-@GBXWa./YR_BeUAPQ@eQ\/QNY-D2Ocebb\[.#I^^
H.EGZK;>[Q:.Gb938bHDELQ22,cO;QS=-/D?FfN#M1:AVMQ#b.P/7BCS>#725U0g
/;bG,+,L4]63Rd&,;AT@TNgOB?da,ZHBFH<NXdJ;AN(F]3UPd28dK;K.a78MR^5?
+YSeg=_G4PZSM@S2\\&IW2TbYM2bSA\6P5e13W>cDQN_V8]]K:=VH.>C&Za-OYSN
\AWWRG:YK67Y>2;c-Tf@&MT_2^/NX3FWSCGG#DgFZZ/1(>2HC6EQ:4<;LGA8RQEV
5HP1V3PX4VdC?ANX3[d8C0):7_GaK(,/ggE-U0)E;W^CgRHNIHFQeUHDO9B9ZfbW
aX02cF1I&G6P#cG4)A-)>MB887@SQWK:IC/H/b+?--gDS;[J>X#H1)EA3-Y?N1F6
A9g1/YNdP&e86#V2V_]^G69b9:<I0aXF4KO[R9YE]+[.I2g8Rc>e:,1UQAfNA+,?
cPYNBF^G6bW.5#;55N[>@Ic-4ZS+Qb_U-4aS@>e61JJX=G53?X0M,^G?/^_[W>&a
R#;4L^39K94;Z2D8+bSHSf(WJ>,GgDG,[1._;/Eg4e^Ib..G5ZC;4[,SE>][:G)5
.?f6?,3MW>GBBUU0Xg_:c\MXM2<=,UT)SE.;M9fe6f\2,e6XL:\W&Z@8?K/UJS&T
^D5;6:[HWESWFHZ3JQOEX>=?fX;Q&KSFdDd7\#&NQ.^_7g_L/8N]e9+;38g2=ZPZ
XCCGM_IZ@#JB2\.,dR:-\T@KC<dH]R#XX7FK;D7DN4<=DWMW966=0U]3[98D/:RO
W@R>:FN,R9CYVC-g6,6&P/;,KO6V6.)PW^>U\MNJ##58X1ANFGa8ZG4g7M9@M=c:
RJVYM&Z6#<7S73Rc5UQ?RYY>T\)K+,ST,)Q]>PFg?3&ME@S7f>e#06BaSX+2/abV
;g6A13KJCV1a5;+d2gT,O__U<)3eJP#6X=I5WbFBRI/Y@M57(H(BJ?I9W_fRS-Hc
D^ZR+5KO7dYXQT=C\5EXV0YMJEB8<0JP,9.85f)Q.0W)^A13+H5ALC_K>[ZfbD/(
ZLB&Ua@+[^?M\1\[bE(P_8JG^3AgfP;8H:(Oaf8\g7?MR-(K8=DVd0Be(BP^BR]Z
&J;)M-S<NNJOHFSed=U.CT=5@2&3-UJ-;J7AC-fI,1X<7TDH1EfD_W+4P\NC:N35
aegHdV[a;Z1XC;K^+#CLJU)e:=O=]:\W.)2@ZDTc9aO[R8MLTUdFB]4e3JX&V\,_
XL\)c22LP4X6af?BH1b+>S5\Zg<>U@9g2WX8_cB@#CR>D?e2T(&E369-M<S,>HXR
<GW(<XC^J6g4WX?[/23:CW<TCQTA5[U_6_+Z<=[9VS_XZeD./[G2UQ^A9K-@QSbd
EU01)Ldf0TK.c4F#G6=E_P4;cFW82T43ZWE@20NSR5];4G_)]MS<aLGKU-Z9Wce^
QZM&0ED)J8\<W4;Tb;(\JD&7e.f^&IaeK,KP@^5TF4]-@]N5NYF,WV,/1d^#RHVQ
EI<_WX.8BBLL6eNPMF?Lg,@gX[A0=N.E-33CFS=5Mf\J^,J77KdL&F7][819LQA\
K=/RYeRVLS,@KM:2YE4)QLOZOH#1)@#93f@e[FIGC^KAF]OcOZaN_TMZ-:F@V2Of
&MgVbR<HS.)J,1(4IeAW;NaVJ;.^](/,C9F49Y6K):6ea93TbgTdV/6T+;.[a#_^
IK)Da\5UW/_Z10R,WQ+T,2;HU_J86E])S#8KeA;EWb]P+<_^6.,U1J]<gTV1Pd6P
.MJ?VYB=.FX7c=+I[\DI7b2Y2>O>QSMg02gV[4;2EDNUcCTT_5<-N2cX7<.2CbY]
?4LgLe\]Z9(JJQXL44a;9)S9G(_(DS1O?bC;-B(?IT,Z4]aT1#)9F#.bZ6X3OVXG
9?9Y4MF;(<IW<Ufb1#Hd&ae6/A0Af:;=AYU?N4Q;QSAdI^&PE&M(S402I)8YKWFe
RN6,Q&Q@4f0S7HY,_ZO97FHFFIf_UQe5O\)J@L&D9>.GVT>G?^PZ+OWJdZD+deY5
g(@5_HXU+7578@XTLcRb5Ed_?#5bQ42[0<:76],0\&UAVe6.U5D];/:M/0]K)3e>
W+^7;M_^80d49T87:.d(00dM>F:I.Mf80ERgeP6K6gCgRJB+ES+b67(XVNe+SJA+
ZfgKKYgDGc?NNL56W@FgW+(S9\Yb(W,I@Ra)LCaOKJ._Ff=/[/L(>_B]F>^-_W1:
7d37[4QD1)c[0I427YJYGMR^OX3IA[FC(cHL,_I#TbdaX+WELP8C1+ZOQ]Ga.71K
N2)H#-7]5;;aQ/L_=,J].7UXGaeJ,UfB85@3OB5^\E,G_U,YeMZPFG#6>GEYE;<d
VAM&O3N7OG((JZ?IZ9[4&.9>K&\06fJ3XWcP]MU@N/BbXU.I(QG\&Sa#dN]g(^5d
ZCV^#-V[^5<RgIV(T.>7bFY0+f5ZfKbP_9<FMI>g;8_Pf1[C.Gf;O(,OU/YP=F:_
O]gRZWdGEAY3I[U;XJ8M?8Y.g-&]]/D)/N8MWLY&88:HJ.#;XLCd3,3.]>.UV]L1
1=Q9b.d.?.CBSg;eV,@WD4,a]#d[Y?)N\RfIH=I>WOG?<-:5AFMA80VXJ4XG>Jg?
M;@50E(4-?<2M,^GLXM71W(?Q=K^W3\f)>f9,8KO-W-V(5>UY8=LHHGM5b-@D080
?6I<4)BU=3g]/Pe1=;KC,PI<C_:J_,fZDTUa\V?+-79:EW/6+b^+[d956@NWM.=4
(@IKY1\OE\)d#fPeX#/eaa,H97^5LU]#>G)Y,J(_]g=V2COVA?_0M-B[WKVHC>DO
OJN4\&B5E&,&/4QfIK-06F-PW/W+<3X\L21\D#S57MDfPf3agUH=3E@>H^I/G3PA
BCb04bHbN41W71+H+U=[D;/a,.ODZcaS5U^XGX,/QR).^GVL,L/cHS4M\9Q_0TB#
PQ2?9\:><;S--[3SC@eVG:/HIAS_cIAe#d(V0QfVSO.&bJXV@c(G]))WFLX(MbXQ
eWeeGbB^-P,8/B@BNU-.3?5-ALBLA9(5E5ZS@(;=a39f@^b4-;&c:HCJ@MOXYN/6
NXfV/Ma+^Q(Sa7eH1:C[WI7@fP)322\25>UJKUd<Re0P4@5:7]IF8)NP?@.KD;P5
QAGfES<a4#^A(1dIaSM?E::Z>IV?eTZJWR/51WN:X[8Za]JZ^_\@M?[gCd?cFcd]
E8?>8MR-/[5UgU?W^G5.]O.]EYVN0cgKLRNTc06(UY\:/8-\adbP-1<-CTK5,B;V
#g;RZ5e]&T&EdZ9\S5Sd0>OE<??F/d4AAL1eSY6:?0]\7X@fT^H/Q,97_9..I2L/
;@]UR0cc?16LP/;G7C8/JA&cT6bF47E[K^#NJOF?#,J;ece94.#O5<K+a53\>9<5
FB?fYX424V\?+/Bc#f^>2-PB?IgU;fC3[9Z0FXPW.MdYM]BAagMI9bDJ,9F\;I</
;7@WcaFF\JB]2N(P&GTVd2(d^IeU)Q_PIVYLF?6gO]C]#34Z-N;6;-Rb\(Z-N5-+
=JLU@9d_ICZ>D5Y#V^7ZY/eO0+ccZA\He=e&:)g\H4,>eTAP4@G+P+,5,Eg2HA[P
@U3KS@F6O&^e<72YT1EY4Z-SJ>Ra._AG)@c>FQ/,e_YNfO6:\GA\_F)aTI-B9_Cc
V4Oc)GE(;QMKad7X+=[f+?)CQMZN7M/Ue_GHE+HDNLC]B)EW)IQ-3G]/ZJf9NKQR
7V(X21D-R\J8]PBdVWQ-P0S77[W&;S,4fFHD+Gg,[Uf2bKGB:KcI3@@H<#]eJ&ZR
0)fOQ#6G+F-f0<JQFGAE-XBO^<H^G#EV_-4<,3]0^XL/H4WMY8M4;?E/O\?EO2g(
Kg--CT+J,\B9==PL-23:VDIK&-^50P<KLT<ZYHgUK#B:T?-^9e[^1HLLMbg#3MAE
=Le[M>Ddf1:W5ccWIQJ<K?G]E4U)O8X:?c0_MG[E)D:;O#\g.Uff=<Y^dJJaSF5[
G[Z^4]XZMfJ\=;,(IKCD?+Tc1fQSBODd56E]OG)\&1b]>B2JG=]8IUZ9<<5D4I+5
SJfb+>XU@FQR^2WR;(C4W9)8]I5^^2.TMe26SH@1<HD(T2J)MO/a_]>5\&^gT9Ra
eD/H3RCY=./[9-J<GeCe:=I]8TSY4Y^N-]DUMYcb5Y4+BHZYV8L\49;.T)TW.&5L
BWePY8eNR<4,IQ0/\+DH6\W(6VMe2KI#H)f[/XOKaMY<>UI^#E?>d?I4KW>8OBW0
140P&Z,M5a;MY?\ZZPY+]2>DXRb]M0SVA2>Mc\N<]3KPU#0?77O/;(I?X#e=E[4S
V@JL9_2CWR7^.,W-eW[N]9^PAafP?cBQRD0>C;(9P=IeM<aJD]K^P#<>C=\&1L89
Ob:HYU&Y@a#91XaNP_NVY0YcN]d3Pe-VT#-e8Re.ed#^[G\Z4^JHG<dPbOS(Z).R
3>9@6NA-(=T1G?2J#L[gY(]CfOS]<;2fY;Y:[)[0/ER:BG[,&1d-7<BT0A0D1-.U
e?+TEcUb8;H6YV,DCEI[K7IC6M[fAOXLQHeaCGSX&\GLTfJ_0Sa;>+[6K2eS.DdG
UJ@8cAc5<eEQN&A1S]4[)K#LX/S]3JbKEC7e&8U[)+c2M1DI2#@T@FF6J&AYUKHX
:CBQ8+g#YVLOU&+^0d-<-1887+db>-B#O>SVG4L=_SO1,E<(a\aa^+@M,8D?E.Z?
gNR5A;[,+7M?Y8=&RC07QFYf]>S-f4N5>^?D0UaFT<.fg@VS.QCY:f?@]WLB6=8e
[\eH12cF(N=I.4VdB(LV#I\F)T)DWL]73,>fOK5M8SLSFLPC21BY][V4HCET\)IF
Ze_6:/4Wc/&CI8)0&JMWf0O_0g<G6MJYeg(bQ8?T^YV?c.C#cB?[dP/aL85X9Y>-
7]H#D+1=R[/,Ee+H52a-V@:_?bQT(Q5HD\,&Y^9AP84QL26+MAF]TCK=(g,&YQc_
TC0O;#9I#&O^NCCNT@NAfEG8G/UTd7V_=:-Z5/7NIYAb6^e]YUG)VJG)N:P@?735
Y7a#T^MdH<c&cL<A/eM&G/Ja^;TTB\Rd)NR1V6U3Wa]4B2OL;U).Q^ERIb^ROV^.
e]9cd9eT6G.V.#c-U/Y;\dbFa.U\5Gd@IJDYUW8<AG#;6857ZWCScAN;#T;>0FHK
2LE@7PcK5ZF2SEaUCM,fY[\f;D5_D>&e7d&:AJF+;\B2-J6UYd3#<>dU[@EQ9A/-
AWT6-,>S4+dV7+W#KbSU=9]RL?J/[B6aCJ6E2(Hf^C\4EY/GNCeLCEbMDTIN_(ED
OE&#b/1c3JC]dd<?IM+T31c5@d(B22e5HGKI@gAIMG&1g/55\&\J2WOHIaP,^6FH
&KSY<_;T(,@-N79[J>cd(+PP7>KeFcS#198?]5=,D=D1(,DF5fJ@YS76NV:)AL=)
4\d3XW)KX;Q.E&gYT@BEF60,.4>]Xg&ZC7L@=WgU>1EF2Y1Y++e/VG>I6=L0M:F-
>7IAOUgR=05GOGKPUHW097XE7)IbE2#R.gH)MD\NER@AAcb-EK-eQJ1bM]T#1F#S
QMV)KdH^5W05I.d.bSH;5IfFA)#6F&8-?Z=R[M[/&EC=0b7)PKAN_);LX<.DY,DJ
0O9-eTLRY5G@BSNTP.7O_X_C1XDBMSMddH5af4WIB,M5IE1Rcc[UOIa\J3LY2V1-
c)SI:U1E0>&62f&7)Q(S0?.([[X.U[Q6/[@HGaE+.4Ce[OcA@3faR(PCQ4M;cYYP
0I3@bD:g-&WPT64YW]/_@Y^PSCDMc6D8+b;Td<>Y/CaT_[8EG0O+b,_C>A0A=Pf(
U-::.MEFd)N9DRC&BTW3^:O>gX3&+#160-Q4(8G,G44A-4PTG28-TaCJ?G=:[1&a
F@+aVTH#0,NYXJBG,?7KXI1XO00)94OQdB>=-K.LQVJ(&NMULJ25YN:&,b;),JY>
828&K7YYM-JSdBN#\g3GZ,2UM+&#U6Q++A@U^&R.f#5QY9\/C4G<4)aBgUJJg3=6
#IA+22EV.U#VK<CbQ@@7.R877YC)<Y<9bP(3eH-AX?f5IW(&GWA(aVSPd_Eb9C3B
SMg4J0CI:,,[F^A?b78(N^^I=E#,ZZ3TCLgU-e3b0NH4<6Z0CL/9(3>X7b87D-7I
AT>69eIXa7UUO\>>B=5&gd_U?/eZ.@X;Bg8GG^1_)O?FOLOD.+a5Kee&WND72a9L
VE+eHJKI?[[Ic9a()[)]Q5ROB=G\8@5P88bWP6<A#RN2&fL.NCW:JKYeYCWO#VOA
TJeH&JO8JP>9J<L-[@+X_dQNMb,,ATYX68I0+1fUL6F(7F]WC>2#f-H[(J-2T(>]
NVCdZCdW(V\2,[c.;]<7&^RT0LYV5(IE>([SUOB(HLQ,7)]Ld2/;8?dKLcY3,;#L
H6&-[[N7BR2Ka_5d6?4=Tc+U4C+].^[c/N7/0c3198Cd&2T@YWfbb)OOJ7EWTEMF
b10.510IM-dCZS+c4+X<HJS9@Hd:gbZf1@Q(44bV>T819;g>X>HPeR[MA>KQ8RLR
[5)3da-LQYZdRZVc2]O+g41>:/)Y9gb?()W6TW8.>d,U;-+Eb2)9SW22#CQVM]Y;
#9-b3bENGf87/]Q;F?FX+<G>9D+/.5N>OP\),&G9U\UUc;FEf3,dHcIM&0I6)HfI
&)_8_=30G[:)a4,Jb-0HM4#DXWN\&=:YT)5UXY^1Ob7@VW[HVaR?,,OXA-^?cXN]
,R8U(5ZZEf1)4)fPC2:gV12Uf368KA)]WBf+OR+;aDeELd<0>LNFXCO=65a4T)-@
ed3&[[]3aZFGB-_@DVE:DR\bIYS87XP\Q_UIFZ26BV;64(ENK0[7-Kb_7U9aUYD)
#2g2Y)M4S8#8K.>+V?)PJ=9KHedW]KMA^]XHf^59#^7V([CWNZ5IR:.WI0L)OP8U
P3f?P6</M#FHXF1&JZ;VCUdI@-b:a\N=^LL]>W[_K3@4(C4\5BV4(7fDPQ,a,Qf2
Q++6];QD-\CEH+gJX7@43F+M\f?V@6)X>BLX/a.Wf_[cBVU+B:,A2ed<)+Qf2?]1
ELd+[=U&cC=5;]#96NF]_+O5df5,g8+gKJKZL.=7>gAE1F9\;V/)N;HS6AQCF6bW
BIEM9(S;.>L7<fPA9+S->.);2X-Re8=-^f#F;+012I1/H4A62fd@8B]#D:cHaG)D
NcE&?R7VBaB.g+E^ZNMSa_Od-f(,FV:N2gD,g1/ba8Ad,cGL=aS7E,Z@00=?VWdO
/A:>PRB[G-?(]0_-J+S4ALX&\S\1FO4UG#EE(\SMYDc5(eV.\T1X]M(:KUR1\3JZ
LI];-gDfCCF.18bKSN>RUL^O6GV>2-9R\T0dUQYMAGG536QA.UU2UUT)KR5EaA,^
H/QSNeaBJABK50.BfXaLeK;fIM/#HX)\?JaE[P0\DX[JMJNgENa+S8&;-8M@#)_3
T(B>,[a7a/O[Q@>Z01Bg1Y(;DKN?WIK0#T/^16(?4f(.-K:e>e[3VcIB<E,1N;I8
,?g-O_6]WZ:ag,)+(Id2aC<=P()3Pe)\_DV8TeO#b=+QDc:9@g]+cR-f\b@L5WDH
\gMW;/GC#4:c:<C1:g.>OcILATfRDU:U?5I-:D/?XW_JF9Ma&&R@cK0AQ6U3\\dc
FWb-3)+,<<9X^B7=<_]WQ6?(1YR45cC=83-++@4N:KZ.(c<cX^(W\MJec2G08]^4
OgTWK8^O^?ICbN)T)(M,2DPXP;XD,V^7,U&-T>4a5;bTF9+IQYLNQ?3W&B5@=>LZ
@,]0AX8Md8&=-fSK+2T6cRCRLEWYKg\D#eDF\4#)_dA,>Oc=[[9^MdZPf;(KADQ-
O=gC(;a2+MA)?B3gAYg1XE3)D,7@WYKJC1EK^6^GCg\.FZd;EJ>=cTV[G,6GJ:?>
R#O&FA[W\BKD2,a/6(JSC-RM+12)Q.fC.1Of5.Tc=:VRYD9d6^D7QJAK?KL?[SDg
LBc@gQ\T);(Hg(MU7a):AP@PV3b=-0<_V@>&+F0]@WUTg8gW\ES?WY5W[H[QSX@R
4?)4?)2:_#4cC1VX)Db,RVGDCM744EHgeX^/KDdE-2XDI&]@d9R^WcFFg7TcS7c(
JO6)V/KbV2?Dg:Bc[BHI]E5S6T;a]/\&]M,;f#[Y1d@C7IQVY^+_A#HPL;6RNDIU
AAIZ#<CfF6E;:Y:7g;R<aJ,;A4aJb8Z0O<>3Cca)848^6J>:4\).aAR4/K>IT+)T
K^^/GaU<e@11a(\87\/2/U:>6=).2OFe1a2JGG_5A9O,)A9W-[^W1,bB_7^d#0&:
17=:/STV5K?H4ebb#FH.HK<8PW7U]3d^D@RR]dYV4D>CKB.Y]c6\/:NJUR[G>@SC
dJCVV@-8(82F0\SZ=KV4(14/+[:I.KbMIZ]XO?+a46[E7PI.MBMR7Qa:c[^XVVIX
&H8/#XaDgd<;[&;.JX-eI>CI=ZK@82b6EF1,66L=J5CA3UQ2GD:W\8JT9IKgR.SQ
GRb&Df]OZ1E8?EgATRaa1GTKD,,6d0OJZKC(Q#d;VQY)ZYaS+TE+WOT=+8f\.0:G
15^C5^.g/B,#.OOI87BB3&c0bTJ.WN7>8XC2+(X;F)2.a59/b_0e;BX\O^MLU[GH
E&^CP/V+,,e00Ua/SK@>9F?ed_X3=-,d7E#6I0dDZJ8c3fM=TQSDKEbSYO:]RGc-
]bIM^.9,?f6/9D^;1C/A,Q?1F11[O0F6C4D+b3Y3+=K2KaZ=R]&<PA[PAZe37U#c
:8;f:C3JZPUbLPbVXU^:6MKa=(6X7>e,W<Y.F(T>#_e[:Fa>4OFZ#bJF+__V&=9d
I/75K\7(8f=4#V:DT7FBR-;(U:R0UNB/2E5R+bT(OP04SeBY.PK/;gYgOPDZZ14@
2eUT([Zddb^U5_15cEZ@O-S/P&0;UUV5<3DdKFI(W4ZVEVKd93_=)D@&Ub4Z-G;_
A.VEQS7VC2D<)e,.]D<OAYGO&T7Wa>(W97-F7[Q>6[HL_-LgX+D_ON30^]/7N:7R
N>,51O8b_JM7V3;c,Q^,X#B4U22(C;S1ZMVbBe8\D9_5?(BdI>,)NgPDV7-,:M?I
gdJS\A/;TJY@2F1g@S5aB\^]JUZ:87?3<9A36?JYOP]9BT5<Q+][6Kd0:</QI9F2
PDDMT^Q:W_2F\G,9JN)##KN+)-M5NK,MA)8gQLJ/P]4>2g^WOM4@5_(#e)&JTa#f
?X=cDCVU7Z+>;I5O(M=ef5QAYYL^SNQ>H(DFTY;7ES1I>KK.C72/a8^]NeDO\_#a
92R=Sfe-82T5g(?.ZfA_:F<aKR;ENN/\14a_F99.-C2_\(D7)g0P@)Y])251U?2V
,XA<eI@+Z7D&COO?^<PH:,-)W(Q/NJ#Jc@2.V<b:AaRE-)=,5[S?P]3b#.8</==Y
Ub0Ta7;_B:3V&JO^cSP9,eag-DL041:LKdG[4F@L?W=1B50#U.:fa_),>W.W.GAZ
@d^?-L2(g<C/4_a2f+]PNEN[TG]\K&PeW0OL3^[W(7F+F..K_SJ7<XUA^ebV/-3d
J.K5W<-Lg+)9);?]TJ01+KXg31W&F)ZB;21]VK9J9W6Y_YR/OQU/@HJULB+IIVS3
KBe\44&E=QQE15.)9<(HQ&#JQ8-9Y?4\E<;4M?,C&AYNT/L^/B7c_Cc,b[U0\-Gg
IN,;f11L7bE]_+.0_+7b.L_Sg#5>M7[f/@[aN8[.EUHHcO=D.-\f/;)2QT3)/&0D
b:V(J+IXPb<,K-2]+H(SJO^+?gSW.H\K4HKM<TXX\PXI^,MNfIX.G=[b-)-8&-dC
\K;^Ye0?G<#[6)G?6H<-9^Ua2\M2P#?+FUXY_e2NHY7f_CU7FF>&eE+1S--cAe\(
[cgCQ+.eD3-AT.XJ>W=9.#Z9_,3TJG_2]bfOJ_UHC9[_^WLA@;7QX;R]B-F>bM7U
DW+]TaBFVAOQ/<L;J_,VMCd7+11;1SMCbE[e8/J/OAP]L>B3DX8T2_CH=9822]<D
P3HC))5fKZfB^RVUO<Z\Te+KPdM6DT&/T[BdU(Y\)F-XXHM8LFBE45>N[6X<@XTE
+0@#<gHX4KY[V0@+9T=\.V1[62FMG)[8,L0e;[(6AI>O(ZIGd@K.d.0?bS+EaI[A
gA,F]a^MC<Q-2]B6[GFf[[AfT]6JN9#feNP3RAY75<9\HgJR/X;1:)Y.35gJ8[F]
LQ99B3KL.fC2ZXRQRYGRXI<5[5GB29U2UV2QFM2>A>F\#.^N+;O0X#dLR7GT0U-Y
XK@&UR;UP&<BYd9TA-?NTED@]-ECFeH#YW^-WTR4\d>;::N]#-LV>E&U]=Ca/bC,
#OS7WgLBT3M:)FIeV@=B\R)5de?=fg<0g5X;1QDR^c290:ZAK+8DA3LKJVdeO0c>
^IRBK)K<e>X0g:>,>?]SXXAVVf)ZV.B\-;bCB,)Jff:3/1PV_eRZF93c?-VPXGbC
41,9d8RAC.9BfT_(H;^.5-[.QIaSMPOHU_?d5PaBceH[QWOcZ2NM-)N<B2O?XRPQ
.<2_>aW.ABS3[5d(=HD4DV.#>d0F8]K/LC?AWZ^)R+(E^1Y?P.CLMX1dOFS+AM_#
.1Y:+S,RPT:W^EE7(aTd,>\;]U+GNJCfbQ8(8X3OSQg?9QN_<;V:<L.P9<&e.W=O
IJR;]-BUI/9IDGW.5<IB,M<a\.FQ28H6,_,?3/I#-eD_I5:G[^P>Ub>IYOg#D/Y[
1>1QKeX[FO\5_1HT5<6,^bA/&CNdANe[[gD7,W#0R_JVUC_]/E])>C4(G7FYE5YF
A[7L+N6#L;K::A57+-T=PRRYRDQf;[.][314;@;P^QVF_3dFR]G6CM9S([ZK9(1c
CDK8fd2(.CDfTCS6C979@QW+@4<c)QN8a3;LTOGL_5F;MH00S#5Z\^YUeS.b+OFQ
gB-bGV;J8>YPH[5.HLO/eKA7ADU&^eF?D;ZT)I73D,/VIWNf9Y&FYbHT3=4Q[VMa
&OG34aZ?aOJ9HSFBZaL^L?W:/_3ZRYCAc;@cda:+;?[g/cd2NG@0N0JR]VZ)-@49
g+d46+XX9(ZeIUH+3UN.FF;Q\NH&d0?[75_M<dSedPg5SbTZc7;J:OSLWM@O1.[J
d0-R/(ab=LGYBdF2)Lb0T]4W4(TF01f,@70D]_fcDR-9aJEBBb\\+CZH^&^&)4)5
C?TAPU)RRY=3(5b4,HZNZ8P3]0DNTc#9\+0REIe>I1S&(e)fYK,5[C@]_+eGK]M+
X-^^P2f<:M7D&VWEg&Y&=DV2;DK:=RT-VJAQF?U>04RX@_18QR.2JPa1#=0(gZ13
JVG+(F8TB?3BOAeX0@Re15B(JQ=T,CB9JScEAJ#_&8;GXIAJ=R28M/]S]F\,1:C3
GfU90(;Ife/@7>W9&dE?0b<TSMbJ=\Q;-;d\0BB3<XF(</>BE6bJ)FEE6WfL6UYU
1T/8>JVJ00F^IId9;F-e\F7:#8XL(Be03T;a5A#U:#MS=DRE+dOg23c(KN?<;ZUb
N=+Q]5JIC5/MX4--GVOQ5edPLGR4?Je#ESND]);SB6:L;3BS)TTO/+gV.LL,V(0S
&RV=&1LPCQd3J]#>?/gS@[Z0A)e-#a)L[ZBM\aW1aCec?8ENQL7)g(5=2&FCS#];
O<)09;K528f@J8<)78D2=))b[)C),;_;4)I]LQ@N&&V&S=>=N:_7+DPdT;)75[SZ
_NE8FD\9B@+RI9>I]WHO;X7P_Kde3E@2M5IBXEI#?)E+\NO63J6;G:Wa8)@I?5D4
be5Q)VW/0)JYK+4A2Z3X(7X[25,Y?P8P_LJAN-H1@8]7\A)RLgc\#37C4R(D@fU&
Se[R0EKbdFB0IK_c3gGgODR.HAXB<(g8,6CL;)T&JF;)XX6@R#HANG==E=C;0>@T
BC;fI1DbN@RX58<31?:T??O^9QR=ae+O?6AT#--/,F.5=Fg<=Q3WXEd+,<G+GRUI
aA,)5(K^E;CKfG9B?f=T;e(9^@0BZ#B1)L=GfS^aZ)NO;M0@9?X],1:J3^J&F=aG
2.3OYJW/\INaR&Td8PUdF>g4)>#YR;LD6]AO;V,PI8\_+)faJbAOccFX-?VP5a/U
\^7[QTC;HEYODe+T:&\YGOACPC7686@5:ZV3e,:&F/&5G0V+NHdMFeA=YA_b5fAG
EXT2.g]gL@5Zf@&\^GUXbKJb8OE4JK/JL2&_B\/288#66[?+2b=8(^BAR)O]g64d
<fJE<;bc&04R?Fg-CL:)VMLKa(79CJR4.D8XN_]K9-G&16O/H/&V5?Q<@)S5cXDW
Ygec79WMA0=W8;,>T[E61b::_038B:,T41E3DYMEQC0X^P-I\9,NPgD?K)AI^-dJ
##dR#.<.ZWa3I)M0e4?QB9:JB7VLZ+3\gTDH/<U8L/;E58<K#Xe+ZNf_dD2;0#GB
1(ZG>0B>#g8]ORQbe5SOCC6NaPBQ1^7.ZXJKCV.+ONS;/V8(#+4HYWXO&KS#FgOZ
VA2?2GCd[/+0L7R)O#c+g3(?\0BJ03TMZ;/US,+bYWNB-PY0M(:ADd?Zb[e^:-\g
SUDM>8FaP:FI4\B41:\Z1D,WZK8b?..K^6^S[K8M@_]NN+Qf>aCf<OFAG1/=SLC1
CZ;dKfbdA>T&MB/+YX.I_T@4WA&aG[9W]S_CRgZ?ReD5?[#1/EA4G,FfZ7VM4eF>
W(+&\NVP9\=GM/CA1E0cPaJP90R4YfQLZVbHb]>JTZT[8E/W:2&\+2LS?cETL<Z[
EaG#QdZb7&\T?Mfe0+3dLG1[?=;gbY?:LVO7b]@>@5fFKXJM=1LMJRWQ=F7Y_,1(
XOf7ObCGE50=]bGLESXWQ-1D1cf?4]-201=NP?+L&+S@/cEIS#3Pb=#I&3E8QTI^
dJICO+-WE1bZ]8>Y.Q^g<L#9;^F1/Y7ObZBe6O^fS4gDL^87RGFI9KP>e-Yg@XDI
eL<8G_#^M)[&M]8KGB\a3VOL0a=f-J]L<cgE\?3g3)=@F7<BREHMTXFEc0O7da-#
FYRML,_:ABI4+VV?=3]L@?D2RD(W[8^_X=J[LFEN<S_a9L9g/F?H_1Z&WS4Sc<6@
E\KV-9>&HJB[/^>T[7df:W/KF&A>]1-R)f=gOK@YSEL&\B\8;&23M17WJAEC@B\X
60<9-]GO5Q[.GV,/H]NJGA8@)U]JVdd)N\H0,WP.gO6X?E#eS5BU\3AbRdM]Z)6K
UEb_S=KUdBIe0[9b]f)]Y7dX@0]O=4X2(DM<M2cIf6caPHMG/<[^\gFBNMJMJ5-]
eC7[>HQU)2K<:F5T57C?Ma^#Z7?d8#OdLGT>N>YG7K<DXC(&CN1ZG659WR?>aP@7
Q4C=OAeU=TMg8gTZS4HWIR\\ATX.@b@55S@6G8G0;/\)Yf]JF6T,@X,,]X.JD66.
1AZ[ZW1+0A6NZU/A?]_/?Bg;91(:(<;+Sc&ZVC0=cSFPGaeSUc(?:TdK@7V)73X2
0INX@-5;BUGYPe)+]L7VZ&GXCIGd@Pd[:V?+aJHB8]G1eNRH;Oe[;\)Wf]USOB:7
Ha(dbS1Ydg2?a&fM@/MA_SgHH7=VIHT0aX[-4#Z38VNRb_aOB_.eLaeF]V8c[.5K
A?TUHW^_+F^IX29[eI,L^HM9f7]8U27fTc=;Gc5b-+gc1NROX9\ZNRYLW8Y(SE^S
2[+353CX,a)LN>eJ^;^3+W#A15K95b\FMU^[e14?PYcL]P(#b/5>XARW-&CO2b_U
Bc@@6Cc:KREKT5<88G).]c18Y56dVaT(9WfP7fg@FD+&5JFd9(5Q_P]DU0g1bR04
VQ8F-T<<LNS(0?M4UWB)5VC6<;Q/PS[#aZ).U1T,T,D36]+)5_1&EaI[C_^P&[Da
W1>U_]].)e.NJG&WdB@JG<I<+4B#//3RDP.9QL1=90fd796Q-H<KEOb;ad_R+^,9
5;6S@C;;A392M_QPH>8+MQBZA2D4FITac=TfRg[-_c:bdLUb.)MM=D2^_],RMG?Y
T;NKKLS1)NH91;g<A1LKOUL/;)+212/CT^dZeRCX5LQI_.cfd>PEX6bZVe^#)e/T
@7TSPAR4D5-Q_Jc=]&\(Q,EH75##28IK9E:\T(&LH:O:<^IMMS-EQY_HY9[?4H(g
CF^EN4>87IQFIDV2DWYK=a3.8XUXEcH52U#XQY)S_>EXK^JM^^7<\+KOceb@>&ba
5D.0dHB]fBJbV,d94XR7TS/F5OXB6ZDR)#@2SHBR82e/(1,^KS>89A:V[^CF.MZ6
].792@ed\QZ(S=\5QAM<XZT)V2A:eU&L8D;.VPAJcYY7E\;Y+J4]XM7Qd)NC[]6X
+f1CG/dZV5N,c,DC?S#L3_Kd\ERB-E4ce:2S:3@(=3+@ANZS^K@?8E7,?gDB?M->
[fZPN=[IB5gP6XHUdYDGL5GM@L&BT+UQeZbTK46WZ]0X-0b9P8Jg)C;@JOL.3g\;
aVc_H:-[8#)d<-XgUP8=+KC]-7cRe94(b+8C3ALU6&8[6R..QV46\U\g\[W2_cgI
6M5;DgQ/V6a:E)aWL<.9?fT/<:QG8L[MCR=+FTNNGN:O+DAE_H&,CcZM@1JdFTI=
+CGZAf:W5,EF<ZV-f#M8(7YcT0=03.8)41N:XZJ9]]Y<K0B-K=?/VSQgAG>NaN\J
R2a+,;2_8T1.XS7eL?&(V9e&cG5bZ8)a;7IOB^g300SNUWJSPPT>CNG9D])gU]Hd
S<D@?W;JdREMc6g6ARcMFLS-C.7g^3-,51:_[59.J0dWKE/dM?D-[f);@,EG]B<<
JNZ#VA4YN?:f@QZK7QbRCaK1<\ZaT(MdBU,1(JdBZ9.0@e,b^)AP@Y6PE&b]HR,a
M-+4OeXJH?BO83F__O106?VaYe:38)JW9b,DT-TR]RdTf^Q7WQ>PHP;X?Z?_VPYM
7/=9]f]J>H4T?Cbf^/(3.PO-=dJ?9J_Ze..Wf0<BWfT=XT\&BHK:gb3ePb_AKS^]
\QKTgKSPMA?((:(QP#I_eCRA,>BU\61]e/d+=\K[U;Sf\#YCcLL?_;AT/5+SWGHI
g9\aXd9MgK0#;P#,?)G1,T-0&2&#)d7X^V=.?>G\8B2W=-eAFLbf+#BHP1=SHJ<6
RO:R,B2YC9W#fY<\HBacTQ#H6#93QK.1bf>a-g@>X&KPMJ4C1=U.8T6_?Z7Z/)CA
S9XccJd&J(?I=6??)33Q3D-A/<-M^NNWQ-f:RE&_d<IRB2f+geM4]W1f>5IV+b8b
3g8YYC]e+-DbN\6Ub,L57\0Y)/B6K33ObMK:&2ZggLTQ7.04E_+<EZHBZG00HOB:
Ng4FEQ_19,H\a>L+WI9]@\XbEg<+S;,US18#>+feQT6M?7>^>0V1K(dF^L(NIea^
cC(RdW3YVbe\NHVX@F,N(eC/f9)=a6T#USASQaGGa3=]g3FT:3J8>9LX]:,D8VP(
YP<fJc&-,RO#@TF9?>CS3PS^JA>5+K?D[-de(^3JfK+)AQSVYF]@aB3KQP2\5Y\,
7N1+MXb5F4JAZJA0JY5HE]IcXa]5bP<LVDa4-@<2K;=/SO.Eb<NIXU<CHaT92XF:
C:Fb9R]0_-,d5Cb>Yg>./0.E>X=F.9#HK7_>#N^:.(-(1=f<RB00_?8[bK]0B/YA
Y?:b27-C3fX?cc[HFW0Z<d.7_Dg31(C7YCg:b,+dS\GLg1JFZ+P>&Uebc.fUB:X6
5;1C/g\[#d,EF)>P.E[J&?UVM:T8LBY\0bH8VI3B7D>=GWWI1F<]g7?54-(362e=
)F^G_AO\MF@9Lb([^D>G>I>>L/aO6\/;\e\0\[BU&dWPa#Z3WS0]-TQ_1d84,G8_
W.(8D>bOJ-RVeZZ(Y8H+#@2X7&4K4[I37c99EW@2EMPN+D7UW(]ZW:?V2>I?H7c3
beTgD1^S((:I]Y)aUe18QgGL9U\?A,HP(VKK#f7N6C=Cg=[3>1QW8,ZcBgU1:c=Z
CVIAOB3+[53Z=XPW5IO.?5aXFAb5C#YS4<aV.6,ab(#^AGS@J[N(/(6;Z^8D&0F+
Z,Re7),BK91QN]WBPXQ;aDS=<@Q[9(JQK##HZ.+\]DXC@L:G,\SGd[dA24+YVF11
eR&M+#DLY(9)D3^<a]GS(@K,M;;HJWRI=Hb:725O\WJ(OWa4P]+eFO1+Z=83+4N1
ZfE(W]Q@UGW;0#eg<[92gY1WZRd+eJW^#MNd4Q>e&LJK>T4a5GgZK+2\-dU@9,a-
_1gdYe_X-PE;VPOG33T^H>/@[FWS2_g(AH&R)3]c,Z-,+S#X0CKJ[>_OJI^MILA&
=M<aPK/QdE9O-56N@JV\eHBL>F7B1RQ/>6&ERCQ2ZTCSFT&@#&Ba-3)3HW=[RMAG
RTHCE]<=RXf^,D](KDN_B5PO,a^AF2a<9(7VNQHF_W=ECZPd^?0e5-(g2PF:f^5g
4e76AULA^=e(01G@Ta:K(HJ#G&+)E/\=#(g8?^Xf\]DZ]Na.bB0.UY0I\4YS-UZ/
L:L^baCUJ]ge,#@G-<O<\aUgIg_RHAQE]^S14NX=/SOdM;e7g+\BW?#=00]-ZEI@
68UJI(KdU:R;UE+X[7E/IVbL+O9Yb=gXM_b[0=ESI4ITN?IZ8cA>+BRBM9[-g8EQ
HCO85,e7b/>EOU4M\/K2+=;Tg?6A3S@)Og-0Z.6BR)@9#CW_T,\SUSBB)3M\5U14
VaY7g1(39Wg]gI_OU^+905)(-ST&2:180g(>J)^>MDW-E#A8MV\6WW@+R3Y7JB04
RMX?\a&Ob+g1RZDD8dFG-^6WB&=E#GgR.#_23V9>8@:<3a2>QOHJcU0YZ96.QOYb
<@3=,feCT2W09SISN_L&;:(,+&EDW(1f<S(b,8)9+8.)NR+N\Me1R[C>-:M]?,]O
W383#-Lg/1b#]N;LA,H#--7Y,E=JGdQ3b19IDBX0C,N2UEde=BNb]S,(Q6EX6?U^
S/QZ>c(3TW(c6[IOHeWO(V+-61I78X2.L;;[]L:dKeE^ZGZ=#7D&Ng_Xa.]8]C@^
H.@_[_(Z[^.6/VJbF5][1WNd\d=U9Wd[5#KHZ@gOgK#OIbEZ6LKKcI#(fH>90TP_
KeL@\]NPf_@:K8Q2VZ.OgTb5=4<<W<7X,A])+L;IO+7[F<CM:H)0+FP1RS;=A?KQ
(-9[JE6IX^]KJ,522ZZMHW):8:FKe;cF/N]AXJ[2bX2A6G.FI-7YF\DJ\5YPOX\d
C>&;?+>g\[4E3X9PS>JAf:QX]S:aSA0NNTBNO76R/aa^_JRSO1^VQA=:\TTJ6gKR
P?B861a7/M[EWPY<(BGZ-N0W>dV<WJ[7?Sb<&.];>M3Ic8QSH]PKSgFKDZMAC@8Q
WM/5ARK+eLQE0)5e/O#X:EdFY1eCf(EPFE:Ma)9.32[K6^&D;J)4)B:)CX:\8c&Q
BJR6^J036=:^WeW9#DG?MKcb\VBb19DV0Y.NX3IGZe1KJ3\.Y=BH=GG-QfL9&7Ha
<(;1[Y3[1YaI@LAfQ[GcOTZI8/R^GOaCG:Eb6&X6,eXbg[JK_J\4<F>M.L_Z#1Bc
(L:gcJ);bDSFcPVS[7dg)96W\e2c7;OCNP0RFSa;gS:#,._9/-YY<&XMCIFSP6g[
@0V0P7fSKFFCFL5&@B?;AU488J=T(S_BC_-F=04H_7fRXE1]/P\.U,Y@NL,ZLQRZ
5#S:@[3M9:B;ZEPTW@AfRS1B]Z18Jbd^L47]6+_geAK.Y)gcKT[WAX=RV2f[_PS8
]]]]/\WRZ,E4J<X40T4b@,(Q[H2f4U)6V5Pg)CRdZ7XNDM#R^L)R2UUP9^HIN1Q9
O^0-?7+-dIP7FP4G^?(.?+W&IY5^\@E7\;?923YRgWOZ2&:TD.:K61J3-\&N0>@1
AK<H=fT(cKf83J2Be6IdZ603BYLQVf&#^[NbM5UF.AaI[8S;LP5(2.F4)-Q\Y,]7
K8+@O9/+R#8MfP)\WA:&?b2W\(Qd+S<>@;U[:b#4(&5/X;Lf/&QA68_S<Y+HMP^<
/)dZ.W\65[8<fVbb8<#P,d86Y.M>B2W(W.60QW]XZ<.5#9(T@XMN&+2K\OJT^:PR
1R2b5T/TKUJY</N6CBe\eQ)U9BYSQ?=f#VPPH</48YS0MGK;E/WD3DQ-A>/WY0JZ
@AX[)f]9e[FT)B-/OVPYFFOTHL>W;Jab]DRQB&RLe_:F]B]0MJ]2]54.>LCUE7Uc
X5/Q]PB>?+\8EHCGde)@5KVTWRSH(../@DDg)S8A=9[^ODD[AM<5D:]6\c,=@>H3
=XDWZRUc70gY8ecE^Y6YD8T4[23O@1&]NDJY>S6S;A,\+<PCS0KW&cLG9U&=[cX)
f?V]A7b2;XQgGP/79.:W&DQ6.UQ9g9/e@6<&a0a@>[gCe_(U[<e-RZ4<>9)4O>-H
NRXPeJI2Y?2S7f;^K+2a@958Z42f0ZRB@M=<;HTEN(FI<G3YHZ88Y]I>K/cA/UcO
AG6-<]4:5LDOIVaM@>B@We51OdKbV9M)?UBJN]H>3CJA1fC)R=RIYW.LY(SBeF+R
M\P;aa@&=b,0R7^1B8;N^8\&/&XI?;E;08&e8e&;HK7NYMO[&ILK\.EW&X[04#4C
@M]2FE\5=b4S#F&7Hg=7BS,@I\B]Y](MSG,M1Mf(4G__U/e.4Z[\gQBYB9>&@G9;
aD<2RV;d>0MecT#L\1,M(<OPV^2.99TE6g5gQ0&aX,IG?KJ-KHD)-GZ-Dad>?KE&
_]OC-=_b]5DE\OSPW,BUS;K/P2@#RVAAc.>4]-:.aK->FfF;(LVC#g^TE6Na)0c:
[W(PBg+#X>J3c;_CPL.Ue(8/4JRJ<LCdBXXO5^N8NBJL11=B8PFM=4G=->MbbRfE
]4_BJPG2a5gL=_)UDRFN@d>WUFe+,A0Z?@;FW.FE(U)=g=CT>D>Y4MS-SAeY2K7N
DOe>SdPfE-dORP^,C<a,J+.=J^6A\EZ;2f?\SR]OA[;._Kf>GMC@_[N[S7<>G1]:
HKO=9AVM406+@@:-ANUB=36g_KVP9WX,T1-J5WgCX;7LG1G>(N)<92TOEC5NYM<8
/SUaaBeT\]GG.T3AVJ>>4S<FgQ3[Q>ISNXQWQKDbUHW1I4;PfLYLMQNDd1RW:2S?
^DJM<9UN<d0YYX\9V2:;(B;/DSKXC_F=b&?;<Wf=+D?Q-0MXS4.DVR2gUQY0MeM[
3-A(-a8CBK=)Y@fU9.V^LdI;[9R,Ecf4QHT-^ZD7+D[6<0dP7\B+W+Z-V,\GA9;L
AVRMV[@=)1S9d(0X>@g[_>J:eL#?e4g[4ZN1_E#caDZGa/#]79\8:d+f;#_0Y\KX
+1,XMF2<<Jb3<VEa,61g5I]<FUJ6gdT1YT2EdY67LOQXQc#fTFfbM^-URcdWJ#G&
&SQD:J_.R4-b:9BI5b)[,F]Rb0P@,2&I0-9f4P35MeN0L_<M;8MHE2^G2NbPJRGK
f+K,Vc+92:>a_)2AS#b48^CQEOY1N^:J-S98,_UOfYR[NR552R96_26&Q;J#+MK5
\eJ0daf81QQgI\.1D2X9LT,4NH#+DGbRXMJN3GR,bH?dc8,<]&4DB#?/V\9gH)1A
e9ATR@g4U89T,aQc@H#4[ae/,_;(FPg+_1+EJ0[V>&B0/<FgW-(>HH9K19D60^Y1
:U(L6fQTdQgH,PL_HU/6S):/aaJY.QC3OAD/HNFWe;^O\^_EI5,MBc+#IYQ048C.
:]NDOJONT5<5b84daNGgWO;g3\/[<b##aBAS>L+>>EUIdF9LWK#gSV+9]T+g@=<5
]HFacNK.fgbP,;ZFB>)eAC;&3</EgTTQ#;-Dg6QP,)X<P/_?LFDGZ=1U)7/H^?BX
=]ee,85)(I1)5UD,9#GcIAQYZDR#H_LY^W8@<e-A)+8VaKRN1:GK&&KY6&I,,I9a
2Z;fLc4ZA.]RdPf]bUR)0Z\/bU:0Wa>aU5-GL8ZGS5+GH#3NV>9M,K(KREdf,>eZ
VT3YP<V);F#7=OLX<RM?R(--F[L(0Pd?>A_\,fRTSHFSTFW4RT0^Y:\HI48Q)Q_3
.E^96UM)VAb^HV=ZO-C#;-Ye.#(_7Z\8/.BU>[KgUS<9-RC,J:.bV>LWddS=Q:)]
E(e,:Y-gF&>J6?a#gWbS-_H7O93#4^O;+7UIe7RV-b90W92.1dO3&5_L)QQVT5Y)
gA3=BQJIQ8/^+PQ\W9ER?6?X7.a\FWaLU<fY&&KUE<0b3,NZB5L:]S=9O,K^GEO\
TbcN@56gT7^2E&F-2GIME5O3e[XMa&8eNe&d)@?Eb(bDFD(&M:M^&)+]3a&>28_:
/;f,eF=L[bM7)#7[1\_e2)=cY6Ic(7WH^>2GM;VR@^6Z0&@DIH=0bO8>1^9];,dN
[9BgGGHd_Y3g(PN:271@=K4WF0DXK@W#;^GDfd181JU7<O#VV7Nc)M\SQ#M)8R#9
RL-VMCKY+([Jc,2Ag.)gT+C?VZbDT>F57Ff)DdKCN?C>G&P>,f4e@b#\7=RbfbUB
A]/gOUM_\=Q5V7:;[-]?N_3XS:A;\<EYW68=[B41EP9T:U1UU8aCZf0?fWgZ)^FF
:6I?O\CL,VbeHN;Y1c/S#RMGgLLVP#f#.36\J\Hf1N0OR4PHXKgJaZ#PadQ3(;NB
>NH-\E?Z5S4,\HaO[eT:B@WCb-0^8T;T?B@_20LGV#]B5IJ<(.eFL;(7EP6M,\1C
01#XgM_[RB6(P+Z[ZcS<E]2G3D/ASA+_cYNO5&<(SP,UT]JBRZT,@gUeLDKH=],2
KRS\1f-9D&_JJ-7,6J(G</X)7++STZHa:?]cO[<>DC2.QNT>>I^CBKRDfO[KL@@d
V@NJ.&bCaC7UF]OX/[.OZ3:;RPAcQ+6^4.2T5WSF2/3K)ZQZ2WVR,^IGOgYKb0a7
Y[R/D7UZ)5#F0F6J9#FQM;?LVe)293F3_X,;AL@QVT>9a>_DV6_-ZA[GUVg:&>4f
_g?Y6;3b65.B_1UM(8R:W)?KF,O;/g;-503\>\/>=>C&GZ+;A+bWD)[,ICGgX@aV
GJ/S9I0[.\#-)OVZ#7e(d70>1Q,aQaZ/]BNU;A?Le=XX+J<cMKYU/(+C^Pb2U&N?
L_.Kg];@0X)GBAZ,M(=X?2E:J+.BD.A.5X5JBBKX30eR#B13a^#3Y=IS_E8KcBA:
W0VY,XeKga96IZ3A)A^T-R:.LI?M&;E(/8V(A:;RK=g7@<e/a;dBOP-\?F&9#O?K
XX=d-NK(3;@X]/aSOHTRQdf)W]GC?P4J^:BRd\OP0eYWX7dP>A<bOc,H#8,X4)MR
-;b]8cQ[6TMEW(_ReL8L2[RB_]c[I/,EN40>+-Z)8?S[;7=_7ELKT:+8;##;EEDR
R<.+V4e.:bC\&J4N=D]d?MVg=SV<LQZA;HX\7@=5+[<VCcM0<+HLN<5NL2-dS2dA
I4[fU)VMCg[3&0gX7@:YXg0WKY97X\QE0U\>7U_dCN6da43D-U-Q;G/Dg)S.b3[F
9AfY>UDOP^K\HM9;CUe?QT2bX.3#A=Qf?>K^T5F3ATGIWES?Pb8R/B36aXZ/UMUP
;YM_U>cg\;f.Y#U]VBU5e\HE[>M=AJI^6B1+W)LYQdS,6UK02;9NgOg2P#/b^O>f
=EJJ9VY<gLJ:Z7]TbFDC]C1OR,Ef95e<I+Lf#OJ@4>N)FRLV\<-gG[+&BT,_[;CE
&U6Ug;gIc^>3c8E@eF-S4(fJ)MKNTc,b=aC5fCMVWJE_1JKKS(I,>,>(8.4T#T_G
4e-aK-Wg[1)0\TdgGB+NQ=Qa;>6PAgEKMY8PZWL1F=1:3L\dU.^C2W9b#94NSXgB
<c_J7Og;7c)@0,)?&dfTaPW.KI/g\XS3.\9@Y)aRR?bMV,N5=X#CPG0O710#6VfM
JHPTbXL:bMbZ[<<O8GHVP07GI<.CN>5XY7Z/F]HHQ>]FFT9Y2?e=dc@-D5)]RWTV
L9>(WfK;(6K,1>D8?Jc/KRCBcR?51K@63S\05Nf)J(+CMA;J5I=:f&H;GE7gM>B;
#P1_SMNBB)VVII(EFDX[F73DTXaaS1GO>bANRD#c^6<+:fS)7=g<\GP-&H(;HM_P
BN?N)=f6PDRcY81=2[9RFbAGL-dcAVd<7W-3b[4F&[O&.6TK?VZb##X@;LNV5?#D
1)dN3<\dNV<GM6)6Y(^5J^D1_f?P.=:DOB,CH?X4H_/^d5g9YY_?1[DOSAc(-#A^
Tg^V?S0H<=e2K^5(U?82c<H+,GK3[Z9P^1IJC\U,5X3Q:8E9V3eK314I>UXAZaBP
K6bPDR+M)SPZ9;6OdfVGW?:gaG\9fGEDge?F3dfAH/MUgC.ZP2,ESR#&W&?OEA0)
9dXdgCM@3JV4b,,=T]F0&YQ>_,U2J.,X]<#\-^BN7HR8HL1<3XQ585,UY?CNPEI/
1QHGGg@2+cBD@^Z,8WA)N4IRMPRL>PX45[6Q(Y^BQ+,RJ@Y@:]bJZ#FG13G5/_1[
BV7/fRZ;Yf8U&4M(#PVW0Q[^DM-gQ_EgQQ(NT0@1;QW?@b\Z7\&S7T(c9BT-T(_N
S;=a;;:>LD]PcHF(H,@HLBB76@G#+QKUY&Y:<NG:3K[[=XDEMD&_7(PZ(&=T8YL\
[&VgIe=<TWSN]/-.AJfU8NJNB?HG-AUY#,9Ha2SBI++NAc?RIS_F)?43V+[0c5H[
13:T_7BFYaC/F_9R\CYe0.7_I=\LQ01C;dWX@/]Y(9(a+d:EA1]S4[&WL64L]9PU
)VU(YTeO2d@VYWK6>+QW&e-eK-ARIQ082[W)]>6aaM..9+fRCfUcJ)3&-ZJH0fPC
Z7>>>#UV18F6G5>cI??UTUK#faYeZ#UKP=&7ANAfg,:6JZA3JIY=/C7N7SXI6#:S
RKN8H.8;YED(UGdRc_Z_^:=<N<YD/5][OI;9AV0dId>K\W=]Z?fe.OaM#;S&^WRH
Z:,bBaC:b_HE,]3MFR1K:P./;#LQ:+]#eSEe@DDWZ&/&?Z-QQ2<&(4VTX-D6Z2EC
)8,T++U:K\&^BbKIF<JgHeAOK](?\#R:RbNVFP<?:fPL)SG-GdM37EeR?XZF6:FR
S_AJLV44\IW+POO5.3PSMcG?<7RKU<HN^FBdVMXSTWQ]K24XSg9@4WLR>4@?20Uc
H)Q#dgITYKA/7-8dF;PXNM=VZcfTQ/fGS9.^J3:6(AfNG&K[1^,E#WM-R)e8,L>P
O)g60Y1g1MQB&Wd.6P8?d4<c\/If+C=X;-(@9F??eV/,XaO)KYAEeC&MU?,J3_9\
=A]a226AUOSN<<E=<+CL8b@MWZfFfN?67+:OVV.fV2+54.:U:)(0U>CLM@?-(L9,
QgNO;bg>AY3Y3Q+EHH,FZ^X#bfHGO]f[JI9OV#&Mg74R?RUT]9g@S1_a-9B[H(US
HY:[L<2-2=IX<74]&CXH5Y6B;:eI&RJX(7&\P1?D^>U]?<e&]LIa1(CZWG]^.8\^
Y<3H/KC@eL>^C1>UHe?+f<5MQe78##\3EOINNE(U^&R8S;8]QgJafb\[]f7[\8@@
V]9)[XJ3TF_#X6H^8dO^2?XCS[>L5JMObf\d;47)a8V&8+-+dD/>G6TdCGPMD,?S
OE\<fU#4UQba>7:C-ENUR/ZT>BQ&>IM=WJC@ObYDeg#)ZD6.0@3HN<a,EH[P;#0\
43O3Z)=A5YGTQ6MD8KD;<4C8JQ6/YRPeZ?M>W]G2<#45IRe@@KKL9@HT]1OP;0=S
3M9SOB9?T],M_UPZB.(Q1U>9b98.13FWTJU9.1b=b<]O0[SG1cfD2a1)7FL-2.\C
=C@S1AOVZa,]cLWR>0OEb^eXJG_@JN(cCbMcCB27#]Y6NQcHOXUG@<bXJ7>C^O?=
D)M>3(>WeZZQ;J^;58EZ,57SO11Q6F\A#T=>Q/T-+7I?9:ODF8R2=#H70]<(7Y[_
TTJZ6FUYTB;??Jg9E^dA>9^/=ST<+GAf3SO1/<))EHHJI[g/BfQGc=:W,3\Be-@Q
,VRGV10,(4]b./Q6\:F>:W,S=aa]/UbW/YLfbC9THW^DVJ]E=.D4U;2[J\CC2.J=
)51cF3QaMdGF6F0B[ZK2_?&[1ReWQaa7+eU&[1a;d?KeC7DDVbR)L5?U4POB#GDe
T7da]17RNM?GJaBIS#c4g-M/;b:WJe5<D,EMN\XD><>9U?P4G1dR)X@We)PM#CMI
,N,3W#X@g:6e/gR2U()2/6dML\(;OVgB\,MH(-dcG4P]86<cfaDBTf7#2Y;1WT\9
DS76#S;Y:TKXGgDO8@Pf<ffSU5?Jc5\H9>,:A7KJ56=6;eUdgc/U.,>b\A#O[T8X
gK1fC45JA3(0gOAe2AOU\13:(eQ+E>ZNGRO0_<Z,>MT.G.DVVa#3YfG,VAg[[H>&
:(<Fg@GFAH2-)H2)\U,3g=W,XgJ#_QR]\gH,<KB<8bdOE6eaLN-6:XA&:(R_(cTO
VHMRPB[L#g+\.=c,BV[eQRY)HBLd[UK]@bQ58DRXYgOfBUMG<B][Z2BQZD;K2@2B
2a<+M941]Z1GNU3\97A)RPb?#1;0N6/9:NgV)5R?^G4,=?BJ4#21KW&>RX)aHX4K
HN0V&^1V7Fb1E26a+O::WaS;TSadDAP/[C<+G,P(.C3GM@Y>\UA][d@>BXA8._A;
E\-O>df8MAT3bd5K3_T.,<,]F[9Qf(C3dPM)MD6=IdScUSI[(58QGH@HA]ge(N+3
2R\AW)M>C[_J9-[70Jg8>7Y[ZcEKY05;D)C9e[1XA67bLQ3OB1_92/:8#^O66;@C
&NPTVQJcT#O?^8.XE7a)7E0OQ=3F(?Z-+SYRS\]fRT(Y@[M6W1TH4(D9RIfU-0gO
.T@gVK>\=eEZ7[HdaT/\I^R)L5@ZQ7T<(F627S=HK/C&;J?I6C.[@ZM9NN]?gDI/
a7QT6>@&[/]?a1,[1C45/8+Y93)1]0L0?+#Eg]DD>:=5gI^^QYA&4(/&DX)315<4
R1eA#\+\8.)=TK6:G90PgVW22O>EY@c42H;9T0a2D=ARbF^W?dF=)&;WH@\Z)WFX
+P/D+6H]e2V+)a8OXFFf+Fg)aIYPRAAg2f8,HP:S2V=&R3:+U[=D[;fU?#ZB7CR@
[Yb5:NVe)/2X:g/1PaR79A6C>.(e9FdK>(YC6e?Z@,X6ZM/aafF#6E^&R]_D^1:;
4(#Z@L8Be[_Z)B;]-LCdTY7g?AU(d]+MF.>N+JJP@@78RZ3J-9P)>Z-(9;2-W?+V
,8J?]aH=[ZJ8Uf<T:P:Y\XX@LcB<)&HPX+a=17X>[90;DB.R9Z\,L3UJF2,L\V_/
177LPF8/P3):LFELOC+95>fXLf9,WBQDI.g[:Q)N,(:6_6abM+NEPdFL.OLOY=1S
YeR)Y2DfU492,1]Sc,.cD=HQX?Z]5L_QUREX^D+#eZK.N:LR-2;5>4P9\P)d&L2T
FLO>&8N+-Z2RL+KZP/>7^A(89^O,LU7J-dO56\B-#YcOMK[DTZCb:)E#.Zdb/M9H
^Z)@a18g#7:5H0.S\_?=U=M[ICeT7M:GD#1#_e>e?Z>O@XO9PP=_d.;SI]fS1BK,
0^^/K8?&RAg4B/RaH.SA,0&:-fXge>/+O:)TV(S;(66SJDDB1^cTD6JV&,^^aX&^
PQB_e1=b&_eI+V6^gN>OaSX52W0/9S<,=IL50fPVRPb)g>:QD[7JEARHHC)5,.Xc
BQE9[[@aTMg>-T)3(#_1(?P;0I7-(//;8OQQ8\6bUS@R<,//,(VKf2P3&eNKfYT_
]-E;5BGK.8bHg#&b/>KI5ZB<@QVJ&fL+JQ@7.0=g=.>(K?cUb)LIXLL3DE+L>M9>
aa:7:R+Q6JXEHHW)]H/D=M#TBR51\_+/Yg4HI&P99Xaa>0)FUB^EBd8TFNQ,HG],
]W<3^8-T-UK#fTHDZC]6E7@?Ff3J:CE?N,+=;(_MHRG8T;gSVW_0=\;d=[\_LIf&
=34X7->U+OX/HA?KKN+0GX>9JP\F8?bAD=9>:(3a&[N(FY+6F_:7TJa.1YFAA8_&
VV1Y)d7KL.KgCZVSVb6USLNEST^G3#JVP]MJ;a2WN/G=A@>-O;B&2d(8:B]&K5I]
P)c+^LfSMWZ;K5Ee[4ZX7#?M<T46#X5NZ-fT=-CJ_)U,,KY,@_AZT5cI[]J]ND.^
@,+:e97e@XZY@NQ^20A?J(JH[IZd>8^2CS[L-#4WGGHbaD/b^Da<9\UR523:IQ>L
XfO5G,bT<cR0e2T81f]P97C5&\9d^F]NIP_J3BLTNMa[#XF,17\?U@8A9gY+4J/I
UE8NN&T9MWV.>N4:QdD-fY>AYd31URF<FBaN3,(c)N[(3FW=QDABKHHTBI53K-=a
^TcXX8I:79A\b-bWCR]RNT53+53:We0Z&ZXQTH^H^1YKe)]A9I(KDQ7a6cXN_-.,
CR_J8KY+GI(T)@9.f397gbM]V&88>4MN^_W/\Q-PL8B<G3JSEg=QNP)SA6&c?0g4
ZD&B3:D)cTZH)?TN=6FK<_#EM>=W>3BQ6.FT?]7Rb,=\]KL;5D>&3N2CQXbX61)U
f\^bgUGY(BDP+Ee]]@TIO8(\Q-1_M)?1:8RZDK633U;)TIb/988a47e#>?M.PH?L
.B?42^bReSI9-]G5^Y9Wb14-;L/d915(E[02/L325c+[cP8Z,(DV(ZN40/1PC.E5
.0[66^W,Jd+dGQ@3>#T[#S;/,?#ZN)eK>3@##^/T=_;KSd7BcCQVHIB54O-aASI:
\-7e?,>/ME5d;ZE#;L@N;gL4Ed0;SWT&.>N>cJ.-KX>CCB,^)T=7.a1P@&:>@O-_
FA+cI^4)E[bSA<#;g^4P\2CA[8:?A4GPa,-d[8.^_1VRN4Q9X1W2[#-8FU.Z9W0G
Z(bW3IO.;\T;cbA_7XF-L>,?KgUP-KeHT4W>Ed8?f9T^:aJ)8=U9ECDQ,3cO970R
_W2DZb^+g1[Z5@N_HcR)./:.#U(--G8SA]5?>4-,P)acO72^OWI48R_#UfC@cA^:
(>C<^DSP]5G.SMc8AGf/gHg(5Q#DW=(09UeeKT;]ZK&OY1VY+_^O]?N^G49#bXUV
8>aMH3^RB\+cS]C2URF+8V_aCF=P/9-56?<OB#S>]=F_O:0JTBL3<U8P>:<KH6@4
WF5,_<6=G#;\beK?M=FA]AL_VA)@IWFBYK,fG@CGN_g,\FRBE)EX/8<U\VfARYYO
@_2;01VgAP?D-N09fQ1FL=FY^MJ6#53TggX&KY6GSH=99UTD_E[LXUL0-6U@,FfD
Nf.G]E3:/Gf^S].)@dX]\C9;\aMMZRC+b9[0[V:7>8=8V3J6Y6Z#aD664b@#<]\#
aPJ0Z=XD/@:NJD<GM./(/(I99+#bSTBZQ(HKd?^<03EEP@cHS27Q=_J6d#MQ3.JO
T@51Rc)P;>>?:\Jf@5U?2W0Pcf)Z?1^NDW76A1+B(L+8AGFBR,7<3a/;Z5VYJB(1
(H&[)-DbB)PPaD3JTGFEI7KW+eZVJ>LVM\.<JV21=SQIU9->f<I)\AS/L4,VZ2-^
-V>P.[LU6,>8MERCK85+4VCF.cPL?E>/)6XYOIAg[VQX63QS3B.K1:Ag#)W5^/dD
O?R1U)X>]@6bV(\X_\D=FfMA<g,#?==Lf#Ba<&c>X>C]?c,@.#Lb7K2bVdGGM>[I
Z_dW,f1LOT@:3++OPY0=@;OZL_)DW;)5P42,#-^[AafS5M1f--9XW]7/1))V:Ng[
4DRU=QgCKLgEEGe,?6b0.IZGB[L@O5?YUO;CM9@J:FWb,@X..&6UC7O7<X9KD2.)
eH(,d@SN3:0#5fR0D1GZP#K<VB(-/]1&/Z8bJ;60YTUD/eVXfKQE1+\#YL:_F2Eg
dSCTE0b\:ec0P@b]-72bF.APMXYBQ+.^DUd;2@dIE,geRf?QB4&)b>)0M0D[AFgW
^UeQW?GOS?K&7A<3F5:H4M<K8#W-<3HF/G2K(80#[+Le-X2T#2R(9NIQ]OX:#1-O
Q8-)9C0Pe>4PP:8d]OcAFNY.@5#-(3U3a1)Q7GfT\Z2Z(?AM,)FPDAB8Y8,7KF9#
RQOc.@\,;@\>>8?VLA9G_<(8E6B89PG_+B4@f8,0PSREa#11HK>YG)^TVIIDOKHQ
N^BAMC]4[0Q70,1+(D)2[XC--P9J1HL.@4a3g8dEF_D;cR<G26R6G-7<0RLeg42W
D0BLA9EE:d)^H&V9>,>86C,]>Ca?O-LK/V=)+XI5/6(Q6,ZG,g+Q8Z9f(gDeUSV^
VHWSQ1?I[0CX?/97IFL7]EgfIT=NZZbY></(XHgVX-;T[P-E6SU^0:1;>W<)9Q-P
,G@9Cd[J:2WR:Z0L_LRS?1,#Kc8KTHM2dPH\JYCOc&0[A).TO;RT#VdJ=+,b#O^^
.dC,@8>S1_4NX3g87N7@TK->8_P]^7Nd29B+aG(>==DJJ<e/(C[7dL4)11CXVRLX
^PZ5CU_V^EMM<ROMF#8_\5(J=^T55Zf\;&9&8=:G<@#LI7WPWXe2B;/@.SXVMQ1&
0G7-TM1?bLS4f-[XHbgc4>\GO2(;UgQJ]DAJ>JeB&/&I/bM@L\@cO7F#<G8G+>@^
M&-W8V><-VeX_b>R1+L[JCD_K/7XV^a+_<U_45dK#1g9K;^U57?=JOD0/aTDWZKO
abbQ2B)3[KX/9BRQ\0@KZRaY0f\]LELd[J0B/agWKE>=/SQN2=5TL].<E-2<)b+4
R5OJWeF;MX85<JC\b6NKF[EOKR;OYaM[:<29FQ:@J5<gY^JCGHV.g/K7.&)aAE\1
J+0IU45V(Za])4C7cTVSNU5eVE0MNP.G#8K,@XJ9/7\0TE])>IE2I09G=><@K]DU
(>LZg6-BA)gfg21Wa<@=T_M.PgV;f?9J5VS-T84Y@1d/<9<=G5@0cEG9GQ+PSW+5
_E@AT/a,MBb8YB4VDfDNJ<^IQST2T9T5PWJCYV=Z2HR-^fC(RX:@\DX;U;8ALNSb
\gfeY_9/,CKeEe3fM=W910H=-W?B1^(B19EM4Q3U?B+31Me0d3=K0WI#F.f3=:C/
J4M:&5,dCUSIBPe4bTS=PHA<Bc:0b2+_KfcNK-\M3WO@#ZaB.:33L^NCPT3BHUJ(
XRKN>M6@d:^PJ_gdC=/#UgZJ9VgfGREQ\>DgAP2O+;aTWA4eK@TEPF1VeI-==3Y5
1SI1]#XXO9@7_ELYJ;C26\/ec=:7Y+1(7<X;fDHL=MYDKTC\a(Ne@/e[PKNVf4TP
/S:F2N9>^CS4,^d_ZbV&,\Sc7>-2UP4+HcL9M]cZI1FDgFAEa>^SR3I]2S04Iccg
2/&YdR,W,W^?&P)f[<3YeeV;a8F9+:[C>bc-TML+C)Ud=30F)Z4L77a)]K,MC@3/
6RVd;EA3>J([/;;^^L-+?],1?4/CG)M#C&LK69>=+Q[HDIIZA^+FNTM])gBZ,30g
91<f;5U?GgaKPeeCGa5(O8I&Fc3J?:^?IX?X8X8NHbB.@H\NGC5OR#:#0a(:A:>-
((SIE@@TV]Z2[IFb=G3aQ7)MdOd6NDQIZL<&V.9TdaV(gXC?UQUA0g;6(^&GPfT,
UX1I&22.7F(7>c[)1J+CQR/BfSg1/c2/=VbR&0FS(82F;KH>1Yc6&T=8L_0(a[YC
\U1/RaXJF70LSG<O075f,B2Q8a@.@O;=U_2OV0+P698=WU/;[P28(2QHe3=](3=b
c_DFgBT^C3H9-Zf:A#Yf8XI3A-FCR4M87E&d,-OAQ(@>A+U5OO2.Ie0U[QZF2H7&
Q&\a7&)9S+GA2/&cG\:SZ5@OggHFRcIgTV[;^FY9^;=f6?ZTLfDW#</9adST#V5e
7S2=DDISN1O2#:<(=5FK]8d#f+f8cP#Da/SONKH>BdU5eXCGZ4:WA[\W9_>F.3M=
ZUW_@,e.eGT02OX9L=9JD4]:NRGEQCF(6dX_EIS27de)FJX1NXXKQCB6]5b85d.Q
PdMQ[\Y06,\EGOJR[0R^M2fZ3S=/0#PY5Z]<cO;;X#?cA,;1&bB.[04:880W@]cW
Afbg-4HCd_>JKG31Ig/UHOH9L^?)2PN57^^I6<1DLf(G(gbENc.4L0YbIX\Z)CR(
)D)&Y3K=+R]V:VM:@5WD8F1I2@P1:ZTB6WBH>>YYbg/5R1E],bX7a7UO7&)NKEQX
=bQ9gJ=7G/9=349ZaK8R=E8=)75Y2K^c/N_bCeQ\F-4J8\9IA3YL<B:Y]2f4g&J_
9ZHQefe1#)S>SHVXPD;#)SS_BT=-W7R8Z:(YNP(>MFEG^PTM?9Ec4?5LJ^e1dIE>
0.eJPL?TM/\a\T)+d3Y@;ZU>deg/8FW,:_,V8bU#[fe5g>eFVBa<&<RN<KW8<Kc^
<d1a9^+,T=cUXKBC]fgf@(bEREB^581F;d)I/2F1GYXYEfXCc#adfS>B=UN01S2S
^JM4946G#_P80JU+-##c]9WLJ7)PV#Z&UX;T1O><.[T9PL)&EF6:/Q?=@;2>A)P;
+gD_&;dB;eP[Z4.KC-?NT&^_S4X_Z<=6;I2ADBBMKZQT=baM@J_A_WdFO3(FX_4N
\-@#QGHJ^LOF8X]XNOUPKKDf#+RV5]=3M>]AAY1LffVD)1R0U]N\SF3f6QgQ-W0>
0J2SKL8,YSFc=e:L1Q#Q.g<NHNLEDB8N#>O,1aQ:7,?TZ3G.Lfb+K]Vf=UO3:egJ
H+@GPM#K2UI=UNUD>OfKNedOLJU+HSJ/+(8WPD(GMP[f_/5TEL_-Gd,R3P09BK0]
;NUMH0g8ZJ[XTfU2E(U.\>T.O,OeN92c^=685W0BKC)Q3)73RRPE_WNS]XZ31=NP
3RbL3GMe;]M)\Cfc.@dY&ZFS4_Y(eQZ:X:LL-OKdbb3,0T,PPf:T@AacGSL?BJ?[
dbc2[c,2A:^J6?B00HN>@OOB[2K;JU1&6a0c/+PMCI#J1[2QUJ#G0C8HLCbU-Q^J
3V)aAC1ZfebHPX<77,J?^aQ7783]QM\\[^-HS<2C#f.M2X]GJfg@=b@]W#8IdKaE
ZXHYOK^KM^[1^#8V4LD_HBLKCEfZd-FaA1@:_TS_?eL7ZI]K]_;V.dE&2;5d=X7S
4P5)<8?4/-7@-7+S+@=OED5-_8)b(=@WYH]20;BW4M9^6,EC@RH3]^K[3f13KP[?
6(CBbZPT8Ygb9DK6X929[Ca]A^/.EG^O[.0Mc45=da8_DeI:+O.Bg2@eIb\JSdG;
07=dH7I>8;[_]J<U2ZF,@WH>NJ37@):7A7_;XWNb)JP@X<UDLIePV:+?OH=DT=GY
U6e-WDg@#SbUYA1[51+>0d?ZNB6(KcbaQ?AcL4@gV6I)K7Y&++749RMTXM-Of/Z,
.O:/:N0G]H441P[cSX:R-=4<]^dY6J):0Q/9QO6&16F@4cf+.@aL[B\0<7Hg21K9
2Z^_bPJ]^(LC_?GTWfM@9@Q#D:BeN/HEB.AU3N>MGW33@(465]QbVJgLFN^4F<I@
T\f>9U8RM&IIP_7_(&b+>O]ead8:A/=.:Y4HVMAG)N+FT7B=Uc?R[.a<U7BVJ/82
34/GMRQafSdU:KWcQY:bJ[=[L(8W-[CFK3T;QG=C9e6\0=IY=a\77GU8GBV<2@SY
g=BQ50/J9AdggDA[A)eO8)KJ0<2]A[:c617R@?0=;2I>10PgT>N.Q:K[?QLeB\Y2
F25>7YY_MFKZ&JQHC=Q9W2[\R#U4R.S3@>-)\<4\B>-7;JL\bV@X[Vb/TW8SK=+K
K0-Y#1e-eI1LNB,>f^Hf5#60e/N]IEbB9=UAO#:RL\2T1Yf8EA1:_(H9+PAJ89)\
?)Tf1;JF4^;P2VS]R]gHGQ^),)gQ@>a1V?6M3&?<\\R.GX4dRcLe<\XT>2R,d@SV
P?V2RB:O5GR?GM]d[4\H#8Y^&T867\OFM9SGf]^@Z6U/(QV.GfL0VF@bOD9HT8]S
R[W.ed^HcSIH#CU288dTQ^Ig???D,1/[410X]Gd6R-WA]Eb6LdU:9Tf\E##1IM5.
L3O1;)5dfC;SS9]X5+_?&@L&A7OR6gbR3N,.04ANEW4dV</@9@c/3dd>GFQY&)4f
:S.YaA+Vga^bOXFX_f0]fR=[Uc@OBM0ZX5I.]N;:[XVV9^>OPfcc,3KJ4^2Cdf9>
ECM#/fJ-d_e>@^>-9=eCU0b2&<]20RPHU69_)]HP5PMJPMGVP95.^^CQH>JgcaC\
@CFe<RgLE731B3cHS9T_-fAP(9>V)T33PPMGB/A:7C?V47,TXgZVZ1)[NR6<830B
/DDZ([T&R<.=B.Y=KT5@^A>5K2TNc@;4aAK7?O\EB<gN(_VO=.egb7/5W0U9YRB&
_dM#_VR?:=PdMMY>K56#aMGLcDZ;U&1JY3I;,bVYf^/;@+EUCTKO[<H2VPM_#/Zc
VHJNb>b:+F9KNF9&N]0K[c.0PK,Mbc,T=#^(=-5#JR&96]:0AXH3+_FW&e/Cg0-N
3=^8+V;H^C;OZ(?&N1Xf=WNaeT1gFCEY_>ZVfQ^=QNc)Y#YCTH0d#Qd6dYZbVfKX
PBWO3DGH]WYYQGR=0aHdIZ3f)&Z9:]@2C#-ZHHRINGM;)HC_[2X:\AEXWA_;-7Y#
>/8[IYIMFeAIWd;1eI7V,PQT[4KS^SAg^5B?5QKd#BcYFYgb]R=I><b@RBEH;DM0
bUeW<b)USK>TV+L_[KdXF@[:5fb(4e[^\SW7DD-a6V<,7OGJ+@G2b>X\7a?afT;\
3XWX<E<4UIXZJ^^O?c8=gTWU1(?CeBL9#1>KGQaYgVS8\HZ)6EFOD.Z8g/ZM#RVf
fXM2(PS)X6]faeb8.^fQ4gd[=Daa;6:EU<+Q#)_MS:G2_[M-f\QB9]D:8_YX180T
G^dOKeeAPB3D?Q1_SAf=)164Ed[>X.dYDMQ@Z_a[RWP^<R<)B7GL)6e+#5&4_ESM
S#548Jc-ed2&b4<[I1NJOMXMZB7?d\T[eS#C13d^@Y[JLHSZY]AL7<d+@(.(@-M9
?)Z^=:&M[S#V-BNT?;Z5UTHJHgORg8RZZXU7]P;^]I/fV3\5bIaKg(eO6E--+?O?
DJ85L]Db9A1+<db1UW^7L,80QNN-9c^IdSB=da9^5&1&TP+SF_&8M6S?BPfSJ/[e
XY;@7##ITg&;.ZM\7cDZ?fH4.XN=2F:EOOc)d[70I+^gcJ;@2^g]Y51DJ?258329
<A-.,K_RGI=;MND46a+D=KA\WT(=(X,2#R2#F41-V8Bb<38]^62X7<I@#:E&.3:N
QTgdZ-&]-IVMN]/N./D9=YBP((O-+JD?>_A3IBg4?5)>YeYQMc0^+L/DKeLag#Y5
^FF143[,/:_4JGLKF:2NS\3DY(8ga/MFQU4]8/R&gKHP5J9-CRX>;CHU2AB[34?M
EgHRNQLHZ\21fI&U]9JDQVQgfB7JCffNPB==@:G[8K;a]g54HfZLU33/Q&[O3#fG
8U8]b11):UM_/,8I]LAX(<(\FA\X]-2G)Ng?fe_>KV=860d&3AMS,&c11T5;&K&^
eb=K072O:^P,V8XV6cL]g4(;Q/e6AKD1E1ac:\+d1_g76SAAgI680N=Z:<CK<Bbg
cK;HY1AOPRH6CX+-4PeC7He/gON2()/T3;C=3R#AP/\16_Qa58(XKbSb05-;C(Q_
H#egO.eN7Q^g?3>N[C@-TTHVg\2AY2C\=4;QKU3A/f>JNNBbTDc,B.4YK66M,FHR
&\dQ[8gXDA,/+/3eJMBc>d5f]X(R0H<Z0LSJ)&:RH&IYG0HX+:aeYdP4G-Z<I[=U
MVF(_M:3_bCTO])VI?,R)J<U^+>:8(N:\UY3[;^G_WMLR(??4XG-,g&GQ_)Z^,Hf
Qg#eZH>W0S.<^MZeFQ5&K;eMB.gPI\X5#d/N0CKF=+OVWR:>^6>cX<g]O&,^VPT=
f;1X+(VWRC)__+3M?3UgPdI?gXL5G5#>5eb\Ydc/D6b]G7.#,/KFB5H(MJ:5][(b
&J(B3Z^[J8#/L\^_=I@,[3&\0(X[V6V1>4)(N<GI4=-,U))?P1fd+BgO2@TEW]2S
UN\g)dQ:XJ=HWKN;VRJ3,gcZ/^Ig:0&<(ARdcd#)X_858_1P>-,#>(07(?0=ADf_
?M+FT&_AD\:N??(I96(]FVIBP1<aafDBcG>WBf7aaRR.#-ab?LGX1#dE9FL-RU;+
6?)#,<X8fE\;@-<bD=OYDW-c7:#\<9YD/>]8S(^b0_f\B;K?<03F-P:B83HB.HV?
C-FD_e-C9P=f]FJaDRV]]dS=F=^I,4Y;GZD/5bd-1ceJXJW_R45WGaFSNZKD?^&F
.a6::[TdCHG06B7Yg)75&I#0YKLW&@)&7?-eW848#02\8]1#L1cD]1YaF47bJ/+U
/BBQGR_3+^TKH^6@7:+:>4B81VHXeCHWK\LS,bQAJ\UVG;.W&,Z3TXO<RF+=^-/)
1@9,@)=PN0^8XK2a??VB-0Q6GL\4?)>7XD[)R?KD7]=TXCS:+TZ;]faKgJ&+YXF+
;W:2b:+IM_:W)_@Y_/0MV7B+A5JJH(BHFG&P_6?.+(U^J/aV6=P[/O/;5MWH8/5d
5W]863W.([5ZgSC>E/74L]8#@TNeF3QbS@/48[,2\=T()1c4M:C_7.?+NSb6R/[c
0^R>5V2dXN_CFN,cPYb&b]ICHVE?IGR4SH[C,?RG_C/=P.\GIK.0IGY6Q,)YTJGZ
4B4(/T899d34(K4#U:-NW&^:TR11-2L15a0IeA+-T3B&/6PBGQ\F,Y-_b+g@HMgS
>./.R3:,WLJ&TIdM9?TGY>?V#T1@;U^Pf7?(Y]CIRe@DF,CbC3-,3DbV:@C9)e]=
E<NW1EJV\>If6)0,df0d>Y.J(,P8[c-E_V/4KZ=3RaQ+RgNP6C[OQ+cDbKGC<eT)
(AS-g+IS(-)8?UR4XW@Y(2d?Df6NY:([PSTAD&U#/.3g@=\?NOA3C(MKGOIV3V6I
QPJ>NBD@?P,KA_R@2RV/,RQWgY(,.S@G=Z282O0L1ZWSD7?,ZIC#VTA;<37<TX2&
56EbU@<@<[D;;GaSLaO3AK66HQJ41FYf2P<>Ic3?bR1Aa/0ELG-=]+-VPDR<H7Af
A;-R4<_EWZ?(d8d=E&a&6A_Mc;6f0S130;c\<B4SNA/Z11(+c@?@5MP#=F?FK2Q=
^aWF4B??0(g[20Q(?3LcWT-J(0FDRN:ID(dYW@]ZY:P@H<=[C(20U?6fB[S@c>71
3;E&6@<.P5PRFL:cK#<bE0gdYBVfRU@Bbc7\_W6OR?,7>:gRaE=Vb4cBXZF:</;_
N5:)#4X.YV;CO\O7c.[dQ_eEb?/Q7RES5cN?6+&(#8QHVG/2\.L-:a5_LeTNGB\c
:P-T<K=TYA@@]Q.OR>:M]a>WaZF1]ZR+BcW4)VQI:<U2EcYKWH2B:(2Z+T@^cJD<
@F8Kd48[3fZ9:QQ&&YTEIKOZB@#SH4.bBOH@B/cA3ObOI5W&g0K]A09--?;OKQ1X
90@NGHDC&;)^LOCbH;ITTaLZ2VVUU>#T0Y59KI)E/^<1_N2Lb=a,gc,/_BD;5N&a
T#;3D,&RLZA/#[D,WT2D#WX)F&=@67ZAA.J#[XVEBAF/UGY5-,IQ58)RaWc)+0]:
AY^\E-KYXb/4]>TMR[UB.4)2Jf/2=^=H5BJ]N/O+E<YOXB]R(gG#<@L#PWT1S)dU
-X78_R#T;+?\KA9O(_;2c624YI0;HB>d+P-S4.7P[ZEQS;\Tc.DI(AD/_^OE^.]8
WM#8\X^^P<RLHM^g5<^a.0^WL+TV5&ZUCc=O[.E62&D>eF9P[3)VEP=1]HWSXU:6
&(a^O06KQAC2)M-RfeVNIfJK0RLA+]+#>-(N/G4=W.7JCX(;]U+O@XA\AZZNW\5,
/PdM\^?FBNKJbEdX8+L/A:@U,fg)e_\6g7O_>[NDO5W?IMJfG)=]NSXM^J?4:):+
B33YK/LZL:L,=bS>89C5V,\AV/:P/N90c[;&c]FaN,JKZ_;TaEe^QRQd[M_:O:<N
]U2675dHJNM@R-F>KC&M<D90<]NSXERMA)Uf46EHAfF,=;T?10YV/D-,,F1<KZ&E
A#QM7NS][Ag_PEC#PL:g@_2J@I(O5R.57<G+?9W2UN0#REGMK@)./&7NfODgXW;g
?Y5BE5E-,ce8WZ?H-:cM[/bA7^_+@8XX:Gce]@HCSWTWV#QDS,62:X4F<>Y.g]bR
BGY7bPL1]&H#+0&8=>B\fOY,-LJR8&P#09EZ<WQda=]/UNY;V_=DaWR>P#QINZ7U
-9Qb6-33>W4aI\/TSYW6@PKZScU=1<7(\>\fc_5W3SD.M;8&2VEbdJ:)GW<S[L><
<MKJ3XS#6BN^++c^Bb>CJ7<:CNM9-3UD;N++Y\c/>-+K@T_=3C,T]X>HL(WdK6JO
9YZLPYb&IC,^[O)VK-eX23cP7LNafR@BD<:H<@B5=^-@1ZBZc?FZFFLKMF-Ec5\A
OZ+[EY60^BXB,E:JRdM48-AabV7aa#eZ@IF\^C(^,1I;f>[:9N-[4E0P-LJd-J;H
+g4f4fdMH3=3T2Mc@2M+P,e82_U9(e+(.&7=CL,HSD9H8g]O2?D5QQDZ^KEfBOR^
bE/<\/M.]1.MVD[^5[9^I=^(^BbS+=79E:S<2KMJ[=OFVQgIF4&,9K1G=H.N&1@^
V>d6I&cU/W-_LZCQ7fbU_X;WT.aEg_cCJC#D7X^LCR5#U-^.6d[>8^AJB/c<IW)X
K7=adX,SP,(RJ7A8+LFbRaKZ>NC3PJWM5N?;Uf6_+<SR>FQ=g6]9Nb5O[cKIc9]R
/+4LL2@cG=S,f[;d]6PJ_H3K-<BSc>=+e4P>(NHLgK#JYCAK@#5>He)7D+,2W:=H
@7/PH@N4+SSK#d&_EaVO&.V7.Y])CYQ<NY95G,FA((80f\VJYJ5Q4=UJ^8Y0EgFA
/U5H<PPGF1Y_cG_4QFW2K6\_d#ZcS=_CR4=RH\E]]4XQY#K](a./2N]:CMBB;LD9
/\2-P5>T#fYU#[7ff[7\AY#J=W-S3LOR2>c::]Og,92NRI(@8=9=BV)=3a3f4?;@
5cRfP)7+F>YKQP7JL@7;;g^WU>8&EM.J-9NA&AGN=VA)RL&:E+8af.Q;7HCbO0f4
09XN<3TL[OXR_:IDN0^W^B]W/^7cPa]P^(08-?Va1;:RVd38.;.CA68>/Z+Q/(,T
Y)Eg3\J:7BFR>[.XM;bF2U:@]<F-=[T8OBGHV7^;--D/bJPI#F(,6YSC6ZFg.H&?
KGP(5CZ;@(,?c3&\2WIN--_&@,1Z:LKT^Q;GTKd/YeO?]]OX_J<SBZ^CH)1R7]cH
[]_7UF_BB70D\R>HSJ[>WZG_--=/5aTJ]P[#RXa+-1VZUE\C#>[gZTKW<+M;4KgX
e<ZW[1d;ZSP_S3NEP4/-.HCJY,)\Q>.XWU<N7^7(=0ea3U(2.5]Y4J23Pd.[0>.2
D(SD1_<G;X6#c:DWDG>0I/Oe[f4<adW4C:cgW:EF2J\@^(969^+O:4OZ5Tc2XMRY
.64.ReT9+/-edG(7X4R+O>1JU1gW>a1g#CcI1+Ef]&GR,PYP>H:PbA073J9ZZPd\
&M,^I4AfY8BJaI=-E@\Z4AYWF5LJG3MYV=_RgbC0)3I/PgNFZS+ZLe@>[1cdE^PS
A87#:FUE^HX4g&\:K:7(\W2G6dNFO]ZT&T-c7Y0H0VAYRL>9:bd4J1D-MbBP&KbJ
HK-THbSHMgfAL>R5SBQNQ[7RMS&M[,&O1A=5F<GJ-2fHU^6ZD1PN2+W9aS,\B_13
Hg/BQ;0>MJ5_aC?f8F37.W;NSaXS[?C\9^WeO+[=].[)]g73V]CfAL8F]_D&))\R
@6;C2:YAYfT+.#8a;P(HNG=7/43UbD8MeEL=\\S-]:b:X=8[d^]a17dGgCJ/(GL.
X3MF.+EaQD4#GT7K>KfB,,\)S^F)#;>J,1L&O@44V]=^/[3VWaYLQ=5D^=QQ55J0
XE0)6(H]caBa?5BAEP#BIP\?>0BeM1><DX2XJU4HO]4YWeD?aT4a88b2HAQS><2P
BBDOWf2_J]NR&923d/I7E]C<.3?3dF7,P(+:P4?2FeZ62&cf?VY]^d=VDUH5T97Q
1HS^eUMPBdH<g=<g11SI35V;?^g4#.PW>;PIGaa^6]b24)Aa\SR/2EUL0IW\V118
Mg]0g]M,)4F_^Z[?G<_MCRAa-b\SF7HTGE63VUdeK,U0LGWS+SPe8-5J[H5X)a>6
NWb>-]065de:MHI^F_3L4B;&^]1Ke3T7M9_IJ8\Dd3E[[+GAVG(g#aY(_:4;^I<d
GZ]K6b?;LF0JUXFN)-0]46C<(A,CLL7?^W.L&BdAdfI7<FH:@MSHfU3I.d>]<A[1
7QZT_<MUb);6,.eI.OZ@b^E17QJ)#GRDK-Y[ME:G):?/#)Y.#XN4YBfX?C_GY46I
A=2P1=dR[]@HAc;G4Zd.b+,6X5QagW8WP/2/B+E6f(7K2a9@#1W<+^RD4JUU#9KO
L4g8X(c6G)29^+IT:=HYYXLVd;dcE/0I@A8+V)Ne(M3bHXB,+73?7)-4ebF,IfZ_
@W4>.BR^#aI@V(:La0?/FRA.eRM&&/VeC)=cZNNZ@e&KU9Z#HOf,+_B,McGL>O-3
GEKN@_^0^0^fceF:1f@@0#_-CBL^;.&3Pg4=CbE+e2d6,IJ[/H_6fT:dX&9\\fR/
abXWBAJ#_@2TY?DT(R437L(^6G5I<O9V]Cf8XU/0/0>V0-Q3EWW)^]L9^CM-^<;@
6g<\X54A3&g@J4eNf#)B1)+O[;VY-P_GgSNXFWMY#^(UVP&1Kd^XA_D_GB.4QL9N
XY9bfFNfaU1[gdHPe3G6HV2dMTL3c=QHaK4D@TB2R?>2@g6RH2<+K&:33\fFZ]7-
G=UAI^N=QN[-d(e^8D?c25)\5VQR+fFH/MZ@DU6B8-a:1=1-^8,T-BGIC@e]4&[>
.FH)+7dZXbTE<]]O/ZRNRJU2&YFDZ1fdG>&;KIfJM<SM&G)Ifb#40g:T53YYHDbZ
)Aa#aY\QWb57W<8OR.V35(#77bH@acNPP,3+(+RV&FP-0^\>8VS][ILFbH)#7TOa
(]0CIf[e?2B7+$
`endprotected


`endif // GUARD_SVT_VIP_WRITER_SV


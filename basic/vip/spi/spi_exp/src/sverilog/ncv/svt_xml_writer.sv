//=======================================================================
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
//
//-----------------------------------------------------------------------

`ifndef GUARD_SVT_XML_WRITER_SV
`define GUARD_SVT_XML_WRITER_SV

`ifndef SVT_VMM_TECHNOLOGY
typedef class svt_non_abstract_report_object;
`endif

/** @cond SV_ONLY */
// =============================================================================
/**
 * Class which can be used to open and manage the interaction with an XML file
 * for use with the Protocol Analyzer.
 */
class svt_xml_writer;

  // ****************************************************************************
  // GeneralTypes
  // ****************************************************************************

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  // ****************************************************************************
  // Public Data
  // ****************************************************************************
  
  typedef enum {
    FSDB = `SVT_WRITER_FORMAT_FSDB,
    FSDB_PERF_ANALYSIS = `SVT_WRITER_FORMAT_FSDB_PERF_ANALYSIS,
    XML  = `SVT_WRITER_FORMAT_XML,
    BOTH = `SVT_WRITER_FORMAT_XML_N_FSDB
  } format_type_enum;

`ifdef SVT_VMM_TECHNOLOGY
  /** Built-in shared log instance that will be used by the XML writer instance. */
  vmm_log log;
`else
  /** Built-in shared reporter instance that will be used by the XML writer instance. */
  `SVT_XVM(report_object) reporter;
`endif

  // ****************************************************************************
  // Protected Data
  // ****************************************************************************

  /** VIP Writer instance to create FSDB or XML */
  protected svt_vip_writer vip_writer;   

  /** Handle to the file that is being written to. */
  protected int file;

  /** Flag to indicate whether we have executed the 'begin' for the xml. */
  protected bit begin_pa_xml_done = 0;

  /** Flag to indicate whether we have executed the 'begin' for the xml. */
  protected bit end_pa_xml_done = 0;

  /** Additional controls that clients can register and access during generation. */
  protected int client_control[string];

  /** Holds the uid for the current object.
   * Added to support backward compatibility.
   */
  string object_uid;

  /**
   * Register active writer when created, the string value is the 
   * component the writer is associated.
   */
  static svt_xml_writer active_writers[string];

  /**
   * Register active configuration, provides a way to cache cfg handles when the request 
   * to save a cfg occurs before the creation of the writer. The writer creation then accesses 
   * this cache to obtain a handle to the cfg and insure it is written into XML/FSDB.
   */
  static `SVT_DATA_TYPE active_cfgs[string];

  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_xml_writer class.
   *
   * @param prot_name The protocol associated with the object.  
   * @param inst_name The instance identifier for the object initiating the write.
   * @param version The version for the object, typically the suite version.
   * @param file_ext Optional file extension.  Only required for suites that support
   * PA with multiple sub-protocols.
   * @param suite_name Optional string associated with suite name of the protocol. For
   * suites with multiple sub protocol this value indentifies the suite_name for the
   * protocol. For single suite protocol this field should be empty.
   * For example in case of ddr family of protocol where the protocol name is ddr3_svt
   * the suite_name field value should carry "ddr_svt" and the prot_name filed value
   * should be ddr3_svt.
   * @param format_type Optional file dump format. 'FSDB' (the default) writes out data
   * in FSDB format, 'FSDB_PERF_ANALYSIS' writes out data in FSDB format optimized for
   * Performance Analyzer, 'XML' writes out data in XML format, 'BOTH' writes out data
   * in both XML and FSDB format.
   */
  extern function new(string prot_name, string inst_name, string version = "", string file_ext = "", string suite_name = "", format_type_enum format_type = FSDB);

  // ****************************************************************************
  // Access Methods
  // ****************************************************************************

  // ---------------------------------------------------------------------------
  /** Get a handle to the file that is being written to. */
  extern function int get_file();

  // ---------------------------------------------------------------------------
  /**
   * Registers a client control with the XML writer.
   *
   * @param name The control being registered.
   * @param value The value being registered with the control. Must be >= 0.
   */
  extern function void register_client_control(string name, int value);

  // ---------------------------------------------------------------------------
  /**
   * Retrieves a client control value from the XML writer.
   *
   * @param name The control being retrieved.
   * @return The value associated with the control. If control not found, returns -1.
   */
  extern function int get_client_control(string name);

  // ****************************************************************************
  // Protocol Analyzer Utility Methods
  // ****************************************************************************

  // ---------------------------------------------------------------------------
  /**
   * This method opens the file and writes out the XML header.
   *
   * @param prot_name The protocol associated with the object.
   * @param inst_name The instance identifier for the object initiating the write.
   * @param version The version for the object, typically the suite version.
   *
   * @return Indicates success (1) or failure (0) of the request.
   */
  extern virtual function bit begin_pa_xml(string prot_name, string inst_name, string version = "");

  // ---------------------------------------------------------------------------
  /**
   * This method writes out the XML trailer and closes the file.
   *
   * @return Indicates success (1) or failure (0) of the request.
   */
  extern virtual function bit end_pa_xml();
 
  // ---------------------------------------------------------------------------
  /**
   * This method writes the XML header to the file.
   *
   * @param block_name The name of the block being opened.
   * @param block_text Text to be inserted as part of the block 'open' statement.
   * @param prefix String to be placed at the beginning of the output.
   *
   * @return Indicates success (1) or failure (0) of the write.
   */
  extern virtual function bit write_pa_block_open(string block_name, string block_text = "", string prefix = "");

  // ---------------------------------------------------------------------------
  /**
   * This method writes the XML trailer to the indicated XML file.
   *
   * @param block_name The name of the block being closed.
   * @param prefix String to be placed at the beginning of the output.
   *
   * @return Indicates success (1) or failure (0) of the write.
   */
  extern virtual function bit write_pa_block_close(string block_name, string prefix = "");

  // ---------------------------------------------------------------------------
  /**
   * This method writes the object begin information to the file.
   *
   * @param object_type The object type.
   * @param object_uid The unique indentification value required for relationship handling.
   * @param parent_object_uid The parent unique indentification value required for parent child relation.
   * @param channel The channel of object. 
   * @param start_time The start time of the object.
   * @param end_time The end time of the object. Added to support backward compatibility. 
   * @param status The object status.
   * @param time_unit The time unit used during the simulation.
   *
   * @return Indicates success (1) or failure (0) of the write.
   */
  extern virtual function bit write_pa_object_begin( string object_type, string object_uid, string parent_object_uid, string channel, realtime start_time, realtime end_time, string status, string time_unit = "" );

  // ---------------------------------------------------------------------------
  /**
   * This method writes the object end information to the file.
   *
   * @param object_uid The unique identification value of the object.
   *
   * @return Indicates success (1) or failure (0) of the write.
   */
  extern virtual function bit write_pa_object_close(string object_uid);

  // ---------------------------------------------------------------------------
  /**
   * This method writes child references to the file.
   *
   * @param object_uid The current object uid.
   * @param child_object_uid Child object uid.
   *
   * @return Indicates success (1) or failure (0) of the write.
   */
  extern virtual function bit write_pa_child_reference(string object_uid, string child_object_uid);

  // ---------------------------------------------------------------------------
  /**
   * This method writes a one field record out to the indicated XML file.
   *
   * @param record_name The name given to the record.
   * @param field_name The name of the one field in the record.
   * @param field_value The value of the one field of the record.
   * @param prefix String to be placed at the beginning of the output.
   *
   * @return Indicates success (1) or failure (0) of the write.
   */
  extern virtual function bit write_pa_one_field_record(string record_name, string field_name, string field_value, string prefix);

  // ---------------------------------------------------------------------------
  /**
   * This method calls the 'svt_vip_writer' API to add the interface path into FSDB.
   *
   * @param if_paths String array contains all the interface path.
   *
   */
  extern function void add_if_paths(string if_paths[]);

  // ---------------------------------------------------------------------------
  /**
   * This method writes a name/value pair to the indicated XML file.
   * This method is added to set the filed name and field value to the
   * current object to be written to XML. This method is used only for backward
   * compatibility where some clients directly called the field value writing.
   * This methods needs to be removed once all the clients moved to new writer methods.
   *
   * @param name Name to be saved for the property.
   * @param value Value to be saved for the property.
   * @param prefix String to be placed at the beginning of the output.
   *
   * @return Indicates success (1) or failure (0) of the write.
   */
  extern virtual function bit write_pa_name_value(string name, string value, string prefix = "");

  // ---------------------------------------------------------------------------
  /**
   * This method writes field name/value pair to XML/FSDB, the value will always be in bit vector
   * converted to right data type and written out to XML/FSDB accordingly.
   *
   * @param object_uid The unique identification of the object.
   * @param name The name of the field to be written out.
   * @param value The value to be written out.
   * @param expected_value The expected value of the field
   * @param typ The data type of the field value
   * @param is_expected The bit indicates expected value is present or not
   * @param bit_width Width of the field, in bits. Only applicable to fields with
   *        typ svt_pattern_data::BITVEC. 0 indicates "not set".
   *
   * @return Indicates success (1) or failure (0) of the write.
   */
  extern virtual function bit write_pa_field_name_value(string object_uid, string name, bit [1023:0] value, bit [1023:0] expected_value, input svt_pattern_data::type_enum typ, bit is_expected=0, int unsigned bit_width = 0);

  // ---------------------------------------------------------------------------
  /**
   * This method writes field name and an a string representation of associated value to the indicated XML/FSDB file.
   *
   * @param object_uid Unique id of the object for which the name value to be written.
   * @param name Name of the filed.
   * @param arr_val The filed value.
   * @param arr_exp_val The expected value of the field.
   * @param is_expected The bit indicates expected value present or not.
   * @param prefix The prefix to be written in the begining
   *
   * @return Indicates success (1) or failure (0) of the write.
   */
  extern virtual function bit write_pa_field_name_string_value(string object_uid, string name, string arr_val, string arr_exp_val, bit is_expected=0, string prefix);

  // --------------------------------------------------------------------------------
  /**
   * This method is added to retrieve the uid from the PA XML header string.
   * This should be used only for backward compatibility and not to be used by any 
   * new VIPs adding PA support or any update made by the existing VIPs.
   *
   * @param object_block_desc PA XML header block.
   *
   * @return The string which is unique ID of the object.
   */  
  extern local function string get_uid_from_object_block_desc(string object_block_desc);

  // ---------------------------------------------------------------------------
  /**
   * This method writes object begin block to XML file.
   * This method is added only to support backward compatibility for existing
   * VIPs, shouldn't be used by any new VIPs tor existing VIPs updatingPA XML support.
   *
   * @param object_uid Unique id of the object for which the name value to be written.
   * @param object_block_desc String holds the PA object begin XML data.
   *
   * @return Indicates success (1) or failure (0) of the write.
   */
  extern virtual function bit write_pa_object_begin_block(string object_uid, string object_block_desc);

  // ---------------------------------------------------------------------------
  /**
   * This method writes a comment to the indicated XML file.
   * This method is deprecated shouldn't be used in new implementation.
   * Added to support backward compatibiltiy.
   *
   * @param comment Comment to be saved to the file.
   * @param prefix String to be placed at the beginning of the output.
   *
   * @return Indicates success (1) or failure (0) of the write.
   */
  extern virtual function bit write_pa_comment(string comment, string prefix = "");

  // ---------------------------------------------------------------------------
  /**
   * Utility function for getting the #begin_pa_xml_done value.
   *
   * @return Indicates current #begin_pa_xml_done value.
   */
  extern function bit get_begin_pa_xml_done();

  // ---------------------------------------------------------------------------
  /**
   * Utility function for getting the #end_pa_xml_done value.
   *
   * @return Indicates current #end_pa_xml_done value.
   */
  extern function bit get_end_pa_xml_done();

  // ----------------------------------------------------------------------------
  /**
   * This is a wrapper API provided for clients to capture the predecessor object 
   * information inside XML/FSDB.
   *
   * This method calls the 'svt_vip_writer' method to write out the predecessor data 
   * to indicated XML/FSDB. 
   *
   * @param object_uid
   *          The uid of the object whose predecessor object is to be specified.
   * @param predecessor_object_uid
   *          The uid of the predecessor object.
   * @param predecessor_writer
   *          The "svt_xml_writer" instance with which the predecessor object is
   *          associated or null for the current writer.
   * @return The status of the operation; 1 = success, 0 = failure.
   */
  extern virtual function bit set_object_predecessor( string object_uid,
                                                      string predecessor_object_uid, 
                                                      svt_xml_writer predecessor_writer = null );


  // ----------------------------------------------------------------------------
  /** 
   * This is a wrapper API provided for clients to capture the successor object 
   * information inside XML/FSDB.
   *
   * This method calls the 'svt_vip_writer' method to write out the successor data 
   * to indicated XML/FSDB. 
   *
   * @param object_uid
   *          The uid of the object to which a successor object is to be added.
   * @param successor_object_uid
   *          The uid of the successor object.
   * @param successor_writer
   *          The "svt_xml_writer" writer with which the successor object is
   *          associated or null for the current writer.
   * @return The status of the operation; 1 = success, 0 = failure.
   */
  extern virtual function bit add_object_successor( string object_uid,
                                                    string successor_object_uid,
                                                    svt_xml_writer successor_writer = null );

  // ----------------------------------------------------------------------------
  /** 
   * This is a wrapper API provided for clients to capture the set of successor object's
   * information inside XML/FSDB.
   *
   * This method calls the 'svt_vip_writer' method to write out the set of successor data 
   * to indicated XML/FSDB.
   * @param object_uid
   *          The uid of the object to which a successor objects are to be added.
   * @param successor_object_uids
   *          The uids of the successor objects.
   * @param successor_writer
   *          The "svt_xml_writer" writer with which the successor object is
   *          associated or null for the current writer.
   * @return The status of the operation; 1 = success, 0 = failure.
   */
  extern virtual function bit add_object_successors( string object_uid,
                                                     string successor_object_uids[], 
                                                     svt_xml_writer successor_writer = null );

 // ----------------------------------------------------------------------------
  /**
   * This is a wrapper API provided for clients to capture the custom object 
   * relation inside FSDB.
   *
   * This method calls the 'svt_vip_writer' method to write out the identical relation 
   * into indicated FSDB. 
   *
   * @param source_object_uid
   *          The uid of the object whose custom relation object is to be specified.
   * @param target_object_uid
   *          The uid of the custom relation object.
   * @param relation_type
   *          The custom relation type which needs to associated, eg: if the two transactions
   *          are identical then the relation type value should 'identical'.
   * @param target_writer
   *          The "svt_xml_writer" instance with which the identical object is
   *          associated or null for the current writer.
   * @return The status of the operation; 1 = success, 0 = failure.
   */
  extern virtual function bit set_custom_relation( string source_object_uid,
                                                      string target_object_uid,
                                                      string relation_type, 
                                                      svt_xml_writer target_writer = null );

// ----------------------------------------------------------------------------
  /**
   * This is a wrapper API provided for clients to capture the custom object 
   * relation inside FSDB.
   *
   * This method calls the 'svt_vip_writer' method to write out the identical relation 
   * into indicated FSDB. 
   *
   * @param source_object_uid
   *          The uid of the object whose custom relation object is to be specified.
   * @param target_object_uids
   *          Set of uids of the custom relation objects.
   * @param relation_type
   *          The custom relation type which needs to associated, eg: if the two transactions
   *          are identical then the relation type value should 'identical'.
   * @param target_writer
   *          The "svt_xml_writer" instance with which the identical object is
   *          associated or null for the current writer.
   * @return The status of the operation; 1 = success, 0 = failure.
   */
  extern virtual function bit set_custom_relations( string source_object_uid,
                                                       string target_object_uids[],
                                                       string relation_type, 
                                                       svt_xml_writer target_writer = null );


  // ----------------------------------------------------------------------------
  /** 
   * Retrive 'writer' instance for the given full hierarchical name. If the writer not found for
   * given full hierarchical name try if any 'writer' associated for 'parent hierarchical name', 
   * if found retrive writer and register 'parent' writer to given full hierarchical name 
   * to enahance performance for subsequent retrivals.
   *
   * @param inst_name
   *          The full hierarchical name for the required 'writer'.
   * @return The associated writer, if writer not found returns null.
   */
  extern function svt_xml_writer get_active_writer( string inst_name );

  // ----------------------------------------------------------------------------
  /**
   * Method used to get the format type of the writer.
   *
   * @return The format type associated with the writer.
   */ 
  extern function format_type_enum get_format_type();
  
  // ----------------------------------------------------------------------------
  /**
   * Utility function used to add a scope attribute.
   * 
   * @param attr_name The name of the attribute to be added.
   * @param attr_value The value associated with the attribute
   * @param scope_name The name of the stream for which the attribute needs to be added.
   *                    If the stream name is empty then the scope attribute will be added to the 
   *                    'parent' scope. The defalut stream name will be empty.
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
  extern function bit add_stream_attribute(string attr_name, string attr_value);

endclass
/** @endcond */

// =============================================================================

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
fYVohv8HWGlA8cTn/QhYQ+7FXlMK6njs6MwExQPJyfDRdGH5MJ6DvEoEN25f+Xo4
H+FwH1tHEgX+5kTFFwyhrMXZl2Ieyk+RVJrlYOuOD8VXo1QIbGJg4zJHMCLk5xjf
yhqvI7c0CXaU5srD3kQ7tuCKtoCjglfIu/O28nY+FSG0KgdD8Invug==
//pragma protect end_key_block
//pragma protect digest_block
keuoKjIbST/4Cbh8uPt+5q/e0lY=
//pragma protect end_digest_block
//pragma protect data_block
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
SbqIkVqAaoqtc1Clm9RfVw==
//pragma protect end_data_block
//pragma protect digest_block
2Ep69WA8I/ghoDa4OlJ0Pnon4AE=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_XML_WRITER_SV





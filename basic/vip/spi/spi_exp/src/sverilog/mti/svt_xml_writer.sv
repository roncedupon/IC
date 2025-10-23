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

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
RiPffziQiJsLbuBkeyt0V9oLC/mgbKqgmNwrUnCDdr30fNOpvsE7IY6OV/HPra4g
2NmKDyj2P/nxWmFHiOfap6MX2ISr8zVP+vPzwEj9/Dx18fKoUALFFIH/beBU3s93
4NBMKoWUIaJPd3zyqf/rpzV3HotxI+o5dUgxKcJmvsg=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 16888     )
8HjajYHrmwZmxUg+TNWpWMfuPh6QtUkjzA55jvtSDRA2X8CSjYjeJiFfnMxkWn76
GH/twq9TCGjIisDqkrZc6mo5L4NybsnNy2CXkcmVNMtrsh53OJNmPS2uNX77oUIM
tqglB/8uBw7Uec0WaXCsLMujLnzcATVnCVlnvo85ngJuOlYflqEGrktWRQMKQUtk
mSNLGPZ+63TYPlEuNXgFFSxpq9HY7Q08KTUrmML4oW2jDHYVn/yAutXwoRuEHGZN
w6tefNEe0yqn19UkppfS5VRVjVtesADDPPYjzGmDjaVGrqczB1BiC7t6nnAfoNGl
r4OZLbviJRZCjm5R8dtztGYfprPaCG1nSqjdT1WT43/CCpq6AtyN+S8OlBPUnc7Y
5KeHF6Yzr8savheLmaSyug9juaCtyRzbOr0HHLc5jvxxJxa4I6TDW4vG4FB2wrz4
NxEuPyQsjAabWLYBfafZwL1/MHlyhZQoE4wFg8N3ieviJ8KRE0vWYywKyPXrwLNF
MS42/kyT/QX45GAdwVT0kl4U6qEuKsZ6RvtQlP9Fk33TC3j/sQPXwvJGmzi+u4At
rwP+eeUrWSe98bAVcbuXvjZebqgkYh3HSgVbQlO8ft+lsfjIH98sGxXGl529YjRO
vIEwvXoRFoPq0lQLAVH0I3Fokuxzc8Jq1+d+1RHihzi3VwpNsf/2Q2aU28K3mWof
udYkWKg8Wo+vEfcLD/32Zcl5fFHzRxrQwVI+RLCuQGcKuNZxEYo7XWTY0XpxGhaH
GtTuyMD63E1qgB3jKIGjvqCNPt1No7ZVQFHKOaM9RtwGybXBtadYBZm/eBrjT3rd
Rb26vkLisSLAgbw0cVVNtXLXFXCj9TmgCA9LzxGNMURUVyYSP4u9P0VKUUgm6C0S
6bVjRq73fpjPpdZIYW8D0EfoS95SoncPUIDtGQ/F417b+ofX/3sMYvzeqESDPaRY
YrowL0nvmdaXcbfPz6ucgSfqR5ZJpY+KFDUYpRcJqP4IIAXvHkssOfibII6g/Z90
NQ9X5IJCjFbw4zX4U/qqD3CCLM+NDd4Orryq8Px2pVgPxNWP+BtFnl8fiSt7UdR/
TLjeJch/fMNwogCzoiiKgWmXlY2PAvxpsf026r5TU3g+TiWHbcj8y4IBKr1ewCUl
+1w2SXUoLt2H0/7zhhokz1i6ynqIe7YHLPM0OK3CwqbgtsK83pjNGHzk29+pbu3C
Mdye0xVXLianTURbhHtyfsrwFZcaECv2c1trs2vBKsiqiqR6QhDv6z3yYKzXy8Bk
iw+f3+7fPgoSHVLxjkzuS3Fz0x2/+W5VAIa4r0JstqsuO6AQpwCBtNWwtqLOrs5b
TOGKKadUoVgsQ6gTcPFdTQiIGKYGAG6RVnlVHE6eYcC0tWBoW9S1JJzceZXsRaR+
KQXLL4Hn8RFJxvJPrPSe3mLZYVnACZr4uQ081pz+tI9eEX7OzYD/9JjNWpz6cWNS
fLeZa9j3Zk9anEcrjjv4DX3kolKzOdOaFsHtoyrRVv/xQm3AHgDkKB7RSE9AJv3d
07PNUcqDg5PfCqTLq7ovPnTvC0eNFGs2Z5Fo1r0jQhk0KKQZYoik3ZJNMMD1i5OM
AqP2oCZlgszoo7iXxBaDhwmCB+l+xBAaFbCRPZIjsCJPeRrVapY9uBwg8MvKmtUC
KqSRu8EQKVg/1tTpzNJGt1BBCLUs8l51YEBTgBmhJgsWuiA9DubCX+6PedGl+RXn
5YNyRQ7UhNIBjPd+ssD04a4AXPoyZRt+v2UbZ0mO+X0rbrvMZ2DCi5GhbauNOpsg
CTknfhpvfqBMTSRdYbl4LExdFzzYAnVPE74W8NnydohCN0ZeLMfBDBdY2IPs/7FM
ZOKbiVH/MxNQZDo/Z73qTAmty3GI0D6DjW5MDdAEQyn/lk3rXpfU9RwUHLh0ljN/
o9wUj161JDFXo3qZh0+JUY7sbA23Ddk/350uq8SCGTz5Ef+0kO/hc+S+FJDC1a5f
etLGtxtJiXghGIFPb2cS5XkgNXATVJaICVSRol8092dQWA2ePNAlP8ASD4vKVdud
D6v3KHxSeZW9FvTXRirA2Ub9BG0AL/QHW36TG1qqD0GmRovI5/KJJDvLj6EY2OPn
f6osLa4/sjVisGaxGbIcwhtYgRqkDCFNIYhvit7RJtur8MdgAkqIpn50KKmDSXFD
A4URU5qPz1ZgY7W7iKwJvPICFvEdIPESgKEenzQF6EQ0au9jyx9H0EHJqTAb6ky3
xE3djN0Qc0v8s3PDWp4RWKWNSMRMgvQnr8XldJCK4MyGapfMgb65zTV6ASSbmU3n
n/GIw688WlMPT1KIZ32efROWK9TxhCrxCIm5qfXwqasXaCPnUu7o9Yo8LwuW1G4n
uVsuSQf2cKdnuuEGq/PU4Sfdf2qGN26KQTIvt4yCwHWZd28ywSD3+nEwHNOwr0hR
akXu/vMtDTLzNjkEg1Ff+bfoUyr7QEpJ3Wbbi2u2tnUhkPcUJhqfOrG1sDWC5OOo
Mmo1H08uNaBU5pU/rD3x8F0QyW0vPcHQkXMmwHh7QbTltyH0fcu3i3HMkiRucAga
NA3GpxdMpyNDQRdKgWFwCXCC2uI+8sF6wH0vRL/HcF8Q0pxTsUJ+9O2/ivrE45LG
zfMYBiW1RIEzKTy7lTK4uybKFYUNoi8fyXxoX+6A1lQaE9R9deaBjuwcQ3yJoIy8
VjpG8wAk9ca5w1Gy14/2iv59oMz0OM7crxssKd5JrUUBs9tUXrW1NZYbyOpc5VVt
a8zWRKEZK/FpEjnS6iThpdv8mJjfS1SRaGIzWF5rnaMhcfodLvGo3ijwpVxlzoj6
vN6Ws53fcCEo/P92c2Z1bGpxnSQam5lgw7NGOV6PXBGafp5U8WXGz1VgWTx07oLL
cBApruucY+9vOFjq+pC7uPQ90hv4KjxPlBTrJdOHpS5Y9ABmYVQuQJlWK+r80FxD
82+lzQSjXcY1fS3j6gbztFVa44yQv0oSYpm1pMbvGRRWhnFYV5dXINbdTSc5B0gC
bqppDrUIVtoJUOZBM6eoIrI4T0+P7WLPx1PqyDDyXsOavX+hTzfhZijETCs0PBoz
T9KrpQiiFS2yZYwNjJkOqj1BQ91Gy1UFhtwGw3177/utJ7VsEGdmxA/rsQA5uny1
h0XaZecuHrjPCgb55DoMvTYo1R5Eno1taY4IA6BDZmLfdDXq6mJJpAGgZ1A7CAfM
MicmnZLo1Di7+1vW4rC3us5wTynqVH2MHygcI+Ju1u9auFBuSLtRNFjYYSr7UbOd
yufHOItnGpw2ydE2ilYkVZr3SDV7RVNwXWvI2+deHuWQeZCNetb2AO1cfo19ECbb
85CDEzndu+Ei9t77u/vS8zty7kNb7Ug2Om9GeRdUwsxjr2zm3b4TIJDaBCFVKYYZ
VkQO7ihP7wHwgVVtOsgdNFOxYCpo1SVN9SNzDXRDD113NQKWh0APjYNA14aYG4Bi
7AFN3gXYnpBSX/UqYNleom7nS8Q92+DC+KglgFNYxw4CykpgYrVaOis/vEr+fm6m
xryusW6zfSGFp+12tkVpmbFNMmV+b76W4rhg/1bpjuBxwXqk+GY03gId8dYw1zMm
N+tmBLLUTsg8YyiMoXRjw9ty52fBJaiU48TPSdGasN0Mc7JrMUMtgH8sGy6pJczL
w3tn1m6TZawOs0Gf1Qx7iTBLS3mif4zlDQOxKCWbmJY05gxpXZwBxBrPpn27pK0R
gyhe0EFP/dao5a0PMFHjRue3gaMDu828Scfrf1s3bNpKbxQg7dVDDS5/aF3FQhZL
ccGxPWOStEFxdp1AgJtCLnom/A2Yexaua3PPhIhNhPyaXaC5LTyY3XWHB/EJ9kuj
kNPRLjPUbuaNIMkYizpdsTW5kFPY6G1VQDjXFMQGcvB1VdT/EzuCjgdz2873hzk8
gGclfk9ahkPyG/K0xv1Ed0xBitdkHAcnyT2QjD9a6kP7EdoQRs87yJe3XggR12x7
7/QglvEtie2FzQCIp+VSGG02FBNyJl612dh7B86p+/Scqh94DsV9XbUG5TPbWQ/5
N5lt6CDo+sDx6tqKkrhsuLQkwNL+XGWLQYU24tKkTmyOlXL4s37SAtuTxD4C9P28
klm0CamWhJC68WNrY9Hzg4bvmPIqDtDYqwOGe1695IUQePNGWvfp3pbKfd4hfHsr
Fp6r2V9EyiB+2XaE3AlP4UoCJtS/enLfD0J5cbq6P9xEl1H9QlF4CwEiiXCbrt+5
TXcL3aXFsHIc5mz+gau5ZnDnLV+cTEg6erMn+0igZrMWZ2UB/lgMDb8qNWtzswaY
TkKBlXh7k4Pz8UDgFm+oIQApwMjsB1xeqAPWVk/iAtROPloH4BTL9W7B4ifdrVzS
81VHvFkPgRG6tRQ+4SlqjHtQNVnFHzQVifDulvLk5sjXj+KwfPqyVoqJwpRun2c3
SLxsbyUl1I218y+uPUt+/CSlNeF6SL0w3MstN1OZJs7YFSgGdqTj59fyHIkjtvyl
H4pFBHLfMOS5aOmqxAUKrERQOAu2ijX6r9DX9OvkB/HWgV+tGxiofQMbB21iV8D7
82XC/1aSxLTUTa84TOboLbQuXVmzUKfCXmvoXdH59z5dtlYPNGu3LdJop5Al+dSV
MI/InONaQsguJMGW4HNjmUDSB2Bh/F7s0R/EuqDd09fO2YWZL+DxiF5MPlsNUYG5
ISW5j4Zn7J7rzPB+xEPVjVIaWAoguUum2AbvmrpYAFb2ZTXkBluSqAQAE6PPX0PB
jmwIfhYlXecezSsW/iGOlScFnS2q1bD7BJ3pslQeWVojlAnx67EOKeNrAn4LIZDv
njTC3AnHfm8sxEbByEEgU+GagGlM7Vw/RNR7wfkA0a/ILSLmaqQqcPKSRceA0r39
coxzLwt0PefCT+0w6sfflyU3DZ+L92UyBgL1Qej+COTH0gJiv7C2MDaVEmrj7cPb
xVga9rNnwMPgbJ5SHrT4cxCfZzKKIMUXJy8aieQT/kKQWb4e4jlemDuWnjclL15S
o5xwQiadP3BzxtlN56u5gO5T5XRHtYCxuNTKvWb1/ShZpZwtFnLUp5Uf+TlRbZ21
wvqr1HqxBzuCs3/+/UYWlj0JIhySPKWYp7iG5t/ITaYIooxVHREyf4HiEQpcscWZ
M3CxFjjxt+JpK4D8pyH/hBL2VYUsO77QxBQOznrVhgIJiJcnPS8JBB4lPMWpiG2F
doJdQS/FmFWdT7DXMSFrltmwf2c5ZDBWpKbijn+QizycpwxVzcsqYfmkqFS3BrR3
QmNPR9Qki6o3L6u4KCPL/a+p8stEsQictqI+/fzVdOR3eJbfts+oG9lOKZBI3oek
/xBQDA5xF17k2mTinKv7e48fRorGKK2B4i9Ktm2e62aBcPixvvr/3L6Eci4yK13u
p6pNJ1z1NK7S1sCx2QSIZTxhNidvNyiDrqKGCHHTCw0g8TrRCp8p0aZ9BPS0evkM
k/Y9j6PR5Yhibc7eigAxzGCJeiXYpjmtiB4VtThElIrKrMuAQOXPbdfHb6y4pZaG
iI1SpiUstWrykiwWJ4b5jFyD6e4/2YiXFWsqTVIeMYDd+yFUiDytZS7EsEknpxPl
XI8giXrHylxyDbvQPDuC11lYOmkkOqjUjB9/QHzRqv3STGUTFnfWynw2XAs1fQTN
jXErLe+DhS8XcOZSRizyP4UWfquDw9wsKPe0TCLP+mEKLvj7iewAr281LUAxU9eJ
cxZYR0wXEB2tGOVJuOT6R4EqQDJrPNgMLGq7WIsfIbjhbI1y6KmCyQmOWNzrA5Jt
1c+RotNxZnQvP7eDSmDaV0Xtb3xxPQ+E5p96GpyN0OsGY4tMTwa9SRsKnMNaYrQ8
hQ9BEsv1nOcvbPqen7JYHzZgwRQ8Kev0jbXRlcNF3fIPhuBEnT7F1yQId5E9LrhN
yWbzDdsZI3rmNGuLKHlPbsSSjTlszmg9FbVnc9Y3rPRLqrF4Skq5LjlFlpert/Xt
G69yFfRQjdgh5HiJMBf/C/xFL25BRQg9YJez16xPhdlsNUrJ42LftJkPy/lntY8m
BDV8tbnvbQ4nJ9XsajfWEsDLuL+qhp18aGCMX+BSXExkC70KlNtroKb6yxgbaaQd
8glbxkp300NfpVtOPbnkqTgl+BoaT1l+lcKMUZmCO8etT3qYaObCZ3zw0JG/VseT
M5IpnLayXi74tDJ51Fp+Z2Yg38At/OR1g5aqbigz6Z9qpQuOeeyow7fi9JLnS9jk
uzpPNcPoUqKD7br9ZNGT3HrRMrrTSEHTGZX7TuYkB17chpUUvH59fk3hTogS4Jjf
xrg73UQVLUuwAESjSFNtQAosCQUV/uNgJPwfDIGza4HKLcKGbrgEezWd8y8A+j43
Fn9kib/oZvfBDvwnUwBYpEmaq5q0gujPbdUVxG34rWXRMaBgQauL9oGLQd6EZhux
AB1YxlPKxHlRacO4QyQbKBFfwhS/il3ApYKTvZFct3Y4unkAcORxnmLcXkHxyx2X
bjFLXhM4TZBVJwQycWrvdXeHwS8JGF6Jcckru4HcJ1Qa1dTy5rGHFuv9ff03Jw6+
uG6/qZk2N7etj59zfkVN7+tQE1jwNU8BrG8meC9oRRiYYOeI4Y7ImI5fK+Rh5TSA
tBjfi8vQAuvKubwlaEYbH+u1y2V/kiKS8jwjbCeeZwcXRk2RbBxm0wVpp9juaIep
nyPCnjtKuks22r5yiojI+sNY3wgxA+3yqaMUlmkmQJ8b1WuqFUDzaR4qWarUml3i
72EyflYFwbcpX8nilevvW/S+aJAzVl/nRbl9J36Ooh0+G8eIQQkGDeKc0HxxcUNA
scxsHDLlwYw6Sq8fK1Vz5ggXonieE4hFXhVkmrMKLgmxSILwT+5kx41zmZTXx3wC
mBCV4dtd1aqGCi25ilUuHRUAVXgtv1nORY1fte0qbMzJSW6IDWQfKa9qpuo14AWL
xBg3UsVEKq3slofhYbPseuHCFooHuFRvCOo12D2HNiY13VSgxF8yTSFxgxpqp5f6
gJ5u8vf+73GMEK79MsODBGnpT6VmgECQShZFo8y9skAj5OTMeOuqw7cOtOlY/0hZ
j46klWtdVnkRbnc2Jq6h7xVfxmM+ATsl7WbJC2nJXQul4cZ1JcOKQH8lvrt/zeNh
zLMN9ilQFoBVTNQ05cCY2W0AWr7O4O3sJoKujKaL+q/xcu6F5HWLqBHDFH01wilp
InUstLKwaRU9fPS0XkAJEaB7Ta9vyWHaoXKe5ENEHnCSnjQsMQRT3AycwkhmxAYj
7ebgZXd0zsc5lUsAF7TUP8T9qv8O/N29M6gKfyeRi7KM4dKs6H0UmG0XFZ7wBqJm
I9ZGmN4xIw8MCsSKv9G3tnCRpLe05sL6k709b90vBgXfv626q9vIOcImYMYDcV9s
Oi5rPTasO9WBFstxRd9FDm7nwOSfRq7LSAHViOt03mVj3KIyb3dt16rgLaVVdFjB
L3wi/7oMU3aZzOcvQjMO4ZRRozVLxRkxzOYsiAOWug/Gui9ieLeuFggtjXqU/Wv6
um3zvS4KUJyWup19FPla8rRDxHHe9gQ1e8+09aQXI1geXsx9GTag5v3vnBU8F8i1
2zZteSs7mOzPOtRAaHRrCv0yM8fsYjYRUyAfmtXF9GDW44QPdFGetCnSRlb6rH3K
7dQ04Wg6P4RRbn9+gzbWFEI8YMG7rn5Y/rlJqMInGdxHZdp+80hudCDw87MgTtYo
LwQdPnL0dSXBFleVrZQjoH5EjebSCFYA37CGai1l0UqgcoMHrgfSpIKMp+CbAFEG
lgWeCILLDhtHwOPJChdTKlyVH+vpP8F+qOrPqm0J7i9GEa3NUBMemubIeKnzNTU2
RwrzjRCogMoo9jQYppjv92SyxmMm476p7RHC9SHIs6Qi2E7RTW+4tpgBMC5FvAY0
T4IOL1IhXTOKv8gMuQiGoEzRXpNn+cpDpRZAb4mjtlQj85efDLSPBssdQk04hOAZ
dsdImzossmu1na6i6IwcB6lPNUwtLTHsmSaEVhA3jwOJ25umNTyaJLq+v5f2hHbq
0UyyqpKsUcArdmF0+59FrIL48Ij03ragQYLnrfIb6gYu4XOixhRACt0RFp0lg6NM
Qb18Dtusf5fFrlQbjcgntIMDectslh8mfqz/PSiwMwYstb8PlSKdLhznQY2WTnIN
A8tCnjtYpiylYdMf5TL40fx+/C6dGBz+8jOp4tIdMi10wKGSkj25QtTKRoShdFqG
7tSjVx7wPfkNIowqdQ1Zq82IgLUz9j8xx8XMR1KUM2TZnuh+p1tL6cuO9+D7f3p7
uGMXkywCviK2WnT7VBTbzyVVwR/cjR4LwLiTya3PhxG2vMc1QJFJZbtczV0WUqCi
OuUt5NS+JLqHB9n8Apl1IfQaFRrGhSqbwcTNsIkdXcekjj3VM9LGqRcl6jpbGcmD
JZyni/o6ZWacwrC7eZ9sYAtB4+AWpDqCg/+TiRKyjtKBBaCSCjoqpOaEuZyPe4/K
RNyI76GFR+PiD/zoK55cLnmhc4fBwKaYBaU4bTKOQTxymFO6v7MDGZkzA9c5jmpG
YGgpeIhh/MYzij+17OM93ESY5RhfaHG4yW8lq7HyGzDXvJxHW/J1loK6PX3VvD4o
sA6Dc8e/7j20obew7zwHhwwHlnmU7g8CHItwKLCD1kiG8UC95F37bZu2C8eNm3t/
sQHApt/UW6ta/68H4j0zaqpJacVWMq+gOrE+BgEdWPb4zoc6NtMZaNatbSSUgdH/
x+JSns+Ptj8UOUlU1qt+NEbbN37IzzpBjHMtv8mCUNVXXaTfEr75tWMs16uK1FkI
NujvGDIZJZ9OGPi5Ye0QxpPuucNov6JpQ1h0wga+VMtsdHZMxhb4VDoiP0grmKfe
WJqMGuV829AnSKenqMM6Pw8F0CEH0/oPL4tdL+4MHq2StOyYjDjZnnx35+qPYaox
pIQXEEof8AZL19UtCisqUfFfx/EShypETDiN6iu5xXx799zY/QJGiEZw5epBeP5D
d346sQIpCMjpdu8q7dpTjdkxVWQv/1m/gqVjs5qtdDrL6HPydqH+9aJzSGmxN3uV
ZjCr8y9kmk/iN0yH0HKPT1s0Y/dnt7udd6+XlZSiNfuo9Tn/lKTq+n41L/X6SkE8
20MZcVrvOhjXYzx9ERLSgeobn5mP2fdnHSafGNBN9TtwcH72AmgFBpX+mlyRW/s0
q9vf5D1iQ1sFLzjCSI3zcwbbS4nRZvQqY7j+SvwSHwoRtbivDlYqwOXvTa/rQGfC
zctE1sRLK+QMI+vk+MacRVyZM0biJskrFQ55XxC+PmsaGkRd+HdoUJitwabazLwY
Ne8jrLuIxMHFWKqXl+1yCK9Q+s3Xp5PQ6H63z6/BsPn9XcUmww3UEB6fJpFpl4Lt
ZTOQmQNP5WzYWRLJxM54LKaclIpLl81kWNmAzU9BEUG48RLeGKEStW0TrOsFIRq8
KLXZLHR/4EcQieJkb2lgFq0PAhjppHE9gUmwvcOs6ZKLHjjzlIlTovqIkvcSQAYF
4o/cBUpJHcwKDs9S8Ac2twgfRZ4sWRIGVKnUHKxOcXy7W1zZ2+fmq6WPJuvIGrkP
Q6jI85YDQ6q9ej6vxJPDmMTOtl0mgsWpAjXEOTt+bJuZBTz5TcSK9oafiwhUFa2p
Kmhe2w5BDDT58+0ZHW4Nv+zkDRa0N7N2RLyEvI4jSDfUSZMV9VgNEUi6ktj18dUu
OYQ2PzMaPCHZKxzPJRUXaqfymGmd1PaOYyDt7DCskSZVFHHFS+cs1wLBEFupaiqA
GGyjAXiml4YpVnuGL+v3XTU6YUqsKaquBrn/s8ADKUDkNqxFOeL1p2hLqI5lO7LJ
pji3vFRPptPCtoo0h5Olh6/4aFdsrSSDIc1Vfp/m0tFUtFINkVGgLs/Qv9XNS7xe
J6Eb6MyPdjDL9BjXv75qcKV9GuRk1px56yrZvezLpjnAQuqYBAiFE9zSWxCZOHvx
Mc/inX827vI6Wu9UZX15oYnX4jp8OKZaNQVslYGvzHK2xLXEk0EsM5o7M9N9XeC+
t2DLx0k13HI/VGPj8JOpb92cT3PS8V4W990mptvbJt771enpWJFqQeqjHfhV6YQQ
7ZuWoE6pupp3Wjn7UebyN85JZCOJPoH4he4nPXHoK3GRW9h4LkfFzoeDSSzhZpij
TOdgeMkbaLYub+5etPwDvFxxB4FSyNrO0OqaAJtVyf8zVuFDG9bn+8vGN6dZXGFO
YpaZo+a0n+OZXxhi88mEuAPUcrDW/ypnLVAR3btKMQSYQDXwOyigJLLoPVM8LR1Y
ImjCuoJ6GV8gdORgLCSRtxgEPPkhivqS0445JEmat7e/9kApQbQRvgQtMGVRwHBX
u7Yh5TT24IxdpU13Z3UhnqXcXmAn5C8RApRFCQlMz4dzyts7g3rzuKch9SA57XWZ
Y5pwjvF2wfjysrCZHuFbRAKCmzjwcFA4cxyxO/3/S0TR+fLTkCayGBDYlmMMqGuE
TFCErF4RMP/6oWGBIOmsWKxLgyrCCd91610KZUKW34J3Z99L5mx3VKvs50wwK8wY
XS8l7qUzbl7vTcM5jEl9InjxJ0qiJrT7C8X8PQ1v8143xWUVBDEPQbqEfF1tWJrF
F4Z6rxuWMg5XzZMnCbDFouKrjDQm5MvnPMbhZ5gFzRuBOKNDmW9UWW/+LOwpXJyq
Nc2WuQYeZ2zS5gu1IiQveNqkq6Bbqa01gtnWurpIEHi4/YbYiKi+GnTVZQqZrAjj
u3zGXOWs+Cd8o5FaYtdu/kFMP8sTA9cvV/2BrrR+C05zFmm2YhUG7cdiSA15vf79
gykaZ2UFKEpssPzUrEASJKVSb3gwQsKdOl+kjod1XQovudkCvtZyfOMdCFuV1Yfo
f5YofR4Dv2nwMHnHr+0LpIr0LFV59IxqpGH9brKQMHKFp2pW0r08bSfC57ccvZBC
0VNvFdDLt4bUGSqfrzXNzLjPN5fGqGbSdxa6ABBHyrxbiHXY6lQfx9BchQ4hD7d7
Jg1s4uDAvGgRiyCL3YGn+C3/LCPjEP3Y6DUfCg0if230y1vPJdIjVoXFcAiazOdx
inEw3RgPSAT0tihxk0qwbck6fTfVO0UhZzV/pHj0xcEdofQu80MVfiPbu0Uwhjxl
zKJFBWQwwtitdnCEANlMZxVMo8o6FrMShx+ZhqEqXVbfUuQYuXzvlLnWJDg36JYj
ViE2czhKRwqx/s0QdfLLtB8EKBy9xlForG21IFblEwVEOdmQrQ0I0chhnNamJHmm
cAQUBBT/LBKcHfB1Newk+a4k85h1Ke2dnHdW2GeBeJp4Y5mtgz1COKdVYgLXgzlx
WMrGcQcBildD9PZaQyA8O85IJQ4VMmvxq1C4yFNCzS6Vq5/FqEkk1PUU4BAtx13q
O24DcoP8+GogSPBfR1h2zKVipMwo0khK/NQzgvZEru50HNwObdfp6FKtmuCWWuzN
DhJNjabJ86tRwpnBMPIb7oZTSpppBc6FblyltvdI90/kFwFYancZIfUYTBVIsSgR
A7V6OrnqVgHFi9OMjHmk1SA39ykyLT1V1eAPYSGHSgNPkEDTm1gOEJa1mE6fTCH9
y/x1oBuvbw4a6OHkIxCqnf78D4seD3eUPSTRIQ8WiGcUkSHRdEOjFFxomddmKVYG
CNDePRUxIN3x5DMoXXhkZaE6spkvgeJoouiDzH4BAHFkFJ3P2752gcN+X+/rWx1z
aierqQODcsAKZhHcjqbJtVxteTcTF5NIGPLpzFY6uJZmRw0a49k+gy55zkVfDVVR
yU3gkt55rjSRpHb5GHq8bfugLvidSW15EVn/YXYA8sqcagiRXg4NB6Karm9k8lFc
llzfSrh3TK+EDBH0H/AbaJeFGHydn0HvdKMe1TDLr7YTBEoYO2uHPeOeUZt+g7po
36DLL32NEreWVwFecc6/mnaciOZCx3zlgcL13UNmO0uzWx+j8EuLqKKmPJNFpdCV
eAjb7410FIrRqnYoAlFmMF5TzKKHzqSRWNtO0uvBy42Uyofe9qoa4FiSYobE2KTD
iK5yKIg5gzuKl5tw+1C8qc1s5oeJGKXZcDGi58qp5PY9EOxsxm1ciU6YfSltsSmg
/oGOQp4v9mtgByDk5GXlqSqoIh4VYrG/CDGtFVTX6NWqs9DglIv8Vr1YsndKfsms
h0DbjvEAfL+xUKHf8xRuGwRq1Rh+ThSUkZgcmYSKGZA4bm8Q+4S16QiX0ccBIFnH
oXZymN58uE4VhkD9mKsEIx1j+PHP0VaSVDDTH0TqrKJgwv6NQmWqiEqVXAT8cZiT
bJVV9ghnk80CGD5AvqOuol5lSFrsc9SwxY2CCfOVhpyCR1oTb8eq1cpBP629dBpK
hSbu1y6dwajeH4pFbcPcAh5nFa2SjUNEB6bMQMOHYkd/dviSFtrB5MaRtv0T2yMF
7B4Onbw9Ur9uorKf+cMU3s3PYAFkONMnl7vEHPWnk/gZRZ4o+001n04tZlYwaTJq
J7Qlr1U4B6dQhrRkmrBycelSZ1pBLTS8dpCksqq6RML9VR/mo4i0Nn7OOj6fsJ55
gvcASfz7BrlnjAbNjEdnpamfC3PVxXWPhm2IY1RpXnAUl4KVrqqWWRmojrvWuS0a
/jKYO4ePoY/+wdft8M3YXDkGfpV1NjpdzkbvE2/TVn9FcSNlMQ//FLHG4QYKsyHD
FqDelRVs5rqdbnoeWXm60Ae5g5b3mPbQT9S7FwXKp0clh9Ido5VrfjWo8jgOA2Fx
9wj2OXNtze1vybCf9W5XTptN3Ld7hYdk/hZc7OR4RW0NB37Yf7s6zpKum1R//WUu
B2IktZESpScpAS9clsGkVrcKrEZ0EFrqqgLmUJMD+nmjMifo+dN2rDCGjRvdxFaq
lJlt10tnnRLgM36r8kRsVGPWTEWEIBMsjrQLKHCz2cVAQ3DN0Ozg0zg14rXZ3Rqj
guP54jAEWuPQ6DgQeBJ/7K02/Gpqbkdo1BZ1AVMpJG53LR3G8sHn63/7ovb0vT4r
FRz+mjL/G3yHGpPpoumZSOK+GtdrlO2szZbw0rrZRGJdwlT+4T7E1MvEINixIVLS
Q8VxgYnFF/CGr3RlPmQGhwR2Tvypmqft3GlHxGTYVeBW3HgZObnZtm103jlEDuzw
aAPBxxv/5N3W3SfBZUe57zkptzdq3wxLa85lIWjmR2Um9ljSHUWvAIAnjPqSv9VZ
n44T3J7z3FZVnvN6iZTUsMEbbjpan7Tywkn7sJ1TgB8bkJ8+A6owdqtCHWyq1non
wn1hXUM9W9JCHbiUPmDNiVgSYjJ1gmxJepVxkIAzIPIwuRWHfxibpMSePm1fp+sO
3mXhdW8F8naTlYE62f6I9tZWCldzONNoj0au8OBu3b6YngA2gpo+SlcLgzKZtKTN
JcS31yC7k1S6vHhAwDVajB+/YSLvxRN0gRa0400uWk9FwW3jH5XOJidqZ7H2//IX
ku3PIY3dK4WJydHXdIY11t6lo1/ZhfGbl/VzyLMvh3fCl/XJcwB0gH2Uf3iYaV/0
E2qsFoJ6bTkona7LNt/dMDRjT+cGXBj3QYtUmEhMUl6sOCphR7Zqufv2LPIGWz0o
Iv8SBOGzvipBbdxOZlUDjAK4ZDMJY3u5wnduygivim4jNBGdRHNdG9At1El7EBJb
3glDYO4573oOmj6pgGDq56sD0hdXdess+G0sDa06rdWe0Cp3p5zfLlrjXzsPrtp8
JcKu4OgiDa94iOD/xppHg5RL/2FbBI52Ca/pzUgMqAsD25FNkLg2oyXxFPMacUSX
0i4prmeuzEoBeEfrbIFHLu9ddzzYY9MdNAS0Cegqf/errgpchF8G3Jdd2fmoc8yL
SL52UdJd/mp8MDD0qCIocAyNftRz/NsKOs+4YAf+ffGVABDrAfg+Zi5dLl73EEoe
DWgEsQ8yJL4brSMXutUopaX5xxigOG0Epr08soIvHJU9L5P2ObWbt5m04IrxsAdI
Aylpw2rZyHmEV4BGez85WDP3uXmWFY7UbjnetOSEis8EIB6UqFjs/fkHPGLPAVQC
aye/Rd5fgvj2Hj1Mtlo7TfqaEDrr/FAksPxfxjUKYpXlctokd398jEDdUmvPQKHT
RWM8MrSChJ3bUaJojhNW7fjKHV8e9T7jiwSDhJFslB5emFurtQieGD3NZkeS4HWw
Kvcqlvz6Fx23Q8doUvwUyWPtpwc0BVJE+Wfe5XD6/cw7o+3XZDokmZOIUHFmjbmR
Qjc5mpUAtpirLIe2ZoBvI/ukMML8sGS8efkH+dqQi+sjDGCacRNwfeSLbDjcNW8t
s4UK4Adx1gPeKuPJcVsvz9FWyNLQPoZwrJrrQ0E3lrb2ubSndisGiSyZMNE3JmNr
RBlSE/y+/Czv90pdFY+qGySF38euCk5BCO/lZBfm9nSqUbkYeoRZnAVmUgYAzahl
hUR4V8VO9thfBkCKGxj9Q4ZYXztfEXYg7UOUm8uU6DirTltuL+ZvhJyglm0oPhpD
0CcCojYbtCBa0sE8kJ4pdyMMAngmIwNulfOU+LdSCKXVprLMBp0wDVicYczBp3xF
Xe8ZrTGFdBiy8DQVFj8VxegtyJQNpXI0diLYF3f1E+84RFHccxUaK3yogRorCiiK
+wIw2cmVe2ANvGw1O/2kSqmOa8I0R3bRfsIQ83Z8GsQ0JCwtp/qLQVKoxmy+Pq1u
w0FKpIcFbWTWAESHvGt6e/NACO99l8BBmGRA7ES4hIWqmTd5Xt1i1x24FOg2hZbP
9fPG5dw8k5YWz6dA2Q02S4B4/6iGnD1FnEECQsbUo7eGXbsyrdntsthETErd9n9k
WIzJjYqfBhZspMyn+dKn0YuL3FkVZmiewt3O1uX/sN3iSzZZo1LRYNqO3U4y2nc2
zEcugJQQaLZE/rzKU0d+mqEDeeUIG3jYH/fYUtKSteZ1U0/N5Iw8xZ3fCdzeyMro
OmGu6nVoATGUrXIqRMjrsi5C9NmlmBN32hjV33DDZ4v2Ybay+lVivlHhBS74scWC
Y2AMfic44Z+nx6HAwWxKWIjuMZTHHW3Qtoa3GtYlv/8zNu8XnCuMe8TLarxANE23
s2Q/jRQTaU9qgcRf7VEEMJHnoYl3W4kcl8qIaNRhw/gmOC/cagDee3bmz4CIE3Tz
KO1ECPSeGk6nb9fM0JKHzvHpyXbLUS2JiaVfyGKFoTTQe7vkXizw5/oxHw8dSG+B
uwIrkpac4umt+rLnlcsoBsf0fJjvm9KB+AUzkXXHHVzCZuGsNUASJlRemWF6SXbZ
MfzNwSgeicKfQZNacjVQOMz21n7kZYx3mMdBLnoLZks3LTIBmGWYQv9wpa7IOhWf
WYrhMsjXcH0FWkf6/Wb0TgSX1yer4FPrWZPrQiv9UlQt8rhNt0I37oNRm+UT1WQV
Jk/mWlOEVlp82MjbNZ2r9/TmDNSyb3DPucBir6B9dGDnQWdt8rv26Wxgi/+iK403
EkFGSkjEv6kbZpVUi1n9AKV+Vj7sslEPEiMk8fz5gRSPhmqBHo6gaS/ilZevfIJb
3vewg6dXTzcNzKnAeCTmMsKexWNhuVRGyTyeu4WVSUIxbItgDOg/ici169yDOuxP
drpmkYzZXy47JRhtzuEaDlWGcYPahfLEq+sz9MfHei6Ko/kCrj2no7+oxLRAuSsg
Ql9XAtWGhSo3ZlQY8Vpm5r0T2iaJDXel75YKx5JIjF5jT34yshamusmBS1oP+CJF
2gE1ellSh/yy2y+X+ziOj0Jc90prtXXrrGF18m1rwzHd/2xuVciBgBvIGDMkqeNF
aBehTKbTRUBssufjhHtCmpURk2HfAjJFk+ZzUXGJwaWEfVY+NfqwLpotaVV29Mq9
qttALF3Ct7gai94Q0KO44ws6oa8GZrGVNt+G9ApA3dnECUoCGjk0rTPQbcvv0OgZ
78yZHwviArpahnzjtVwOIXALJZGuRgGPyd4kno8SAK1hJpaD8ZAKas2lRlykDfO5
kqcZBiy8mACoPfsrw0XeiGfLf+/xiCGJt6vEi0T43R32fr15BkAPOgLDI5OZhN/4
l015Jonwbm7NiB4FnjPeo81fkMN+/CZo81LO1FoB/E7UtYvLYNqSwEeheKLo4SRb
BYyztN4iGF0nEtyTDfG2AJfFWgZDAoqvsyJPhUIhS0qLb/F0xBS76Z/6gado9tQG
XT1dwg5NrYWubz9BoO0VV2dy+E6v/vOpeBT8Kq76l/WBmzprx/8tq5QXdkKqXJGO
LOad8DcjPtXS1gceaaN8tuzt8RxhkyWej489azNF5fHxCuaUpgRAeNAAijfxG38Z
2KItfoEh8Of1ukz8dVU0WgPCguQ+KVm1r4Re4i9ViH96QC6gU2njuL/vjT4T/VCJ
Qd7ssfSMBTjVEHsXBtjyyKQAx3szZwncs/0AUivnWnAk6JP/2OB6d+i9pder+3om
jl0r7aPYNHHUU+addCl26K0Uu9W58igaBeoPO4iUeIg3RbH80Ac2OV/cbG335Wg+
wW2FGywAhKZ0Y9dwvjKK7k9fBpwiBp310dqI0J6xuXVfDy1i1ibUJndQQ3c8puQH
04pFD2+6yJ6GzPYKjpipw6FLkK71gyOhdGvvzhKN2KEfu/1l+hU5c3UhkILwJ43M
4mAunH4P6QRmDwqonHhYRvK+Id4LZMxYSDPupuxy3wnyY0JWe0bmYTHZ2VU1yjLc
WtU45ZZYp+fJ9rgIsjEnrm3q3OBSjZc9DPpnYKOXK/EeINr0yxxZlkxWTSdAKP94
mprB+iTb1wvEzKTyvn1SNNiaoN4qeuEKrTcMRZYJyGp7K/3oMLmgDY2JQuT/n3Cx
iZG/DR2cyqBqZSguOrftz2ktqQqhyiGGvilYsdD74CQ9tUaRTN174lVjz6arNh69
p7uKeetUgeR4ZLPOZ4FfT/srEeK0e+sjoAcQIaoqmxLehB8S9TCthJ4r8II4rqra
pgNYv4lMUp/GLQFcRB7gwZ/8fzPVc8EhGOi389fpWirkIu+Ct//7oj4bmdC3lsBr
a2fTS0j1aOL27KkVxwIDEofw0yPDuOYeYoo1NZJEqKQZgBV9fmdh31f5w2OTNnbO
GYsKpiC2ZOBdGgiqyy4YkaP85fssGku+/FUdGPbGUShVkZZTt6gZgaCt356J1mMW
eTARpcw1vfTVglpPK7fV2AHJRSD4Gc8e+cddxULIV33V6D7MwpscIDgBWeYk48ZU
bOMUwREFEnTFHTWq8xn8klaE5q2CPkSdwmrvuPtL9D3vcBms0rcrPrWfDG4GZ+ri
KwnYonJK6afC4/Zyj8MVqt1iE88PbK6b+PoSS7xrgBfMn4vdJzIWdTTiMC3q8zn0
Dcd6XgszoHBZEStr5Gak0PqayimRh3Q3SipL3SVIvnoOM+s4/Dxqjc0wfw+oArqH
Y+ckaIa9hbtaSqfpX4lOJEZ5FUopatCaqnlRX9PHtK+HU8hGdTrFgzPgsBqgwUPt
F0IOgy6wbUZ0uuGV0TIFxZXfORdABDKG7JSvoMD9dZL5KF06chhWlM6bIja/bcbf
f13021uk6857+adj70xx3PPWbOeKKC8NZLg9BPHpj/wRUOE96k9dS7avrIJ5YM2p
2OkiynhlU7OH5GpIGu4YjNt/iI3mKp6MA23BFdz5tMvQUISyA1nkjx1dvkpYF+B2
Ok4/XH5sKnRk6khfYKJsqmitr0X24gLhVitxE7pDB5Dwt0I5CCYlxeWtufuWUwf1
wDe3lDOh49SECzj3cblYAO8m4ljV3q8f0aGeq6AlR1FFuSioIFn+7IT3ZmlOo63E
e4UbdkqiqOrJQScTCDYwi7iGnP3TBxk6+KfBLJFNHzJyPKxmUeKeuv95ZmMm/qzb
hgpLlxH+TjZGTjG/WDvcnhtkjw/tBUu6M8/f7FnRrnOJ+8u0pvrUzLMuME353t2z
lG/yy8Wha0wEqfBUMp3LpqgfFWHGt22o8RFggd5Kcu4AjEj8vA7Lkt8HtEpAOp0F
PXzjV2Y8Gtw5JM2KXiFa7W0BQrF01S5Ek8i3YHd0dYI/KkaU3kptABRVN0B3f3Tm
bltzBDguHEtWaSAgz3/dzULK7029d36gake/jgCak3gISzqsgYUJ0Ko3X4fTFC7C
JRwUONjyaXLEJTHUEy94X4emlS4n4oseayqdmYkO7TqOI1cTaKeye/OM6Mai8g+q
IJ7Irj1H9v7VMIr5SX2g0I2h77f+cnxeE1xzV5P5KlQyy56I/YSgKexqFBWTC0Lg
ArgwSKI5Sa+U2/JO5LATYPIFgDxmlfJo+McfIpcYduTkg+HWRyIrRxIsAtSwDGSl
X5uzx7AXBFkiQpLdM6KUifEdfONkxXaAZ5cNdCU4CizZxY3Oij7un5Iti/IgFV2C
Ko6W11GzyGBpfmo3QwgruBcFaGw9lk0eBFXeA+ho1CHnVoCkMYKKnsI53wQb4jiu
hup87ZJ7G/IkT/dByZJajPU1npcN0NkIRUQ0aGomO1PD15crvWDCOnO9Fx+dsu2p
GrSMWIhB3RQrUr36h7/HxnOHqHaQwkJaNprN7XxB2p7SWAHJ8scbsS+BkwP6idUS
pNbyHXRU85bm8vj9RX0XJB3NuCClCWVzblPn+nJ72LddyiDbZsnrGp/lFnXhbUwe
ZNFlvj+0ZyhNpK7akLigvfHDc0UhjYtUj9A2gHivPaEU58MKvcW9e/49xlysnCg6
fHUgglITM0+MCyepNDEpllPNhhY8qtwzQWztbVJI8EFnswB7SywQ1yF2idSVBGi3
i2cWVlWiSvTwCjQrYCpYCvRdGvglQoem0nXmrPDivSId51DakGhtqQHRr4RPWTII
xGw2tPWwdDQcEIyx1ogQYx2Bvq+tY8o0M/vFWLubABHxVCKcQgo/IgvTYpERsL6u
EyKf87PLpK/hwFWtdotKEm3aUHbFYHyQQi9gH/m0NRatnwtFCix7tZUqPoTH2NIw
JHhcRCyoU/pybflqDFM4PLMwToh8wvr6dD7+CfmnC4IMx9DuKxysUkdQtSSzGGf6
v0DqqGsIx0Fy4QY8tDzu/RjBUD3egliF/LFHqu9q9wamIwKNmyKQAZnq0vkplxC6
WRTvDMw7P42VvOE4a0RMAHZavoEtMdNWcrzMHJJxP4HjSpiSUrtGhG9itw96JLq2
lofHC8yG1IO5zS7gd4nVr/b0+ob5+EY2V0PI45bHRViv7yr1BM5Ynh/OBjdFrAVR
qC8GxMcye1xdffN4Fm9PpPzrTd+JdGVKe/MQKqNs7vphDf3NlBjV41sV0uDGv8Be
iTCX0DI9b7pp2vONZnW5mnj0jJ2y6U5rUD4evfjhcAggbVtDIdf/uT0pafmxX06i
Oix7PPg7cfbXDo8CD9VirQk3TyfSQoyrM/HQjguXd+0AQ+3EJn369BII4HW98fdJ
BioiazgddXl06fgS7brYQCemRWK8FD1L94wyEy5CgnEXUOXx7Vpdo1md/Kv6TuJr
IeJqAlx/XKfOgFtbrMfMb/E0UZLijPbPFSPh8yiDvFinYEa6mUVAC0timLF8LFq0
KKCvPSKAKo4BaqKG9KWepFcgPPJX+Et5MAFLRKbwDVEJAJiRyFIIaABSWuUOgdET
isu88CJzqOEA63TVtyVsaT98bUSJYXlhYm+yVWPkWDZNCuLdfNNVCjLRgP0gSIP0
Kx5gJw2SkZAAjSWTYdHKRFtzq8WgNz0mpFwO4ZAKPBzySpv3rpm4tM+8WPU6qSju
GaHdwt/g4dIoRTY5Om65SsMF7nx5wa5N9OFAUCkyO1Znyb3QBWu9BgYFSpeCE7pb
Y/TrKQ69XcgqybD7zQkPIj8pCSCh7IU1RHNaEwH2tCC4BREY5fpFTtpfZ+kaVSpz
f/9JpLB4OuSyxqkRBshumJObc70B2nrQre/2x0Pwu91rKgJxWLzNbFVYHsu3MSHx
t5xjpYNiWVimAMAko412JpikhdIC+rhjSbPCk+SM87c0hcXAxenQjQ2Ymw10d2ZB
nMo+Bm/oqOBfQXECs09YkJJjIollHjIPsFlHDCWfXM5MOUG7vrQhpH14qMhB1rUY
423lhAHn3E/to0FlYM1ZXt9j9WgD2yScfk71hpZ0NWLDIOlYPGrM5ucVW48s5Xcq
Caiy1A4ohSGgJPoo2MSg2W4kmRMJYoJ196BWzlRndLpUL+RV56N/7dffCO4mIxFk
aWaGdSr+fGRpJxsh109sAJGg4t50xRt3xIApOPkWeXJuOW8SkPQwOcTvlafHrskL
h7Fp/0+XGOhI96gAr6qxiyLQ5J5fOLnJH+StwgXKBd++vX4otVvkDB0XYsZ2KXqz
qZanujxU/bj5gl4hFRwCaXWU4KAbKMGAWuxDnQub7v5nVDciGUDjAqxrfcdyGqPz
4Vrs9r+N06pOFM8PQRAP20N3/pr6vCJPtWsVHs+zmB8MgPySsK+LYx68JftrZB3Q
a8xVX2xBoCggqGEU88Qyv451E9Kc3VQhk0rWJMnm2/Kgdk4frbUwMuuHaomdYq8K
GgHzq/o3HhIpimoZX/9/UctOyjYdB+7TUkhEXmE65NYnWHDIhaGRa+Kuz3bHovsj
YVy2h6XKUjX4EysIgAYFubmXZmkptW3xAfjVFJRAGdhIlUnbn/e/uafRtJ4oLxLr
Z1xOMu2XoOnhHPxMeRxV79BQeODI4JcqY1228VXcDH1salqQwvbkFUaHvSHk6VMC
/J25M+XCJnyQk2uyu8P4IbU8koXk+iV16ktELL2A0gXLd0r9Zgn5fOvJUlw2EHYn
ocHhf6SEBfLo1e670jrihMi7Z+ATmK+1dQZnFgQSEu4bvazFwJbviVQv5JAfROX6
kdZro2AjcFWTxntMu6KZ3nEH19na3f4NEp/2/h7CoSzB3BBYrLUTZHRPTZ9eZDP+
X0wUNPYhBizRgyEa6lv+Qr6iSt/JIBq4SxTjeWp7sl7EkTvabi7W5ONiL9HEerRu
yVnqEMXnpCtBgP2nNwJBw4l8BDtLoGKLreOvHpZ+jWqxIFSJvTZuPT52hTehblHC
LpFPRE1+jGsPstHsL98r4VCfVT9pyC/hee2KSQr0rRGUh5Gn1QyJ1awnDWdAagKN
4WLwhvw2EV59IqRe7L5hqevznJYV+5ZwXYl8QkwwtCRzbh65MsdDDc2XaZ2t7PjE
StpKzA5f7QHCaPiNx4Ewr+UvWGZ/ZzFsMNbvqJx6p/r/x/31E8r4iD/3p8Cnav83
6uG6sRXwkP1GFV16WZ2d+bZCfUt5ucOPY/qhvZoDlre/64v18zblUlZGr5wpZagc
A9hggsPFJw/P6p3OHwOBzyDwzZe+B9aCS78IhuhPphq53s49W5J7js44TxJcVxXE
BNMGTYO9MIj7i4mG0LTNlxrckowEH3ilyL9gA2lWPUMtMtP1MhZxLFRhSeRnSi8J
a1QiE26bslYXhbXnandOEe8hRbbfnqela4LpGKEa0WepsGC7h5XDOBip+X7vwH31
m4RpKyHOlNY9eP4BcDAKq7nzdh7t6+sqyRiPruRzbX9nw4IeVn+z58EwVTZjlWwe
SczXiVaV4awoAhbBhPYGFLnjF7s2Fkdm+dlXbbA+9kWpNQTZrXLVa5UNkrXL7NkY
DQ9kVNBJ8A2yrzoK5JzQynzCD6jmogQJyJLXKQWaVeJqXdATGeVfVyvDyuoRZue1
bZpk0eZ0iANpmHQCthEnPmcuxAvAtirXQA9oL5dKXkfOTL05wVtZhCjRV7el6Epw
kAjTAg9aaa+nS5Rtr7qejE/SCxXBjv6PSeZimC3nyULHu8SmhT7gEvNXn7ZkKJoH
ZrgvQQ3CueaIe4CWs4Bcwn/pdkh2rVjtH23LhygitUIrJX5dmB1BTq8/mhH0R/mk
lF6RGpMLsRMVxXb7eCpoMCFghXDynXd134ZxILGX6zx332KDcb9xxY2V+dBj/hvG
qKXZgy001Wg5AEUu9IRcTjadW7WrfP8LF1cqLcUgWeb5gZewndgynw9o+PDiOHca
3545vp0i0DQtzTAkDsyiOTbfzv9Ik4zPCs/oFhWKDYnS3zh4KBLp51F6Ag2u4RXI
fv3/JNi/Hkmhw3p6TciOR4MS91pOB+bTzg0JeR2Rbl08CXKzx6najrz6ZLLzeISQ
Q7LA4YRga0SN4h2L1dlcQkA4+SB6jxUsxk/rxBLf4zvdpqsahoqpT8sTgvUcU7nZ
LkKG55GQ9/zRx3JfALzbETK5A+kNJHqA4g4jIXiEx4FqxipkZqttUNPi/qWVZTSE
pw2ifusD+dHA1oSVdh/bIwXflKwG1NuokvJMy7keS9RXZZ6bKhETpCuiOTc5kLc3
1MrvsPhUbHaz/XdkqU5wOOOP+gQOwBZOgBrHjmQkOhi1kaJMKmdZezk6HPmmo+bg
tK4r8vlgcHhyOiQssfn2sv7pWzJVRvT09DY/S+VU3tygTXOKST/1Cgttmyc1WSbw
zRzKPDc+2irUOedjXuWPFh8EV3O2Mut+RdxJ3UWYFg0IUkvw+GvqQmZxRNK6LcJZ
u0LG8qG68S0jQiW8+g32Vs5iXDQanER+8O2qJrv+Y+wfLMVflxPkpm5frDzytaw4
fR+NgIQ5FRTEIUYtq2g4KIKF+j8WukfTLGa1PHpVx86qmpvwoNGhEb5Oz8jTsI3G
+JPmqFrOVwTS7uOr5gIGL/C4bBm1jKdFtIEkhVNJY9UO6uCvhohR+9uP4EsOpRrL
`pragma protect end_protected

`endif // GUARD_SVT_XML_WRITER_SV




`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
QAUeqtT3Lse1zqQ8BN/UbqSxy3rNawibrJeVIK/bq1vYZcG+xS0QFg/oKPvf94wS
JYB5GyFBUEHspRZUIQINcZBjcT+MxgfmEU2Of7t6xUH7ECrkq3Ti1FdNSds7Qgop
utLmYtUMLzEWtfreFmbRK/9lw0WezoTtKrgmYyj61Gk=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 16971     )
69OYRmnHF/s572eFumtCOjClEfZQfTsdW+1TWUr66//ZY0LNtjSNHHAyLi2nlMHU
A8WZbGcIr39S4T0w8xv1ja+CtBOhWE5ZroRm9hY6YPphcvDZ4aGnbIgaPtkeQ+Fp
`pragma protect end_protected

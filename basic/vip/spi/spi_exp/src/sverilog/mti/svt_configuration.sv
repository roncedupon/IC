//=======================================================================
// COPYRIGHT (C) 2007-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_CONFIGURATION_SV
`define GUARD_SVT_CONFIGURATION_SV

`include `SVT_SOURCE_MAP_LIB_SRC_SVI(R-2020.12,svt_data_util)

// =============================================================================
/**
 * Base class for all SVT model configuration data descriptor objects. As functionality
 * commonly needed for configuration of SVT models is defined, it will be implemented
 * (or at least prototyped) in this class.
 */
class svt_configuration extends `SVT_DATA_TYPE;

  // ****************************************************************************
  // Public Data
  // ****************************************************************************
`ifdef SVT_VMM_TECHNOLOGY
  /**
   * Used to define the Instance Name of a component to whose constructor this
   * configuration object is passed. Since all SVT VIP components require that a
   * valid configuration object (derived from this class) be passed to their
   * constructor, this value is passed to the call to that constructor's call to
   * <i>super.new()</i> (i.e. as the <b>inst</b> argument to vmm_xactor::new()).<br>
   * Similarly, the <b>stream_id</b> property (which is inherited from vmm_data)
   * of a derived config object is used as the <b>stream_id</b> argument of
   * vmm_xactor::new(), to define the Stream ID of the component being created.
   *
   * <b>Note:</b> After a configuration object (derived from this class) is used to
   * constuct a new SVT component, the values of the <b>inst</b> and <b>stream_id</b>
   * properties must not be changed in the configuration object in use by that component.
   * 
   * @verification_attr
   */
  string inst = `SVT_UNSET_INST_NAME;
`else
  /**
   * Used to in some situations to define the Instance Name of a component
   * prior to its construction. Mainly used in situations where the creating
   * component is creating multiple sub-components where those sub-components
   * do not have obvious names. E.g., an env creating multiple masters could 
   * name them master[0], master[1], etc. But the user may want to name them
   * CPU, CTRLR, etc. Some components therefore use this to support a
   * mechanism for overriding the default names (e.g., master[0], etc.) with
   * more useful testbench provided names (e.g., CPU, etc.).
   * 
   * @verification_attr
   */
  string inst = `SVT_UNSET_INST_NAME;
`endif
  
/** @cond PRIVATE */
  /**
   * Used by all svt_configuration derived 'copy' and 'compare' methods to determine
   * whether contained configuration objects are not copied or compared (NULL), the
   * reference is copied and compared (SHALLOW), or whether the object is copied and
   * compared (DEEP).
   * Since not owned by an individual instance, not copied, compared, etc.,
   * like other svt_transaction properties.
   * 
   * @verification_attr
   */
  static recursive_op_enum contained_cfg_opts = DEEP;
/** @endcond */

/** @cond PRIVATE */
  /**
   * The VIP components provide support for the development of testbenches
   * independent of the availability of the DUT. This is enabled via the
   * 'No DUT' options available on the component. When used, these options
   * result in the random recognition of non-existent input bus traffic. This
   * in turn results in the random completion of transactions initiated by the
   * component, as well as the arrival of random transactions initiated via the
   * bus.
   *
   * The input bus traffic includes randomized values as well as randomized
   * drive and hold delays to demonstrate random legal bus traffic.
   *
   * (Default = 0) When 1, enables the 'No DUT' option to have the component
   * randomly recognize non-existent input bus traffic.
   *
   * This feature can be set directly or via the command line, using the
   * 'no_dut' plusarg (e.g., '+no_dut=1').
   * 
   * @verification_attr
   */
  bit no_dut = 0;

  /**
   * (Default = 100) When the 'No DUT' option is enabled (no_dut == 1), and the
   * component supports transactions arriving via the bus (i.e., as opposed to
   * via an input channel) this number is used to insure that the component
   * limits the number of transactions it auto-generates. If the component
   * can auto-generates multiple types of transactions (e.g., for different data
   * flows), this limit applies to each type of auto-generated transaction.
   *
   * This feature can be set directly or via the command line, using the
   * 'no_dut_xact_limit' plusarg (e.g., '+no_dut_xact_limit=200').
   * 
   * @verification_attr
   */
  int no_dut_xact_limit = 100;
/** @endcond */

  /**
   * (Default = 0) When 1 the model will enable callbacks associated with signal
   * changes (pre_*_drive_cb_exec and post_*_sample_cb_exec).
   *
   * This feature can be set directly or via the command line, using the
   * '+define' plusarg (e.g., '+define+SVT_<model>_ENABLE_SIGNAL_CB').
   * 
   * @verification_attr
   */
  bit enable_signal_callbacks = 0;

/** @cond PRIVATE */
`ifndef SVT_VMM_TECHNOLOGY
  /**
   * Used by all svt_sequencer instances to decide if they should report 'Dropping
   * response...sequence not found' messages for exited sequences. Disabled by default.
   * 
   * @verification_attr
   */
  static bit enable_dropping_response_message = 0;
`endif
/** @endcond */

/** @cond PRIVATE */
  /**
   * Field which reflects whether PA features are to be auto-enabled. This field, along
   * with the #pa_format_type field, is set based on processing the 'svt_enable_pa' plusarg.
   *
   * The initial value is '-1', indicating that the VIP has not checked for the plusarg.
   * Once the check has occurred, the value is set to either 0 (plusarg not found) or
   * 1 (plusarg found).
   *
   * @verification_attr
   */
  static int enable_pa = -1;

  /**
   * Field which reflects the output type to be used when the PA output is auto-enabled.
   *
   * This field, along with the #enable_pa field, is set based on processing the
   * 'svt_enable_pa' plusarg.
   *
   * This field is not initialized resulting in the default being the
   * svt_xml_writer::format_type_enum element which has a value of '0' will be. If the
   * svt_enable_pa plusarg is provided with no argument, this default will be used.
   *
   * The svt_enable_pa plusarg should only be provided with valid svt_xml_writer::format_type_enum
   * values (e.g., '+svt_enable_pa=FSDB'). If an invalid value is provided then the
   * default value is retained.
   * 
   * @verification_attr
   */
  static svt_xml_writer::format_type_enum enable_pa_format_type;

  /**
   * Field which reflects whether coverage features are to be auto-enabled. This field
   * is set based on processing the 'svt_enable_cov' plusarg.
   *
   * The initial value is '-1', indicating that the VIP has not checked for the plusarg.
   * Once the check has occurred, the value is set to either 0 (plusarg not found) or
   * 1 (plusarg found).
   *
   * @verification_attr
   */
  static int enable_cov = -1;
/** @endcond */

  // ****************************************************************************
  // Methods
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_configuration)
  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_configuration class.
   *
   * @param log An vmm_log object reference used to replace the default internal
   * logger. The class extension that calls super.new() should pass a reference
   * to its own <i>static</i> log instance.
   * @param suite_name A String that identifies the product suite to which the
   * configuration object belongs.
   */
  extern function new(vmm_log log=null, string suite_name="");
`else
  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_configuration class.
   *
   * @param name Instance name of this object.
   * @param suite_name A String that identifies the product suite to which the
   * configuration object belongs.
   */
  extern function new(string name="svt_configuration_inst", string suite_name="");
`endif

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
  `svt_data_member_begin(svt_configuration)
  `svt_data_member_end(svt_configuration)

  //----------------------------------------------------------------------------
  /* Method to turn static config param randomization on/off as a block.
   * This method is <b>not implemented</b> in this virtual class.
   */
  extern virtual function int static_rand_mode ( bit on_off );

  //----------------------------------------------------------------------------
  /**
   * Used to limit a copy to the static data members of the object.
   */
  extern virtual function void copy_static_data (`SVT_DATA_BASE_TYPE to );

  //----------------------------------------------------------------------------
  /**
   * Used to limit a copy to the dynamic data members of the object.
   */
  extern virtual function void copy_dynamic_data ( `SVT_DATA_BASE_TYPE to );

  // ****************************************************************************
  // UVM/OVM/VMM Methods
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Copies the object into to, allocating if necessay.
   * 
   * @param to Destination class for the copy operation
   */
  extern virtual function `SVT_DATA_BASE_TYPE do_copy(`SVT_DATA_BASE_TYPE to = null);
`else
  // ---------------------------------------------------------------------------
  /** Extend the UVM copy routine to copy via copy_static_data/copy_dynamic_data */
  extern virtual function void do_copy(`SVT_XVM(object) rhs);
`endif

`ifdef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Returns the size (in bytes) required by the byte_pack operation based on the
   * requested byte_size kind.
   *
   * @param kind This int indicates the type of byte_size being requested.
   */
  extern virtual function int unsigned byte_size(int kind = -1);

  // ---------------------------------------------------------------------------
  /**
   * Packs the object into the bytes buffer, beginning at offset, based on the
   * requested byte_pack kind.
   *
   * @param bytes Buffer that will contain the packed bytes at the end of the operation.
   * @param offset Offset into bytes where the packing is to begin.
   * @param kind This int indicates the type of byte_pack being requested.
   */
  extern virtual function int unsigned do_byte_pack(ref logic[7:0] bytes[], input int unsigned offset = 0, input int kind   = -1);
  
  // ---------------------------------------------------------------------------
  /**
   * Unpacks len bytes of the object from the bytes buffer, beginning at offset, based on
   * the requested byte_unpack kind.
   *
   * @param bytes Buffer containing the bytes to be unpacked.
   * @param offset Offset into bytes where the unpacking is to begin.
   * @param len Number of bytes to be unpacked.
   * @param kind This int indicates the type of byte_unpack being requested.
   */
  extern virtual function int unsigned do_byte_unpack(const ref logic [7:0] bytes[], input int unsigned offset = 0, input int len = -1, input int kind   = -1);
`else
  //----------------------------------------------------------------------------
  /**
   * Pack the fields in the configuration base class.
   */
  extern virtual function void do_pack(`SVT_XVM(packer) packer);

  //----------------------------------------------------------------------------
  /**
   * Unpack the fields in the configuration base class.
   */
  extern virtual function void do_unpack(`SVT_XVM(packer) packer);
`endif

  // ****************************************************************************
  // Command Support Methods
  // ****************************************************************************

  // ---------------------------------------------------------------------------
  /**
   * This method is used by a component's command interface, to allow command
   * code to retrieve the value of a single named property of a data class derived from this
   * class. If the <b>prop_name</b> argument does not match a property of the class, or if the
   * <b>array_ix</b> argument is not zero and does not point to a valid array element,
   * this function returns '0'. Otherwise it returns '1', with the value of the <b>prop_val</b>
   * argument assigned to the value of the specified property. However, If the property is a
   * sub-object, a reference to it is assigned to the <b>data_obj</b> (ref) argument.
   * In that case, the <b>prop_val</b> argument is meaningless. The component will then
   * store the data object reference in its temporary data object array,
   * and return a handle to its location as the <b>prop_val</b> argument of the <b>get_data_prop</b>
   * task of the component. The command testbench code must then use <i>that</i>
   * handle to access the properties of the sub-object.
   *
   * @param prop_name The name of a property in this class, or a derived class.
   * @param prop_val A <i>ref</i> argument used to return the current value of the property,
   * expressed as a 1024 bit quantity. When returning a string value each character
   * requires 8 bits so returned strings must be 128 characters or less.
   * @param array_ix If the property is an array, this argument specifies the index being
   * accessed. If the property is not an array, it should be set to 0.
   * @param data_obj If the property is not a sub-object, this argument is assigned to
   * <i>null</i>. If the property is a sub-object, a reference to it is assigned to
   * this (ref) argument. In that case, the <b>prop_val</b> argument is meaningless.
   * The component will then store the data object reference in its temporary data object array,
   * and return a handle to its location as the <b>prop_val</b> argument of the <b>get_data_prop</b>
   * task of the component. The command testbench code must then use <i>that</i>
   * handle to access the properties of the sub-object.
   * @return A single bit representing whether or not a valid property was retrieved.
   */
  extern virtual function bit get_prop_val(string prop_name, ref bit [1023:0] prop_val, input int array_ix, ref `SVT_DATA_TYPE data_obj);

  // ---------------------------------------------------------------------------
  /**
   * This method is used by a component's command interface, to allow
   * command code to set the value of a single named property of a data class derived from
   * this class. This method cannot be used to set the value of a sub-object, since sub-object
   * consruction is taken care of automatically by the command interface. If the <b>prop_name</b>
   * argument does not match a property of the class, or it matches a sub-object of the class,
   * or if the <b>array_ix</b> argument is not zero and does not point to a valid array element,
   * this function returns '0'. Otherwise it returns '1'.
   *
   * @param prop_name The name of a property in this class, or a derived class.
   * @param prop_val The value to assign to the property, expressed as a 1024 bit quantity.
   * When assigning a string value each character requires 8 bits so assigned strings must
   * be 128 characters or less.
   * @param array_ix If the property is an array, this argument specifies the index being
   * accessed. If the property is not an array, it should be set to 0.
   * @return A single bit representing whether or not a valid property was set.
   */
  extern virtual function bit set_prop_val(string prop_name, bit [1023:0] prop_val, int array_ix);

  // ---------------------------------------------------------------------------
  /**
   * Provide string values for contained_cfg_opts.
   * 
   * @param prop_name The name of the property being encoded.
   * @param prop_val_string The string describing the value to be encoded.
   * @param prop_val The bit vector encoding of prop_val_string.
   * @param typ Optional field type used to help in the encode effort. 
   *
   * @return The enum value corresponding to the desc.
   */
  extern virtual function bit decode_prop_val(string prop_name, bit [1023:0] prop_val, ref string prop_val_string,
                                              input svt_pattern_data::type_enum typ = svt_pattern_data::UNDEF);

  // ---------------------------------------------------------------------------
  /**
   * This method allocates a pattern containing svt_pattern_data instances for
   * all of the primitive data fields in the object. The svt_pattern_data::name
   * is set to the corresponding field name, the svt_pattern_data::value is set
   * to 0.
   *
   * @return An svt_pattern instance containing entries for all of the data fields.
   */
  extern virtual function svt_pattern do_allocate_pattern();

  // ---------------------------------------------------------------------------
  /**
   * This method allocates the same pattern as allocate_pattern(), minus the
   * elements which include the `SVT_DATA_UTIL_DYNAMIC_KEYWORD keyword.
   *
   * @return An svt_pattern instance containing entries for the data fields which
   * do not include the `SVT_DATA_UTIL_DYNAMIC_KEYWORD keyword.
   */
  extern virtual function svt_pattern allocate_static_pattern();

  // ---------------------------------------------------------------------------
  /**
   * This method allocates the same pattern as allocate_pattern(), minus the
   * elements which do not include the `SVT_DATA_UTIL_DYNAMIC_KEYWORD keyword.
   *
   * @return An svt_pattern instance containing entries for the data fields which
   * include the `SVT_DATA_UTIL_DYNAMIC_KEYWORD keyword.
   */
  extern virtual function svt_pattern allocate_dynamic_pattern();

  // ---------------------------------------------------------------------------
  /**
   * This method scans the sub-object hierarchy looking for sub-configurations.
   * It returns an associative array of the objects, indexed by the paths to the
   * sub-objects.
   * 
   * @param sub_cfgs An svt_configuration associative array with entries for all
   * of the svt_configration sub-objects, indexed by the sub-object field names.
   */
  extern virtual function void find_sub_configurations(ref svt_configuration sub_cfgs[string]);

  // ---------------------------------------------------------------------------
  /**
   * This method allocates a pattern containing svt_pattern_data instances for
   * all of the data fields in the object that are related to debug.
   * 
   * Regular expressions are used to identify debug features that will be enabled.
   * If these expressions identify properties that should not be enabled for debug,
   * or if there are properties that are missed by these expressions then this method
   * can be extended and the pattern can be altered.
   * 
   * @return An svt_pattern instance containing entries for all of the fields
   * related to debug
   */
  extern virtual function svt_pattern allocate_debug_feature_pattern();

  // ---------------------------------------------------------------------------
  /**
   * Parses the configuration object using patterns and enables debug options.
   * 
   * This method should be called by the top level component in extended suites,
   * immediately after the configuration is received for the first time.  It is also
   * called automatically when the reconfigure method is called.
   * 
   * @param inst Instance name of the component that is enabled for debug
   * @param path Optional argument to provide the hierarchical path to this object
   */
  extern function void enable_debug_options(string inst, string path = "");

  // ---------------------------------------------------------------------------
  /**
   * This method sets up the fields indicating whether PA support should be enabled automatically.
   */
  extern virtual function void setup_pa_plusarg();

  // ---------------------------------------------------------------------------
  /**
   * This method sets up the field indicating whether coverage support should be enabled automatically.
   */
  extern virtual function void setup_cov_plusarg();

  // ---------------------------------------------------------------------------
  /**
   * This method allocates a pattern containing svt_pattern_data instances for
   * all of the data fields in the object that are related to PA.
   * 
   * Regular expressions are used to identify PA features that will be enabled.
   * If these expressions identify properties that should not be enabled for PA,
   * or if there are properties that are missed by these expressions then this method
   * can be extended and the pattern can be altered.
   * 
   * @return An svt_pattern instance containing entries for all of the fields
   * related to PA.
   */
  extern virtual function svt_pattern allocate_pa_feature_pattern();

  // ---------------------------------------------------------------------------
  /**
   * This method allocates a pattern containing svt_pattern_data instances for
   * all of the data fields in the object that are related to enabling coverage.
   * 
   * Regular expressions are used to identify coverage which will be enabled.
   * If these expressions identify properties that should not be enabled for coverage,
   * or if there are properties that are missed by these expressions then this method
   * can be extended and the pattern can be altered.
   * 
   * @return An svt_pattern instance containing entries for all of the fields
   * related to enabling coverage.
   */
  extern virtual function svt_pattern allocate_cov_enable_pattern();


  // ---------------------------------------------------------------------------
  /**
   * This method allocates a pattern containing svt_pattern_data instances for
   * all of the data fields in the object that are related to enabling coverage.
   * 
   * Regular expressions are used to identify checks which will be enabled.
   * If these expressions identify properties that should not be enabled for checks,
   * or if there are properties that are missed by these expressions then this method
   * can be extended and the pattern can be altered.
   * 
   * @return An svt_pattern instance containing entries for all of the fields
   * related to enabling coverage.
   */
  extern virtual function svt_pattern allocate_check_enable_pattern();
  
  // ---------------------------------------------------------------------------
  /**
   * Parses the configuration object using patterns and automatically enables PA options
   * if #enable_pa set to '1' based on the svt_enable_pa plusarg.
   * 
   * This method is called automatically when the reconfigure or enable_debug_opts method
   * is called on any of the top level components.
   
   */
  extern function void enable_pa_options(bit enable_debug_opts = 0);

  // ---------------------------------------------------------------------------
  /**
   * Parses the configuration object using patterns and automatically enables coverage
   * if #enable_cov set to '1' based on the svt_enable_cov plusarg.
   * 
   * This method is called automatically when the reconfigure method is called on any of
   * the top level components.
   */
  extern function void enable_cov_options();

  // ---------------------------------------------------------------------------
  /**
   * Parses the configuration object using patterns to see if coverage has been enabled
   * on any of the layers or protocol as a whole.
   * 
   */
  extern function bit get_cov_prop_val();

  // ---------------------------------------------------------------------------
  /**
   * Parses the configuration object using patterns to see if checks has been enabled on
   * any of the layers or protocol as a whole.
   * 
   */
  extern function bit get_check_prop_val();

  // ---------------------------------------------------------------------------
  /**
   * Checks the PA related flags 'enable_xml_gen' and returns '1'
   * if any of the 'enable_.*xml_gen' is set.
   * 
   * Clients can override this function if requeried to be.
   */
  extern virtual function bit is_pa_enabled();

  // -----------------------------------------------------------------------------
  /**
   * Record the configuration information inside FSDB if writer is available, if the writer
   * is not available at this time then register the data, when the writer is created the
   * data can be written out into FSDB.
   *
   * @param inst_name Instance name of the component that is enabled for debug
   */
  extern function void record_cfg_info(string inst_name);

`ifndef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * This method returns the maximum packer bytes value required by the suite. This is
   * checked against `SVT_XVM_UC(MAX_PACKER_BYTES) when the configuration class is
   * constructed to make sure the provied value is sufficient for the extended suite.
   *
   * The default implementation just returns `SVT_XVM_UC(MAX_PACKER_BYTES) value.
   * Individual suites extend this method to indicate any specific requirements they
   * may have.
   * 
   * Note:
   * This method should only be implemented by suites that require packing/unpacking
   * operations for normal operation, and if the default size defined in the UVM/OVM
   * base class library is not sufficient.  In this situation the VIP developer knows
   * that the user must provide a larger value on the command line through the use of of
   * the `SVT_XVM_UC(MAX_PACKER_BYTES) macro, and so this check should be performed in
   * the constructor of the configuration object.
   * 
   * Not all suites require packing/unpacking operations for normal operation.  If a VIP
   * developer determines that packing/unpacking is not required for normal operation of
   * the VIP then this method should not be implemented (and the check should not be
   * performed).  However, if a larger value for `SVT_XVM_UC(MAX_PACKER_BYTES) is
   * required to complete pack/unpack operations for specific transactions then these
   * operations will fail if the user attempts this.  In this situation the VIP developer
   * should determine what minimum `SVT_XVM_UC(MAX_PACKER_BYTES) is required and should
   * implement the get_packer_max_bytes_required() method in the extended transaction
   * class instead.  This will cause the check to only be performed if the user attempts
   * to pack or unpack the transaction class, and so the user will only need to provide
   * `SVT_XVM_UC(MAX_PACKER_BYTES) value on the command line if they need to perform the
   * pack/unpack operations.
   */
  extern virtual function int get_packer_max_bytes_required();

  // -----------------------------------------------------------------------------
  /**
   * This method checks the packer max bytes value required by the suite. This
   * involves checking the value provided by get_packer_max_bytes_required() against
   * `SVT_XVM_UC(MAX_PACKER_BYTES). It also includes checking `SVT_XVM_UC(MAX_PACKER_BYTES)
   * against the `SVT_XVM(pack_bitstream_t) size to make sure that the define
   * is consistent with the buffer storage which has been allocated.
   * 
   * If the user is using multi-step compilation and has failed to specify
   * `SVT_XVM_UC(PACKER_MAX_BYTES) on the command line then it can lead to a
   * compile time failure about an unrecognized macro. This method isprovided
   * in unencrypted form to simplify the recognition of this situation. This
   * situation can be resolved by adding an appropriate `SVT_XVM_UC(MAX_PACKER_BYTES)
   * value on the appropriate command line.
   */
  extern function void check_packer_max_bytes();
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//svt_vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
ZH0KLdZIEayrtdntplcHrKFgaDlUknUy3u2x9hK6qjiBKs6mi757BVGmvj6quOkg
cgzAlDlEobQ9rDZJhXdel0OOhPO1P17wA7ndsMpPK0hpHL/E2+F7y7xgfFiBb0k0
tPGkZXk+rrAOesFulpPT7rU0CHkplkvRfufAfM+vKI8=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1741      )
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
+c9axKta2YZkdQLEK5uzeA==
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
pKo+GXJk10kk72kU48jVesLR2pcpx98U5v2FLc0J8zqDA4cjtswVIKujc6Rat01Q
aU5vCHUWYwR5DD+6jw5GqlTfICCE737as9Ae1MIJh7JNTs1QGFdfxIouw2R4qYgW
SRD+70t67HuC8EtiJNPDouWThDubWcDQhy1I8jBmwyg=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 30361     )
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
QK80JYyerqc2grez0Lzi2wJOdmjWvjK2rJAFgVwAhdabAWpivBPGcu3KwS+Jd6r7
ChCbda5zJT7j1jW0Oyx6THCna75MhVl7QwjzMgh7FNPFPQjkqqvPQlR07zmlj1uF
bt65/Vx2pptzyK15pS0x+I+Y2dow35QzkSXgpZ7qpzQLJTCAsFz093keZ18xGZJ5
BOgFTTHklcr7bjU4hk63ZVWD0XAvGWBa8CYOUTa3gpbA/qZb52atrbkJhj4FvJpV
oINDjLfe/FlhSK6JjtptmbnbCS6PYN4+LQecwjWB2YlFXXnjkftU+qPnDTM9N7YM
+OidXrMNbrh9yqnDTjxHr9C91J01RhFh6K+LwzNcsCHWa+html45SqIY8P4ihjnp
FwM6fZ+6hWZwnE+Nc3cYKoIdNs+5ZHPj6+nxMDBqNHSRF+hrKO6YpwjGj+KaOhDx
hT9wkqxIDU3puFPDYX2ol/dj31pVnmDxiy3w5dDTjQugczZP+IqyUr+t9dKTzxfm
s5jpLUygDiMEeyCeR0rnzTIdePrXfFxbfaywa5W5XhPCj4gw6wAv7sycDSuYYWrv
f5GpStuMujCfen6ltlc1BvEKBe1phCV/PBwf59zSli3xLnMcmFCz6JzOJm1dElDn
6O3joRg7CLnyBVcQ/pS0o2MbRbKl99hi1UcEItbzzdv2h2+IMbB82oyblzwR3zCF
md/zjOh06QMTd23q/d7rq6SqPePTHcmDXrIYivb95EgL54z9/Suv9LuLa6qa/che
+cUwLhulRM8FQn7/lXCQ1E399apVBAhLvnc4IDUHEMgsTEGzvXkJar+aTMZ0visx
XEPCIVjsvqmhEs77vfpn1ylLJXBzTniFNIcAqee72MhgI7m3mYfySNxF9/KKo4DF
XePxZbyutiTuMbHSsl2GQKM1pNpVKC07ySlp0XXa3D5DiiXpUEEOQkRkTdZ5k1Fp
gYYZIuUVns74WfEHrr5ulRge9XDhLuhUJUZn54LsOIbRIS/BP/roZdnugSa0sfdo
x+PVlraOg+UrlknXQ7h50XJ2KRupiqkB6A927h4q5XUG5Sd/NLJ5GDcWhdkuSM1Y
LDPrREol140u/cuUY976gxgHeqpDlJRrHh5Lae/XaspEWm8yoqLVl9JdT5u2u2X/
1jCIb6/9Efa2cAYdqnM6SgLcy456CS998Fmydr5wBv5LtQ2X2hFMm8g8jp/VDq2i
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
I8ibWT7XARBRDHzLLn+bXw==
`pragma protect end_protected

`ifndef SVT_VMM_TECHNOLOGY
//------------------------------------------------------------------------------
/**
 * NOTE: This method is left unprotected in order to expose the PACKER_MAX_BYTES macro.
 *       This ensures that the proper macro name is identified when the macro has
 *       not been specified in a multi-step compile situation.
 */
function void svt_configuration::check_packer_max_bytes();
  if (`SVT_PACKER_MAX_BYTES < get_packer_max_bytes_required())
    `svt_fatal("check_packer_max_bytes", $sformatf("%0s_PACKER_MAX_BYTES set to %0d, but %0d bytes required by the %0s suite. Unable to continue.",
                                `SVT_DATA_UTIL_ARG_TO_STRING(`SVT_DATA_METHODOLOGY_KEYWORD_UC), `SVT_PACKER_MAX_BYTES, get_packer_max_bytes_required(), get_suite_name()));
  else begin
    `SVT_XVM(pack_bitstream_t) bitstream;
    int bitstream_bytes = $bits(bitstream)/`SVT_DATA_UTIL_BITS_PER_BYTE;
    if (bitstream_bytes != `SVT_PACKER_MAX_BYTES)
      `svt_fatal("check_packer_max_bytes", $sformatf("%0s_PACKER_MAX_BYTES set to %0d but %0s_pack_bitstream_t only contains %0d bytes. This indicates the %0s package was not compiled with the same %0s_PACKER_MAX_BYTES setting as the %0s suite. Unable to continue.",
                                  `SVT_DATA_UTIL_ARG_TO_STRING(`SVT_DATA_METHODOLOGY_KEYWORD_UC), `SVT_PACKER_MAX_BYTES,
                                  `SVT_DATA_UTIL_ARG_TO_STRING(`SVT_DATA_METHODOLOGY_KEYWORD), bitstream_bytes,
                                  `SVT_DATA_UTIL_ARG_TO_STRING(`SVT_DATA_METHODOLOGY_KEYWORD_UC),
                                  `SVT_DATA_UTIL_ARG_TO_STRING(`SVT_DATA_METHODOLOGY_KEYWORD_UC), get_suite_name()));
  end
endfunction
`endif

// =============================================================================

`endif // GUARD_SVT_CONFIGURATION_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
X+cZSnkn6XXDH4eV5ZYahnIfZibW8y0C78ReZ2SpsGbWzsqTeAsRj8jmMRO6VgMF
SM+u/+/Mu9crvY67oUujEruqLw51qN4aizY4S+S6qtfu8zZ0H77d9dKN2KEKscUy
FE4ZKAEMfMpPRLa7oPTirgiZj4R+Hqsw/IbWTn1ACQY=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 30444     )
Z9uLWh25k3uarRHEfYnoiDs0mCMY1M5HiIUD6qo8BPEQO9B44SsL+Pn8vOqfyZaq
2z7LnPrs2BvjfH4jKx2EFfv8pxsLz7QRScuRxXoLxa1Y8CVydmACcbPeFmnIqBJh
`pragma protect end_protected

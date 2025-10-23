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
`protected
+GbTOU=L&b[7BC^MEVKgH+KcaBOWK(L9-W1@1\/;C\AK9DX>EJLF+(9IUIe-SG(N
fE@4O^#;1:23)KVDDXU2AgZYSc/Q2fgE#4?]=M#PBQ)R&M3SS.8ac.K:/X5e@5c&
]4c68)g4+5],B:6C<6>B>X6-Tb@1SA2eD_^#Z)H5@X>3U\0]HVN2[@DQ0XaL(CO;
dT0>WWa>LZ8?7/]bH<JfO:X595ZKT^_MBTRG,N.cNY4IYQM,VYKCT[2O7?VVYgCY
-^OMg7T.ceg=_9Ccgc)D@-Fc3/?FPFg_G@9Sa88g1BE;Y:HV7XTXf?5:#2?=,3I0
1OB:)MST#d:K/K5<c-OA[/gNa&IgC#bW-(CaD]^TY7_Pg0eQ.(@Ie62T0/dg-SS/
,F@^\KF-&UKL#,GUEY8N/A#7OI\]V-NTaJP24[B&NIb2]H)(+e<&Uc1P-OX?YT8e
>e^^e1A]FEHD^EN+?,;;GY(QfXQ1EEcb>(=@gLQ9ePB?d7YS5Ga24A<H0.E8HSf4
S<9RcXBL/@?T[fQ1TU+.AOC06W>>eE[JBP^b9+_c2/&=4K:^R?U(0)7a#@^+/B[0
e+<4aH1:O1+IV6#IbNQXGc9)Jb5+F,#UgPg@2XC38D?2&./b=Z6baD<X/6f8EVRD
5S#),WFRF7AJE6QN3XP5,4W_LTf13Oa#afSb.DH]-V],=P9J8UREFA&XDW,-&9>0
GXRRU#0H(C\;5eC\S5CGS786\W3=GfaMU1SA3;&/DR2#]eG55,K[5^XGF.-@-R..
-/5;S);<9IK^bC+[4K>L6QKND@?F):eUACF_P<CaN+-Y_U5K=(1aCP3KXL_6Sd0?
]_eMaaE2QRB@aCK#TY#DF9N/M(_.f2WZ<ECU^X&7\Y6V>RZG;_c:(0gaNVZaN9SV
g8Nd31VAPOMTP8]RRF)>+X/=?6Wa<?N@eS9a3[0MKOQ(68+gIM&X\Ce[#aC=Rad7
aP#?=.TW+U@6^O24_XUZ#(QI@D/AKR9/;,c:4<5#@_F+\7^/=W3JSbb([9&O,.WB
2)OO4aAP#C7U7@02^64ZEX(USPgKJaV)C[Ue.TO#P:.A#]C0)SdBQQaY<D-MIA/U
B@.D0\,(c0f[YCUUW&a;M&Z-&M;NXD,Sa)6AOK;g_]523\(U@:\.6RL#IP[]I4=O
XRFJ8=gf[6/PPE4Q=ZL.&(^GOD\C)FC/,Y-5U=@&e6?ZFAN&98S2#]H,Y?W<9D3[
DEZWS4=T(19Zde0FJ3F62V+-dFJL6O6;N?)&]M+K3#a>@Q9L0]ZL^,JdR5=H/9ZZ
\7d400\GXR#X6F/PQ\9:@[[=d.Jfc+6F/6U>QB10#XJ0?c_3\<d.)=2aDL24D+,P
&XdO-^/B<JZ&P3@Z3+]D516ZIOJZD=<:BHI0IZYgGGR?^@+JY?XYEF,f+&Z=bc3G
=UWR?0G+aNQAg(\K.P86U58E)L_;Rc51D3Zc&#I1J8LG:/;82HIaF)JJ(/2K9[OK
fMK_U4TX^U<5G5HR^C([P?_=(U[KV]27Y&e&X_I4Y1PG+BRWCc8Q)\3WQ33;;[GI
c4cX<M9d)#@EW<NJ);gI:D^0DSJL1I+659eX5PA>ZTcI+Ia;,1/V@J3g5JFPUaT2
LVI,6OcK_6[[4gQcTBVBJ;/FQ,/A2O6a0edOb&Gc_K2<Y#bFP.(9):Z0NO?=fbO;
H(8@R-XZeRF[PYJ(Gg&,+P92,VM-,<Hd6&7D6@:f6EM;TTZ:<Z_dRXe-<?gJc4&Q
cZ6IB6bL5eLW&=V2RPYPOI<_KV-[(U0L<EO4?H@WM31.bYc)H??#Q:E<#Eb:]KG\
TRe[&]\8Z[,g&/<Gga2TT6LSPXXW8L&;I89/3&Sf374LNYe2?TTED23I#663]^BT
H&6:MZ#2b(J=cT]Q]9]>CIeVO/Ze):D+b?:JY:RK9^REAeF0Ue81L?^N4&X1gfBK
7e69XU4=B^WR1Q#+AOW67D_K6BgcgR45.UC=GZY_I?f(XHJ&eYLXK?e,Wc58A-LG
^82/C_(M\?:4H0#03?;)F=[VB,bG()gGdN5D1P)R42>]6gITW)I)M2D&G6^MW\g(
;ZJa+A,La/c\:Z&_d6CWa]]G/bYf+_]MX)I@dA1g\Q&ZY>=EJGcJ5E1g(bHMFdH5
E=,#bYLeaOY/9Rg7-0ID[.\@Je[KB5A?H09a<EAKLU@<E2.Y15,8,TOeZQ,,F\fB
#<:01H(S6Q,XU&6^-4^(2=d)R]<_B&#TLC:D194+7XL;]6BKJXeG9;d(+eY87KJ[
T&WD=F_d5/Z\9B;fLS=[VYQP[0R6/PW^g?HKM<EEW<G;C$
`endprotected


//vcs_vip_protect
`protected
=Y?\,8R>g_Ca:Ye):,XKFDDW=P2MO<.\g]NY3b.YMH?OB[I/=DM:+(XR\?\C_a7^
ca]b^eG/dYcKfX[U9[:2H3XI3e6dYQ.P[:f]<P+[F()GL/Ng=)X+aQ@03:?OOe6T
d]N.@,1@SN9+TP2I.5PfK,.\_bP\:aWa@55^+NG\RNPO2/(?G7)&CTG?)29gX4Ua
8dcQg@<WcBT-cWSM&Z2.bFI\<ccC?,[.fH0Se8,K4Ra7797(&UTPH=d@&S#1G8FL
/<eII)[_8eO6.J0]gS:T8gCCWOF./,N<K9\>_\Z>>,E;\+b^P@AI89O+&fH+0=\P
]55:WOG.^g6SVd4K5IRC>QD:-<O6R5db=aeHP<U^^K5_+D>X^<;B7F4VF?@^/Kc.
RTUDK5>BA@71,L6SbL:,d)@^Z:48-2=#B\2;]aX;@(NW4JMR/RZ6FWDQ#.b)<]GP
XJWgdVF,8)2Q)I7QJDO;-Q:_VOAP\8dNPOS088]Wc.V><bI,73SXcR/2>08U9ZT6
@-GJ4:58VSF0GW[@S7PgCf>KSYNE.<E69RZE0(&g)/4Vd]-1;CMI>:)K2Z1Q6T\B
<\<aJ1<-8<bN56RQ=/N[9fMP:<]3UYH#MDTL8I0_^b]>0Xg[dQa.IPP8BXM.)e:Q
T/K,)N6c(&8?,PYYOGTL=Z8\(Te7BB4U^d#e[M#Xc27[3B(3EBTA#6_WDbFZL9ce
I8/R>_N,J>)(>/?aI?)9cX[OF>RKd2UN4-Y(^5gZAe?BU.Z014-62LcMO5#8.eU\
VecRb@A0DBVV<<X6fbc\<eJS(SA&/<N306U?]F=2W(<R0_F._<NC[G:R8J[JaSHa
W9<MQ;1@c]H,.<>&KXT6)KgBRXeSZ&OM9C;+NQF_A@OXdd<;c;eJY8C\81?X@-Pd
^/Z7==2D-[11JKU_J:ML:KfDN0#dT2SD;+;Ega3JCSWEWH@6d1_&CYY-([/8=@LG
Q54-RZPU6WO:5_3+6;K]/LBR77O);:I0/(URN+8Ygc-3DK)]5@ZdYRBI7e<E,<OJ
)&a9MR\bUR,>R#/,>KHU)Q.VNKI\_<5+FeI>4+N.ZRD#P\;V?BQ3g481^HQY+-Y+
/Ka>/.f8?&C7ZNUYU;09]&T=0\>28Jc=(3cW,:&TVa#T(A#Rd=DMW25NQ15Pf0U@
Y-NP3H2;JWg@>6,+T;^OE++YU:bLYQ_XK^d[#;5gZS<fTfL+7JcJ^URO:BgI7ZAO
,b&MGd&9Z#J\9FcVVG9/6/Z;BL6,Y.>R\K9gb^DHR+a=C[A/30/0::)3L5ET-[)K
T-HE&/&6(Nb\AaP^?JOX&d;I)<3E=PN3d,Yg\Z4XD&_[4H^589AT<3,,Z7Ue4/6\
1NND./JD/T7KKNPc.gbeQ1[VS+_gG&Z=FM2W:g9K\MPE.)A,.JN7cgE@CB(<O(3@
?YdR^2E[0HW@#JLYMbZd-#WVe\K];3UDDEb(MU/D+F2Daa6)1\-MWL^G.0NAI@-(
#4f-:,SC^egB^V@>MTb[V)S<14e28MF+L)#HUeac<KHf:])16BeA:4aCZGJ66N1?
,>=4<AeSGY[W.,>MLMQZF+\\X1cZd3\<V/G-5&2I6>KfJVZ6RH?<2J_82VQ[dZQ5
AQK7fKW&<9?FOB\=<;=,UA\L+XY?G3R72g#\D/bV.Z8UH[V?e5B(Y=:SACE_XDPO
9=.GFRN(]DQOXC3VO4P]Z)QcQ0b0LaM;CV2C3@LS6:GE.&H<4FeCO9<-7;_77^bA
5#B3QU\S?D\1-:C,S=CE_]-)E3_Gc0MWC[Va.+=5;SHPVU]#eHG.<&FX>2L^-BP>
BZaK8&7gfP6A-<AWV#:BOb&e#_ZM,g[[08R^K;P58R?N9^-D]=O+e/#J4(1QA(@J
V@^F(>,V6BSS(B.NJZ8ae\OJ>)N7K.?E2,X].149KNO6AFXC\_</7eRX54LA+P0[
5ID8UL((K[3K9^K8TA@.W4+AWEVG/0c@E[NJ#=JE--eX\(H:g^]9JZf,O_K4-gZG
84NbJ?&K8,NL63[g@>eZLECZA?)?EOYB&KY;:XN=^Gc.g#2K(5WgRfK?Qe-AUB;+
7O3=61#01(2&9J-e1[3fWGSfGRGM/bY6-9=FMTe=M6V-YW-1RX3A66Z^YbaaT:gL
W>]HQ5D#]Ib<LKbAR<9IBQFL8&&8Qeg#,2fEL04.WTBc)GFV.^&,VWG0O2]EI:_9
-E0=8(HE:WA]5&XaG\<b_6/cEGP-S)1?IN;FEe7&/K:RIc6^P)U9E(68(J@g.UAc
HWWPdV1Ff/c-GbO9U[,^+_f@GG]bJSa<067H8Ke(0J7OCfY=/f:A+Nf6=fbNbKFU
aA]KM.9X>YP[Kg>]S5AaWA9MC[=</\^B&Mc&WXMIR,7-/A)HVHZR8#-2We^+0TTS
;#BJ.bF6H8_3f(>-R/O[_.MFd4]Q0]::@Z&F5[S:,--RQ;dEg<&Fb661\dd7b;b0
PAd)463:H7T<YD_4H0YDS[bcaLNQT0J7Z=31,LZX;U]d^^2>.);adHSSR5aRgB+^
LX\X)4?GT5X;e=J@g,-FA?GAG:2fDN\e:?-H8UcB7<#),[APHJ?3f<-(T>29114a
8KB-@+FS7f6QU#_AS)&dBH3TWANgRK[)T.d=[_(eTZ.5e,)gDC1D8@<[[f5CY/0c
&.WfA(V\f#6?N3N56aH\G1@F)K@a3d^I3D&=Se5(@bU>.TZI]M<faO3CVOJd&>Qb
7VQSM3YgC0fQQd@3Ag7;\4WCg&]gf]XH=V7/X8QXU#&b9aA/A/OH6+XDX?:5U/JJ
3FU8.(4,^WO^G8D-6;QNb.<[^1NV+D]U@C:42<SK6P&.-TN<VFZ68-#T=K=Z<gO?
X8)HEOBRMZO<)<_[g<F^]=>I1VMT>[ZFb-:PT_I^O6M_7?PZMXWg3ONU/7F^63:V
ZM8#P=HeL&F[_X1;ZV@Z,FZW]6a.Ab^0\N@@bPP5=_D)bVePKLeMWOYKVBRRV1MS
f:gUf:NCI@a,TF;F+3:WP@D@;->>4fE_JS.U.,..PKG/W):[88cPK0/<+K[7?8]X
#FS+&#3:[@fN3(T5>M;3\8J<Z#-AgU<O6[AH-;DT8?2fT1(bQVIY2BHbBXg<We:W
IO,D=CHR^>30CG8D]_O)]AK)QfKH3]A[.B3L=@c4--,_T,QP\>]_e.V\(4:R[:(N
)_5da,&#^+9T_bU__Ma&XMTSJAe7XMXJSE^>]Z.<4/b4QK[W<^7\\MB^\bY+.X99
]Q?X#5HG>Y^Ne8?C:GCI=)e#FE@-EBH_aDNI9RITK@Q0#,?),5C;TI2^:ID##8ZP
F^2-B+L@ZP@A>\[3b/=DB9LC,,W)\F;H:67Wc[6eD+>W_F\XX5KI5J@ZE&^(<WX_
OeBD/aK.b&bb^+R=YL9,-38Jd[Tc?EeSfA:IF(PHB,G]A.eK4MQGb:-/D4>TBTBU
::/<g;U;.79HK@]<#VBc0J(W=.[:C05;YN5@PG+-Hc9Mg(?PMV[J;7(Bc/FLN91G
SaPTQ,<C;BbeeK.RG:]1JO_U7A6ZY](XMIW<L1OEec(<64I.IO\CJG6g_U/YOQPC
/?-@RV@PU?Q.EWT19LLNgGJDc937^=0VX]AZE@a=HPKVAG7eH&dAb+@G+@OO&HSb
1NXKZ.<[>ZKE[A79M2R^a29-AWW)U?CP<#HA?F.7-?CB?(+M82^ag,IT_K__G(:-
_8=KA+R+C-K#UbG=0#d4J7+?QSDQ&#)4\^@.?-)dAb1:FGAKJZ:=LA;G9a>^&gYT
-1INNK.e_WS;,QbA1Je6_>H8==17EM#,E=T.]a:aC]_U-.\?0NJVSd[6]4UC4-.H
K0cX+Ngf>65Lb//A\NONO_EB2#aYfSAX>\+_V2Tf]6=eYBANOG2LS[b)+gF]+1=H
]#Q7Y/M&-?+?<;Qc??RFZ.#RF.0.-J^IXH6RG>HH3]PW.P.2?7La_Qea1c1[cQ+&
S^=+GG61P9#]R@>>C^=).OW366-=LZ\/UFTM&d24a&\)KT:4Lg_eF=;;?LB+N_PL
8J]8ae[=R).0\PAV=/Z0H/-?T<GNWT#CGA4c=X(M3MeOZ^2Q(IaPXM^SY#G)Z[25
GLa=_:45Sb^XJ7[4c)Z<90(<[XPMU\RMS[=LEVHH1NgMU0G/D=Qe9(UZI#?c2Aa<
5G?UD\^-9H2=c#)X57=4=+Z)][5U11-\(K-@-:AKf<V9)+^=@U0g)AXXYB3Q<0^I
g\[Xf:c6:J+M]2601R^ec\QEO:#PKF^D(cE[DE11W#]b9HYE-,:0e23TV.&3L<M=
f3PZEI;L3;AN>NDLC4=W).;R/b]82B1^<9^_3[:;1]O(DCd<.T62Qe=A]>M_N<BA
^#RB9a&03afK)_DDWFCPada#6e#];&Fd-9)A?SPc3#)JA\T3N5@d,/5B]DfX56A8
8ggbe#,X5)</.Z8_F>6:f^:=4?TPBe,:L>3e6:8^M-2U^:2?L4.>B-@T-XQb2;RI
W+?<J^cI>^VPC4TOMc(<K<5K<2LId/)JO\Pd=K,X8<Tdg^BM753c,.RC>8.P1(Yf
[c/:Yd+K_]U6XT5E,G1(FM#aU@,G;BJW<=VCR-;[XL6;DY]CEK[#Y1+AU2He@Y?A
b(,?OY9P;R+V]b<2=fb]RHfYW2/QJ/XV,6WbfPZb?U5=JK(RM^faD2++;07#0621
(#^Ve7HI]H-^E07-#.R<gLDN]ELC1P7)6KGG4+Lg_Zb.CSGZOQRT(S1NOO0Me7;P
/2\eY=ef)WfJaY6ff\+3aVG8IfWY>,OAAIa_25?#GFWBE@,[\2a)<A(]_VZb=gNK
N\.=dR?L2W)[TDIFY)R(HSV?HI5SNc=^fT\I@e@I@#8aA9gTcRfGK4&]KP;5f4T6
E:2/R0-(g>@6XW-.YGNT(P;[R8AIMdZYfF(T3:>NJG3=gL<\,[2>LF-8582aF69)
9I#YGHc9NT:\U=K2<F(.NCF:gX&43>&7Y(&W=;_K\G2]\PIUS,0eab=\ML_>@5(A
ALaf65<Y<0X]WDN\J-b.b#WGQ+M_=9CPC8#L9E34H-P4NNX^89dgMP@WVISdY=Ed
3.bK)VSGd+((0_IU(>GY_#(1c=(BP>P+TGHG5?#dWV?T3Y5LR2f]bVS^B)1b/,2O
9YNXW)=d,=-2VH-c)Bf<(@H5;X@M<]S)b[KQXMERYZCT^AY&GHLAAb81\Z;LAQQ#
2.S:6&=.3QUe#M5dP&b7Z(^GCF9;[KP8FGX2aWOT0,\)bS/66[.8R-)OGfW=;3=O
Q.L_X]4Q/N<;RF?cVSFM+:C1,KZcSP5IWZ&A:0T(A(1g,,OAI6aP&Q#CbTXV8ULe
dRfcJV\;dd.>9,B1S+^S.I_9\3[P[=&RQ4V2N1MQ_@J[N+U>8>-87ZQF(:WARN>3
J712QV&.40+gE&VIaX(UP:[.XT?PMSaUJbI8Scg1Cg3aQf0<DLWELb,9XM6aA9H5
]K5V==^ZI9_8Z&9T5ce.B9?f)].cO:0SS\f)HbeD[0DF^c\]dFIAf#K&@>C/a5B/
TfRU3WWZG4;g;SR-S^24#;c\[4fTF1g?LY_&VWgJEU5S;\Tf+Q6,@T[-CIdSCV^(
>@N;:HB:D.@N9?VKC-3V5Q3BS@.>]KTJEf=RA6_7DY(4?//L:^]UL<E;<TL,>aDN
XB796bI)Sc&g\RECQZ1P1YPEYc[bcNSR6a5bT/OMeWRb.U;bQ#H9g6UcH#=TU325
S[TEI<OO)e6c0RF.?A<QOf.5?aWH.>:0KUcdABR4>/C1gb(/[\&Q,B5EWM02g1)U
6/C3Z+T:?5AeUA_fFRVN6>d#JIP+)a-G?P77NH:HRN]FK^>QK[5=7?.S.6b#aTXD
;0M+2Vac,R^9XA\T9//_g-[:Q71cV.Z80CU[f]:2.DHKf#7^KFIK2E#d7B6T\e?+
fV_bUYA?#@fMe/+G5C9g\R]UOAB^VHP1Le:KWWS@)<>aSXF)gRJDIC/L9#@bZ=OI
U\)670f+fY4L979]2;G#0S:JPM><F=2EJa9KL818:_@Qa1+V<404R@3?<TDa>SEQ
@0b^e;>/V@_Y7e.OT9)^0:Lad=<^N6<@_/(#8G/Md8d#9G7ae5V<V-6B5V34FOJG
89Nb=CUGcH&06A7DBUP-6^2UKV3f]LMKBSNYd/6IW9CV/QZ3J5X)3^7_>V+A<\?I
8C[gBX1S_PJO(:F/@[R^dBN6E]@LZWCS.Y0N.cE]DZfe@eK0(e633(BY?4OP35R<
6TbV)eTASOC>d?TMGea\I3T9J[@;cbR>93bb=Z+Bd,eA^(P9KOdG<Ig(SZ:UC^H5
F-.f]AUNHICK##],)e;SESJP&H3;W.a6<2FOKcB&8ML.CDb^4NXE2(?RGKE99b<+
K:>P^^A^ZOG-V-KZ2gQX6_N&Z@:9fEZ-.(2@.L52T;Ce@R8^f/I55DAF(I>YTJFU
B5&07P?F:#J_cQE=ZV/^4gRfW47L/CC0g5EP=6\0&M66LbBLKKKBRT]E.Z)PL19@
DO,3c_D+1ef^_8aX7LN[U_)P3dY5+^Y(&+=/2MTB\3P6.aP8H@c/DVfO-^.^[55d
,-F\SLD]1gNdK\X^QA2O0DYCcg[g8Df53R;f4aM?&B7D41^@@L_+@/R(eY^.8L77
A:I^AE:CCB2[F]2MV3_;^)>@T?XASc5X&>D#+g:@(9_abC:FXeg<^?dNPR(A_.LJ
MK=b:g/]g#SGc+AT>8<gREX/R),A1c-(@]<(FPFSXI#<P16c9T;/JEPO(]_?>KRc
?KQJ6D;^+g[DGTd,J[Pbde24Ad)H]]TS8#(&g/;\P:d8b<c:be#;d8OW&YVJ#81-
#+3IN6d95)bN+JR=S2[K:C,+C]+cVBP4CT1e^L^e^T:D-,CJ^/,S1>[H1)T>)U@f
+9N[ZRcU3#Vg>eJa-5^eI44EV([Z2D?EA-WH(;g581-BMN\=Q=K+(ObWCC8c2d9^
UCLV>4WH)ZF<dTV]0P>NAUESNedHKa^Cf666Z1Y.RK&\,e_b,dJ:^P^IcO1NLDHW
UeE5T^TRJg9#d&5_I7_^FO;NCF)+QCcSe73,C:EIW]?VJ)U[\5;OO5>2X^T;O-D7
M5)XU^-K.)CXC6;>D&V9?.8]@0IcR=6HaS:gO0I:.5+ad:E@-309J&]:cf):@L84
+?,@ed9M43CEd91^14Tc[X4:VLS0[DZR<(NE]&c_W4NO:314N_6OQ2J\XL(+SL]&
HP#(6^BZWHL^\I07P>,P8S9(3gBN?1-RQ.<RCLJ4U_J26)A242D-2\>X6J=Z+NLd
g#b+F[>(bYSQC-\0Q632B&3:TX7dMg5P,Z:T+^N<c&V0;e7B6#H6QS\5&OTX9M_b
HW2YT76##^d53LU++FCT8DX.I.TRC+D(6Je0&W2X&JFg:[45,_49GBf.LcVU9GXc
_L-gdNZKXW=,G7IL<QddNB9L<?JGXN2(SF3/;K(4d^[7BC71I(eURTE7EEaZ]LZT
8O3KJXS6Y^74:VLceHI&6MS6LK&GH;I7?4[9RAM)U>Fbg=C/PaX58KHO(Y31cO)X
8ZE6XX-[XF(TP9HR3P4;1KMZaB\NIH@73&L<>W7fLM,gJV0A<8[]F[8GD+g()Q3+
7+3I?D]Cg1KG?^bP0)7:/4@<83WC/\b&KOS5O[fW6C,,1TJZ3Gg,OP1TPG6#GQ7K
)_Z-,J[<AS/>Y;ZD_c0.W5HO5g8+WS9#<YM3#9GKS?ee0TaER],OYM]]\?E.,8?d
aULP-B17WG3XbU-=,/URUbQ7D6C^.Z4&+@4^D5^G8,/BG-3W;ga#b0]J>9UD,J_A
fFI4_faL-9-FFgA1#6cGOS@GAdI>1]T8Oeb=8352,I(>fc\ef50L2BCb3:ML6WX(
.1-ZH_C9<,9g[TONY_aGL0]EN_ALa:#fDP28A)B,fB_d[T^d+3&/8-QM,1ed^KR^
N>O#bJ;;XaHKWcSG[f/]KCU,^U<\(0D@ZbCA_I&WL<HG(:IR1GY#-d,GGZDaYWQ5
_Za6^OZ:TI-^[RD@V^4WgXc<N9PV?8[;>>R(U][Ue4]MaE<+<HUe=bG&C^\I7O9/
RXY(>]6/9S=PJV9a1#dA(1&\aCYPUHOYM]-+7Z9,ZVA8TD7c]AUVD)KO#YT5,+16
O;B,cBPOf.UJS0)6FG0AA(ONFbV:(#D1O/B6;T>ERVBYU-KW92B)g-W/PaZMc-_^
1]+7CQPK5[ZZXGRX8c@,>V^e0XFNO5,@HJ6(Y\BT>Y(JfF_\<[1ebKHV]2,(77O+
^]Z)&\cE:0PLEE53cB3UC5QYKN7F=751([?/fUb0@Ce6&\IIdf;OOCT:0<<eW0<4
@979H?51ZOK&A(U&MXA9?=&CbP.W;5Kgf:(E=RL34Z]cO4&\78b?KbG(SW.NS7]Z
VV1^EH>L<R:V:<CXLMgb[;TFT#bW6MH/\Q70^-5<^-#8aKbIQ4B7;>beJU.K)2(e
#b;BZ,U99DQ08CM,?VH/(@5b#I0VQ?/JW_,2dJ.CE32c4;GUf;,Y[1B]&[4D\UIc
UP&VU]&0AOHda<@:V8YC8R\B/g46A1/Vf<^CD2K.6_A8UHNg@;V6?N++^8(S32<T
_NR0E=RB;=/VdL+,+G@d4M1dBQ;a\=T9[>:d^:0R<7aFc,VbLW8D73V<ZaHJ]+6R
_T2?_=],DY7aC:c1AMJ5b)IVA6:IQRV;D.K)CaBec3#I4e(0e:Y?DBYLWP3(&S_2
X>3N[)9RQ\;MA,3C4]R3I_f;#:VH1c,7WVB<IO]MN[^2N.12D4R6]1PJJ2g0f3=#
>aZ;WfO4A[MY]KbdB6Cb:eS,f2DaW.I(^5GZE>Td2RM)X1??2Ye.Jd#)&\T[>0d+
B[S.fSf3R]WOC=N-]0C9FU?N,?;ZDZNRa(<b5I?a]gM/cCPMSgAX2OH_A2^7Y&<g
=KOLCTf-;AG3Z>Tb3BcfeHB8G<d&agAP,_7M[_FJGY1L26]8)>]Tc,A.;2f#B0E;
N6-J<>VGU2?AVfWN:<GOY?P(<)V4Xa>;_:L[HK3PT]7[J=fS).SQR]9391O2Z3eG
Oea>Q.6GQ0;:ET9[;68W,L,0c#<5X-g5KN)R?VD<Z2@+2^)&F69DRJS1=,M=eT)<
7^eKBe+e,cQTSfIXH\X,&cWPc;XMK0P/24>-\A94TW]gR[AR^7&W^<K?Q^M)6R2d
,FNN\b]dd\L&_9K[L6W#PUd-XaXSVGKP]^-]gb.I,1)B_3IEB3P3D]Y=T/EWFWXC
HNb.eN>=/ZZB,947d+XVbCF/?(?E29/A1_dZM8JEXM>#WV8F@>#gM>R#Vf&5F\N2
[,3/J)ZaJK4aK@cTR(U5P?ZT)7AW):I7/552Y&CZPC[f@^,XNS8--/&AQ]S3>5#K
Gg>a4)#GK.OZS&BZJe:XX/88-gfB#CG1VKJ<UHYg;/&OV\>4HX&SQ4^LI1#+Z)S&
aLQ+#WQ<?<eH)d&\.<JO,JB-:)(-S04(^&<C_ZZEdfU9/ZJ^<&Bd6AJZ+7\U&J0K
_#SEX2dCa@2JXNQbQ<Y)F&K4Z;AW4b>Y8YSX.G@d=+,5O2A34+JKA]>F97M6^]DX
c)PfR5>-Sc4&FDEGHcQXIYY]?Y,\5SRY9,J]^@@252g:VJ^VVN)bGM-KI7@+/^_c
^E(4]?>_e01\0NJe2L6<:>I9MBXYCg\5<S_/W,5+Le6=<X++RAHb;&+)C66;M.08
7-KM3d#()JZdG#c/]d0b\G:Z76e6Z<eYNeT(LW]fZIgV,LMRS?V,ENZ]eef4?O6g
b[:;^#F,fY]EaI?BNB6AA<B+4(\R6,W_598]W_9@gE=1Y2d-<eO[)BfW)=Q?/>c&
?(FO8&\4(QVEEG/YTeb1b?.7<#M0SPE2_?fD(CZ:.Ce+.)gN;<9R5HHHL;QHTIQ(
NR>FLS,&aA\0^b9GSXWUC>,Z_@_GH7D3A5OOc6\]6eP/X(NM?SE2Z0>,>PC=IV6c
Xb/;=L=-E:V=WC6<70a[JY,+W6==d43A_/_.W>V]R<:A5OUVRB_8[?J&+7<Iec70
_GS#7@eb<gPF/E5GI#K2ST6OBVP20Q5fUg&NA>0Ne8OS2(D.7=1K5-d:KPMfD=H<
?^b\Q4fY>^\/gS70(G[GZP@[9J=WL#2[(GS)2>,4fYdCeaYT7#2#/=JNU]W)Y<#8
#MS,=ZINJ.eE?g?RTY06f@3_1^C]=GE_\JM[-MK&^^e7[ZMOZP?&VJTA&<ZAF;Tf
^-[W_gO0a4(OXH?+c=:J?6OOP]C_A7]\LSd8X<32IOaG=U1A,048641G-UZ^EH;8
47g.EOR-^37c/fDS_9_HbcGAA9EJY7@,,>+XS+Q_SYZ66RBPA4]:]&QJ)I7d6,f-
.b(Y=7V@-g;6A\+]HM[IW=aN/&@a&[fM,\&0]@EMQC#=L:a]H2MV[T9)J(0gZ,:8
.QUGRM_774W-a7\B._(W@e)3\@TY[209\R^&2[3DBPa8UC8RDHE2C))FKWIZE?8E
-BKXH:dB#_6Y,NO\(+.T=<>[(WG,,c6-Y@21R<;[0;1#S7L^^M&DW0Q@EP]6?(6H
+?.2B:079cP&Z4PcEG:b7TS@-#H;]W,PEPQB2F\]&XN,d+0[Yb,.7;K?UbQ1)=+H
=Q1IM6DY+Y:-(dJ(W-XGZ_&^5R#(c#fZB:U8J[&1,JZ:8e((,=K/d3T>RJ@=V3@.
Y^&dH)D)7eR[bgR/B,[R2Ng7LR,N>UI^?T.YRWfNgEf8\57DSX^F3dL7,?+5WN&]
[:I8[0a9HfG(/WCA&S^Z\/:cKTG4#?ULMZYeZaQ_CXV+02Y3+,IKJFbN^8XA,D7H
6\UJLcgQ&_C.<^3E4=MLUC,QfL^GR9?g7.fLLMEIUYF0EVdZV8f-UQ,O_L>We=]L
9#A[-+V+XGL2.FDb2Ue0?T2&gTOD#?gA9XD98,4TK++Z&I.(+)B[:W1b7bX?/9><
8^+gS0@AHZcLT60>J]5=_QG_+2T+1D1J?],PdJLUD.b:b72T/AKcP5gcC3?QKJaJ
(CRd9TIcK^c)GUS:@PRXe?<:Wbg2UgU::3;N?dB<LGUNIbX\U@aOI(?=VJR5Q;0M
)5W[.dd>:U_Z)TM=@IOSX4=B1IQ05.g_^J_ZGZ64We[DU57+V2@&EMd_[Y6fZH3)
EP3d<4V0gE0C?BPLbdCYI1IRS>P#D8?QJ^4LD-g<K1XM_^g:5O7\N+<U>]BQaO:1
P(<IHAGD0@b7@A9S,DAQW:\(PB+0d24A>DK_aP]&Jf1OMCVJ::/d[RF4X#[d7W2b
TDP#OE\VD@=)aJ6QIQFK5W&[3bL/Z/C3S#RA+XNEgGUOU[1&MQEFVIT^QF<.@.a9
agI3dCM5CbF_UV&8a&OGMKB4OOc[>Z>-3f_>.9f5]Z774RH=61<H>[=9EdX+?f(7
:2bF0e70ZXE0N:[)EL/L:ga\6;c.8^R:\;YV,)9]N.X,#e>NPGd4ZZ<3^E+]LU[_
R#c7BWJ,K/GK9QLKP;)E@;9@X\:a2[[C+07ET)K:G:DD,;X)TJS;KIa11#IGc?MA
Pg-N[EW5>c.:(EP&+(>LCG/+XQ<0+_f\I(00?P\ABOf8UY]MGgE/U[@IB7N8JA-=
^fI=82@9c77L]S.JT@G,)#RBZ+0<.^(A2;BeS@B?0\O9dcVGLe.3BdQ.U6=;TK/V
g&8&<3CS4cQ7S3OO&Q=6-#ND@5(]gF9(L_HF2;>C8BHeEU:;<dR3E]EN\D88I6=D
Ea,;b.5fg)#B/E]J./CeT+NKH+A>;+KZ8M(08[2LHX/PE#0RNK8EfV&[DPacN0IH
f[OdX1gY3b<56<HKT:T[aY5Z)AN6CMKSCP4WcMdNeAX=W[C&,+S=3W95MW-_:X.J
7\:\#?4HYO6N2&=ZYUba=:]J.PFA-:J<_LAFg@X</8RA,AgLI?ANVISLADKCXN38
ffG/8F,R,,fT/^L=PDWa\=8\ecT0Y552[X@LHMQg<?HL0\&6Sf#W\Pa2+X-\]GHf
6?Y+0)7KL[G7d?#fe3RT]81Gdf#7+QUQ9+YP>P51gV@?4ESB?//Z:W5D#>#QPbI/
1.b1aedcRa=WS_I:WW1[K5YE38gGWGZUCZ)c^F#K/I=V_-8_\eQA;AL:bffP-6+.
&Jc,f_(8b]P\,IO0.\a)X]8L71Q.)EEFDPCMQ8ALZe<Od/1BTE8D<TRcZF)J0)-M
1)g/&NOGX?:eP3,Fd<+J/PZ=_Q\+ad8:<)E?W9U2XKTM=;^?<8N7_dGXdd#9K)Z2
0U_WROA2g1NL=?C7gL4MG5J6b&2GaESPQU[[4g:JKIEO=\@6MN;eW6ZGUePE5DD(
^Je_g#[[<cNU./<@>&e&UO:+UGA1;3F6=LZ7Aa2W<[U?LO<gLO59XJDY[B#g@c<6
#ZXN.@O:>N=KM754MEXeA9P1K,^R74BRZ62U9X(0<R08DQ\OA;&NR_I:8(g@PKJc
eYJ^N)(T7W1N[2W8O@c4HN1-_9^:_b=K)+9\\90D.bV:e4g]HIS@I=M1K31+,g(J
N7@EUC=^.&c>CfcX8fVO]4-PZ=Q]DFUQFA1H<096CI/J93=.9-2;L0,U;3=J=bWI
G@2D_S7D2:g\Bg[]-^T_Jb[^#+E5BUg@+E&WU94KQ(7LHR=b,?&4JG?+a?g0<)2N
T4K@W?)8N:8?b/A#e(LL=0dTe[?\,3VHH:_G=QQO@L)1,af[NGBR9R&\?9VQ3L_I
YIB@YN+#+[,&\\,8FFc?g+;PWZ7>d:6fNdc;^bbGY8G:cS&17QHWN;NXc88QZK2W
7GZE_?LKbP,?+T0d8_P&JBDN3\.XBW^><U9H>1[@P6f6L8(<AebQ/4MKG>>PPBT/
E46_BIP>0>EeFK[5\cOS9=a6f<I0f5]\>_MRM]?/4c)TQD&_X_+\Y5O\6XP@MU=-
QEVZU_E1@b--\C4HVZTH-(#BWFfJ:YVZ=)7B;_Y.:\Y5^8eLOYD_=Q,CY4bYN1c8
9W(>bB=TG#@;BNeY6WXTY57.KBLK0DJbc5LgCWVTX+@A,ScY;IXfU,6a:^:#;^XT
<WeB&L+M/d_bZE0g5I16EG7L,08d;47dbd1ba_(@AbO5T8#\[M1#eAGIcJZ]B8g7
)VBe)_d([D4XW46F>SQ__J08d>(6Da]URZWB^;MTAg?=@N9bK\fXO6O+5XKTB:2Y
:O#@9,??MM#QEbM7^3)gB._gS=)fGCGG>\G0QgeTOaYXdeE_/X-28UKSYB4_STJ8
bEHFO#??M0)+@H/1+XeU5WHN8F_/K@8=GaW/M6,1ac&J,_-WF7fN?]C]>:eD:VPL
g>:7e^T2L3UQ1X6eSV.bL1=F8:4<aW8ATVJHb>-;ceg5^X?ZO@CST1S-NE:E7DUe
afO<OeVM,N8Me;?:bddRI0F-0_9MW,GSa09=IA5f12a&F+>/E#T#MW#/N@&QCC32
_L>bMNQ6)ANO^H6(NIER1D&-S(=,Wc9JK6C6VRAdPa+F>fIQ&#Wf)=5#2)ZeFS6=
c(=:d=TT+ADG)6]G7@JJaU9SI@<O1O]aBC<Zcg]aRTK?^)FbfKP5b2R2eT+.@gTe
caD]ZfdHVV6:0\;+b-O\LY<T)?E/cSIe[aP3Kb+3O8=V:)5K2<;]>>&^TA#1@V?0
VCF>[dD.Eg+60R_NbMUgX@]A0FT0Bc;HF<C<L^gN>CM8dg,+W35:aY]>6+W6EHL/
@OaDH-9IK:]X([RacE:#&W@QMG](EA[0dGXF4VA0f^.#BWb8\Ae=G,)A1M)^4YDS
R,DKO7HL;Ia1K(H]KJIc<XS),d-4E@IPB;WHbE.AXgD^eR.9:.Ba?b3F3-XD,)@N
IP2>I&>a7R=c2__BS.9(U9P/[;J<WgAY9?3:\.<gZ[+<0a_)<K\KN\c^AM;N6;\2
0DbUI00c&<DBdRYB1+8QfN(TOR.A\&/IP3WPV^8<46JQ02K+5:#<@LDZZHXK6V0#
ca_3O6bUA\_a9fV(SY19ZB9WPWfO9DOd,&3P^eLdB6UZ/L^(dMG#\AfB2S)eKg)(
\9N_cC7e:+B8E?Q407f3-T+#KM(f7KgZ,5^@RL3[gc]T50Z(<-J(1CI?PO6BF_@S
V48NbI_L^5ESP)L.FcV,+SR/J4]NVf0^ME/=4<#aO[V&eXWcUS&DU@5SB4V&Z<0J
-]@\D5B#_A@^P8R#F8a9PV]8J38C\QJg\,5O+b&cXW76eOEE;6f5<?C=&/KC]=C:
UJgT.8aBE,POK/25Z<K];_>B3\HB(9LCc:M8A8[XfZIB,28FF43=4?+1BPQG2f<]
Jgfb=:6NK&eXHNcNF<&6&J@5XS8Nc\8g;?S.b(a8O609[M/YCL>@#([b?4?JBE=H
Ge;_):/]R&SD2Z;;f;+f/<J:;1-Q<OOE=V_TZ54)H@+C.:a@OF40.+25X9JJX,ZS
=3T(Y/bFJY7KCJOP/>/C@<AB3;cG-<F3+g1Cc#g+[2;RCKbKH8SXbM#F]a<aQ]ga
e]IH>.fYUU]4L=YD68eC.[Z@1::L3T.\d7QT^9ZG)3?e8Q#H([ZSTUKLY_7-g,/Z
GD@7E]VeYKDQ&_>9U:f9(P#gCC#G/99X\aCGg^65JFS/,@\8g8;OZY52JBYQ05-A
?PfG[LLJHZb_:dUZ#8DJY9>#2F?5Q)S]OO@HR_)<P5MP7199I?T@W86Q[a9GZe0#
IRD>L:XJ^:I4DQ(1LJ>M@;6e::9,.N6DXR@ETEIS-TQ-G[]R7Wf9d:X-4D),I;QE
SWK8S8[c<19RMX:.-]B..HR2M)OP43HQKL>TU@.-;:,/88R,<,W>LC8_aK512^>X
D>PMO0(R\PBNO_(;+HgdT6f-AR/+&&>=C80;^>(cDYVPa(GQN[[M[,fb3UdLV(Tg
d9&=5B@&M2e@JRd)#O)dY-<X=;[A],53Z@\XJ/>3H.E;=AOcI<3G&@N52I>;MSZ,
4c,Y,=@F7ZdR:EcN=E5?EdV:^^fHP^VLW8\a1WRe&I?&8-4J0g/Y8&Me.ZZ(d<3M
,TfR.QdUO=O79(P(e_-^JXA,1:(3C+&#d:A1J.RXOV)UNb_;W5.ZFB1(I9c3&KIc
9a:7Be]DYTdb[TA&M,5IFXE>e@AJ+fe+9.KcEaJgVL;&YZ;7BKdg<S1EIXO)<P1+
WO;>KLdMB?FSDDD1g4^4/FH\]D4I6I9]5.RS:]1HgEZBI9DB(\@CN=g_.Tb9,4>W
R1d4#bW32dJc9;229g@2D]CY#F+NWCFBcDZ)#;cG\HR,\_J5T/X1Z1gL#5M[R<:T
_YG_LBaUDV05Rb:HH(^\C)J6NTd8<:)^(:e&7-PJeV52[I;.fU^\,Z:cSE9fL8SS
e6@;6/7g3+N.5\\;2gW(CdXY:P))Xa+CV#V)67gD/L7\0_>SRWc09&g7XCKYdTOS
fIVT8SXH)V=H[T.2NZSd6F,@P(9^?3RO-^_:_?OEJ3&#Y[P.)Yg_7#],KU__2QgB
C>)AI<BBR/9BR93];fg>O/+ACe9.28Bg<CS)\/H-4@05cG?&K&79Tb4O4^301FM-
+6B9J/I&d2;e_2<d_dR)@G(f@Q7],9\R1]1WH<T)>C;);e?]16bF#X0ATBH,T9(0
:;KRg]?9GREX2Xf^dY2fXJ_OH4YQ,XeAZ<B39B(Y@)WG5KG4\K\[>0VD)-Z.RIg\
W;/3#<K:TSO/YEfVT^dWXPX@=d6C-HN12T6[=RIN4gYA9HI@c6GVVQd//KF#GF=3
gC^:ZL#;Y(RMD/MDD86c5WeAWY=3Z&/5WIYPg(CT/L@?.:J(R0C3W<&]TDWHD_cc
-b@TUG=+ZDA@\>KPER@P&+QS#R1EW[-URXYO96M;EZeBE>bDC-K>0:cgK;0&ESHR
&b,g5d+8_.aS0TT[:/RGM#d,Z.BCHcVVbX7@B@NAK2/bG06Ac?-4)?+b3_4?H8RT
PTH]CHR\131DTbfHWbM)bCM/45CK4A+JBHdVEU=MYRMeFO_UQ4ZVIdg4MPJ6HU(K
g^d6e\\>51JZO,/L32=V4/.ZJG\dQ-VbY^8DIZI1a_GFe,C\NFV3c8ZVQ7KNa?Z0
DGN)Qb_bN,O9.Jc<gP_#=II-g<BDJD7D=P=C1<+LYU6PVLST;4G?[4:f.4cLHI3=
Ae\IJL(8L:>NG&)&F5LOV0b2b)2YYXJ:1?SgKdG?Ve>B0DV8HfVAaMC#(X(<-8/N
PBQCMWaNe1#[]aJd7>3E-Jd9f@^P)PJeUU0b[7TgdJdPRQ;e.O,N>HJQHgK:(C;Z
;B\M:(2+EcV[L=U2=WJ=c2A[(MgX\+P^QGbgQ8C:MKD_T;EA#[G,>CZ5Z=55_&G?
B/8<V:K6c6X>dZL:R>?U<,NV?)-BCPV(:E>26++\dKH9BcHVIK-8Eb<AM]bFNE1+
A/M\X#f6=1DN)S)G.34?G5OL=/95Kf1+S&ce96.K7/\@SU51@C(R.R856/V^f06<
dQ5HQTZMAX<,2SXCL^#1WKObI6F&.#cF23#DNVFGOMc6J?d:HZJ&4A5_^T#G&<4;
dfN;==>A_8fMK0K5e1<SY?ZN/^G\Z0^#0F7Re.ADG26<&bUK8RKB5G^6b;Bf\U=2
KJ;\49)5Q-H5ZOH(]>=S3YZJ:]?eMQ8d]GZVVFeAT#G/gZTAHV0G6>6ZOHddd>AT
#,KM&9SbY_IA#S)096MX&Z,1397dII\[Y/SS(b]#._9ME@aJ:c&Ac-a)U80I43,-
6KB?Kf1&bV-SI[GX]&7>;T<D1;H@:ANLa[_XJ&&I-P9VK-K2-:29ST=0b/4S7T3^
Q3@B99Z(2:5:DD)PHf^]9(J[-)]^3?D>6dKQ<1(X9O8Z3BbRGNC-d:QZM#OYF\+^
O.4W6E?0U/aTC,5e&STOCK4=0=\/_Ud>INXE5^-Zcc9I\)L6AcEgLGOTK15O30DF
&1HT546L643K_TASSEI7MUd#X74]R5-]>C\fE#AB=U05d07,L3];>[AQbd(^5PR/
_1fV^=8g,_KAHG5)[EBKA^R&cOVMMVKUCSB:ECd6W@LdYZ=,@BJYUS9g69P#(?GF
b,F-P;&Xa6>2a+QX,(754M52b@/G9X-LP9W=S5?6=COMS\.,O&<L_PMOg?[@PYU[
baV]@Y8GDM3DHSD_)X]eUTMBPM-MUU^ePCe:b.E)\f;e<d9F,9#/JN,FYe\XUB^&
AX9dMQG(a]3W[;05gHf[0&M;a/[+aL;CWR8,R,(P>3R^8W:Z32E=gc/b=bIY?]V6
1<MRGH5#FCC.K.:#dEadHT/R_\@]YZ-Z.M@\M/a5E-REP/CWg/DDP9;6JL&9CS6F
UW)=1<(+)G@K?)3aBgQ/.7O]]=?T##+3Y&[(.bE_Y?)AKRbBbW1<,YW5LPdBOgP,
R^]TOJ59Y&QET>+,UK8J+ag5YOd]6:dD\;7G]8dCd8?HLQfXEJ)dRBKfa1M+VUc-
\M^AV=(IIVbD#VFYX:OZ2YAS3@7Mb\+d4b[OED1:R1f?H7TfHfJN@2fg2-98J,H1
@54=/OTMaDUZ8WHCX/F7F,-Se61IK:bYJS[\U</@_UDUcJ[6^C8>92#G9&9[M&OY
-[HISW]#JCc]3+/WXfQL._=S\2EMgQ_0D[8V]:.X_.-?CZ5&Y99gQ#Ba91+18_WS
.FDT2I.?3T.F;3_0]GN1<cF6ag(QGR8(+4<N\YDTM1aDX[>23)+^f592@_)fIY)F
9S\?b5W&0J3\b3?<6dQZINJfb6,6:0KOS^cU4[?2/?B(L+2\M+DJb/@Y7S5G;e/H
_^(&]2Kf\F3DLG?+K6C(3>Q5#BMH-^WfHagf4PU,0HEO2670g96H.a/3,1:=_<#2
>Va=Xb]65YTgRQD2e.B1V;?I;+1&1KLE)#)bZ/)&:X-#Y;NZVDLbV-1D3(:bA0Sd
DH>WBHDI]A[[>g12e&6/=TG6HbDTM6B4FA[DXK9E_[b\fU\K1OX(eOBf&^Y9<R2P
OV^S75IR)0Y#3+SO<aGd0eZ<UDd?O-HFN?JLc]1.#C^T]\/UK@)8B.;GegM+VGG5
E.]6?Q]A-MT4,O63;cRR:VS]3HI#,UX7Cf@=L3OH\f2P+I14bH,_a+DC4S[RN\UN
V1^S<:AB?^/1?e_\Wda-IDFEg2F#SNc.;RA@O=(YW,JAY&J3]<eLP[+\gX5e3\dY
;P@<BQ14B?)e9SAD=<f3K[Z<gVFE0Pe8e4?TP6&GZ)5,g#B7&e7f6bF&V#JOO(_c
OfTZB&d6^Q/B[A0V\F[UOW6=TL2Z>46RcTO\gF)HKcccHdU5<]4e)/a_8F8(EY[5
6b^?,8>XM,X5.(W20]VY,Q7FMe2J0;-L/\I1QfeR/S3>W96U#)LKW)c:<MASI8=U
4G:))_77GW=H9-?<fM7\C]?B0+^K.[dOQS(2_W0+PNW4T>b8a^[_,0.3V?KU]V6c
\LUO25LdcYa+KQ][TMXY962[Kg.;dJSeE&MddOFJV?6:b]:L<P?WINOKY(:9X5Y6
HWI(4I>,L4g5G9_<\gXO#STc_N[@6&X1@H^\,1DIMRMFIE&/b]WMUWWW0[G@?YTQ
8=(:OFf@dDZ9(TgPQR/KN+_400@X-M?T5=PNYDS5J,O01bZ9149XE18(]/3MGHCD
eW3?f(LXQ4=#4\cF.c=Y>9,R+3.ML5:6L8;5E2069>@6NN,=-HT2Y7N8EgB=Bf\_
Qd55=I-7UL>_Ec2JG>^gaS))dZc3_]D=R>gGO-Acd=&<GN64?>>I-5P@5HDQ\8-F
<[QCNMM9cbS8FPaB&<Q,&RWQ<dUUFc^GP/\T;g8#eMfb&MVc&c@?JM-S+@@]8L0[
JES2@-:X<O4T9-0DJeE\8WVJ-;E0S)O3SZ@EJ/+gd\_;&MN)-B9+UF-K[dYJPTJ<
^Z2Y6aZe(1-7+JNKAVR@@,NIfP_(O#IB,DYKDc5YT,D;\PR22LGR8MEMH9588DD+
JeC/C(?_P+WM8C3?5/P164-&TPc60:Y8ga<H^KLH&+[5-E9BB]VUG&6>IDY;G][J
=bDaQBDTL//Z?.]Z_]X7f7PT:8\[X,bfN(9,4K<>\P4c?0:2LR(A43:8<96DM,O7
N<J_9W<9>F.T9?&J[5cfE7Y+BWO<7D)&+eTUK63F?I:Vdf6<7?R]@X0X>#:1L;.@
FJ?T-0^XLYH7[;16-)QWeSa+R:b2T9@D##KcbS<=SF1SR#:>BH:OB+ZUDbPQ/XFH
7eJHUg;TAa-E:@g,AP8X&Z9@F9)&MM3eC2YKOd.<^A&+XZE>X@H;&VKE+f_d],aS
)[]WMQ&[Ia/U^#5a6gM8G^TH\7ZU?&CZ^V-+R7_E]@.E6](?aW#,bKA(^NX/5d<R
77)]4gb909A^^C914f\L/@:ZdgWR;[IA?<Tbc]BAgFBZ]_M0WFf4\3CP\\#g<ITe
9+9X(6(^b\S(TSO,</1Y,1GB,#53(9[C8=1dE2BN0c/KSFHRbX.CW2BPf+fG@/C\
NND9Z8[<LNQ#^5,DJKQR[:JYK1La<08?G19>e>I[YTQ?JA.&VSIJLBR@1.MBdL?B
9e_@8f?CGS=7-dN]AS=CM8Mc0EH\A^;9\E0Jb]:T>ad?4&<SaBb(cH+[P<5=\6?X
gZS]+V8NR<F>QNFD:d/+S0=@RCND(NJ>THa_QUC-#&6e-I9GM7VbZT\>#_@6a,X<
YE\[Fb3)O^7?1)+R?B&>_WJ]QRZ<1FaBJPA.5HWZ7ePad=VM]Q_gN5GH-aKB63+2
_0@T90Y82&cAY<493DeIfUg<(SAT#R,UJ#;K<G5N=119AUSPAI=d02Q#[@+8AI&c
.E3P)_dSD4e<b;@K,<X?-<MaPRdK4ZdBE^F)9_V_4)Rc1]UY6T4XV&]WZFeOcV,P
^07(O+5:d.-SKFPc-IVOSY_0&+C]JUYR=ZS7D>;?Rf?Y]f)2AL.?.VC,C[cD0TcI
1/=QJZ\4D00_VW>U)aS\-a6,7/R),&_WRKSO)L1J0,=GMa8[ZY:^GJ4WBbV:#-1,
-J[RE&MdW=H&I5:4\WfTC>H5_.QeZcT=:4[gHIc=DM+IX]/0Wf7-KK4dEX?Z9\9)
7-JAUdGNMeLcPY2TO/fAKOP3+E(LNCPS-[)6T4#VV3LeLW?:-6a\:EH@Gg9_>8CN
:Kage8gJ])MIORbHEW5JMffK:)7Q3>W&d>YNVDYM^R?2L<JW(X.5\e_9<,1J(J@Z
4CGS6Z_cD7Z3L3bB;_/<aG;g_5?>4VA0OTG6e:&[P?NT4-B&P\]O0d^:Zd)cDD8g
L0?\D,S</#^_fX0K=^Y?(TV@9dbHe7F=+@DH4)NZ)Z;N.K_b=]0;3UT#B.TE_#[N
K(6ES8f3;6R=]Q^B8bTKXE^^6X?U;2X/;_,A&GgE\GQ>X?H^@]X_^,:gO7FZ\g.<
Q+X8e>.Q9A+0&e)Y?E>872c^A51RTSbEc>GM>6_#ZI+Z27KT6HSE#8)WUBaGZ.XC
H0B]@9_B@L^Q-/N8b;YP.,a5.[UbD_D&-TM,#XN<OF[CJ3_<:DXOI4EMZ?DALRTE
):P#N:/-g,<D4?ODReCaP5TQd#46QLRP)Z.ec700A4Sc72#K7,CfCbY4#71.6g?X
2R]&899JULE03W8.?L<RJf.&@VF&/46CF8c:8T+_K,/I6V[-NBPY899;[67e.W=A
Y;[QF,<@cT31GN:#+\G1Q3\:bW^=IaP84IMga2OB98X#QF;Ia_Y=G765P_f?Yc(2
Y>-A@TffOA#a]HCeEVYN)-fMEB>=3I0[g+94CH(cd-e\?,EHN)-d:bdUb:12g8<7
^V<7c.[SER<ZT_[edE]d\3@+#cfX//(aPR@D[J@?c@-4@O8NQIB7cC9RM6b>)2.J
JKYJHJg-_g,79=N2;8gQ2Dc);9[UBae#=UM,H:7]9QE2+Yd8.<D3R#);7c<&O@gb
2XP-I3bZZ<gBMU==B=SM7^GaX5FW#[HbU((PeVD)485cEOXPaZ[&<DPD7]Ka6T.8
:D5_5cM/\NbQgb+/P3^&5XT_T9.NCA_R#UaJ(UUVQg=f)U,c/-4aFdH2E2^ME+V>
3XR;5\[CN@PYZ,7\--5Hcg0]W2]PU&R@gQ>NZSF?.N[2b6/J)a+P[=;Hd\fI55Y+
G/IH0GA6:FP;;GcXZL.A\?@_;R8=3f:I9eRD16PL.+T,+2b6.RP@\@J1E\2_WHX#
.A?-^0&fW\1_@3(KH33[@?cII)ZG@J[BPKO[,^K9Y7Q>C6]g8F(REV7GSdR]9UIP
RXZ8AG0XY0R<8:;BVAU)X=5SW(B^3S(C3NFG>]^I@W^;P,OML.H_KSQ@REA+-YDe
OY2;WZFD@R3DV7LHaMRZ0G1?V9X5JP1BcJBC\OT#TA&W(=080;/bOZ4G#4;R_2U,
_6AMc0^H;)A.;CR,D334,L4bY+SPNQIC77Ufg:84&B\3A;=WCXLZLIMdIKV(H2+2
HM4<)+#E//\1ZS9D<OXcR@H2DY3f>[K2G>FJ/)P&2Og@3\0C@Uaea^T=I[<TCe;Z
bKecf>CFX(A\_B6eOTZ?faNI++cZ#S;V)T\CF#AQdA1<X25L\KVHDYdT@L8.25.J
K?fR70aD.],PO^gS\6<#^T+_&c^#;?\=XOPT?+52&A_GUR+VG02<7YVgfg:K;b]e
e1M(Ob@ZSJTb>@;Y#<4_1?&QN911V&0?89+>S.-<.FU3>VPBXVb4-<(Gb&Y_FD#=
C]#Q)Ug8aBWYE3=WQ)#\\XcNfJO9X&af6A92efeHZ1F50CgDHZQeXcG+,RDB1>+R
9:N].PV?dG+^gDaUWa#,[GR_J^\1?&OCOg,#7d,843FMFC.f-BZ8Q/2AU3=0VH5U
#XO:._XOUT5NRV..a1g(Y__6.T9PbCYF8?5d>EH>Y^gHg/cD&EQL6)?-3AT-<B)L
N#bLT;]EYZb@-DCLOK7/CLIB#6a05YE<DL=YQ<T,6W..0W@W2\e_KI+N@YX,3-gG
YI<K6c?GM(c:b8ZO#1(]/1]GRX[DG&WbLaI]EGZ\g-d6KQbFDFT;=6IN+9GGSW.E
32E[ZY.?#bbZ,:R0f_R<8Q3deP-NSTcHBMD[Z]aN>8Ga9SC5;&BQ9@L]?A9Zg3_:
KHOLB>2Q7.E;@WS;C3G+0K#BL8QYOBc^#OZ3H39G:d97Xa&MZOgJYM?:Tf:;I<5g
fb:+P7#OWgRS=;URRM]M@BR[I>GI]M9(L4[PUcLWgI?(_0F_PH7C83#0LF1d(R8I
W#LJ:A:d[QQ;KSY56X([@3\O)F?ARGB1fS-FNE@d(7/03X]/f#\bc;(D#DMb1f1b
1gLI&BN,1403?^N(]+JXS(eEG9B\4e.g;:W]RQ.Z@NBHG:A><Q;Ve9?<90^5T7M]
IL0AGYcSg33bP>FR)<O;0K+,YFfWK?:d,1(C20MKDNBU;D1VXKDODRN\\e#:?L,_
KeV2J:)PY_a#RFb3I6QRP.Y\=F_1V/C_(]:(:dWg;]&VP=:-2DQfQL&HN809FIZW
2+)JKaM7<3.S@^,NH;gf\afU[,VH=bCfU),#&7879/d[aE5UY@0;b)P825dcT4b@
T:U>bCVeA^GTK.3\[ER)^\CJ,OCAJ:A.AB3aaFa=dJ9C>-^d7X@Z/QgGXU42\;a&
<9BTe>D5V]RBD)a\3Wf)JUM0THFF^&X/SUSb(U26WK4L1DZ[&:BdHX2WIYI0NVWY
YYW_>35H@5>0UV02<=>:b)R#1;2_H^gJe?3<+#.X^eG/cA7f2#0dB6^aB3UfG;VK
C@-,>QXGV+bGdf4OaAKAA9ec[.0>DLRY7=KJ7Gd5gF0ZX(]@5cX@75JEUBV]@0b0
cdcKbE#C^e(e;dd6-Y(9.)A&;^Hf]T@eJLO^L;T@F.5_F<DTAZ@,EZ+1Pd@WfQ0\
8XB2[HTFD^Tac;OX)3d8Z)eYA,Y8gC&b[WI4b\N3dHPc\&?e?TL@FZXWf7IV3G;M
6CSe3)cP6<^;4WaJf#XI_G5f5N[@f&O8/_-#24FD9.^P_M3ePVb6UYA1Q5)&Qf>G
c#gG_/U=F;4\@X17:)5EgJ&SbOUWF#7:3Q#f&@cLP,g]<-FCQH3WFQ@^T=N)N3)#
55Y5AFdMT8J93d7ME:BV-9fb:BcPLRZ]KCSXQ<BR,PCLSM1BeO6Q[a&dFZ8UQ6RM
K;e6>-_.?<c9G,#-654L-.Bf-)O[gaXee[=NPSP=BEK(9\2b+a)/fA/HK&@5D6@9
)Z6H\DT(WdKW=IJ;TXP3_/C,73aO>1T,E90,[&TQXQXC0EfF))1E\ET70W7L]\M5
D>RWe[#A>@KFRZO,F3AaPS.SM1+]4R\S@\ZDR&7.]7Bdf6@aYW):YdJEVH[NSRS;
+85(P[0D,/D<TU01:]2b3AfV2F9<O3O#PgDYFA=&6@6,F/UEQ^G0[.M:2T/VLa_A
(?3/cBbG+)#L\=fM7+bK3IDQC>[Q#[0<\8U/YWPH:_T/>@Yf>WHUQP6=FdU9SaAd
TdG:NAZ_K/RW?F-,HS<H4]T+gBEbSNAeCM&.IQYY]R^D;#Gb=E)9>bLB@Pa70VP,
EZ:O6-)3X>DdQ].0P>2c>(OHG&71fEcFNg3]WUMe9RBWc:R^RdYAOY:]FOc/_Cd7
HaL=F.>FE4-O[BNHWORc1@TU7eA6>NU1eb:,JM87/Jd_2[@+FHVDLR-bEd=N8(<.
U02>ZJL5+JVPJPV@[.c,T165[J;9Rc]4;:-QW.L.M&D=699+FH(0G>T00U<CHENP
:55F=)3Z#.BUFX/BT?TBW+,WHQa/IU1_bTd3C3B]EY2HF/]7RYOOaAY<^/9]c<WW
[gQAOF<1PE+I;X-G</<)0RBTZe#A&\eVgQTMP0:T4:dKITIJ+Oed;E@L@SZBRKaB
E6B(^\D]g/Vc@IV_Qa]FRQ:7FHOU.=WcNA[-C.Md=5^SMHL_3R=,5?^9).EX,;J9
ge1814T+VcOQ780=d[(S_U]E[JC>dMMIaL4bT4#KU;aW;+7aMZ)M3.:])FC]2?^U
/40@ZdgS-;e&]X=J:T-M6B\DC;7E?FI//_JXCSBBO@R37\:dSK(e1VNX^=9,X[ZB
6@Dc)E&B_-;FYI\_INL:dgKV9M?fe#;-QU@7#U<KUW@D.KVZbGRQ540U@IN=:#NH
(7C=Q)6RGZQ8VZV^K./PFR:Y.8BQWY(g@d=EZ]X14D7LAYD]^:c]DR@Oa?YXa4.>
g+^XBI)b8,(^CL3_+K3O,MIee9J1-;H>Yc/)d4ULLY,JT5A>L@^)Wg/a(L>Y31[Z
]9</Sag615d.\&cdX?g@cYGX>B4#5YLb#c4R0+^VJY\CLF;V#bA3V1I0;FIK.Q==
^7GCKKTdeF&eLKOYXf:<I9RN1)K.SRH6.^aIDg0dZC<[;+C^6[NAU1XM;B_ec?+U
S:-UQ?G@VTHV4=_H\dVTN[5>TcSR2Dd:H[D-X2]Q>-?M>PV&5;,5g\ANQ]K9Y#a=
X4@)E#W,da9K#HP/bXdE4a-NF4GBaPU8bVDKN::_Q4#6V;N>++>[MB\83aG#@d\7
J]H4#DN3LCSg-<V^]T),[dOB@V67I/<8H7DK;Hb].d-3@ABHB#IFC8EHb[);G22&
/agL9;M<.@S[O6Bb(?8L/agCS+E)X?7-,gJJ0Q_/XU\Z7Z9F3?K=ReE[(99-Y+c>
.E;SUF7#bb9-ZQbZ@5gf;FW/O:>b7a+;_#Z@OIS11#,#[DO+>=2-EbP=OD:dW+<G
ED+63HF/a?:SEd>+WSWcE85:/\SN^W-(Y09fCHbMFN98f;>8.LPFf6aKL876Z]&O
?e-b&1W]I?8APU-X^4BW5TL_8TN1.QQT3@YWVBG6?#F&175aK[A+Ea]L<BM=T3NO
)-W7D:9339MI]f&A8N9G2ANJF9P9AF9_L5=D]B+>#OZU(JcBP&Y(EM@8MM:B]>\<
d+88ZL+&4D6@49)&;aI92.1KNRL]Ka+B#WZ;6I0J2M>9>g;3Y_XcLd711H8ZZ6DT
G+V8+=_]7.O87_L#g-P<EDegYY7bfc5W5<&6.I>&UXZa68P#6137A^A(G=UE/g[3
9Ec:>+?GdD5,1\Z&9GA_NZNf#8GO9#RPA@1>a,a<F,,PQEba0g0_;^4-9#;_OH:#
W/:0ee5XV9bT<KXG0B,P+&7.=5=B5#ZI?3U0\P0^Sd+,GO@+]ebEP>e)Q.fJI=eC
TdZbBW464bI]2N/.5fA4=107]Y[<A,e5[+c4\,WO-b9OHPEe<+_5g)>#8g#55-4d
H17[\<K&II\geC0O+bBQ+Cb9be75(YgfQ?OfQO@X?]E#5WFb[J-)U4a7>QWM8Yd^
XO?E8HM:5H.#@.7?ZG7PZ(CKUGL@MWVZD0)QF?Pc68(CU,gDZWdbFUR((QQ-/NLR
0De(#XIaCZ5DWe:cQ6Ca&JL7CMF0#[H;3WfMC6JKf=Z.](J(E;6TB:I8;L;/WF(,
?DIdVHO&\=)3;&9b@Y=7Y/;MU8\fQ4>U?VbW2_#G)]R.W:[d\]_N/3JYK]dKe4Y4
MJ#2(3V5GUg&+P?DDHX7MCOK:]OP?SMUWT<IB[c)LAQT_2T9ZJ4P[fc_A;f6ZAC[
gTJ/\T2D(.KPJ_gFC881>1@SXBY5H:VdAL\:>5V46/gK,H@K:..+dfgT5A34a\E0
4R6,I,M7:YHQK;AYH0X7gW(T3=YfaaR,YC)ON/bO^N(M2GR^/9/++3LJDWX7O#ZP
;[YH;g4:b:CO=QXO<QP7K\\J&3R?137&S\NTe?]KDD2#I8b\.2C,YOe8EH3.71OB
<OB+43&7+#]Q-/1bP3EX4a?,IA^#fO:9Xd\V(MW,SD9IIa)B.J0AUG.\P@.-36I<
8SH;)Y0<(5X6PRD9c,6RNGeKAI_0C\IgGH723LA[5N#1;KBHLP>da/N4LPSY-7HZ
NK_N4[<FIF40LIE-@ECR=(G#E1I23Y\T?c0]OA&LY<41@f?4]-da8IK<,adCf[f7
9gSCdbKbWO6Z#]?^_P3D,[GBL0H[J4X3HHgcc/@H;:F,I4+3)PgIF78UU#0dQLV^
/#;WA@g0O:>HUO^18\O4+If)aUP+#9OM^0d^gN45FQ[&K#R.8&EbOJ_[K+4UIP#R
,<dHd&^(C@0XGeL+E[B8I+C9YRd&+NbN&530J@.IHYW0&B./X_4XEL@.Td&.7]#c
8/[]U5Kf]A54.@T=<)c9&]Z]^@\a;;IV;R0NQ@HTf<;dg+\./BNg]5K0GQO)<2gR
Sb?JS8TX6@9WUCNLGVFE3@<<PX=Ng2b->;>@SBg#D,O1dEHdgPE30X24IDN[/#b6
a8@g-G@c65g01M=KV\@eQb&fA#fZR(B0+FB/3T=C7X&,6#;_C5JCXOgG6AEJMB[P
EHYdBX/W@=/H+6+b(dcO88B3K?:HP.f;LXDH;QX^7]P_1.MS:CaGY2\:H]-M-Yf?
fgf1?<T15fF-/+a=[8a.A)0\IO05X;R8\KA6gU;d_[7f&QE:b_D[8H\g708[)+_)
)2.)R-R?3(<Yg,>5L+W8B>eG;NQc4J/_RQY]?,^^bFQTMHV[/\=,g(PB_=W:)X+.
&K21DX=DJ2K^#3(QTeLaYI8I[@.0QPCC0>P71[bKHU4M3SA?XbFaC1<N/7KUd3C4
JR7\</daX/.)22<eDfL^.>6.^dI.PX<b32d+>5g7<):AOcLW<X21U2QddJbV^MHC
XXCO52)M]#;-;IR@4^6YFN9D(:Cd;VGcS;F9c-?R3>V2S(&e#]5g5e(H18=M=(g\
&&Fg4==+-D.X?RUb?DCD^<;F4Gd6V:(J1/>6b-W:X?[Lf,:FJ1?CGNSEURIc3WTP
6J00UWGe0I(G>(16/;E/V.A9Yd87,1=_2,AZF?8bGOVDK&J^G]=PS>6MdBU2]NdU
gJfF5/b>,[?G_:BaNLYC.>fbJLDWV24=#B23WcYP)S:(\R]CJ]]G9MJ1JNG/,XA]
0L\eJ:SO536/e7:Q/SfMK&Ad(aZT2-J4^O)#]+6RYd<;,g3XG-<2_2b54:B1:HLa
XLgQCMU]9_M>^&;dffND4H,b\,8(g/b;\)BM@PBf15_667&VQZ6U?6^45Y:-Hf(P
JPQ5QOA+UH#ICVd/Q,4aFffYE6B1=]HCZLfLa^DU_Q-6AYJZ8gMZ#:Ba2[OO=YCD
=bQ,7)-#HP40/@-^TaT(UR#eT9]e70LL6PIH[7E?3VRS^PL1FTUJBSVU3:6M8<\L
bS&cJ+Vb@>Gc(G\L:P.W/#EX1-ZODVP2=9I(&bK22)L-J2(Je/(=d0K.CF99L5aK
ZZ+EGfUKW;DV[0P2CJ7.A:.+E?2@N9KZ6Y7ZWDJTaVGg+\QR+afe?X;^K<-C;2<J
??B.CPF4,SCc.67><1<IGS:O9AT0&g357<@YS-RSW].Z99@BG9(CMA];I(U67X=d
B3:[?731-SY,N?5f]SZM>_&TJA8B6KP-/YEOT7?9/Ggd:ebU/b(J;gHI_UOg=WP,
MT@/]\(?<YY3C9_c:AUfO6#./2-c@NJ/HGP^cH8MU5eXL>e@Y;3_A5e\TS#M^d##
deG[K:,L#PE/44WB>Bf2D.aWbQ3KT9)N2R35;f]^X6@,?N=19F9Q72K[W6f8U7Y:
Re4]f;FRg+//7]KeGc:\,)MQK[Y2&1<=^E:4BVNK1AHCJ</+@O#gP=df7c&b-M</
TDGgaK.5gN7)VZdQ+2AfU9^BP^d\E+dfbPHSEL\+50[[=5^@FO@f<XW0W<35ZaD(
V[XFG,Z6Jd4.e??ZI>38YOG]H#RIW[g2RgdD6BD/]CE\.88<A97J[9=<2eFCQ0Wa
:1dR+?7#bd;8;ccQ,MH\1]4,D3).CP=Z^M6/@C@eE?DE&0D-JUA,Nda)d)]b(gGS
,VIGZef_a)Q22@&50a2gO2ffd6;_>:/V(Z;0,P0K1JR5WW#:0_2_((_<DDVf<0_Q
I&9QWD5?RF:f,_6MKgg1O0Y<#,d5OaD@);(<R1eBSOMNTJf@?.L#D95=+S\4H]eN
?c4:<74M9YgA/;V=LZFEP^<H=.Yg#-41WG3LH4B64_R#Q(#g(#,g#2@9.\.@\_)_
bb^(9([T-eMU&(WW;\&@&G(F>^R7Ta1a\0<0G_H(ASdGN.(_A;]1<Ng?/Ga<5(XC
[;19CW5UE99ceO7?J<91I7eS@VBeYUS;N1a>,=R1V?QHT,eVQ;D3c2_KI90K4.I\
O?2<N]_d>Oe_U\\/:7(/NA-M7GRe>N4+gUPV.Q&)MG2:JV7ac/Lfa0#/Q<R>?&B;
EeeUF<_I\BNNPdK##@]#FNL,C1ScP:FEc^X^^bRQNLd039V?)XY>+:&2F/](?0&3
1&JV5=>]^^5:6ABGZgA9bE^JNWUPbBXX)#B/A:FT#1)?H\85MCL-67?^404B_.ZJ
PS8fD\7gYUC9<U(D\@HUFe>U25e0]>Q,IP>f6<f@D/=[[_-2c+ERX:-I71.Y)c\A
cKd^gV3O_D1:cZ4IJD4c0@#&DMKdHZ]MM65-M<69(Y/0HQK/d@,E7cBOfN:OLe7;
[^+:SRR\VKeU4FM7V,FN5A)K8/.M]DMI03=HRC2cMM;>HDA:6D1\\b_SAJS-[JG,
UE#<fU96WM::#CJU<#1G[g.H91_T40KYENb7RGL(/TO>\(\\0RNAWN[CP<6_e::0
C-T71]9@?B.FVH7T2ZU>H)^]945Y-HFYcXa(U]G46<cZC4MY_EB8)=#Pg[+.3#9D
BeCU_?T2=.(X24A438g1M#NUUFUFP3M7ENf/S##Y<2#c:VDL:0Bb8WL=-N4OVXZW
L[Wf=[M;8D^)81M8Nb/eBA+I+MGYAL^RLPX7QL52b<#bd?S^O-0U1T>:1Kg\[@Ib
HcO0#cK#\fN\=24Q4a:BMZa]7PQ5]C:_Zg_=XWG[&YW7D:H(\b1H433[9C)GS([Z
K^U4dM@TgM=;KPRZ>F8[UVYSWW,NHV;Afd,YN<[_-(,K]-^g#G?3I?I3c36/R-5W
>>8SCMb.J>c=#.ePI(P:57RXe6aL[/V7>HJT,33NEM;3;V,Z&e?0\#/4d=F^OHLc
^6A1de-+1[=e+(TN[<X8Pc>UQD<)?NUS5L_eYX0&@7Jag2=Gf]>+]Y1Y;[B,b^gb
Vd<aQ&(88cSZP,CdfTYJ/=<(I/+1__:I9a=;U3-8Jb8HG0R<FXMd9)dDbOg6Q,.6
DSG0ZZeQ@^C>;+DJ@RIS2Q1((66@<>Q#c^KQJ&EIV^R@^AE/f6KOI[.5HE_3Ba3M
@I/QOLa-&8IE1GI?;d1@PLS?H?6UZ[+\<A[cXP)=QY6/F3OF\_=U1&S+#)B?M0+1
^9]N?HPMCd=;D95KYeW?e)R(Q=dgIYJ69Z5AFOE]D3GQX\0N4)>]69>\R.19e&IW
/S1;G],T_Q8J&b&06A0><^:PBT<_OZE)PNHD<dXZNc89OM#/:JPQf5gT+bU][7QF
3)_gFXZ=4R-g.N4Zf/O^8>0_,1;J@IT(][T6>5c\]a@CWT]NA#;G?T2-;GRGdfL-
M0PBW3=9cbONJbQU]f<7\W9AZc=SPg06WUONBGN]]3X=;WW)[f3V6KJA^b^F8-A=
c5?=CTRg6><7P&^dR(+8[F#fPS6<SbZ9VSc=bb#A+3MZ>=(eK36131N:>>Q9eMf>
Fbe]&1N-\/E[E/e4Kd4:FT#]P87MUV8](/NXBF^M5A^[Bd2Db,?BQD1Q-Q:ea?e<
8\6?H7]K6=M]5A\d-9T#7OfX4E6>HD+C,AYRRd((cFZZ,=O_XA>/TBP-H2@c=_=/
\QT<:\(/AWS8^OG..#8WL\TaK6f\>OU>^N9/U;5fFA2S78@AU.P,I47d7)BEW;KN
R7VbaH]@&C#^Df4b5C6ZN@\9gd5Ge1A<;(<,_?@\6^,K2(<;^(c[LeWfQR^A<>:]
Q@Gfd1b/HI,A2P-2N^<XV)aQ/]IT?/b_1@X@5:EAMHO0^P<8A_?9;?d8N,e;L804
bKHcH:)S&/2F&eLT\Q21MJUYPX8SQ5D=GaZ_\O,YHedK2>efWeJS_AR=[QbbW,6J
3F12Sd-YX;O,M,)XEU?]<[4f)BH2XE9<#>b_-=9(CYQ(J6MOUI4e0=JWggKK,WDa
H)N)We19K&J_XV\-FSPGa93/a/FXS4V]7\VcCIJTDAcVX.3e6-N=Gg-GJ:bS1baM
6[G[L.RY:f<SUKX)c-df)<Q69EV?I?4#ABUUb(;FfDf&2P3KNPR^93[bA_g6Z[7-
@CMS5TLD/H_U+ILB,SD8.6WKVVVL3KCX0NA&)\DC?3<ZgIB2SG,@g?DJa_Ob]-,\
SKP/DR<EJ9EH/Y:4@Q8Yf66<dEU/@cGI-gU\R/dQXb=dD(U,Q[3[fg\Z39+MQ8c^
\FBf<VV>)7b>XcIS#/RCGR]PIS6+E23&5-\URg2I:[8)2>M8--cV(A>7dD&g)8,B
<73B1_GeNPg1@TX\\1YW&[Gg&6:09CAFR(=gU--XI&K,Kb5SA_?gKP7405aTaW74
bCJO_8ZGZDZXEM=2Cb>J^0V1Va-6?Q7_FYV&ACEYfIW50.0/fNe=aKC.bH7JUSB3
/Q(\#WBXH[_\JIeOH1-bcH:0=YEAbb13C88=>BX\FY^QVX^b4_@ddXJV7YX.fede
@8cFFaeFaP&P?.<>ZH^-S8N#?AfW0@(-a?dW?Bg>[3-&IU80J12[FY<_d-W0K0a4
ECS4(XI]c<6MBf^53^O?VWN?Wg_Z5Y@J,M]c&GSfRH>HV7XV);[cBCSMFWS\-OAH
R_\2,g;+2AFT_6J7@=V7M;fZO4/E.27F<)G:^1&P&=^af>2\JXYM&4;@N+f.HA.0
0U,bHg9<;XVN?UA0ED=>2dI+DTVW-JJM42C;V&QWYbf5U5DP)@ZX\X4R1_A2&MWA
Z&e[bMT9K<)]CR26:MTZ^T#MX)fLPR#0__d<UNT&(e3ec;D-BTN.SGG]P>Nc7+JC
&Cg,0YWPIM0WRSW3Z-DAd0A>7Zc[b&^YSa)?d)S-O@(2G;OAS9aFB>bdDE0f&.P@
&F96H@E345eC;3cggRI(O0Z7gWb:a5J4e(;e:[#dIF,CE=Z#I]0Vg+gXg?_T8F(-
g;cY:/TOZ_EY6B4+Q4MD<M9+GbS>5K[).cNHM-0_L&-MYP?6IIAe-Za\Q)R6NGH^
cG-JeSBCd1>J1-8MD=bb7PBRfg2_,GVU^XX<g3g)^=^W-H8)#,/R@EG:=>BQ92QX
8YHf6,a03TeS0#.BaI5ac?He9VV]^3\SGIH/RC^@)UR@db[4_@H(]OCeS.9LU+5Y
\WE5.ZBL)YA:MFVW(MDFT>1G0QOV3fP?MST_MC=K,Y:@=0^2a3aT#L35QDBbMP6Y
&8P>.&.3QKMW;6B+[dK8NW5GSS+:IF/:=WB#f5PAaXbDcG:;W8N93?NI9R2]HKPf
BI(?F[E0g2]1JT&V]/dEOTX)=0>f;Z\,fAVR8[Bb];I)6gMDeNNUbQV.^771O#.M
BP=2+#W>g2S@A<^/2,.e1F+P6ObDNW6J<Y;J:e<RYaI\S-I.\&FLF[C9@:0^F5d^
E:/A(N&;[;/_BH];Zd&9eGd/ad8+<8Y?gTeAG;9@:[JC]=Ke@KCASbRT/#D2;V+X
8=N]fYF6-[YT]_&=&\]\9OYN5)X3d-a2RAX]R8/KZ1#?3+e6M0D<BG;?+2b#L9^]
g3R>83#(Z76JcCd)bY)C1(?b\\9[&BGF/B:HAU9K\=D\+:Z/\VYfaDa3Y=&:_>XD
]5HU,APJ&I[A]^22AQ,QVFJZY0)cVXabVQ9IO-)6ATTc@76I/Y82[g5Qa0(JIR6J
8@=6=0A^H<.2^d(K+DX-=BTf9MH&cLeWL#]M43:=ID_>;\46S^a;3D0?gR021;)\
YSQ:e&?2Od^^V.[5-I[Z@4c-V#T[dM?#P1P39N=dLB(1,BYT/PUP[TVN#=XTH5^b
7&WO,LcZ&WWF7(GSGI?e7I4Y+^a8KC7Bg=#XH,KBf.fB7IOQ]FKgYe_@/EbT-B=0
N@/<]a:1]@cb\GH\O[,Z;)P/(D<T)X]bVG(?VTcRfH>d>MD2BK9(Z5H=LI2UA.:C
,PRFgJ0SB8(@SI^+L6;]4X);^>^.ZSg3E0.EPM9]8Dc3VXeQO+YR+;.K7Y/K&.4G
I4;b=^^01YWR#?ge5Re5B]JMf+2O,FXXLAdHgVJ8Ebe=VTN8A]>T6?G](>;2I;9T
2R6<#b/J0e2X2fg-&.&g^Td#NgDX1#:ZH&WabJY/O;ZS?eM/FT@V>_bA2;ba-G3/
^MK4^W?L^GUL88CG29G_J+E_TWdZ>QMNHUV:a=HfUP<NGGF3f^P(>:2D18LcW/SK
)E=-U[Q?EL]f68&]<A&#OFH,I67/-fB_Y4P+(LEV=Y1dHA2RW>+)2N@I-85N_@/D
0DMM5ZAXOHgZ(?aFB.GAWF1_-]AAF)0F-gdFdg&W#75<bTHP9_e=IS;?^^<T_TYA
R90F9\4+__1b@g:b?9P_[J.:MT>HS(;FgbJ;^ITU_\J);cXOSgO[aJIM8EC)]f-d
12PY+aO13AA,P(-e)f_CLd8[b-NXPQ.S+FbA++K1]M^3]#(U]b-T1^HM[?EbB25c
[1&CC#DWEYbD,QELOI.5&UE,Z)#6/aK,NK+HfR7P,3BE3Z<.@1.-KEO2&:)<-7OT
?.HMbgTOANd>UF\S2=6gK5XAe9G#G\)Qc2^aA[GV[USZ6,.^(=KI&GI(?EAb4d0-
V(L_T#A.]#650YSR++9JDIN:RFJ/]+NDW_RYT.a_6_G><cL@FZLBOYD(0ULN5-(a
D^,QfJF51;DM+.BB9O)RfY,gcM1S@T3&EE?@I<JWO7XOO;/9IJS-6FOVCC#<UN_.
-eZJf)]D-QRYEUUBWN<#Hdg:=U823-;BO2[K.@;KB^,g>8TF5UVa7W/1_,WEVRYR
Bac0IdD+bIZgdDY96d:FL^:XFL<KFF>gYS]00H(YA-]TR?>6=L@87VG0ZV0./(]G
eBM;YHP@^7S7bGT@Z61dR@^?(/GON\+XcUb@1VT22()c]=K+@N[ID^DZ]=NKd]RV
KKI;7BWVXb;7&f)ANXVLQ6NQ7Q,I<cJG]US)7>LOf@,EU1OH/VE_a8YH4\1=O1Zb
SL_AIFOI16^Z2_I@O&0Rb?0,=UXf1FG&S(EPdA#QKQ,_Z7;=b)Q5[QbE5P;SLDMg
Sg866_D:4@BO[)=PeNRE&ZE)1@MZJ)fGB;fN1<2.&5U-V4(>Y\IE2TeH^ScdeC:1
L,FCaLBYGJU83H,9ff.Y12)caBSL/cbM/3c89)b93#O\\IFZ+fWXV+U(#,LX?LBg
e@/B/[&FJWg8,XKK[b029AF)WKZdRFaC:[.;[;6YV7DVVY[=I,5c=IN8C#=LT+-E
HI:MWB,C]-#6L\AZ-.&R?C1ZD^+7BGMMT?6YKBC?U=JCK<QA<Xf)6gHP);R8E_;&
@H@XDg+WCKaM@T5LQ<,0A]XfE@[I\L-JX8<TNG?JW7/.e51KP(45P>M>=J(Sc+#L
8bRX),?a^CRg4+cc-ORENHb92eIC)[I5]R1^Y.^T0__&(A8MQ&Y47gSN5USd3OML
QS#cZ[=YDJNS886P4b97d^A1/(_,V.K:[;0;#?J?a#;S9;R/YI()5_Qd;?\bP##P
LGQRTCLC=?C0/V(<c)JCAL_/ITLFe@Y+M7EK,.1H<JRCe(1LDe60BR/1?2U_RO]^
LP\+:A6A7/6+[=CC9:@>G2N.DUE;K5)3DQ,_/?MG,D6B4_EE5HB[B)1Ucf52=S?9
Y7-^cR?:UH5K]W^ZG//F#>A].O<-e[&Z32M5[,fRE_Y@E72LfFA<D(dBC0:(?gJK
aC&+3G&GK)Xe17]H^gN\?@T:\OX<,aNDO^dDS5]aSD:81/X,-[_OFNXabLRS)ZQJ
d5OcG-]+efde;^Tcf5[gICII_\0cNZ[]53@<Cg8W_=dg)VHg68ZYC8[A5KTAG2MD
R.65Qde?:00MS]bWf2C72EDS-+G#^<LM5=DCVK0#.[]HC[GRcGMYR1JfZbe3&b/N
^+LFNbbCN<d\5IYP@aH(GGJcM-5[UKHG1?:Ec+E.0[;U5GFbV6CSb83d.\6F3DC0
4e@P^&1\T1+MLL[e1>NGD1<B<G6d\X:MMY.@a-@-ZC+g9];b)2X<UfeQ@A&.2E2?
IZ:._;YLJ[1[e+#_V\<+ZF36OW/Qa14)eZB9?.>5-ba3#@:F)Z/MA8C7dNQe5CMK
G,Bd9KG@-PM503JR97VS+X^>ZB/a:75f+J.a[\<=bBY:WA??M&AbGVN-#LY-WWQ&
g[T&G1+dK.aJb7S@cW-O3W0]e[aW6[Q3RQDJ9&c.JN3[,G9X.T4JVeC#.,W-D]Z1
e()HOYEF\WUD#M&G.:cTE.:._aA8Fae(6:<=ZAQ?0K?Ld/=\fJ-d;NPMC,I&C^@9
F9BDZ8/E;^ggS+5^A7Q\=ZN_W6IdO@D:DUb.N7E4@-V];aTD9<EH3BK[TVY4SM^>
Uef5e(@,Qe/^MW4dcgd;_7,bAQAK[c[MRK,9ETLe<+_:_c?JCXGaa/?eU^1?Pgeg
C.1O]WbLVHA.FYY>R=B^?E_Cba-c\)VXb4A#9+WX&T]_(gMc1fSUVH_[)261FJE\
>3,PNSNFBQ9d77PO0;C@_+;#WH=bXP\[>d,Z\7PcBS=@32Zg1X6PNF&[/=7KVELU
aH@);@Qcb57fB3Q/AG_adG-)>N/cf:Ba1TE0I^XS[@A16/C/#XCcPDBd8,_WIZZY
G3U6(14&,:62LO,dT(YZ&A=cT\_);Z^>IVbg(bK@A3D[Tc3/bK#B6RAPFgES)>?(
,Lb+[O?[GS3G2ENcR[K54C=L[@2N6d46[@T\FI8,8Y\_>])4)^PJ/>NNHTecaQ-Z
VZTS)8[[G9ZVM;K4d]PV,4+6&e&.\BTIA]YSZI^A92-93+,F#BF>6[>C6;8cK0YX
aNV2?,2?X@?aN2ESKg@,YI-M>EZTOU)Y/Sd_-04P2ggMY_Hf,GcH37>].e_9BNA\
129gT-T8#-I#+H9)4.VHMAL]MFU/b48[,U+VPEg\\J[]5D^PScf_,)^GE0?=;<gJ
V<Z_()43:]/KJO;8OcUJcO@OX;73F+)8,F:.RR5[A)W49TLIe?7U6KF.4e(&A7K/
PcL-DYYDWdSRg+/G=ML4X)0_>P7,+;7C\)R=>V5S8dF[71f0JL=,5feDBHL)>(-P
F@(ScfWI?A1BXO3/[S8TD7E0dHP2_J30[.8644PBN3QKHUIcTPL<0@AX0\:Y])AQ
Ube+WP46-:#d@Z)U&LA0;N(a-7+1H&9->=eTLEYD3D^\bJ5DC^B619W;@1(Z@QGP
9VVG\3.d;gTNDAU\bg:3bL9\5K&5(Z/GU.,@3WK,acGN_aAY=&2g>[H(/#]<aU,Y
d/aJ^Mg?_6HO:7?IK0\:)I(X3K,X#d8ebBEQUDeD&P6P#=83ELXBI4>_@P0.cbD\
RY7+G-RY_:9.La=LL7/+S,J=.-#9/RC7)7PdQI6>+CFQA_8S^_TGE+:>P^^FXFQ>
,M1978ENOA-TWKJI&\)aLS6DC@[3Y\:fdD6.S]5QO3-DW6dWY5.AQYY-O3==]PGC
)KARG[(J+DO9dNPHZ.D92#:Q+]JIO@TK4:OSOdG?P6V1T]JPWMR:#L=KcV-;a_S=
#G1+]6_5E:Vg;g>TeL+GdVG?ES?g+M<EMD\fB@4+V&T#-,R+IP]\<8O=C@W/ecI2
7C+?=[/>F73^EC]dc63QWYbO1X&Y(^,]a1fW]K(U]W.?FdLSFeEf:[9cM;Y]Pgg;
/@^]7FDHV[4Hb_E)/&JJHc,V5O_YHeb3T-L7>VbCYAOEB]TJ9:bCK38/ECLQEMXf
,Z6\2;45^73a]3V)8Gg;bd/X]=d<aP6@01OYLF?1dB+WW?BV@+V:\(bGa1DBf5V&
eKL.4?dgQWF-20J+4&a]Za(Q(.E#JH<8R:+MGX-[.DA1K3c><N#5/7Zg6dG@.FS#
>_I)_3?EgQc7H)IZ<RPIE^Q4:ZI=f6_D4e6e,US71AAWN\dD=J)=.B/;TT0M2;/S
)/fA:;K\\J#97M2)K45-\]^J(E#J1T&;=Yb6HGU4LT\HNPL9bGD+QEY))0.+_,f]
;BUPd6YUfg[;UAYLOPgJ#:IS)(HE8fNbQaKG:0A;O/G/<S9c,KB-IAS4DX;0AcVQ
NVf4:\3Q-Z?ZNH)>6&PFG^TNfH/X1c,SJN=8K<L]Qa_B=+NB=E3^ZQ@K])IL1V[g
G0f7GQ\P.-b8F/4>+:O\T]AfBE9]K901J<DMT^G\X3.U;1^BI<V3IG]MUJV<dCII
/G=eA4SI<G62YOf>5&<;SH:??E4(7(2_05WL/4:BK[_Me=b),GH@QTV6eO1D8)IF
8b9OL6XM+aJeGK;\S/\ZT6R@M=>d\2F@[HHU/8b/:d]Ba-MRe=(Ig_/4[=ac&Uda
Tf=Z65@3E+AV(/@&@b4Q#=3\<QOLWQLI3-B9^#FILca@<&]0=5C:_6V+RbE0D>H+
=WBCRHHFYA;b[UM-?>.K-Sc5@SZ+O<037SfPA>cAW.UB#]beIZ=?g2>)I-<J]J40
SeA?(A)]^>S<fOg_AaAZBIgJFRTZ3C0N?XEGZcOKV30+51]Md;e(TZ,P9E4[.[52
Se4I,AN>HV95gKK[KGJT&\b^Xf:N(MW)T3J2-DFV:6E=Y-.OW2L[1b=e\]KC&5Pa
0Z6e_259E?4O/O^D]Q1-9,P3<1^:K__+3+W9Z0@BJFD+93:/2bYZ<A_6_Hg(+)V9
^S:R#4I@65?MM^4<f][D\SBJ6BB=;C?LVUFO:B_?)O+dVP[d8#BYB-SFW68ca)VV
YU)g-bWgA@#.FX)2/YVS7X\/Y&f3bE7&[Y.KQ(H+SD^DVK:VTCEP,M=2QMCbJ2-N
[CD&&RIK^V?E1^QO-:L0Z[+OcY]G[=a]bcff^Qg_]A=ZB1d87AR\gXCBR>:-F92g
)J+Z/[^[Q@5MDZ>2/@&fb,+HQ.7]2c>2DPV[A<OB?=SC:2VVMB0b:61OR#6N53]J
:(>90^+,+a(9DK?5\@P^b9[(5G1(MY;F8?->R^DF0U^@b2NN\[R/SHC)5EU;J\U+
5T?_NCcg+GWD6_3H5C2:UUOM__QCW>fPcM52VEIe&7c+]QaPYRRA-)K;JTfD(C(G
LT]OSF?C>X2GB2.:b0BLILbBFQ.-Y\3FU52aJN?Jg]3ADR[Mc/DF9]Z2)ZF]LF-G
OIT&N:_+4;=64>ON7G6GZ+#.L7(GN0I5;^IE+>?9\[<()AX[eABY,@PG<[_7b]]W
]WM[@Q4=X)>@-4(f8_J?ZJ7#_Y9YIR2=D3&WG/3L[PbF(D_RYTQgXDTeD;d>cX?Q
bNJW=,G>:+VAP5[1YSUKX&#6-9f@>(G,N0YZVBD(;9N_Z-:./OH93)(7]40=Ha^Y
Q?K)0Sg+UO9U-+VH,cKO[+\8:F6S;f3P9P3JMP&XdY[e=E_Y.LNg:UbQ(;6eP^CN
I6I(19dG3d\SQ:-H_N+Rd5&&O6VWOC_e?-U)=bVa5NfA/W^Cf@+,=d/2LZ]g])Y6
FG0/Pa6:_Hb5IB/W(?c(>K>N60_Z#30f6R:d&\#4))6^Kd#KX:8(/DF=B&A0C^8e
XS5f#,7<WL(DQ4::gZGS9LYCUJb[CV&Vg(<O&Qe>=fZDO7JTG0Jg_IEXRGTS@X8N
5:\N@@;Y(.E]U0.7D+WCT.MY.DFRA?[JFJWK#FNI:ER?_BDf6fHW>\V-NAfc1CD.
Y+9(0IS2Wf->G0&REV(WNKM&HC;-0?N)?42.XMHZ)<\19&JPfW/B@8]2E9FF908B
0U70)Lf9BJe#^#JTb_W0<CV/QDLKBUVQD53ZOQC49d5#JfL>2;7H]<N9NRb\gZ=8
@9ea-dD:dX&X^TWIBZadL1Wcf?I\TKM5.96(XQN@G1+fTd?WH)4?)V]TBAV_I\UV
(2],A8XNd(:9BM+aaLUb<)MS2caHfZV9a)+K;gDU7J6GCTdcgLOYf.@,/7IgFAPR
&&9dCZdT4g-JC?T\/<+?Fg5#SGf-O:I[ADM1Ta?EQcUb#;?0I6<#M#SCVPWB_W(4
W1UZE)O/b/^cbBbLJZ8PALQ3Y:20>ZH6TH.:J4DMVI)cZH^=6W@)0U)JN_f\DMdL
266(C]@?D:b=C/QK+>4AC#DM2S+8JB>JY@\T5S7A\Gg09dgVf0#9=4?b6W01e/+F
^@^<RZ<]c+Y20[?Y/F\Q.K51:fWGV:6M_T,-2S.I+3AJ2H#Yf+SI@MfPJPC\9N9U
gBP9XOCD^X#/LX?\=:eE]65>Z3_-O.9Ld>W,)],Z6KK:?RR6Q<^SJ7b).]G9;R,8
AXZFP+#aeFJ=e_<P#Zb/d>W92V_MD5U&01G;aXH;8733.1a=OZGCLa1C5U/SH.D7
(<T]G;#D,#65]&?_;:E?Q?TW(g\P5d3PAJ@BLAGd3dXQ#3=PZ<56,YBW-=BYL8E2
R]F\+M+f2LS3F3BcQWMRQbTCg8-:Oa3Y0TK(58=CCF2-,YV(^F;gN;c)K#TgBJVD
<6).AX#)47Rg8,Y\)QN]-G2=Y>O,gT09:<KBK92H[MdV\,7c+(B4S)Se0^548K,L
g.+#[R\HH:b<_)gO++OQG5=<@6[I-]]0]E7;(RaNM,,;dB2Q:\LeXGH/-0F5+//[
9(DHPIU>;]Gg9<VaA>c6HDX94(2M[XICK8a-d.5gR/?7_T4PE1&dWEC2^f6GA_fK
WX(5cLUZ3IWB7O?=3;I.6J0URK9MLYEA9H\D/]KR1E5aA>OXL,9?fLJ75M4aQ0):
D)ZX;]:J\WbGRfP5;TYW-SDX=.0TD7J2^H^J0^_C:V5WRge^XDe7?P6KB0YWdaa=
>#8]\dU^PG_C.G2<,U>cgB4+Q?9Yb)&9R@^G<eC5AIJ[VBWa2B1T#g?LXaO&FLdb
fD[71OQX(VMC)b/Ga(L^V=Na7<+H&d2M2^M=50Kf]L3[B$
`endprotected


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

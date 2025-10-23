
`ifndef GUARD_SVT_SPI_AGENT_CONFIGURATION_SV
`define GUARD_SVT_SPI_AGENT_CONFIGURATION_SV 

`include "svt_spi_defines.svi"

`ifdef SVT_VMM_TECHNOLOGY
`define SVT_SPI_AGENT_CONFIGURATION_TYPE svt_spi_group_configuration
`else
`define SVT_SPI_AGENT_CONFIGURATION_TYPE svt_spi_agent_configuration
`endif

typedef class svt_spi_system_configuration;

// =============================================================================
/**
 * This class contains details about the spi `SVT_SPI_AGENT_CONFIGURATION_TYPE configuration.
 */
class `SVT_SPI_AGENT_CONFIGURATION_TYPE extends svt_spi_configuration;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /** Bit indicating whether the VIP is to be used in Active or Passive mode */
  bit is_active = 1'b1;

  /** Bit indicating whether an Active VIP should include monitor capabilities */
  bit enable_monitor = 1;

  /** SPI enable_txrx_chk bit enables protocol checking*/
  bit enable_txrx_chk = 1'b1;

  /** SPI enable_txrx_cov bit enables functional coverage */
  bit enable_txrx_cov = 1'b0;

  /** SPI enable_checks_cov bit enables coverage for protocol checking */
  bit enable_checks_cov = 1'b0;

  /** SPI enable_txrx_xml_gen bit enables xml generation for annotating functional coverage */
  bit enable_txrx_xml_gen = 1'b0;

  /**
  * Determines in which format the file should write the transaction data.
  * A value 0 indicates XML format, 1 indicates FSDB and 2 indicates both XML and FSDB.
  */
  svt_xml_writer::format_type_enum pa_format_type = svt_xml_writer::FSDB;

  /** SPI enable_exceptions bit */
  bit enable_exceptions = 1'b0;

  /** SPI enable_txrx_reporting int, indicating operation enable and depth. */
  int enable_txrx_reporting = 1'b0;

  /** SPI enable_txrx_tracing int, indicating operation enable and depth. */
  int enable_txrx_tracing = 1'b0;
  
  /**
   * This field is effective when #enable_txrx_cov is enabled for SPI Flash mode. <br/>
   * It is used to select supported flash part numbers whose coverage object shall be created.<br/>
   * Coverage bins of loaded part number will be populated in a particular simulation. <br/>
   * Simulation run with different part numbers selected can be accumulated to check the verification completeness. <br/>
   * For example : <br/>
   * enable_spi_flash_catalog_coverage["N25Q_1Gb_3V_65nm"] = 1, creates the Coverage
   * object for N25Q_1Gb_3V_65nm device. <br/>
   * Similarly coverage can be enabled/disabled for multiple supported part numbers. <br/>
   * Please refer to catalog for list of supported part numbers. <br/>
   * If a SOC supports Two part numbers lets say N25Q_1Gb_3V_65nm & N25Q_512Mb_3V_65nm. <br/>
   * We must enable this array for two supported part numbers. <br/>
   * Simulation run with diffent part number can be merged for verification closure. <br/>
   * If this array is empty then by default coveage object for only selected part <br/>
   * number will be created when #enable_txrx_cov is enabled.
   */ 
  bit enable_spi_flash_catalog_coverage[string];
  
  /**
   * Reference to the system configuration object.
   */
  svt_spi_system_configuration sys_cfg;

  //----------------------------------------------------------------------------
  // Random Data Properties
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Protected Data Properties
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Local Data Properties
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Methods
  //----------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(`SVT_SPI_AGENT_CONFIGURATION_TYPE)
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new configuration instance, passing the appropriate 
   * argument values to the parent class.
   *
   * @param log VMM log instance used for reporting.
   */
  extern function new(vmm_log log = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new configuration instance, passing the appropriate
   * argument values to the parent class.
   *
   * @param name Instance name of the configuration.
   */
  extern function new(string name = `SVT_DATA_UTIL_ARG_TO_STRING(`SVT_SPI_AGENT_CONFIGURATION_TYPE));
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(`SVT_SPI_AGENT_CONFIGURATION_TYPE)
    `svt_field_aa_int_string(enable_spi_flash_catalog_coverage, `SVT_ALL_ON)
    `svt_field_object(sys_cfg,`SVT_NOCOPY|`SVT_NOCOMPARE|`SVT_NOPACK|`SVT_REFERENCE, `SVT_HOW_REF)
  `svt_data_member_end(`SVT_SPI_AGENT_CONFIGURATION_TYPE)
   
  //----------------------------------------------------------------------------
  /**
   * Returns the name of this class, or a class derived from this class.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type `SVT_SPI_AGENT_CONFIGURATION_TYPE.
   */
  extern virtual function vmm_data do_allocate();
`endif

  //----------------------------------------------------------------------------
  /** Used to limit a copy to the static configuration members of the object. */
  extern virtual function void copy_static_data(`SVT_DATA_BASE_TYPE to);

  //----------------------------------------------------------------------------
  /** Used to limit a copy to the dynamic configuration members of the object.*/
  extern virtual function void copy_dynamic_data(`SVT_DATA_BASE_TYPE to);

`ifdef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Compares the object with to, based on the requested compare kind.
   * Differences are placed in diff.
   *
   * @param to vmm_data object to be compared against.
   * @param diff String indicating the differences between this and to.
   * @param kind This int indicates the type of compare to be attempted. Only supported
   * kind value is svt_data::COMPLETE, which results in comparisons of the non-static
   * data members. All other kind values result in a return value of 1.
   */
  extern virtual function bit do_compare(vmm_data to, output string diff, input int kind = -1);
`endif

  //----------------------------------------------------------------------------
  /**
   * Does a basic validation of this configuration object.
   *
   * @param silent bit indicating whether failures should result in warning messages.
   * @param kind This int indicates the type of is_avalid check to attempt. 
   */ 
  extern virtual function bit do_is_valid(bit silent = 1, int kind = RELEVANT);

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Returns the size (in bytes) required by the byte_pack operation.
   *
   * @param kind This int indicates the type of byte_size being requested. Only supported
   * kind value is svt_data::COMPLETE, which results in a size calculation based on the
   * non-static fields. All other kind values result in a return value of 0.
   */
  extern virtual function int unsigned byte_size(int kind = -1);

  //----------------------------------------------------------------------------
  /**
   * Packs the object into the bytes buffer, beginning at offset, based on the
   * requested byte_pack kind.
   *
   * @param bytes Buffer that will contain the packed bytes at the end of the operation.
   * @param offset Offset into bytes where the packing is to begin.
   * @param kind This int indicates the type of byte_pack being requested. Only supported
   * kind value is svt_data::COMPLETE, which results in all of the
   * non-static fields being packed and the return of an integer indicating the number of
   * packed bytes. All other kind values result in no change to the buffer contents, and a
   * return value of 0.
   */
  extern virtual function int unsigned do_byte_pack(ref logic [7:0] bytes[], input int unsigned offset = 0, input int kind = -1);

  //----------------------------------------------------------------------------
  /**
   * Unpacks the object from the bytes buffer, beginning at offset, based on
   * the requested byte_unpack kind.
   *
   * @param bytes Buffer containing the bytes to be unpacked.
   * @param offset Offset into bytes where the unpacking is to begin.
   * @param len Number of bytes to be unpacked.
   * @param kind This int indicates the type of byte_unpack being requested. Only supported
   * kind value is svt_data::COMPLETE, which results in all of the
   * non-static fields being unpacked and the return of an integer indicating the number of
   * unpacked bytes. All other kind values result in no change to the exception contents,
   * and a return value of 0.
   */
  extern virtual function int unsigned do_byte_unpack(const ref logic [7:0] bytes[], input int unsigned offset = 0, input int len = -1, input int kind = -1);
`endif

  //----------------------------------------------------------------------------
  /**
   * This method is used by a component's command interface, to allow command
   * code to retrieve the value of a single named property of a data class derived from this
   * class. If the <b>prop_name</b> argument does not match a property of the class, or if the
   * <b>array_ix</b> argument is not zero and does not point to a valid array element,
   * this function returns '0'. Otherwise it returns '1', with the value of the <b>prop_val</b>
   * argument assigned to the value of the specified property. However, If the property is a
   * sub-object, a reference to it is assigned to the <b>data_obj</b> (ref) argument.
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

  //----------------------------------------------------------------------------
  /**
   * This method is used by a component's command interface, to allow
   * command code to set the value of a single named property of a data class derived from
   * this class. This method cannot be used to set the value of a sub-object, since sub-object
   * construction is taken care of automatically by the command interface. If the <b>prop_name</b>
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
   * Simple utility used to convert string property value representation into its
   * equivalent 'bit [1023:0]' property value representation. Extended to support
   * encoding of enum values.
   *
   * @param prop_name The name of the property being encoded.
   * @param prop_val_string The string describing the value to be encoded.
   * @param prop_val The bit vector encoding of prop_val_string.
   * @param typ Optional field type used to help in the encode effort. 
   *
   * @return The enum value corresponding to the desc.
   */
  extern virtual function bit encode_prop_val( string prop_name,
                                               string prop_val_string,
                                               ref bit [1023:0] prop_val,
                                               input svt_pattern_data::type_enum typ = svt_pattern_data::UNDEF);

  // ---------------------------------------------------------------------------
  /**
   * Simple utility used to convert 'bit [1023:0]' property value representation
   * into its equivalent string property value representation. Extended to support
   * decoding of enum values.
   *
   * @param prop_name The name of the property being encoded.
   * @param prop_val_string The string describing the value to be encoded.
   * @param prop_val The bit vector encoding of prop_val_string.
   * @param typ Optional field type used to help in the encode effort. 
   *
   * @return The enum value corresponding to the desc.
   */
  extern virtual function bit decode_prop_val( string prop_name,
                                               bit [1023:0] prop_val,
                                               ref string prop_val_string,
                                               input svt_pattern_data::type_enum typ = svt_pattern_data::UNDEF);

  //----------------------------------------------------------------------------
  /**
   * This method allocates a pattern containing svt_pattern_data instances for
   * all of the primitive data fields in the object. The svt_pattern_data::name
   * is set to the corresponding field name, the svt_pattern_data::value is set
   * to 0.
   *
   * @return An svt_pattern instance containing entries for all of the data fields.
   */
  extern virtual function svt_pattern do_allocate_pattern();

`ifndef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * This method returns the maximum packer bytes value required by SPI. This is
   * checked against `SVT_XVM(MAX_PACKER_BYTES) to make sure the specified setting is
   * sufficient for SPI.
   */
  extern virtual function int get_packer_max_bytes_required();
`endif
  /**
   * Assigns SPI interface to this configuration.
   *
   * @param vif Interface for the SPI agent. 
   */
  extern function void set_spi_if(svt_spi_vif vif);

  // ---------------------------------------------------------------------------
`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(`SVT_SPI_AGENT_CONFIGURATION_TYPE)
  `vmm_class_factory(`SVT_SPI_AGENT_CONFIGURATION_TYPE)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
LFGk+vEWm5NAaoz3vbMCHCPM2tMx25Kg4mAe25TWWmE13ghGKa1lx8N50F8cLX9t
+IyAcvU5P1Spf2C0HeEj+NLHDkPx51YHHBscQIwRiS3ITodNbzi+cRPHYXArTYxq
oiE5y6R0P6deo9rRT+b6cEyc2ZneuRuZTlb45PqyUAx0wzCxtjXkbQ==
//pragma protect end_key_block
//pragma protect digest_block
W07rmlMWzeH+I8VJ0CCJNhm0sHY=
//pragma protect end_digest_block
//pragma protect data_block
4cfdTa/qnOm6pb+8p82sKTida419VOXssFdGqM1/ZUql3Lgge7L8O5t/Hx6X/h+x
yFVBf5V7mdjT5Tl+UGfZo1CAtLZ/mS4Mxk3XOZ5TD74HYpIHRG1/URkXMiVdYfhX
7bYDkSDL0KmLfVUsBI1cCKELG6kYCpyATA5h8oN0f3z8aeHed7uHvmsmNO/tEjYo
KleCt5i8Ofvb+/+UDV1KHLn9dwWlaaNvRniYHigmo+I8sqmZBF4+navIJerNxIMo
GVbR3vyFhnB0dI67jlMU6/7Qa7/C9El9c5eTvRS+vJ2eGis+JWuldCHUiWQnCSnU
eVA87XMrVR/XcMkCvZ7QayRNAsvhu3dKq3f59ZkuCDTbj132PZdauHpUbRbIFYTo
qOpTsHTw38hKuk+649T3cWv4/hcoDcrTBEPCPfETAwqjl8BESjpOo+P9tRVD13tr
DSc9CVV0ccta/ypqxaK7wRnthoSxkjjX0OXe8tsK00mRhVJCl7k8QRHQYPueQ9XJ
vI0v5GcLh2Y0addIu1cwpvTBt3At80DKnXUioNx8EXD5ZMpBgF6NQKRoeHbJIrsL
mwg/hG2DgN0G51/xecZbxhrzQ4iFOfUQHROnSKH4DkPqjDb0S+SsrydrMc/VGtTt
AKS0L577++vwkpvcLfVJsVy8TpigZGXcyNJRLOXsiIeZjsiTfjFQ8vx5wH3kv9Zc
MNeKWzg7PTvPpv58Oe9mT8tFVQ6jA660tj0FeU107tfQD7CSLC+QDukxXoLvCAxD
d47omUnp3OPE07AcInZuAn+vo+AQAQh40AI0t2wEMvOCdDGOVYx2yme2RTZfHhHj
jUN8ZMh03xmFGlBUx6qF08Dyn/w5WR3aEWXs2vtu9//yKASw42yT/w6oznhjroRW
CtFH6I3cTIP9sfQfuwOBbsqnKeubjBVA2C3OioFWgKui/KAGKLY8+4Ozn+4NWbwh

//pragma protect end_data_block
//pragma protect digest_block
St2QGXohUS+lZzK4NOodGAwdoSs=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
T9mt3a5K9EyWyKCjDQLGX5Qx2XfkUopLzE7TYLy1BRUI3pjWNw7wcMsRciRRfMwJ
B5kQqsz3bkbQ49s7XK5YjvRUw9VX9AlYGZDv1xqj2jiY0jzOVJ6xeg/F40i29uHG
QltsH8YFT2bMQ0e+WhkBb0iKs9mrdnIvZoN+3A770Ebc5wlIP22Szg==
//pragma protect end_key_block
//pragma protect digest_block
hHOuiJHkMDNG4A6R4lPIc5iTfso=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
kTV5SHwZz80PdunfXWUOLv6bjo8=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_SPI_AGENT_CONFIGURATION_SV


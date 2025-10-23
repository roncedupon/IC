
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
ie8tUbDVJzYfPV+W4gtlcvQn9wP75Byj/NziQCc2obV2++YD9tojxyPhI6OtzAaT
uvZmFMNRlzcUgrROEl8/71gttbXHjGNScF+2t1wE3vd6l9i1UMgcv2g7Gmr/KdKg
hxk3aSBTDd0QRTS8afBZMU/uiss48Y3JYD+l0TQFPgkhv8OAtLSuGw==
//pragma protect end_key_block
//pragma protect digest_block
1k9BZEaoAivcpfy4QkMsymJ5+Tc=
//pragma protect end_digest_block
//pragma protect data_block
XteQK+CeTeZ6+8N1jVOzhF8KGRMEpMP5YcSn3YmCdzHR5d/OMkKOZMF+EphB/zCG
jEISo5NrrGJ09GtwvQ+pzw1LT/xp8ZMA9ouD4wA5Ocll5ORYCynVSC5eD1QhQ8pA
ZpKuvGJd5wmRgsr4VN7vJ3GelFa8oJ/4kD/3pCDoTZVTtTOix5VY1TXrc0ChHcbK
yS/el9tsY4k5iIMuEtwSfNlunUKJ1sDq2KSM4nucXUfcSqLtHf9De9QUlXS/VibM
rwoHSJb/Fz1W7gMippTItZi2iw0HEqBHTRRBcG/LdicJtgTbZPT1kKDs6IXBAaUf
gYESRYZgRnJDrjJ4lHpG8aUU2DSTO7q+azXheQJ0Zbx0eu5g4wGBY5EaKyvs86c9
xNyHMsdFeV+FjLMHcWuj5xtvDVr5DzZlAumYn/0N/jm8inXJtTSYyTIXRv5g97AF
byDxL2g/U124ouIbWpLGnXuhF2NJsf3seMxzFN9bUex/9kzar3ebhmcpICDZqFWT
0bdwUy4Nm9KYE0vKUIsetHu5rifysjm2xSEVuGqiwPUKf+Vu4vCkMn2ItFCIqIOK
e+LNkC+GoYPzRIJM3qkXhyO/iVIfcOwKoBftgXkjyxEHEUEST6A4lkM2sj4Rhs3u
PQ/Yc1iphjyhloI141IIZEk6GuwZ8uRcFKz8LbXMvviDtN0Fsj2bMvvxoXjkBDHZ
BD5dQmGw2WTPYcrYUkjSO7lRS67+DxlTuZ7okC5UDYzZyBg5X9MuxxSEDvAA8ruX
VT33ep35tudnIlL+By8yeK7jK7z+4Ng4uVRlhjh0NlgIVdqzyIFPvgnDbNJnjCC6
4wfXZDLQDAMHMfLF5vVIfcNUnVnuSIbNJm93D3tuhWAVpfdbS1eT9Z7LbUg6OEAv
nnhXGhd9qryHof8kuiGZWoNHXV6ik5A9+QpBKzj+ZdcQNoVPz/pjWGy+wBhv+nr6

//pragma protect end_data_block
//pragma protect digest_block
SN4pmBSdXlmTuzkDasFd3V4F4Pg=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
GUndnzXC/qDrieSmC0V9ZH6uVAs1LpvUfHpKWYmMSjtqitqZ7ntyacgUXhh3whTL
5ugWiSdD3mJTowJNOzDoEYq30ed1inEXt/c0Ddfu0fRmordwteOZF8mPqDPCNobG
L3QdiDnv5n+ohZqDjxQE3nVSC7aTQsmDKEtBWMtanF4Hd5p/++t3zA==
//pragma protect end_key_block
//pragma protect digest_block
+0vx2od8qRmMD81UeZdTv5SK7Zg=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
I7o056MHNsNcUJcf6aLgWgEyOyM=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_SPI_AGENT_CONFIGURATION_SV


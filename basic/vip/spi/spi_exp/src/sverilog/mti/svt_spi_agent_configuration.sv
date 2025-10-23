
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

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
bFKivfsIHB0S/wmSDLODtnVtQNSMId5vp0OQt5LJ+cnbK4eqH+9suYns/s9luD5n
Lf3CdNwmpwzrQqstgLTmzblf9xKXM2b8BKFimXmnYJcD4yFYrvX9MlCZ4xQDT68U
N2MYLRsaqkrjj0yCu1Ir4+E94Q8W9c5srTzhhbtg4ak=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 551       )
Ldw+VsA4jxbYcdcQn58OG4SlGFiADWlupu3BgJzZXK9iAnxssgrrTvH9BmkSBbTJ
VyxPjliJH1EL6hEQ7ag/Z2Wd9Zq0cxj+kM3KSy8ANMWs2z82D+M5oVCPKE/AJZS7
A5QYXNrbYvm+a7BLpkRFxs9R2GOKv+CZShhaep6h7JYrLHm7iBmrT3GiqudfCIkF
MedEBghe9YfZd0EY8EYCPmXKuEnpAqz+JIcStkVeZ0UrAJTjMCPxgKMRuphAcLJG
p4fxO2yJEdk24LEVO2CYVupBQdUyXSNuyTBVLaTd7L6kPGXE8+6yyckm5FFr9B9m
arDCXOId+rR4+Tirjrsgrm0WYpsg3DsSRm2DpDj1U93n4MSA/XC6twOEYdgCvYQd
PEeeaEC9zDiIJPmmMBq/f3ERxQHUMmUOQ0CsQ0rJx5cwEJepwUHPgiX9a+PKyIeV
sXHq9v7hTFVjce0xbaAkvknpAkogOXu1qdnAjGJuJ8nBWlpIec6K7+k5KCaVn+gJ
1hmtos9KSfotAk6juqkSqVTVDvImWqB9QzBSA07fe60u/AS0QPnBH8cc2uW3HCLl
RajvbmbHk5dvPGGzjeWZslxCb1vXgqPEzgOaJlfx7uxEthMvMPJ09vK+A8uLk4Ri
BnK5INMHzW+sS4stT/Ph00Ohwt3rk961tDPoWqRFqXxYeWduwoIWbQ+okekev11b
N7x9LHvGcg+93YQFnYkhdmI2lmv7VJkrQ/zRIQKINzg=
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
ovW7Iyyy9FYg1x+FUFBKpZtDRMitnW6uROdZUmHG246ONJ9MWhILCdkKgObYfAr6
vsBJIWgSOkaFusH8wOt29TSEM2TTDueTh0IIOPo6TTkhgq9PKhMwZL7/UhQXwJ0H
xHh25JtAUh+X0BaClbg310pPwcbo2OL+MtMEpyEvo9A=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 15741     )
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
`pragma protect end_protected

`endif // GUARD_SVT_SPI_AGENT_CONFIGURATION_SV

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
iapdSYtTH60K2IY19KcLtU+CvRrUHsB/81cDThgmkNz8nFwEU4Z4nqa8hbxgpxqY
oImgf/+0fXMJ9fhZ/73bOyx+nYeoCLmuIzUftO6zsbKZfXU/0v/tp9aIm4XfleSb
PcWsLNKStRAdDURVVrcqLgvqlfGVN6rXsoqbtjh7SXk=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 15824     )
+eaWh1O/ckL4Q2qRe9bvdp1uR5o6FF2gVOKk7xI8dO7ElmO+IqUQ0r5jVp8xsQ9/
ODvMASqh500Bw3C2uo8BhTKK4LNtu3xoXILwCee/LHo84FoE2vXcLlZd/PgiSH1w
`pragma protect end_protected

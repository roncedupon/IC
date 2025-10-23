
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
ZoSsaU+ageuHRbsasRRkSRydQMpIEuxZY7N1RvAwaO4s8SHXSg8b862qeM9aIqRc
ygwti6wD/Ehz/t2O0uq3QPGZA0deP4G1kkSZxiSuy792qgHIitKXeNYRw/IUz9fk
ZoS25KKCQuxveU0x7zcvkBjV9qhzJrKhXEUDSSDHqeA=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 551       )
rMYGieY60MNaP+pACVNVNKfQ9BeDpE0HJya9+diayq2/AYuehXlSZdCSu5RI/AqA
+fk0hTXCvJ/FxR3Og8gLLleK3owmuTRtPPBKX+Jaz+JNKYhvk6AALVvTzeD2nAU6
YDyQpdbqz66tPJ8xDvD+SNQFKuy7Q59uqEJoIjllNlxEPDjxLpVHE1Uw+OapcJH1
Dx3+Db6sc9duoiKZ6xBETe1VysRBesbkSZs42n8aoy/ctHF48x9CaCSFdidE8Onz
f39DOtYQv7nSb0rRaf0NCubSLjimxm8/8YUlKbFTEsuvIHimoUCEzzsu19ki3Jf0
XN7LXHtvpf9TbEBntCXpH97M8q+mnQz5pC6IrFt/6gZEqPkDOG2Q83ief9tlLPNN
2Gkbk2Gv5+VshC0nWGh15dj11BjnGR7a9ZHK8aqJa0v5oHmUOZPjcPANAkSH4FsM
61DMT5ldelQADgtn35SIDRN29c707hrzwLOmyyLJCL6fOHicKIsOVFdd2S2U6j3s
5ATl7NSXfUpYQrb3R40SihpFZj29K7F1ZPaupPHLAKn6/wSFwFfsIXGm+lWJ+oCH
y5Tk3LwUyg8x6om/qKthikZJpEn7wx0kD7VST8FTsGMsMFW+D1KrDZcPKcVAXheG
vfaF4ISU7vm0WlhhYb83BUzMW1hAiemFFn8c8BQAhsLPxkmuqrPl5ULvhmhfdr+X
EVQ7+nqRDl429mfOXpaqYpz6um2kGLS59uRO9qTlXNQ=
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
lq38Jbd+Je8SYKZbWTRA10wbCsmFlRicpBSOMLCQFN8klszjuU4msyyV3ASuaAZO
WBGzSX7gEMn3LulUO89s9XqXf2LBMRhaDG/6s/VzjQc7Dk5OCJWuM0jTApIWrYbk
0t43E5WH7UNh2iyLoUBhdJqqBOE6G1PNYyRcbvBMqEA=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 15741     )
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
`pragma protect end_protected

`endif // GUARD_SVT_SPI_AGENT_CONFIGURATION_SV

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
ogMDMso3EpDU8eJOTPABHew4K9nc7d3YlxfhX/6vs6qhSI0cZkNC5cKdJYseKTDx
+moB9KY+fdAN40z1ShHP4elw8WoL0QrE8uU4S3M76LnQbSImJb9UYxM0K70G1RPq
DBO/5qpfZoR18/8HtaRYvcYocmmnofWmb+A+6cp7DSk=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 15824     )
vJ1AuUtmfyzLG+wuCjeGvG8XjZFcFNFmkhuYTsFcZ+w/5AOgcNG0Ja4moHsr1Zdx
51ym8Qo6BZUqnmbWS3Xj+TiSEIqMk7h+UjuxcHSIFz0Pc0Xi41guKWfh5GRno9l4
`pragma protect end_protected

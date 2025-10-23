
`ifndef GUARD_SVT_SPI_FLASH_JESD251_XSPI_DDR_AC_CONFIGURATION_SV
`define GUARD_SVT_SPI_FLASH_JESD251_XSPI_DDR_AC_CONFIGURATION_SV 

typedef class svt_spi_mem_mode_register_configuration;
// =============================================================================
/**
 * This is the AC Characteristics Timing Check Class for xSPI Flash based 
 * Adesto JESD251 device family in DDR mode.
 */
class svt_spi_flash_jesd251_xSPI_ddr_ac_configuration extends svt_configuration;

  // ****************************************************************************
  // Local Data
  // ****************************************************************************
`ifdef SVT_SVDOC_CC
  /** Workaround for SVDOC CC circular references */
  int cfg;
`else
  /** This is a handler to the SPI memory config object */
  svt_spi_mem_configuration cfg;
  /** This is a handler to the SPI mode reg config object */
  svt_spi_mem_mode_register_configuration mode_register_cfg;
`endif

  /**
   * Initial value for all the timings which indicates that parameter was not
   * loaded from the catalog
   */
  real initial_time = -5000; // must be smallest then all timing

  /** Minimum Clock high pulse width duration. */ 
  real tCH_ns;

  /** Minimum Clock Low pulse width duration. */ 
  real tCL_ns;

  /** Minimum Clock high pulse width duration. */ 
  real tPeriod_ns;

  /**
   * Minimum Duration in ns for which Slave Select must be deasserted in
   * between Two Instruction sequence 
   */
  real tCSH_ns[];

  /** CS# Low Active Setup time */ 
  real tCSLCKH_ns = initial_time;

  /** CS# High Non Active Hold time */ 
  real tCSHCKH_ns = initial_time;

  /** CS# Low Active Hold time */ 
  real tCKLCSH_ns = initial_time;

  /** CS# High Not Active Setup time */ 
  real tCKLCSL_ns = initial_time;

  /** Data in Setup time  */
  real tISU_ns = initial_time;

  /** Data in Hold time   */
  real tIH_ns = initial_time;

  /** Output Disable time */ 
  real tDIS_ns = initial_time;

  /** WP# Setup time */
  real tWPS_ns = initial_time;

  /** WP# Hold time */ 
  real tWPH_ns = initial_time;

  /** Output Disable time to drive MOSI/MISO ports to be tri-stated after this time */ 
  real output_disable_time_ns     = initial_time;

  /** Min Output Disable time to drive MOSI/MISO ports to be tri-stated after this time */ 
  real output_disable_time_min_ns = initial_time;

  /** Max Output Disable time to drive MOSI/MISO ports to be tri-stated after this time */ 
  real output_disable_time_max_ns = initial_time;

  /** DS output active time from CLK */
  real tCSLDSL_ns = initial_time;

  /** DS output inactive time from CLK */
  real tDSLCSH_ns = initial_time;

  /** CS High to DS tristate */
  real tCSHDST_ns = initial_time;

  /** DS tristate to CS low */
  real tDSTCSL_ns = initial_time;

  /** DQS to CLK delay */
  real tDSMPW_ns = initial_time;

  /** DM Setup time. */
  real tDS_ns = initial_time;

  /** DM Hold time. */
  real tDH_ns = initial_time;

  //----------------------------------------------------------------------------
  // Type Definitions
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------
  `ifndef SVT_SVDOC_CC
    /**
     * A helper class that can generate random values for non-integral properties
     * 
     * @verification_attr
     */
    svt_randomize_assistant rand_assist;
  `endif

  ///** Assign refernce of spi_mem_configuration object */
  extern virtual function void set_timing_cfg(svt_spi_mem_configuration cfg);

  /** Randomize all timing parameters in between declared range */
  extern virtual function void set_timing_params();

  /** Randomize tW timing parameter in between declared range*/
  extern virtual function void randomize_output_disable_time_ns();

  //----------------------------------------------------------------------------
  // Protected Data Properties
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Local Data Properties
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Constraints
  //----------------------------------------------------------------------------

  /**
   * Valid ranges constraints insure that the configuration settings are supported
   * by the spi components.
   */
  constraint valid_ranges {
  }

  //----------------------------------------------------------------------------
  // Methods
  //----------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_spi_flash_jesd251_xSPI_ddr_ac_configuration)
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
  extern function new(string name = "svt_spi_flash_jesd251_xSPI_ddr_ac_configuration");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_jesd251_xSPI_ddr_ac_configuration)
    `svt_field_object(cfg,                  `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
    `svt_field_object(mode_register_cfg,    `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
  `svt_data_member_end(svt_spi_flash_jesd251_xSPI_ddr_ac_configuration)
 
  //----------------------------------------------------------------------------
  /**
   * Method to turn static config param randomization on/off as a block.
   *
   * @param on_off Indicates whether rand_mode for static fields should be enabled (1)
   * or disabled (0).
   */
  extern virtual function int static_rand_mode(bit on_off);

  //----------------------------------------------------------------------------
  /**
   * Method to turn reasonable constraints on/off as a block.
   *
   * @param on_off Indicates whether constraint_mode for reasonable constraints
   * should be enabled (1) or disabled (0).
   */
  extern virtual function int reasonable_constraint_mode(bit on_off);
   
  //----------------------------------------------------------------------------
  /**
   * Returns the name of this class, or a class derived from this class.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_spi_flash_jesd251_xSPI_ddr_ac_configuration.
   */
  extern virtual function vmm_data do_allocate();
`endif

  //----------------------------------------------------------------------------
  /** Used to limit a copy to the static configuration members of the object. */
  extern virtual function void copy_static_data(`SVT_DATA_BASE_TYPE to);

  //----------------------------------------------------------------------------
  /** Used to limit a copy to the dynamic configuration members of the object.*/
  extern virtual function void copy_dynamic_data(`SVT_DATA_BASE_TYPE to);

  // ---------------------------------------------------------------------------
  /**
   * Hook called after the automated display routine finishes.  This is extended by
   * this class to print only protocol kind relevant fields
   */
`ifndef SVT_VMM_TECHNOLOGY
  extern function void do_print(`SVT_XVM(printer) printer);
`else  
  /**
   * User extendable hook which is called immediately after svt_shorthand_psdisplay().
   * This is extended by this class to print only protocol kind relevant fields
   */
  extern virtual function string svt_shorthand_psdisplay_hook(string prefix);
`endif

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
 
  //----------------------------------------------------------------------------
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
  extern virtual function bit encode_prop_val(string prop_name, string prop_val_string, ref bit [1023:0] prop_val,
                                              input svt_pattern_data::type_enum typ = svt_pattern_data::UNDEF);

  //----------------------------------------------------------------------------
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
  extern virtual function bit decode_prop_val(string prop_name, bit [1023:0] prop_val, ref string prop_val_string,
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
  

  // ---------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_spi_flash_jesd251_xSPI_ddr_ac_configuration)
  `vmm_class_factory(svt_spi_flash_jesd251_xSPI_ddr_ac_configuration)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
uPbR0nj1ZNwSA7H1Y4/0NATsIc08WZzfUA16vNisqeqWFc5fUYXDGHlMYKUTwS89
RYFExSmnDair4fSJAQjKmynH8wDUn8BVgvS+VMr69WRkvX2bpzMONmIe/Na4T98g
FY5BTQ4+0dvhJ7AXl1jRseW/SHAnXWX1l/jK5r1BbpChoji9mtPL1g==
//pragma protect end_key_block
//pragma protect digest_block
+o6qkekw7yFFPU0yecIUplg0r8M=
//pragma protect end_digest_block
//pragma protect data_block
GVOT1qL9xWH3UsN24tirFSQ91yGYsMYEDGynIAb8flTk6lRrJoRWqtJJ+De5mVy2
HmOtu2AHGgEgxXttZB/dsr1e8PDim2Gyfe7BxImAZ9yvyG4dY7/Ojr5tXrg1LAwv
9QFq7LVHxpD5DWmBu1ThbKpUUJjrOfmCPkjcZbSBhNBY7Q/MH3c/tAzjPHiCi4VP
RBnL3ahUKrXPxhqf11HRoct9M5CkDWESac9z84dmXZmDRNcFJ6vOkGTAX4mw8Q1F
k6rNDfajCFtGyZA7QgxcvA2ySn6Naty6oaPT/HAh3I+BIcJqwZj9ttPlXvx2yH4R
mkNR6kowOItKqtxqIs74sx9Yh6fOfNx2wLJx3ZlztnEtf9hSFhN5odTd902duEm+
xDI5U+wxhYWwUzguupp4fi4pwe731YYKHw5lSL4kcbLtLUsb46CJFrEVgrPBZpIe
SWMpOeDU9JnpRoib3JHPn9Tytl1LDi8cSSHVO5H5e12C6XTzJCtSM/4Kzdjlk4pq
mync0mieoZ/15FEZoslAoOwWd+zWRBcXSMzP1ddrAyhI7bvYaPDsYMv4IiPS1y/S
522VnMcYYw7EL+5Q6gP/ECTKmrP2bM7wlnFglSAVOGlaKK8/OHOKwW4Vq1R0TgcS
7UlT7nt1DsS9vOrfAGKQpJzxL1ecrPoZ4xVzEebVHsGEl9kZ9OzQ4xnCHzinzq3h
o/SnQE5lFNPWGcgc8VOYnR/pGjM3W1rbJFiEC03tmcJD7kK0/8s5HcMqbDxugbYU
vFwwzepOhFMAdOqtkrJnqAuPJUILHPc6FJVUKkjNX/apSlfI89unnti0DHUrF7N8
//9dKv/fKechs8IxQ0DW4bG681WpoMizfH9zEzlApnsGhrIQDIDrhVt+AvIV0l7u
bpDahS/Jm7L+Gbzl4pO8k5o1YXTsS7CTLw+Fqx6fYU4OQ3rVRlpEMusrjGOUt8mu
gvNvhghepwdcwBWXW2HWJWA7xkenTu6ElB/6VSzNbAwsdtjF9ZDjFH9mGfPMRaZj
7oMiiaDCCErQW1eStc2/2p469slKvkXx5IwTmj1umERqLqLXehZ9I/7fHcobHSE8
qSz+LLvZOgKhiLZ8jqk/7h5YnOOGzjaoxvXzqymQo3fhhTQIpSl5aZgpQPqvSItM
V8oiI2aVUdEamum4SMB1OrneOsWUlHsaIJjJOe6FXd7RYF/ncTVSukSH3HMEMDLu
5phkDYAS/Qr/t9xUCqRoaq3//zFLSFOMNCDbVCXP/GNIuyDyaT2W4HCifCpsno5X
byp02d3yWn60gTZzisiUbg==
//pragma protect end_data_block
//pragma protect digest_block
BwbNTC9y50e5C3aQLoIsx23ere0=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
G3PAAZBayeLY6Rhj1dp7ypkxOjZOn6fne6jo/AGxGFAcnYyhBJYihv1IQySXOfPl
F0PP9SsBllkk580NM/KDQFj69jmvFTywiswRFcSLSzOThYPankuY76sziswAmWvn
TJzZG+6xw+EHy+4lObKX0DyipVGV4/gUEy2ggbX6A/4Ip6aWVCFEUw==
//pragma protect end_key_block
//pragma protect digest_block
SyXkL8c01EioX6xywfbboFNFVjw=
//pragma protect end_digest_block
//pragma protect data_block
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
GdeCqTVUOUyegx5rBoesx/TrLqTXWkvm6Vtu4kvGK5xkVk1qHqV0l3xL/XfLmyqb
3z7y89mb9fO7Zjc9fyI7cp1ND6bNt4I26/6mk2PpZqsSFOWx+/upsGvRxKaEz+L8
89pK4EAM9RbR22yMq00i4XK1h7bOFhcuFbtS9qDpTdmcvGR6Q2Q7JrKKb0EIaFwx
10W6h3fZI3cEIuuhCfe1PTjs+dJTNDtRJrkjeirylfzXc7YbDnFnGL/RNHSbNGQ5
HN4qSH1s8IvTOsN2tFfJeaHxWda4Q0yOw/kNyHSb7Oc6aLyzV7P8xSz7bOzmTex/
0diBj8F9VLaf/VIct+7LzpJt5cOqNhj+AWAC364AntXBIL97g8YfenC5CCZ0p3Vb
2bMSZg9eJY/gV+9jMj2OLVmPro6PYFErjl8tUGY9HqCA4WTNHzOfCxE/GYRqf5AC
Z8ggozYNDYJpdpOj6e38Hg9ty5b4EbBp0JE9oeJd5+bKiDYhe7wJruhln6A+qv80
wlsSoMesANCN6QgiX8Ps/ufwwCVmK99sZOeihZCmxQ0H2m0kACr+Uj4Tz6s9z1hu
VLHUUV91xK5Wl2/65gdUWnjGh7xlDL+XhQ7Iv6FYi/h5OaAYm81yKoOLFRYguapy
i2H1vcIi+A7igbEX1gcKsqjfrUKbQfPLJ/BD7zp8+ZU0yJ11wNqHu1lYoEjPsr6N
7n9b9dBoV22ReNejApxebHqcLFav1iFr1hJiRJDsV3nWUn51Z78CesFHAasqB4o9
cmQ3JiRfJG+Lu9qErw1OuNVze2hKdtqktXy3zyb87CPQILN1oM249CL0zMfujMSf
M41dm6PXeDsNu+mFXL8a03GMYA8rVIxsryGv6biLlqu1N3Plv28/MgskBaWhtoYw
lBcjNe9Gx4amzW9CtOUClO9dosHaC97zafQu+dh7WAoL4wqQTyQjsOHaVZRp/qA5
7XsFdjuJJutuWEAFNkm6+wskBLcCHPNfy0N29jcuNeLPIVOoXkz7hH40ZJf06Ggs
gW/i0cWPohF+Bvr6WsUp+wzp0EHilIZUav74K+feDPxdX5nHvykFA49e/MPtphpb
6jDT335JK8Zl/lis/yUBKJQCDx0UlOIufsoITbepUheeXNgg0zmzes7KM4YHb6uf
c2GvemZGyZns7gfrajH2wBz62V90+9ZlV/XlM2IO3qGYCMQwuWX7pkccL/7lTH7O
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
qaSH1jTf8mW/FdHOy0oCdQ==
//pragma protect end_data_block
//pragma protect digest_block
cV8vvcd9dZO3nvGf9gCz+tOObpk=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_SPI_FLASH_JESD251_XSPI_DDR_AC_CONFIGURATION_SV

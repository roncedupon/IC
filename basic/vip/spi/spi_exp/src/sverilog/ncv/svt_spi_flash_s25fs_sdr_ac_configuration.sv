
`ifndef GUARD_SVT_SPI_FLASH_S25FS_SDR_AC_CONFIGURATION_SV
`define GUARD_SVT_SPI_FLASH_S25FS_SDR_AC_CONFIGURATION_SV 

typedef class svt_spi_mem_mode_register_configuration;

// =============================================================================
/**
 * This class specifies AC Timing Characteristics for SPI Flash based 
 * Spansion S25FS family in SDR mode.
 */
class svt_spi_flash_s25fs_sdr_ac_configuration extends svt_configuration;

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

  /**
   * Minimum Clock high pulse width durtaion.
   */ 
  real tCH_ns[];

  /**
   * Minimum Clock Low pulse width durtaion.
   */ 
  real tCL_ns[];

  /**
   * Minimum Clock High/Low pulse time for Fast READ Command (SPI) command
   */ 
  real tCH_Fast_Read_SPI_ns[];

  /**
   * Minimum Clock High/Low pulse time for Fast READ Command (DUAL I/O) command
   */ 
  real tCH_Fast_Read_DUAL_IO_ns[];

  /**
   * Minimum Clock High/Low pulse time for Fast READ Command (QUAD I/O) command
   */ 
  real tCH_Fast_Read_QUAD_IO_ns[];

  /**
   * Minimum Duration in ns for which Slave Select must be deasserted in
   * between Two Instruction sequence 
   */ 
  real tCS_ns[];

  /**
   * CS# Active Setup time
   */ 
  real tCSS_ns = initial_time;

  /**
   * CS# Active Hold time
   */ 
  real tCSH_ns = initial_time;

  /**
   * Data in Setup time
   */
  real tSU_ns = initial_time;

  /**
   * Data in Hold time
   */
  real tHD_ns = initial_time;

  /**
   * Output Disable time
   */ 
  real tDIS_ns[];

  /**
   * WP# Setup time
   */
  real tWPS_ns = initial_time;

  /**
   * WP# Hold time
   */ 
  real tWPH_ns = initial_time;

  /**
   * Output Disable time to drive MOSI/MISO ports to be tri-stated after this time
   */ 
  real output_disable_time_ns[];

  /**
   * Min Output Disable time to drive MOSI/MISO ports to be tri-stated after this time
   */ 
  real output_disable_time_min_ns[];

  /**
   * Max Output Disable time to drive MOSI/MISO ports to be tri-stated after this time
   */ 
  real output_disable_time_max_ns[];

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

  /** Assign refernce of spi_mem_configuration object */
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
  `svt_vmm_data_new(svt_spi_flash_s25fs_sdr_ac_configuration)
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
  extern function new(string name = "svt_spi_flash_s25fs_sdr_ac_configuration");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_s25fs_sdr_ac_configuration)
    `svt_field_object(cfg,                  `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
    `svt_field_object(mode_register_cfg,    `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
  `svt_data_member_end(svt_spi_flash_s25fs_sdr_ac_configuration)
 
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
   * Allocates a new object of type svt_spi_flash_s25fs_sdr_ac_configuration.
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
  `vmm_typename(svt_spi_flash_s25fs_sdr_ac_configuration)
  `vmm_class_factory(svt_spi_flash_s25fs_sdr_ac_configuration)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
wXqWZiu81yUxcfuRd8dpp7XyIVkrwH6aTROO7YJ91h8Uo4809TLBQutA+69AWG5x
KBAqoCUe++P+Ca7lRwRLj8nZ5/mbX3Kr8S7DSRe912Lx2xq9WK6ipFnGiPFAWpTg
6ZA+nWlmmVEvbLQPdb2lEbpaVCD5Pg78Y+wkMRqINFVYjz5cPzkvAg==
//pragma protect end_key_block
//pragma protect digest_block
0/z7G9qMZuTY2Iq9JTEC75tR2zI=
//pragma protect end_digest_block
//pragma protect data_block
aEP20/VeuqcqH/afyxvbO9YWRFNZsBfdHlwEybe/m7rdIsF3QyOIjgp8p9VTbEaz
wGQSmYOraQQF9evkZE80HvdPcvcY9LpYlpRMchucrNTknM+9kbAmg61nMTlA4y9S
PSyoxz1K+IwWElhERmlKrayh0KgG+OwP9QOf3f9NkmPoswWtqFU8eD36DovEjw+G
PjIWdi5ScDxc/AzZVYGa986yc9sZpYSDhulCQPRv5grXfrh+2BHiwuRDOD8uDDdb
MyUGwlBwl40kzbMP+rYkikhJBEKOOz4Q3HjPrX4FYBev4nRTZceAJZXsgvJE3C8e
0P1GdmtDe4jiesgmaGrRvvs3v9Z4hj5ONdT/qSoT87TfkNbvd3GedTQ0jt3OeJXq
KJdfaVBFTUCPXF5UEGqukTmjrnRBsSodpjTxmbo5VALdUjYY6JTwNgcnd/2My1If
w3/Y9aDOnHdWQml7PpZDfaxdsz3ENVu9O6ZY3fuOzti3QW/Nc9sh4FxfqcAD+GMd
o9hy5zVzdpsWmjYYG/Ker+A4PWuIsEuAsZ98aiOavopciuSCSP6ii8DGBgikseWA
HOyV/ezvv+OP8rDvnhWlJPfaXzAR6fvnJ18z6zgTHMlCms5IW1l6nnZ+gsmuWQ5M
wZWKFSbWPX9s0pR/QGIHzmAdvPCNaUFLZDFI0Jri8bL2bCIKzqhckJD3Onnu4SOC
IEp8hjT+2U2QZaGrZBCactCTwcbSoaIKpji+8H6gj0TMZH5hWi1lT9Vc6MLzS93k
+e30vJjtA4F1jQ1xd1IGmWjm6BQd/gtH4FfgbWsUmQOEs5XlC76HQkHZTC4Tb+ys
4bJMzBeN7KgF+XXpCvw4XjE5weIrNU4mXT2FaUs3MS6f/Q3hly61WePWyTq21kZt
oBILLPH9KMmpwH0wJFH4VImjFB/vXqntOYyuKujDWmAPvMLt/P5okN8g4kEtMzTL
jTvA+19hOCGEDJhi2yYyBQvhJ17stRHo+U9YRaw7XwW6HEHBHgCFjVXuCQJ1qYmb
P54qDK6uywnFUP0kaIMnfu8VQLbyCo7fhcIGC1N2JDzZTQ9SlNVz7JMb9BNnuADM
ASqRF5w1pmpUM+e1/A6jcSqFET0UNeRkGeYFMl4J5VO2orVfL9Lup9M4HrlJictz
oXn+I5/17zR4ewB5c4eGvq3Yrk7kv2Wx+y2IwPXPUylw/jZSFdMiFtt7Fli/FEE2
EF8CCBebol/NPml4yeZ70aF32CzfRjyjBy8KFyvs9uM=
//pragma protect end_data_block
//pragma protect digest_block
VTGBxiVSP5HC44FJPJWkb3fQ4gQ=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
sZq6CfAxqb1fbg2y1Wy1JoG2uc7nyil+sN+5+gtPCW30OpwTVWU4iAAPkuqJF2CA
LBdF4gtbxy2RPRiQkB9iEtznLfUdZe3Nr2VvGAfldhWx++r5dd4xahsS9Ja4z5pz
hZmgOsxc9pPfPguZy8sM/WvDzRdpOLMltCJNR1OFvRu0Rkh+lgzhaw==
//pragma protect end_key_block
//pragma protect digest_block
YP7PB5nF57fzSGubfoLZiY9QSYA=
//pragma protect end_digest_block
//pragma protect data_block
nwZhza1qp2MznWIIXPGEf6sSza1NQSuxtuy4zYrmWr3lpM9uDQ6Ibgub/66jIUk+
3YVJZRSpbjp++xiyC8PdRRxyYkaGFHgqOgcZGD41IjcnzCBBxP+gGzvieE/ls0fR
BBnTzmtEE4BfAh4cBV3VRjmNQGtFyr7FNOhfj4DjUS8Nox9bUVVHV5juHXrZljnB
NEi7cq0WHV8HiXnDZNWeSs8kr9glMsEB5VX6VwTXUR8qVQKfFtH/TE4zWnmWH5OG
+gL2CI9JsEkBIR25X+KeeuL5JVmQ8aSaR330RrEThy6ya7CwUaOKoE19geCW+ZrW
+/SwcRkfayzyoiXkrRGToakiBa5bq7jCi8viEsRO806S8D3/MUGbydGxwtqWpr+K
ta40PNC3lb2C9w1UqXQN1virbXgEyzcpPqF3OqnfADbVhL9OHEb+1MibP+nKWW4c
EWV1iV6FVsiCg7pmmAd6l2qmOqS9Qoo0unSg30fAoTq/X+rcNk0/symJKcub+Vke
ca9Wf3rSIIRiE+x2nHOP8YdIysQxejm7qpE+WWp6uTU87L3gkVv0J9Wf+dyIYZxj
BGsXEuTJjlNHgdNV8jvcZF/cB/IisfyYxENXAE10hB34P8xUPUodZNokDJe2A8Ny
xbFFV1mLM3QqqL29vJEP4RmhYCLjVMINduN278FQLWvDx1uMsMR9eZP2DoS+cZ0c
PP4laUPTCN2inXCG01AUUowtQnBRjvpUPqlDJdrWn202H4jsqle43Bq8B/gtGBs/
sYRLvrIk+2aAt0I6tmhGdJTvSj8l98pDnt9NZlk6NlU7XpiaVmG6fYKyF18Grh4h
6ijTqX4b2bGOMv6nmipoGBQe15VzhhHZdYBUJBuLb8RKlCzLT2hq1Vc1YbrrdKQ5
llbyacl+4Us5tsQziA95WYPy2vzyon3Kk/X9/Wb0xb3yA0+l2dQwQl+DTrz2TrEZ
zNo8utHi9nWedjOu7w+c9Lu9HNJhnwM9AYazugpfXGltAhYL2Lpcn64fr0KawBkH
VBwW5azSFzsUZRSUuWElU1/vXXzhNTdEhLO/oxPx3H2rxSha+0Z3YHUdv9bo6qrR
BmtSEg0Cwf4PgKNMoiadECuZySIh1IpW4SS5LkU4hwlYiZUjb0zXk272/MlVRsaF
V+25jUbJXB+EoXl5UK+zyQexzBEcEIkC+eh/p5BfKVX05T947XEYr/Kohyqd4MJH
SLjXcrezmdokNGJEtsGKTvFQunr9l4NRXhtJGV56HsCKkf6Lvt7+KUAxfIn7hlGq
hv4u30QCcNLpT9NjiFTDxkHWrVnmsYuCmRTECP/xrvrpMvqGg0+JJiKMiJVNWXaP
rfOYXxF8Zt9xlTKO5dx4TqE6fYPteVtxLqMnBA7eqfdIHx47/1+mPayWwhz/g7Ta
ic75ezvHQKd2J1uXMLYKeoTtGE1caFaDy492nzf2HXYqGU9nEucg9lOPtL2D0HI9
W9/hyOuqHlpJ+Y/lt3MvqIVk3OhVNQHZlnkW5RUeghCx/DS2kSNa8OlzkjpA5UnJ
Gt0CWZ9UXF+X46/iIfPRsSfn/veDSrICNmzTf71OaNzngCpMHBjFnbinjGKODeNO
ZvNV526wz9kZi8JTl5wtd2fJJC6l/JtuW5c1oV3qsysxy/VUFLn+b5RMnq1jofyS
+mqMHo0U3Hb9C3Kd+eOCSZmhNn/yXVqBsilFk7Tzk625SoHnxxCRIV+kok3Z+drC
zs7+HoSXaVjtOjm1kqku6izmPJTZnp0Q70FxUAYe68iyH4B7qyjq6yudWZglG893
ADxJ1pCvu2B6cn77hRGrhUGOrxWmgSlEIueznPBBFzaX6wyxoo83foSQ/ZdbLMby
hXWLU+/LtihKR+qlYnjPLnRJ7Jr79ig35dx7YcYq2xVYRJkc7VBfTGA/kSfoe+cb
7F73AaJ/sf9dtPL/wI/LfsYtPbKFzV3THGM0STKSZgCguPRk35J5N8uBihZc8vKD
q+NudVsNEOnO29l9fxEdrQvqVQic1ZSrxgdm8HLqpQ/OKd2Euk/MokKMoWbuOmu+
QEYFeXHSYG1NKjIBufhQ9GXcFqgJBFX6H8BiopgJ95ZT7GSJq8XfhTo4/1f17bFs
88L8EyZYdXWjV9tBnwM1VGjdbhKJG5rkNgf1dOLYhrDDOZ+x9sY4nxBb9r0oveK3
Ifrx7E/aOsal9WSWibTayu55ziqCETeYXQmnzO6NEkT0/RYyY4xp0J8wvRq1DTGs
0PRVZO0ZBE8Lsw4xXKRPagc93EMSpOxPivPTrTHnYqBQGcXRf8yP3YeyosVK8NvD
tjSWDn7VNYJUWytkJMOlHFmqE2qWmtMbyC3pjxImIghBsLGyLpQ9kjqcowJYEtYJ
Vkssq+7WKHiHqB/cpZCpMDmZYqMw7U8Ojry4Iu1dIcrbKMb6PZNRYZuTUpWWpAcH
aTgjZ3iy2wI1+FTjNyeqfRYBtrM/8aTxhKRdodmYLlw9FydxxkLGgBAZLcuKcbPD
FTJltIat+rs3MFkFx0X2RloBMBYDLa/B+tsqcAxe6JUPiWTFskWcBtWOqVC9wlfP
HwsCY3YnxKEMFIY3XRQnseNtq1OkeSdYcKxDndCgqgcvixY6J5N/P+KY2nqNT/FY
VOqUNYEW+8RVNKhS03YR9wNdBSrgQ5FYxP+nJ/kUuc2y4rrgdJqtLy02uryjabD3
uu7lZiQNIq+Opa60uHpk/DJ0IadXSJ6WIV03EH8+ARkK4O8wDAxikjacGp+ay4aq
ROgjRtvJsMwLkM/q60PSuBgcGzT0pvJPayGfZi7zRemEK2N+FumkSuZVY3ozvngq
jZd7jzIkcxNlj55nSA7DXXscCZ8LKzGApcT3o/AZW/cY0nQgBmqlSgqV/PdUe8GL
XD58s60OQo0Nds0ksM4poGJo/ZkLWmNS7vuaZKX8wA6X12fZN7HfRaX7To40N7/n
80hTN18HyKgmMqJuDbfEeMXI9Roux/IB/+i7BGyt2UDiO6gb0e9Jipnx5PjalJql
5tLSj5aqDanxtWl57A/ZE6FzPsQA22bsIUZkCh8mBJBEZVz35OH8CJMA025HuOvV
qiAnweeUl9KWCWCyFsDJSMBMadygSmgNBZQmiEP92Hu0/+LqQKPPJvWmL1ABTCur
HAQn016AT5qhCC+EgUh+/FkLNZqIREA8z403F1qvWvHmDnms7j4MyIc5VAlIvbmu
eafg/exDQL0mypZZY5kbPLn52j6fqf8i0iOV1Dj39yTLG4uax/Unb7WFeQ04WAZj
2ZnEkLPqsXpJL/2rm9VQ7z2R+lCBH6oSLBoM44H50YAM5+R/9zIAjbxMBLM4ms0f
UIcIMVmCw1prElB8pIejvogWuhZL+XTNRI3RAMoW2tgaFG4ibeLpnjeZXxzjmZ9J
Wc4DxO3ZBg0SNKEeR1IltWNRu5oLjXJOCdXEeHh0+AaxFfbquuw6RANUBejZnur5
1iMCSLwi+FQ4ZwFv34p8jQaMb2SYfKuosD4tZYTGZ3b+ssPDMAPOiyyT0k8Pdjdc
JvLyipuchGDhbgTJYBahb6nEbiL8UDju5Qq47lQwpM3iCLbdqRTvDW1Prgp7d6mB
NZ/D5LFIlwFQMUu1Y6R9DUnBYEOaJfVJcBaHX+53ZTp/ELb+Q0Oz3V8N/ho2S40k
OEsb06CA7oPwX03cJJlZFCyiaKK6lIig78ojsv6YnrxE2tKSakflJi08iX5SXv7m
oZfjc/s2GMfC5iqoFkGhRGms1jI5lL8PHRq7XsLzXidku0xL0zvZOa8zT6HbH8kH
y98CYaax29R9XbPEmrjwP/LLzPdE+BFfVtn5jL+kyRtKi2cJtsJMOoBPlWXpjd8U
ywPu8AeucHSVUW1iJakIfkbW8ipv8qLCXdobcgkiB8ic07pFMak1WnEdnqdonZMZ
TCleU/CXVJ9WhaP6HkB+QyUW7kPqliKTMsUMgNpkkEN7kBNcH3UlN5XoFJ4EvMdl
oHcsjCuZjqIZtaGoJRKSPNiKkf9nOIfWvbwcTiZBxZWl9s9wwkBGR5eZMa0rW0iS
UuPojnXyRQbUX+XZjMccxVtsdkjaZv1cv/Km4CdHt00GgBrFchkMwQHNs/yX7SPw
U5UmmSlojghJG0nIJq71DHxjFjq3iynTL4NBc6Laha14OAJkqkpwKWr4b0InhgTM
DJSZ9+dHOwL9eTMIbwBa4SK2bHiWPqGmOtl6uEYHE7sFUts1Lep6nIzxid6TjuX3
uOiltRNfjqczD+w5REXmlHZYIo75HHaa6xQS+56ng9yJ1ww3QoqHI9ORq3fS4BSc
WVqR8SBzKOpb8CsPeVUyyNKEqTqaMkvPnM4mmLvFY2ZXgvvgE+XR5L4RTKAI7VyX
AKO3S9RI2+YCAPMGd3vdprM5ccka2U1qjMxUgeoNcQ9i/PeBVYMRh4BMqU5EshXG
Wum7oWQBblT56pJiED62bE1ntK2wWshd5DDlcfORCgT8P8Kuu8JPvtzcvDdmusmU
2Y8LvnNxvAd/Ia8tCXIoUFR99KpRT5d4eHkC6Aza07GeswlsBIa5ASWSYRcQo5Ej
6oA7FniKabk3WfQZnDWg7IiHV9sx5z/qlS2akVPO5FYHCaQsob2d8qiqG8RIfcav
ml0yApWZvDpLRMzkI/38HUwJktsOrY7heAbW765EGkZrbeBPELdaTUweiuUOUGlb
u+GiGGLXZ/17hbP2xsmPCdQjTJYCGBmTWt8Ziz8QZrqp81/1yvph44+79sWAKOu3
YKQp59GR3IfeTQzVwXQqflCO5afbnxUP/LPf6DB/ipa1mlzvXfCkn8ZaVczIqTbZ
JhvaO+L+4DfuTzPaSdwuQg63NRA186ArkJNdCVMH3a2fV+ClBB1owlrWtTNZxFv+
kzc14RaYZunpD2ItVQ1MXizyZGb9vw07hVHT5/ZmMI5JxSN8YtwrWMBqdpp3Q39h
NogZcHGueLE+PY+MtTl18QNxuSedUVmBPqGAwXUgKc4rgl2z2Qkpy3JzeCmHHt0r
R/tIyhHRfrojdtpegH0fEY7IFgRM8YRLvFSFXeBY7/0hBd9Ur3FnHaFbyK0mt3F8
Et8ZIthfN15g5qiCiv4u7RWMgh0Ild71HbVfKu6cofsm2Cp4APTQ3EIw+4JBT5Nx
XSjQvHDp1gNmhK9C87nzO/TygbvKEcClv/WVKfBQm3FCICWDH/X9M+8Y4pHR+fDG
yDY8yrEFGSxQSaMxoGz86oAxwz2cIBidvoDFdFewEEXASibE1YatP6kFDRmcfKGq
3jugnJaBsvHVdPQfcCOMTkT0Z/zT3gVtbuphkJBWGXVIHb1956OmVaWNKB6ZcKuz
sN3q4L4kGZ047fwjtgBO9cmgY0yJtDZRYgYE9e4NER4EdDRS4MGzkMtgvxIo10X+
tjsUGlOVZcdw75AoODT+kU80kGtDQVz0B3/mdszjANedzVZ/kydG9q98OAhNK6OF
fohJo7wSeI4tkz8ki8RpIKLCUfaK8OlzqL5eHCmyLKMq3f6RmPDuWCRO+mCuqqn3
khsLEuclyUMu8EE1ZPESE1PSNurwP1M6+AeKF8tzgLv3HAUBgJQ5tfnD3cBloSLQ
41Sf7UN0xTTKVQp+CDNJLcQTJrQjHhi4mGCgDOo8TFYT4SSseaJEdVzLzVueC7ez
FDmP4s5TwrJjnqXr/ountZUyu2lekAchLAxoMo2tiOralPfh1zfG4Xim6jv/C14Z
jUG6z9G++1DKBgRmm2iyiU7Kxy7hQy8dLNDAqXSwH0OD8+3gTTBifhWY0ccA/X94
NKojOTzTzggWQITdd1HfNDxg/Mk1UBGQeIyH0RLTtYf3wGPN3rXEi+mCRM43k/t/
/54yfkV16O+VszmKD0FxPd9h5Atwd9ZhnFxEKdSQyhFk7N8mNQepbhbfH91MvqXL
ovRI556a1XfbXemVhEb4hdKGLBp/SpSkTqEK/5yyTtjXGarfZ7Sf7U6XUEUDXb+Y
l1iaVhRuYEYtiEi6cc076qk4LI3QHI8yNseCFEKkuBBCEO/wh03/9ViUFOcBvR9/
thtZLY1kPI21skZnFx60GOiMHa7gK/o84/+cWrhKq3oJEKEAZvM7S19bL6mZn4jc
wIjFj+7eeXw2vfLYVSrGycyFWjGEg0CMbcldW7MzTQ5+aSXKm+n3PZNeZIPM6cM5
5RM7PgSXpY4wH9cU5H93jHucGn7Nr4ptvZzJ6JmvxmC7UkmZutsLWwEjQqtXor3f
/TtBDVQ4yFCObtOiXxYbD+n4wVpHzeyPJzgxvJNL1dqGiZiG1lT3K9Iy5TGaLXdA
5erxHxKOon0NxGO7hK5HmYZnLtALu/wJW/JFG4X0V2DAj6bqjzj4li6EJ3HxDqqw
Y/c0QkVJaGgnDew7vdG00EG7tJfaysjYZJB/6qcbqM6EdW7UYX9VdeWkE+Gkqnfr
2QHsAFkzjQSRzyQWafO5gyNK21ex396NenhUuHh08iwHr+f9d9JiE/vwZjVTXBcu
Blju3UnWtYVT4U8lAcXnjU0pxWRR/dRgGrFVeS1YTyVaxZw71/cf/oHUIcv63trS
EzgOFe/lzYgMPo33QjbMPsK2o0E/bOQs8NFK6w5sRAbtrCdlxzDQR3hdEYQVp0mO
L3lv6NLOzlAtZmsm/PQX3WueO926jzeG+Z/CC7DyMk7H6j7fTBdXiORtFJHhjwG1
Jgrxdpn7iPUyMSFHRMzKqLGghxfCOU4Thv5VO30kuyyGzXiX7MfSZJ6iv6KwNYhx
gztNFMcJJw7JXHGfOEuwdK5ygriWbkypNEcSK5gF+rw3saHUQMTRw51Wzz5u2aOB
dg0kVUGuRPn+ckZ0kZ3UhKz6NpIx+MTAMtgXkTckRksITa+McnBlB8WJ04U412Xa
41t/PUjRdyovQcZST6peSPckG+KngYDsmUM0/rqHmELMo5VveveMwjJ7kmJlchF9
REb70HHjM2nAExbZTmUlmM7v7wuP81FwAzaT1Ry5ZVZw+98AATgt6uuaj9o+Px4S
UEeYZDjRkPsOeaSBg4EFzb48my/7osdQxqWrEvOnooAsVop33Rck2JqhXcDuWM1y
lCUZgK7BKmq8cRP5oB32TQgSovaR2ngk1Ohzj2/aKPrfRQ3b1dU0n0KbIF3HlckI
hD4zNmssqSGriWvQ7Pkzz15zIRrHzM6ta/PxfPERWLxYvZHPEsFFVbst8ZORX19g
J5H1MZAL0URYimPbQhrCt3HLXS9+v/xJ6s/y0BKiYaKGLRLxmJjpq0pxdjmISJXV
KHFGQrWZFjM9K12MTYCmkr7FjBBS10e2dRQZbBDQrw25hBidRUXvAmp/qru4Njoo
2dfCkhnVJItE5nJN9p9Cm6YgM87/uQgoDVWIWqAROmCF0NYArD0Ij1AKLTGbZjE6
+6hVXkPQKK41h4ikW3pW+vw4vrEcggCL/8nwmak0o2Tc4GVcc/OghjEgMS3QOyYf
vJpdFf4Et7DePTmDosP3p+ljdXR8Szt09i/fP0037+l76hYC0RvwtopOtcT+KR1b
/uMz5G4p2ipT8Jh2kqFp7ct493L70t8f7hWFvYgV0pjyfmUS2qZm/M3CC7DfesjZ
9Pix4zblP8cumJkWCQki+hG5IEGOvpPaNJJzdNWAE3vyqo72h4t4GuUY7HDdTMzC
niuAZiE5J04BxC4bL1VBMxb1tfN9DQyFcOqIId4BGrbcUVYF+LwiwuUx1+VBrpHh
IVgncJXfN+D7JAJ7Ne6vcVkVIKR1C7WWwiCv31XLdju003mWiS8Pdyj99CW+5AKa
y7nxXKsvWVTl7fuVE23ALTSmYONxJ4p16ebWoda6oMBeLiCiOJTF8VVaieVL2V5n
/xuLgJ+tJoDP41whtH+FIwQsUXbtgQIEHIo+dADO56wkKZfYWxJiG9puEJ1eHKWq
OoqfuDMLtNz0cqvwwBdBMli1RQ/s0iT1tEfuCp+6U8xv3tFTQW1WlPK0DJh35+E2
L1hMiJg+44Nn+qLWhwb+uf289Az2D+sasHI4EQQxTPI4j8Xicf2YLT00jKTxJ5Pj
i3VR0U449y2RAc5X62c1GxJw2ibYIf4XRBV3vCSDWABAFH/ER1qQ2Ip25nXQWV+3
CkAm96Z+pXLUOPRjn7PyEHx3556t6FVjqCtKdmITtbZX2lVwsAt3EFw6yssD3quG
P8jzv7/B3YI04bM4tW9amjsoCexcZeM3rvI0Ds2XQWVsu3NLPJM23STPnV60R/5E
EuDj+vPPrU9DjRSZZ+BXj9KYlAd3YFRYJH9VO1TMHM3cU015CfMETUo6Ed255RIj
u4epb0VBXkxklZFvdQnJq2ACtv9dgtQcgYVOXdy5uTC1thPptp6rjVTIGyIl0qkz
PqAq4hA6n3UvIC0QSbRCsz6VSGmxf6hKli5ozi7PhV7AMhy1evfLR4UctrPWYG0P
L6suLz3vZPd9r/dQLs/OI5cRjFoyy96hsVLCnP2CN0k60Kk4ArWffpJtpiG2tedf
W5YdF9sgkzaXw+RxSvuu7eraHd50llAUB8subN0wrRCw/L6t4XEK5KXtY3SjDQm6
ITXJ/ANjBtSYf/i6Mz25Co8nsVO4GFfkylX7e88ARS0B2f9d5DPCOFw4RnM/zp7Y
+NjDhvAlaMcOGOhn0ZbVmFtbp8atI7/CrXJK4pjWM46PHn/yA11WhtsHmtiL/Yk1
Ml7B+sFAzr5RuVOJrixb5WU87FAQDQO/qlR+DGE9Ha3PC6YU5W6yGW5oE0/SP0wS
IVtGjK8VH1ZzbXeS8ofy62nMMC2+E1JScL9MJRKULLBYjd3IZ5jeuMuDAPd+3acp
Gon4A0rJO2fijakZGK6oghDyZTnF6/GDEuCq425oOyYSqlBNpR96R4X1BU1ki/7m
ZG/Yq0b53VYvbm6ejD+RJitL0v/AzYcJm9JC1ljAX6Tp0cD5mdYS7hHGnNAMOlXg
DhS/ZN96aLCfFnPRzluf5QD0RODVKndC0RsTOFVzBIdV4efjEfb1OB0nzJUu0GTX
/mxrwVJh2tLy9MtpRht9gnNsMbtKSIzip+yYffl5HvAxDodfMaYgr3GSsLrznOwX
1cVVRmXhVo5PjnCyylJuAnsi0P2hoXlEhZmZG1fF4gh+FApOOxSJuKPww5eBXFWA
+gVb7ONwxEF00kiDKkAJ+TtB78g+whUxK8tswSvb38D0sFfHlRpzOgcCGGR9bbx7
tiLK2tfg8HTrPn5LmeQ2YNwqJtQ4SGUH5yZPxIi6uhX3uEhfbozhFA49QMRR0FHB
oQP6UZ1uxjHVEcRfzfoHCCetqHvsDbbyMp2rz033ctvYPHg2qvUa4UnC2kGkPU9I
s9c4+ti7/8QL8LnCRJuOszvBGGtMsgl1p/0KxMAgxM1yeaEd0jsuNskHEuG+VtzP
qI+Up7ZPiLzfLrtesGhHIrpiiE+WlxDL+qkTqdZyVpNjObr3G9DEPue3kEw+9Yb2
mKFVN6OFuITNtIJFARz7LGxVxtAQfgE0VHIEYluiflDNDXf83IszFsJg+xyL7oN3
7r6pdlm9BtD4g4liuXfd3swd+2nNyCYObKoqFxNFC3ETi4X+Iu6o/iOnE71TrZNF
fHmQYh2+dOjBudXwOj91S4WBfyNOyjjEGSrEhh+b56VIQjzaSSQRxnkS98igyxGv
lxBJOubvKU3jc4m9W93LwOzG6I2gVJTLeDU1mbqjW/RCOKRWwSxkLYXIe8zco3u3
NDB0OCDCm8qvGWfjwl4xqrFHJ2uP5UPwhC6NLL59UKArDSvMmzXjv887tks7DrPD
R9mNPz6vR3I1BlA35Snv3/8qd5dFMBL3LNACNMeooVMRkoidHoU53iaM3r+Qegkl
E7fKLSVj4up00d4krZswXFf+9peY4Dv+5bf7ln0S4xVqmPjLY5lKylI+X5LVlK/q
YW5LjiR4A+/tPlUmf4m6SEhtHPYRwWCTYXWj55EDsZ9o59F/kUag0ojQKA1Y4S3S
KOz8L9El82UvnoPag0IkUERYyuJPE2ugF8dUkCvU6h4dRvaZChFXwMKNPSaWakbX
OTj8k6Wz6AuL4wLoQQ99dFAYjoq0keXt/vGQEoZKRvLInO3F9zPbyazlt4xXIlGQ
ITanQZTSaOfPqlomMUv8XrMmkSsaxyNiJBwXkho1h4FD5YVu4zdTdr1G7yc8DMKi
leDIF5ET5TyNQAQHhMPoxPXswNjqRO4PWptgxghzUWg9ORnC5CtLDezEBawzI+Sm
J59/k6wtVS4+THUL48plhClLqoUiVZwG6lvnbNNIg5PU19QlSq5G98UnsgV5sjJM
HwMh0vP75ige5KaKc0vbE/SYAHXp6oS+lfvbdPSDh5JUAmOXAnnShm3z1YqykS1c
QMyZogG1S/UpNT645KRWL0t7mW5R1vP8ddQiMiXjCdqRVxlt/o/ys7qVr5pfogX2
FDru3hg6Me4fBM4L4v99B+FS6PFjmnMEwx3QNXac6+vloCF6emn96ck2yJ+hFJ0H
ySBe5Zpiq+f9n0nb5mnXk8F4bL3oovwFflTgsiK3LtnLBi6uTx/Rh7x/CSaZ4Ux5
ANbpxMRm/S2vXWjARUQqoRypi3AzhuhdGxz/0CNP5DpoxsWF0tSp7fo4YMpgkXAh
8GdEyCfRRhyWRPk8LSQja9gr0zFLeGJOxZ7NgV9v3en7J5hp4yrdZZEq1U6RBD3D
cyhQYTZzTEcqxYiEfZCK1Vu+6M7G5qVoxdbbKKpJLjeglH98XTw9jFQ4dKr/Zoxd
N7XzYUe8s4WfVVZKeve963LeZTbYsmyEeNs60m/Mk7prhcy5hZneDAC2YYTuw3XQ
riVVGBLgcHPbuqg3ef/VhPEgDmtIsTjPPSJ42SwjUy0+ptfVXKpualX8vvHyDfkp
NqJv/0P3mIEpE/zfyA3HLY64KAyKlZhhMc0tBP575aKS5dA5Z88JXRrlPsnpnIWL
4cXOc1oKiM8r9bwcPo4sqeERiCm6JR2sU6CZpYDvx1yU0YvByxyKLQvRqwCPkSiI
JlkVcaTK0TwqfJeZ8bGwYZqYVMml+WRICsQAatlEHUOn+5tncOCdQpj+hX67PLzA
uK5ElSGlcsY9no/WzR2UsQ8tkcyuLVc4IPR7g5qmg4R9IHqGpaSkxke3zTndiwMq
muMfMKwazvn6d8u1WFBu9VUVXMdtnPpfa+6dyIBdLguEUEe7KgqBJp3hYx3drc3R
DixRWdG9YtlZN/RlIppJnzcl38HcAvbt5+zTctcNe6s7vaXSzD3VNoEdbBQkOYmR
cTe05xwCU9bA5tY6z6YpH8MBP1sBGI3zKk75l6tHhw03i1FBlPRXtDOkFDJkknhu
8gxlC3j+C4SPtLPz0NYnCKPFtYfPsw/eaUFD6Ymgcl79LRg8oCIjAUhStuFYQmH/
1FL2E3X9DyBbVAeGZSkaUzI/5nJvSyMwTB7uSh/mqoklWJQiat4je/HB8odP+qua
eKCD6WLJoXLZIrR/KVDafKy8mrXbIXksIr9XOsU7B8NcKWyvI8t62MBsIc3O8vTi
GaEvnJls5etyc1Uo20CWDGQVF7AJVTqsBmPvukFuucUo/9ViILCNDkgTKxi7DD5U
ptH8wfo3BJlm5rrOIYDWwoOFLczBmbhncPWxZEWK9kEmre66bszSgA1ME+pG+niN
xRLRP4qc0MvrkEcXMGd6oDSMVhTJzEzeduOvJV2m43KMz2TDZ+Gz1LGXy2X7l9Rv
ltjda6Yeq8st/uHFbusEXUqYhuZPwLYcAEBX9rNBKX5Lxe5DShSNRjH3paXUZhN8
KKGQjLob/etEZivTKsSpm0EX+aneqwTA8v4kkEozoUF77lcIUteKlj4/rfZyVU/B
1Av5fgG/sUvhsP0ELIAhJBGMhW121+wNpru3VBiFZM4jKZzefAXSYcFkIZvKHA0d
g1xIebOjslb4jyqpmYDXHl/VGpVP8ScziLWGH5a1b3mVSlHsAswqbnDF50MNsjIa
2jm6DcKt2zNHIVta2sLNzMEIZS1kBscHItDt8cUx/hYdGoPb3byG935AShCJa2Iq
ebi6q1PgW0K7CELaw+VvwDe8zOI0qrk+UYSFakjGcbhn8tG31V6EIeZoRRrtLEXp
xA3FXGWQw6A6l1DkxZzlqfqDGJwdDQcrUk+CapPbeWcpAlQcBQqPFMUlf7tFGzsq
JeeP3aTEwt2nKQYAILd/UhwZ/9g8+AmOVKXL3AW751PwkiBueOYm1hzInUCbpunx
YBkpj6w6y3eeZbeq5uyJ6UUtlgT29OJen5KnKBlwqqYVX36qqadTAHTb1FAbH46A
hMKpkwJGWl1EaEV1WKj4xQox1KE9xAZ/IQbRqLExnFzSAN66h+lXOBRP7oswz/ax
gyiLASE3cWSEWz4Rd3dfL/sm+vCyisMwj73ExsK4jnhV9TbPneqAAF9ty2noslj0
3vt9aHYSso+X6UAZSxo1v+wA8RHWTcAq8ugk/bhUAe6V3YkYHwhuBShTc4uDGxLY
jdV/zC0umedKwNPEu0DX8QqFWes52mzxFwdORdFCVMkvLJHZTAA+9Z9q1riHvXKs
0Gy5m3J+SHda7HbZ1zK2OcULDE3gYvL8y7NrkG4pt/rMitkd72kYVCjPrKai4e2t
myzhKFOzZVI0KqMW+P40NUe0v3dUt+oJuAyRaTkK0SJ53sN/Tnx/kdgIGyNqGFtm
HEgBONKgjwWeJE4qd57AQzNSMdCYJDynxZkILpEFaUDh9JovzXOeQkW1fyAsbq3o
Of8CwoTGU8P/EA46n5SDhFyRII2+UIp6R82znz+nz5RU7ee84vpm621QJNzAFVlb
mWvxoB76canohnXJ6PG5iGyRgXUcoRdLPjgeEAvfWX57pl4erbXoww/KK6c9sPls
6TeGWv4e6M2VE+9kpGyN2t/njXMVGR5M6ISxZROckIo1x5rZXC/SZzyRum6lgfWY
s4hRfUY/r7B36bXIJEdad0D6bXt+7s4VTAQPATNH1Z1/X/wjAZb/ROb8mlxRmHSR
1/bOZSMPf55XSpaIlXJxzugyRhpvwmlGbnpPdoF8ejYr3bIEnS+prs6qyzvktSJk
F/C/i+cs2iHgKzrco24bBw0v76VoaqaG7gdpMnYDjHB+NIBFSE/nf1SHcWcSbBzs
BZ/SQ9espi5sfh0Zzfl1/gpfS+s3IFEVEiZ7KaEyX6tKmufw9zbMZ+6zBMDnuPyN
iPRJ4h0QiIZBuz+QvCytGsXB+nthc5ZvxNeOmeOYyNtK+i2sXiDv8M4BWROmWTSW
VlYePhEUMPIpZWkVquhUgbQOWOwcAo+dQrskDsoqThvDhtvVGS7OX/pbuABaNhZP
qBuVlVSRm5QN4qB+8wm5bDmk9v0CwPDr5aK4XfDm7rwDylRmg9ocN7UMaos0xUYn
qM9RP58rnOtcJFExhpPpIaTlnppWw75HQwKAsRptUwAYFI9Ni9t4TawlWG7HvBxS
F495WrQb27ev+gJTkfxhTKgAe8Lx8UyOFbHPa+8YTMRHxity+eLRPE1dUE62EooW
+VBQ4I19ew3oeooHargBaAC3toAsNLvv8qd0KioJvT0bjh5FDQELQGknaU+OOR02
glp5wrk8TxJwpzsBwdb4cPECpMGZNIZr0aVNLWz5uQg6ygnB+iy2FjcYn9ylRmmg
m+5YJJlOmmLchrGJR7KK79qY0U8y1eu7PBwMN6n6H0DYeguIN5I2TTm/+a10WoM+
1jQP0/ZKcDC+rDUphv87uHZWTHAfmpvj1pDuuf7pXmzBujDF5m9cf8azfZ2FxrEa
22THx+so4fbNfh8AEc5BNgP/KH0CzuTllCPQF5E5/7RRxK/6Rqr+OWZPU4yEa8fB
Dc6Lv5R54S9ptg6VI5ORcM5ipMzWHuzz5ma3hanyzqNCsm549mT6U4/5WjdQeoc1
Qa2/koKQz6fyitHJoxp+FExHgbfhDJp8Qzsr5snJ+0GZajSLAmVamKylnCJoFNq6
g7ctOYdNl1F6zNuKa29DiszVx5NLcGcN2biflI4jKYwthiN07LcaD+mpm3GTofe0
EuPOIiSGIiAk3bbmJk70JW20aJC9MrMjTr4qV8Kh/2BCdwCyRPHvmRtH8ZP2fPG0
yG9EwCA58n4U+NYV/TVOQ2W4MX82qAZnqRGsRrAM951Zc2nY1XuvJxjM/ouze421
QVMVN6aHgH5aVh/73xdOFEhnxuWNk3qut0zSgplZOTl9l6FObKBuc9osfNuRB2rO
p7xMQCH2Ko5zFiMOty6NsXUBINJW73Pkngy65Wf5r7pPC8maXBCNgeeoZVZNfbsQ
IXYriGHmd7NsYnFFOXgEsmM5JH8rTf/YqmJp1hJWL4Ns3yWjiC6dwQeTpPC+Wt3l
1wbG5XuqXzVvVyuq26U5nipVv7bxq/Iv3u62s+WNcZjDn7Tg+tp6pKyYypyfIV/1
SORhsqVMrF1eDcXzGx6tgLWlEVs/F8f03bKz8OHPWOetEH3fCdZXxzdkmx1v7MEs
BC33PTs6cdRjdksVNBJz53lQq8a20G8mKIXYAYIM/ug1YlVInmYg4Jqp0L5nFqwb
G1+rU3ncjpB0VH5eefzhPvwuDc4muxtXuvYjIR0rbVFCGRMXBRo7GpNtLt0jWXmg
rO7Gta/uN4yJXDmDLe+/QxfKtXlS/wu623dXbfQMdnB2/bylHSZGwEdJKBJQckFr
AGhf3ETcxB18dIDt+JrjKX7g8rmBiTqwcVXNFrQ+GCkqnur+2b58RW6F29FeTPOx
MV6i7bwmCmP/wvslmIPc7VU647TM3PHNVU8klErVY2sgvMvROgxdfj8Q3my3Urwa
ELSVVR4NT7T19+4DdGPxRkNP6BgKOBNcXtWg/dd51dQmHm0bSXImCBVjbtzuUTy9
7o6G+3ISaVNr3GIJHNsx/iuSXYl/h14J9H6ueAYk0IrRJmyNdX/AqG5T7lhpOua6
gUz+0c9F5PXH59GeH6GPqOpzklnpZaHjaGERmsmTXQTAvDrprjxjS14Rew8zG9Qa
sL78LV3qCTkMmkygDfzcl12a/m9R5tPN4jQV5ZrFP54lyqDKKxwGc77F56g4RWfE
1oSPDEERNrQiyZKXX2wtGXqNiMOVk0V2eaKOeJr9k3SZYSPg+kPIgR2jpikCmZ65
tp30tGUjUQkbycQHX5gv4Bg3uscwjT4Ol4SOtB4robeCcpqXRA+qjcci8PXxOGhB
OBBFX15dXIFVH8lY+2rNkvrt7VtlQRb1hi87FHabF8iSbrJ+FPK6bzz6ir2TEoql
GhMFi2q+X4MCbHWxT04KDFRxjVYnUitJE8NIJ3Qbs430Ra2iAjBQHYzFqIik2r2+
CCebE6x73qkST+OPc2wKJMFs3K/uf+BfxQQbFyujEtFTc60onbF65/yQrESgstq0
NOfxt7ynfdF2OchhVq/8QoAXraqTitwJlZGhDCWMJcp3Rcvl2W1oOiui8qS1f4di
H/YzCTmWxOFulVvqDKt5SnXjeDhx3CJ1zWk3MGnmv2znjwGu2xsCxUVTJ5Av9cLq
slmCOInqDtky/cBFcWAbnGRItcjfxnqNTZLeARQ2CqlaoEeqU7jg4uYuyq6lsuYE
RBwcckeqE4fD/gMaRhVnYFBbQ61I1TBB97cywJBrJpAeGvGJflvPQx4GB5yQl7k8
TO6AxxBFROpor+4EcT2UiR0BzbhWiPMGQx5GfoeM9M8ZakwxZiwBGOBqBXw1Tek4
iYgHga3COwOVDa6nkltZD/J+evImpOTzuNmFLhlI1YtJxjOejvWlvr/AH8G6OOI9
M9pac2hURRwUvZgpfy+SiH8nb5TaQshlOWYItkRI16Zqp0Bi7gw7XG5pm0nwYi8i
WPS1BIELcFC4TJdPp1glvQDLCEfA8f1W1wpUb/zCgFs7PvdMNpWzp8hZvV8Ahs2d
d/HsjnPCr8mS8N/AUrQ2lEN5M0kggb/rd2QA0N8ZJN+MA3m84a5YIuYH4bW299dS
AKTImdYP5ktwkekFkjN14osdwE6ncG5PV8zsl/qlssjb7cHaKzCJ9s8TOAQRN8sK
weaG6sT5axXTG2PArCocfA14g4qVLCk5fxUw5DUytobu6FwpXwO5gG2spcIDRlQK
QpvUYvna+Ev3F34TYv8p+YcUJ7ffWdxs6JgnO40tFBFvKQPauN3TuMjI7X6gmAJx
BkwSqQy4nDTP8rugz3XajnnpkXnWRGY5UPFEYVAJLqTex8gzlRcogohSLrGbt9je
ib3bD4J5TlA/UvIPS6uIP2VQ4H/xP+JogtL7iNVHjCxddcKVdFXrgIwwLZC/M5vN
QT57jbLJvl124sUvgoepYfftGgEW4Q48dZO+aKOFGJvSmEIb5or5xuHh4LyW2KEK
IeZQWaL36EdSnn3KJsnWukbbdoA6NdNfZvziBkLTe4yoemsdq8k4jB+kl3ejJ9od
MsELlJoZfRp5tbb6MkHhq2G9/rkpKpoNhMu81tl1EudS1FJTT/nyPyaaOSJQFVK6
B3CzoPUfbKx1MR7mlAnIlwM0tYp24aPpO+AoLWNiyKUdJUs4h42Y6fhLYdakZsHS
0wRnar0mVY/tYnZE1dYDexff/4x2jPvVosZP+j4AMkSpzrXW+12uHDmNKk0QmtBK
8XhGbqtHHnutC61ckxAqacBhmUnyzYnz2/MOeUmtpNMWhHZ8yl8NNCBV/qqlRMCF
VkWlb1CRMQGyzj+pb02NafdEaXNWUpvDsjSglCMQgd4tPnF2gpbUJ0DgJgDvQ4+g
NqcnDNkSMAiBIdvQ6hXoQyndvIN7n4rsOA8LS/MDZYNiICWFgzGCFFLE7/9B+TUS
YUSRJZMPX2YqviMClR+OpXIkmkSoN/Yw+deRS/GE6van4nWi/GTM1aNWYL944jaA
XUtVFC9XuVfJ7cCapleNICly058AqMDR9/w7SkudTBOho0wxBvz5oRd6t5ARAdGQ
+F7MHW01ZfShCzvl+/xH/TOJi37BjsYqXxU+dAUbqBDH14gjQO+VZz5gw3WN6OEP
r2WtrxkEYf0QDQU0xNpezTqIKnP7hoO2Yt5dDQDqNkGsQAiHjXQES5jjRilRTZ0p
GnBaHQIXdh7JaxUh9hIIbUmpjIHis1EbzZVHSbB0xxyP5oRdw3bZOfmDBH1eiQrL
iKZ0bpLwSx2yGmO3q98WCQIV0Ycl6gOJJerlSoWSCHxlBSxtO71AXD/u/bXrWC/M
mpCCPyGYrG8o9eNrJrFXbob7CXooFkAC0tmrrGTIUGi8kxt2+HPdJvmyz+f5QUci
NY93zsZDW+21jxjcRzPD8FUQYzssxhZAQqfuFw9/Z5dzQedUqmxXm27OONO20Ds5
ODlOHUN0G7zIiKzFjk8+8tN5lZK37bHSiS5FoG9D/36XAluGxZfHrE3inNnfvXG5
m9E9GFLMa9/ABWwIEWDrv2iZ0rxlyDYzf5VXu2Sc4V3IaS2lCkdi38QlUAQZcJ0O
Jn9Iqx3sv5ZksvflW5ED6+oOSXIIyRaasbxtJWAQV6Jok6Gl6aX7TK1cxsnGb5CU
T07l8dAPFdpQcH1tNtqlPvTglKjyMqspzxDwfgL0j45bHI2Q0X1KxINCdWNdW0qI
jVbfUQxOa6N3XxEaXo1LEZeb7zl3eXeKXX0JDgFHks40xRCi8U9YfJ4KZR3aPUi0
fdDnmWy39vJnRLLPJEc/FOLJ+T1lnLRc1smCNBQEDJ4NeV6d1J5rx/2DHq3Szfz3
Dhmh4YwqwquzDcZxol30uGkvWOPoIeWg0lXMuGRAj9jY/r8xK5IPidq8bcfdHzhE
KfUrN22FYqXL7W+aH8kF2jXViA6FnxGGxd5+MNi2Du9vtLbkffbu0Ek2WDMZMrRq
TDXqWCraW3a7mkfqxnHLwmgY5AojCWi35hLLPHi4F0bDcMYhaqt/BUswj9cZgOlU
qYmlz9hpQm4jeTVDzHYVNMLzItqf19eRsXo2S+0A1lE+QFajcie0yduDJZ7GGiRB
U+gglqa+VVi0V/0oDmDKoLDolubmjZyjUk+3a3NQQ2T/SccAXuZDE+TS6OzUCYzb
PKEMDdhQyxpzzZ1pmM9uhwmomcXWJRWgHfbgIqInEqkZ1aIp3NVeVZF+51l4AA0G
VIgpjDuaNAW/YEorrdDfRqO1x+BGN+GqQA9DO5zRIofhXdqYA/AMS885BeFOL/q6
vJD1Fpb7e0363gGovmPe/tc+uFQJd0rfmrfWmcTpN/Gb8BuBUVkindxvuIXrJG/N
S3yBE3mBffmou1u0wysGZupqBsTc6LlBXB5mGBi8d9umM8EXXxA7Im3ryshl2vRW
/mqUx7t/RUqdolthhEdwnxKgRcMCJpugDHukg5jZU+tLfz7esYPHs2YtkiRkeX4u
dr6s2UqM6nmV1JkNzvdLmtWjp9MCIeu24IHyJ+JHO4jylqKcaL4Iv55JZ1YahMnS
Q+sHiMPLvC220xAIV14en7nahVkZCmKaVsdT69Ys6GIln6lpDTzAwUw7z5tT/5/W
MRB6+YjB2lV8JfaC8LyO1qp5JiqOzFlwTnrN5I58XM+Cr57qPBhcC2N4murtJKc8
TxAroTYgLfHfyvaakeLpCSkzS5hXDWP7j8/cGUl08CAPOqnEoP2JDWy6H8j4BZCm
UFUw5B8Rbd+z43KiMxYYWVkS/snoAn2CH0Dt/t+BJwS4T3X2hoKEoZ4H2RPTi6FG
KBprW9h/DCExd1adH8zKm/0bmCzOQ0niXJEcgxcO4rIqnFXs5zG199vm5R9b0qcC
ux0wUuQSRP3r21Fq0krDynPnsDyyyGHXjkfREg/9bUGPDMt34ZopO4DbrsMmIo80
C+PkQiZ/pr+aFDJi0vYt0P1JZ8ASWPZmgl13zUn3RdsPyApeaxmFw4F+v0VOzqua
66L/DOuNWuo9grYr5fnuw8gH7JZ8dJntskb994YIxKXVQFJZzjAXi9qHvdi+frid
CzAm3YVAJ37vCuBoW3x65F8+OHg8fXacdJ1Z9zc1R54xrLmCy7Y/qYTQUTzxrqDD
bJiJC8K5bfeCkcJwAhkCA3LqiJsXjvAEWMSrKdH8/4IALAyFmSzsj5AFtpM+0daU
ZBIPANvgiUBTzgC0+JaA3RgxmWHVGjzRI3T+wXUgUKVI3kmiRkWW7Br6kUZ+2xLj
1btxEhFZdyVhViH4uVH7dhjhFQLxeqfqZAkz8PX0d9VObO0duDw3lNBGgGkl/fCI
GJjf3VuCCYKz6Xk0nS/t688vTxfENdakQ2DmragBj3f7FZxYrId6uIDNnnucPwos
CMhaCbzcA3++MoYQY0HwLHOsYvXhqScZSVCoMEXRkYvCylVhgfxEZtc2HD5MLbyV
Uyd9Dukvaw1NCKiUR8uPJ7oyrm2y9F2A+X5q41N0zrwzQEoch+USNSotqLYk9lh/
YvtPteDVLJXO5RoIIISf2xzKSc4Y3qAhGrag+ILXhmUzvIHXIhKD6CRBrdEP07SU
3rY9IYcRXNhAc7Mh6OogOtG/Rqlbjf9wecfE/sdDOGpPX2BmcqWzZ3Ylm0p7NPBS
q9wY9auQAWldI4wX5QV5WHWpa6PUp2LtNUy8jBsF8f78HYy6GAOr/HReyxKxmEaM
d+PGBWUXzoaLS9KCvVDNY5KQWQutPqljateqkLdSZTsKgGnxCxhmrvzT6hvjPDgc
TC21GRL8k+jRwBopQE49RCBKKNFpz+VPZpSZ4HkxFDmrdIHGsB3hKQmOZMmKu6yu
XPZHLVtPloxXmgSRqtAZT/Ro9BC3ZPr/Xr0RHk4BnWz8q5V1TjSoW9O3zVIegWuZ
SmMDkBp3rvBM3/CXbumKXZp2shakraec00afMcqm+YPt5Tmn0z+eH65ytjsLe6a7
83fixBeRHk5WMyVoTdgmI3Ete3/L0KZN75qK2p0za51jFRyQ4QyEYzeTLrI//1GE
0dmgq8iEKi6qkWr1ICZ8zh5fO0w6r8wE8JKU5NHXm23Q069b5LzppH+qh+MJTk6q
/yBmTrLlggh04q/P009IfAHFy4mAwULknERDQrHr8tBNuhlO0HhBDO2AxECAVJzQ
r81ScsYLHs4leUFTytoCIOoIFHBAqLeGj2WMESNgSsOWI9YLFLK+nHQE0MTqrP/0
0fNX7RIx8DIWZZjhKab0XMc/QTneeKsNywsibPJ1cN1eSbwftALCMEWGfh0kcGWj
ZYRUnWxC1aNEtcjZ3MOAZpLkbqMzboVH+ZMn5gCtjOY9BZS6cal+2M4zTVkx4eor
8t5CPQUeZEWXyRT8eV+jSCkAoZG6iMsw7c3KqGHyWs45gtQHhbUKHdFQPXfVUJv/
27hOS+motEpx4y258CmWhaOsxKffVBrWF9ztpcOHu9dGlMN5ghTUABJYjUUDPHN0
613hKAD0vRlFIB8zY85tpwqq/I8fnkjhskJIBCktGrYCssxWY6408SXQAMueCFWT
tCqMM84r+0u3lMoWqUOesZ/tFSxDYW3mfHrLQoT45E6V96iuj35VRQwHxgSltYrW
ATUWdNP7Hku7wWdX5JeF8FC7bOfjCPQlaWnWpXnkz7e2XyiPhHU7UUm0nE4uZmL5
n7vtHKi9Ws9FnP8TPlDxPIqVg2fPywKlXzQmhr0yU3KhKS6fhP+hUIdvPenhkgS1
MIQI8M4TVE4ZYKA8GWcL6tdytNgGDHXfYnIYzeLI9CWO8FNcZ00MICcM8z2KbQKz
WvZPTGLnPetFjj4MhnotuF4nwauBbFI23K2aJCbhDdh24avbpmEsUgRkPahvNay9
M8kBbgIhRnMIp89ccYFxUvguFNfPNIhe6Lz6S8rICHcfL29ak75aq4NS8eZOnP3W
91FaxskZ6a7hqwdFr5eRORWjHZIoZyAkee/F5369rlx8ACodtJOOfXkKFn741rBp
Ks5f0GC0XENvwm+gAxw+Hx8Gaa5+ad5rRj98j/RsnMiI0d32LF6cdZTw7BJvVI0R
kqUXRfJycuUVSdRPHsx6aWExnqO5qESER82QU9QEHWlrsZnqIXZdqHgeK3N2Yvk7
7rwNbdHQ8/3VSgjku6TFHiOyP9bdIf+g3+qRTyncRzRQIC77bF4qINYFIGDX8hMh
z8AlcGrOi3PalJ8RCMQUSbtYb2IlP2jV0De1uv1HJEktQYnBaW7zX5aDsE1h/HdJ
KDiNgvyFKEX+O4jSYSpFBKnvCcd+9Zrrl2jqZuP04rKgLBMmWtXIDWlWBbmRxNib
WZABqdEOtwwISL0XYVSZbYgMxum2NhgHau22AUrpTTLYvzacfHQaL9T0SnGvpyiR
VHDmLtLgDi4pRpt5sk5d8Yi7gS5lv4RetDmWlAcBnFY/KjKZErpAh57f16ZGbT4W
dzmBwe/2kTYl7EPXqd3ooBR6i7DehMYfyQ+V7GWrOCfkE8CwRgQySTQYQSN53KYd
3FBo+sSbcxgWrYiShN8DFi+YmNPdUUPnyea6JmcX9/g/WZYR3AXwvZBdqZqSFYSi
1n0VmgRWMNytv7+gfAjzzHaeL4BK/jvHenSiTo6sIAK4WryhZ/k/JbHpkMBTCGnI
Yw2An8CeyAANQNmo7LlfTJOl1ZYk5HIpZjlL1wYLQUI6zwK4LcZlgvUCydMymjib
r+EkUHZyjO48JRdA8dEWI8bZ0iDyKuBuqEl/WcN2wbhQqg9wnOjyYOoQIs9MSFcV
MfFomo3xPeAkguDVhEWLw9ROLg17ytyKutxItoe3yIhM+H7BlZzOplO5izOzU+iF
qRoZT4lSFqTEAAp88nqLfUvKkAxo/99KLvskyMLO7iDnLIIosHctVPQPHS3oXqXr
ovNXRcweHUkGMSJDAwmdDlgobpp79gn5sHgLDaIaeGB5qiSBkSP2Hw5Gw0+STKmW
0GC9uS7X3EWTRmqGG+hsAcd9zNxp0cn8W8dMgrWm1FfVn2780JXN8T8wT/vEl6Xi
tlYG7ilqiev98sYFSD/lInCWvXP76XIJxKBikelhX+OR3miwfVWRW1YPrULIBeVF
2Ax8Q9W6oji1lBMtqZUeuCe0xpWvaxow829jHyXmQaWrXe4A7IaERnrfJtOPY/FH
L3Uz90CnZIfGbAJ73nN2vNSSvlsOgRBIjf1cYSbsKHxDvK0ZcTEfBAx7yZt1L71H
3P4mQ1l96gkbwPsWp+PJP+2++BmYJCsqBMN0/45+/CKlNCdMUjSVU2bq6yJujr0b
S358V1DdfYUnI413VZOvEqdYvxN7lSDbveKeHT7EewrUnUcFcQpRLpzfFwx1DvU0
qEoi2E6qDfatWEtRdvttwi2Dtxb0CBAfmnN42ZMEKXADAppYcaSZx0ejMspHzc/Q
GTSLAeLi3Nh0sdhZ/DmQCfqINA1/BxgfEDNvybxqKzElsWvAm5n2wLNpivjMIJpl
lpZcLbDiLF4U2rEC1QZNvLSxJSa3mOzh4bIzu4u2uu9pjxFDkk9dDEQmxEJKTawj
BIFaQWP6SK6tjBy4lFQlQQv7ADKo456DIgq3cRCChgp5s2r75ivz9yrt22Z1KWDj
StTC8ABU1fc0eWulwxbCwtujNFgxN935UkNIjypbVZjNg0PHGhThPVXz1f4kbuHq
7NxaYyRGL4vKHrJYg0VCpMnXkhEkelOu2IAvye55Z4UBeAW5yxFbKpb+FBdlcyk1
ZatBAyZvpScvfpQQzvajXnbFdVuOgFxMR1U4s87Wwdj8zc1MqJgujsEilM0mA+02
PtoASTQyhcmVaR4HSuZth0SSNfI4dxeKGFIEiKCGoJJmVg0VK1nuc71n2SyRIcLn
doq6spH3L6LVbWTrCwwitz3LzNymOSQjyUkZ7gS4qO0k/AWM9atDnSfNhAfzuYxc
uP4wOrCXfordRAXYITDCXAuiVYG9J00KiAh7JmhgYDO6o46vYn29icFhd0kmSLh3
H3ysKZF6/WfA54T5uzBeoAMgApCXK4taqqxV2HgNuatEaWh4J469UU0Cuc54ytsN
0/hR6+vk2JgSEWN9iekTivjowmknibioCxLghUD7ob4mnaYk3F0G+kmx9H8taJIH
uq4FXb2sc7J31SedwzLAarPO6ax1lHmvb73gDX7mi5sKvGqcC0IOAOdRFPSoslxs
CEId0VOdyr2ymudEEbgiGgneaqMNQc6gWu0bDRmoEGpbG5AszAPT270lu3hMriXq
hrTqclJ3+hDAhIMxg8yxS9WLbZW+U6pPU6IzN+dLFFLQjSIMW16gyD7+9Dp78P4k
dij5ctewqm87ib3AYIsOG6SO/9O3pOvKFBuk5hxGclEhoDVCTawFBnf7Lace44KF
8GpArU+RS5jdn7wMUkaMaY+iffzqJo/TBpwRJGxgD8RhGL6NP51S7N/oTrsikWvu
EKZHqvrRmqwXKATz3s6MescDQQJUvktov9xlsClZ2yD9SS16XQop5nrQSSr3bNjp
8wkFOJox8wt1X7i+ihu4SV0L1vyTGV0j/B1Ja3NQnY7pESb6mIb94yF4fORz2AA7
rK5qzzdLSxyQfp+N9ZEX72F5dSFQuK0xv+G6ZmvbkwIkpjO4gEtQp816yCeWjYqz
+AwDnPpA9/PimflLZXIIW/3k4B49A3pS7g0ai4yCCFaOieBa7ku4JPObAX1A8vMG
hn7RzwdCxxZ7Y5CcdLq2SL5N/RacxRPZghKVgJe/yfDFTa5ea1tSbNfUoCHGIR+H
lpTq4ah9gwET+otNd2a+01EV3e+hay0T8c+NeoRj+cLfG4rFX+9u1eaScJ10V//v
l7x7FQAFAW5zbAuGCKeZ43Wal9wqTPhfMAMueEfC7e11Ld+sR+lri7+BMpl5/myE
0wZV9wuw+/7nuBxn69gMKFI3QfZeaS3cSSz0rOlA36Hx3sDsqxnI4lo2BGXIZcIU
hTbfeDBO/vM0TMN6sSdL/LKew1mLlWX1AjjCZxyslEXix+SmhBiKQ8/CC8qxX4is
0b8uywo36kXJ/27TEXwKKRc2NhVeuXadJiJgNknhg6LC10pRrHH17HpzyOKYVOpS
yA8QqSTv18xfYcs5ORVUlhZd/dDLTLSNG1pXH+q7BIaFhoJBHel4wA4Arn05sgus
ExlCbpyNth2Q6USlhZsuOFx2PGxPHaB1qFvboScdrOCzScofGfzB5DFD9c7HqeUE
3A3VK+fuXjfKkFxT7PjnMNc4l4zzXkRJwHOaIc2knjoV8XZq+hQlAnx84bngdMLy
C0he7T18grsajJbcplZVsLuVDSMfmKF9eQkw1i9M4VDe2naHVaAjTPtuOg1OLztu
X9rig169YX4oJlmuXRAU3hNDAaMR2WSZAWamWuUWT/xX4rJAOg6xVWsDrFYgiXJR
yEGHPeWXboCwpILOXDcRpFAJg6WrfxvCMiKeGbfGbb03wsX1PKs2/1mQH1PXFHrJ
n/20cMQXr6I7oOZptNvY4RlMo1Mhebspri/A53k6fpNnBs128UZhlEe4Deda1YBj
H03XCTOEEwP6vYWTEcIEac6/mHeUtNT2//w73E5Vq0hK/xGXEKyXLzJ/hd/MR/TV
A/RuMyLl8VigUQmez/6Mrw8yg8KK13XpK5FoSlbyYKYGZ61nj5AoETXZrmPEYgMV
1eNxfAseb4//kKeHnmCCRl9wV8HX6IlrWIgyySldXI6iWuPNkgesKyJEMpYg7Nek
J/RnyTaL+9luMC3htrCIct90qbyQ8eXA6AhI2r9/VWISmLx7NZTw05qsgmwgh582
SpbRa+BmfEqwMuGtv+xbMk+Maw5tXdbNMgkVR9wKJ+lAj4g4nUIWdAHLmaEP+Pav
4maa8QHyB0BcZnz5XORAjkJP9zxojqHKK1qF7nZdkZlDu2IwSYSMdvwny5XAh0+t
T1X7GM2dB0vIX6HtTbGmVbfzITisI31MjvX23072+CsiQ2GkbM8X6c/+58UCPDVh
VQGMr5fpx+O5ybueV4qGDuRj47Xnr/KEOdIDfRasMGIV9tPBMWUvj0B16kVrDDhN
CXeg1DJGWlVzomjLYxZaXlX3O1Hav6EXu8/4L6hY11uqs21cB7sb0UvgjFm7HCwQ
68j1S/sAKXgUXnNepZrQiPrQQhPl+uczT09BueON+vLn6X57VXDj7saROVZuHO78
eOcsT4+T7XH9dRHJ69ckAhLDY2GFmg5cs3DUotL95VECX35+Ddm4KrWQob9BlTQ9
grEFCYOBGr0VXA1iWlyeDHyYeDwqj2Oj1PKnAQZXhXkNds2Ex5qWUgnKoRCVBUIL
QPg4j+cG5Xt0b8cZtEQdw9rJIrAbDJ3t9G7cIrSRPjI2e65PUg19STumB55ZjmJ3
7SQNfU2CRdwtOOaIHgIpqgMhmielPybYoeQB1qOceZHIPxQ16vgt9SbnrFTGUrp7
NzJdtAFb+vlOxPB06oLuUlRmx4vNj3gb3ssDBEfFKQ6xo4sooEHO42/IbsYVuDAW
p1m4i1ibXCCfli0gt5wHPbmAbV610V3n0pDR8nacy6XmBXP7vaN/oahPBMgjpqDA
Mv2NoaoLS2GBcM0qTROTAmXQ1DNAxNtIFFDfZwczhViM4aLhG/j4JLAgSW9YebE1
ok0up/tV1O3u76zPrtgDaNqjJ+E7ZT5/nFwnuFXliisGHvvY/xLHyoF93bscK5kl
W9qwnJa9Yqef12qnGbo+MvQI9DjfSc5VWXUUjr/72mpMiNnYZMFMu7SMLL56W5NU
OVkJFv35hqC9Zau0ygXYoGhKc2hoSGw9Ju5BzwFrPJfPhLtN2mOE110XP0QrXCL2
OJpQCM5n7SiWJKxvDydEloOdJTYya8ZhScFVD1ZrZn1d0yFTnC2G9ng9g/JGh3XJ
1HQPhyi2EgmiHliWap16lD6OZ7+LAUvd8J3kkq6Y+B2miIRSzzHrXomArDjkaJiV
kefFS/2xmwjPurGLvmuah3YNDaoqqqrha1F8pxxT1K/IA/RqFLYuKbWNYt+z3ZlW
N0EbZxgP8wZz59OTdhL8/BuguOOy4qPDOsgitzL8fBhy5INfCB+E4QvF4H0ACxPK
lfZspzq3M+dR7JvgGZvDh2/wtfTTcC7Vgh+RWOrarHHSrZP7rSsmmljwv89QIVw2
zqQ8cgnpcCEw0SbPRTLEv3FMiKqdOUFQv8HpsDBYCAmo9+BPotiCnuq4cZHgCQVK
jlAdFOaKWOV22Zisao4O9b/WL1YQ/kXjtv3XAxy4l6ACcLWk+YTm8bjbaTQp2poO
nJizpNvp/3GDcXfNwxrOTr1oL4QzkhZgj92yKrpG5+9axouEkmm2kMhA2oZheKzb
gQrgQ1NmSXRTCOTWZI06h6bnRYnZlq1JBwLS4VRcYvlJTf0J01KQoXoOM2eU8pTe
/Da1961V07Mo4JHGQdwiIRZc8DZWuf5J0JSsBEluLsDkMXIv29VIjspDGnSO1DXv
864rZEBd/BFchznEndJIe7zWD/ijXUs6GWM7dGgE3pid8ukCxb01U9JmjRp2Q+BP
E0/4Xzk1LrfZGPM/yTulGeXdbDKrTVXtHI7AFFgKXeqTyhAGhaeMPQGU5UWH/DW9
un9OraMkMYTCyMp+ZcUKnSFB+yKfWt0UoR34JNDrw2tlZdNAdf1hR+1P7hjTEWu/
ki3CK9oq6HsdS6a8JUEbWlnZ342AS9nZR09632CbXJGpTQX35l7fdcHEguUK+HLb
2GYDGb68934zXxHijsh9wHeCMkAy6vgqFpER3itjwPvVnFAHTD3o1F2bwIQB3zJL
khGmsfXpJl6X3KwgYSqgJoaZaVwfJsx8q+IlDc30iBj38Xfu27FEUajWLolbMzUm
GR6295J9E20ASiZ/9Rr9bRi3RVYKR+7PrgY59ByMufETc7p/jZTl12RZvi3bThCD
dtLKHV9Xwzh/AGyjyNKvukkoDI+6w1CPiFhWVd3DtQyO5qDqpMkx8ziXT1xx/VxH
dF9DU18TsXV6HN+hZxcQu/j+PyMDakq2Ml1muM5ySzQKFCeMTcu+NQbNtjUW6sN7
JqAazkD0p0svsAXXTxY/HT3xlPJPW1qaVYeQWQP84ZVr3lSfHjI4gu8CL+212L8W
97XOnGqoAl7MwpAvaUI5W2L5Do6u1ZWUZzNF/JKYzW21vP46K8KdsabyPcj5sOtz
U3ZdBr3r7AOUfPmTyDdJ0oEeShUck6tkDtBQClfQcOrL+AFO0t5k6FRcBuCFYwLm
yNlJXgdQ0Ox14sMdKboNCWG1JgLrqtOmdnYajYSO2ywQaQGoA/KNzxHCABi3Dt/V
mausQ0vrKGEn1EGPoT8aKMlsB1o8BC/roUPBq9gMdH3MKBE+tFlrSTAjRZgnJhCw
eqQFkZreqNvXzx0egBx+ogTg0f8+Z5O+Ze+2NdUFpIcUgylIAuZpEXAmQhZz1pfL
KYbmbZ4SMKY8ETFBhAJsB6Ox3KXpWJt12bsOthzoNpSYjajuw9DTlGm/ihLJDUe9
bnV/Z5lJOafkmkrplOUtH+4sXUf5jCD13MGYDFHmJwfLUTjpXYAaAB65/boZrNpI
wOOw2ZG2RDe8Gb+Y4jDn4G21PYhH3KxjPTHSNyvI9T1NW3+vz+28MB1AnlfeS4xO
s387D7djGxkApGzter7RSI+U51WKQgzspkxSR6kyiYliroXAo+B4TiUKJ39yKEmn
dJd7MSoHotNEoCvIt/Q5Rm1v+CwL4VPLH2rk3c8gTgg7EpdEHiiptKGfdC8o8NPe
Vs1Iw/a9jQXrx6FhBPev5dxoB9Hc2z8hokkbk2WOCqT9PlxmzGbtqzUHotd8QE9/
NiizW7U38LngYImqut6oncv1mVIQnCHypku6LGnuZdFJLd4xudzSrIPoFhbkX9FP
oxSbO7bw258TyUd3LQpRkNDZya/qxgn1Rs0TY04GfXiG4/yCZKQU6WHoRjt4aWQh
uzbE4D1Qx0n703hZVc1IX1iUaah9dqZyrxbz+ITMbZFVixseDlvf6klceS9mvaf9
GexX+mtrFLmHKBOQd1BUW/UXe73reZyvfVVo/lTLX1Nnp5q6FHxpDNCPH13uv5oY
Oq4jrO0FD+8FLB+OpdimvXR9NXdqrf9wH4w6R28IQNKCoMYrEIprO/tm9xi1GyQw
5t/DGm84BUX2BxtHSgmyoCjOxpMIQuFFquI0XU3HDtldQylCbrL/Irllg8/RmeOz
TyQhoKgGv6V9TmSFZOgKSOf3JD5j5rCBjTZTDFuDyGjBXeG2VhuL1gyzBpsv1FwK
BkUM3SSlFDPsFu/vZs4W2jrJOcxTqNPujBag8bRBv1i/fUsz7pO0aQlO3z+udg5a
PtdQ6vwBIaL4lEh617addmNJwUEcR+2Gr2TrZMxrLaFYmSpdXQcPGqNHz6xXQ2pQ
BmyiRFJKKwrjMxaviZElFoO/PicTfBsg/jhzjeXrfsSo9lB2wRgBXSBXC9TtAmgh
b4ziInPYRoEnxsGtyvy5C7aLI8CrAiRUqzoXe8MUR8CzTTS041LcAYiE65eoUVZ6
nhu0CgNQ3qoGWSz5Mm0++X/v9YCX/M0sJ0/GevJNp0UdjJ7PkX1h4vjTSAz48o3+
1LjAP9C2xcolkMi4l3amM6Z4QmKWz8xK1tO97CC0ABludWvsIjc6WxTrthg8jD4H
Zf5oTzQ/yLUdt2dKRSkt2y1ULf6pWf9fy49jC90OYySGHINYjHgr1HBRmregWc2F
vWrshOdcZsQB/ByKMqTXdGccarZR+Cah4Zi3D5gEeIqvrnofjGqWLiDkI4GMrk/C
sz1TBC6mmV2DPe9E3oQcPVIcUBKnHvdqy8dThVcugl534c1nKRQdO6n+xQQ8JA3a
b6CPif97Slh0gKrAgUuLyLz/XXxbo/c5lK6hr9agvYXUuqqyUtMz7394lpq2XNQF
C7YLRl5t8vkHqGHSntZE4R6JPFTIyIdUMZCvYlFt4tluILOPHH5w7Ice8Iubc0yV
CUp3SGuF/xTDBY+IYrYnoXqz/TuDVgwVow9SJWY3wvzbQpw6xDhnv/1OOQoSfn5Y
o6iBZQWZX20CzxNSkMu3eTtOU3UH/b4v4auwNX+u7xDpUE8mtNDUpww8EZcPB7I3
B6d2UaJvQVC+sPFjgVv1W3hWSyGh+MeV5YrqhfJxQQWTQcrN3a7t/b8wU23QM5xR
VLoWV+ILUtW5XyPxxzElGxy+LwEgixIRFUsKa5dAoBl0Yk+wma2WgFmcBE7GxUTq
3PiJAY51EVFchoAO/OSGq/AjGNp+PHDaPrJuphfGo5A/QdCoWCu/22Zwd5d8RrLm
BvqVV/OqGqaR6cnT3IdEMrR1qGzBXLvnEtxXn+3ARWahE8vc1JGKhNmAfzqeP+6j
JSx9G69859gIf7swEhHmgpPAi+kN0taUN5Qn76g60QpnkxgQExW1KjrN9NXQGW+o
58Xn+6+CPhfKyY5q0RlDGmVN0CE45TPJ61zNoXpWuR8T7QoDEnWtbrsy+9bKVzxj
yyKCQ40wKO8/fKKWdhow8c9TuKizkMwZf0WPCBqqCRmFTRSzulRIIbxN43kghFpS
YUWcn6HgsMPt/YfxAtNZG/W1S0NGRzz4Zz0vsW2IOEQUP/Uv8dAoem7Ltw6wsQ8O
Y+x1mDdMnRTMBij/laaY/EZfFy+JOowtfmVRdHpByROqTy9pzhlXIU/WfggLsnHA
UDjkd5sNAOiaGouIj8CNoNbB/8/5n1/vWHS1F6ff+4enqA+QnCTrsdmtBeI3zDGm
HsjxJ1NiZ/9u2DWpvGgA0yTxEVktRFt6oOwu7iAh1bi5pqgGOOfj77Bq3iK7Eo3Y
l7CqgrPkOUPKeS2TGoZQUblXz2zzH/hhFDZjOYMX1Oa5/vw+h2ESQJnwhUBidBdv
m+Dbce3sfpQzYWDK3HuR13apHqyAw2dWtGr9F+pifnvW0/6UBLRW5+GB6e3V7jxa
lpqr7DjXgw7vLpNfl/8oo66Ex8cjd4zeCKsNhcWxfuEol40dsqNFGtUtTZkvrHe8
1PHUynnLVO6hY9jFm/f5AoOJu4Q6Q6LzVNJXHdtkPT+N7K81bleTvh0NJMbTcqPw
/ihXNEeVcAzvNZ616/eeaxMHyoEtUMTj8T+zNclD8u6lwQcrq7M7LkDNGT0YIwMR
zEYsu/zkE1k7g9kKvlrKK10TgrNaPMCUmCzfLrF5n434q+mpVfDkgOSP5gZ+i66i
PZw+qTq/EmUqTHv8JbfRxnRUCiiAYmz4A7Zao8amIM5fX4TQPWcMTSpr0ceswgnl
hf4DGmUZdJ04FoQ8T8+d3G0gAi+8dPhkZiI58a6CC4qGkLetlIzyqff2baM+RlXr
0DZFyQJtms0MSqJZzvlB7PbX4VDz2eGGqSz3Q+1IRqc5aAvkE4tUPMO7oqtSq/kq
v0TRCOxqZhkGLwBWeq3ZPIqexv63oUFU5Rcwn/Y4qcasJ5PIhloMUlmi1KLrTQNl
yx3Pn9p3Me7pbrHqnC/6EMjWK8W4aDTDmLCcHy8oUDSoBKI7osJUdzRsRnPH2mjN
Ab4cFUSnoE2XeTorOqH8pFasp6163jHVvMkPX4UODvrAEieokLvtN/28StN8zalT
GTgCX2MxrR2c4YVyQG97G9sewtqdF45GXqCB6DCXlQISjvJz4IP7bHJC4Nuy1SAE
dq7281IqtQ5bfv8bQBw4p/DIDEngKZVVNW+kDDRVL55YsqKKChFlAuyPR5cAJh75
7qOOo83Hc93JkT/5LOPwzac5vxfTRNB2SanKKGk01PJ2QeS4vVYmmCCF3UzHfl/b
rzQgvSzE9b4rFpM3sWxjM/0mEd3/0QqfW1c3nHwCSnGo1xJKbjSf2OdMFX6fDVer
r3aJckKcsddgiErgd2ebKk2IA5ZcoXsXAZB7jMgExRP6/CmmFUc8ZDne+t7X8R3L
XZse9/uY0pTf8d3CxMRmkIFncjfaesWhuDSQbAhYbFxJCabhMI6LLUEZMCEsZ0Bt
qD24mm9FNEx3P4+0oTg8I9PitirMUUMHnRtqqhj5i35jUkKk+mLFZfiTXzEtOlBr
CVquPx/7q1S8U8B0yxWN4B4K3RF8NByUhEc1wJddhI3zyxSo8mz99eVZiCu0tTCR
GkGVq5T8SBXGrxWeJmnid5LyfhLSiLzTOpxmNYnKYX1YmHVO3UltXthki3Kom1t3
3XBfu0WWQ0Xd7WSEZ1tg0Dc+UZZmtE7CMZg/UIKh0pk1Zt3/89isASrN/QjeX3Bn
A/A/CTVV4ajdvMiV6UtbErrBJ+hffL+eaWcoqhWHFQr4FiJ9C05o3DdNO7jbXJy1
sm2jVDwPosD1/KFwZH7Af/8u5e2tvZnLxksslZ7Z4OaDuQHhGfp87IgFIPq55KQq
vQwZ36XIMoWhE0Lgem539iIBOXfcNrlhZIIHEijynftK/nI4feWObFMNzYPzR6zA
5ZtYx/C/KAn1TtCPTYvDplwETtZ7oSm/WJUIDSo6AggxTgN7HWjH28rpqhEW4msa
8xBMqsgCFNAEQ2JLWLHpoxdL55DZHWg1WBFRhMYX8idCAto2ETJEUPP/t/kkO/Z/
5APc3e+WlCJEgTxg3LWgJ/KC0CWOWBy5bi+yhdXSY/4sg1zzl0GyhE97Tdmpgqao
QCd7IUEsxZXHX1nwFSYX9UpT5otKjGpbH3T2pHmNTa7q0ePaaBrNjYNGisTz6oXC
AmodWBryPR5CVGKHObb5kYOcBPPZis10YeUuangWtG4MNPGAYxNcFO8mcSWjOvae
gfIHemM0lsy/TyLnvHOo/R4R9MVBE0poZ8Tvv74+5vcgFAXNHVU/e6YqhP4DwFln
2lSypSL6eyjacIzXQ2W33nXcCtBTw/hzsSKGg8piUqLVUEhKQwJGgNp1Imf3e6R8
XPEaSyvtzk6UJhCPBbo1ZO67/U8ZFDhpliZFFPpunsPIDiaoPNlHyBHt4zNnrilA
ODnoue9D1shvGXUGBNB5O22LwVUWmDv81g5gZXNxbVIOKE+jE8NgwQzMm+7qrZNR

//pragma protect end_data_block
//pragma protect digest_block
Pu6XRF0wLnObQo2PWxxrn9i1PEo=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_SPI_FLASH_S25FS_SDR_AC_CONFIGURATION_SV

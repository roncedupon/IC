
`ifndef GUARD_SVT_SPI_FLASH_MR10Q_AC_CONFIGURATION_SV
`define GUARD_SVT_SPI_FLASH_MR10Q_AC_CONFIGURATION_SV 

typedef class svt_spi_mem_mode_register_configuration;

// =============================================================================
/**
 * This class specifies AC Timing Characteristics for SPI Flash based 
 * Everspin MR10Q family in SDR mode.
 */
class svt_spi_flash_mr10q_ac_configuration extends svt_configuration;

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

  /** Minimum Clock high pulse width durtaion.  */ 
  real tCH_ns[];

  /** Minimum Clock Low pulse width durtaion.   */ 
  real tCL_ns[];

  /** Minimum Duration in ns for which Slave Select must be deasserted in between Two Instruction sequence */ 
  real tCS_ns[];

  /** Minimum Clock Low pulse width duration. */
  real tPeriod_ns[];

  /** CS# Active Setup time  */ 
  real tCSS_ns = initial_time;

  /** CS# Active Hold time   */ 
  real tCSH_ns = initial_time;

  /** Data in Setup time   */
  real tSU_ns = initial_time;

  /** Data in Hold time   */
  real tH_ns = initial_time;

  /** Output Disable time   */ 
  real tDIS_ns = initial_time;

  /** WP# Setup time   */
  real tWPS_ns = initial_time;

  /** WP# Hold time   */ 
  real tWPH_ns = initial_time;

  /** HOLD Active/Non Active Setup time   */
  real tHD_ns = initial_time;

  /** HOLD Active/Non Active Hold time   */
  real tCD_ns = initial_time;

  /** Output Disable time to drive MOSI/MISO ports to be tri-stated after this time   */ 
  real output_disable_time_ns     = initial_time;

  /** Min Output Disable time to drive MOSI/MISO ports to be tri-stated after this time   */ 
  real output_disable_time_min_ns = initial_time;

  /** Max Output Disable time to drive MOSI/MISO ports to be tri-stated after this time   */ 
  real output_disable_time_max_ns = initial_time;

  /** Minimum delay between Hold assert to Output Invalid   */ 
  real hold_assert_to_output_invalid_min_ns = initial_time;

  /** Maximum delay between Hold assert to Output Invalid   */ 
  real hold_assert_to_output_invalid_max_ns = initial_time;

  /** Delay between Hold assert to Output Invalid   */ 
  real hold_assert_to_output_invalid_ns = initial_time;

  /** Minimum delay between Hold de-assert to Output Valid   */ 
  real hold_deassert_to_output_valid_min_ns = initial_time;

  /** Maximum delay between Hold de-assert to Output Valid   */ 
  real hold_deassert_to_output_valid_max_ns = initial_time;
  
  /** Delay between Hold de-assert to Output Valid   */ 
  real hold_deassert_to_output_valid_ns = initial_time;

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

  ///** Assign refernce of svt_spi_mem_mode_register_configuration object */
  //extern virtual function void set_timing_mr_cfg(svt_spi_mem_mode_register_configuration mr_cfg);

  /** Randomize all timing parameters in between declared range */
  extern virtual function void set_timing_params();

  /** Calculates Random Timing Parameter value for #hold_assert_to_output_invalid_ns */
  extern virtual function void randomize_hold_assert_to_output_invalid_ns();

  /** Calculates Random Timing Parameter value for #hold_deassert_to_output_valid_ns */
  extern virtual function void randomize_hold_deassert_to_output_valid_ns();

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
  `svt_vmm_data_new(svt_spi_flash_mr10q_ac_configuration)
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
  extern function new(string name = "svt_spi_flash_mr10q_ac_configuration");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_mr10q_ac_configuration)
    `svt_field_object(cfg,                  `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
    `svt_field_object(mode_register_cfg,    `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
  `svt_data_member_end(svt_spi_flash_mr10q_ac_configuration)
 
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
   * Allocates a new object of type svt_spi_flash_mr10q_ac_configuration.
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
  extern virtual function int get_clk_parameter_index(svt_spi_types::flash_command_enum flash_command);
  

  // ---------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_spi_flash_mr10q_ac_configuration)
  `vmm_class_factory(svt_spi_flash_mr10q_ac_configuration)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
v+GnfSBdVza2ub08ALYxEN7rkudVdzEAhe8kMWd+T1rTADwEErZlBuFFMQRUgo+u
ogj2wco52RDOTWeF+OrkdXFpTiz/4LvRzDVzwmoLGJB2KBE2aOTbUx3xYvRARCMa
VvX2UR/xjCBi0/8KGgJImE0kYgRfnUqgVawbCfC/O26GwhL7UQlxsA==
//pragma protect end_key_block
//pragma protect digest_block
NcSy68S6AEwEV3lHVvEyAdQCsAs=
//pragma protect end_digest_block
//pragma protect data_block
F8z+RJBHtx33Rc8rETfSGo2vqE1yxQP8lJ0Sk671C0nO/Jtb2DYUvRzm1qNznqcT
Ek21F3QSfYe07UJeK+xr36DL5/G/S/Uob8EeWJREqUy0HXMXxlk0PMkcWeJjH68W
bHO4aWeWdf0qnuj8g/j8a3AAJorezmYZzlnNs7Sd9CfcBmpWzc4PWUh0bGHcCfwL
QsdrZX5w6kWzcwJc2fyhyWjE4tl+IkMJg0xuUCjMbjYJJeUwJd3WGB2g6fbFNrxF
GDjP1GT7V5/37Ifb37AZ0t93FldLG0WvMID1cuEAWm9F53Rz4pCBEjvMpZ4813Az
OJA0h7OeVprJe/c3BsK0HCki79Z4fQHKfgBOHuIdWce8233FyYtwjdzc7AHWYLhF
0wG/TOpFN6+7y4FX3fh7bnrBEXWw2nOWyfS8z5V3DM2XlAyDMTQgabh6pd4UjwHQ
tk2GtAf83wrlmBflKqb/L9qK8LZ/Lf4cn7PghSjFrDLd3u+0fvMEFbLlYfxL3kY5
5uwaUR1C6MO3OUf2SwdEyEubzlDexrrlxXOLfqezMUT1rRCuVcQzdBbrro1yISf7
NEi5zlNewaPKFRfTFJSlaX4mo9shlGgBAASQLiyT3/b+n/JabAQZibXHesZv2/P8
E0XTmq/Yz22msfIaIkajs3xACkRcKb7ypnOT295UOw1Hyt12K86U17YI31Ex+Ug0
xtXwdKTfM0Vjcastv9NFHN/hm0XzjFOmYrsl+08KZlXToFow2sjXp+YQ8WHLfm32
NkPv/V1vC/u5CvYDR2T65gzLvThmq8Pzy9vyZFMvlN5rbDvycK9j+QqDfP61ixDL
po6crt5WlmhjHTjo6WYMvDSqfr6mMSLgOHmLl6sB4mpc4UQs2d1OpsnBayII5Brf
rbHmI+6rgTKDJ3XyFDJH19/R2SAjmalOZ3mx8l7jny4kSMcU4ghEzhYZqg78A8jL
PbwVwy5hqj4ufZpcqlf6D2qP7alhweWr8bq5gE27R+R3QhEfBMn3cdxIlC4CjQLA
sQKYwIUnttoQ1HV0OUVquxZWkY6h4e216KUehEaij8VgvZvGAxfPYmyOpfWwWOnS
dD+ojOMxmPgC2tZFKmoqsH0wbXZf0sKuJ32USfjAjkO/Is+G1yLUeISPHSChuHMM
FzecM12j0bFMUSqhxxgLlk+9URoJbz8TJobqMEqT2rHPJ4GkZzbvzp4wIt8U+Jiq
GIGsa+WlcJ1W58ytAPWOtA==
//pragma protect end_data_block
//pragma protect digest_block
391INzG9IWDewR+lHUwJ1omFxZA=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
sWVK7YeWV4XwN7lAGEPVtQAHOEEZfvePlGy/uLO3xbEXnRQOItCOTmz1RNW0NkgD
FwwcCa9pg9JlLp4uyA9OENJuZmqckxLITMSqh5AmwwqyETORt/8IA9sLNAjEf/Fu
yP4jXQPGguA47eG3a3OZENEeVvTwJwCTGLFZqfJ4cfV5y6qDBvH+uQ==
//pragma protect end_key_block
//pragma protect digest_block
phVzo3QXyVFvm+gEMfR9aATbFwE=
//pragma protect end_digest_block
//pragma protect data_block
He5a8snYOEjY/qAicc9HUorn28tEKyC0/gdO2u3Z95yFrJvs10dTy52o9p49Ensg
HBRM3PVWoJkcRxxIOmkl4L4hyTdQzEXouonV0t1Sjr1wbXD9HPe3kbXB7BhQ72bY
Btt27jom0j1BCZPsvuQKJ3B88r6wLVY2zfiC5zKJLuFS5Rn58q53u80oNa5leeci
K47LCPfE2M2nT2SE6Uiec8YJxrgdi4Xj1/yxz22+l04+oJiRMRSPgDJ9tTlgmsNt
gELrQlfrareNVA/P/d7YXVFRmATcpF2v3GXKranjW5pZtAh28y9XGYsykb6G4d7r
9F8F9KeWLDehOskiHP1z2lIG7Ea9jT66S1eJ1kzKyLVNJjFb1e+NmnkEMnLiau0N
81u2Z2xazL6kFHlYEOLhIaQfImMRLUunIYbZhcr6nuPC3JSHll1RCv9FIjzWy1us
nU4XpoYn1Mr7KaY2bc931kD/CCQzutTL1Yy7HT3/vDcFpRdj9lqv3i57cS+zfyCZ
PWW+CXA3FxcLozsMccvyLbMctF2boBIGow+MQFwEbUfDfCr2KkRxX/CxqZW8IYnM
G2yL/5icSorvTSEiS4eMNzxbjziav+kwIWKyO86kMRtg76aH/WdzQ3eUNMrIiGIT
oG6RtijUohYbTLX3KFC599smwmV/BteqnKew5Ulwdb5pUgrTT+oila5imwbFM03U
ZI/bzt/pRxAaMOtA5kTQkcL9aP+ebZgGW5UnmS1bSuyf2Vbw3Dey1C+Og6BHQQZv
EhIQCVfYI1IoaKVQD5lnMLvlhi7MhOTVGjRblvhJ2RRV7vq1D7ssV8syeqIzsjo3
/rR8dch4uU6vx7Z1oVzUq4erJCCKhsydwlfEnLg8H9yn8yC0iYsW232Ps2rLXuY0
0s/EOSGzAgsAQXAyk+M9uHV07vQi++aN3yVAvKQrBJiSZ6wNmtGoGAreGu0boOjA
LQV5Cgq9de2xe3Zd3W5KJ65VCPdaUVjGhfW7igvqxoZNgkuCRz4EUtXepo3vvbDh
xk+JerELynd9BpWBTgXWivyqTMF2BUb/NlSh+xsBfAeYG2LUrRMOS5OFFd7SeK7Z
g95HkRAMGFQVZcuf/gKtqN71ke11U2mGS4lWUIM5krmzRns2fyjN9uriUcfMLP0p
+NqljROA/qAj21tGe5HhMmUlzZu+BTJsK8brW8+R1R2CpXVUqM7AsQf3OmEaea5R
+gjcqjoOzfJRpWy5IXzBQEfG8Y8Fsc1YqP53824YjhkgAL+XvTGentSwtAL1/a9V
ORDpYPtxYofQwVqRB7Jw/YA4EgNrBQUf6UasMl01YXbBy9+KfVoyqXuhjyerMKIo
EDkLvNTNgeCtkEmyfmFylFOC2mfN09tP7AJXH2iBPjszAxX1weEV5o9OCNzBOpze
vVEDZ6pKAg5iDsc7yreL01d9CmfQJeLwOU9aoB8Ot/o6tATeMgjzz66fZLIacjcQ
N+qxqaXtm78PTNgeo6DDuaHb7+MnMjtxQ8qLzGWaxi/K0/6aqaDa+DDJjukqwmJE
Z4zqnklAtWp9QDUL+ub2nJBnUAOPTvSPKOi3wNhFTaXVa0NKAV5JbhY9rD/+6/vh
/RKyFQPhASDPr4JUs2thsEyGQ9TJcfdw9zunOlHFue+8LHg+WWW+VTziUsgNX1qs
PFGIknwX5M6/MlAmmoUISy6SPIdcdciN4LKQ44HcIxKPWMnKyCKYDatXJatJ0lu0
5t7ymYhlp7Ff5AXdQy1G9peVCyzVkrJv2XYwEEqMaDnzphsuDiC8sLnORDmfEM/F
DuQmwWscUULQq1meFqHJI/jNJvwEjYEXtyUyn4R9R87CkyGOHDGCsIuq2bPQyUre
5EDPLeYww7Q7NFBYM8cy3NdlpXCzrVl2fwy5Y1AaIzU+yAm+IWT7c1LCa9mmqpNy
oTF2EBCAwd8B+Mqv+tEACGi2W7y31b/+Ts0igJoUvHtxIg4rQHnK7VNcO8Dy+SGh
xg9rqOKPDUNTY74rJJU3TInOwifPOHce0vj97TqqV9diGSMkbSp/qVWfIlGIW0df
qpYLa7xpmuKWblB+3zM4mo1B2Ce2qPWMuTg7RIqDYwKwwn1bvkFMn0vSO7PankFq
k+U9YF1uFdChUQTef6CWFqaFODlBgpslaCpxL6vA2CRw4yMNjk3IPPrdtc1ngGkE
RL1SjpcFXHbFdphSyJGg3zvDKYjybXw7h60D7N5ie0CpW/Zz93opEU8wwUz0MkCN
R3xoTH3Mte2RN8Y8LbbbphMCaNGXFlPQxJQ6SbYy1z3wpiFCbJj8nHbQvaqXZEIx
1VdLu3YjYFxkNwGQDXzk6Aq7+wAoHEqoD0YE0Gs1qAsaYgMrX4kkfAVc2DbBkQAp
VBMWUEyCu+nSERPcQcvDW2/BsHpE9Q1PeSIA7VDwGTjAFdMMYo42nJVhU05Zuswc
ZAsoZKqNztu7Z/QlxE5M1Iivp1uPscjJnPgYsWakayMsb28KneHuvGfV98X75l1M
i7FtCbqnvuvLForLulK1DueIeXLAlsZ6FxaHUcLlMdMrN/4j0u3GIcZO51Z4bJ/M
ueevHSolcnxxgOxem3+hrrmdPQlCZQen5GGDw9bhJIcqlwjG6KZELev/c1QYAk9W
jGiQHWk+AghcWG/fJXPuOUErP/N74BdkVH8tCEmkmGmCWLBI/xnHz6x+sJOMoFK1
2IDErVFC2UQ1xPcUaiEIQsFuiLmAAUHGa/EjY/b2i1jR+8fXb6qjz8VoqaA3R6e/
fc7q73seQO4b6p7uz443Vons3hwnQXtJlGsNU9gqDznP7FwBOV+1ygLumKqB4Xjb
14tYzlhxTojzVJYBmUDv/7+iLrGfnUDk6ky1XdT2ek25kPe0VqhQqMl4l958SVu5
qM1ufESobatCGoWzQZCHc2umwjDnj66onXDolhP2VsmMH35GeKZlRH6SczEmG2wp
0CaD/k6SAYFODZ8DWPguefSoz324PKKctrXWzTIYkVaRplHxBDQvuttc/VlRZo4H
caZ3PpmZkR6royNFesIiJiWorI0PFtC9EbS8cnBOEBc5SEQQGDtRZKCxn2qzVzB7
iOGT0qhM7WtQVhHIvYetosASQbduaMw57xPg0Ub7cdBBbwANQxVY6jbrDtgNBCoS
GxGzCy4alqkxJOLgLZIw8QTD3C3leUEwjzpUTSvNRNwgYuczklEFy2AkK9xwjP6K
K9idcnEuj2ilCBmuqHlBtm5JguS2F/wMAtVUFpwpLU1XPUE+btWYH7UrGmRgLQ/V
Zh74JGjE8lE71YqSZNu45jp3M9V9tZ0A3mpiuilLwSpAZhvJFYvVhyblxBpyk7FL
G8PVXq7tv08A9yMr+l/fGa2hSI1cRuId0BljDXLuLX41QjemuGrtBGBqmYMLujZW
pw1TRO1zTzQ7zGVQ2VVMkxZcL+BMQCh/t1z8qk1sTW/XBgF5YLo1UgPMRbzRHi3q
zTX7NKCLtNa6KKH8sjw8FQyUhKiDpxnQyIuqdPAd3rcaHyadlUrzZum5QvZmxqG7
wquyPnzbuei0Wa1M8c4/J20ymjVHRuYwdVnZbx9zP5KpRaSW4h3Z36ej7iWK7SYh
nogI7xPuUdFtzQoGZy0h6GhfkbBqc61E1nAfvPYJjYJaqoXk50l12IP3fpgVMBu+
oRcNR4ydnR5PUbs9Zm1+Ka2MJO9kRHPZUn2dPbm+AlwRcxAgbwQURa/5RO/W3jlk
hEi3Z5YUnTKNunHSmVVz6J/F544ilCXTbLDSd/lSnBdHmNuG258VTnV3EdJVIKHH
/p4sGoLC6jDT7QBp/DAxiyug9fEozxLl3f14YPP/7yVY4ae4oNIumXx0zO4/YwDD
hMFEPo3kkruF+Rje2XGMYnq4Q9Ln6IiZj8wx+Fr4Y37zGFF9v9aToUrtvez6zYd7
7MLwhY8sHWGFfufUysEx5j2CqgbZMCgeTsxbR09l+pU0X4XGeuiKyWzHCxD/18C+
v2tGC74MzTF9PmpdNVkvublejJeFCkd0Ebuu6TKgpPO79fhIkw/E3hr8ohowXYeP
SbMSj6eUT2ZKfRxHUoQ5j2v4xbXEBND6Emtfq86c0jKwGAVol6UDztJekZuxCJiS
AB0EbB57FusO+Dz0Py5Xu9mKFVbomksFv3kkdP2jVWR3ccNJk50LG6BRslVKBQwL
PDkWOhve6D9M2jVPilcW3niywlOj5p6SN0Be2Nq8WDIT8/+9jI5DQvDW4b82uqkv
QvmbySKSBrF+9gMCBgXH0MP9d64mCPEmqEuj+Ycc/CxfAsnG6p8ORSBaaf0iM7Bs
cB7xCD/JjxujltWmmS8L2RMkowCR9NEjEF1xsWqSYM4HkKViMDmj0GVkfURSXG3W
s7U2S1t25XLRau1upLXw19VYa0HzxToqX2sUltN9CBoebPgSQXAkOfvhfJe9wOq9
E/X21nYZd+bgjPyQByOzefkw1U6wZHMR/8IFz9ykYsI01pkll9Xzjhl4DHC7tKgs
JDA2cuvs1GcecP9i8GS4fI4xwsoo25Tmcx5t/4QyZBTa5Q7o7tpWOr5yHOGCK4AG
ZleH8+wSDSWRRYsnw2tbozsApo02dWtMvUDHgjEOa9qCvCb88QDsqPzZdIThsPNd
6DxLY7Nvgdu+9LCefHn28mLkyp2aeVnLiQP+FD3m0QOWivAGnwIQLsOkJz6YhE7r
mEAabFx2mWlZPgavsl279B/Jpg2o/AID4pz8poFmJPlKKCufqsYOMM6RCJxZsHsG
xjkG/DCIZz5iPDUsdjueB7ji4PAa6Kd+MV6PloGieXnsjVPnfKwArFZrzQFscyzh
i5lGB0rzmDt7efsgO4/hmW8gug2BvKlT64P/wTZTuNqMT1HCHWvwhXM8QIx5r7t3
VxhDsYZp8WQirLKwNjYS0l5BlWL8M/hnXoZgK6jCs/9t5nwceZ/b67JwF8Wm/SDZ
EQHDebc/OzkmzzOVCkBYYCVY/aL4Vkk4hTwrlKxEMEcCfA2AA9bXlX29GGB67Bss
80+LbzQXZaQa0+kJTB1RHgB7k1Ia8k6qOWEzrIMPbF2T6Q50wcINU02ThFvzHtd1
tLcNORBc7vEgqqNBQlmlGYk2UeOltXuXJLky8Z4YODSP8sJ1Kx6t4ORxeySEkYFn
ow2DkvXb5s7x7E2/z7W+WjNHyxKstC7q3E9Ycgbj7S0X1lpEh4Zou0bxaGX5j4YT
AMLKowa/eu8KbWIxKPPxlyJVcf09lmRcI3jYhpz+7R9ZvHmElLwysEP6fX6bR2LE
M/sYMGRA+FJqOhUU4hIXdvK1NkLqOgWrhVJKiD2wcygx8OcaTOpMKPXaHZGGH0TL
1TXbz4SB8lF17G1tgwMxhF7C3tt9kTZkBpidlAKhIVeru7qzB+fjBGooc0Q6h5mO
NUIOXR/ba99Y8ut7VefwwabZiOiOCyuAGggqTAhnUpOu3JLPg22Sisfp01JqBKz6
yTpaksLyO/ef7h9C21Z6Jmi0VVLZ2cml7Rp+6FZ+qTQ3guNDLwkE4R6DGdXsrnsc
zaD/sY0xu0mejxG/OPP15nPxZrf4HYg6hNSSu2xCzSba5r7kbTWXsD6UN7gUaw7g
pOt1blZmNLxypQKADnQGnuHvAro01f6BMD6x5H9+drR1VxA8WIalIDWldjDXzncL
4egrW6xdZXq7m0T7KQrNNiAF9EXBkZablpp1f6SkX+HSQl2ZxSODN4XeBvmKorld
aapXTOSaM0LjQWW3m+1hZMtHZrZYqUFGMhDT7dSAWxrYJ2GS9riNtvKe5EvCxlLf
I7W/rdPbADDJUTLofRbu2JgxyZhdl98Ir6QnKxeNkZ/wKWieMTBsFGQlqc91UXbG
/q4j6MZijrffp88aoBfv/C9KgqCX1ygvZFUm0lv5chj+2diLDTwEumo+TrAKcJB8
mubtMfy/L5Z32HDec4ATb8UHPrjgT+yW0n+dKcyNB2YxhHiNIX82bFoxqJemfWtw
n5lfcyyQsUFFFNa+/YyEcfteOm4N5K1krDD4WKde3x9J9pobppn1yo6lIATHm3WJ
nniMv9MEnu+1RLEyid1Y/6xQu4iMlXsR2RG7xVRQUMdy6Myjll3YH6Ivm2b0nuAd
umQcIkeiTMDs9ti1rT0PuJLc/ph8vAfGtEKm+vwmrHvNsGLJt1FzF9SCS8/Gyjsz
qxEr39gtErUfWxRsySl6gDRC4qrAGd4DnNP3jIMgjITJ3Map8FFmQQGUKQioDZ7Z
GHyriOJZBiJkKzI9LKHi26n6Wzc5DM8vugV0EmO+TOgur7oLUXfBm4561mG1lMws
7CNQLNpcm6OHfbV43QEmpPVpBklJzFzsIB/OYF5Yey00SmVtZA3H8aHJdB80Kepo
0YQLk6jlaiZD4PDavyq8B0FbFjpwlQ2+mjHcl5gCC5KpS4YN1L+vmXrWIVt1P1PK
QYgRQwIOOYhq/9ntkC919i7noKXoFAJCYHlUi/uXjOhNkHGuyDSDTwFJbydvBXSI
1U9Jqmp1KGopMNOb0AkydA65hdlB2S6a0pHuVDyqEwDlA6M+mNP+/o7qPEbuzu74
9Ie6TYcYqu5S/NYv51YguKOdVD1VDr1u0ZHv3IvuZV9r1gXehxZ2W2sX3WMGw4L9
eDVibRR7J9LoV3eAI9rOscYCffKXE2nuriO/4GUy3ziD3uX/lT7eZnIXO1D5+7M9
lrUURaffPfNT7GV75AYxadyuPfsKJUZr97BK12ou10lmTkxqOaeg2zfTTmjgRm7s
ErYWlxobRCkH+qYYG8ZiI7SZ7tuNuwrOZQJjHACVOJdxoUV+Ajp/Eh1pkohkivNK
KnH8VQCNHlrt8k7PmR7D6GvxynHbGaFdutRraQFben+BLtBiwgApwb8lbQo3as1N
ThOLLb+rnCxxjBadx5yxNwyZV1X/Ecn3f8yUt4VcqDbhXC52sQDH5R6VkRnFogEu
dN7DgZDHUbtfDIA9BNtFEfGE6ufDQoVSO+1d9a/FvJB+ongDG/e9YjPxXwUwRM53
M7gZ7OiCLWJPK5kBGm/DBjtob+v9fbiCGRYkDm3i8IdIVJUTMRttl9jrCrAkAkNH
xo36rUL8FtjixXI40CQyqfTBig9DS5xY1FkWmZnZFL4JKDJEridfGkz4FYPawUpH
XNqrrr2fQc7coHnHHd8p8kIQWPM8tPvGY7unxcmMFRBTiRowC+iWHFiIcyNLN8ww
UzVLh2Wb0eYclnIkqnxe7mp+/+yKP7JUOeuhXpnS+fblrrUJNz3JC5vDgVMPh9za
iJlvcJOZahVfauZWgCwvHweQUfq140ayetlnBzQ0AuTP5qZ+mzhFUhYPgLv6nm8d
L2z618JCNK5J5i+u0MmMEgCw8XuAkq0AtcChNiApFltzgqrE+CtyV0kJXIF0mKEg
OrAWZx6xbapxljbCd2BCUeljfOx3sb6dBXZ1mHdzrY1jngFWRb0WStgQdsMuz2iT
DFaGkux1Iml3gui/2A15YuZqcE2+wAQhGhuRYZdyvB2J/eQ4WOQUjJPPcVb3YK6U
bHcTViYn5DlK23eOJ60c43Wu8WBF+GUb3YL1N+3rUFg8tdr0W6KlYI6II9m0gx6e
qmNNi++/a/VjRHPLDHvjmVjq5I6sPynQhR0EvyNl4wfXDehIgfw3B7P5VKVOHpYc
fw2ow1Da+iBb0M/3lxz1Rd8cxAwzYeTJxp7GCYcZ+dWBkb/2pb+Jaq35y3p5KBYK
T3qKyUkwFTz1PimGbOFK7df6NZN+6s8wvNiy+0yaVv/1NebYVTWjKuyhrFeA3xa2
nDKATO60PeCmDrcmLaD68Giu8piQ1xuK0mHonbkyXcGATQWIYO7ICOgwqOOetvug
9TRi1o1MBL0Syor2Kh4p/po6JSE1b05q5GWBBTUWMue/TUMDAVY/o+rkS6KWS5pq
f7GrsCAf7E9KxSiFROhAyBZDRdU1H64Ed4wToXH9aT34rw1K5asEgOqxwYFCahgZ
8vLgJXMTT2G0FkeuHprHf4OUmYy4otfDVOWMbJe2fSV/1wJsvEnQsSwfOQECEoPi
l6L+BPzb2Z+izSc9/gwS07wyKGYh9WOrXpkfvRg1xh5yPJZvzhsDMBC5S8qfrxIm
wpFtSojyor24MvkqGnmNXPgJXPGwlC3ODt2UsjeI/6pGzc1c+Z1IaYs2WxhgYalf
5dhx78kIQfOwvdf4PRce7bKWsIez2Dj3k0B23se1wzN/zHqcCDYxEkC+MDTwPBSj
lFXi4Luj1trqAOk80Fib3AGp7Eolr5XCPvGaSrnQ4O3BdegNS/Wq+QJa01EnBIQW
g2Jvod1TNy8jrTOMeakExGsiv3GJ6BvQxhMcx+xTl9RAN09kb2BliSlvq7Xg3DCh
X6pNpLWFE8HoLTjLOIgjOqPUUj/nw3PuRcfgQSRzzsfm80SJxQamBFKTLFKo6mE0
i/Pwe//qgJcw5T/X7vlmO78UpPnKD6r8054UP5jd+8gDrMaI+4Zi/Khak5t/6Xa3
VuZ4PI6Rqvl21yvuE9q6h0IXZk6gnddSlbmq9OGQ1F3TId0GsTbleUGEa3htUZkV
dZ1+Crd70D+ouDzRljcQ62ZeKPV9AMjKBeB2BS5obMZSvR5bvj9q3SVkKXuaL9lU
jng7L808OVgbJbzj0KoKnq/iDQAbWYrPHXkui+GXAEfIUFIp/S21I8I3Z7IQiNNU
JVbUpyGIUrDu3S+8M4g5+fBIx/oCQZaGtVNWDv1+pGkyCiT1GbxdVZFvix7fMT3R
F75lsT5OyHOxDh2hLz92VciyRJtDFpBOs6GKKe1LbqQ37cXht1bFRqt3j/TSPFeD
pm5bpN6IekZ2xwAeM1YLHJ3RpU2Gr8gPHLalSlQjLZz5McYHp3I1p/GDdMRYlir2
i2Rrj89k8dmz65QJcgeF5CArw9N0Q5WaS+UCZa77L6kqK6diIdIIfX0c2JdS70Zp
B7TrKdPNuzPJWQo3jWsKw7hp/z+uWjOq3SwX3A4Acyz13xTEd4A2+0zpuByrEHHG
AenXnDx1QWHOTmAjTvUHogrPKLNuwLDtVlBGvleOmY411Rg1Nw3ImTugq2xvImLk
SfGAW03oNEgVJheIhqqyfHbdtli5zC6PK2kg59MQSHa/eQhHN0wXM960MXwXmXfp
rwzsyLspwPbnd0/0eO0ihW38x6vwK/+MWek5qGK7ZtIrcRBqK0bPG959JXqiphEA
z9ujV2eL1xgxL3c+fUGBp1gIpS4Iib1x3rpzqLSaRRIOvg/Wqb3tbOn6t7YgjBei
WCdNs44LpB49zIpORAzoqygY9YCi386CxxqvzHW3MzNDANYwbD0bqFTeHLPhCdHu
+cZEENCyuU8R+L/UobbZvr9lhZvubOCaXOGy4kd18nQ9cmHsflFGJr+shQRB00EA
oGLFx7nZlWAjQZA6kmmr2M/28dsobvbCL0aG572sQvmDudSBK0xL78XW5RA7UM6h
TWbirs7dQ0TUbTbM1Qo+6p8qpjOEoRoxivjWYXndZLpy1UM2nXVKcLobEsESKvZz
a5ExX+VImC+32V1MQdh2THwYrs+cuQIgb2AGB4M+6jofa6L4ZIMD5TzKHcKqgURh
TJl9EDIH+GTLkS4pk3Z30g59PMnoB5nMt1oKNqA/G5I4GEYJPJfD1EnVrKIXwOtq
Zc9Z2IixVP5gbZD+B72IKSi5csD6bAvhJEqeJQIIwv0k3PUjx7ze02Iw4zvt0GLf
RqAhehqtELQKAFDhvDJb2w/oTdtxCvLDM85VqdAdRj200xX0rf7RqfqS6BHRdegr
dg5TZR5xF3aEHdYFyhyjiUHJ6Tow1r+R2ruSLBWslF6rTDZHK5JCgm5IcHNUOgXT
60XiYJr/aGiAUzj8OJRCN6OLuOKOE57r5ox9wsIsx/tIxt5Cn/uXT4USpx3akcc5
ngIA4xG4S7sLBSs8YkXtCejIb/hHG//WM++EyH4QEY0SLHv/aBDr5h7V4J8IAWf9
DYcWHzT89CZRwFl4xkY35MzNv3nxqplzNeeJUYBhKU+HP4C4GQ8ZdZeESayJEJGs
1gHPoRz68ozQqAukMAy13pDKNHz4ZxULCQLuwUu7Ay3BTgsDo4oMUEmvX+eR7Y9n
0mUmPvx4q5MK9tNes84skD3RpeON9zdvX4cZECaMntfRNO8LcmWEh/AOvl2ravis
9J9OAwfFA4jLvDKxLKZXhOY7J5GmOOwKlUjL4kTZ8o8UwuYw9jj5T6/wcNHw/6GY
AXgor7BxFCQA2nKVeKM+Lnna+fDaSny2tJX+i8pGytGIn/k2D5Lx4SJN1/6hlagh
m8Z4iO5PkSno4lTHZOGgxftEJxBXQwSkAYJq55XDTMCyX8OknJ4FoAmS/pl3vfjc
BeS3aThm/vaUVNkWQOfcKJNhlYtdPwROudkzLn4xzSZ6DuzovAF6qRh8pZD2JQRn
oZLvBILrECm2u0DzXy+1xWr+BLOvy1zvd1uC2odArUenriTx5Gx/OPjESSAk3R1H
zUzyRG+afCmzeC0Kf/yW/JOp/xUOP6HqA7XAt9qPb69dq+3vKTaURkEIP5R8SVy/
7R6KJh3zaBrK3IKJ9TIKFAYnQvV5e72prvxOvRoV0L1NFxhgpIsHZ18IZkHZG5pw
XBMzCcVDtPFiCWbhQgxV/YA0lz8x8pwvAfzQqvcNvC2jju1h7OtLwVV9oWwZiQWJ
X5ppOQDwkKgrpkpJXSLCcziNIzbazMsB7wYLlBlr89X5Uve3+BEwmE8A34Y0f+MK
ghvLdnc6c4UCIsLgvHNx6NJ/OR4BxwkAnaR8BSnpLKkS11v0UCp7Kh71q2u4XzGK
ImX+PmX2vwbdolPCQZq7L7LvigVRZpJC9eG1ouJlLXYAvVaijEXgurbwpFS/noFX
uba2ivjwMHibvnpS19fd91+H1ggz7kEy14yuvDNJC1lLCGu0+/PPRWD+MycMT2ol
Uggs/I/7Ia6gP54oab+JJwcmT7Wt/R28Xp1gSOuDW3oWxIZu9JKOI8yFnPE1YN+O
GU8xG00kq50TtyNRZyCBKcYYlFEucCgZ1ouXVcqrSuaCPwlZaAw3gKjMhPiHTwNm
H7lwH4PKcA1dM5h/wiPPf+MEbY+FSqfYHs8MiM24UBAmOpWpnX/p/ahmqCeZRu92
KZu5qtSU2LL4HtwhzSGl/0OjrcyOICgLZQkmibB5OTVeyKutHBy+ompVM7OSeLRM
YkJRgvr4f8SNlTmTIBS0hQ7fNN+ecPtCNdnRz7jCJCEVcQPvkKu6kmm26TuSUJTS
d1SLs/ulTrk2WXon5HLSAyIqi9+0/JUs9vM/9JRo9Iq9rfuPA4dOdb8Y91makfZq
uIqUJFsg5L2IpySIrztuytw6qzrbVPr+VjhoXw2ky6SrEqhJV56C8x7VwnnWCcwc
/mwJg3cVNWJE94PermcOg85c9/0qlNLHp8LTmyFseEDmLE7ksc4TlkM+j2QKhdgg
pe2L8X6yrG+zVZJMUi6gzqBKGjI+C27PnU99NgeE3mzuNzNcQOkLZQc08xse+Hpa
hjjCjOkXlWdolTq9XtE7QM+f3YT14ppUPuw9i/lT7t7TGKKCZxC9BK7EHECrpvYn
TRFZzaYDHmZFjn/EKcsW462/ZcV9W9m+ouWaiqbM4/8pdhoIQs1bxwvcPwzqnD7E
dyj2lqwniPNAtPoBkmmnH9AsBE5eT5Zy7ZrYWguCsFi926PUsy1kmcSZikYw0ep0
apvLK703NBe0Z3Etqo/oFuvovUQEVz3ylN8W+xci+TFoLgnrLv2PhUnzVc+mztzV
fKQnGQ4jXlEBLQ6jmcKfvT74GU0Wgk2EVGrwHMNG4RMBeeDEqD13LwJA9/h66typ
NvouY7v98KaxQciQ8tCGs09FXCvDUKJ9cQ9Of2+8tXqKwv1yq7KLVwOe/sEKK/t7
cSV2NARHOGgPMKkq270LdUF4zp71PEkmQJ3ZjK4rFb1emSi6uT1B79yb/QW6QQNt
lGYHbgX/sbr2bjncX67DmhVkmSBWigLFIYRp/3f7gEhPmgQJ9QLjJsJp1sqcgggj
h1yiXeMXY2K3tyKAlq/9xxWYiwPkXlBKg8C/UXZNaUbas5t7BQCim9IzvpAg7gmL
eSL9zHZIxsYlQmDv7VE+sIZrYxtZmWmwCkCCTs+/z354yZRdLtU78I1Psw+2umTf
4XE7dkquK3+sp9cy7BS7p+e7CmMc08e4kU3vfxtw8k9nZqXkXziXUOaHDXk0hpgW
McJmINZtRpshCCqfCrwFrDmsty7GeRniZebzwi5Lfu9LJPoEAFmjhdAIxCkLh3/i
RtOh6W5acruP2Cvht5/Ov5E+hHMoG8DtoXGy8HJcX1j3bmNTZ94R2095EG/NwBcC
UKuIZ27EA5QOoYZGoszv6VEztJr/STiLd+SCLQye2CiyKddjhURhepEthvTPK+wD
xBJKljJSJcMAYpSzRWgFoVoAY0sESdj+Ug8o6bOae3l2e4lkmqAczpEG6CHGj/o7
S3+4YhGIcDlkHYAXwQkZevNqigPJb7o9kHFIGlBWKXxeOn3FBh/iFAEAJwleeD7P
G6C0jvOhK19P6DTweCwatNTvc7Wp+ma3ugCQNRIaYcyggJdjiV5vbGdvLnMQLSre
UO4IyDFpckHNwXjPfqoaLSjPcg/e9S/t0wl3gn1oAQSwArfiTyBcpiKzsYaCTS3P
5dsf5qPQHYdLI6ZzO4X9Og0wsj3dFmo4gYNllF6Z2bSEMTqulvLZc44CORT34OVx
WcHcezQUQUDW8Kf+oV6miHoZUUPlbJaeTesF2+lbL4AU0+JQIaOrLZcH5DyBQGql
8iY2jFnnE50bFrTy6NE8U8nsjY5x45hwQOzEyai+7sJ2lUcX3ID4W66nes/tEVDz
WW5ibwe0G2mhLhafXjZm0CnwbUt1Yz8O1bATlKgTUTQevkCLOPvTYTshOfjbxz/7
OyaCYsIBzC5F3heyKPkRcpb2XWDR1HNRglJH95PhmNCIUSFCpAhfs7B1qqVQdSKg
tZaif6juiFsMkrrBiWftVY4/AQwxNMy5RCI/ODpVoD1mJw9QWmBTrFQkc0aArWBD
GTvVRAi30Kjnyr4Pr0vBm2M2Ydmyc6km3Jnai+ts735WZUy+0BxxglYPnYGEA4Ko
3c/64eu/Gz3QhYKJ7/7GZre/M/dIJZ/s+Ge1yE+kYWopKoJDf5O1jt5SmLWA0nPl
BVCn5C7+z/8a/83+kpflJcMtEB/Fz5dngQ6HTFdmzEI/SBztMwV+tlnoMx1lqc9M
2C23PvSufWrkXiFlSfF6M5ipuOoGFIwg62Mrwt135tp4mCh5Aegh3hYwBPBFlX2O
WslFum6IGT7TxiIiLIT1L63rySXce8uV4H7auTr/AliA+gLGAXHSG0hCIBKz9X7c
+pP/XYb4Baj9LL+/j5GRYSEqIa8rHWRk0Kpma2UIQzaCrUpxWxgVTde3uQ+MVIxL
GsYT5nAo6DAM4yDlWoI6Xv/LD32GZqSS147XwtMQ5vfBug6e77MwDWXhIqgT4/s1
bfuaQn2DfxKDVfecLFu/pqASJVduTAqVU/qNRNDfaIICNUgq/xLKVjbI2BT4xfHl
5NOrU2Lg91k0Ds520gQDA6krDpA0EUEaD6tnhE1ZWN+q/z0tC+tG1VI79n1fGQ85
DRADn4KHYH/OzFIE53kjnJpc6262lS19gvuqP0iKxGEw1nUgLJ+j9DA8iGKze6TZ
3X39HjpBR9Zfa0fRpxtwtIgtrgnQOoJLziAN0+vkWWw+tNJ/QdKzbLk7OSgdnbYL
Ho1S9kYbtPSaNj/4tLJG82/9+U00XHJSVSMMl9XzOieuY41Zy6ti1O76ldsO2K43
EXFzfAtiuUVMxDELjr5VGZy0gVldaR2Cb+9s3GgqPE+T//UxwpaSSJlPiqrRMUC4
Iz98KKOkAoZXaOsuW91TU7BZg6eUkQMU4+I5M1buT1dETUbfSxezLL56y+S6L1vY
o04JKWv9dxGmOAnFE0An5FpGOLEcwAlY4VS/s2qwWnhfqIrIE2iqVr76g7MPRoMR
4StfVi4Uzywn46zMmBB2D0AS1sR/c+oXLlskqnpKLO3I7xxXL/89jNSFLJ7at9hU
WMnL1Tzg4DNwpcgYPlGbWB3/FwwkV7CLAuy/D0Gtk80meRj/AF+m5eXyStChVFdK
JEi0KWZoII4H3KfkwAVuNKGBvAhsQ1Zu4jbNgnv1/+iBcC4WlyAKaTtprt/pjlwG
91Z5ZX5J7CM/toNDCvzN0dsMt7BbmSZ+afRGE4ARhuwtRMNn1r3oPeBdtEWaq9Vh
sGkJjRDYcj4TY1SVoSIkid0VmG6iwx3Y8hMRAKcKxeTz0znSmB1KRNCex51pqjA9
Wv9RtWFsOJzn7MFQHc8TIgLG4RkM3FiOxodmKyBRaLNqwWh3MZ/pxzDF4nqizR8u
uoZUWDnMaXFrHppJwOI6v0OillQ3QpguxI7JPAj5ytyHfIKVGK9HiirM6KwDz8Tu
9d/Ig1DPaoO+qJn+Tao2x4xVJuhWUeHgbn9WaMQUHa9HIgMO13CT8F0ERZi7s0Oh
+O/UahzX5Ji4PdkTtSLXybLbGKvoeUuMmQfmuMYWlbW7ckgZ4J4ptOe60pq+Iwzp
RHhEbpCQ5qZ1m/t9mgrth/e+Ox93HUpyo0OyOMudPJtZS+o3ufosCnOgrZ+twfb3
0y/BrWVe/h63CQpI07896d6LxOw/2JHjLvaJVFUTxHieXhXpf8lwjUoHxe4EzNB5
IS+bFk+Fm4ZWKeZbkUvAkukw+8EHLcH2zpifLYHrSGBbBnVg3Mo/IcRvjx/K4Lf2
9Ar2VgP0LjnDyhwQPkvck8GUkvZwdpo219hekwa5KjxtsGpcxunbW7M5qICUpZFo
CU6WXGlT1DJyNsM3Qv7jeSfje+nnUNl0f64m1hbHcPAbSgWJ+PheZywGjL9QZ7Da
yHv1eZZH3a2josFU4LKLDMyFKrHeoRf6fHMAj3u8Ao5zlLzLex++1zBAW9P0nDK4
dsp8w/K8WAHE/xmEfJNTSoYxaWuMd/7ss5BQn9F182QR/zbG7EExsFfc7G4Vjapz
1bD0E+E675+aEhNdWKzPZRIcBIkrHPIK+9oQCU56Tc/oL4fKDjUrG2ZoL6wrXhmW
GpNrOi45b4zLzVB9lPp73FTJf83I2rbAdKhLWBiq1lBX4HhI6CRGAoHwT41Ql53S
3o0uOsNh4afxB3q+BaA0gqI1sZ7g5N1mvEm9lgUk8vNv4kPMJoBhZkoWA5DwUqqK
vYfNwTrhLCh8wDyflSu89drQc3hFvsbISgw7yGkQPnVMr8ptO6wWFqLtNq/xpgg4
N6oLDC2wmb6rmZ5kFJCXfSo7GyJ2k2xvwwWVUBlXpp/xp16FHYkxXF5aBdG7tNu/
dstwENtIk3snM+vZYlZIlhxbOZtt81xwdht273iI5iabJj2u5OBJCLX2sMc3dctS
sdlVBLKBZXJA9cfIGAAWgofvh9bspS+AB8H+43UFgRtzrXqmC1QAZB/MyOe4dunk
dVOyDt+FCVd8X9Z2J0Rkdqz5Wrk7PC3tgIM59M/tdpIAzSPuNvouJ6UhEFc/5s7y
bCoClJxm40dAmOhhZfjRy2hhywsBr9xn9tmhBjBhqSPprw0fkdE3aOda+BtgakR6
FAXmQllRYAwwkSqwB/SxmoeymH/d2mE5xVVwqqkV3UBM+9Ux3vy9oQ41r6968M7a
af6Bs4XdJ5jaO2RxGRgscaH4Jdzz9L+UZg3T4NA7GHJYTSX+qK+tb4gt/uE+Leib
cz2NQqWG9d5CuisJ7cMbYeO42665Qgvs3mfRKe2EyQJaTJssz4gJSxZsPPL3AbQP
EVB84qbQ/s7rLYSdZogu9udpw9t5069unp7j0TGOdTMrBI3ULX4SHvTQ/HtaP/J9
JPHxRPKfzIFBXAyN3R0trUur4MclpPlM2tMOSoFPCCmqKy8Qufmn28BPHF6WPNol
Vh2bxdzJonn3EtEHnmem0I9RfPigEwkPJ1NC9Z9S44jo11biATvWQM0QcJqvhYNn
brFy7hBLlhjWWNpbHyAmDeJ5kMt/690BA51tUz5nB2dNJpQDyk9+pdPq/oGxDRCe
MUakIWcq82ThG9G7LBUg7SuSHKrli/J5Y+5hdDxm0n3M+Nlbp5/hv0127tKjpE6d
xqwn/CnvyLfhEWvJ3hAGBzKI2HVx4N8wfdPxdDbLISM8CxZQqqLc6p5odB1ru6Py
59DFAJE19G023h7KJhGuh33+U+zAM3gJnd8pQkpmlEVhdwUJC4fk70dEKnkEQ4o4
hu0WLXomzOvqqsEyoifAPA5Dbktx1acScEwpiD9MCbob24g2dakSYk6SRhEpQlzH
9csCgwgbtuTc2bKHixvl5HuOTOJ5/0v/Iv8OxN+s4MHYRMd4jeb9qljUzKFARWOi
y3+DLCzY13+nVY3g59m6BpVFzOLRgsvzUbnlfQLNVOXCxBb+kltQvI7rSOwKetvc
gNP6yNf4x+e9xdqMBul4Ny+N25swc/BkFd0jaRnw9fSfILiIhvOtLv4K1BCZrpxG
ct21qvgtX7J4GwO8t9yqDabl/6WbeGbSAscXAtOFpWCPoYeL6LjPvcBbh19IReXZ
Qi7Pr9f05hKMR1kVXhdFwBMa1MWgYNGV1jkLRQkyHJFQivEEcxfAOsEW/GuN7U9n
yaaRgTYnFcqEuG0A6qOtxxA8PCBiGbvaFJwcgABQDJ1N+cw7ITptmvug2PhgGvbH
z9KNl8rzZ/1mJuDzD5rciJlo2LOgHm4fUm4cumjIhnzykuONwvu8+aNVMmpRtt8k
umbZHeKXRpGzy5rbIW7P6PqYMp+kIiPL9hbigeIz759KSsbhZ08OqJ6ztdoCBNz5
WE2bs1ywtdCEAZ1Nj/8r1dnH5OKLEQawFDG7ye8qdnsXvuBo5cmQlD9Y9Y7IG/aG
pQ7hUtDNgQsX4dyndXtyyBAfm4srFuHLscdauJz3evHThzoqNJcQEE9mCWCQ/KTM
R+OZh7YbNFoBCDO3QvM1lRTTwj+LIhDGyYTJU+cwtfauZeF47IDsaJpkZUM2XSAX
PuUGhw9ucasm29lnsE+A+I5DhY5MHeKzCulNQPorIlOJ7eFitrBb2RfrYar5odwT
nAs6ZSWNLY52IpDfPxg4mrrTGFc/20XhRXFXg5qfxnlMpCWXmcSdLwlphLRCB8h1
SNwD6rW4BxVYA1fCQL9k7+x+saFX9HMcqNfxKYrAt9EbqFw3OaHLdingKbHw/zE5
7N29j3duWMcrDNYyFXKtGVCuTEsn7Pqctpoo+zzOf4wP+F0kLzMA+QH+ccQVRVw+
OJ9yAoUXOGnPdoB0bP3Htc1PNHySxgPtkc/vUF0UWuR8ER27xqktqTkSP9bFDjJO
R5diRewpZ1zzB0Bdy2mjZ57nnN56psUZgoP//Ip7JmawtUsiYOxmQxZv1jJ2aP1s
UfNQisAfpmDG9SmomWwfZD3waqFScbuVG2sPatykbmZfW4Q99SBglEN1e6XQiewX
YdVxOOCb3R+y6k+RcpgCo7myJY4Ew87bHqXlttQZ2bEPnyvVI+1E7X9tjiWC/VsJ
rEUx0NxaFOzQxYKrWS3nSWRmp1UZIzzdCqH+rjMyqVt4VNusf+TbqdIxvYkQ+0hU
nOfmojbernbbOR7y/G0BB5OIAYwHmsxLkQjA6VDOD7fZyDseeZVU8KoSrPw/faTm
jpQgemhcumgk/JqZVM/CuHMb9EfFI9rC4x6fLTsVu13IcsRKi9HW2I0Lrf/h4VQr
xI4Dm9VEM70ykPKRRgvHFN5DKWdAzafXDq787isxX/qjXey99/cD1vp3sAlfEWkR
rWxXQRnkB3gJStLhTnha8QihCMwdNrPSUOhwqSo8F5is4sLEDLPkA87f+u/cjpi9
0WtKFISt85hEcjlYtbZKuH9U8wtbxi9bTPYnb6+rPkAJGBzfEG6/gJ0mWCssH7UC
4gBv7BOmAmRgn2EHOTGbVhhUUhDil0/XStZjQ6NCYkiqHimbK5sTCQlLVt/jIugl
+Q77dXOBl36dQR7kr0kxgUJUgGOLR0K3F2IBQTyK0r73Af51DR6T78eXbRE/FdRC
29GiBQra14g5FK8v3Cjar37bi6yus1+urVfC2cTmHh7fos4+j5xpTKXiuZc5D6OI
mDjr/kA+xUOdHGE5iM3cUbBmnih5ht2c0ZfEW948vYshQF50je3ASy6gSyd87dER
GCSxwlnJkL8jnH1VWbXMqXVYhDbhjUo3XbFcT6WxKWrMMD9Atmi8UUusXMaMjNDX
6E5/hSMXqhjgOV7DXrZOMhGJXcWUS0CB0l+8EbxwWu9Tu7s6/I6TZ2TVm3SGsxtM
QQW9Nwj7tyddAidDDCViqPxVDKYth2c+rp+q8vjR7ussrBhKODxF9k7v89KuBNs8
pk4BT2vsR1sLp9wMC82ZJXC7T93uqIRNHXpo9B3hWGz7Q0z3sD/huqTMAdzh287J
w38fy13I8J/rk/MTvFHvXk2KHnSWArcrwvk5oVPwc5Up+fXhzsr4WOR1y+FiY1F3
7Dh4k9hbJzBNOTD6k/xv+5TV4v5KxmQF+JmgRsn/CxkqZ8xVL9msZL6UyYOGx2In
ceOITqEFesqASLc6EETKBNEgaRQI0UwFQqgWWW5H8Ypmp5Y/o9pYZCAtVmB9uphR
OTgBuk17J0conZ84qa7wqgvuuMJxFp3ta2pP42JPqNi861RTGpt6xMzxcyzzr8to
wNa8iyQMax8//xx1bT2It2XZY4NnKLC3eJOFbUMNpRQmoJ86Se6pA+4cKrlnM2aP
48G4BN7ejFxgIFJTskIlLshKXfvlkuLsFCbs95nXjcyPVaNGOt+geV+V8aK3qnfW
e0bvluRnN36up6QoQUo6fntfmTCmBwQVf9XEqdYOUb7/P5zBlopthIk/ivrDB7go
WqlZ5Ftpz2IuwrRO0brc4+Jlm248MecMTheEioP4tsV3hhwNJucSF1uKg1N+cMKg
dqHOofXR1PhwJjAmVp4YLT3KtiHUdu0u8rip1wMCijdiOV2rpQA9/QgEFzuu8snU
BdTWuYFOLAat3AMOVkFQOmI5LDqKImtvnuOneis8HP1J6eWWpfe9k0ciFRcJ5s26
ae4deHpv+yBBCCH32OhJjf/2FfgoYfhN1MrlMP9SsUw0W4RNr9IxJSjnURhMefgR
+rOs6XEESzBAbKVyr3+AT1DLZ34TWZ497JurXz52O3uCyOymRlaOJCOsQjr2qHRT
un1d3yMI7ygm/E4GqBgn88PEJ65Ci6NPQIWNGpOUUixgBrUqLtobjdtPAJKB2lVc
h6a3uMZNwRPPcLsgLL+Xlj9AoikCgprX37n1el0KRnTnk+Rhx/NO0rSZC0rstU52
9wYNtYWautZbF0aCPl1dWfB5SJt/htbiXxUW/TOD7/QKZVO8LRy7TOYfL4Km6115
wrfxhri2+sU5sK/MzZDSmdGW1+hUJwddu8f/ehU6bTtrGyawn8o5uUIuX7RiiebP
yVBZ0U4O+972LvnsiovQ4Rn+krAFk5TRjmDKVrbSeHrYS01XbKdmNMy+1zYnca2v
3We2Cym/P4xI9/cJDW1/p33PtQDU1JPW1IszsnulCdd5JHbeeTAQ7L2B2bycaD7D
yKSk9e+WLPP8se2+XNh5iGhZOYuzjemqGCo4OVUx9EnSjlAybrTwKFzWdzcsSztl
c13xE3eiTogx/AVYJKnqml0vsVx0dA+qiWVWHzAxn7Kzya2unJiPNx0YYBWcysZC
VUNwezmtwieeA3M7QmrdjQ3/5PM2MAcEx4Fg2q+XfgYwkXhZXdpXMEmojd2qZTBL
ksMYwO7eHhTIqrIY90iP/B8KlQ9zfzY8+M+YIkAlCTmY9r4TKDDthpOIRZ6Rvz++
XCbCMnJrOYflMCJIHBU9cHbWNQJH1f7bgeVovBWGEXuUyL90cAlz6e4sqEfB3mmj
U6haMo9M8R8t9BMj7pO+4VSv9Pvfhvsr0E2iwfzEqD7sITPGiYE+ts4qOpjx8HFM
7/NJNtoR2IG8TQRrWI57hX1Lae1x8aYSpA8MEB7uSmxOhieVuZebKzxBSNAf5fJE
0uTPb029B8KGe1OEAekqBwOalAc+x/ZCf+kVD7/aLbPYWwCVKk9iqbZjuGSyLNxl
MCaak2NG67plUY6IUkF0l5NnVcwb7V50Xm++43fuBuk6EUJVgjPiv7WCNb1M4gaW
oazf+oXQx6/p/3oJDjEE54TbgQZTQVaAXhViWzpC/u8ARG8MW9aIWhMpWPcpUZ3k
hHSY1fA/cYc27bIxCzRHAogQHj23eKg8xhPaXEBuZ8dvQpbahvGxlG6Ee6fo+fkO
AAPqRbMk9bw9i8qPWgIXyNhNlL+XEWqaHETH0VUew2Hu7qjnvmDBEfo6Zf15mm0M
h16EjDrtS1JjXsYsdHI47JWBJbPPPRKBrR0P8PEyX0mzb4qBfQMck9+qb+X2v7vy
Us5osxdnswpesthekVLutsrYL2oSPDNfm2nyYiiGLZyp7KYLLpywuuge7GK4eKRH
8Zdl/Y13VpOTvL/KnrZ04cTyB1Tv/SG+cumdHb0y/Rpz9E7Poaiqi8UndEZY76O+
IG70Tl8dIczbAFjC04qvJv8RBVliPn5wS/QonlTAG3m54ltUBZb0muR8MC8hnisl
k+zkPghXdOlH1LXYXEjM/CQYv99/iwMNlQkrE3FyOYQSS1CDutnsv8litZ0NlG/+
+zvM6YPaEIWgczb2MifkO26oQdeKBPyhOKtK1kf79VRGkytAB1mkpZjw33iZcxK1
T00JpY8c9XLaErWdY5rNFGJ1nagJlDQ7OvoAca599j5MKnm5pLZnNAEOC7oFOegm
yleWClUA8LIXeykuKN5F/nImE4JsdS/SVpq5ozruz6lNsY0stHr9itdyy+JIvfGD
qVNDRUbevZk+L/rMcyALDsann3x9qT26dIf8XzdkRwwj/cHiC/gD2MZ9aueojk0d
hSfsSxs4a2XpVM236iI6Gp+DF0BjABa0ujJCwurplTRH6yQKYxbQq1AoxNlLoI4R
8csf7lZcPRhshgUu0eiRFUX4da6ZeFO1RWiPDOgOQzSdW/2jnxag53krsF1vKB7z
xXsXZGPrxAz2OXuFRgbtLb349c383RD+MYfs3bNlQcWOo7WGvpl3lxSXHxCh4ItD
gg6MlUjxZ02L/8cfH7I4VQc9DbM2z9i1dZ+sKc9EWLwyrX+2mgfANXl6+9OrKCxQ
Eo5+QGdFKzWQQVKqNgx+NpR6f7E5djzgHAmdv5yV1vaALQcETKDYO1GP39CU9YSU
flzXIpRyVl8pSBNgAIWYXuf3kOxEEiQKet13w0gV9PygcjRmrEYiohtQVNez5hXA
8dUZLhYkP6VZbm9AVBMi8/JpllRAm8j8IrMif86FXF2ag5mPEQ7DhglsLMP6KUAd
Zxf22M0yZx/nrL+eY/tBJ4UipVsCfc+UeWrHioLVjcrZ5anP6cyVqqNLyKi2b48/
Vj5OGMStj3UDKkPjwdJiBUULQHCf26DyMZZNbJguwdrY4CaD9cKovy0MW0LdyuDI
cIrOQybU0weIFzbzID2B+9me7qJs8VZcIzgdrJO4LuHMsKaL04zsjSFyQ+3GSRxj
5xZ33AW4tC+AdZXWdbz/IGveOd5nPRAFQcszSlGRD8rPqnW+Ad74C5QZxYD29HCn
RZ3C5lW3/m6qcJwKS9yPdRo5nkqgy5WKxPnNh97GgdKdPQOsAJY7/Y5Lrk1vsBu6
ztpDXIsdTOhBUk7GMc9hmC64RlHf4E0aCYQZL9Ah24Nd2bml0Sm3s2FSERD8d+La
1wBzqEs+pIURJJ0Ren/ocNlf5lbwP0u5gstBL6Zm7NiXNC+I2W3N0nuq1Mch6yRj
ENQbnUNyctoYdHFt8upvGB3SofHGaVNSDyc98XMMxxISnE7hnnUeo3dGcqZiHCoN
g/C/CA7W/LTkMSPra4BBqReFrs1QpoHHhsCeg7XU6HBU3Tmrb1jrZHBbtvXfgqoq
0X9dUqKNC9Lq8Pq6X2Wk72xhXvD/6peegNh/2V+a/4e18I8ryqdNLYeIxQzoxKl/
WuZT1bmEcDGTkJLIpw7GSCUVgtJH/A2WaW3OjHJhXA93iQNm0cMW/peow6lmKkS7
bvu1cyH0TDm7ZZ0EJrs5pIy7sSlEGB9vDWHwfnrjTS+19O3fZUDtyqYBSlz07u+A
gKPeo+zeb0B38gbpWfISsdPcCldpJDDmKhbtlr20c68Zai/6OdU8cbsoNM3JBQP4
q2eT28qqGtYGJGCN4xgBwJqo80XTNsPhIZ3mcIeajhhd5rduf50XMiUD29XKlGFZ
7QWy9tGSEsqI3qaRSN0R0o3EMCE9U7aE7lWoh1fhHIJ637MuNZVG5Ppmwbtgudxr
ZFytjHNRIU8IQUiwF2TmU+RTpC/t5dvzHXsf1ro+Te1HjwcGxmZVjZ2CfHf3Xh+e
Aj+dOtG3Yo1Nql7uVZO+4EyupuG1r3lxK3EnUj9e0Zd8YegRLjbHFcAueSb+5fPA
YgxGmQ6G7e2Aku3k+0DGDJn1hcdLAJkIX/4YZrBjDXdhlk7K6wnrOM/iU+WFxHB9
vri9B1VK1AgdiekcuQ/7LkPVaGPD8plE+Y/o2z+hZYqVlPBRtmIjaOm4TTE/PkFS
75kFtQ/j6g1vaAYJ0Y1vbAcb1hf5lmuUQeX0JhR71gt+X8te3/eVSoAwygq9kXW0
pppnA1nzyUk7Q2IRViRq1fomiutfW7W+VShukyfNH/2gFA1g6sAvnTJAYRja3KqN
Ro5MfOJntU09ARr5OuCsQytbSUx4AWcJAdt65Y0XXROleQQ8uYYsLIzJucLbPNbK
AFW/H1xIQRcO3Nw/6Zbwl2q0sAj1h6aQDH9kEpDqXejUu1izVsxlvEbc3x32HVbE
shhO0fvjyQJ06E5Zov0MA2OyaTEWJ6dDwcmQ/VfpUZ+qavMbm56nRFL2gwqwOkr2
7scJNQBSfOrWm0jODd/0+bDVwd8JMNjRJEgvGqVDQWHZtqgh0GgUjBvq5gUWFGHQ
BMItodeqHKIsMDlZy0ovPTEMUBmULFU3gAylW1fdv5p74iXX6shAsg2VenDNoJNm
L1pIuQYxkmbqbV7EGz2nopUz4YxPHyssEeFwITDdDV50bbkDykBrIOPcIjtCvvOo
abnVEB1ukL1JejtleX8YR8QN0aVQYlJ3EaYArJ3KfBxpEsQLbgIvYuDQAx6G8yX2
bSh5iL3kivDoR2mXfVsEyI8O01+vt4upvYd86uDGF/Y3/C6wppa1jPuHn1EB6cT2
9WN2lazQQY+tI6GAiBsh9Rt/0Y6IPkHmz4fKQPaEo+IbUStsM/4LFzJXReneeLZY
8CYbRvg/JcRhdCgYLS9UWVdtOt+iYebmvMzNltrjcVF5C1gu1GvweR01rSsyo/VS
ITQweq3XK/Ja3iVTRhJ2Hrk+6zj40yYxBVHlX+TfMvCblT/AboowwjUQJIjJq5qk
BqBzBzKsq1QNkbwzLHV6E2y9sH10gtDUSX0RvCdGmqxcFsqzPYffi2SUBooArgFz
fm4iFjD70x9Kb8WstilNs3Caa0ke+9M8HWpumzJvkWj9aKFFL5Hc0CCjE0lL5vU+
dMJ8dLf9B2xtPopnjgxdLvVb1hKIx8G2SNdGZfKZ8bWaWMin8k029Pyw2Z43POLZ
wnEy/q/Fmq55nISFZxWo+gt5H+Xcncvg1OaTy+0OCse9GcTQXvoQ7jPoDeD6Ug/e
DX4TibjpZe6eUsnjywsmaKgoXe7XTBBQTmrqr2PkQIbUrLaNFsClSXG9iCA0tCTB
NL4YJ/dVChneYBuleXQACB5+LwOJiV88djsOsGIz86Y66ZBX1EQJknL10qhiYRa+
FR2qlKb+X3SxKQiHK2JZLZZsnYbEzwSypwvRqtHdgvIejFX93v4X73NH/Dy9iaRb
IOdgZGQ1vc8D2oxvFrHVeVg2Rmn3ZQG4iE5Syd+6ekVCSOR96rlJddo92sXqalGh
bQh0IIyw4QZHKdGzEi5PTu5h5HHdhfWCdoS4S3P9dr90mbK8igi3AHupz8INrXco
IsmkB6KyhG8r8ZSJmJN9hTjUSgmsE0qUel9fVpauFFfYAsuU8m6yrgonTKJdCeOo
jPDyL+L1hymlmLJBTZiES5HDDPia2MandEiJiDDhDfogyqf/pVht2dk8AKlBJ5Zp
eL9qCA8BrsyvKOClz4hQ3olm7WPYd/3tJqKaFXupEBoUOK9oKi4XMtTfrToYw9X1
SAAr4BFbIyFX57Vdh6hMoqejobui+NfQPF+CAREEAL6AcAunxfVSEZVWa/GO+MQ8
gRzxPpYM8VQF2dVRnMbWyki3EH+i4vkxdFc5HXdbKU2amsVwFS5jBZo9gC+AJQL5
84UY4MWdcBGUA7b5x8SITPXekUYRNV0MCCz/hGXknnhJjB9sInJGZWtADqHnY+TF
nQhS+s8F97gzqhMC77tqDNzEzAxC1yEg0habeBrxD3vQ0HkV99dFpYG/12QQSwi4
alF5Ra5H/lpLgX/BDvVz5QyIBSq+7IUbxMoTeos9sFGM1bH7enm81EPpgalUZFfb
zAvvziwE8R3hUeVxHWHyvC6X9RyHtrLxykTFlMKviF+psnar00UVtN41lDxReKHS
wV4cc1DGALnVAW/JX0WPItrykos1mdawjc/F/DhGY7UIJl3XbJ4ofH8+iTPIw6tU
T5bNqPj+ajCCUsGVTVyIwyfF9FNWPp9S4EDTbzZftYfSbAgRiGfTPZG7gcYEsi78
OKoRYgSgR6VVcJA+TxM0mTiR8uNxFEkDK2OdgMNvnNfDKOgkmRWwKFCVsBZLwYYT
vxMnBvYCB8rdbK8FwDa4NsyZjquLrlwze/zknSAiHfD71mFZEYduBB/KKKFlbT5z
bKBndoMLK3bfzZFYZW2rOK3/MQX6EyzqvRl4IRu3SXBKf0D578PIlBYXM4NMvs1i
gCfOt+F/iXHsZ+MFS08qCNGxYJvIz99UB8nMlYjGynjIEhhJHezfKUQ9U3YZPlB8
IbylF8Now4D0pK303qXgTCMInKbbNFUItov+t7eDCCd6374xUpD3/9OXs0y5/Bn2
2jwKyLukWDa8SLdQLijyfjswnmkyzZjCnS374KyxubmMGcII//TRL7ndFOoYscB9
BC7DVL9trBW9+EEoYrrqEUrLVpWgpdIJYymWvUBIhOLt6QWsSetnIXJccpWzS3bl
MGFergcEnnHi0l9PEeYEYjYMHfMl0ywzaNXvybTWlmrjVaTbl7EzHgxRzNtseQr2
m33+7jrNWyx90rtwysUbpWOY4JY2C9Ri8x4HKF/J0wW0zGru1vRxGFuDX3MSIzbW
es+fIlMi0/8erc0c2n6GPvAYYKidO0DSqklKVQUSk2aw4NcuWlSuY8BKE9FunL/F
5Sa4ujS1kSYuVTQsgeYs+MXlXEFnhILywYozY4o1iqR2ghFDJ+QIGsCEI4Cbw0eb
EOHJCTGxwse+0O7sDZr9jNsKOIIe6jFtEwk/iruAW2KZRr/5mpyrTEsd69BNe2wo
vuJRsBjdYwOSmmVmIQ0RFwHY7/YAZon/vdtsl+569K+beXNPnuzkEYXc9tacHdIL
ZFb1ZYTHnsFIdyNdzP/M2J+M922uh4Gfyrn/qLMdnOdZgC708cSAjo3j0w9wY7AL
OKFxevlLt2PQGC88d9mQtAIkhsRjKOvbLeokg9DS8sTPNH+dxH/rIPsBtxLHsTqM
iEUeWvRkj1jJttjNHLcB3mj/i5wQmkF05aQ94riPxMS+gmQb6z7kkw5uFLxeMpJG
+moqNcL28xCcG8PNCAHtbE13A0jiUHW9oFxuCABfjTK848Qyt9rlXixyI+rYr+PF
585Ux5oLTi2OiQb02voNNlCsiCZ3TVJZWhOgfQYG9zHJEGsKGW4wMZT6aoOIJ5jE
OXG5srlAXgORkbq19nn0RXxRzZOf1Aw4BGjXHXWILk1+xEw65bjIYwiK0ARQnhSR
rKOfnzxFUIFIOCLDeKHbQyguyiDqGrSLJtK2jb/ATJ50Pt6/OVWtsjoiJK8Lrr0K
qWR1UdSLoTHFtJRGjTnIcHhAymM/HutLJkcP0bLiG6IlGZ3IiYxYYc1fn0cpx4lx
B5PfDxdA5OJh9Sgs6hJOo8wW1o5YSRwUCkWDQIjT8NoJo50yQkaiN4zStGJPocyd
lFTnEbZLYmJkg2qXgrxSdeNzGZXvoLA4ZeqotPnk9W1Ay1RqFmbf/KvHAOUyYJBa
x/ZFxevRS7RbZU2mq0qAuEf87140HgJ2iNiYd4sigZK895834VGJSS0V7ZcDFxdC
d4jrrzsfMXvtjUiSWxtOLbRcHddCSoFEYz4COkrANtcHPLzc3xyFOLfyXX/QbiBE
8T0dlz1q7t+XsuJv4VOqxR8wZJx64PhkTwpsHk+flADnkLjzNmLJfIHLCiwO9t2L
T+PKRNwC0wznQbe2BWMQhvDX/abYdC2w2vzrLI4pUFzgSZ2R/sgMyHQJlR1+Blf0
XQo+yXvk5KZrWJ3K70StpNWJTlLP+vNUewGMOeH6m93XnvJAph06gMbg1UUC7AEa
5zgzHOEZ8IfP1cF8BgqAfjo5n2qPtFEr5ZnMMsjAs1rukN/PMqUMuTrgTx4vR3X7
cYQby5h2nE9P3DoXhGmCSs2Ynmz/TBimE8wejExHv4qPQxyHY3TpRTMWhTqnuGrJ
c0DbI2vGqGmvlrH2I+MdDXdLsePyvezfIhntLkhC/UVUkwRwWSKs62DgcfdXL91U
m3RNKcA0EJGns3T/Hag9AQIUgcWca1xStIgHJDx9WOYB9Bienl5zRafAIIO/U+pt
GA1EC63ywu2YJTW7B1yDnUbTJVCfxxNs2n9G5U60yYuxR7ICr9P5WRpNjA3+hvKA
3XXbi7RVbLt/0tKgaZkw/UpHclhcheviHszbjNx/TwSaM3aYTFxzaFwIw8IxgYCG
mxSiKSXI0KRzi5vTKNWpEggDlY7wy92J5DI3niaXS6mPS6cuguiFe9h/zU7HWYCw
jX2fl1w5sGCCJcpYMxoz9JnCRlsYciVELFuB1ezqN2UEQYsT6jsgMdGLu+6efN6Y
XPF9p6fPrf70RfnuB42X9bACcBQMBXVklASWY4fBoynby5H1or/7nFhv3Sr1yh9Y
XDZ5RtqQWkXUEqvWy2HjQu3jpIq1djJcCJBYoSEKDh+XFuPm+Ke0F+mX1nyyg4QT
EJQpb4JYsuUGT1al/HKgJ0R1XTib1Ed5/3atpTgzEhho5ADrja5ImDEC2tFYKRDY
By6Jxo9oAZm5JDMZZQBbv58r3s9lZ3W1G9fuk0FbUEtPxCjFyLLN0h1EsvKIBSMd
c5s0JaudoQDtvHbIywFu5y0TcQ9cgBBJgCTUBIwzxj+xsyyb1wfHU/HHz8dPIB7/
e46fosxekeUgZ56Jqw1oZ7+xgaxK8wVnpfPCPbRaNQZPYDCQ67HmSvgHTFQxdONK
VpJ6nLyjPez2ZZh0gxzyxe7MUFCWEzH7D7bSZt+00eg7dFiIHIIHIkZKWnj0fSwC
FXw9iuja/ZpL0J1g3IHcMksLfvT1K2hiUGhSKo0xQ8Ayer0w6n7sEFLMn/FMjmyL
AtQs1P0/a+ku2hovb+eg2xiUIdOUPwkSSn+jeKhNvbR/FYQV5TAk3gHPz2AsQmlh
nyLHkvijT9tREOzmfzULNEigfaBdQcz0c8iXURK060/16K0buP1wPTkxLv/0wJom
rBSALPsOsdjxdByoVtbIuZ9X8hSYeIfexNqWzzJVfXn+2CiLirWfvwiVD1D/WVsI
9AlA2JSLxG7OKvBXDN5CbY+J8pxdsNGW0wQ6e8Z3AdeqlXCXl+Dq+GOmE8zFIMrg
xy1K3kgNIKnOh87IJH1z7VToAeZRMCJehp6NnfvWaI+UZTmnh00UJM9/yFv1AoyS
niiwj/3uIxsTX27a6Wb/F5v5i+fkv/qnXL67FD3NIbmuhT3sWmlyw74kYolDOEIQ
jcLJlZ2EAOWxL9mEEzYxJVdQ4gEADWpwA4/cYqOg5i0V4ofp320uW5UP5fGHCsTh
aeYk5RfzbK6Xcqwu8UVAo/XSNhtJ5RT9AyircJE0k3mm3GVHEZVP3vaRXJxvO/JR
XP0QepO8iCXjfWQMeCUNQOmWLRn4xBtgEahaA4NgHVW1sVzViCCMpNBemQKvhV22
w2VGMXlnRG0rC0sRsJftsZtP3sg3WgAjoveS5K1IOfnY1KG1yHhTDRwmcQRlLRe5
SgYBbcVbnpTJw24atAVfUPtoiALJhLNaUlHXD1TL6lVUGQU3k82PfNNLGz5jyYW+
83sLa54pNIn52/yY4RqLDzxxXqX90L1nGt1nwzEY8XPRMR65p/oI1JDLuVCXJqfF
rSrr3oc2r1+5sBlXMhI+ZYIZ4xY5aLugUvmqhutB6Rwq0TwtmRGdY+6Ul/kKNnGO
12HlNC7yrb2v1ugFxCZOPnad3DNoTs0uUDopsOa4D43jRRDGnPALCUEEyaRbYmuX
kisprzVrESitxXcciupz3Q9gGFek8TS0fRIWWhesEZ+s+B71wIBlCpIPjd6usE93
+KEwubHmwAOQR76afhupyfVIcyXOCPvZQluUE4U22kiUFSjutRltBWTslSFvaeIv
WEWrQZ36QpWvV1X50CNAp1LHbBVzHvrIv+QVEJle56SvyjznPmuw/mCrrPbV0FwP
HsmxBoc1gBEXi+gIB9Zfz0szkwFGZ460k+4D2CJD0klZjMgMKI22LQkOwWOd4xu2
y4JnQlwSzO5ohJYJ23Oy3bqUIvY5Qpf8OaB5nd6aYGtlYwKkavb0YivUakFTJgmR
NoT11tJ8XwdMLs3/fBv9IKP0+86ump0dmgBmi+2Yla1msfvQsW9/ZfJwDfdgmKjX
yTKLeTNgWuPXlMiq/S7kf/IUerIlOza/qZVl2xdM6uO1HNOoz2RTxhAOBfHP7zB/
QiOdfofjT21Emc76k7oTpEXtOEjdvRppOqGaivYeBqI8AIKZRNH5k2AQBNVZ4cCr
Q1vm2/hy3Kf0pfi5VzXATWqViiDbCeFuUVpbYRkiQ97AfCk5Hg5g04DlGTkHO/KE
THH+Z8nZnVK0K9KrAXWBHndeSsHFEIFigrP4tqoVaU5HgHPW+LDC2rDN5wwN1qSK
vHY7lgA4E+5QtyjZLzSQkzO1L8PHA3b7zL7wenvRRLK2LM56pg0eW7gQcB7Oj0H6
FOHYpZix7lnLw4tk1daiT5RJbfBN7ZbQL20rZzAiI7SDVJlZ5FP225J7NvIDzPJZ
FHNxdWFJRhf0RcYsto61QHuNQZCqHVWyU5OCJaKpvsjWVPHwKrt4Mv5GFpJygcsq
dCdUr4G2l8Y99IxGS3ESUce3mKu49quXVoObOmgVxw6PUiXAekLOeF4MxmRP9WwY
CsbMMDoqiKEisU9ozid1VadIZ8OoLDO2Fldpudr9EpdqP+Wu7/P7rse8+wehalBC
RkTaYSSExHHY5kWk7Q7pS7//AQLnRtqtISyUqhl8DJ0a2mjdvJ/eWGBadc29BNC3
qV8FTbAsnrfs1wqdUt6cvA155kiXwnd2pmW4IwLQe9iEEbOwjHit++8Kf+zTbC/x
hf/vg0ZxHc3nYriA9s43U9KabShbI1kd3z9w9gfxdGP0+FmNca0GAV9xspRORW71
mQ0Sf/xAVsbjMhLOenoPKoLn3MM7/X19KVzvM2OXXmUvFxOGsqGhx1N7bCoW7qO5
MZE/OqzSr0hMsB4ZR6wtykjwuX/cQAuCDB8XKOc3LfpSVOOfpi4iZQqmFEFLhTzw
x9yRC089GNQnahqa2TsIJi8e89L9DkPKlnkXQ7VPDOMHNaNHRks1kTHn0iZRWhBs
p5UkOz5B/oKVJg2BCyb26gQjdVJ3w7BVEMvovGnYuhndohVbhLM4GtdpaCl8k7Hm
qILoYYHExiGMe+YUonGm17mqcGFrNjlzYKDorLn+Eb3FscQGMS++DuzPI6PoyHYL
HWOkfGQsGKuJ8lG+DmsL8AQPP7X3lhzmSm8HIaL+xe4a4efNWVr3keTnol3fYuya
9o2u0gJlICKBiTVt0slNFIp2w/CDnq8R/quQXU5sLRar8KuOMMCngrK0/PuShqxC
tWU/5uwS7/Hzva8F2aSs9i51rEeq4gvdpnLD2mykrp7ABiRHI5fpKUNUH3hOYC+M
ruwObaGSO7UhTk6ZyBaluzDUtTTEj/xutOMSvN//Z7Ypr9QT6cT4iSFpBF6RLQVE
ACNDAozT+uMp3kbQrRkZJDd7u5lLm4drarm3Ee13Z5RWS5QTNffoU3ApZHNwjDbl
YZZ3DfmIWrKUFqe6OlIU7Fgq3rkBaWhZ2UWtmDBqrGNBG5cRk0Z608+BRJden2BZ
WoCFVHqPB1L7rOBNCuLEJbr3qhAcC4uekw9zftko7d6eyaRKU6TEqSWIF9PwCYRf
5zBCkG2F1Ve3SMXDDvnEekgI0NkwdmH6t5nJtIECqWdpp25NHAjsq4M0Mxd7xUOu
ezcoq+eFlvzGuk00bjfiBrWUtqu09UfcVT78N8RwQXatpPtXAM82EUUj0JiPo2Hf
Smed9csPKatLXDNP93qD6LXVcvLPHN8stq+PllxTgmBhflT6KTwzqNU+2O6jbUQp
chPJT4dHKv5Pr7OnoWy1AcA4y3z94SYNDh1RZ+sLc5q1Z40/XFtISH11014tNWHV
6/BmIDhe30oQ/QI3G7xO3LzJSQsoQRwXC6bZlgLj5nQwaoOPbqUs96hbtf9nyx6c
Y7Howx1K+EQxsaJNzppHfrU3jYeLOyD+vyVS+wTZ33G5JvXOsuoAdq3+60GbhFH8
EXVT+APfXo9B3yBAsdrrHj6RAqVo8fBi8TCLr60anScea60jYdeHMYqlCrgxH/iK
iRrcjh3gxxAvbNza6hAeG2IA56rOSpSkrewWDI1rd219gA5vly7FhX8n0opNqO6P
+E5IxG8mvB6jlHDwdZBQwcW8/cWNo0VtqvIb3tQ6W538W9vWwLgLx7XdtZDjDKJD
SMG9hTYtb5Lwe4nGCjUjWK5hEUyfYUU2zu/XAKtb0WsRz2I+ncaJmj2+z/qK6jcj
JBdDbg69cecoJDdmSQC6+p9eDue9hndaucOnh5T87d8hIMyZDn/7K9b6mw9UVZRI
r77bpE0Ok/6xbuJm1dn6Sv1WhUrx8SEpZNKwfOQJy8q6R0a2W+1wa3Iw8PJMFvXG
31U8VurSURyMJvQymOrw4e+V3McAzJx/eHNVqzvkxaB5qEdiYxldUPWmFtFc18vw
1hE1tNbR0oT0a/Skpw8NM9gw26Xln9ln73TIcUDhFugGXQd8nXAVGaj2bgTq/pNa
pqjMpLEtNfuDUvJ/v4FXxz0gV2R4BwcL+imXKUyGcIKHbpJcSy4W+Q6y/PaARGdF
z7wt2ONovwS3ybIEhA3GJdwAtCWK21xXDI6WqB1G/LOjdLOg0FWgFBfvVBJcRXLt
3YFyFpVKNd0OB04PaMrp0QB9zxfBJ58TPLZlslKx0Hlqjx3Gtxaqz0ckHvQDsNY6
sG/4gPS8dKPIG0Cqxhfd7Zb9iMHqYDlNSxGPJ+Nvp+lpTdwlVaCtUvK56mZ4hS6o
Z3V/e4d0C2r81NnriYkjOGk1+xBOJq9NCPwIJ6zFZmQL9h1z29lU93JrY/ZcqLjG
YffFttLFN2KsaCxwbg93XdpiNg4WC9j8Y+Cpc6CDMZqe98KAlUSAfbrzyVdPabbS
OfCV3gitB2QALPTqrsEa3K6Cna5/TlU45PlRzXSBYmlpafpmsnQWaGZ4ElwXyE7D
doos36if5RDkaLV6GHsS0m584EiK+0eenkXF8EhN+jeQ/gGVHKVeO92/oD/agmTp
Q3mNayKjiZD1JdrNhLoj6POsq9FITsJD+enq85h4wO0O7R/JkkJ/VJaYGhK9IoEV
amTiqB6nBzK/e9i0WnM6XS6vy1eYmFqmOTciwlNwnjDODi7CvaUWOzqIL7c5KqR+
2ayFgJgh65Y3RomshohWvVE7bYNlhb3YrUiOQhnLyqUbGZ4IDCYDDh/sj+l0PE0m
O3zxcWXN3MZGGkjQJNxcQ3ub4mbQBjGTlyvg6pUKDuVRjnCRIJOgF4o+gGR45dDo
XHfIr9bBTKnJ1TTWCRgr1rsKkf4XP25PvaJvjOdIIiDYexAy0KN9x1gr//V3lq65
Y6GhOlVc1fSuzWM6YKf4rzCShhKFjVaMibVHNAE3kOUjZ9F3mp5zgQo4qwA+lKia
CKiy2zQw0TagkgRPHrldN6uFV/I8vqNlCF+uEpnivrORYe5gD4wGrF8UNwo52wuW
FirO5bhYMnmtSJwepgWcPGTs77ZCC8qnjRaMfuAqzzNKYVe+647ktermp/9RRrhy
UVxhN+YkBzUf585eObh6eMMs1T24PEc0k63uis71Z9e0OOZsP/vFt6fU4cng52RN
j0DDWwCiecgvtZQrvTHWc/d4Pi0ZmVQel4F8wU6il8IlIWNhlF57CsEM59fUidSn
kJGrAnHAvWgS1hk3LBDeOF5tiRpktpNpqxnZFxAikVeDvaCEymZOOubV4Thxd0Ew
nU4yuXOhAhAsFbIop6beay5zWn63jBUSe0R02gxHGbAeXiy0E5rUN43w27X3aQWo
1vb4Bl74+0JKSGtlb7euNiybYWcPu1zuT6m2+j3iG5JhPmbpCgLt4zOHv2EHPjTT
+zZ57Kb7UoRDqaykxwtcWmqqFuOeadBmF+cc9z3RdnmOu6CmnpYFFCz754cAZxbt
b0pJIxMV6Xu/yyJpMvgwJnKQ+L1lp93Mm8QHEq6+MeNh1PMAYDtadQtkhoI3sEVO
0QfwkyQR3Vcom6HthJjAlUuPmMExtl/ZuxGA35YavntBjBxKMtX256FzyRbM9BDQ
0IdX3Qit/BkO8FVkBdFAMJaEZcuHhjjoM88M9jba2pqejKTDxqr5G9vi1ENj/Gxk
0SJOIitA2KcASfp9GDEsKGJMANmCudfbZt1s+SSyafzT6yGNTCZPdzbfb/Evbftm
sVrUHOfYQXd1lZk+pZSbgtI8b6RcysRnMTuLLNuQPJyBiTG3M9GOl+VzoWYv8SHe
d/n//GQDFi8J07MG/wWx/Skk3EdJPT28y8uCYzmy6m8Aqu3WZ0HjZx/22mSuy8qv
NO2MkDCZ+MIb1wSpX99ltznf1cNOXajUjYmniMQEFRHR/0058V82YRahc0fk+YD9
ypzLxFGa0s9kPRfeRwfdRiZqLs5twSfo3wmDzU5PRjavQ8gJX0Cass9DWIYYtls5
URpKSz8pNFCB1uT9YJRko5Uppih0tCYeZnRCDPc53SZv2N1vyFKwTvg81RcKQFYT
ll1wFS/k6JYS8oh1Vhsu5KsMH9bLC9nn+FYM4qa73x+gj4YCyFMZkqp/wpbUbAnl
8GWoNe/D0mZUEcFBGBsDS6qH5MLKBZ8R1HtBh12eDn035uKoyFIu/L8FDMLFBcWh
LAJouRracSNkdWGvYHpQJvg7x8zmujIudM1gr4luVJDLro92XkM7XAYmG6hJUzbr
7If0ulXP6RFQkWEN8DeFPoZeR0Yb4cg0uvlPEtGb18EhWWndb/VgnBinIS713ozf
y7sMzCgBUyrp++kBjDqralIgUN1S5bVmSTPdbf099U9CeCymbC8RJkRq23KIIpHe
w8HRQYIsWWkdjkWlcqMNaWF3c2iMnvuIEFc7IzN02kFvU2ZjGdQgQK2zj4bHV3q9
93c6LeA/jXH5I6MS9cbvqmvxdG1pRXWr+fouey2aJcdB+Uq/feZQyriJVWicSksc
Td8e4RNYx/b4Ic5fgG9O9ALebPx0ZCc9ynm8VBgeGH2FeHy80A4OAXH8+1F1pipS
IMbFhwWw/Lpfp/YyoN0VwHopbpc/7eLpy34Ba40+R2jWht6d7ujwj9BAcYGtdKgv
yEPtgVijZ7b8gD+uXTBVDwaPw8H9c9vPrQXm35PZbVDD0+fIKmziBofZMuSyDJpb
uLaK5MsX5I/9RHOIwOZUrxTw88Yyx15uri8qGf+wjHruOhPIq5Jbeajtpjf4K0uY
TD167LR5kTRnRrtuaIZieV3GhzInjBF0NuXb91lH3AvBqEmHUukfJ8ca6AUCkwp2
i0RjypBQPVAloBoaCuWYkEJoly23WbRqB9u96PrfR+retXO5upu4dxTOFHPbkCgW
C9M0NoRnU+sk5au5HSz+30rFZDiAiUBp1QqXG8N3ljQVRBHPexLhABEWDexAb0u+
yDcTjLImKFFqWBgzso97lSjpiPeB04hSFDWH0F2jypmlrJP+44oCssSTk6iETSSY
uVaTx9TYHIrEZmLhT5/o2sThqosgwPhSNYcMeGBoTdhF6Rt//Vf3bgXa7G7ukZQx
xkL9GvfV4PuVm0eYQU+Cunxj7i7e8MkjYguyux0v3a+Pu9gpUqApgcOy4T1bPVKm
qIPuweKoP6OW9lVTARVDJI9NVdQ+D24XAvTJnOmufcILkkz8hQQbMz+JO/wvn/h+
mboLbjs2cz7aVn2FPSX4dStTM2y48FbXURpK2+fjM2x0tdXz0yjcra/koBY3pDZD
EdXzxRwVNtC0+gPhQBeIZJWWkMabtzhf6gJA6YrtzGh22jfiAAnIRWxNRuAgDB/n
hv0xpJZzP6Mn34+wNEE5L9222Y7XCj0pcDGck2jxYbdMIu/veh5MmlYyPtNfzaAh
epKuWNXLKOSkv7EjWhu2KFbyx0Qpg8lKyWrYti8AC4FonF6b1mIzNwlpnNF1hHev
OLk5PQOa7cTj18vlejraVBGMQ7rIQMqK7mjyhF/aidISPHFSYf8CmndXlTAz8R3a
bMSc14C8hzqF+4f36SE2XYbkFHoDxW5+zTz0AB1KeDOyY2ZgnuBeeuSIbV4Xl6M5
mf8xn0HujfMQTW7+YbVDUU7jhebqoGXsuhRdIjZhmcF/vK9X1AnPqB0/4BbeGE90
w7JjIPSxP4FcF0Xxs394zMUe69XYDG4ENXBnfHofe5T91BTAvxP7ouLKxS46sv00
xq7UN2UIS2YKkIS1UTwNUCNv8NNdTDzSvS3WZpefaLwZT5ooiC6HUfHUhuQVI02X
14qB6mlYNBAIMXOjojItnjJYWbDhokRcoAs58ntLtOWpcjnybaGCC3lZR841J9Ai
LxmnTmKXz/nO29NOIsB+2U4iP3omCaz/5Zt8oKaQfVDvuNQsE0bDK4BOo5qzC0CT
mqZoB7Nwf86Q1+3HIn3YPhb9n4iGpc1kR82kI0UQ0mb/c+L6Fq5WCngIoLVOdW/s
dfsr3JhKggZpij4busPSMOar/MeDkzCoOJwFTdWbhoS4cesP5r2zQHhltj27tD+P
Dw7eaF80Wot0RXOqwl1RucWEuZpbweBebciG11ZHcDJ7iDoZvU+tc+1NndFYhskB
yNXTQedm3BU5zXWeP45yjNrCRYNUBXCcwHI585NZf4x81YrNSQ4j5Pz++bVF2sDa
+Mzmb9MlkW2fAW6ZQH3tJZh/39EQ4v0R1gRMfjhUYTzjXnaEKgu7U8hm0uc8tmVW
v4r0Vk8msOsfH83YRl/Lw77Si6hxVdvErTV78ARHUtgKXLbJxObu6wR3QpoPF0lT
a25MP+VXjxQgrPdgXPjJFQT0jz48GkBRIXzcjtofc3UvoYIRGghUVVsNg4sGbvqF
X3Hk7sEibAR9RDaNmhKmVS8j8bv/TgMpDrQHoW7Pln/t8xYZuKeTzhJDlyxbpTNm
8MenEOL3o8aeHgDIfOKkala6D7c0EnyIC1OIEu06NuuOvVHCnbhTx5mIM80BwFzj
Fu8sbEzUJ2WsVZonI/5MQCn0IsUER5b3QItE5eU1Z4b5LU25fO5NAxkyCTsJQ7MW
BCfbvjmzHGS1R4fLPNHC/fKbQKzbF1fUVhd/w/BBOs3IBWjpfw0/x8LOoke9AlCr
LklxjXU9kTv9qE6/ZxM2nWwEQ5Z4KNeyy+C3lGOeydnen5MY7ozaqGGv+PDV3Cu8
JuVTEj6UdsgHDFZicQ8byvdu/2Dl8lS1kDKc3tzlPj/Px0Fj3cl/6okZUcwyr9tB
Ygv7/6aqB593LvrBW7bRzfhaF81pIiD6ZnrDQqlxQxK721NWfPt2kmpPIlfOcFSb
/5ZwcVt13JgdraiTGSPNcEzFxQwPHomH58WcYlUjPhOgfsNAnz5ae5fhX37dzxId
99aF/jPePt9kY65RmX7sI7wdikb3xokf/yBTLKr0IAOe7ilPqzFOitwsiyaR3iDx
Cn+/ROg8d3r+KYrHUl2IS/rRYe60Fhy7fm64zuxSR/t32Q7zaJvujDRav5w+V8Vf
jxl8WpAzEMyKrQ66rQOTA4ler8GxgunPxY70ZILKUKYpkp6+4bQ1R4TTLWMZ+OFb
ikzyl8ko3EfRJPgrAYTgXKSV7aZwzBp+vMDdKZBFeEbT1MqmNeNHYrWTZ7WnP1vI
yhBYvOs5PgN3E4AW1eEG+OPcQVmnmDbnsmROb+T8PV3ocje/tjlZ/lEI2N1H/HTq
8eXV7E36553SA8T3+qtwuPkARfQWVxlDtDuYX7A/c5wtUyQe72TXAKkVL+rXjFft
kvqWHpUVQGbs93CD/2Nne7sYIjBSmWB4N2r0koBbPK0ke7MkGvyxnY9+gCNW+nzA
Oq2U/n4NNScfzesMpZNFYP/GvrjTcKPLokK1yO9yjYjNsp9s7RxyAaVI8Q3Uj1tu
O3/QeACe5uCcCDPN42jU6OSz2DqUAu9hNh0GADdKmKi3eY4+NwcXFFByB6JlvC4s
Fs8wroIVrE+0WF6k7Om5h79VlYMimuZAIj5nYIQs6qqSrXTiBs2OvDxqtiMQljc6
kNHXhabOMU2STyttVfrEwMXkzv7A8Ap2NHiaOw0ZYErA2bSUACYCgatuBw8PGxlp
9poSdekr0rCQqtPj3ICqXjF0IIfY0xzrDbZxY7E5BcATPtkQGzKtD0Peoi7FX6IC
7BkjhB/DYBLhQNUF+zBnJJTNfzIqJRcmBJ3zg5T+mH75JjcU4TknVoThvCqs93l9
jRH41mIK03X6KogHYEkFKVbFi6G06GeXLEuEtDCr7sz98oacwstFDhGOIxz5l1JX
x9t3b0r2xJlmJ60WR04zyTohu8V2ybn5vdUaQyyZV1ha3MDH5u5tmgY/xwFqBVEP
J+P8xLBZi5EYRikpOjQgPNUrvSSaf5Wv37KVytFLBPRz0U79arxcmFjJhzOBcXow
XQyN5ccFD/Fum5n0RRfF9TdnwWwhm5rTToacSjxxRWrvdhmJDdC617eehLOmK8Kh
cSAkFmtu6UGA/agdMc2MuZIvf/Tb1RuJ6n/E5UcJYrZ4gsd6zCPJGDY5EyjPYNTT
n2RJtDN9/5MglMRiGWMNERJGrNJlYcoRoFH7VSCGVtSevcnMmuLsmlXKfhEmUyRR
KADvndysO87atKN8gyWTjeHqkWN9wSqLH8Rd+JaMbwjGFRzqJBAekJqgGeho+MLy
rDbFcexx8lw4orX8gBKQZBnh0PX8tGXFhBso+P5SGma+SzC6pdcqGCbIuV0W2elO
soo4G0UrN1Ps541Q2tBeVB63rBRYxqcFMS4W5eVC28tLIc0l8J6sdLosSNgp9X08
cPi8Y1Ib9U+HwnU2wKwzPypW6rLRMftsWw0Q+NvlEIRqFN/67TnC0YFUFJsqxO7p
m/2B2vmHUhI+IobN2Pf+we85PYpzAJ7ulLZmcp579dNbP2HfA4ZOOWbfRP7Oejla
QTdaEf5z5bnpH6YAcOkOEX7nBH5Yitm+aXPbVOvVAeUwHNeIYKQ3+mkrXyojJdoW
FnS9oJkSr0pL/fibsDCxMN17SxepR7YDGI6EcccNM8y5kG7zY8gDxAaGWJtHEKrY
h9saCtZl/tjytMiTXXeKKlNTaHuXSnD4sNpDLw4yzSFoNU6grHU5EpYz7L8PzQov
LUA7QBx98SuAlyn3SulQYjGYIHMIVLbrBScEqKavZTW4T4fcoZhJ7pUzJYTYFpks
SgZBICRE8KzcapQ66009SpSX8hQctTg7LI/65nY2aiu/0ECZ19CbFSkeoOakanwP
m0sU8SztmSTXGV0ZaG3/0JlfK7dND+EXHAgjNP8w6j1phmGrG2N9L6Qh5OzjEzih
Vcf3ZU0OINXWfaMuk6gmZrs7/OX4mbxg1jMG4j7SQC/RG4I9x9VTsV64AIDS9C5A
v10jjzk+9bsLE5OvtTHt6ghBb/1NjbGEKGo+s3f+M1cksd805yHe7QA2gORb3o37
LD3+e0CMtJ04X20qZNDc0koqEUlEbjxac2o/mc3eWCtZQzSuzCVe1V18/aIJI67N
HRZQqnSt2/ov8IjbdefgL6rlgI4kQVRVxOgXS0EFy3xZV+hgNCMsHl4k1QO8Di0T
9+TBRsp+iYDdSl8rHB81gpVG4/BGdIOBnLPcl9LNmIoTybdfFFdZkqUES4G6KCg5
nOqRELayGc44wzI9jRf5cnKy+rJIHRCxzxaaARRO/XkZ3cU7/mzBRxVddh4zbRH8
Hwi27PGunzQiTlmT/9d53KajILCMkfCGoY/iYfaKs7Qo6ud3xN+kWanOMqyTnz6b
+GXJYy94pDovVVd3VtGQOMRsHwE31ZPRXXnIS9hJMJw9OwGKspgrUatqfHbRlrM3
40f14BWqLGXC6C5SB6DKhYLiDf1pva4KrZi1hiRIULujyI1tfu+e3/mutoV9fV/G
h2nP9YQgOBM6g/Fc0FUEtl5Tyi2zImy5bFFIHTTclifqCMf4y5KvxZHQ9pUfWmsp
tQT1pAaq+vrCbdlvZx3l+duKuOb054GtiytZXsBafjIa5/4v/4Y3kagueQQpBOHW
83k7FZTHKEoNgMCqyMMrFt/ums8H0FkC4iXQ6PelfbnKkK5XKaYS4Xv7pUD16jlt
hkBujynXGHTrU6T8akMneJBAmI5SyK+m4U6FYPtgIAaqS5IaMs/lEiASR+PSS1et
rIXVQP7csGEKLm6EEQSoselRVrGySSpkseQMCxG6jteOvpSb3DzuZPPxd08EkmCv
QWO13q3HhLHAm5ZlQ5G/ch6nIc8qDNu8EZ4PMqIWuWixvCuPu/p4lZZ551tGxLeR
G70pm3FQ0lbQm1IApZ3ZLVo3eNMzwscPpvrcX0Hs6ouDUgGVhrWTluN3P7sOF3JK
4JhdHJROqXY9o4M8femUGgSqPdi/oDhEpFTOENNEH+AtthzRVvAfGFhzIFA7A/fe
aGVZwKDw0x/0XruPvRHawp9FcfvKO4/vwvvPjMV6pLkJLWwl6dXB3pbruqH8j18F
+2JRhwfal6H1leu9eCITQEl9vX7xRzZW08Wr6IbU0vH+y1T/bIB/O9TIPGQWLKwE
McHQp+rEE45DFUlQLwwd2EO0K9akWSvIsr0z40WpfZrWYC2oOc+Z+08j6+EtLwaB
fjmd0An3NeA3O+3i+8S5m+tQnuNbpsYqdO2QWoXZ0ovKe4mYGzidJP+iLf1ttABA
scpiTlwFxYED5EbzOjQPlQ1ugSiLV7HezVrsAYfFw2BekP0j87mgwR1makuCLas1
kv9fNNLx3FMDQDWf4RCHi5qsS9H41oyooXSCVGJjHe9mafDXv2mrQESjfel2Hu25
bUvTPSfUVldks+qpib0BqdEI/NI373Nr7PiBE6RvgPelcSVr3Yupnux5mvZuMnM9
p11WjOkTQqO33RhNnuYZ3siymJTNVk90nZEYKj9EpyW+OOXY3PVlOkVIt/VP8VAE
fanL6PnJB2kR9XcCDkh4Ow7f/O9DNxzvOgtqHkhQqOMH+lYIZmsC+M7wolzRC6By
kPWmxSMTqzUsN9XX724boaMa1V2YayBsCjVm84PLSqiHmwQCaQoaHyua19Bo96aB
vD3EJxAlOlU9+z6RcFfS5vLjFroRNo7mQnbaeMGVGUmp9UxPmOSJYJUCk1tEq69u
mOpRqodyrTqX5IQ2RWgdrN599PSMqL6N3uRt0im8cshsutrqkcUbUkdgwXV6DuL1
k79ULWvqye5vf8NnB+ndFH40824e4LpvTbofPfKXI8om+Lhq6d3M57Yc4CMigaoW
lgiaL2WvSkL//STrxCsF94VYht/H8T3ywSw2mSMiqknbS1/WX2K4CUxHRidXMJx9
U0YSXDWpa49tLfZLm2BENk71sVoVI6ivDQZCP4zikbhhBk+bPgf6Nkj41a8xLdFy
5YTeuiFPt0tLUR8NeWgdmst1cUknySswrrOco0gvV01+qKKRNG/aXRXZn0s2pfrg
YGiJr2CwXSc/ZtKh2KjIa4RbffvF8isFpzlmTy85YiJZnGHqFvp8gm0aYPckX/30
6uG+gFxhIzfhfIjXvjZ0HJE02zIRNfnsAv7X0HRGCb174zNm+4VtjAcUxxAAwvfy
4AumxYZFMNAgcc+s3uwFhpjvxF6g9x8EhuqKTynUsGtQiEYSprT1nHUtHbISHnF1
IqyFeUh8WeRQ/rJlCcXVITqBVXBiyWDzI+oZBjgSc95EmGgFlpcvU9WJQ3N2q4UZ
HbcMaaA4uuKhU+/n/shTdF+JTUiZXCDOBB3jfRl6DrreZTt3qPW9YWpqQ2GpT/eL
wHG0Mhe2Zf/LrKIVivqiDvrMhkdLGcqbaH5AYlhQ/QERUuERZ3f78sVYEJErUaZO
EXtJfwU8Xeom0sCs09AN1t95fhPfBeZP5aADQGdVEJbo5EQoTImkp3nZ+MZ26S1N
3CXyjfx/p3uCz2fqFp+/CA==
//pragma protect end_data_block
//pragma protect digest_block
p08pO2o71bj0SVuiVjb6PeI1sl8=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_SPI_FLASH_MR10Q_AC_CONFIGURATION_SV

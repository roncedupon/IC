
`ifndef GUARD_SVT_SPI_FLASH_S25FL_DDR_AC_CONFIGURATION_SV
`define GUARD_SVT_SPI_FLASH_S25FL_DDR_AC_CONFIGURATION_SV 

typedef class svt_spi_mem_mode_register_configuration;
// =============================================================================
/**
 * This class specifies AC Timing Characteristics for SPI Flash based 
 * Spansion S25FL family in DDR mode.
 */
class svt_spi_flash_s25fl_ddr_ac_configuration extends svt_configuration;

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
  real tCH_ns = initial_time;

  /**
   * Minimum Clock Low pulse width durtaion.
   */ 
  real tCL_ns = initial_time;

  /**
   * Minimum Duration in ns for which Slave Select must be deasserted in
   * between Two Instruction sequence 
   */ 
  real tCS_ns = initial_time;

  /**
   * CS# Active Setup time
   */ 
  real tCSS_ns = initial_time;

  /**
   * CS# Active Hold time
   */ 
  real tCSH_ns = initial_time;

  /**
   * CS# Active Maximum Hold time
   */ 
  real tCSH_max_ns[];

  /**
   * Data in Setup time
   */
  real tSU_ns = initial_time;

  /**
   * Data in Hold time
   */
  real tHD_ns = initial_time;

  /**
   * Clock low to Output Valid.
   */
  real tV_ns = initial_time;

  /**
   * Output Disable time
   */ 
  real tDIS_ns = initial_time;


  /**
   * Output Disable time to drive MOSI/MISO ports to be tri-stated after this time
   */ 
  real output_disable_time_ns     = initial_time;

  /**
   * Min Output Disable time to drive MOSI/MISO ports to be tri-stated after this time
   */ 
  real output_disable_time_min_ns = initial_time;

  /**
   * Max Output Disable time to drive MOSI/MISO ports to be tri-stated after this time
   */ 
  real output_disable_time_max_ns = initial_time;


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
  `svt_vmm_data_new(svt_spi_flash_s25fl_ddr_ac_configuration)
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
  extern function new(string name = "svt_spi_flash_s25fl_ddr_ac_configuration");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_s25fl_ddr_ac_configuration)
    `svt_field_object(cfg,                  `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
    `svt_field_object(mode_register_cfg,    `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
  `svt_data_member_end(svt_spi_flash_s25fl_ddr_ac_configuration)
 
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
   * Allocates a new object of type svt_spi_flash_s25fl_ddr_ac_configuration.
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
  `vmm_typename(svt_spi_flash_s25fl_ddr_ac_configuration)
  `vmm_class_factory(svt_spi_flash_s25fl_ddr_ac_configuration)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
nvNNFPeWv0QpF2Mmd29zsvhPDSsJApJLQLtM0rdJyri6nEdn7u1GQ5j+ETxpGTSy
7mfv9XbARrXI9zU1ecge1lHL2nMtwITCgR5KnQ0lJlaQ+S5CDDYPAY4ho4OmipV1
+KeerabXgJd6DA7wcHowWsdJ67AHQIGGnc/PvlQRMwfh6M6hZud6jw==
//pragma protect end_key_block
//pragma protect digest_block
EgIlq6qPgCbC+pq+pyjbgyMylzM=
//pragma protect end_digest_block
//pragma protect data_block
NR5SY3dCHi7xP69BESbdGcPZkGI3g59FyRv14Z0u7M28xVaQ3vIlxKAzjoohqbHU
SR+mG8l4516IH0noserP3q7RVSBWTE8ObxLOuFGW+X7A9bDfCMD478Ar08HYVb06
tD8ZypXI9bLnkQr4gOEre6AjBTWOmJyDflDzX+x1cq3CgZkvEARjRSvNL5CFaXmo
ojmsaHPL4tEtjbZH6NVNwqxE36+jpQu5jtfCZXONuo1GN43KUu/xwbz0tri5Tya9
VhmKfW1k6CXzpUcM+CpkJdlc1mDd8BiXR4QWRgbj4kTsEier6j7/6lc8Bp+5IEdD
juragEwwESYhrDJU3lT7gvsNM+DZFshlWM6ufe+MuiponwZ5iSdP/yZWmuYBwUhH
Q1HhpCoaowDTT6GsM+ISX3SRNkF5bftxFs0qbrRmz5tngRZ44EtqgrGnC+bxSJZI
FjQhm5ebP2LgeJluVIf3z+pFAHqBkQjJpsK3JruZpuecZZ1lQaEiR/iPEPZsOiao
TNI6f/jI3sxf2Y3JxI4TIhMw+9nK3M37N5eiBqfhJ2IXLCtDWewmxjXV2Fv7IOXg
cpb81aIDXGW6EnrddJirn/kAXPTaiQZdEantzBY22ydV83+eXbcDcTlxgC7nLBcA
FT+RV1mCjRDHRggwCcEtkKpd54pQxZdm7NKB4+Q3UX3dUIKvz+agr5GyJmG/nJE0
i7SYN/RtZBpO1VpUFezqIpUhIZ6c5H6ObbOuB/jF4q3BbuNzuqI7z1c1uwaXAhVx
wybMFLO0OVn9rZLxcRGOlIx4LV+sEiNHOy7U6AUr1gAc7DKI9lSafkxm+HRAGZ1k
ERMhn/3yMZ8kqJCWLZnHzuRDs2b/aHKG8ylVDM2gMX3cPWyCeDnuBWprTcsj9qxM
7fSkGJ+qB5jNZ3albh36KWG209KOcUdHGcZjf1Tw9Y6yLunEsbD4g2o/yC8/ZBmV
j8mCT8UJ6fV2Cy4+dtRRlV2wvvw3A4OZGyR9i4LpDvRzSi9J+rIPt2RImB37faQ4
HzE2EuGQSHNPtWh7njraHD3z3Dkorv13oiWlbpUO2hWQ0cZb1b+51v+oK4YVXCL1
YZo8BVzUaR6Dxr2tkLu/c/QLMPJr9LhqiVFSYLYARxGbspsszZduv9ddDGEJ02c/
ML+hhOwfr2XUlwTYKf8oeKIRSLxUwDGfaIh2RTh0czJbLrCzLFpxUuD+MXge7bDu
05+VUR8NthATURh6kCtlSE54+CM0yr195wbc+BRbHUc=
//pragma protect end_data_block
//pragma protect digest_block
sdJnnOHKYy83TWbc4KGfX2zD5/I=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
oSw4+kLQlc8JDuollxo+fc9CnKgaCtk6+sYBmCXQ9sT4RCNktOfclE8ktZojNtA2
ZywQbYSqweqmY+dP1a/Ix+yCCpJkwiaEJJnnCam53GgxQFOJI3880UFE6ucNb8uO
3Z56IBCzhg1+Rnuj8Y8O1LBSCBCQ5dRlLFoK2ayMzHZ+uU4kRoBNPQ==
//pragma protect end_key_block
//pragma protect digest_block
QL549ZifRlpCMAXXPDkmRwLABmE=
//pragma protect end_digest_block
//pragma protect data_block
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
2egzBoerOshe6WnEjEmJdA32bLJo+OHc0PYoj2EL7CFXztULjXE+bcl/Fq7+VLPh
QddXLgsFDfojze65CBG4AoHWeqWrMfLaQ1KHR53SgKsSs+8AYQ/x7HDngErV4szD
sO2BHW+Xf+5sDQE7bqj1Z533eHFHqQ8x0MrqUvVAp4PCCbOcahZb/FbqGKKVJ3W2
S/NnVEmR4o+r3PRxP70+d+CsixRyugajl0+RwEiE6wtdI2chpsHPl1a04GlEk4L8
2U/1vNjsygOeg3QLEzpYRdaPUJ9NZ9Py6kS/eksZziw6U09sMVgnQXk1IKRTilka
a2bEQR7I9oSt0gz9bXu8E779h3SUv+VPeY0nhlw+hMRDcDhTQqfeQ0//runlmd2F
nYQThJiqHk0bNC+iP1nAlC1nlL1nzTyEuqOCjoxn50UHwgbDLWiemWcnI+6vugzt
svmJCfp3YmUgSEE8sQE+tqVJ+BNcO+5A7njulnh19dIRIT977PlKoDAOa5R4EBmx
Te+Yv5prtTv1XJeF3affzyWtyNTSZ48Aq0W9EBh4h2SIOq/jSQf45CAyDRdiwLBz
KLK8LoPzzgErfgHI+s4HeUDMrVw5BEZ9i2xuVfmBtX5cVLcbTuB5BAsYOaVmrtw9
BzbgIHnkmZqcXm0v3d4E86cE4TBP82LdfRfnc6KX3tZ6o6XBoJ1v0JuZIIQd2O1Z
jJo6XIw2xDLpc8Rqrgg9QDklsmuWsMmUGMec9wqPSwZdPgR3HjTpZmgD00SPfqfn
LSqggGW+srMzdhPvmW1SW7NicAbnEqc7HUtKaV3SIv60cagaWQcHisLAwHioHEUf
xjKi5QlX4p6hFTrCEMCgNKaSQ+TChgtKpjrDGLXHRI4DnW19zj4GtTo6Ft7SFg64
/WfvXSFR315DqewjndTI8BQplMzVnRRiOkWRuu3NmdV346xlQUFQ27hnnF9E424+
eUqYYrW0AaAH2EMSR7GU+ge6rXDS0QT103SA0qXTOAclg/7nDKXKfET1+3QrQOft
6luCBUSqoW3nb9cZ2OC/yYB6yedsZNdgEFJR7RFzWty/BO9xxbGGZsrUiVURSiIP
A9+Kmyp6NvrmU0sCx5F3zpTZ/UCnJX7N0kGVzP7ehraNrsVbzLsbkqA3HoFc5xD+
D9iiHEd/gM36/RulM9sWBOETX1Hxa1IrhobEMdKXtBYqZHY31U5oPcSME5NSwf5G
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
//pragma protect end_data_block
//pragma protect digest_block
PjrBRL/Ulb9r6fp/vBwEMFCCEE0=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_SPI_FLASH_S25FL_DDR_AC_CONFIGURATION_SV

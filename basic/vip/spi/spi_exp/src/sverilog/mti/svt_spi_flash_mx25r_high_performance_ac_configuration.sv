
`ifndef GUARD_SVT_SPI_FLASH_MX25R_HIGH_PERFORMANCE_AC_CONFIGURATION_SV
`define GUARD_SVT_SPI_FLASH_MX25R_HIGH_PERFORMANCE_AC_CONFIGURATION_SV 

typedef class svt_spi_mem_mode_register_configuration;

// =============================================================================
/**
 * This class specifies AC Timing Characteristics for SPI Flash based 
 * Macronix MX25R device family in High Performance mode.
 */
class svt_spi_flash_mx25r_high_performance_ac_configuration extends svt_configuration;

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
   * Minimum Clock High pulse width duration.
   */ 
  real tCH_ns[];

  /**
   * Minimum Clock Low pulse width duration.
   */ 
  real tCL_ns[];

  /**
   * Minimum Duration in ns for which Slave Select must be deasserted in
   * between Two Instruction sequence 
   */ 
  real tSHSL_ns[];

  /**
   * CS# Active Setup time
   */ 
  real tSLCH_ns = initial_time;

  /**
   * CS# Not Active Hold time
   */ 
  real tCHSL_ns = initial_time;

  /**
   * CS# Active Hold time
   */ 
  real tCHSH_ns = initial_time;

  /**
   * CS# Not Active Setup time
   */ 
  real tSHCH_ns = initial_time;

  /**
   * Data in Setup time
   */
  real tDVCH_ns = initial_time;

  /**
   * Data in Hold time
   */
  real tCHDX_ns = initial_time;

  /**
   * Output Disable time
   */ 
  real tSHQZ_ns = initial_time;

  /**
   * WP# Setup time
   */
  real tWHSL_ns = initial_time;

  /**
   * WP# Hold time
   */ 
  real tSHWL_ns = initial_time;

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
  `svt_vmm_data_new(svt_spi_flash_mx25r_high_performance_ac_configuration)
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
  extern function new(string name = "svt_spi_flash_mx25r_high_performance_ac_configuration");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_mx25r_high_performance_ac_configuration)
    `svt_field_object(cfg,                  `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
    `svt_field_object(mode_register_cfg,    `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
  `svt_data_member_end(svt_spi_flash_mx25r_high_performance_ac_configuration)
 
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
   * Allocates a new object of type svt_spi_flash_mx25r_high_performance_ac_configuration.
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
//  extern virtual function int get_clk_parameter_index(svt_spi_types::flash_command_enum flash_command);
  

  // ---------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_spi_flash_mx25r_high_performance_ac_configuration)
  `vmm_class_factory(svt_spi_flash_mx25r_high_performance_ac_configuration)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
n7HrkULbNi+8ytqiPg0cyIIiY6k985uP5UAWM2oxpI/KuphUSRfLXYX58/ivXCqj
fTpE419YcdDCRG004zyqEOfmRw4h8pfOEXRJ15vRjbOkbAX3JXQ0HepLjjhACFhj
xgJLbYh9Ej+BYIddR/8qfDU/cgbcAn3/3+0qNREnGes=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 821       )
I6TCBkFVcmm3I7dr+QfAN8rbaCVBhrL1IFM9H1f+dozoBXYyPHkO4iOMeUGqL13W
uwPKGkkXyXZkAYF7zlJrSOOm2NlEmkR23o2I+R/8zbXtQX74/o40M+ggZzo+fvMH
/ZkbH5EMYbLfVxEY2sNl5Vh5lt+I4pHCYw9nZBC46MoskgjyecM6/bpQtoBH0/R5
m6zAp2h6A9Fn5j6XzsDpklg85IUu7pq3GyELxTn6m+m276fy7tzXfny0jvemSWST
AuK/dleGNUgHtPMA7TtijMpslZbqMJXpYFj14VqHdJxFi4IwFH51/bJpdc+c74EK
DPmXz+l0QqurlxgjhZiXvPG8FOipPKNslmcycRCNwAC529kWQXVuP3ghhKKp3plt
lWsl3unnbiZm2/hYPUZlguo2Gsu+MXFDjtkvuByp0gmjBtd7OWTRa13M1MwZHhSs
po/4iRFUw+SqXMM18148eLyFaWrPqp01c2oLiH8yaDnQe5m/61j+5DWzVgNMtMnV
P+kLFAfLe1BuBCf68yKBLjDl62zVHprbAmbzOrJceYU/WoCAWbA+h8SMh9T+lG95
KCEWz529WbOFW+cX4OHS59TdJkQAABg7fXj8rB83lGo/oTUCnBB1ZyINNJXJ3yQJ
FEP9nNk6LPI+uS6ANmGPe75EcYWRynr/v5sdR3/m6eEuxPpAG5YlzW9kb8BLfmyr
v6ourOwq8A6vs6556Mj3fnXV7eL1t6W3UJxSgwLHMngeXxFiKFvJatBFRCfX+tIi
shEz/XrBOQXJcA2jrOJgj6NYb0wif3BugbrXET423tWcfl34tysns+DfrD6I5HWY
D9ADDouYCdMaqD756TqvMF5nOta+PvKol72EcoWp5oO9LRSmZVqsL8y3YXsEd9Ho
t9HLJIIsjVm0OiM2aAUpExZ8BhxUYYRErFuLTE3blsxOWN8FeBBH7U3SoXaYTN6x
oc/SDigJN3C58+63+SM5QfS5rKuokHfcmI0z+tODtcJQk1qxPFRC/RZ0VNMrPIkL
xn7rCuN1ancArh1eY/RIPfgGB7rJIGULAbc+HrVJ3Uy9Gbye+T38WZ9oWWOFZ9Lf
2F+RsyOAZuNPCoh7hlY3Jw==
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
kd0zFcyQ5xEHofzLHs1Y/0kOPIeBeooTBn5BMOucwwzW4So7X5WtbxFe9ZXS7DLb
QMgS5c7Ir6vux9TriqWLBKFyVre/mDCUasflPdq4zU4aSQpNkzhb2ap9RWXzSEPa
JC881cOZOeU063w8vSaZtuaP+1QGFZcqcuFT3E2YAxQ=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 20871     )
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
`pragma protect end_protected

`endif // GUARD_SVT_SPI_FLASH_MX25R_HIGH_PERFORMANCE_AC_CONFIGURATION_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
pcyt8cn8fUpYnwsBEnc1lPl087qYT4ihADDpRkSzVvBcR2pr2wezeQDit11HP4yv
ffpsTjqgUq9YrRx1Q7poz5/gExMn5GVoQjLb3XaxDfPr1ujAMLff0aOU/zSbDQhU
rb9RZJZSxQyGHcrBj3CMLtS5PfQBxyFeZMIIaLfcTE8=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 20954     )
uW7hNnTjGk4/cDKfezHGN/XBcrgzoqcD/MvmSwVFigAzQEkfn7rfEXz3cXI+XkCd
Ti0AX17cxwUN2oHyfWCv1qr/k0sOawW42KYdHCTaF5sbCzRaWXKaAFbVdjIj8kBn
`pragma protect end_protected

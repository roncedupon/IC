
`ifndef GUARD_SVT_SPI_FLASH_MT35X_SDR_AC_CONFIGURATION_SV
`define GUARD_SVT_SPI_FLASH_MT35X_SDR_AC_CONFIGURATION_SV 

typedef class svt_spi_mem_mode_register_configuration;

// =============================================================================
/**
 * This class specifies AC Timing Characteristics for SPI Flash based 
 * Micron MT35X device family in SDR mode.
 */
class svt_spi_flash_mt35x_sdr_ac_configuration extends svt_configuration;

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
  real tCH_Fast_Read_ns[];

  /**
   * Minimum Clock High/Low pulse time for Fast READ Octal Output command 
   */ 
  real tCH_Fast_Read_OCTAL_OUTPUT_ns[];

  /**
   * Minimum Clock High/Low pulse time for Fast READ Octal IO command 
   */ 
  real tCH_Fast_Read_OCTAL_IO_ns[];

  /**
   * Minimum Clock High/Low pulse time for Fast READ Command (SPI) command
   */ 
  real tCH_4byte_Fast_Read_ns[];

  /**
   * Minimum Clock High/Low pulse time for 4 byte Fast READ Octal Output command 
   */ 
  real tCH_4byte_Fast_Read_OCTAL_OUTPUT_ns[];

  /**
   * Minimum Clock High/Low pulse time for 4 byte Fast READ Octal IO command 
   */ 
  real tCH_4byte_Fast_Read_OCTAL_IO_ns[];

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
  `svt_vmm_data_new(svt_spi_flash_mt35x_sdr_ac_configuration)
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
  extern function new(string name = "svt_spi_flash_mt35x_sdr_ac_configuration");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_mt35x_sdr_ac_configuration)
    `svt_field_object(cfg,                  `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
    `svt_field_object(mode_register_cfg,    `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
  `svt_data_member_end(svt_spi_flash_mt35x_sdr_ac_configuration)
 
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
   * Allocates a new object of type svt_spi_flash_mt35x_sdr_ac_configuration.
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
  `vmm_typename(svt_spi_flash_mt35x_sdr_ac_configuration)
  `vmm_class_factory(svt_spi_flash_mt35x_sdr_ac_configuration)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
EWvXaIy7SpQi2gsrJUo/LWDeP5JsCPXooSdtzaaQO34LjjelC76QSC+F9JribhGI
ZvvUd6hvr81GV3XBX8orhkuBdXf/jUyXLx7pzQNZZdXY9rTwDC4UGl4ZrKyAiE9s
eyhq5yNOrIsILwFUCFpLLIJ6nWOjebwO6x5mcDW7ft4=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 769       )
aUEBRaAImn0OVggiZbrh5LW4YYIz8tIvxJzA+CqngVJL1iJPK/VktmIh+xeOs36c
09MjC3VLVs07k4A37hP0+MDeJIyu4SlS+RU8tyUyx0JJKqSysHw9D5rWbmtjReKQ
xNiQUrcAVZFz8uqIECWR6Rz9umf8DNwjxrXChLLS1j7vQh9jwSkvplwS9K1r9p2S
xR5Nflto5RvdC+WjAUFaSqHiWckxEZpPab8CLiRFz+hRgirCWhXLUqMsTzL8YyUO
xfexyAeeI6oSvBlUuifrLzgGesui5CzvccveSDpSwpcjIqdsUuU6O4wRmP5ehNxc
881FQ+wyRko3V2zB/t+QUyoNQH6ny1IJ7/omyypcQfk8xLLcpSq/dWtsHPjoOUEx
NwAR+fHrtj6soymInRsFxnj8bq7a/Ub0qVcjF+GZDpT+EaY0gktedvkLaTxuUkVS
VnLtxjFU+oz5QXTjh+uGqrpq2/w6UAHyb3CDs8Ut1UYkDoEMim3McF/+aRkaP9iX
qQp1trIEQH+vDpQHuF1pM4bTpjMiiazYYbv/XeqODdKNn0GsG6hNfjBU3+vO29lE
jBy/g5PtsecJJeEoPtSErFkGxuElfp0NzLpZHUJxRsdSiciKmaSAjfeK8ZJu2P9i
vlP1mqMZWtAfok9f6c16pb10pW71VFuYx/62jxKRSRYBE3VMSwXtLN4h4yCOtK9w
KyLCtmwXYWSu0SASOUu1FJ/6u9IgWt9/4bOTLZ176EKsDyw2Q59vq4zw/xO4UH7o
h7l7YimfFtYu4Eug3gwC+xnIAZS//xk2YqknudjZNj+fxyvIfw9eFGoQRgplhRaC
wvbrCm2s9IaWMhNURQlbTmze3swiG+Uy0wE487C9qdKLBqxqUk4nPcwcE+eDwUTh
8LaviTYhmikrue5lQDJ+Z77nuBCM/D2s6pmR/elPc/mIr9zkDeYNza9qCacErH7H
1Uq55OCwb0b5Q8QHGm4A/tgLij9ftgtEJVTegDDJEzEljSLU4f5wM2qVcmqsZpZ+
NbUv3G1AUNu8iD2ZVK5onQ==
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Ar8y3UnZhd0ebF+tT3Bb4Rr2u+Y6S5Xzf9LXpVrIuHofzh/7DicB94DKwRNXzpw8
E5uOXTdzCHHqelYPUSXPpV9jedlcRrPYRrjMFTRG7HnUMFZkO4HCy+Gqax8fIdk2
dCIcIvL+S+cEjT6hwYWDlAIjSCNZ7QqDWIHyqRdx534=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 26259     )
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
djlbHpx8txVv8J08+7znz1ZJnKVXXeY5+UZL2GgIR/82ZjCm/ftQEVd3u3DA0Zzm
NdSKlmQDLg1JtDqQd7tq9tftZZ66xzh31tf5H9IJWB21z1Tr5jkTthrd1f3SfsM6
IotB5POeRklYoiR6QiFK42EyzQWLgx4wpYRQK3We+4I71OGaDTs/WYM5KJU9Y/p8
W93I+JMTXGuoaQ6pbcmBEhgJVvZO6Lbv68x0nir5YXHfbw/Ar7LLwKGN2wLUp8I9
+Wbb9kw+Zpu+s2UMyyzftyhZqNxqKTjv93Z4Ug8zuiwfcVBPMLPLDQtvrhmpI43/
2ZiUqZgpw8e9c0p2r2oV1WpAR0PQIrWGg2lm1q6fCjiLidhlEmBQnUMAlXbUMIoX
fk8zpEd6/7PP6mLMzYut/S3W9ozgRW3NeQXpMVgQoOkaiOiZQY5FwVUje7UV2O6y
kUcIo5yeRWdvILM+JlzGc5afrVHPvqcG9h1saw9DhrA/YVtEhySk4Vf9kQp8vFyh
ZJoIQUsED8frQt4Y+MGl2Ia25cZJm+Zo18ffShxh7pW8RqGSNhd8WItAnp9GpBlX
OyVYKoTYccwyhRoF1CLgacWKy2ovQAKmaK6pO6zqUfpSqyoTRLJJE7fBiPuc/R7l
8LxvSTol155OyZiW2X6MV5GzQ3C4cJDZM+OsDt8+jifLjgdMp/tyJxrqBHma9YhN
HG9MrzN3KEvCdl9Q1iox3f9eZ/m19O2UTMgYSCkm+vGXNrdqKRNTh8kgyRhIKNT1
x4Ox1dNl3LahN5oNtmdVK5xcq0a7hJedfQ/cujL3J2LCq5rvtJTNh9t7A5s5/L/j
3W/DJLBP07ez/k6Bt1bGhouc/1smS3s4mKKMI1ON1UprVwUKRuH/OKe4ary2cq1s
JXeYjP6KroMbbL9Nup61sa5mGPcZ5tNww+7u7qoDxk0D5v5si7cFA/32c+tQjF/u
IFAzMtm5uVy7PO9ap0y0F91L2hsKP3qkNA9O8MQwjMXLWC4KDO8spUDxsdvA4Osv
IWYhUzRWvFeIEPII1ycfQ7yoD9vEol62TkLgrvRGzoqmoobI0q1pkNHdpkEZTO3g
OgUqfnB/s431jtcZ02SClLJsvuvndzJctEW8zUTpLiAPllmX2mebBY6p+m3mGBFn
PWrGYCTneJ1Fw7r04UsarA2YCvurnKVeLoki31xJdAbHUD/rkJmr9mfmjpSHdrJB
vmtQkngrx/0SrhDj4AkglFt9DECDTOpJI4LgbAdN3zLRAPcYp08zYds+etwWtDbJ
AD4Evj11S/6tuGKRTPxeMQoqHR0GmVJ4ba610ZBsE6vimyHbmu0uW6qnbwfX7IoR
4GcwDcjaCt+QA2CqFQXLAECEKYXQSG1vQVgWf3/x4dA4aZr+lysqHVSbnF1+Dwhj
MN3UQupXnfCvTtNmlF3HU4nbPvoI4BSCJvmLWkl22EC1vAamV0Ew3+EGoMwDvRdQ
1zUNk2SafKW1jAUfMLooR4noyOcBtS2fn0XEmtAfICbKflAyAUNUMbGdZLDxhgRG
sjU3AJOs/t7+4/t/hG9mhy6Zn/QHSvLCW7D60J4qsm2fGXQcWNPVby1QeRQ5aNTM
+5mrAHAwywTX7QJDsYdLL0/ChJOS7AGwlIt0Du2C1DxEpwLdZLAYJ848OJRzXE6Q
eEL0wKmmEsW4eYL57dfNx5niwoWpryCeWI+WqmFKV4AEMv0DfvgwlK4a4q2SLk1A
ltnPFKtak9YVc6J8aTRfIJV5QPsUl+E9c4qZ7mrSpVgG8YY/H9Fmkau1gfA7Z67l
OIshsYq2SB0RCNKGn7Hg97j3ur7R85x0wWJMFyEtZy1QN9WQqV3J11YyS7oZOE76
8JZH4AZS24FFC5l69FsEXh65aT8ZV23UIE6nWX+TWzVG1usPH+9x3mNbPinNJXyM
/mq4nU3qABh84zja8reF8DKlUhlBWyo+FuJBKhc4jHTRTR7iDCi4YVxpYsk8iurh
RRtqqUSVkLR+1EgXw4IC/eGzWbvOg5mdNo1zcr1QzxpJ9z2AEDXRogSedXt5U9Ci
2nuDFgyRr7U/NmBfVUKnX90RClepiTTYdp+pxkay8gvY/t27Ar29891ksiQgcXt4
ok0NDfgP5c8JyC8kjmBIQA6y1ZYaeyfXj+NOOJe1hoJfDvpH0MCHYkXeiAQpcGKU
DxFY9brYcDMP3BMdJOP8SZVjAa0AYaSPRi/ACY7UH467uN43ddlEmtwGacakI3mR
ypC8wJcn1OfUymDt0jCiXQFDRJaiAjaKJWrnrBek/vktLMQ5tsQwnI2qbIc1bn6X
LNTPSzYaSnruwFSiTvQWQLQvAszEj/aqiQTgGoItYs7gdNpwTeLiL/f6uoWBnw2N
Z3zlZRzFmvLKdo31c7IICt4+SH/OInew6Ssvzr33brz/kV+ERyzhwexKbkaunnB5
8NKcX8Ty1pUA5W2IF+wDdJoHmm/EKGhDB42GIl5XUc4TF0TeAN416A5/SP49EgSF
NZndqFRUOMEMB4Aei5d5Na8WgxYpuhFS8wyxTCX/Pxhy3PPKVQnj3bm3PKWaLgmt
viHUlLxiY86z0SDCV4Q1pVFSobS/YoWOZqEPoyrRMqneV9EeeFa9f8lKYNjuS2Mb
Ouu+v/ml/SuXdd3Us8nz0r2WgLZxpFfCLdisOTzF6Er3RLsXK7xp7XcXBRxDFXfm
a5IFs9Gnyt764jTrI//Df4isbahjLSA1u9QoqJ2m0Q4wek9/8aaYLnwki1LOfTTa
/BLmuuvAlnlzsJWRbZ8s81DwDeAl+UucQBJnA+ExrjXZDH+KGiWdaawLgYZfYVym
GcP3h4lamzvpl1vT+gmxIZZWYXAtPzFhlJSdrFBKKw0M6dfrRXJtlehvN4IrdSf0
TAqVACMv65Yzzs0fEXVi7n3Uecz+fDP9Qa5nPYFg96rdEm7oyQvnq3aiGokEhT8B
SMfHRTuzDDh/08XnFdHIg0lRZIIF0MHotVS55NqLj2qrzo3rTHHEu6gsKAG4+kg8
BcD4o/8BFaQ2x1R3xOXYfHp6syvvwGE/YTLmaaJthVqnYZcua3MBlqvN2+g7ZAE1
3mSAN599g8WGktAfG+ZO493BwtXDHPv+gz8QMkRXNCsd7s9uk6YeFVTtWtKZAO1Y
RfyzNk+kxi3tAgfYptXeNwS/fTeY509nmEiv/JtPyKNDxcGns24CyrRe/cYUbuXc
w5SUbrwAvVYeOx+Mh+AEmvqZoINlwMJKCAwFrNXIAEC3+WyAyR2S6vjOOwjdtCeh
5W4m5sJq8FZpMlXVKBXS5oGPMi0tqUEEMpnyBGr8MyHyxO+i2SSgXnK2XHhXR04I
vVUXj2NJ6a7lFKuOONYY6b5oMpHODSIr3S/T7vJm/Gz/mUx5RRCukvDZwKwOUj1E
cu5Rz+BhKxf8ud3gWYlKblxDVRHuvoO9pdh29FvDsPygwMn6Il+IGWQGzKNMnmT4
Wny0bZQ6twaNZjtdzEced7b4mNhTMhAAzNSxOZNS75C2+25BMPEpqqFu9brBEWuq
FsjSeDCiCfTc7t9E02/H+nLy5fH4FK6DlPnwmbBwaXQPo5PMnaQI+NOv2JQeUXi4
87GtxbDhQliimnZ0qWmifg==
`pragma protect end_protected

`endif // GUARD_SVT_SPI_FLASH_MT35X_SDR_AC_CONFIGURATION_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
KbO/v02/nOkerasnWOKRvgeY26GaL81ZFhGaB0oBswZTjqo6q7xTbMRqdrlJHWt2
IaO2AeJ+qp1Qr+gJ5APFoEVvu+l/I7gyVU2I3hLTfv1VM2ibA4gflXu8HMgsDfI4
Q/MhLuuVRlVnwTODc8M697EluDGfnNsut3eJSxndXWU=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 26342     )
6nJmFpjxGQewLa+K/3UkFjPsZZn6AnFKbGJ/0exlt7LSObGRURlkqov+iELidcjB
llS6vNeOKw55QRd0jq4MD4elm9i6n4/YsP6Kn+jSMacyG1SjEGiXZy1WoQFysS5h
`pragma protect end_protected

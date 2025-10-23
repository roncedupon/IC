
`ifndef GUARD_SVT_SPI_FLASH_MX25UM_MX25LM_DDR_AC_CONFIGURATION_SV
`define GUARD_SVT_SPI_FLASH_MX25UM_MX25LM_DDR_AC_CONFIGURATION_SV 

typedef class svt_spi_mem_mode_register_configuration;
// =============================================================================
/**
 * This class specifies AC Timing Characteristics for SPI Flash based 
 * Macronix MX25UM/MX25LM device family in DDR mode.
 */
class svt_spi_flash_mx25um_mx25lm_ddr_ac_configuration extends svt_configuration;

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
   * Minimum Clock High/Low pulse time for Fast READ Octal Output command 
   */ 
  real tCH_OCTAL_Read_ns[];

  /**
   * Minimum Duration in ns for which Slave Select must be deasserted in
   * between Two Instruction sequence 
   */ 
  real tSHSL_ns[];

  /**
   * Data in Setup time
   */
  real tDVCH_ns[];

  /**
   * Data in Hold time
   */
  real tCHDX_ns[];

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
   * Output Disable time
   */ 
  real tSHQZ_ns = initial_time;

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
  `svt_vmm_data_new(svt_spi_flash_mx25um_mx25lm_ddr_ac_configuration)
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
  extern function new(string name = "svt_spi_flash_mx25um_mx25lm_ddr_ac_configuration");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_mx25um_mx25lm_ddr_ac_configuration)
    `svt_field_object(cfg,                  `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
    `svt_field_object(mode_register_cfg,    `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
  `svt_data_member_end(svt_spi_flash_mx25um_mx25lm_ddr_ac_configuration)
 
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
   * Allocates a new object of type svt_spi_flash_mx25um_mx25lm_ddr_ac_configuration.
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
  `vmm_typename(svt_spi_flash_mx25um_mx25lm_ddr_ac_configuration)
  `vmm_class_factory(svt_spi_flash_mx25um_mx25lm_ddr_ac_configuration)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
C1VD/jpZ2jU1W5gM9+GMcthQnuzytGzpgDRwBqXARlYQIM21fAEWMhKCggJiGmlc
85UYEwPAfEVE79CKLD0LvYFe9BOPq4AkpzId/q/+ynZ++eSJHQamvtAi8q0saRgw
4HxR5EOwdg3rZQV7cmoPv+MNg5KV3B0dt7x03oawCpWcvS5RYcwbEQ==
//pragma protect end_key_block
//pragma protect digest_block
fQUOtVYV6S0RzLi0pdeUhp+ASp8=
//pragma protect end_digest_block
//pragma protect data_block
NL6ZdyPhhkQJLG/wp0/ohB1GS0meB/R5GsIKflQypyPN3JfNuxfEGbK4IoMezovA
0F/Wb7WVS8VkhZE1FlFGA1tvYt4MSwJUff1GlsUWKLV5eCfvTQhmpX1HQalExPi5
oo3NAg0ym+vymsw5UPc3JgttGZDb8EN6kHSyEzxpkruoXkX61251p71TTjBMIq2W
kRf6L2dqGpZoimi4rh5dIPMRHHGCAZJis7mHJt2s1SxnqaIgtYnyfCb1q79KpFIn
OapzHy6V4odbeKxm08B8qJxW92+BueByyywihtoesdRH+ZJDzy+sO8vwkdGc8hyY
Mjtgn4PaYIWK4xcNwifTVLIGK8vgl0ajBguJ/L/KdpYybnNQJLR0uVwtFPgG299t
zrPPsswk992XwiCFDaFbkWaaMxzOwBjRhcbmYlqRG51Uaqi8YSl0NM/OgdYPD08I
OpKZrg1c8XdaHxLbsWA4jge97esbn3QnE570ceYUNM9cfpr32HyXSMIyyENz3HTC
a8Z01xYa8igiv/ItF6gvPgf5yJc8bQZjv4N5VJ2AtKEq6wSLe/kWwOfdbhgCKWUA
v9xlvvYCekhZOn9fl0D9lTJCmLJCwD9C9kd9bpy4a3Ok4NyFhCB3Dqmvq45q11bX
0Pqh1vq4C8RFQbkFlUoQ3CLzlsPDKenx3bCzuc1pyUS7vvjKKhCCwaixdaj9HlTT
/NOlL51fXP7Rg7mbDkDIFvCX8Bu7hG7lz3ZhbnJojvUn4+0LLCBiw25cuqJHBcyn
B3JDq2SqfIpxreqhBvkxFgiakIlr9x6Aj1+PJOPNkgd3KhwGIILCVPvdKqIAePgZ
x6O5z5sp7gVJYHrCgmxXsf7fBLRgd2+OC7hgK5FA2JYfloqU4xCJ2TyGdmEPGNb3
BjXL041q09WmWdAuppY3UA5j6BlpM4BPOQgZqe7o0UZ5hCdbkVhZaBA1MG/LOi83
shCPhe9eHY9/ztDP/psiKkqVa/HwMmJMVyP7PzoaGsB4VWTNqSnN8noCN6b3oDES
vh/k3MMIRg8TtRXPBviapbRKwTLShy3836UTPlShZmtWpSY2ctDn/VaNqI4C3JII
/MfhyEog1p2wpg3jP58PKmCu3ATVr2xl64EGbWyEh+FyiG6PzpVCt5LC8ah1Hecd
xUTHs8bJc9jZZr6xjpoFUrPEK3BDsC6LTpnjjKHtLSpp8aL/izfWH2lRIuGqsnQC
HNwN0e40SiQtgBBauh9MlDpVDGUIvjt+G24qsCM/r09qOSfmTZRX+bmn1nF09DPn
1ZPQBfMHNhOxP8Q13sBDAQ==
//pragma protect end_data_block
//pragma protect digest_block
DKte3W0q1Jh46kEz954Sk3yaOHU=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
oKdX5pZEjddJ7k5MdDM5oxYoEtyAvW2di1IQc+GVkgzk3cDgLJFv/DNM/NvS+Ncn
OzAtP63y68NNSAG07nJSB7uYWbvB+vMvxymXAi8e0xTgOXkuolzUxYKgtwkydNsq
9pUfE/Y3rj8UeKYr0mKXLxVBzGSfR3P0MUkL27A8utVrriZE/DSiQA==
//pragma protect end_key_block
//pragma protect digest_block
4LsYrTglsIhOi8oisdz86lsgjGE=
//pragma protect end_digest_block
//pragma protect data_block
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
7zt1EqiFzIkG9z/ISgI3zy/mUmLRJ7iD7K9oeuGjEMrCDJEzTOOO8/hbX3yC6/sR
1e/l+5orB7ShQ4ALub/HuPkroQgq7HDYRk8eOHSlf45dD8B1h/mmLqsz00LzZ47x
WNgjlcEFxm6ns42BQSTASbLL7V/K/pEKAaWAn94pbtqBeNLiWNZR3bh25exI2oKJ
BTjyEmrz1m16g2g+dLS5xfCI2mnO58FECdHYkr/C5p4QAIUFqhH5sRLkTTPuvSiJ
hAk1dEbw7tpqSm53yUsLgFO8KIh48zJ2CyxuqRD2jpTsC7sQtIScJB7r+kb18ZOA
6nAE7ZVK3MHptTDPOtFAUCKN9b0XRUmh8VYMUfR6bQGjH4RUlddThkoo3Khau0QI
R8LwTiLcPuEw7bBIqK5Bg1SIC5y/FekvZLE2wslKFJ3fhX1IdWPu0+sQ0BQWb1r4
dQOIEtacHouTWSntfYr47/22lAEImknWBM08OZMwa39QCsFADE4BzxPar7/w2H/s
3rByx25AjAcZHsHy7klY6DGe+H4U9vzJ4spaWc1E/6mIVMTtSUHE53WUReAM9pUY
Wr4JqSFtzfuBMRlbTLaBCuqc+PMUYjyje7PqVnUcKk+mWeehL/yIO37UYNK2BeZx
Aq7FVyrrmYb7OyWNfrBh8EuIalmakh0F6NXfVQ+yxllkE8Qg3r3ciZZFo+tgxQWh
UuUK+ril4OuPcyMwkILl9HXQQIg+gYGz3D5Leq2rLE6WnGWRot5uUdgsqayl1fDt
ufQZiXwH2Yrhjq9VoHvy39NZ5dCseoZmvn8GA6WpAVgS0IxIJ/LQR6RuWt+d1p4X
C5v2sadYYp06PVdf4nVbkxcZ7/1ND0nXydaZTA9IZWOVMjjfN3OXrH/xj6jyGTe5
oYi2pFn6oOCDYzetdb1UZ71MW20qx5jRbB5669gOuAIIsFbQvQrOfXgeDGWmkgI/
TKMk6tg6/DS7TVu7daK/TdWkpJA81R07A3lInTBBJucFm+pWid9zXqbAiGJCt6Qz
WypYlfOubts4V7Pn950s9vWHhueiMXL2wtA4IPe15INfqior4NqAjXtkiSyW9ZlJ
r+kMZVmq94gtGtltbBZ9L6dBrlnqjftkJoJlPxD65R1Xnaw3P7d650dlvTq0x1vy
tRt8sMPNjdlrD/fLmhDzPRB4Po4M9JGg9A4sV7xKHqvhqGdbI2WgbbaR2aPmlKfk
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
//pragma protect end_data_block
//pragma protect digest_block
MWynvx2gh6laKomUUS5djkQ7fZ8=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_SPI_FLASH_MX25UM_MX25LM_DDR_AC_CONFIGURATION_SV

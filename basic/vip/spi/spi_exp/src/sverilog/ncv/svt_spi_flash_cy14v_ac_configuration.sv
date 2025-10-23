
`ifndef GUARD_SVT_SPI_FLASH_CY14V_AC_CONFIGURATION_SV
`define GUARD_SVT_SPI_FLASH_CY14V_AC_CONFIGURATION_SV 

typedef class svt_spi_mem_mode_register_configuration;

// =============================================================================
/**
 * This class specifies AC Timing Characteristics for SPI Flash based 
 * Cypress CY14V_family in SDR mode.
 */
class svt_spi_flash_cy14v_ac_configuration extends svt_configuration;

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
  real tSD_ns = initial_time;

  /** Data in Hold time   */
  real tHD_ns = initial_time;

  /** Output Disable time   */ 
  real tDIS_ns = initial_time;

  /** WP# Setup time   */
  real tWPS_ns = initial_time;

  /** WP# Hold time   */ 
  real tWPH_ns = initial_time;

  /** Output Disable time to drive MOSI/MISO ports to be tri-stated after this time   */ 
  real output_disable_time_ns     = initial_time;

  /** Min Output Disable time to drive MOSI/MISO ports to be tri-stated after this time   */ 
  real output_disable_time_min_ns = initial_time;

  /** Max Output Disable time to drive MOSI/MISO ports to be tri-stated after this time   */ 
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
  `svt_vmm_data_new(svt_spi_flash_cy14v_ac_configuration)
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
  extern function new(string name = "svt_spi_flash_cy14v_ac_configuration");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_cy14v_ac_configuration)
    `svt_field_object(cfg,                  `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
    `svt_field_object(mode_register_cfg,    `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
  `svt_data_member_end(svt_spi_flash_cy14v_ac_configuration)
 
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
   * Allocates a new object of type svt_spi_flash_cy14v_ac_configuration.
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
  `vmm_typename(svt_spi_flash_cy14v_ac_configuration)
  `vmm_class_factory(svt_spi_flash_cy14v_ac_configuration)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
2H8PoF8ZPw41nTVxD2tUdihKI4gtYFs64xMtJBFL1xSgPtLcJjdxKR8XQz9bzlfe
81vYdzorkz1nlzU3E2rL/Won5jiYfcJaq28xKUOOVVzKLPF63Nz1xmvJNPTBGfBR
uG+gQ4MFfMoC6NcqPLYhrJiAdiCA8OuhoBqs3caAvy0uYx3leuyVIg==
//pragma protect end_key_block
//pragma protect digest_block
YbZuMi3AipBnV03XZ9sJGyuMpfU=
//pragma protect end_digest_block
//pragma protect data_block
0v3trQwqJgIxvxlfNs6mgWd0aH+ozTWJE41jkIumYTp8PtuPYOekEgQvpenmQpQV
5sx8CFGnnj3GSB51ERPqrXdx/GngTyLgNXH0gTIUNie43RLRbkw7U36jRR4m4s2l
RzZTXiNoc9ewXX8Gqm7B37Bk3bI/395k3vNZ0m+VlFg8K5VRFSSoYmdF85brfRHb
DaMo/KxjZv3Y5LbzYd0yElCErKGf2D8AeIoI69yFlWFh1ALniOkGisUzzuortD1A
K5DVQhvAp5GVcT+rXKmh5Qh31aTRH7Ew7yV/YGOct8enI4y/fbzX5LTPbmLFgsRn
n5vCLhwwkhYA1ONTHP4nk+66xl5xER6xbWBhpNuj0xWm1bQDZp5rnetq1SecvV+r
gRTRtITTuTPMn73ci1spPneJO3byGdGjhx1+IbtIzwvGWOyS9NDi0L4M+HQMx5L0
HTp8uHLSXS7qCI05P7YN+jHNI90DN7+8eVbzY4dChHiiwyahe6NtY5EKEbWuVq8f
I07ynJGAzCs6E0W3mhHD/h8vrExaRGm2HwZkwXCmxWtpLCNB7Ppw1qSRW91M+db0
wbq02/W4xuO/YLO62a3O6OC2gh7SsfPyiXstzk9rcgIpJFeC0TIWFBMN8s/zSSSR
9LCN2N7zKelrZMmG7EU6BW0OU9kwFKHitPPTLGliocP/HalV2W4UY4L1RG2eHCYl
+SH5Pc59b4JzKTfcuVIbSqKwTpl26jPPoyuvwH13hs401rior/tizNcEuShb9mjH
L+I9gcBHCFAeYZeS5Xg5ter/dU6NsX7D4L+UgLNC53laTDYLdI+ecFoGyqvKIPK2
z20HbiWZoxv5vSy1n2x4EPwBYIXkQuuxy7E7oQYDum6zZ6Qaao7ot8CatUrXXSJ8
0bOgMQtkukWDiFYa9UJ5MmRpkXpMZD6XIzvh8n6X5E3y4JQbdOI4ii2ixEOeB4vk
/o/TGi/NBOcp8YuoroAHM6AhNx1Oixyb7vGK4t/zp/ZthTmDaRvH2yBA+SzwhLoE
wgD3UD6hbo5b/ReTNDc5AlPd8aXJXdVySoGYQyR8DpVYwBWmQ+6lechKsb3HlpxS
CVZTeObwwfDldKz/yYptETLB5Tb/JliKe2aWin3yo07GvUAtTPtMrVTp+QR+m1JM
n33X1qS1rAhI4F7OBeEATqIj6Ry0RDxSxnIZJR9D7FESmZ4oSKAfPcivM2/Hda05
ayFtuAMrUiK3juX8zylk9A==
//pragma protect end_data_block
//pragma protect digest_block
erbk0UxAiEQlLRRFGm2Pq+RGDCE=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
fPVskeKZze7vC7cC1cUNLjM5rSERkukepCW/IUoWMBeZRcSKS+SEnbIuAWBICKNs
zLxWIbRwP3m5kgE9sQ7MKSKEho1EqcroaCvfJVUrtwrCgonC8p5xN0+AYu0j8WfY
sUk2nf3GFvS6Lydt6efTM2tponAor1xXbbuVFQo66tRvwWOnoDVCiQ==
//pragma protect end_key_block
//pragma protect digest_block
Xnm7IGSOH0EYs1mRd5mpJYhBtzk=
//pragma protect end_digest_block
//pragma protect data_block
CLSikRb/iZiKZNkQZZ5gUAVmyfXykYm+XZJyIM9DEZNoDFU4wog67UqJgrjJiyrd
7EPz2GbBrBwG8Lp9guBaVrhHbvdZDV0vrVW7HlqcQWbJHumHyx0bDf+mEKGjvCHL
amIiXR0hOemXtedGRQeVeD6rafRjNIFpdif1kcNfzRYiLOaCwc7lL8/ov3nKWybs
xh5HIWUdIIrnw4LSqxzWEFUjyY6A86OdxFakErnUXH+WyfbMJzVTB8as2bKnQKWd
U9Gbva/VIwxWQXhXhQ4wzs6T/vXMhEJmKykCv3SOr5SEEdfBCMB6glAR1DVV2Syf
LKXP/hLIQkIM4Zm2Nan8FlKXDlNMp3KrfzMW+8fUgx9fm0+HFdPSuuxxp5rAdgyj
dwevQYYA/pmNbQKNqVn1om/sKLTkF7JSJCxNy6M5Ci7/6H9dOrLP2rPy8xu0vUiW
RRizJWebVlsyOdbM1mRmeZdz7iIhgPRiH/KSi+VWkw/n2pUvpCuaaGgF2/pGmmB/
jHkzyLEy28VXe91kdHVRJEkAEJY108YSvN/28OJHcLvC6s9eyk6RxCjVjvkwI3fW
UVetxnegJIArRSx+Bh9SAK9FvGuGUP+56xT8861oC83OEScOsTSB47waoRJV+HZX
KLZ3RfOkSpEjHcKd5Uddg9VHtth0y3Kat9yLfNHS7NkkHkVYEgj4acmW3JfbJO5v
3KRrqqFakOHP6PNDZ2esrsYzjUNQdv3uzOEtBUElWBFSMyHWmNu3IOjRL6XqA3sp
p6swUT6Y78Niqk+FSQxqXNnGDEYSHklsXPyXLNJg7/ZY5ZLCLc5+3kW9FobbEcJV
dVmzebl6efIFr1KCtugxltMvbu558reAtlkxQq7dNe376qQzU2I46F0UAKEvUg0Y
7nzR2Fj/YeH6KuV5F8s7db2+uN+t8ybdpA8VBV+K6WgZpSKm2IsiKsAs7cQjbwbF
eewTGr5Cdf7DM5qSSpGssP5+Ilaq0qnIs7s6b/Me+z/726mz0wEtvYU52Nb7eu7p
3lmeGJjzWN6wnUVf3CQSRqACTArCKJ9CR/+yckYFTD8mFzKN8FPvHvIA86yRwVvS
H9SVL8b1v6sRRJ3NzFSiNV5NKxSjMpy2LFbQfUIpA4fdEWLEeT7GZs3gkbW2XQqS
6YxCMvRZVlI+PRAjbQEbTg++cPLh949EusLcJ3JFh/vrEAjX3JZFH/gVOcBT6adU
F9yE2z6daqFS1FSgMMqdTnbUbC2Ivsn8tzr/YgM+HDSO/eS6otTbCp0nNz0l/gGi
qkSx1xZ3T0oMOvUTZZAyFIDlL//cCad2vstrGcl1+Ha3nwdd8rrXDxJbwioB/EK4
KTYjhkakzRMLIXE9EWWLuuPYm4FwpddGyLYteRuHmAJumFvuLfNE/a0F4O0P4d/u
yakfFpfzl9JdnyUfovL2c5saLsTBC4bCTmoAVCR53/lb1q7bjxFJvkrAskgmIc7m
oBJg3KuDwnN3q0SWtIwt1OOU/YQP17cdS4Ld2S+N9SMOWyrwW2mD+3yWq5rvnNQ0
d0fh2KRuyYLmvhWscUsu2YhYQYqCT8H6hKHADktEKEYyu/yn459HPLuouErVqXnk
QTY6xeTscNQH6XV5Klw/yZ9VO7W9jTvii1ANrYPLtJjqFvCZulEGyFZujbTOfPgx
VIA6BXfrQdYVqchoOHnp8VW49SJBHmKaG5pUCPKf/PFwTBexTPMwV7KyjsUjUvL7
Hq31og3jl67Ib/cD7j6Q8xg2frCnypDM5CTGDGg6L3wDkG/RtgFrdgl3MxVzJDLR
joAihIZKg9d9rEfSP/82PtJWpRvE+JJDtdZI+ZUTs/OSAkKD8OzhVZtQckHXzynj
QyqP2WISZ+QeGezFkWEFm+O9FIJh/cadpsXoDmIe+xN4bYolHNOh2CWTy16FZ+cF
ImTEbEwDREfACMIbMvW55W46yGuOXI9+3+3hb5ou16N2PGcchbpjkJTtVTNAKcZB
mjEK+OG3vahmBnefx10WU3YRcD3vN5T81T1Wztl6pXLVrAscwRts3VNFrRmeXyTK
TYsFUZGpdI859nMiCwVARds/cMKvk6BvNBnSN8MgeVDT8Kb5KFFHjz+6bFec7TW6
E2JW9CqNpa6pEY+Ppaq3m2/FsVmp2xHgINhxh7R2iZTmpYl7cClM9EfZ6RaWxnJY
CdBfQCqlJr444QeCa0fyDdkf+Hqt/zNsDXnDcwA92WBCNLesgip7gvXsEQCIxP2m
P3s/AjyPavNE/yyHZpVS664saxY3GaYPXWim98ryv1RnGYGd4m08XMvGqJYS/RZU
0XMfiFCwnIF0+YaAPR37V0AMlukwoFL2ihbpd7XXjkHSntRZfM8lHcIrDUoWYsCb
F+PE1opHPqvkvKh+7cN5mPN+mBv4sy4kUiGJv57ZdZQsPvSSDS5kD/kS4XhPCgjQ
gSAyoBObxjnwfEHcz+FoXHLqxllitVKfcBoWVhSjnJ0xnDQHpqM1EykEuO2z4QrW
GKm9UT6O+zZTD/M8cMMzT4L9Rmn020xex8bwTtLHgeZFe2ygfR/0yhWcDxgb56EH
ZXhD48EYNq9X1XgkiN8S2NSa3CpnthBmKfYNgFvomtdyv2YlsQg5tAMZ1PFNilaY
rCHhWGuZIhxoZW8rXxtk9UgteNn3hRaqcX8N9HawEMThnjAwshJ0rPxvJGKkR05r
xSyqjdtwQ9iaZLdZ1rjNTavbrBvk5Lg6iOoUvEYmXkEabEzwgkuUszNMHJ43DhJ+
sSCDZinwyLwyYIjTrHefhww5kNuD1UE5iVkLjkUz2tEBv7Rxk9Ugd6uuhil0bOs4
F0wOnZu9k/LAr9HD/ci5V+tblI1lQwICnjaeCUfCG6F4gU+Ee1e+/d6O477NXk1r
Nt4hET6nmZmHZEi+SvnGsv2sbcVRkv53kmex1/Gml3Lfpuu1gus6lNkX4+yGbwnr
DVFTbfdpa+64kOgHWxMraLq8PgooIQ7R6pDzeN3/ps8JOyIgYG5pw9pBgq5YQxZF
7vAepNvCUchwYpiB6+fEWh6iKOv4Ua8nCAiYIJaGOM2uOCRLdch6FfYI/KEPEXCv
MONTr42QZLWGaGNIRlUo0RcUKMVA65SeZ2jrt+qosZcc95ROSJ3orkfa8hARXjme
Eu+MIDhg989kU+PJAM/NhIYjOJJH0GWqqA2bO8jiWF9Y2U30RD8G3/ZpkW646JLb
KBVUwbAq3jS9aBFwRtyoqhst5oDi6pxuTiBtWIlL6eCYwW8MYHHc3Miqulcw3GEQ
qqz8dOnQWQIJ+zkTNVRXVcsBO2WNcMeWMsKC/+K0ydF7rWWa/robVr0+k3ROggAq
3JV9NkViF3dkNKyg0BPJ1jom+SDDwhfUWarAyz8DI0w7QVy+esIST+gzHpy09YnE
oogXjJ4jpdFFxakVr1lmxpgQRZfo+ZKXEIXpNC/j7i8Z8Bt0styf5c0ryiMGM0E1
rTUvLt/phHrwA/p8TqMj66NaVZXkU8Ph27C6LzTO4oLXAN91I+UQeFKAFIVrTXpv
UJodW49j8SXpbepZKslb2wP7hzZGq+hRuRfmey+sD2Cv7E/tpdHgoXsA2TpREvuv
9y7dTAgPxA7I/6WMINY1pX+tGzn2KiJHC2MJY9xOsrzjsPgo6DEl4F7EvjWYCNsr
6YU2srnJ7s4CbVrpETPJC/oUEBSwML7aZKJulSY3GjgjQqCWiRdtr6eSRxS1MINN
DjQdwznjT+EtbyTbNGl3GeUyhcLqB/Yp/K0AGFD0o3rfCY3uS96aiXGah4hdRrKi
jiRyZ0OVM5K+1MtjONVY6nWI+WWND1ACi+VWmZsVdyLacVV7th9mJUPNYu2hBpRw
/6/0Qw7Hg1LpAMbSZ2wlwol9XW4PrDln1Z9ct9iCID+cVOivd4NU/ElyU1EOMd27
lL81mZu7SAAx7gSxQVt+XBAKl7O2w40zpqRYiTP7pky/6SxxEnIaa9FaG2JZ6Hyu
dYPfRWTSaxpjURNvu4VLqd2MX3VhLBVIcbnTNBA2o+WAtZCJpnk7cEf+wA73ptRn
3r3sqoi1zNAqRBUr5LgP8qSxrybVFgptGHC1f7Zw6RIyo1mRGpgfQ1yTD3Jp8m6B
68+nBTN3gSz11ARMRJIBOrlZ4P0/mirK9sY0TIYXLTuUlanPPqo3YBnuqFHe5+A6
SuCTmA76HXiCnO+NuoAXdqoYumdlVvRFtVtkSJM3SxmbKdYyzNqSz6kRQhTvB9n/
Hz71Q7mtqBGd5GoNYbVQrXXGs2/ldrzixFYIW7+J33f+3Fd2UYzmxIYn6DD60FiY
uhSLdWnJdwHeMPNxFzAIy6HBnUZcsqUWdsqt97F85X7kINgjvkxWKRHe6ZhKKx0b
KmsoJN1MDEhLHSKJPzWMdU+L2W/dqSFRwNDpPAaVPBpij7GOuQdYHYvyZcUE6wLn
spTCfcKgbMQV1UMj7vPfn8CpUOouWrOLhd6I1zths9gLi/Uc15iUHe0UMd06raUg
UQRbSwMo7EjhbCOdGspEk+cVnn25SKwWPA0JEGVJn28wo5SAOnpwXt3Ez07Z86Lm
5fs3V6OYoJ58mBN47SDNNsrRVJHbQ2ReCDbYfUUzrUlVqUsTBiilpbDj+XLxvptT
sqg5UhYghW3iJo58pPaYpvSbkRz9KpM3V3laDxdSoFO4EfHcJPBbDPAsAN/Zkh1k
4gWKi6im/SRJXEa4CaZLEXwTIjP1MMgnYCZlrYxl49RlEv+jFVHRkUdlI5oO7FmK
JRmP1EUqKzAZqX1dQn+/bD410ZxIBmxCTOHNsxkZZAULe/o4JVNQP95jrCeazAUF
s9kwjuYbIVL76vn1G4c3D/boLiFqG5vm07Xv5jwSYjkXupk489hQVheDnzWzuLTL
4XA1gHvOtYoIcWtLc759aUrNF2/uOAZbEGbHAotOicFQQE3qDd/CalYirrbd1DkH
IdAlhPjh14XrluUyeCSNYZyUBq/we3WJgLiUX/ORjkRTYJb8Y686KfarNMy7eB4M
KnDW3STOFqk2Xgvc9lpm95nPV+4TPWIk1KXACunup2t+gR39F8VxyHnQ9qmoxEG6
Tx/3C1OwLZoRUGyhOBkCFnnSexTS2vp0sk9PPLOmriTaq6Kq+69M0T9BDIMaykrV
ymme/QPag2e4UvU8T++Zog0ctjXFKxNWD/pk24jVxMxEKB/7O3Nw8XZIiq9+4Gon
q/v+3VFzc1TaixlgBQFEobjW5xBkJoKRoCx0sWdBQmKnTrEUFZ5YmL+hefosmuGL
U4CusZxyIfS/mvZj4qLCwTYL1IhqXwt5edca2nBo7ACGooKHQ7tJi5VC8H64W+ba
FcsRFjGhdKSZbMmVQXlykVo1BJDUEmzSgGhb2j3TUt8ovUgafe740qM1XXH5GdYE
UzRZaJhlzayoMtvo2fGBHdOwVx5mDs+25ljC7D+7uDbZJIYeFs8RWpFcY6u4r3Sq
czoPlM2eEZKP+2CxqD8V7v5Qy6xrX/2naMvCG5bQFVB0npS7ZPEHV+Y78YjKDYYr
iReZtUgFidc8RAlGN+Kq5KgxJV69bYrQs/A9/CL1CBOlOBfxX01x7qGA4akuk+lM
5sSm5bCzoReeMiMtrYSxk/2BZyXyV4zXfsr/P2UA6TGGuSp+KxxWKL12g+/SRSTZ
MmH4KI2dSeS1Kmod+91XtC+Knvg38dAKtRX4j7mkq32Zxp6cqdHv85VUODgS2LCw
cduozgPEBfFW/ysC+YL/Wk2R2d2G/hz6LSLmnSrhpNKMouItZASLCMjSA180ClPT
Lqsx86ltwdgnYi0TH8jjoAAujYHj+JjO9MugpUXQQtCRnAoHFsVQLOjFoqWaY3IQ
5XriJOmZWyFoj3yoxqw2fgHb8bJ4rsC/tQVCtjZH8vBWe7Y0QpTRuiYXfGkf92Hb
s+yVl2t17B1FMnn25OUhEg5QtczIbP8Z2t0Fq0/5S9BLH2Z1EWzQOn7cooo4IKUM
F1nouw08Bl+010oa0GbPcqsKCUFSg7OYPEhNOQ+S+dSr+q3+ZHge0qI5edEL3MxR
vbfjX1Of4HGq1DXtNZ5EaDdGkDfC2Bch03nEG+gXKO/kO/GzW6HRrOKq32/ZAobq
wgH7sOrwB0zM7Px/vEUC4IGHxaMFlXd/+TzuUjWhiqjPwoJ3DMl+McfdA4gqoRI+
99yh53kXo8N47tR9CtxphB5mhiym+QLNRFlmiDWQFFjPdcJ0aZCBaEjj3UmXc2MI
od0VXJdgkQTXeBMD4QZHTAVmQeFiVLoCi5rj04ccCf7E8rmr7+o2ejdlFQEKHPFb
K0HmvExMZcKFaqW9tm9dMwzKRHDzCm9z1th69wA75VxSfsiXszii+2Qmv8Ly3hpm
vO8aj+edeNh/09Jexv25KPtjBugMSWu//U/tS7T77L4Mz1kvhrEzOXl/4bdtd/d4
3I4qsF5FSPPJPxAtvI5a4Z0K8UNfnUquE5DOHfYxbJx8PVM9CuRRgNFHJNftgpsW
ODOxk5Vzp7mnvPPiNS+G3rVvCXdPfhrXdEcxfdTUK9l6swVALtrol3wwM20zOfOF
XabCEy+aZLK44QxqvReF63BihcKdx3NY7qdMAivZ0W0rCU2J+IY/XFCE2DmV5Ygn
z+3g4ghQ1HvcsssXDyWz74pVSaYkzQaBXvAqyCZrAvOcTAeVIYjqM14MJv6HZ5/G
80rmE+3utzTBIQ++VcaM+d9zsCNNQyO2d0oq4PUsvhJK+Hy/laBmReflR7Qy9itb
Gl8vtQ8OYRTmKrWt4i6f3r1dYPqExQHDREH4Y2cinuESw9P0luXdI8Biguf4eHxo
EuuIK1A//23nbzG5yzzDw5FvNe5dSorHOa/16Qq6pAY6/kABbdamFGJqWNbIpBlp
dMnRKBEtSXLlNzIt3zeDFBA1P1xybjxIHfjBObgyJb985HM2LpFff3qKX/jWVuW2
AKcYRAjJs/r61pNM+JA8u6DCCpgf8PhKKsPjG9OGM1PYNGcbkxfwg3+sEUIIHdIh
81SyNj7zgzH54akY43Z24eLbdhQWFvgGnZX+YhQ59+usFG+mH3rtDfrGNstoxsRv
3oHiwYFiTcIMdNzikxqGOX3S3jiwW8ngBQMrJLUNW/1IQGR85Ezn+V3XXR3Api/v
jUvNgPav5Kk0+GYRreuKuWMKl2l8DKpXKWmVYvDApXzleeVfR5hZhI6UIiA3VOyJ
T3s2Am3nEo6Dghld1W6wuF6AiNRSOsB5ZXTEXLLrtPT0yfJCrR1wqVR2EZwtWPSF
KDIhqrh5xY6fzkCJIhWToDLMpEvZ6V3CVehj/T7vdLf+maS+c78VJ2IEmpF5gPby
9JhyEo9MPwn3iOLub6viMQnCems9F3tybJJjwmhsxM7w46ZI0ye4hqhHwTU+2gHV
V7fDbC5qKuS5PUiiVacH9Tajq7glAmW3z4l/98XkuY/e4Yq791NAZTWtF1ORV5zQ
7qy0RJ3W+liIrPsXOfgN14aBbzvE1DyGn+x06cYgb/Fq3pkhXpwArFFQlMVQ/9wQ
8Tc1kFAUl2gga1t6qG3b7DRUZ7uJiSogiUbFRc3SpqVk/2tPfzM/ktx677C5KNDZ
fhvnsKKXnVJWDtpbyFw4jTGrB2OjCAe+/7swjAZHDFw+JCn02BcLZi0wWZXCF1ld
E3E3FFxbbiESKmoAxFGtEvAFUqGHNK5rKqQO3z2GpRmikhpFIWHMOSK4oUhVLVwh
J8FkeOGlrNc/HhB2YAcOLQz22cKvwoiS7zsOCQ/3sUuKrCXQuDubbsycSt4K9XC5
S2Mv7hw2vmFdJrDlvU2BmlrgkxMqGq/CemcgJEtsi8zbB9qyaIjQaEbkGwl3y7BK
GINPlOrcWQHXBIYhfQmoTVHKYfK3wqvQdP0xOyZepgOM6qZ6jzfm5SMw5kxdFU67
4KU3BgX59cXRNSU3LBgHsoC4WfH9v0E5ilaPeqqAY/EMaV//FegJlDLUhzElkrHe
Ft7/FiXyhwzoBBBYZRvNtrtY153C2UgAszx2m1bnnDxyF7ltz4EvGqFZr8Fj1Uhq
JeWjT0PEg7yGgWM90wAOpErQCT73irI+BQSSTyL6FjrrSHs3E2FF703tC2ylUheb
eBaXdvdUTRkR2q8uV2HNNqtQ+Y38eMOmEOX0TnHr0D6bJoST7qDu8cDh7I4MHacV
/Em6nZzXPfuWoDXMLSpUnm2MEcaYZwnkBaHe2qv2A+sRdy5IRO4gBs3MVGz/rdWw
kJaMBdsQoNdamgqd0uldXrwKXwwDzxvghHi8JGtS4l45oFehrKMW/hqrApE33Pi1
YNTNW7kBMNuGiQbpctitEbea81JkgWoIpVR82vNq4e6j+4Xzq8MU5/9/zGL+ZeTU
W/werNjWBHmOIeRPRwXuMkRnwogUcZuu+VUxdZplpRbE+Nisd3vSXgZP092BPsta
OQMdfmNrKxzyZm6DyU9ZRvOYctR4IY3nyE7xYbBoCooN9v5eeY9PqJnOlYUGRxgF
xI0k2VFgFsQ8ikg6dWLDTjguKOe9nLRp9ORpv19VGeARpita3lzl/FarAdcBdAQr
B1dkqoFn/c2+B7JMuXOV8BJbr2VDhgfRpDL+akIn81uNEIklkNIn5PbXo95dmZcG
YXjzOI+wQoBAi1ncyA1AW5r7XmwyIZaZGi5cASxRXaYSYtyALPwctmpdO/X6QVRx
Vv1DeZ7Vrao3klgVG74oc0MarIKOODcM90/YyWPSNMU1YtoVm7uuMmhM/jFfovaD
aik9KOHZR5rsynBJeZNxHsAVd4WuVFsx4qmsMWzDWS9tYCQ53Vh1UA5uPzCbKekT
h2vABkd1AR87tqquzVbRVGDpGRzdvjr9o7JpSCT1Ubuw0VeUHt8RxLnSewue1s4E
efQlPjv7eoCdPI5yMrgy5T4exvl4gX9NGz5nsXBXfYlEfOXd8Dzc5cwrOLmS5Mow
FZLVWr6HHZgi28muCVykYVv9GS5hFHm8PxEaSyiKpAprCwjH4vrjhBeY4uQzgJrH
ifWUsEyBAKPlOANjGMnNeDJkQuo79P8IAfI6bGJS9CXVuue+yrMyujQikCbQdXlh
nfihCgU5NbbQAn1nk/o39d/8U4nhiUjZNMOc4fv+D7suvQKmGQSq3e3Ydac+bY7C
4eibAw/w2HxjF8wSjv7WhYvWQf1ef29D2aGD/ke5V3IQxogUj3arYVRQQzLwq354
z3eVX2qZLA+voTpnmDw1AfMx7p/2P4n/colr/6L0e5jWK7OG7iPDO35+62JnlzID
ZHxYBv7ksb5dSyw9VrorwsxROryiXrK1Q998BJ+/DteqHDEm75KiV78Ej8as5QKB
k4l7rKt+auxCpT+bYMiGduVV/fnrgKDDuYtx8EsO4mOhkVryJsk1PDTvFXKKYkCo
IAbRYHTJTddLN04L3CTLWru72i0Vj8zW6ALCPSxsPiTKSqZxTfrUVtSvGegmWkjF
FXZiUNbtlA08ZQm++80Xv8vLpo+E/7WIIEkXlLw7FLGIHfKyQJV34x7GFECSMILn
Ay1HSlcV2maBlwIbhs8q2MnXHUBWbO7PY3aF9fIB4nHp1m3oTKOw/ttE9eMlU+rW
nD5ROK2ZuIHwRSU4kQ1Ng+tkjdMmrgfOaaUs95XS7MthkgAOZdE2u4OvWWkJhwLA
FEhR7/3w7rn9Lu/wxNEhCsyi7MMt8JBRcjWWnQEJvt7dqvbwG+X27jxlM8MxdZjU
i03gByOG58Y6AB1W2VvJJN5lC9MOvyGnmWH/jesFr8UCY3v1M0zVxPpab8nTvLfJ
2oyUC33Yp26ZmnOpSJyCAP1oZYHAu1ctOcGunk56wuaEbHD2d9y+oXfS/bluZq9V
d1ky03EPewJoJUg9Wur8bnSZ6Q0Skl5RWjLCV3Xrr5/wgaJIWhoxE7hX6ij25NvV
sYmxzd/XdF0mabs5PkHdnkuB8QeSvSswJias23i2SIqakUVyECUy4gNc0a2mHEDU
cxiQx9kQO6Jzinx8doW2XvZBhYssYbViTwzOMs3o5nNn4D3utjT4vgxDr/PVZXZg
TYdVBrtBeQMum2lvvNWKCYF7tFxMuOt4yRm6UE88Jb1Aw1Re95WaGsimnPfjGouw
rEFE6gH8/ST/uRssJYfZeSDAG4kn8gHgtyJ1N3wqQWgimyuP5nKXuWkg4skmabhU
McFv/7gGiHWRBuVe/nHx5dgZRSU1DAAOymMslWQi19fc0H53ej+Im77aoaY70LYb
L4Nkk85byDnE4meYOODUelITVa+Mm8U62rHwDi+zasiYLbECXaxOFdscVXmIlX1i
n44HZhinV1FhOgj5KXE1zfyr2G/lMCy87KzV5tseR7o4uBwkRoG6Qvq4ckxemZzb
4wQwYxvpEB5yndNw1KHqttXWzAWvc9DHO+jIs9kQWkmJsZBZtLoctpoKjCRguX18
uIX38NlzLFo0rswMD0PNsjLZoN7kfktU2419ueWmD/+rbHsgBBdAzgT9W7SDyAPU
xWrS6LdKN1d4BfgqVwUe2t6NYUWPCVllonbMALT1womuHm9aM/J/8dpZJUytSpMM
mra1U5bFNXNNVT/MkLVX5Vos8qbePF/0XjMQ7t3GNxkrZpbX2K0QI22n652M2A5f
EZq1F9KcbblPBkKyHpYrSuyNchKeqGj2RtRi2GrIXu/CIjqq6Ca725yWP/jQ9S1R
x9ec1gNG8WBuH0HczOUB51jYAXVkGeTYBLMZQKYZiFGHvsvRYJiIWYYJu0VvqRVv
3sRaQgqhDSTcBm81pkhY+sbCnBDr8U4byssXWoeAtMrEFIbIYY2jsXtlkgZAOQ/I
BW7PiSAi9RphVE3SG6dEbnKMM6oetcA7M2OpBEI+agu5ltGd3ldrBimeREtiwP9h
M6VyD2VVmt7KkMHbZP4mtQhrzJMs2jbFm35SuMy5vB2p0HcPt44PuAA8x25m2PFD
8whEgLTv2h5W0/8y2+/t5zVFkqxcbR8PmMRTFh9WnYWv1Lzg9jiQq7j7bA01KJJz
gRp58rTLP05pQLgyehKjCD+0OJR9MK/LR0DX7teUmi++L5hOOnQhfpBLn2iIGIbP
qP0M0K+DkQJzyonM0td/NlTiRsv0IsIf0xA9EMkwdLTDiCJOYBEbkPpye8UD3mN3
i+hrc7uDaNFOdFAQUN73AASytkVED/2g93yM1uenbVCkpDncfflG4D8yaPz0Y0Ph
97vrWukV5riK8kqPuLwfE0Xp6xT/8/2AnMYXClkKZ4jpUC9XkCdwDqsCJGC1qIXL
wJwCT/xA2fuyyHdcPLSejilrP9w0iyKxhQ9joQuFfNAAECOIMTpfZOyFLM71lx38
NZZ+dfh4SsQXgs7as1FjIYDsrBCjL8Cyfd/mxakm3D0LP7ywqBzu6ERa8rSkr0Ag
ePczgk9HPhjSFszQMVgNB5XfJjSj6m+nBCU2NjjvFUq/mtpCrY2Lwpr7w4HzqPuE
5wtqJK2fEZYfVJKjoNjUn9P4U+KwsV8pa6hsDX8zFf5aDmYNA/SMIiH093eCvWt3
DS2onXB40TLaRRuAGioB+gucqUe3qvOOXbpYE8s9OnCOiFCRNSOv4fFbyhKXNW2e
Kr+WPKwEWlz6uzDwJcKigFFh6vwweo45Ke48/ac/7Go/xuKbSSbALoRoQwvjWXIT
4kTYCbpzn/yw9H5W1EzXUqg3r9EmFVmEX61baYXo+/IWd6IYpY6QR9YvTlBRoaj0
6unrHvXV5jpcKU9rPP6stOmy699hIQI5PVg4JrvmoYRQXc8FgIJ0ibKf7qdrtEMr
saSoY3H533JAN27GjbLWczAf7xMJn8ACD/pGvS5d0sQOBYaeGQ2QXLtCln7m5qIq
ms7BbiXuy7tKm4pOXsOOtYuXsvulbCKmxDp5kJDLjlRTFP3VIISkXOPtQp9XZPrx
seUJqwDBzOWUsoxJz9w+GOd6XpgE7zsI+Uam3Zq8lC0c9C2hIP7UvlKeO12LZTil
Xj5GmHmhkJg4uWb7PonxvuuRmpt+wa6k+EifkmT85YSva1xIeYrAv2OQiriNKrhX
1Wlu3DzP/UjtvhuZvAOsRtVXaroKyASSdpQQzKog2/iXn1X70tHLcm81/3G4JQ19
F2gBbRetkY1m6QxvVZ/5rXF8r5qdAjgfP6YZZqwwmhZhLwdFga5YHWdpBLMtGGs2
twBbj0lgx5dEC10jNigFG3atOII+SN3Mm2BitTh2WpmmwwLP1A9uAPSme/rIHj3K
vRGk6dwl4iWfUetX7uvz7ZQAL0xBCRp3sIONMnTTMlNT67nUNiNCgfR5FO6OEty3
93ebiDQVtg9nKrpoNI+zd1bh/4XaUmvzyz3F0W0e16xe5+5zrEdBzVAxqnAChtzW
qVMZcQ1uFE/m2Jl1fnicOk6QK8FFFuCliUPPSn7wxgGfJJrONlZllL2yYF4fCqDR
U4HEoyjxLvAbyiOkKoQyEWP8mdq9DQLs/wQ4OqnIi7fjvYZurW+f81eVx4m1BLwo
0uXR+d4GWcjGM4ENP24cOjdMvns0lm14td798Jj2QkoYdQLl38GDBTwmPaQejQmU
oNaYrkrwAJ8hdFYy2YYoqiutdl8FHGMdu9G90P5pNAJtbHJIOLdSqa+iXVyhHXqN
On14ukQ2hNs2Ul4KtrEcchGOVs1aggnhJJaSS4Ek8P3wQBd9xXxzDEBLQ4O4wnjR
FwwKr4F4nt+npnWFNlXQPXgZGjIU75L1cwqCeL8Ge6c9QXblnv7YHq70DkwWuJIW
belLoGDLJc/SXXBrH2qQIU+CRkz4W80DEjMLNG8Y00HIeYlOdVhcUSm4lIACjnxf
ymyyqt+cTc+gLzmh6aqWx8wAz4int3VeNIk7WiSJkrbaOl9A5JIQVY9F2qubfF8w
BOaxPlm+NtRgD64Kg6Hl2xqcgJ3Lll79H/LVxkfy3hDnuLCW4VTs2KCCrsafb4SA
n4RuBemoqhCAcEON3ry2CnZiFPgMIsZtXytatDrIp8Z2KrODXMG1f/ZVpHop0u7Q
ZPkSScpDib5TMHd23JStwIzUh+HfKQ3p9rfuoAR4ejK5HQJdB3CYiAvJsxs2Zg9V
MG7hNd197xRmA4XgZGa51jSza+OCoWTJOsT+kQv8a6FHzsguYeP0eg+pnDpURlCh
hgduDaRVaYemLy+R4MZvXpBihxbpTr+1KAWNXvxsw8+UNFmGPcsG+8aY7k4c8o+b
neBfpvrekQu86z8DNPDbvh1yJoWLEQ9uGTAztc3pHRCHDHETvXMf/o72IP6E+f7J
HMjOzWIDS/NFgXOG3WG7boDIf7tjNyu0GCDDgyfw36D66H+CTva7a2/ycmuy4sTC
CfymRDM9E3lTEzGuKIwmp6ytsySbGtHKuzOJ4p67CvSPEzDHMjvAVui58IgD4LaW
Pv7HrITLV4hIiWTynODy2i4ELWCNbFymlBW7rltlteejCdINxf25GmaqgxLsBrue
RZOwNftytOxKL6mEHHzJnvpsINzYcL1AhcPUXEr3yXP+SugUkdyKmNCf82UWota5
oJ9k13NybsXcQRcw+mziubcualx9a9lyEh93IosQcM3IE9OLjyUIhjb+Hzl0GfPh
g87yjw3jnCVcAC2PvoYp6RkqCo7b48LFNzJgcyv2hqWgLax635HcQA70h2Dm9axo
AfuePyWengCYs5YxA9iZv/sBGHDLkk1o5LAIWgmizroNn2DDFHNb0H8smVwpOAih
MhXu7CyLVXppMRleM/fNcAFE2exsgqicR95SB30rz2uzZIIW/2yT5JnBzO7nqEPx
JQGbznoEMg2Msi/iFY1YOKUOGEERygPOLQ2n6FKJy9dLJb9XUAy7S0gAN9fwCpaH
IzGdvC8UuJRDPgKmFUxaXVfKHtViVqduJyxAY5548fpbKO64mYZx6lVToFSXdsur
xw0Ouc/98ARBwJU8VxUvEMAu3WcVSX+Ji2HDENIJPwnanTNQERSErmX1cUBF5EU6
8vMsGtbxqf4Piwb6mibqUm3VXcYuNUMoKQs0cyVy3F++iciDk8Mt3VznR6D7vdxm
nzRV48V7y8f5k9rm/r4SoDAnLG3Nma+Hj8L3tj6zhRTuIun9IP7sH82ARWloowGN
MjhekBryAGKQSXRDDno+iYmMHwJIm+L05GHPAIU7c6qf45rgJ21LVfhSBLochLZF
LtDVickRrcVoCLS7M4/xAJTzptxef9dngDZ4rXRtccYwthixgcwIPTf3zarc5mRu
y5tDojvQGvVXyyl3qBRVq9DpBq01IsJve6yWWbnCsfZtj3QVIXONK+ekS4bV/Fpr
Qw/w3YME2qzRcSQX40ni6EalFYX1bH8AcS4ISLcPv50dlHdW51yB4gwDNxyBVC5f
QEmj1U/8yoB5icvCpP4W6491DgKdxyjiRjz9UuZPnadjk1N2OEAi5K/lARdMMXdH
nJ+jujpvKWaTrxP/PsXxOeknvOVbwCNH8IS1YpiPMWw354Qy89P8Dz7DBn1vHy8Y
rMLT8Q/lymSh2p6tPR39ba9bH5/5kDaXcVhTKms7xuP7WnEDSqfQ9QBev+SJw/0k
fziK2jq9asJxKdYbGMonUAwj7AyoetOcA3N7c9VWIxzfTPROeTIUrnCxUwS1r4Ez
DT6v5aCjHUFM1x4Lfx95vSreYJ0j+IedJrva/ljPYJizhQiu23NSzmrkY1NkPBmb
xjTOuf0N3+yrAUbiTg4UQdQ6FX0lZaZzfaUcRqyIZcAkfwumOOgSN9gHWoOgpiTI
eoEmX+F1W/hHlB+50f8oT6S/0Nn2u16DMS7EjmEyhwoA3KwlJ2xm09cDw0w69vK7
kUeoBh9FQv56h16jxIeUVjTDCOfxQsaEFMtf3o/uv9knsrNXfCBcT6hZSfwoPI1B
QPuuSRW5KSMNTRBbY7ra5kDbl81wRjIt0H5kRMDVtksKLAWUwlBNkyadiG1ut5oK
pw5gJFBQxYZaMdMAz+F1gBpmXYee8tABNG594+U/1nWvX27effYRU8s3sLcg1PMs
6j4WS1MmRcmxIfBS3G/DxdI9e3aUmMYFvUuZ2ytZvh1YPQ5m7SDqm2fcUr22qfPs
CtHyufDHU93o3YSnO7wn+eQtXodtloQa3IWESlgRIzp6/0HGNWRc4eiBsPiMel+J
HKbcV9aOd1C9J2OlIJo58mWWkjXdC+IRz3t/6K4owvQUUeFdtBXl1a8Ww3ajVHIh
SQUvQDUCoXxOMyA1AJd61Z00FD/BQ4kuZ0W5FralhKcAtFKDROWmdm6p/d/hLeph
lKGOPzOsuGgWnx1OxK9gKiHIZTFxSpNLODw82k5qBB+MzX3a/ChJA5vd0XIH6VYa
vNf4JXScIAxbtyTYptCjK4TDt5VfCExgn3CtGNDME/Jm/r2AoQJNLU/hEvKYP7IT
wiX1SdnJtkwJie4NyOjyYJA/zgtSRf4pgAg9Cu8ms+ZUECLVAzatOJeZI3jrll1l
EPA64wXPb+kHgzeY/fLQUZ3ZaFgPsOxWEa8TIugBy6Gqs+gR6KVV/GyefYU1q7ga
89iFFi+KxPxMWv0S1xfZz7c7y2hJO08vQFmL9BJlqpKGofYOuxhGETk7JZ7CfLRl
sQ/pukO52ukG9+eMqJR0R/L8CrSEH9rWch22AO2foa6nU0aUWNqMwrpgiNdVmLi6
+nmmI3VHbJq0h5N65jr8ZIxkpoboU5owtfmrY1hkCHoIvkhyL5Q1tdPEON72P9pP
vI3yHRolDqA2hvIzS9lb0gI/hw7/AzXIf/058D0OMT1gC3s/W6FXXOgfEmCsRCcJ
GyIqzl00JfII1SNrNx8AdekoUtnuzSCf3w9t9gGbHsnVvBgHpnL1gtBIfim2mE1v
7lRhaa8fwyvONbcN2Fnt5D9e2PegmmKfhF9Vd0CnonpB2udCTkN5ngQPKSpmQuzk
4yYiNL77/IF2dGJzCjXUkHlJJA5i6YEIwMt8QESWVoqj+1A2t3cybgkYIgaAeTpw
sHFHGG9sTEOMgFpdEMAAIoW1T9ogyh9NEBId7+U2GX0OPoDdf6cHf6QCfQba4ytH
ehBJRbmG6t4v9eAArMkb/e+PsJLEqU5YE3Bq+0rNIPX1zaZB7ZGy2FjnqWPq7yBC
X5uwxTyXH1+aQu4ciVAeZHXLqijB4kDaET2lajjPjdRM4AKlwc7dSMLEQFlf3Bk0
jKOfSB8YSbqwbMcDfrfYQK4Y+8xAdXuV4urrMXfN42idjVZ2nZpopPqWxxvugV5C
XbSGC2jZ0dwv8ZzYiJd97kJJwPwaCpP0WW50T01ENlTraTCsFSacRKTfCLWshAyB
oGi3xOefisTOTuR5qSTR94xu2HPElW54DTUvpqJyEJMdRtEmy/5/8c8LAacot1IK
j7/Q6CNU4bryRNIW8lMpOBD4HPxEXShOZ9f5YUUJFxC841JCNpWB5Gv1F5fLGyl8
cV6YUXzZd/RWg3YLsoPFZIlRXkACqEKj77PdwcXhqvvIErwLkfdKDY1iNPmXD0/t
fKnFDxFer04roHGHEPC9EqqfAVaM0rD4E8Pc9h4BhR3CoL61BqkWmGtxR68NsAlA
bsA0aRcmjEM4MkaY0zdMlZ9/ajgK/yoa2JcOi4rK9uK/KIetma7hOmupA//GXYng
qJnPDB3W1vLVl29PTI9PTUTsWzKxbCQOxP6WLgga/9xajwXAvmT/2MFA+8cqklUb
k9i7msYKorVsUufx4mW3XB95xWg24RhiYtdmSMS4xF2wGwftnLsdoi7VwgAZl7NN
cCTPxvZKbI88e3BpF00iK9kf4l6JMkm4+9SMjgXHTOj+RN6NF/0ZuqDxrK1r9vEn
8BnUqjO2oBAsUQdh0JUzgC+wPPrTzRPkRsHvfMOb1AOY7UvcldEipEULWSny4F+N
c1DlkKxxdhLygwkCX5UE4832nhcGlDtwrbSO8tUU6gJZFQlRJjMOhHj71h2TiC/4
vQnQDoiKbL1Gnzj6hKf/LJCHaCDUo7fWzLNmCQ2AmMSKMqXBlvsP8vllG7a06G7m
ctqCfbhYj4q7yt1onY5RLYWFzlF7w7ZLQcS1c64bdxPy0cfA4f5rtYRCDN6TLLsd
YpLj2DTmFp9l6idsM215sQafJ0BIpGW5tOACHLPPflDZQG3bu34j7wYdQkqylP3D
1KxiDIjNECT0E3iNeCMVMCQJoUII2MEIvAxZrg817EStWY7ewbDrliRGkuAaiw2t
WxYTee4KflfYhemCcnrKysIUKQrOM6rE5p6Ry3O873RttjPrJeyJtggJ/rhqYdhF
e0s9HfwoTuOnW+1Ba9WACOQw5aLyFjdlJint4zl8mpSQGGe4z53XupzcD/LK8dhF
WxmEh8ZL5Hw/1DHg1De2zQepBC96QULTLSsiaBOSGrNKKFBExbB2uaY6ADtaNJk+
mpA0MMSyb70kMq/+kfgJ+3upWitINZ7reFtjliZtNi1MwwJ50/gMqyvkLuhggKNh
OFIfgpxvpILanyhpSopa24e77H6TakM26/zckd/iszZw7/RHLfDRz7bdSfkK7uVW
uw8b9ghQyEr8AZiyTqvVdQyqTcO/3pJ91LszpR+ciE4I3Iya/Xsxy2HNyglw+kKp
g4f/5EV2C/7oHho2nTvfZ5KwUWPdg87cnP2M+VSlwj584eTZHCQYZOu3iaS+gFRT
ibxborB6xWsqil3OrcCvJ0GWECc0GaWIUvun2S9859uEzi+ehp27Mq5I5+TG5Kaj
7q9mQau8fMseS36+2iG4SQDV6sUIZFLgJpV2IE/u/M2iK1E78P4Xc+IyhrvHwO8C
EqyE7y1v6OOOwZHTbsw+8lKWYj0IlLCR+6yx/S43HOoXJ6T9WOZwm8C4JLXCnBne
XXJibKXH74cbyEFiSTHTj8Mp7eHQagU477eGF91zMfneG5kpovAlZQzICunoyE6S
W4VrgPhAmMeKIffPLO+5uy6HRs94+JXpKMC6E3Ah7upP5/bnEsGTxpsr/qWDiVvX
D680XW1YWRXyrSTqFHiSxrIsdgE+BNxcc1dyYyhCgCzKcAXdxYsLg41m41kGW/7R
fdSNG5vw/GH/leUcLWPBj66KFH6BMusEF0AqGnNSbPCWCF2eRR/s4jOF/6nH/E3e
PWN6XQS3PmyF0VUZvPgSfFXrse0gstoP/Qg5oqY6JcJC2XYlhyu5gSOr3fY3NrVH
o4ImmuoKoQvflOFH0RVCW6y7I/Xjz5+NTkJIpm4DLnsLEM40c8YyCAloauAqhDM2
laApx8zej9O7MpfXdXV73Q73r0rD9EQ09eE9v3GRNDGAzS3WMcdXK1aINh1YXwza
7mVNOuHIlcnVY0tareCOwEh9iY6tgXKi+husfWc0up8rl9ToKCccIMEztCZ4kFyz
PwtN0I66wiQFbu6bxljCS7RmV78XA18pPaVVfwBPkOGl0wsxaUgACF+x6bgzFo/g
I5cN7w3WIZ+lxv1WtiE4atele6Akw9YmN/Xk31FAZldT5j6N2XXt3q+5s1+qSorA
xeroiGOXk+uZ0jSP99cJ8uCwkt3/OSMrTrbL7MFEMb54nZ/jk3YF/cLTsfAadsWV
xAjiU/v7RdEQAa9jysaxk7FL5KFESexHiRjQp3XOvR4MQAMWl5Bn7uaMc9Y6k8Tx
7qBRwWzBavN88sbD05f0cFszBTUlKzor3BcPrJX2Ih/oNeoE5FnigTZ/di4k14QI
ElO8Ey3qm2ZcOthLa4u5ql1wT2MIfDguZ5SurOBoUss+ZCVUZRi/jaQeDAzkfDzO
6HJRuL8VdbgRxxbld+ucMgw276dZNWp7ZqlDbmuf8MpMx3rBJli8xxIWXH/wNikK
ARd+sP7miw9HvitfEzS+z+K0UWfoEn1c6BoXG2S8sigyLKNOC7SU3iIfDqDydrdr
qyx6n0WXkND5SCkujQl7Qi0Z3+/9eyPHOyaxg0DdGbUwZ8Q7R1eeMgYAFYnzyY5M
sH0x6epfi441AQRnMZv/0MW8lcfIQF1Nt6f4y/vmP3U/pJFL9TfFJFLK5gaV1pt2
Md+aq5tDc2MDE8nPbZiy2JR9x2NIqyI3jGCCOL6lKiWgAmVjMXS/eZp/JGqQ4GtW
bwmAynYLOe/TlmwoDCW7/Ea8HX4mnSwPtCHHylIulVyZGdlVoq2RRDoVnkJs+1uO
+cNKpweloKilkjnWB8zr8hSRyaC+vDzXypz226PZjhbziC8lXDbJdupBvRpsLYtH
W4E/8KSAqgKJk0O+7AoW5uwSDsGqn+ZuZZFyhCy2oURBxBlYwMwxj4avG8ru875d
ZuGve51lgvdRhVWThxG4csQNn1s5lMGy1Q1iNCltxMYmIe7T6T6eaOdaQTW8l8TV
AtrY66G/lcAUnZtm0+X8Y8rKhse9A4gZ780maoYIo5+DehoVOJnMteqDhxVYpg2A
+h5IV3LTXv3Bvi7IBk3KwL54fTII9xHdlO/nIVeRojmADeXHv087MLfivi9+PXQD
nQLd6vP8P1w8o39XniVf7/tNPqhKKueUU+tgzCInosp5ATuREmK1t6T68B/JFoYg
ezzp3I2G4oqkPdDKrPrlUQgocoN+bOsfDMmesd/ROBNqWjkML3L2l/Gr5yuRa86w
5+Rl+TR1s+7mkDssQmSyRnIjOPLtlElLrkcGwQfio5/X3rJKtJOoLtHwdCcyvBGn
L8k0NM2z6EtRpd573+fMz1PFLsZoeGSyNaPGZLfFLxYmG0lb4R8sua8l36nrRFkl
dW82lcnRhCaUhvx9okKLE2Y9sW15D98wUESRvTc6rO8/q50C8gfLHn9R72x0nm2C
Wm88jYeA47VM8DCNKWevUceqZANxYow9LfJnU86Wahg/Mpv12zosHwfFNAZfXjMY
AwwbocywwD5svuT1F7Et6Xusa+npqBlhTSe7Rwc4qI9m/qasS1D+gWiqIdlu0IfQ
14OeU23p18y3+pjUgcu4qcOkTUxdNtcjXTTmn9VDn05t6tj8b+hkLvXKf51FrAmW
tzJGT/gNY5No2bchTmzwbrYfKVjqVhhhQQAbj/0xxdFqKpVqL7pxo3vf8ukxyMVv
JrRnaErKDyE/eSzWncXNRZkUJJ2WzKSSXJEsRZodkp4UaF92XdXpXh69itwHcyGA
kCghVAKa5krkc3fl9RcnmwDWAxVx2qOrK89tt3fZ+t1lAQyyUsQZmDs8oQ87Q+OT
HeSGOu8RF98nE9UMF9A8m3+umRzxYRX10oDp2kJ0IRUZZkkgtEU+F/SFdxMrU4Yj
6Afgsuk12RbxAIKvMj22EqOX5ZuE37XsGR+mLfaxsQxjwNV6VFrLR9tJ4Ttkyd/3
NZRtfPYzc4Q2pLNThTjlV9+XVwNZxopVKrwgVzrQYuOeR2RUgOvgzWymb2XTbaBm
DeR/+rPJsmGuYFwdIyZEfdwXFQBilXVGpWM+moc17/jfkCEAF6ikceXfsitHcw+e
gWr2U8/modT/jEkVqOitgHjkI7JNwpilQzwvu1Zom7qvYVNdZaRB8m6wmzqOAYFX
V4pdvIFom1PZcAgViRuK8waw85mbSHfD0fEwbBkEnw42OcvgctQBguUMCKGTvU6D
SndAQS/xpDtF6O371VuAuBuovWvcPZAGf35EsMwS6M35E3tifKkaUSwUKXkXSJLb
QUvxFzqc2i63IwRhENbJG6K8r4Z9MJrxNNnXsGMF8KMFogKv50xaaLGh5TDNBj1S
n4oGGzbXqGoK12xciBZyAQKYfm0P5YpreZWw/xjGPXPVmZ8+ndnwFp1MTc1DEaJc
n1E57BLVUOlXrCSY+us6QHaXhvTl0ZfnEUFP0pzyHNiJ/Ivb6OyOZIZDA+cEDQuj
lmQdhA/fsFyOx2mMbnLZ18QqsJrylX/KF3hqBi/W61e5uva8v97M8rPkZ+/z9vjd
tUW1mTESCEtWeEomHf2e995LImrrYFl3LNcAxVwOMaDmIkqNV/jLlgEffVSCqsUz
bo13Sl6s5CvAdb/P14AdY+v66a4FdEIy4iE+zcRjfEdTlXm6Y45mo8mSon0OahWJ
DjujuldlNgIPONUAJqU/svfn5uDewWoDe/Zqd7ss/RMjiBj6LerjTMyqSA8sLpYF
8LsBGiqNiojG4fKhftmr2LpB2PaNAiGDLDPOqMGoUu9LQiuJehxinQGC8WRIykoh
EE851KlVKdKQGCPsyICbXTWDKGRcUVrs+xs1cDSa5usTkOtAenEIub2p+zluV7Uq
SHIUHBRAk2a1Mfh9Seb8+I500hzsfhmUNZfjuFn4gkimV7W6y6uEFQgYq8xJiUbW
HAqCHx5QVRSZy+HfG1KgD/BgsCJl5NW9Jnt8o1iU2PlLuYpLLGYBXLekuFZvUbHf
gnDAiP2sC6ZG8DNtl3YC0Z4hD4qxhdts4ef/Lmi0d3BIkB5HPsC+BYcnImTmlBYY
LOGnbW936VO5zOego0HCJUhCyzg8vwtjVNp9hOJX8EVC7jtj7D3Z/tK/kB3HviXw
o4AiVh+//rviSzJrbZaUTNAtodkAPznz2qdhR9QWEx7GKcC4+T9CceYyZWNkqVmU
DPDcdyAmz213A8dXzfGvbsvb7tEUJIPtU+HPmhgeRQhKgJ7OyNaZijSqMGi6awAC
xtxpN6yF04Pu+Bw6OiizDJzGLwkAdBPvIWmR03GyUwB3Zyr8DQLaUupWQFMUBm/G
e6n9Y5OxNr04RFgv5WY0OQwitXC08+uJFjzo1V/HFDHeZ5jlTwXBZV6AZ8m8RsRc
BiYdulLd2rPJ2wjS6pdRw98sS9Faa6vvw/3PkZ2vPCRnkzjHJO+nacjqwinwKjLh
zRdRSkaX6EEiNOtzd6I8Ioo2IPNbdllkP0sc2vPnltc61lXXPfIvkB9k9+URHm3d
cvxFJTNjbcajn2J0dE0HpEwCkdApnqumiXfPFVdbpI/cz8vKEfiPd0UTZmL9Y7WJ
6WkrpDgl16RLNBg8HUKzAekK2t7yIcy6ybaHSIFO4yFqBe9GJ2gyXfPoFb4JFz3W
C6qxjb2LSu6nXVTonTkhvm7ojGW/dz4B4IP6zfbO+ihZX+aDbH13Mk9hF0x9swfE
TGpyKprd/4emMK5ESRbSuHr7XG+ehIFLyT/Xq1633jCZZC05iRRKNM6lWMIGQvby
J7JLl75EGOOnnqcDYvdcGse8+3sSTc4HKgyXczuBMByJuOGmhbLHatAvBK1lCOH2
qOq0skEKMIioWpB0iix8xhp+DChzbFz8bC1j6ft3h/Su0mquSNWQbRo5JXSt3LqZ
pBGOpCsajhLeMzjYYYvwvZ7/nyrkELp2IcoMOC2rNz5LPURkpu2lQz6nR1jx/Xth
NMphaMTMpklJXyjbvoJWmAIlgs7MKzfOWyFg8UC7bpwhK0neWJPG/9n3/Yxqg78P
pQrp3E2m6gAr0B6J9a3Dqx5M276FOoy6gy2uAnOnGW4XayNdIuGTcBCB1vVD13z7
xvQf9CeSumqyX2ox0kN9jY+J033Pevf5P8xFcK8GCfF37BjvtSwQtoS4W1fBdMZP
WxPldwi5TOaN0s/jGrdISOKZ611/YA/xxdheRwa69P2g57iR9EHgFInyfbrJ2ysE
1mLm6mUqFCpJX/3W0FxNtxZxVwl0DIEMpgmuU8LhjT+w9kXq0Zl/DvM2HeabyY7I
NthcpT5SYDNnH5srn8TFaHhXb5yse+F8SnOHKK5fD5kjovR/ExPq7PQc4AX+WTK5
K6gtsctBO49+D6dNhQwkYkWHlX/SGAxjW0xoLwVokI9fDQZIwGl19x3HgVVAPlue
oB5KsuQQ44qlv7Yui3U3WkkjHO0ZQB0WFljf34rRwtSFP2PufuaYLQbgQojLRE5B
q31MjxcxcYSB0jYYvNAVP+vx6abnzm7FRzOj6+LA6+ozpsG0K09ZiVP3dOQLfOJf
Yi32YMx5FkHiMiZDQCye+iltUiTxAnmj7UHjSQCdfohDd08E4W9eWDbz48CXisic
RTfLysMPlkI3Vil0300RP0zRS9Hq6l2Mu69+URgLD/vTuk5DcS1I39dwRLgKUdBo
xt21g+tbtzztZMzF2qki6tnk3LYd+v0pz+uriLb9olDPsaEg33lIirTLBQBw27KO
tVh1M1KEc2gtnETUTqf5+6/BZwpZMYh+yboeUESjxPOhv0KZa6KAWpBMUoh9GnfF
vT2VoseWTcvZmDpES9lcEBz1mXebL15ux2MrNPrsy39IYcJsmEkBtDH5PhVvSXL7
ot+fzz2UStZzXNYIqwCHM6O3YlKFFFIr70nc7rKg3bFXKqxrFMPpNPn/sH17OGSk
0MCtimTLkVjDwZLuydeqnO2qJAkuJuM1L7vKO+Fyx7bai1gPmrPCDEYdyldMcz6l
vIr4XssAilvU+7hgKGEDAcEQ/KLR5qtzT10+tB4TWU25GHHzzjeAbBVpbKzpEHlg
mdfycM6gQx/KWJnl64N2MsIcJqciBNOlao/iv4VDiNI9YdIoM5SC3Gh+FBm2u7+1
vh7pDF1uDUk5paiC7k4Pb94L26JISkQ5kjUQJb8coFZx/yTLdVIxfV7DFRrzyPSl
QnNRJ7ZuyODdWK59g+hFXzdlQuShD3LstJcJ841moAmn1DmsoVDNf4LEbT5cv11m
ZjhBTaEdoEh9e04E3ICsBUVR40yblRpYC8m6CN1v6jxGH+gfJfg0RiosIvlS7/OV
2KI4lS2SCEmUDkkt1a3kGdaefViHhvPnFhl8Gtu/fQ8dmiw3aqEFtXYYRyqrmJzK
UDZpWyVQNvmiwWqqMEFK5vrHItJsEQNeN2wbxNYLNVcvwmT1xlBHpRd+B0Nskeea
+T4Iw09ZKyLx2l7npCHXC0pTAXpyfUW+DMMigSL3RGMZkYPhHbA+3/AJXv1bnOG4
jsw5ZL4Ks+MPKBEu4jA0hX2I5rhZ5CyOK3tyIz2F/Afk+HjvGljJOQjCNNWwuRfG
jc1tbSBdONjVD3CprbiFDqonHnN/IaQSsdjT/Q62K5xNEEwIDsYJESGqQgkvp9OH
bO7b5mqedKsYMIhCt0r51+FtzXMWFQR4YVFy+JiQNFp1ZOdfPI6o8LR/F947f4oi
HYCuViOPcx/E4bdsbH9BWtyHYx/QXme3kWkRP0FcPi9h1OJGIUjN/K0TK3evllzq
S81uPNT5WH5qBANdI2Tn8c0K5TA5V2GsK61h5CFFHfLuGFJ3inRc53geCpKtFzlZ
9A2DxJeim06i2llpC31NTyCvEUqmpwUmqle4S5dEw7uVVyGhTopl+m/UZ4NLtT5d
I5t1pkD0WyKei60yEXnuMG3ns/7DxQ7Qd6rN7wh8Nen5fCX9yKLSu+gbT50562kN
r9crCxHvsSKqqDU80N9ZsiqzHpKG/41vN967TwyT7q0IZJ03szGPNk3IUILZk4Nf
KVbbG63qBMyTt4nB+2kJFwk/s7nnBjSsa2oLQFSQaPXrKugbMy/vQaxDTAFqODZq
RI7bC9B91VR03vtSPDX+N+NRYju9BZOHaAJYRU+l7bLd+l152wzCa8KS9EJg9Zag
Jv0BzkfUzRyy0mzKBCtFBO3U2YOCgu2ud6yOZ/Sc0mrja3jYEMnfcp6/bHGjZVOZ
+E9ywxedrhh4hXhK2CUWwCtd+ygxRvliGWTvng7faxbA4gCoYImHb4bcCXvhEeiy
2bZHdvqCVF0E6PlJzb1ST4qehx23Vh4eQyRKRobVzlbrH5+PUpaE+wRZfYaIVvec
4zxSVGm34IjuaskjJ9W51UL0CDj+xWnX24qYyEQB/7Xx5RyPxOyZnOQvCK0648Ps
dJgKWsUpBshSoCn5AQeiDmOfGov4ll9raXYqsbNl9KzgQRFwWNjCzNSE/JzKvApJ
0Ng1mdodzRw3GMeZautJaTFbIFykUWT+mslaU8ddcMZSZUeEkOBsn95aofK5VD3e
3taqPMjSfTMPa+VWQwRR2ltl6Zpv1KxB4/5IcJTIxyg82bVY5qOVctKD/3r6LMia
kZ68dRTz6bEubSl5pPYCHOLueFwy+u+2qEwLhrjAsOsXSGKhjhENeYlfQkUzIujz
L4ZSU0YV4nVQI0Eipo8VSgfJbr3dNcgi7EhAYVKkpeUIf+RXmqc5x7gj6w209wly
gm0HMnCHRG2DK0cFxz+Rxw3wFsm0wbQ6cVSOe4AeXEs+dbsZCBeNfXaCjo6Eb0n+
pXJlvnw0SjO2gvEStI7ns9GmdtXaodCf7iNPDbtM5NMjHdCsHUi4z6pjFdavwZ3W
FL3qMNlgjt/fN1+SOr/skNhE/qNeh6ULsPIUJ23AR30GKQsplxhHFGTFBEUDi3Lf
jppX5ArUUhezoWLEfPx4NZPLQ7/AWKK7gtfzz6pJRhWVkXFY9SO/hhbfG1mkiOgO
M392t/W9AZPTQKuk4djbD/xa2UGZvDV4+czYelj3F2JbhWd20sMzH3kQ9dMh77/V
86l1S+csowiJFfyAZUjyI4CrU9bFOZccE/gp9x94Oj9CZF4p4OYyyXeJTOf+QElN
ufFIJn6TsMxX8rrEHao5QaiU60kztspaY+TThVWbRq/WCx0ePhVMDsYfhsvKieVs
zmUeqWwuGUaihsAUModWMoGw3r+yiTDa/QsAbpqYJc83BFLkDmL+DBXy71EUd2fq
PsvfThgzAId78f+BaJMSBnOW0alyA8NQWLggQBsBaCJSSmNIfC9MJ7DWGhnUnzrN
A57zAPXmNky0uvyD1Tzv0gVVWKtBCGZP+y18NRdkkUtM5miyjD6MivJqlOOt3uum
bSLc+lWsXbVwXjmsIqpnajlOOFFDmMt0rwArh85AuO89n8OkfzSGy/qoIncwN6A+
o6+eP7khiI2+rdP0/VbqZcsuLXaAfZ3R7xZepgnayYYgMjNgBqvQC90Y02YgGe43
+lm/RtDEgmFk74EPu3zP4uEcIgyQL65fv3v/R6mPF2Mq/5ZjFBr3ax3zNyAS0Ueg
QDOZaZBn7IcCjjx0g3wo94hVJOAsy8XkZY7cc+vV69tZUAO7ID8KWLrK1UHYG3Xb
hrm6gcuV4SGSD3moVvd8wkv20x6rv6BeE7de6RE/nb97SUCX0slB7I6m/OQcE2Lj
7/FqBs1w0f0ehR0guk3rXDUFVIBcfKigfG3s5PQxfsM8Jnof6OeZy0nrDSBVOZs5
mulndjhM8fLL0Dp+05q/rs1w7KMo2OHmy/vjXcyYmXC0M/CMcPsEFyb+ZKWSD8cm
uKaoGBElomhG8ZbU/e/+zEj1UdItzJTZoTDCU8vamufECQzXU3CHpulpe5fpX5Dw
mMC7zk15CDyX9XcbDgswQtoBG6OunuCDRVTIM1mQCkpfSWPKeRZgMFQLXN0FM+Xx
tgVSNs55Phz+zVtuolZ4fkI38jWnhIzIbEQWbYbuNEWIf+Z0vz2FP81W617TMdZq
/7H8Ilzm9TWcl4F2oVEeXg==
//pragma protect end_data_block
//pragma protect digest_block
fpylIDjNTGgRJERmwf/J1BDBGUY=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_SPI_FLASH_CY14V_AC_CONFIGURATION_SV

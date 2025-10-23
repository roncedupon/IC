
`ifndef GUARD_SVT_SPI_SERVICE_SV
`define GUARD_SVT_SPI_SERVICE_SV 

`include "svt_spi_defines.svi"

// =============================================================================
/**
 * This class defines the service request transaction items that can be
 * triggered from SPI Master in SPI_FLASH mode. 
 */
class svt_spi_service extends `SVT_TRANSACTION_TYPE;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /** Handle to configuration, available for use by constraints. */ 
  svt_spi_configuration cfg = null;

  /** Processing status for the transaction. */ 
  status_enum status = INITIAL;

  /** This variable defines the type of service command to the Link. */
  rand svt_spi_types::service_type_enum service_type = svt_spi_types::POWER_UP;

  /** 
   * This is the weight controlling variable which determines how often <br/>
   * the RANDOM value for DQS initialize as ACTIVE HIGH is chosen. <br/>
   * This is applicable in Slave Devices Only. <br/>
   * This is currently supported in JEDEC Profile 2.0 Generic Part Numbers <br/>
   * when svt_spi_mem_mode_register_configuration::enable_multi_factor_wait_cycle_latency is enabled. <br/>
   * The Max supported value is 100 and value should be multiple of 10.
   */
  rand int multi_factor_wait_cycle_latency_wt = 50;

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
   * Valid ranges constraints insure that the transaction settings are supported
   * by the spi_svt components.
   */
  constraint valid_ranges {
    if(service_type == svt_spi_types::MULTI_FACTOR_WAIT_CYCLE_LATENCY_WT) {
      multi_factor_wait_cycle_latency_wt inside {[0:100]} ;
      multi_factor_wait_cycle_latency_wt%10 == 0;
    }
    else
      multi_factor_wait_cycle_latency_wt == 0;  
  }

  constraint reasonable_behavior_type
  {
   
  }

  //----------------------------------------------------------------------------
  // Methods
  //----------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_spi_service)
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new transaction instance, passing the appropriate 
   * argument values to the parent class.
   *
   * @param log VMM log instance used for reporting.
   */
  extern function new(vmm_log log = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new transaction instance, passing the appropriate
   * argument values to the parent class.
   *
   * @param name Instance name of the transaction.
   */
  extern function new(string name = "svt_spi_service");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_service)
    `svt_field_object(cfg, `SVT_ALL_ON|`SVT_NOPACK|`SVT_NOCOMPARE|`SVT_REFERENCE, `SVT_HOW_REF)
  `svt_data_member_end(svt_spi_service)

  //----------------------------------------------------------------------------
  /**
   * Performs setup actions required before randomization of the class.
   */
  extern function void pre_randomize();

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
   * Allocates a new object of type svt_spi_service.
   */
  extern virtual function vmm_data do_allocate();
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
`else
  // ---------------------------------------------------------------------------
  /**
   * Compares the object with rhs.
   *
   * @param rhs Object to be compared against.
   * @param comparer `SVT_XVM(comparer) instance used to accomplish the compare.
   */
  extern virtual function bit do_compare(`SVT_XVM(object) rhs, `SVT_XVM(comparer) comparer);
`endif

  //----------------------------------------------------------------------------
  /**
   * Does a basic validation of this transaction object.
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

`else
  // ----------------------------------------------------------------------------
  /**
   * Packs object into the bytes buffer, based on the `SVT_XVM(packer) class policy.
   *
   * @param packer `SVT_XVM(packer)
   */ 
  extern virtual function void do_pack (`SVT_XVM(packer) packer);

  // ----------------------------------------------------------------------------
  /**
   * Unpacks object into the bytes buffer, based on the `SVT_XVM(packer) class policy.
   *
   * @param packer `SVT_XVM(packer)
   */ 
  extern virtual function void do_unpack (`SVT_XVM(packer) packer);
  
`endif
  
  //----------------------------------------------------------------------------
  /**
   * Returns a string (with no line feeds) that reports the essential contents
   * of the transaction generally necessary to uniquely identify that transaction.
   *
   * @param prefix (Optional: default = "") The string given in this argument
   * becomes the first item listed in the value returned. It is intended to be
   * used to identify the component (or other source) that requested this string.
   * This argument should be limited to 32 characters or less (to accommodate the
   * fixed column widths in the returned string). If more than 32 characters are
   * supplied, only the first 32 characters are used.
   * @param hdr_only (Optional: default = 0) If this argument is supplied, and
   * is '1', the function returns a 3-line table header string, which indicates
   * which transaction data appears in the subsequent columns. If this argument is
   * '1', the <b>prefix</b> argument becomes the column label for the first header
   * column (still subject to the 32 character limit).
   */
  extern virtual function string psdisplay_short(string prefix = "", bit hdr_only = 0);

  //----------------------------------------------------------------------------
  /**
   * Returns a concise string (32 characters or less) that gives a concise
   * description of the data transaction. Can be used to represent the currently
   * processed data transaction via a signal.
   */
  extern virtual function string psdisplay_concise();

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
  `vmm_typename(svt_spi_service)
  `vmm_class_factory(svt_spi_service)
`endif

  // ---------------------------------------------------------------------------
endclass

//------------------------------------------------------------------------------
`ifdef SVT_VMM_TECHNOLOGY
`vmm_channel(svt_spi_service)
`vmm_atomic_gen(svt_spi_service, "VMM (Atomic) Generator for svt_spi_service data objects")
`vmm_scenario_gen(svt_spi_service, "VMM (Scenario) Generator for svt_spi_service data objects")
`SVT_TRANSACTION_MS_SCENARIO(svt_spi_service)   
`else

// Declare a sequencer for this transaction
`SVT_SEQUENCER_DECL(svt_spi_service, svt_spi_configuration)

`endif

// =============================================================================
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
3hpqT3DjFLUzi6EqVHOVLh1IZdGMhuvZ+EeKlt2xmcmE/1sDrr1if8XqyLbAS72Q
Q4SX4Q3amE5nXVZj44RHN714ye3jjN0vAboY5gHJM7+1fPWE4mFTk9QjduTn6Yzn
9tExolS5L+W4Sa2OUQfDW5/586gtme1xTZBWm+WCMr0ZNnXLgTP9Bw==
//pragma protect end_key_block
//pragma protect digest_block
vFq20p+QsBiXbd3YcPr9zFcceog=
//pragma protect end_digest_block
//pragma protect data_block
B2aWmOuW/kp5VtFjvDHMBXjYQyA3QLBFhqRJ0g3Cm9uuij/h2eG5IKJMIKcZF9/x
4aVqX7kC+A02a6+eBnAEVDLXmYg7LT7ZONVvTEp6LPB+X4aw+f3koaf8+sb3GA1z
hhsgaiWR0cUC6aYmosZxj4R2LPvlpXyS8enkbV5qgpDmyK99IEj9zEO5rLingKxP
25XPficFkpbdpyzrVLsJwdG4A2guzqEfOV+XVt5WGkzmgpb2EgqIemVxKiBh0uV9
nrecO/BDBTfY6LimbCk1nyqjvG7E7I4/TLQl9I4wyl8ZQRBR+aCRFSrLFB65/k+Y
lIDN00sKQANE4n9m/OQkLcwYO0EsjR/mhRGLcZ2nq//eG7FWnaQXIh+whfQ7vQMe
I9JgvAo69FDrFWHdecIxUyVCqA9L8oPSBNJ9FMYApAe7oQ66EyQn+/0eESKCJN+x
0XsEDHamQID2PmEXIqlnXm36zhX8SMSNTljupdh7hhQYIuWnLRus7XMlnzjX3Co7
T24pESfHBNNbPcOJLbv+u/gahccECx7mMYkPF/C9Otg8uGqoHCEU2uHlFmAsbIlB
qUPtNXfWPmkqkBPfM5toN8hwazQh8VLOPqov4m9IY+CD9rM5NnhdniYrLKuY1Ha6
VQVtOdHY/x5N3WFbQRAFpP1fDXyGHlkchSEOOL5eQZrch3fnKk6jDiqB+xXBwZLG
LBpTJlrVc1cgUkpXUDatZKyv/0uIAif16gCZtcXNX1OgoYrrIC9t1h3Ix2tLY/tF
E4j3BP7jkN69j3Fm2LaXptW9r2pZonv8Q/GPtI7mAMLicmfAxMA+QoFIm9HYNhZH
pRggz1sygcCu9ojOb+mhl6X16W9cW4Oh8uDqUjEiSQLlMtdsAPpu+ms4H9po63sX
QonRGM41rtb47/9fgWBiYVafDnpBwIuN6DJuBsOOY1YJPywAhoswdrLKKivIR1P9
Lccj9NdyJBdCuOTVxQ7DA+OgeVbFc54aAxkdVErSBfy6585r6RCU1OjUHVZD4ZUY
/8TWSF01xwpCr3Lq/3wpMwAciW4NM5p0jB2kf+9JUS2P46XiXhTK4nx4N6th0DZH
BW/Fxtz6lKQlHoMeKFNpmE/VkPSnqe9FSG2ou38Q9b+lX83upOeCeWtuZ6QgyRoM
yqLdW67HPYg4XDeBKmOxe6CJ4OVUSFRtDd6E1HzfRoYQHBsp97XZLe7E9CJSWAv8
kdmxoAiDhIARkrWBjoFB+8SiBCsjKGmMmbmkiJZDk/HQth5Jzbtx1U1mAeQWLQcH
k8BZrXf0LBqtG8Qkohh4joWJ1bV6ocmd7NbWKw/cZLCCf2r/4e3VoohNyyZhJVjD
5v9c5fx9vfMfp1mk0mVHMY8LWhD+OGVA7stsxQgEg2MOYSfNiUYNrYBD38U2S3hy
LUJ67RXd2aQZMnEzzQZuFGNhegRN46Kbmq4WoWCevNNevZ4aMRY2111EOybZMKDP
v3i2jF6KLRiXrfmVkL7P8C1A5cIOxoOD6r0a6O5qvYILymEUDPpvBhEUNn7KiM3f
325MPNItAE10+1Z31j+FYppajx/rXfweDVuGV8JXP2XeA1ql2kYAbIeL131a9utL
ysbA314Cud8VtYzi67bV3Jwf/FZD6w0gEkVLFjTForCsLfjk03tjXe/UsJT9uT8z
IsG22tKduWQtkeUVfUPY7VljuVMZt8Uj0yNhrX7QztHUtaxDXKQ/Hol5/ETPEMcj
mPqO9hS0ro0fBZnsZsWtr6YuEihZqfFxqDjaa3+ncSInYNy/WJXpfKAyqmBW2jPd
gX+g/ulCW+wl+eDRdsbk2jZquw54lbI4vowtdF5J0pHGWXzMncTIQj09DD3w2IOs

//pragma protect end_data_block
//pragma protect digest_block
EX6Vr1vZMXKcwubLFKk43YMKdtE=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
LgpG6Gg56MjGGXs/4g9K/RkqXrUFbFw/dqxavskz5mkOWcryFjWrssslImYdQ0hq
NyyeKGj5E7u/aerEmp33RTw6EPF2/ACuxnEGZORoHi43U4R0wywxqcYSddn641EU
R6wUUh0ZSe5/b04I5ijCPUWcrv5zF3uoRn2h3cJdLBlp/vN5u0BghQ==
//pragma protect end_key_block
//pragma protect digest_block
o59UzWc9rlz9gAFNfiZa64NhyIU=
//pragma protect end_digest_block
//pragma protect data_block
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
UKpsnbfQDjRJshvAKYEkRA==
//pragma protect end_data_block
//pragma protect digest_block
eRpJxGJKwKYN7frwJhWU8lQJA+I=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_SPI_SERVICE_SV


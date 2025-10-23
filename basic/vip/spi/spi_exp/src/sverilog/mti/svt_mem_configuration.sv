//=======================================================================
// COPYRIGHT (C) 2012-2017 SYNOPSYS INC.
// This software and the associated documentation are confidential and
// proprietary to Synopsys, Inc. Your use or disclosure of this software
// is subject to the terms and conditions of a written license agreement
// between you, or your company, and Synopsys, Inc. In the event of
// publications, the following notice is applicable:
//
// ALL RIGHTS RESERVED
//
// The entire notice above must be reproduced on all authorized copies.
//
//-----------------------------------------------------------------------

`ifndef GUARD_SVT_MEM_CONFIGURATION_SV
`define GUARD_SVT_MEM_CONFIGURATION_SV

// =============================================================================
/**
 * This memory configuration class encapsulates the configuration information for
 * a single memory core instance.
 */
class svt_mem_configuration extends svt_configuration;

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************
  // ****************************************************************************
  // Local Data
  // ****************************************************************************

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

  /**
   * Indicates whether XML generation is included for memcore operations. The resulting
   * file can be loaded in Protocol Analyzer to obtain a graphical presenation of the
   * memcore activity. Set the value to 1 to enable the memcore XML generation.
   * Set the value to 0 to disable the memcore XML generation.
   * 
   * @verification_attr
   */
  bit enable_memcore_xml_gen = 0;

  /**
   * Determines in which format the file should write the transaction data.
   * A value 0 indicates XML format, 1 indicates FSDB and 2 indicates both XML and FSDB.
   * 
   * @verification_attr
   */
  svt_xml_writer::format_type_enum pa_format_type;

  //----------------------------------------------------------------------------
  /** Randomizable variables - Static. */
  // ---------------------------------------------------------------------------

  /** Defines the number of data bits.
   *
   * Must be less than or equal to `SVT_MAX_MEM_DATA_WIDTH.
   */
  rand int data_width = 32;

  /** Defines the number of address bits.
   *
   * Must be less than or equal to `SVT_MAX_MEM_ADDR_WIDTH.
   */
  rand int addr_width = 32;

  /** Defines the number of user-defined attribute bits.
   *
   * Must be less than or equal to `SVT_MAX_MEM_ATTR_WIDTH.
   */
  rand int attr_width = 8;

  /** Memory is read-only if TRUE(1). */
  rand bit is_ro = 0;

  /**
   * Memory is 4state if TRUE(1).
   * 
   * @verification_attr
   */
  rand bit is_4state = 0;

  /** Name of the file used to initialize the memory content.
   *
   * If the value is "", then no file initialization will happen.
   * 
   * @verification_attr
   */
  string fname = "";
 
  /**
   * Name of the mem_core used in C sparse array.
   * 
   * @verification_attr
   */
  string core_name = "MEMSERVER";

/** @cond PRIVATE */
  /** Physical characteristic descriptor
   *
   * Defines the number of dimensions that the physical address is composed of.
   * This value is used when constructing the memcore instance.
   */
  int unsigned core_phys_num_dimension = 0;

  /** Physical characteristic descriptor
   *
   * This value is passed in to the first argument to the 
   * define_physical_dimension method in svt_mem_core.  This represents the
   * transaction attribute field name for the dimension (Ex: rank_addr).
   */
  string core_phys_attribute_name[$];

  /** Physical characteristic descriptor
   *
   * This value is passed in to the second argument to the 
   * define_physical_dimension method in svt_mem_core. This represents the
   * user-friendly name for the dimension as it appears in PA (Ex: RANK).
   */
  string core_phys_dimension_name[$];

  /** Physical characteristic descriptor
   *
   * This value is passed in to the third argument to the 
   * define_physical_dimension method in svt_mem_core.  This represents the
   * dimension size (Ex: 8 rows, will have a dimension size of 8).
   */
  int unsigned core_phys_dimension_size[$];

  /** This flag is used to enable or disable log base 2 data width aligned address, default is disabled */
  bit enable_aligned_address = 0;

/** @endcond */

  //----------------------------------------------------------------------------
  /** Randomizable variables - Dynamic. */
  // ---------------------------------------------------------------------------


  // ****************************************************************************
  // Constraints
  // ****************************************************************************
  /** Keeps the randomized width from being zero */
  constraint mem_configuration_valid_ranges {
    // Should be at least one bit of data width and should never exceed the SVT MAX.
    data_width inside { [1:`SVT_MEM_MAX_DATA_WIDTH] };

    // Should be at least four bits of address width (memserver restriction) and should never exceed the SVT MAX.
    addr_width inside { [4:`SVT_MEM_MAX_ADDR_WIDTH] };

    // May be zero in case there are no attributes used but should never exceed the SVT MAX.
    attr_width inside { [0:`SVT_MEM_MAX_ATTR_WIDTH] };
  }

  // ****************************************************************************
  // Methods
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
`ifndef __SVDOC__
  `svt_vmm_data_new(svt_mem_configuration)
`endif
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new configuration instance, passing the appropriate argument
   * values to the <b>vmm_data</b> parent class.
   *
   * @param log Sets the log file that is used for status output.
   *
   * @param suite_name A String that identifies the product suite to which the
   * configuration object belongs.
   */
  extern function new(vmm_log log = null, string suite_name="");
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new configuration instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the configuration
   *
   * @param suite_name A String that identifies the product suite to which the
   * configuration object belongs.
   */
  extern function new(string name = "svt_mem_configuration", string suite_name="");
`endif // !`ifdef SVT_VMM_TECHNOLOGY
   

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
`ifndef __SVDOC__
  `svt_data_member_begin(svt_mem_configuration)
  `svt_data_member_end(svt_mem_configuration)
`endif

  //----------------------------------------------------------------------------
  /**
   * Method to turn static config param randomization on/off as a block.
   */
  extern virtual function int static_rand_mode(bit on_off);

  //----------------------------------------------------------------------------
  /**
   * Method to turn reasonable constraints on/off as a block.
   */
  extern virtual function int reasonable_constraint_mode(bit on_off);

  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object used for logging.
   */
  extern function string get_mcd_class_name();

  //----------------------------------------------------------------------------
  /**
   * Used to limit a copy to the dynamic data members of the object.
   */
  extern virtual function void copy_static_data ( `SVT_DATA_BASE_TYPE to );

  //----------------------------------------------------------------------------
  /**
   * Used to limit a copy to the dynamic data members of the object.
   */
  extern virtual function void copy_dynamic_data ( `SVT_DATA_BASE_TYPE to );

`ifdef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Compares the object with to. Differences are placed in diff. Only
   * supported kind values are -1 and `SVT_DATA_TYPE::COMPLETE. Both values result
   * in a COMPLETE compare.
   *
   * @param to vmm_data object to be compared against.
   * @param diff String indicating the differences between this and to.
   * @param kind This int indicates the type of compare to be attempted. Only supported
   * kind value is `SVT_DATA_TYPE::COMPLETE, which results in comparisons of the non-static
   * data members. All other kind values result in a return value of 1.
   */
  extern virtual function bit do_compare(vmm_data to, output string diff, input int kind = -1);
`else // !`ifdef SVT_VMM_TECHNOLOGY
   // ---------------------------------------------------------------------------
   /**
   * Compares the object with rhs..
   *
   * @param rhs Object to be compared against.
   * @param comparer TBD
   */
  extern virtual function bit do_compare(`SVT_XVM(object) rhs, `SVT_XVM(comparer) comparer);

`endif //  `ifdef SVT_VMM_TECHNOLOGY

  //----------------------------------------------------------------------------
  /**
   * Checks to see that the data field values are valid, focusing mainly on
   * checking/enforcing valid_ranges constraint. Only supported kind values are -1 and
   * `SVT_DATA_TYPE::COMPLETE. Both values result in the same check of the fields.
   */
  extern function bit do_is_valid(bit silent = 1, int kind = RELEVANT);

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Returns the size (in bytes) required by the byte_pack operation. Only supports
   * COMPLETE pack so kind must be `SVT_DATA_TYPE::COMPLETE.
   */
  extern virtual function int unsigned byte_size(int kind = -1);

  //----------------------------------------------------------------------------
  /**
   * Packs the object into the bytes buffer, beginning at offset. Only supports COMPLETE
   * pack so kind must be `SVT_DATA_TYPE::COMPLETE.
   *
   * @param bytes Buffer that will contain the packed bytes at the end of the operation.
   * @param offset Offset into bytes where the packing is to begin.
   * @param kind This int indicates the type of byte_pack being requested. Only supported
   * kind value is `SVT_DATA_TYPE::COMPLETE, which results in all of the
   * fields being packed and the return of an integer indicating the number of
   * packed bytes. All other kind values result in no change to the buffer contents, and a
   * return value of 0.
   */
  extern virtual function int unsigned do_byte_pack(ref logic [7:0] bytes[], input int unsigned offset = 0, input int kind = -1);

  //----------------------------------------------------------------------------
  /**
   * Unpacks the object from the bytes buffer, beginning at offset. Only supports COMPLETE
   * unpack so kind must be `SVT_DATA_TYPE::COMPLETE.
   *
   * @param bytes Buffer containing the bytes to be unpacked.
   * @param offset Offset into bytes where the unpacking is to begin.
   * @param len Number of bytes to be unpacked.
   * @param kind This int indicates the type of byte_unpack being requested. Only supported
   * kind value is `SVT_DATA_TYPE::COMPLETE, which results in all of the
   * fields being unpacked and the return of an integer indicating the number of
   * unpacked bytes. All other kind values result in no change to the buffer contents,
   * and a return value of 0.
   */
  extern virtual function int unsigned do_byte_unpack(const ref logic [7:0] bytes[], input int unsigned offset = 0, input int len = -1, input int kind = -1);
`endif //  `ifdef SVT_VMM_TECHNOLOGY
   

  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>read</i> access to public data members of this class.
   */
  extern virtual function bit get_prop_val(string prop_name, ref bit [1023:0] prop_val, input int array_ix, ref `SVT_DATA_TYPE data_obj);

  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>write</i> access to public data members of this class.
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

  // ---------------------------------------------------------------------------
  /**
   * HDL Support: This method allocates a pattern containing svt_pattern_data
   * instances for all of the primitive data fields in the object. The
   * svt_pattern_data::name is set to the corresponding field name, the
   * svt_pattern_data::value is set to 0.
   *
   * @return An svt_pattern instance containing entries for all of the data fields.
   */
  extern virtual function svt_pattern do_allocate_pattern();

/** @cond PRIVATE */
  // ---------------------------------------------------------------------------
  /**
   * Update the physical dimensions based on the configured memory size.  These
   * values are used when configuring the memory core.
   */
  extern virtual function void update_physical_dimensions();

  /**
   * Clears the physical dimensions dynamic queue. This method must be called before #update_physical_dimensions.
   */
  extern virtual function void clear_physical_dimensions();

  /**
   * Verify the physical dimensions queue size matches with the number of physical dimension
   * report an error if there is a mismatch. This method must be called after #update_physical_dimensions.
   */
  extern virtual function void check_physical_dimensions();
/** @endcond */

  //---------------------------------------------------------------------------
  /**
   * Walk through the part catalog to select the proper part number and returns the
   * path to the configuration file.
   * 
   * @param catalog The vendor part catalog that is to be used to find the part.
   *
   * @param mem_package Determines which package category to select the part number from.
   * 
   * @param mem_vendor Determines which vendor category to selct the part number from.
   * 
   * @param part_name Specifies the part name to load.
   *
   * @return Indicates whether the load was a success.
   */
  extern function bit load_cfg_from_catalog(svt_mem_vendor_catalog_base catalog, string mem_package, string mem_vendor, string part_name);

  // ---------------------------------------------------------------------------
endclass:svt_mem_configuration


//svt_vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
AcDdXQamNGzMEMR/rKLIFgMkszV9LtFRJ3s+ei6n28MKEAwJNaieg6KvjTeUrig0
WxGlQHZmLrPbu04uFuDx3sJ9kywUBA5wDZLkHCmTJ8CJttXI6DvTKj07ondc2K+r
kq2/rV4JBKSrjHXl52vrJvJQrpc22SF7/uxMOF4EWfA=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 673       )
bDGJf8oJgQpMgvKu+BM7cioU2fIMZ8O5WM4+2XAYA3RUgPlfD++i7lkstSCnp8Ou
kjZpfkOR/YtZuMMigMb/KsINsJYi4aFvEkjyauJyKSm6Y4RJ+ViAJQ0xpHNxhYY7
lnOu0VDZXPjA0JgG1dhQ9Ybod1COvVIOTZcX4A1gTeRQYqd+4syGrPvpR4GPjTi/
EV2zIA0tVc6SCq6RVVl1xY2iUVTFTONES6pQDFqb90fxaVyWHFHzJZyDoUlXN67i
yeJ3xfm2ZGO4hRYGozRzWFhhKB7RZuyIRP0recsC+txSoalV/4mXrPmRcuVYv6m+
e5ro4ik8SjtJGrHd9ekjoKoxhQTNMFIgTkDz+nrM7yJ2qbPXpaCowtdL3VuxUfVI
MSRBz64J/UIKgoQi/g8JmIutgidodWLVe4s3hU17KjQNUw5adhcFsG399T4yZOoG
bULhYoK9qBuo4k3+K9mmGnV6EHBO2rY69kjLbGBVl9FfSmute4oZsVMY+qjBumkD
zM8FrukfpZx1kqkxJivZ1KnboTubBEXl1qs7KxfcrdcPuH69tFCsr0yepiUg2ley
o3BiJSn4T7AgZFFTdRs+lisCtstIZ+tDUvgTvTStx1KMQReoyhbHduFJDOR1MrLr
URnSxoYwQ8NRCEg5nQP2srQ4+xuw5CLKNi5lHBROYZKfAGhAwOXVyrWv8wi0m/oF
Ep/VnTAdVSIzUy+xSbxAWd0Lx5PnaTXKo98btb91K74FYeZXsKRYHRklFNfre28N
Hcz2wIUel9C0xrP6HEV7LOVu1erpWGF2ESRhLP1syDWxO2iBT1nsEi/mUZy6ZL2z
e/hniWesuADTI60TOjLYANaIQdtt3W196mDJRdbw6f4g4gQhGytu3jzGqaRii/ZG
gAFpaWcl/0DseRjnGl6zKg==
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
fhRQCxjzFwNsFc/jhzCdTjc0X6/zW/RuUKk9sTMYRuxuuJ1XUbhPjlSxTHd35Ynw
l7JBnAFT9pouXUPx5AOc95XKmE8TdnckCsXiXuWuQuql6gfn9iPwgzhXhEh8SN2b
mIHC8GsJAMoqKq6LHsOuH1n2d7A5MEa5WOLSq3bNaAg=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 20190     )
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
`pragma protect end_protected
   
`endif //  `ifndef GUARD_SVT_MEM_CONFIGURATION_SV
   
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
S4E0M9Y6aHgHWTUqGmE3GOu+hQXrvMW57t7hpkarDqRtglEfX2iAJ/81WlNSP13i
JEbVuq4CXLWnoi23clzl7DQQKCynWOhVOSrv9BHKU8qR3FKxPAcDwOrmmQc06sKA
PkaYdSD2L3q+I007Ev/eRWXSw2LUh0Npalfgqo6pf5E=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 20273     )
P6x7PmDTGxj9KKqVExToUXvPOgxpoww9e/iTRFymngiAN+AMOdHnXrIu2KjLifnG
hxfgAbgiHBxmDNH0EOKEHYr4/7AsEl5mCVJIhM6mRyeNwEU8Y3Ur1SMXfghzAZCu
`pragma protect end_protected

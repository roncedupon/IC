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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
SPuT89S32iYyIyEqrB2+peT7iS0VWB8W6TFOV9A6qYodtKJoHzzSF1YlVkkel69J
p2jSyYMzmHLZ7vZ9p0RvIzbQDdD8X7Jjq5bWZd/RX2t0xz6o+jW/O41AmRdnb3VA
Vvc3wObpbocdXx9on9GFlqoYfu5/sN5ptsMZaZ4j/Zjo6EQucFaBkg==
//pragma protect end_key_block
//pragma protect digest_block
M05kJW1BGeYTEdmVNJEj0/spp9Q=
//pragma protect end_digest_block
//pragma protect data_block
3qR6lKQ1FiuVtKnlIZO2RfuMHSL8+gyc9yy7K0aM+1d+cZDagJ8b2021lH7Hv7qX
uTwNxhwpJckyHoNKD1mNf25HW2qqjt7naeKKDizJ2YxrpDYiPP0PEEeBHW4FuS6q
IdVjjWWDRsBbZQdwDe9Wthiua5r+K5Rc8A4Rn1sf6zEnIp3qug4J+5PWX9YOzR6P
quQFu3aZYafB3tywpwFW7vMnGB2jFdmpruw4lu+LvreslcmDAkHQK5WaOsAR5vD8
LuvRHhPf5CAFB9QyiNTYMFQvC26HSEAYrw+69i+g/7ayuR43CQi7KipLQ3ghdUJu
hUnJov35AqehUIMFG0H7SC/hl2PSV/KEMkvAjY3Olc+8TOTrEmxwpeA2m62qKIdn
nv54025TxTqBQaeEfMKi+f/flGJY0p1QgSdkJnZ3UNY4X69jS0toiSLZfxr8MNrX
lHcngNoX2LQoef0jrwinXTXOQGjUfgCh8xGFJwGZQ4vYBiJLQmTey43UOATahllI
yISLzx9dotSYRpcNX1mp8mb3cGA3i3sh/euikfaqrpZ0zn5sP9VixH2gEIax+Z0S
4qZOe83f7KUl2l6+XpdJfOXMkTZ4ijrhh11VTnEfBp0UIw9VSMQfWjBDdmkmUmId
q6cFMqLYIi9t57iTbaeJzB3/HsOpqR5vv4lSeDwPNe+XJSeE2ABuSdExOsgiKjbU
kL0zzj8rYq4Vho/NYx4oCNDhx+FdENUijnS3t1YiNlkYbZez2xPU5jfXfZtKgiCb
bp9zArwi7j5FVFXVrHQHytac972+8dSXeuR8BWOLVLRSQQ/8J0bZauSvPh+mlE1e
GAZBiOjXbFs+sLAqG88d/Kmuen9mL+jv268V8weWxSdbEqrtifLkakeXCeUtOceV
uK2/i/CHMBxP/lp3lZI35Ww5DywdQBaqkyUSKu1OOcl61/VpYLwaZKMUzjrkmh7U
MLUAV3hF2gIKysylSxFeWT1gFyhxWwqsQCKAmPajlpeKJT8bcAAin+DuNRsfrgEX
pWdFIBeLANdnzJ2HuMcpblcO5xjUSfBom9hmFs48gVkxKJzRQ7rNSpzedO0fR8+v
zQQsMLBeegeHIGGiRQY+l2ZFY8HvexqZ7E1xHCwBW3Q=
//pragma protect end_data_block
//pragma protect digest_block
JUNShd2dLZ0UeIrs3givQArhMJw=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
NcLNS2awRMUVFAlcyL/LJREvY6T1EXWadLAb4aaB8B2A9UGYdOqnR+zrBtM39V8O
/QOT8p8v3aHSCaznth4VqmxBD/O+QBQLMH0qoxRqauJU8yYBs/FRdi59Jzd4XamF
aOO1c23SbPH3a83l4SifxY1KJPs4kVI80kAdv/LWs0Uk2I0kii1/2A==
//pragma protect end_key_block
//pragma protect digest_block
mMAF3th40Shxq3wvYsPnybmWC6E=
//pragma protect end_digest_block
//pragma protect data_block
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
LRITbO6cblEn2ZFN5+coHw==
//pragma protect end_data_block
//pragma protect digest_block
P1Eoo6xbF4SvHZhCwzT4uKiblnM=
//pragma protect end_digest_block
//pragma protect end_protected
   
`endif //  `ifndef GUARD_SVT_MEM_CONFIGURATION_SV
   

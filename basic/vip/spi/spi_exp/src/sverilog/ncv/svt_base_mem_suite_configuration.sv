//=======================================================================
// COPYRIGHT (C) 2015-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_BASE_MEM_SUITE_CONFIGURATION_SV
`define GUARD_SVT_BASE_MEM_SUITE_CONFIGURATION_SV

// =============================================================================
/**
 * This memory configuration class encapsulates the base configuration 
 * information required by memory VIPs. This class includes the common 
 * attributes required by top level configuration class of all memory VIPs 
 * (both DRAM & FLASH). </br>
 * 
 * For DRAM based memory VIPs class #svt_mem_suite_configuration is available 
 * which is extended from this class and can be used as base class by VIP suite
 * configuration class. </br>
 * 
 * For FLASH based memory VIPs this class can be used as base class by VIP suite 
 * configuration class. </br>
 * 
 * The current version of this class includes : </br>
 * - configurations required to add catalog support
 * - configurations required for xml generation 
 * .
 */
class svt_base_mem_suite_configuration extends svt_mem_configuration;

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

  /**
   * This property reflects the memory class which is a property of the catalog
   * infrastructure.
   */
  string catalog_class = `SVT_DATA_UTIL_UNSPECIFIED;

  /**
   * This property reflects the memory package which is a property of the catalog
   * infrastructure.
   */
  string catalog_package = `SVT_DATA_UTIL_UNSPECIFIED;

  /**
   * This property reflects the memory vendor which is a property of the catalog
   * infrastructure.
   */
  string catalog_vendor = `SVT_DATA_UTIL_UNSPECIFIED;

  /**
   * This property reflects the memory part number which is a property of the catalog
   * infrastructure.
   */
  string catalog_part_number = `SVT_DATA_UTIL_UNSPECIFIED;

  /**
   * Indicates whether XML generation is included for memory transactions. The resulting
   * file can be loaded in Protocol Analyzer to obtain a graphical presenation of the
   * transactions on the bus. Set the value to 1 to enable the transaction XML generation.
   * Set the value to 0 to disable the transaction XML generation.
   * 
   * @verification_attr
   */
  bit enable_xact_xml_gen = 0;

  /**
   * Indicates whether XML generation is included for state transitions. The resulting
   * file can be loaded in Protocol Analyzer to obtain a graphical presenation of the
   * component FSM activity. Set the value to 1 to enable the FSM XML generation.
   * Set the value to 0 to disable the FSM XML generation.
   * 
   * @verification_attr
   */
  bit enable_fsm_xml_gen = 0;

  /**
   * Indicates whether the configuration information is included in the generated XML.
   * The resulting file can be loaded in Protocol Analyzer to view the configuration
   * contents along with any other recorded information. Set the value to 1 to enable
   * the configuration XML generation. Set the value to 0 to disable the configuration
   * XML generation.
   * 
   * @verification_attr
   */
  bit enable_cfg_xml_gen = 0;

  // ****************************************************************************
  // Methods
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
`ifndef __SVDOC__
  `svt_vmm_data_new(svt_base_mem_suite_configuration)
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
  extern function new(string name = "svt_base_mem_suite_configuration", string suite_name="");
`endif // !`ifdef SVT_VMM_TECHNOLOGY
   

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
`ifndef __SVDOC__
  `svt_data_member_begin(svt_base_mem_suite_configuration)
  `svt_data_member_end(svt_base_mem_suite_configuration)
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
  extern virtual function void copy_static_data(`SVT_DATA_BASE_TYPE to);

  //----------------------------------------------------------------------------
  /**
   * Used to limit a copy to the dynamic data members of the object.
   */
  extern virtual function void copy_dynamic_data(`SVT_DATA_BASE_TYPE to);

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

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Returns the size (in bytes) required by the byte_pack operation. Only supports
   * COMPLETE pack so kind must be `SVT_DATA_TYPE::COMPLETE.
   */
  extern virtual function int unsigned byte_size(int kind = -1);

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
   * HDL Support: This method allocates a pattern containing svt_pattern_data
   * instances for all of the primitive data fields in the object. The
   * svt_pattern_data::name is set to the corresponding field name, the
   * svt_pattern_data::value is set to 0.
   *
   * @return An svt_pattern instance containing entries for all of the data fields.
   */
  extern virtual function svt_pattern do_allocate_pattern();

  /** Constructs the sub-configuration classes. */
  extern virtual function void create_sub_configurations();

  // ---------------------------------------------------------------------------
endclass:svt_base_mem_suite_configuration


//svt_vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
ger53oM+lUo76/8UIZzzyGIOsCYGKzw/kGgAmEjuXMB0uDBRKy1wNexvnPbaxfQP
Vsd+NIJZZCLo4Q+1bn4/Vy/i2EfNTaGqV8nk4zHt+CJIYtHLL2Xpe9rLzgFcfM8Y
UXbOCGcRdragaNBrByKu+6v/NX7xpPZvKR2Lf53GRk7ePmYfLWbokQ==
//pragma protect end_key_block
//pragma protect digest_block
Kwx/ini2AT5otRFME0NOuB7uJPI=
//pragma protect end_digest_block
//pragma protect data_block
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
TBdAkk1TW4QEsfSwSIrEaA==
//pragma protect end_data_block
//pragma protect digest_block
z3kTizAxEkzFLgJG8qQKtYnSOMc=
//pragma protect end_digest_block
//pragma protect end_protected
   

`endif //  `ifndef GUARD_SVT_BASE_MEM_SUITE_CONFIGURATION_SV

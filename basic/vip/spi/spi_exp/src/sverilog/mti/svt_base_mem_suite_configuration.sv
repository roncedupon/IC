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
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
nzl60mWgAIw7JYQZ84/Zo+ZRwVC9sa516WnpwSBI9NkWY5GsF565R0SmMUdc/sm4
qnR9AhKJ3aLyvyoEbTrasmxtQdPOcq/D9IohQiAzGxlEDh8sYImDGHrAdwrcFoPo
xI4V883ipZPOx2brNw+wolRH7kDHU/zXW9Edhxoo5XU=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 11606     )
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
`pragma protect end_protected
   

`endif //  `ifndef GUARD_SVT_BASE_MEM_SUITE_CONFIGURATION_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
c+0J1PbmgtSISYtrW1vq/jJnTiIPqL949GiSkpoHWoeUtwuOS7TOYM33L/pEwMTu
MzIssn0lLokCX88Bws2Ve9j2dCtrAqa4kdbTsnGsUw/DLL67KnBmKlGbp4b7Htxl
Ur0F49aYcEs6md/6l80+Pk1Zqa/Siq/Bs7iWQ10rNZs=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 11689     )
6dC7l4cYOzUrDj2wYsgn4AsMxGAgEC52tM6hYkwYUBlOOK3GUtRHRG/Ynb+tZ/Q5
4UiSW2jqE1Ctax/zaSMhxlMSOhltlrX+mI8VeKqK/q997QDoMNYYyEdhtOi5ahQF
`pragma protect end_protected

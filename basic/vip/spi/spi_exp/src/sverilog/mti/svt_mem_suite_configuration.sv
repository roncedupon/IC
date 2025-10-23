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

`ifndef GUARD_SVT_MEM_SUITE_CONFIGURATION_SV
`define GUARD_SVT_MEM_SUITE_CONFIGURATION_SV

// =============================================================================
/**
 * This memory configuration class encapsulates the configuration information for
 * a single memory core instance.
 */
class svt_mem_suite_configuration#(type TC=svt_configuration,
                                   type MRC=svt_configuration) extends svt_base_mem_suite_configuration;

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /** Randomizable variables - Static. */
  // ---------------------------------------------------------------------------

  /** Timing configuration class */
  rand TC timing_cfg;

  /** Mode Register configuration class */
  rand MRC mode_register_cfg;

  /** Width of the bank select portion of the logical address */
  rand int unsigned bank_addr_width;

  /** Width of the row select portion of the logical address */
  rand int unsigned row_addr_width;

  /** Width of the column select portion of the logical address */
  rand int unsigned column_addr_width;

  /** Width of the chip select portion of the logical address */
  rand int unsigned chip_select_addr_width;

  /** Width of the data mask */
  rand int unsigned data_mask_width;

  /** Width of the data strobe */
  rand int unsigned data_strobe_width;

  /** Width of the command address */
  rand int unsigned cmd_addr_width;

  /** Prefetch length */
  rand int unsigned prefetch_length;

  /** Number of data bursts supported */
  rand int unsigned num_data_bursts;

  // ****************************************************************************
  // Constraints
  // ****************************************************************************

  /** Valid ranges constraints keep the values with usable values. */
  constraint mem_suite_configuration_valid_ranges {
    bank_addr_width        <= `SVT_MEM_MAX_ADDR_WIDTH;
    row_addr_width         <= `SVT_MEM_MAX_ADDR_WIDTH;
    column_addr_width      <= `SVT_MEM_MAX_ADDR_WIDTH;
    chip_select_addr_width <= `SVT_MEM_MAX_ADDR_WIDTH;

    bank_addr_width + row_addr_width + column_addr_width + chip_select_addr_width <= addr_width;

    data_mask_width <= `SVT_MEM_MAX_DATA_WIDTH;
    data_strobe_width <= `SVT_MEM_MAX_DATA_WIDTH;
  }

  /** Makes sure that the data_mask_width is greater than 0. */
  constraint reasonable_data_mask_width {
    data_mask_width > 0;
  }

  // ****************************************************************************
  // Methods
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
`ifndef __SVDOC__
  `svt_vmm_data_new(svt_mem_suite_configuration#(TC, MRC))
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
  extern function new(string name = "svt_mem_suite_configuration", string suite_name="");
`endif // !`ifdef SVT_VMM_TECHNOLOGY
   

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
`ifndef __SVDOC__
  `svt_data_param_member_begin(svt_mem_suite_configuration#(TC, MRC))
    `svt_field_object(timing_cfg,          `SVT_ALL_ON|`SVT_DEEP|`SVT_NOCOPY|`SVT_NOCOMPARE|`SVT_UVM_NOPACK, `SVT_HOW_DEEP)
    `svt_field_object(mode_register_cfg,   `SVT_ALL_ON|`SVT_DEEP|`SVT_NOCOPY|`SVT_NOCOMPARE|`SVT_UVM_NOPACK, `SVT_HOW_DEEP)

  `svt_data_member_end(svt_mem_suite_configuration#(TC, MRC))
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

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Utility method used to populate sub cfgs and status.
   * 
   * @param to Destination class to be populated based on this operation
   */
  extern virtual function `SVT_DATA_BASE_TYPE do_sub_obj_copy_create(`SVT_DATA_BASE_TYPE to = null);
`else
  // ---------------------------------------------------------------------------
  /**
   * Utility method used to populate sub cfgs and status.
   *
   * @param rhs Source object to use as the basis for populating the master and slave cfgs.
   */
  extern virtual function void do_sub_obj_copy_create(`SVT_XVM(object) rhs);
`endif

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

`ifndef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Pack the dynamic objects and object queues as the default uvm_packer/ovm_packer
   * cannot create objects dynamically on the unpack.
   */
  extern virtual function void do_pack(`SVT_XVM(packer) packer);

  //----------------------------------------------------------------------------
  /**
   * Unpack the dynamic objects and object queues as the default uvm_packer/ovm_packer
   * cannot create objects dynamically on the unpack.
   */
  extern virtual function void do_unpack(`SVT_XVM(packer) packer);
`endif

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

  /** Constructs the timing_cfg and mode_register_cfg sub-configuration classes. */
  extern virtual function void create_sub_configurations();

  // ---------------------------------------------------------------------------
  /** Constructs the timing and mode register sub-configuration classes */
  extern function void pre_randomize();

  // ---------------------------------------------------------------------------
endclass:svt_mem_suite_configuration


//svt_vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
BsT98O83z7dRZiDHy8da+iOIbDqCW1WV3SI6erFHLeIaKm9PEo+zYCA6gLnfA0re
QeBSSGRzhoFP2W2qLCHHaBAUUit52wokVUwRwW3F6beKBabHlwix5Vpd86Jj+ERC
/kP7R8vitNGveXhdfaIFuU3SZ+/VR24YD/HOLmGFVx0=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 19140     )
+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
avwXTw5dauAPVPdeDpU8aja71+szgiHRbxbn17kTg55cz/mmzewSDF/GpDVp1BUJ
p8KNYPB2TxR3FvI59qccTaadfmdSUCo6/Bd5pOyzpUpdEoIW1RKFWmvJXKEgFk4i
G4WvyHD4uave85vGWUAjgPthQEY2KY1RPUX43RoDz0aGsLeh80i9FeRTDaLPoLRZ
0WjlY/vwX7FJta9teQzrAm4/omOMLuNT3DXm9WomorcsXja+SkkzcMtrjUio7U2u
S7AnRgLddTKwft0bMJDnugwqJCeMxP9UFSh9iEf+1qpLpJ4gpQX68oPvQ5/pHV4q
UI//s7Tn/O0i50pqdPWzhPKa60gwgpihbm/6+h3eRMDM0xD1plo/9lJNErwxXuT5
9SebCDDAWqcdFKmtkLl2n3uQgNlmlVHpS/pIPYYAiS+9Ovhz+kZ6ZAdoDGj0Gf1i
E263Lw9XNz2K2YirhQkG1WJ1TX+DPq9DbEaKgBFaTEa+7VqBSuYAQpQlpTUtWwAt
w6P5WYVZi4B/uiWEWIoy+Qfm863msx+Cye95oYvWBCnUlF6fQV7ZEeI7938PztMV
Zw/0ixuXgasmysiVuc5/PVQUf1+pxpfrKz09qMP1ORCPPCeFY2LOZo/WSbWob7tu
w89R9prbSb48kDQxrCbbLw39nKAUk3QPMiOgFFRO3AZaCFt8ZZX7uFhp21rba10o
s5ylsEMfkK8a4SWP37gH4/O17pRa483PVPA3CRqz3T5Pvzbj5WO/WgoPxoDvhKcO
JCykSmNh8/b5OSsafhBkoFH+JktqdRSXKu6lc3RmJub41E40EI6yGY6hMWclcLUf
ZccyYtt42qPhdwjMRwS85VMp+v1B667rzvo851sIHY9BTKAx7CW2w09Jcb0a5UA7
8Xb+kbUy4lmaH70oZU3WNIgOyklvCjyIZRtwyfmtp+1bX2ZaVnqqIPlpFCGrqTHp
G+CItDS/O0j2o/d7vbhdCOKdur2yzpYxAjH7Obcp/qd72tKWbF4zg1PojB+/ly1a
nB2ac4IDtYl6b/nB6zbipHpU7V3E5UTwHUknG6GcDRPps3xsq7TGDT4+WHdSttLs
cFnFj8dSP0/rVlwdhNvqLEz+H1MCQFAGlyF1O5c1HA1RaWsLOiD4/Zlu3h6Gqff0
isWttwR0LXfKPK+z6ZWz+26rrkQISSDOVJ5z7qDyeICLOJN6kENTRJGSGvzX/P+P
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
`pragma protect end_protected
   

`endif //  `ifndef GUARD_SVT_MEM_SUITE_CONFIGURATION_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
RjfsgarjtFnjsG9M/hyi3IuFzWVywLRee/d14Qd/8EO9p5nar5T0VLTRTusUjacv
TozhEqzzKb7mKLPtqA0A04JC1lCmNaXKokMIExcWmpOT2tNmozRx49CmOezc9XV2
GnA7ZbNllKRO2PEDGCEuIjramS3ud918E5GyVGg59Iw=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 19223     )
sLq0UPoPXZ5pNQyOBMWjMF7ZT+w4iW3n3kqeNZIRS9oJOdAsi3/UKdxlvqqtzWBP
34yZXZ+ocnG/TdffK9Ol7/EFl5EtT4mLvFk2JDlGCb8VeoUcrOBqKBWJEAxH118Q
`pragma protect end_protected

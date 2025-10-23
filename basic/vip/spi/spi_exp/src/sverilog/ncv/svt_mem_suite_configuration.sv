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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
Pg/6B2e6AglyO8NTnzDSrgtwRl/oMquQcaEy1RRHwHCqFLeu4CIVGXFjLbuet5j4
vfpf0IuB8uYAa1wfCCVLiWsY7a+tf8tMN0CUsbFyR2d4JbwvOp4ORErOuTt4TdEF
Hiq1y7dCkYXDONrwRDgowW22rNU9IyGLXnSzGMLSGVijecAVwhvf6g==
//pragma protect end_key_block
//pragma protect digest_block
0PK5YOAAVncv8nC3uZHBubu+oWo=
//pragma protect end_digest_block
//pragma protect data_block
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
cBS7JOQ5zHXmThqBhSJBq/CstWgnoDYxsCoAzlElgOKSSRIQ3kgSfSwrkDib2Y3p
Rl3EvmWxYoEIcPXIiBtV1zJF/j8t8SdShC+TkflfaE8q4mqr2q3ILHT1viCEZHRJ
PQxh4pBlaArQxQcnZw5ZWN2TG74VS55TdPPhEnRIt1DneFydcV2mBHDb2B8pBrYG
5eJU87gcuBoXQsFlkjIh+ptkrCeGHfpOIAUlKzEsFxqCBdvvMHgebLM0KFUxqHoQ
B8fK9Yn9GKjvb4HdwBv8EjBPbAcCyxPPcFnpGeHYzC7iJQRG4Mecs/u7hyRcgAPQ
nHiKzwuyKhTusHa7iZ68p6N1WQb4TD80e1ylcJlhjG8EmiGOey9oHUheBX/lkKC9
yuPZ0arz6MysIqkzHrtqBGwajAb8jHjYY4qS5qUtCvGFNLuQ1GsA7w6+VXSDFYDP
N60Vc+MPh8l8LhSh6yrM1MhJVaSpBxWDltR0Zt62prAH+VkGwgXRpP+pih5dXUS1
qMtr2jPMkyyuOJlhQtgreMJInNsIThjM6NbuxJXhX8Xzs0IaE4XQ3O1lAvKFLVU3
R7XSHbq4uyqTUzXwxXqjkhGpRS90i//uFKnaqevC5zDlrt5eALE43lLKhAc9FCPc
iLBjyIE6jq64bpuxysbrAO8PMcfF6Jhf15B8v6NS+5qwqis0YOxJOcCXD7OoLzvt
u3UamsyZbo6/c7i2hdCpK1xpOQjIq1I/npTHq/2esiS17MpOR0knvsSQr1UDolSo
wHUPeX2bq5qHkTxUSyXZnKv2CLFJklpno8F+q1VHgYy8OacHT3uF8I74DLNcPQUH
qbTw/7HrsR77zUPQBWpu94rZWDTVt41Q7fJp1Bqu2UAcb9xqZY1rlYaDB3pOcrWI
z/MU9hdvB6xKmWdK95+8mRgSrdUQbX87N2zrOubJ8tF2p3TUkGPT+h0AHzTiMXz2
YUJHyrafUyJkrKjhNDtLVf+DAftX5mig0l0DGwq0LkQXI8xPaSaAuf1jzmmhd/hL
4d9JSJ4mHu+UicfPi33VXLItfOs1iquaSZzBEMJbzqdLmaW09fGzFU2W2h0qSvlt
TgXpBe/3xbcXeV0IooLf/csHtgbWHiiNXV0HzDZOwniLswN1lawcJZ4+Zhpuz5rd
CuxFy3PdburWYkwP4H8nGprYmgvZ7MBDY/0m4Bg5OUPyCYSx4vNtNuCDZv7z0WXO
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
cgnYKpap9jC1XvSG0Kerxw==
//pragma protect end_data_block
//pragma protect digest_block
9cNI1pM6fiXG2W7+4uUesqhCeU0=
//pragma protect end_digest_block
//pragma protect end_protected
   

`endif //  `ifndef GUARD_SVT_MEM_SUITE_CONFIGURATION_SV

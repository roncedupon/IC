//=======================================================================
// COPYRIGHT (C) 2016-2017 SYNOPSYS INC.
// This software and the associated documentation are confidential and
// proprietary to Synopsys, Inc. Your use or disclosure of this software
// is subject to the terms and conditions of a written license agreement
// between you, or your company, and Synopsys, Inc. In the event of
// publications, the following notice is applicable:
//
// ALL RIGHTS RESERVED
// The entire notice above must be reproduced on all authorized copies.
//-----------------------------------------------------------------------

`ifndef GUARD_SVT_GPIO_CONFIGURATION_SV
`define GUARD_SVT_GPIO_CONFIGURATION_SV

// =============================================================================
/**
 * Configuration descriptor for the DUT reset and General-Purpose I/O VIP.
 */
class svt_gpio_configuration extends svt_configuration;

  // ****************************************************************************
  // Local Data
  // ****************************************************************************

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

  /**
   * Specifies if the agent is an active or passive component.
   * 
   * Note:
   * The GPIO agent currently only supports active functionality.
   */
  bit is_active = 1;

  /**
   * Minimum duration of the reset assertion, in number of iClk cycles 
   * The default value is 10 clock cycles.
   */
  rand int unsigned min_iclk_dut_reset = 10;

  /**
   * Minimum number of iClk cycles before the DUT reset can be re-asserted.
   * The default value is 1 clock cycle.
   */
  rand int unsigned min_iclk_reset_to_reset = 1;

  /**
   * Report an "interrupt" when the corresponding bit on the 'iGPi' input signal rises
   * The default value is 0 (no interrupt enabled).
   */
  svt_gpio_data_t enable_GPi_interrupt_on_rise = 0;

  /**
   * Report an "interrupt" when the corresponding bit on the 'iGPi' input signal falls.
   * Can be combined with enable_GPi_interrupt_on_rise to report an interrupt on change.
   * The default value is 0 (no interrupt enabled).
   */
  svt_gpio_data_t enable_GPi_interrupt_on_fall = 0;

//svt_vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
kkuYuYANEeDp4FBbTjM0udxbnOLsTH2fdE7ux3vj35TH4pWsBgs18b5HHtsFLV0k
+zPFTG7q3xspcB7FlYSKz9Gp8n1UU3hnQtuXH/PXiBdsrruYF8vbfuYSJ7DIseHD
6fKLE/QkdhpJri+VehKHcv55U2e4+WXPLpkyC7ENhrLLjoYhnKe63A==
//pragma protect end_key_block
//pragma protect digest_block
4F2o2yhjdkaxue6Mny9jv8xJlwQ=
//pragma protect end_digest_block
//pragma protect data_block
ViuimPfgTJ0iAfPXDPlCapTl7G0bPJIoGNoRvnXPDdLCMyPrhVK1byfyEgGX/B2d
RJT6iERCUPFWzQcB7dezFP6fCbZ+oxBE9vq52yZ77j6VtFDhYF+qmVTY5GIBCRmd
mED8cYf4Prihku6gDzd391EPjvTEYd/YZ+mdmxBPIv4zjOWYWA1y8kJeMVYxKhGS
vocxGNhY9qDWeV0ELR29xE2/1+KhE0rfwUAVBLVGRDkJ7tTexnk9HrJ79WwG407E
6ptCgEggFo2WEbAHDnY1RnTMzd3sRhaWiBGVjTM/Ol89xFL3OZJ0znVHs+xzP4rJ
Pi3onSODYgS8HPrBlz0AtZtOT2LA8GcbiNP8WjKGF7j0TDD2c5ZK0xL0FamK+U+Y
TUNYyGmeRkQHnPvFrlsJduIcx0TpxTpl3nSec+SkBG1jG81lw3EUPV6w6GX/hTb7
0m7UjLsrC/6v1iAPTCrZHoG96K87eFaDHvrZPVo+quYjarYvCahVVdQgIgAlvTut
kQ43KS98vwcVo09RDy7dQG7vZ/LiNNJ/UIhBz4Y3lYnLCoi4tWSP1hFpZ5DEs2VG

//pragma protect end_data_block
//pragma protect digest_block
P1XDWzZjjwu0X8VFUr4UI1RGbZ0=
//pragma protect end_digest_block
//pragma protect end_protected

`ifdef GUARD_SVT_VIP_GPIO_IF_SVI
  /**
   * Virtual interface to use for a VIP.
   * Valid only if 'hw_xtor_cfg' is null.
   */
  svt_gpio_vif vif;
`endif

// TODO:
// Need some constraints here

`ifdef SVT_VMM_TECHNOLOGY
`ifndef __SVDOC__
  `svt_vmm_data_new(svt_gpio_configuration)
`endif
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the <b>vmm_data</b> parent class.
   *
   * @param log Sets the log file that is used for status output.
   */
  extern function new(vmm_log log = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new configuration instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the configuration
   */
  extern function new(string name = "svt_gpio_configuration");
`endif // !`ifdef SVT_VMM_TECHNOLOGY

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
  `svt_data_member_begin(svt_gpio_configuration)
//svt_vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
/M+2j7FuJvuJ9UqqwoCFnCZMFhalqFan4MOkBNUrvM+b5c3XasVOIB6oygOrfb5o
DvAubPPO8QEmmQTukh8vfDmvcQQo7XLyCfnfIkt6OXNZ5dvWrxuEz0ELt+vaZ+Uk
8Y/Ij/ZhZzMxce7OJ5PplfDb6XJvImPPVXBcdmmlJFijvnuy7iSmEQ==
//pragma protect end_key_block
//pragma protect digest_block
bsocKBjafBTdCduuTk209qvZyko=
//pragma protect end_digest_block
//pragma protect data_block
eoaJHh5BTsjxpQKG4RkgC82XzwL0wpOU4vVwAkVztuf+3VnrpB4IXKtcQQWppEc4
AemrlESTJfK25KQ9s+ZYj5ZSZaMzbn1nn8exscDCDYP5MP6FY8lMOiuXW4IJYb2p
zbpLplnt8TqNDjJfDJPqeWvkNoZIc7CwYZahz75xdxjkD5t2XkS6X+QYjHsjbRK5
Wwy+zokRb2pWVEOuEn21DZ3fBBJFhYNEDpGvdb/Q3qx9/KX1eU/y/yhrE5FIO77l
o6LuBZAvOt8HavORzbRJR+tLHDjXwkJQWNA0f2mvVpJjoshQF3Jl8V6D7qrekh75
+Lrtpo5FPmOplFzJo5YZH0xqDZQS3vFOeJvQzeaEnqqq75qMuoCqA04N/7Tc1+jz
wVEy/nT13WpDUgyQHqtoZLuKUSDsfGYlaj3Xped7GApCPetQqzh+ZtcNbgdAMaNx
jdGy3dX9SxoLYD33ZPisteDNm84rExUvGsDleBWLeH8aSTQbjXq1zBPKETDurYFM
zXt54EYT8aRwhMXQA3y3OBxOu2L2XK6z7S/WMoDY3p4=
//pragma protect end_data_block
//pragma protect digest_block
zCihSuZ5gEFO1SSFv1VM8vzk2Qk=
//pragma protect end_digest_block
//pragma protect end_protected
  `svt_data_member_end(svt_gpio_configuration)

  // ****************************************************************************
  // Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object used for logging.
   */
  extern function string get_mcd_class_name();

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
   * HDL Support: This method allocates a pattern containing svt_pattern_data
   * instances for all of the primitive data fields in the object. The
   * svt_pattern_data::name is set to the corresponding field name, the
   * svt_pattern_data::value is set to 0.
   *
   * @return An svt_pattern instance containing entries for all of the data fields.
   */
  extern virtual function svt_pattern do_allocate_pattern();

endclass

//svt_vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
ErPC3OD4m6FTgyhoveZTgUUdEYrWdMRJnftIpyCdLFzVSm8PehPr525ME/z6IhNe
upO4yZ9brV/hIGvruZonXJU2UwGlb3RJKsySQZFcOClwXcUrNWVBCExyA2dm76F6
DSxlEEkQSWPnWKnhswshbKW+3NQ9BNNJNWyrwZ8SfXMbBtPG9ncB9Q==
//pragma protect end_key_block
//pragma protect digest_block
gh8XfgkFlHvRIBGIfqqTV6MEblU=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
sv0N0K9Da9hdHNTD83VlJ/qTc0c=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_GPIO_CONFIGURATION_SV

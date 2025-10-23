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
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
YjRBRJqGD1+NJShefPFx0NG2ikbY5rX0dSuL1y9k0Hy0efYNXmGbWWMZzeAuQz6x
0f1H85Ql3kd1C/6xrg2feORNSwYeTV+eqI7mcQPHEfS0Xj7/6cBcD1yi4lURo1QO
7eQL3Xjgd/QmHuoBwGe/Bu+g2MlxQ++X9HfLBrCU08s=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 263       )
yRRQwhqWN9a5hIFDMyXCALOloIxX3NbYiJCglC/vUcPORVfdzM6XsO2D4v0ZrRbR
a3SEv06XyxQw8PpOnmKqhC71Bjht96wiSEx3vfvEeGticzA+nAbfdeD/M+j8xgbg
cGKWIMYx+33oUrbyfHhPaS4d2EfdREJQIjXhkQrROHrZp3Tk32OBTZySRaa3sSuH
iAMvMCrZDEup9qQQUgAGRhwL2oUw98NK9P5OoabJBeaT72A0hN9VjT5TY7JuN4gc
UfzQ42vjWlWtgZMtDVNGDzZDq9gRZ8excB7jTh8PuTKYgLlDsLxBSaSlhur/pGsk
4yrmEFyItC2dQvFVdhtcYI8KXVqbVVwxv/JE8T7BlYw=
`pragma protect end_protected

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
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Ks2YL3njubz1WaC8dBZnGMZMnSSlSmphFEWPcsS8XCrCbJR93PL4uYbNndFg41Py
1PalzI7MPQ1spWx3cS8+IfRzcFW7CCvGSExgQzCd2wR6zrJeLmVjNzTVWxNcRLB2
NZ/UWlUqJojk8x2leFRPWKgvoG8MbnXiAKcoJAHYK2o=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 505       )
JcUTBXe4RJ0fu4wiJ/ZO/gQPTV2e0Q/qFkY8dcm4HKdnnvlS2GzKxFdcWn2+YVx0
++mZrpQsXsWOvQqaYwItzI86e1qafSlD8OyISNl5Zs+PvQeIrHssRF9FyuSTy6+w
1vFjnnHfaSJ32f8DLmXfqEHaPjv5MRY8+qa/CaS7py//XGTdE7ZYRmkdvLqRfTTd
jSpTVQM3Cm3tS4PbSCZnreQuYD0W70SWGfeAd7P+l6NAEyV55uO0lIBkiLnQBXRz
fRPjBGP0sgGHs61y6Z2JUga80CXwLa5gd0/Wq3DnJ+Re04z6giVq/8m3ceM9ke0a
P6IxtL71qfQslne5sOoQsA==
`pragma protect end_protected
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
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
gLw19qt/G/MqajW5iJ6BKVlgGZLdsFcQPtBNfNRQ27buk8WJKvYdD359df2+izWx
G28Ub0gbH7wzs327YcZC0ZXOw180qwk/LyuxH4g43P1Egv0jBV5Npx4//wqgIw82
G4IfRMoy3FRGan0mZrNs19CV71cRz+J+UIhH12H489k=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 15060     )
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
emL1ruvqqAiP/uwNQqIDyA==
`pragma protect end_protected

`endif // GUARD_SVT_GPIO_CONFIGURATION_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
SmIDjUsZI/zcWQTFYVLqI8n8HUj/s+RQqLBS5aDkOSeDaEpkgHQg1cwWqE7MaMpW
uIYJ7EX5eE9ksa3jc2WAxDzcBKJsAbx27llW2FAIgMIZ0Ny4zrNGc90sFDDJtVUG
8abmLJRU26Xv8PqjrhoIf+eRukGCD/QeASfgVloT3SA=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 15143     )
8PfsG3Z5NHW686YI0PlaBF8ZRUqfgedPWcftGo6LGhzJfYJmtKVlaiQ23x5LQ4PA
vX1u1przIDwaF5g3aQNXonqrNuLjIlmhI0E8n4OmGuFsZliKDKhkxilcS/S3H2tj
`pragma protect end_protected

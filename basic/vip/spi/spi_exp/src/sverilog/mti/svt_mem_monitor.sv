//=======================================================================
// COPYRIGHT (C) 2007-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_MEM_MONITOR_SV
`define GUARD_SVT_MEM_MONITOR_SV

//typedef class svt_mem_monitor_callback;

// =============================================================================
/**
 * Class that provides the basic infrastructure common to all SVT MEM UVM/OVM monitors.
 */
virtual class svt_mem_monitor#(type REQ=svt_mem_transaction) extends svt_monitor#(REQ);

  //`svt_xvm_register_cb(svt_mem_monitor#(REQ), svt_mem_monitor_callback)

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************
/** @cond PRIVATE */
  /** Monitor Configuration */
  local svt_mem_configuration cfg = null;

 /** Monitor Configuration snapshot */
  protected svt_mem_configuration cfg_snapshot = null;

/** @endcond */

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new monitor instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name
   * 
   * @param parent Handle to the hierarchical parent
   * 
   * @param suite_name Identifies the product suite to which the monitor object belongs.
   */
  extern function new(string name, `SVT_XVM(component) parent, string suite_name="svt_mem_monitor");

  // ---------------------------------------------------------------------------

  // ---------------------------------------------------------------------------
`ifdef SVT_UVM_TECHNOLOGY
  /** UVM build phase */
  extern virtual function void build_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern virtual function void build();
`endif

`ifdef SVT_UVM_TECHNOLOGY
  /** UVM run phase */
  extern virtual task run_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  /** OVM run phase */
  extern virtual task run();
`endif

  //----------------------------------------------------------------------------
  /**
   * Updates the monitor's configuration with data from the supplied object.
   * This method always results in a call to change_dynamic_cfg(). If the monitor
   * has not been started calling this method also results in a call to
   * change_static_cfg().
   */
  extern virtual function void reconfigure(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Returns a copy of the monitor's configuration object, including the
   * current configuration settings. If cfg is null, creates configuration object
   * of appropriate type.
   */
  extern virtual function void get_cfg(ref svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Copies (deep) the <i>static</i> configuration properties from the argument
   * into the configuration object stored in the monitor. Used internally
   * by reconfigure; not to be called directly.
   */
  extern virtual protected function void change_static_cfg(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Copies (deep) the <i>dynamic</i> configuration properties from the argument
   * into the configuration object stored in the monitor. Used internally
   * by reconfigure; not to be called directly.
   */
  extern virtual protected function void change_dynamic_cfg(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Copies (deep) the <i>static</i> configuration properties from the configuration
   * object stored in the monitor into the argument. If cfg is null,
   * creates config object of appropriate type. Used internally by get_cfg;
   * not to be called directly.
   */
  virtual protected function void get_static_cfg(ref svt_configuration cfg);
`ifdef SVT_MULTI_SIM_EMPTY_METHOD_FLAGGED_AS_UNIMP
    int dummy = 0;
`endif
  endfunction : get_static_cfg

  //----------------------------------------------------------------------------
  /**
   * Copies (deep) the <i>dynamic</i> configuration properties from the configuration
   * object stored in the monitor into the argument. If cfg is null,
   * creates configuration object of appropriate type. Used internally by get_cfg;
   * not to be called directly.
   */
  virtual protected function void get_dynamic_cfg(ref svt_configuration cfg);
`ifdef SVT_MULTI_SIM_EMPTY_METHOD_FLAGGED_AS_UNIMP
    int dummy = 0;
`endif
  endfunction : get_dynamic_cfg

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
GxBeLvFW2kZEsr6nt7jXbo24XbMxlVTe5ue1j0c9W4AbqxJ/un/oX2yjjsz2EodX
/LF16qt+Iq4bnGfnoNE1nz37r8mUn7E6HIwAYCICGoPa6PnXpETmh2FMfRfZQim0
fAlS1uFtZyH1vQYx7XP8iG9ZYtNFuk0Qo+0euBdIr4w=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 132       )
e4cFP07bM81ZxmmSfY+k4/IZPxfraG3xszcqevgjA5W9bE8GfhWxU5NsW7o5nmJL
dxlo1sOD2Bu89gOOE8x0QIRa5oPw/PjtSmp6JYNSFto6LvnmluQnrd96/yeNKd4C
xb+VgHpAMGWP+cR/4BzbxXrEi9cPh3YQgTSwR1iDkDw/XD1W7AkScWClbyLDmhOa
`pragma protect end_protected

  // ---------------------------------------------------------------------------
endclass


// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
jwfo3VQ5hr0ZVqjA2W5V0VSAY4OsCSPQ7RZknFk+8q1vMui9uxfYOkmyg6ydb1EJ
MJFeUlYOdNZqsfffPVT8kwWYvJizJyiXpXoBphNwxmfUFGFhhx7hcSMbBD2c8hB6
5mIqdjWQtGojV08xwr/U6zH4hwZbvpCG13dB9PYF2yk=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 445       )
m6uT8ZZEs2sKFE7pZlVEwzd6WXrKJCX6qljcEr2WawA3Ic7QasZnvg2ozIptK+/k
j80boqZYgyGF5Kztp7rdBhOrFgKbmSxI2OVWLG0Mwe8+b6oc4mZ7lYAdCWDpvioO
L69HqGRZs7W58lFVb9xUQxT7gDkReuy5V0riC95AAJneD9OwCZ89XdFfJrc6EINs
+1uyM1u0Cnb92BqtuDDjq7RfC7OW+vgax5fjROJkBi7YoWxomeLvY1G+G6oAbeOL
ovrJwd7gHOexXbcgyQ6PAmYluuRQt7vurUMXbOQCVC4nP4GgRTrhkxRmSPtJz8rK
MVGj8Me98N1qO0qQhPEJTs+A8/xChjNZAJascu+BT5v651I+1q4EWnT1AS9nq69S
/yEmRoNiTnzK+gQ1p7SeHcsHQ2W5F1Vk5UyIMlwyXZY=
`pragma protect end_protected
// -----------------------------------------------------------------------------

//svt_vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
HJzRmGwMv5U0i83Z35lAUOoflZ2CL1YxEvLvTs/09ppHSb+QeBG/CjmOB1HIyySI
QmqRwvZmuODItj/ZRdkPMp6WjjZgT/U+WEPivwky0ovPAwWiBjodCEjSlSnR5/jp
RPpGud5Xg7t7FmL10pNX6LygT/V+nAkukZ2ZdTN8dxI=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 3145      )
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
ueB30hU4jiuSLtRmQVlE0A==
`pragma protect end_protected

`endif // GUARD_SVT_MEM_MONITOR_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
aLIDmxlWYG0LnZrLwuzsSMkAH5S3v/1g7i4BG6CPzGWxowd8XB50LrEwkKGZiTvF
PBaMaRFCDCAB4ykqdE4VEt/nQiRclnEacVZXNCF/FbfZ3ZJxYfvTBz0JI1C0wpLi
DJ2fpd8g23R4Vx5qZdeQ3G9ILTyJvYiLHy+O++lw0zY=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 3228      )
ExrhjkIAjy5Cq1xsN7qbTF207jFuJK/wXZjVc2BrNCxSuAV8SDgNXeNg79h2sWar
omT7vZzsx6VqeRb6xvYM90drSGlg0TBIXx39fy3YDPiBKl2lWwSmYWEkyBm/tGQq
`pragma protect end_protected

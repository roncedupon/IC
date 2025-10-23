//=======================================================================
// COPYRIGHT (C) 2010-2015 SYNOPSYS INC.
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

`ifndef GUARD_SVT_SEQUENCER_BFM_SV
`define GUARD_SVT_SEQUENCER_BFM_SV

virtual class svt_sequencer_bfm #(type REQ=`SVT_DATA_BASE_TYPE,
                                      type RSP=REQ) extends svt_sequencer#(REQ, RSP);

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  /** SVT message macros route messages through this reference */
  `SVT_XVM(report_object) reporter = this;

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

  /** 
   * Flag that indicates the driver has entered the run() phase.
   */
  protected bit is_running;

`ifdef SVT_OVM_TECHNOLOGY
  /**
   * Objection for the current SVT run-time phase
   */
   ovm_objection current_phase_objection;
`endif

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
mY65HnHfxWNidhN7LdhPEiYzFFaeXkb16cOwyzwWcOf73p4roPEXo+4Foi7yc+Uw
F/vAeJVsxKLKAqfQM2huEzbxpRs3Qz2XaqvSvcgl4EgEZZED30+qLYhRsQbDgSVd
Krmxyf0TCauiw46oGuoeO2jnaE+0ktLnBpvO36IQR4k=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 386       )
bBJXRqPog5VuLH1m4zET/OoTGPbjQ2dLwgBVXn8kqSaRvA84B7YHwrvQLbivBI+r
p10NyPH0O5lpWBu4x/ssHY9DlYsIMH4XLy+oovGkICRyrXygfWIJi2ENy+z8urAA
FeMkSU3fD/av74sOEUJC/eArotTciGxep7f8QB7qNJcX4VUteBtXnx4Wh7OlH6G2
WjI7EhTPPI6USTrjnxfLXCozZIdS9jN7lDfDnt1LpF+g+Jga+h8ssyTHq4jJ7dEr
iI/0RR+1Jeur0+EyHHJgSqmGUDXPuA+agsdfB5RwNRskmyW73f3916IYzHbM2ixv
5kbBvGMiWwqt9MI3QFp3tav6Tg35udc+B21HAzh7fYrzKErO4KSrFxE83O+drYYS
ZDQ7cAF2oOPDHvw1MVdJCcQMRRx5ujpEurHwFjKzvRNvsZPe83EbalZeaVBXPMEy
I8MRrchkmwrOaytlHpCoLyovMnNXLiG1SPH/3LRbNjMNfDNNhozOweIaJMuc9GF6
EBPRBtqgCd7GA7gSqiWm4w==
`pragma protect end_protected

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new sequencer instance, passing the appropriate argument
   * values to the parent sequencer.
   *
   * @param name Instance name
   * 
   * @param parent Handle to the hierarchical parent
   * 
   * @param suite_name Identifies the product suite to which the sequencer object belongs.
   */
  extern function new(string name, `SVT_XVM(component) parent, string suite_name);

  //----------------------------------------------------------------------------
  /** Run phase */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual task run_phase(uvm_phase phase);
`else
  extern virtual task run();
`endif

`ifdef SVT_OVM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  extern task m_run_phase_sequence(string name, svt_phase phase, bit sync = 1);
`endif

  //----------------------------------------------------------------------------
  /**
   * Updates the sequencer's configuration with data from the supplied object.
   * This method always results in a call to change_dynamic_cfg(). If the sequencer
   * has not been started calling this method also results in a call to
   * change_static_cfg().
   */
  extern virtual function void set_cfg(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Returns a copy of the sequencer's configuration object, including the
   * current configuration settings. If cfg is null, creates configuration object
   * of appropriate type.
   */
  extern virtual function void get_cfg(ref svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Copies (deep) the <i>static</i> configuration properties from the argument
   * into the configuration object stored in the sequencer. Used internally
   * by set_cfg; not to be called directly.
   */
  extern virtual protected function void change_static_cfg(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Copies (deep) the <i>dynamic</i> configuration properties from the argument
   * into the configuration object stored in the sequencer. Used internally
   * by set_cfg; not to be called directly.
   */
  extern virtual protected function void change_dynamic_cfg(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Expected to return a 1 if the supplied configuration object is of the correct
   * type for the sequencer. Extended classes implementing specific sequencers
   * will provide an extended version of this method and call it directly.
   */
  extern virtual protected function bit is_valid_cfg_type(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Returns the current setting of #is_running, indicating whether the sequencer has
   * been entered the run() phase.
   *
   * @return 1 indicates that the sequencer has been started, 0 indicates it has not.
   */
  extern virtual function bit get_is_running();
endclass

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
algOV2HwRPwP/VgqUs9WmGDbwtW/s0O999QGGuoX9IZrefsf/alSDNmODPFvg7aZ
T4itStWTPrY3Od5fXKOrx5gm+uwF30Wyy8vAsoDIWhzKanRAIa7PyeusGsL38Eh8
UuZMrN8Svlh/36jb7xSWDFgEdoFslXmSLdB49TlZEag=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 8532      )
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
`pragma protect end_protected

// For backwards compatibility
`ifdef SVT_UVM_TECHNOLOGY
class svt_uvm_sequencer_bfm#(type REQ=uvm_sequence_item,
                          type RSP=REQ) extends svt_sequencer_bfm#(REQ,RSP);
  `uvm_component_utils(svt_uvm_sequencer_bfm)

  function new(string name = "", uvm_component parent = null, string suite_name = "");
     super.new(name, parent, suite_name);
  endfunction
endclass
`endif

`endif // GUARD_SVT_SEQUENCER_BFM_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
SeBJ9aIJJSCpDWsu7oRZ4EMiCQiMOCUOUneuNhTYWWxVPScBQNdOo+epZUE3aIEr
mnhtRri5aIu4spDjQ02xsUnBROYXyAQLn3GmZ83hQ5W4cOMtw51CYl21od2wNRKb
luAt5FPG/hmOIwpl62vP7Mkp+BjiC8XxkfeZaEaN84E=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 8615      )
UdwzeEykm/6IwvmJDBwo+piMDUxvluGgSKRvd0k4wCtkDnDdtZO8ngCABDL++rQR
zz49iCLwiNViydHrEU/scvGinNa/lRoFprjHv34eSY4Cy3mP27BQsRMYV/PqdfR+
`pragma protect end_protected

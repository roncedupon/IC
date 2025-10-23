//=======================================================================
// COPYRIGHT (C) 2010-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_SEQUENCER_SV
`define GUARD_SVT_SEQUENCER_SV

/**
 Macro used to implement a sequencer for the supplied transaction.
 */
`define SVT_SEQUENCER_DECL(ITEM, CFG_TYPE) \
/** \
 * This class is Sequencer that provides stimulus for the \
 * #ITEM``_driver class. The #ITEM``_agent class is responsible \
 * for connecting this `SVT_XVM(sequencer) to the driver if the agent is configured as \
 * `SVT_XVM_UC(ACTIVE). \
 */ \
class ITEM``_sequencer extends svt_sequencer#(ITEM); \
 \
  /** @cond PRIVATE */ \
  /** Configuration object for this sequencer. */ \
  local CFG_TYPE cfg; \
  /** @endcond */ \
 \
`ifdef SVT_UVM_TECHNOLOGY \
  `uvm_component_utils(ITEM``_sequencer) \
`else \
  `ovm_sequencer_utils(ITEM``_sequencer) \
`endif \
 \
  /** \
   * CONSTRUCTOR: Create a new agent instance \
   *  \
   * @param name The name of this instance.  Used to construct the hierarchy. \
   *  \
   * @param parent The component that contains this intance.  Used to construct \
   * the hierarchy. \
   */ \
  extern function new (string name = `SVT_DATA_UTIL_ARG_TO_STRING(ITEM``_sequencer), `SVT_XVM(component) parent = null); \
 \
  /** Build phase */ \
`ifdef SVT_UVM_TECHNOLOGY \
  extern virtual function void build_phase(uvm_phase phase); \
`else \
  extern virtual function void build(); \
`endif \
 \
  /** \
   * Updates the sequencer's configuration with data from the supplied object. \
   * NOTE: \
   * This operation is different than the reconfigure() methods for svt_driver and \
   * svt_monitor classes.  This method sets a reference to the original \
   * rather than making a copy. \
   */ \
  extern virtual function void reconfigure(svt_configuration cfg); \
 \
  /** \
   * Returns a reference of the sequencer's configuration object. \
   * NOTE: \
   * This operation is different than the get_cfg() methods for svt_driver and \
   * svt_monitor classes.  This method returns a reference to the configuration \
   * rather than a copy. \
   */ \
  extern virtual function void get_cfg(ref svt_configuration cfg); \
 \
endclass

/**
 * Base macro used to implement a sequencer for the supplied transaction.
 * This macro should be called from an encrypted portion of the extended file,
 * and only if the client needs to provide a 'string' suite name. Clients should
 * normally use the SVT_SEQUENCER_IMP macro instead.
 */
`define SVT_SEQUENCER_IMP_BASE(ITEM, SUITE_STRING, CFG_TYPE) \
 function ITEM``_sequencer::new(string name = `SVT_DATA_UTIL_ARG_TO_STRING(ITEM``_sequencer), `SVT_XVM(component) parent = null); \
   super.new(name, parent, SUITE_STRING); \
 endfunction: new \
 \
`ifdef SVT_UVM_TECHNOLOGY \
function void ITEM``_sequencer::build_phase(uvm_phase phase); \
  string method_name = "build_phase"; \
  super.build_phase(phase); \
`elsif SVT_OVM_TECHNOLOGY \
function void ITEM``_sequencer::build(); \
  string method_name = "build"; \
  super.build(); \
`endif \
  begin \
    if (cfg == null) begin \
      if (svt_config_object_db#(CFG_TYPE)::get(this, "", "cfg", cfg) && (cfg != null)) begin \
        /* If we got it from the config_db, then make a copy of it for use with the internally generated objects */ \
        if(!($cast(this.cfg, cfg.clone()))) begin \
          `svt_fatal(method_name, $sformatf("Failed when attempting to cast '%0s'", `SVT_DATA_UTIL_ARG_TO_STRING(CFG_TYPE))); \
        end \
      end else begin \
        `svt_fatal(method_name, $sformatf("'cfg' is null. An '%0s' object or derivative object must be set using the configuration infrastructure or via reconfigure.", \
                                       `SVT_DATA_UTIL_ARG_TO_STRING(CFG_TYPE))); \
      end \
    end \
  end \
endfunction \
 \
function void ITEM``_sequencer::reconfigure(svt_configuration cfg); \
  if (!$cast(this.cfg, cfg)) begin \
    `svt_error("reconfigure", "Failed attempting to assign 'cfg' argument to sequencer 'cfg' field."); \
  end \
endfunction \
 \
function void ITEM``_sequencer::get_cfg(ref svt_configuration cfg); \
  cfg = this.cfg; \
endfunction

/**
 * Macro used to implement a sequencer for the supplied transaction.
 * This macro should be called from an encrypted portion of the extended file.
 */
`define SVT_SEQUENCER_IMP(ITEM, SUITE_NAME, CFG_TYPE) \
  `SVT_SEQUENCER_IMP_BASE(ITEM, `SVT_DATA_UTIL_ARG_TO_STRING(SUITE_NAME), CFG_TYPE)

// =============================================================================
/**
 * This report catcher is provided to intercept and filter out the following message,
 * which is generated by UVM/OVM whenever a sequencer generates a sequence item and
 * exits but there is a subsequent put of a 'response' for the sequence.
 *
 *   "Dropping response for sequence <seq_id>, sequence not found.  Probable cause: sequence
 *    exited or has been killed"
 *
 * This message has resulted in a great deal of confusion on the part of SVT users, so
 * by default this message is removed for all svt_sequencer instances. It can be re-enabled
 * simply by setting the static data field, svt_configuration::enable_dropping_response_message,
 * to '1'. This will enable the message across all svt_sequencer instances.
 */
class svt_dropping_response_report_catcher extends svt_report_catcher;

  function new(string name="svt_dropping_response_report_catcher");
    super.new(name);
  endfunction

  function action_e catch();
    if (!svt_configuration::enable_dropping_response_message) begin
`ifdef SVT_UVM_TECHNOLOGY
      // NOTE: In UVM wildcard is '.*' and match is negative...
      if (!uvm_re_match("Dropping response for sequence .*, sequence not found.  Probable cause: sequence exited or has been killed", get_message())) begin
`else
      // NOTE: In OVM wildcard is '*' and match is positive...
      if (ovm_is_match("Dropping response for sequence *, sequence not found.  Probable cause: sequence exited or has been killed", get_message())) begin
`endif
        set_action(`SVT_XVM_UC(NO_ACTION));
      end
    end

    return THROW;
  endfunction

endclass: svt_dropping_response_report_catcher

// =============================================================================
/**
 * Base class for all SVT model sequencers. As functionality commonly needed for
 * sequencers for SVT models is defined, it will be implemented (or at least
 * prototyped) in this class.
 */
virtual class svt_sequencer #(type REQ=`SVT_XVM(sequence_item),
                              type RSP=REQ) extends `SVT_XVM(sequencer)#(REQ, RSP);

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  /**
   * A flag that enables automatic objection management.  If this is set to 1 in
   * an extended sequencer class then an objection will be raised when the
   * Run phase is started and dropped when the Run phase is ended.
   * It can be set explicitly or via a bit-type configuration entry on the
   * sequencer named "manage_objection".
   *
   * If the VIP or testbench provides an override value of '0' then this setting
   * will also be propagated to the contained svt_sequence sequences via the
   * configuration.
   */
  bit manage_objection = 1;

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
   
  /** UVM/OVM report catcher used to filter the 'Dropping response...sequence not found' message. */
  static protected svt_dropping_response_report_catcher dropping_response_catcher;

//svt_vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
DCerKH4ZNA29wYy/am2H3jMUwD5ofH5t9Hh82mu6MfCGfrB3KljU1az9WyL2AOV2
79PMTKfSPxeJNUvotTrCuyi5NNSvgII1gYM3RoBnxBZI6C1Ea+9bu4gIWkY0r4wt
BR5nc6cQbfe4VkC4sQkdraz/MVDGn7SYGQOGKXnHwfs=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 606       )
wh5PEXue/X15w9RulE5sQdm5oJWpdZy1PuAHFZbAKizSoUXwXouHS8J0fpda2M/+
lrXMbcXw8G5gTYQgi4a9lkk4jFJBxt7OPfqIIeBq64QoPOzEXUMWhNOMSILmRiRf
go5okH48Y8rBLufRcb49Nxu77FI1t6fC7zBp/v2RE4wB8tnA725invDBmQu2HGTu
r8pU81AsKSSMWoRd3bW4DU1klXtsy+pol65wcJsgkGK1zeDZNiXQpvSyf5b9LHda
cwkEEnhC1Jw23yod4RWor3fE3oNDhyxE/jfnrgE201ia9sVX1t+Rb+uuwnZUbp6c
zPve59ukBIL15S7Oy3kSDD/B/lCs4ur58k3se1cwkRRYfWewf7N3UFoVlWhJR1HF
YnBD7sAsxfNIzlklhaIIrn4QPFgpgIBgZIRSiG7F1PE/LZi0Q0kirNY+I92fnBOR
t5NEFcpRzBnSdJv1/qB/RihXYUbLx1l0Sk6uSJQzi/Z+Lhaj0lC65eCYwT79OUoQ
xWJLORmG/0XzDnosJxceEAniSJ3ZkhDDzL0xTOTQx3p922nKamSpsdvRCkpWkSw2
4SHaRawxCdQEfU2dYUbwalLpuHIf8oEoAFRa/VQ8LQBrEEKRurS+0FAUHazg+XCv
7i76Ukuijt1rzSIDDGsxI0mC++3/Zj4QB7bes5z+vDEzZwiLWKZUjp66Wi2shQ7g
jxu40ZeLvI/D27LuytJ/f/zT1QiEcCu+Q7gMBC2bEWtKE4wCmv4vrE8ENLURCtkN
YAO3APGxIYhrV40bWnOLBGwHjCnn0iPiFW5NnF9regA=
`pragma protect end_protected

`pragma protect begin_protected  
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
IA0C1CkwEsdVAfyT5ehi5JedTLNETJhENZQnqxBc0K3oRsmfY05SudbS8lZ6KxLJ
ZY123mgKvoBvt5kS9RuECXoE2NNRTn+yUDb9NERZqWGG85YAeQF1LbsQXA7GNz29
OZoMMgQ1UiDkemh/uwyd4BeMdpNvKFi2OwWq0iSDlks=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 788       )
gQAqGJ9ZZ2Yd9FXQb8BUMF3W6E55Brjo36kmvd0PfGKATRNGdUXRe4WGm95/1pBC
sPYy4pDBsdJPLkYbGsWeCtfBD3o+Uvq24/HRnj54jCJi5k86byZnv8rRrVSlr7q0
BVLiUghIMYvx4V7+tg5rDo/48M2zxOxfqPIXT8kfLKNcu4y05WGmH7Xbm+dMiXsm
G1qAXjRC7r4en4wl/Y5sB5/xrDJGo3brSoCa3XPtlJOrU+/xnrZ3aXpJ2hsuudmO
`pragma protect end_protected

//svt_vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
b5MWH233HpFTAgzuVUkNsUMTBpmv6s0NfCC1e3Jt3qY4y/NGCYj1cCNl54zEjKpN
b2VZUAtm8vGQN2UyY42dgq3JjQQK82lqxvaraYaIMRFf7Tb87cv+J9k5Zf+M9ZxI
T+uLkUFBoDRZNHBKgRq8PnTgLHnj9vuRNm+qV9+zkY4=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1211      )
dsRYPEH6+IiS8bVY10dGeVubDTC4186X3/Wy8e9hrGXpTw0dG3RsYcHaLOMWeG7g
B/0Hmp9WdNFsJ2kBfOlZuwvlpGp7s3UhYEJv8BTzM15ZOC+VOhHy5oj23szTUf4c
UhhoxYKL5fhuOMN4w04rSpZZQR9H26rUmerMgZNqmi2Ko8X9wpP9ijA3v2xRec/R
AUrj6TYa32HM71GPl4eF2yplBGjqh3NWGztA9gVJMTfXZdh1/flsgF+6n1/V73mL
0gM6eS5buUlw5cnDnfAkr70q8m3hFXHd/FfKEa+5bRLjzSJniSQue4rNhf9kozKr
+H5I6YZkjPlqnk1aqm0YjknjFfJrlc3qA2DfVmsfL3BJGCM/UXjssTJlNN1kL5Cz
0Ul2ueqIoP+QXOcDSjL7GJIIufaTvgytkRuRYyPt9kt8+AwFqi+jKdVM9GgGdQBZ
U3lfYTdNxzvIwERjQyW+hwQpc6ZWw5jfrIFti6DUC8rUuK47c+YJaY5RUcnIVCyl
tgO5InrZN4k7KBvJ+BegEA3okUzENLarj3y/soNSa7rCVxf2rej/uSuhhLQG2Wf1
`pragma protect end_protected

  /** Class name of the transaction that this channel is customized with */
  local string xact_type;

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new sequencer instance, passing the appropriate argument
   * values to the `SVT_XVM(sequencer) parent class.
   *
   * @param name Instance name
   * 
   * @param parent Handle to the hierarchical parent
   * 
   * @param suite_name Identifies the product suite to which the sequencer object belongs.
   */
  extern function new(string name, `SVT_XVM(component) parent, string suite_name = "");

  // ---------------------------------------------------------------------------
  /** Build phase */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual function void build_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern virtual function void build();
`endif

  // ---------------------------------------------------------------------------
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

//svt_vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
caXBavyxq5UWYHLTAzCV+iNZIAxE1nN52I/J2EOfheRq+zgrI/6A9OeZ5yntqg/L
cPMtu7z6syr5AiMzLN8GqanFubaKoAnDjh72jhy5Cp32M7eVD5KfRPhJ+zB0HUMR
A72GeoNTTFHHPBHFxrb60QLS+DdSYid7EDaBOd96u5g=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1614      )
nn/x0JuPn1ffWGnykT0PLYi87/Lbt5vlvRXZXigPfKopbfQV84WHT40Pn6KxA75q
2dDFxIo29wlxb5qvnogtSqi1p2waryKJSc/MSsM+hvIzai1QS1kwhLWn32MfLv+G
7UXbQJfZVINQFS2fqAUHXAMFMYyB4JIscmQM4B76Q/0hPFX0ASqkU5pZFbfPRiFN
gNB/vxjWpL4K7GA+706XN4fq4KO7fiuP0egv9VfKw9w3scapPTQKRbQnBytPqCyO
HGPtI4g1gPCo1Dg026SoD0CdSnxKAY0aB96ZhYgdT9SFmKkdAGPZoJ6g8j+fhI7X
UtRNcH3pTXKRmd4qwrAvjiiPgFU/oBbVkyByjZ9bLM836j5vgRl/yspwtetdzPCS
FKP0J0GK3RZ60qzyzvPhmwOJ828TNl1wJ9MGT1sp/1afxnSgHCT8TMzBwGRZqQpE
feyO0gw3XlOXO10W09VRS9P+wNP9txwPij4nwuyooEOPHrcKkq5azIXx6J+wI8/U
rERL6dP9+8bXjooLyO+RXVe9kKjInmdgP5rEwUSoLf4=
`pragma protect end_protected

  // ---------------------------------------------------------------------------
  /** Returns the model suite name associated with an object. */
  extern virtual function string get_suite_name();

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
BYr4pZXoRD3ORtMdv/FMHmCnC5rLRLHCOiWk+L4up6mvA9xl4zVx5fcBe+LbKQ1P
CUInQ1uvhO279eQu/qZ42oN0omeYzO5PlWpiZRexyUj5BHWxjWohwBTXUoLyrfuV
d+MaXUKgRO2ZL4VnFKxSmUSj9h+l0LhHNDgQLQ+q2l0=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1982      )
/kXaIA8rpfg5KmmEov1XTpIs61fFSUFgXda/3C0D/4O4kv3OJhlvtQTpLcQVVuLc
szKshdmy2liLoIRXbk+1V57Onhr7O64WBdaPfmB/7mgPzDb2jvHtKtJwwPW/9SWH
+42pi4VqK5X1MIevlwH3ItZOLREbIkUIQBYtMmQl3sQhevtram2mMHmZSoztabTe
EyLKu1njvxdPGG0ndUNe3pjew086pEQP8JIq6Rtj0zN1EWvdrWxbIN8g7loQ0607
RUMEs0Xr4e1JcCQVpHaClcrYdr+ICjc4gM6/3AtGTKazN7RtA1vyiYRgppVeGo1o
NvQ1XOi1uh7IdfsJ7yuWqWuvsC17IBSmhB6flHGrKjH5b8KWB0AJBgmNwz4FJjTz
i7IAAfMPWcvjgalQ3ceqv+q3U00DDpdeCZUswV0hDxSjuUHnELm+McxwBCDr4KQE
arlv8tNShMbjtPWpIVnYdWXbRITsQvlbRpuBZJS1tq3qEmlf6BXJSx934O7TWSq9
`pragma protect end_protected
  
  //----------------------------------------------------------------------------
  /**
   * Updates the sequencer's configuration with data from the supplied object.
   * This method always results in a call to change_dynamic_cfg(). If the sequencer
   * has not been started calling this method also results in a call to
   * change_static_cfg().
   */
  extern virtual function void reconfigure(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Returns a reference of the sequencer's configuration object.
   * NOTE:
   * This operation is different than the get_cfg() methods for svt_driver and
   * svt_monitor classes.  This method returns a reference to the configuration
   * rather than a copy.
   */
  extern virtual function void get_cfg(ref svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Copies (deep) the <i>static</i> configuration properties from the argument
   * into the configuration object stored in the sequencer. Used internally
   * by reconfigure; not to be called directly.
   */
  extern virtual protected function void change_static_cfg(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Copies (deep) the <i>dynamic</i> configuration properties from the argument
   * into the configuration object stored in the sequencer. Used internally
   * by reconfigure; not to be called directly.
   */
  extern virtual protected function void change_dynamic_cfg(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Copies (deep) the <i>static</i> configuration properties from the configuration
   * object stored in the agent into the argument. If cfg is null,
   * creates config object of appropriate type. Used internally by get_cfg;
   * not to be called directly.
   */
  virtual protected function void get_static_cfg(ref svt_configuration cfg);
`ifdef SVT_MULTI_SIM_EMPTY_METHOD_FLAGGED_AS_UNIMP
    int dummy = 0;
`endif
  endfunction

  //----------------------------------------------------------------------------
  /**
   * Copies (deep) the <i>dynamic</i> configuration properties from the configuration
   * object stored in the agent into the argument. If cfg is null,
   * creates configuration object of appropriate type. Used internally by get_cfg;
   * not to be called directly.
   */
  virtual protected function void get_dynamic_cfg(ref svt_configuration cfg);
`ifdef SVT_MULTI_SIM_EMPTY_METHOD_FLAGGED_AS_UNIMP
    int dummy = 0;
`endif
  endfunction

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

  //----------------------------------------------------------------------------
  /**
   * Finds the first sequencer that has a `SVT_XVM(agent) for its parent.
   * If p_sequencer parent is a `SVT_XVM(agent), returns that `SVT_XVM(agent). Otherwise
   * continues looking up the sequence's parent sequence chain looking for a
   * p_sequencer which has a `SVT_XVM(agent) as its parent.
   * @param seq The sequence that needs to find its agent.
   * @return The first agent found by looking through the parent sequence chain.
   */
  extern virtual function `SVT_XVM(agent) find_first_agent(`SVT_XVM(sequence_item) seq);

  //----------------------------------------------------------------------------
  /**
   * Implementation of port method declared in the `SVT_XVM(seq_item_pull_imp) class.
   * This method is extended in order to write sequence items to FSDB.
   * 
   * @param t Sequence item supplied by this sequencer
   */
  extern virtual task get_next_item (output REQ t);

  //----------------------------------------------------------------------------
  /**
   * Function looks up whether debug is enabled for this component. This mainly acts
   * as a front for svt_debug_opts, caching and reusing the information after the first
   * lookup.
   */
  extern virtual function bit get_is_debug_enabled();

endclass

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
PDNjYEprkw+mnlMVG9TXPw8HAy9G27fZ2OtezykVvGnHIejVdjwVPpuQNGOEaAGN
IcU4oON1bl7BYYXd+Sqa/7EMWCY20dIWe4RnjeZKZ9wdhUpzhlLMOTpvxrAooC1l
qu6YLAJs6cXQBQuwlhAq91ecuE9fODKuN7L5PT/rTcA=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 11916     )
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
BzhFxE/XDD+X0IIZpDyFuDJzncJ9vi9I1j1YVBz7BIttKSHuVYmedT3M4jsLluGd
Wf8rQr7qWTXBzswk3IpPr96U+w+Ma7e1KskaEf0qfBGgtaitkFtJLhAor+tZk7Nj
hq/RVSUHxeQ3/hNzrum/sogRb75QrWZe9oiuJPptq5IpRmoBX/1RDiNyP9FuDajX
eg30iiJjLnTXF1VV+xE2Bnb4i4fcLxZ9tWXxKO8Nk6hIGwUs+412i1rbd2/EQIJ3
fIqReoxaW7fqVuTFGXqEjXG1iHZvWTKu14IAx4DIoX+JxpZodI3OjnTGNDq4N8Fi
QkcaVRnsTVLI20Fg/unBeI7pWj2cCZ/S8MjRVQm0gh8E1tt6Q/MBeF+so2DP2l2T
nI5NHZia1Nm3So6ubX8vrFjK5BkUOF8c7O5ez6ow4GEg/Kb3PRDr6xAam8jIJZ73
AschUk30qOPdWxDLxS3yoditWRdcuEed31UzqdtburAqcQXXH3cXa5j/+ifIu1Z5
ny9dvIbylP+5NKg5MCkY3TuBBkh5NdiAnxjnuZUzuy3NtqCHJOTfkizH+y5vFjRi
5oa+OvzqITCRlh/pccnJxMbWXJ+yYOp+Bjz2Go1BAi+pzudN/5LLKLZXAZ62Fdnc
Q/ImakKw4ZaT1hH0usd8jOBA1V1CYxuCKzJkBDIfzM69GL9W9w+cvQTMxfvTSXka
awlXF+Eh2/UigsvgvOCmbHX+2lStW/mGDI0Tay8nSwXJn5ey4mnOysPSs8kO1sDF
a/N2ubZndCoOslqBlhZlfvdEk6T1QdGCE2POFow7T7V6vw6ttJEcKmfcjQ8m7pp5
jkOmlfp9nLBGyyniRSF0fN51WLhbtIzaB4sgeCbi/izJEy4JCB8igMzqygln2fEU
XxOREC5oyiXJnoiiE+yX5UcgIi8uyLejHG3LMOJEITWENW0HGBgd9xbHVkMkGZwN
Hr40dmD9CP6zqhuQJW/e2zPPAjYK0UAqRvgzjGpAuqT6vLxXZ6/1peNqnzbmWSli
Bv9IwOwzY5i9ndlADyoOfeYKdb3k/62u7f/0vV5fjIdTp0aahzesb7YHc4Gl9As3
Jf8VTfO8KlQSldVEa1V3LmllX1Rm2pEBcWXAsvxVl1d1zJCVE/Q9nLl1n1Mi4w56
ZfJJ6kn2hMN3VtBR2ZDisepDtZ2ILKOK3yNNKDqt8SIrMcnOMXMcYUNrSaMEprPa
FRbPOj539cQI7RX27Jyd1MeT0uHiRZLu5zoPmEHSS7GEvjnN8GNroYyMPWjxSoDJ
yZ2eu/jZB0+6baEvUgMnpWGYTEBK15guofl/7agognPYPauzV3FlzVRtUtejbaQ8
sc41jQwktdYI9R0Whbb10y3zHOuxfWG5sMA9S5ChVhw1VyYv7lScNVRVgC+BFCAV
CqfOoVN0jxr94WMP2+yeeps3dN3zZDI6NRYn9t/hC2VxlHsYNbr34ttE7g/onCoz
XBWLaXSS09DDUMETkJuwXJEKyfgYJQbWPZp/3irGXejbM+Qx5xN0ZxCiFSaMn7R5
43H20gsnUlHlg5fNq9uDWhw/iZgODwsIhSpQe2vwV0xFDPSGtiaIsfQH0e0ekPAy
r94a+jhB9y3ZyWH3dgYVpiMHTy6qmFFsXGWFCMCP7FWPjmyzRU3vxjLU/nyv7xPQ
fTG4hH8T6y3UA3Pdq2EjA6NWBDZl1znjbE/nSo28x1beuptf+uy9Ah8jCYkKVfMx
UnFNZ7ihlhz+axN7bLbR6/Q/iyoJr/pLxEAfWsUG/AKq2CVAf6a+sv92v8Wfhng8
DBRMKakjQE0cXjMvMo/hznAK04S8R1mM97dER5oJQTlmxDKg5rISE3ynjAmR8d9z
gUFaiBF5EBO2QyNApwtLME21ONeC0vgZAQrk2vBUkoBSM7Ij+kaTTy9LEhLWXlDB
CNkP3ZGn5+NxV4C1KZ5IlZBfQxaEsaA4QJ/G5wd4CFVZ/5sWkul12onL8RrdH7Ll
eCUhaqV9dzx1NXD8c87HygMZtTujYuKKovn1baRCc1u2BQDRZ+LY8KGluMjauLvG
aQOdZJn+wa2W6XjeOTlReMZdSNEpFIRWYQTfQsLW3XVs2tG01dcnUtLxWAptTpGw
gQedfEgSZ/bvW7HDFJ8ghmlBAm/uJrurQy0SXgs6TTX4MWaFkLQfKNMXEzHcyvVy
LjagZQuTNdo+tvPOfyXSz8vny2PUL+pEDX1m0fP3uZgmdxc29xAzJuvHtJbCg7jM
LQfdLvyvOo0FSwklyYaJIGIwikK8F0eHSJOeBw4Fu44T4XB09oaM2nu8xc4I282O
`pragma protect end_protected

//svt_vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
V3KtgUccRkHgcu0oEOlLV96LlP5/JyLXd46XtIq3elqk9bGArIfbTBqNeGSocyni
ADTRxfUeT0slm06l8UaL+aGu9Eg2htXamXYj5+5CKJtO8DVavlW58abU4q2NR1mk
zPL0xlJRs+q/wb/ylmVZZY4XA4sDxnuhSaCP1Z7MqT8=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 16427     )
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
`pragma protect end_protected

`endif // GUARD_SVT_SEQUENCER_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Q6U8yWOhiHNy2pFxJthExZB/8fj0qIrwYIwR8p/uQJF4SJ7upKbUyN3KpH56+TYu
CPO2mF7yD9QFwJ/orpReBz3H1HM0YJt9ev7QYIDohTA+sLxe1pM0eazFCdaOWoNY
37XU8Vu5CkuZBpml7YfOj+4SDWQMgXgcbmiDghLc03E=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 16510     )
7gzvBnAk/mCuZGj/HMIVPCUn10IqkbdKkOtbtpnhhd4Laq0v7jEvt8+/TdHg6JRC
EtA0f1MA30NDZ274kt2xEPwDzZOsMEwvkbQHHKPBQzufrg9TgqDxzUOJ4/aDdnEa
`pragma protect end_protected
